import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../authentication/cubit/authentication_state.dart';
import '../../domain/entities/group_entities.dart';

/// Per-contribution chat bottom sheet (90% screen height).
///
/// Renders the message timeline + composer (text, voice note, image) for
/// a single contribution. Members can collaborate inline without leaving
/// the contribution context. The composer surfaces three input modes:
///
///   * Text — primary input, send-on-Enter or send button.
///   * Voice — long-press the mic to record, lift to send.
///   * Image — tap the photo button to pick from gallery.
///
/// Wiring contract (current state — local-only):
///
/// The UI here is fully laid out and interaction-complete. Sending a
/// message appends it to an in-memory list so the operator can validate
/// the UX. The messaging BACKEND (per-contribution messages table,
/// media upload, real-time fanout via WebSocket) is a separate sprint
/// — see task #92. When that lands, the `_send*` functions in this
/// file are the integration points: each currently mutates `_messages`
/// directly; rewire them to call a `ContributionChatRepository`.
class ContributionChatBottomSheet extends StatefulWidget {
  final Contribution contribution;
  final String currentUserId;
  final String currentUserName;

  const ContributionChatBottomSheet({
    super.key,
    required this.contribution,
    required this.currentUserId,
    required this.currentUserName,
  });

  /// Convenience: open as a modal bottom sheet at 90% screen height.
  static Future<void> show(
    BuildContext context, {
    required Contribution contribution,
    required String currentUserId,
    required String currentUserName,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      // Local navigator so dismissing the sheet stays scoped to this
      // contribution screen and never escapes to onboarding.
      useRootNavigator: false,
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.9,
        child: ContributionChatBottomSheet(
          contribution: contribution,
          currentUserId: currentUserId,
          currentUserName: currentUserName,
        ),
      ),
    );
  }

  @override
  State<ContributionChatBottomSheet> createState() =>
      _ContributionChatBottomSheetState();
}

class _ContributionChatBottomSheetState
    extends State<ContributionChatBottomSheet> {
  // Real backend integration. Two bases because chat splits across
  // services:
  //
  //   _financialBase (8016) — financial-gateway, proxies gRPC for
  //       message send + list. Same path the rest of the contribution
  //       flow takes.
  //   _mediaBase     (8011) — group-accounts HTTP server. Hosts the
  //       multipart upload endpoint (gRPC isn't a great fit for
  //       multipart uploads) and serves local-FS files in dev. In
  //       prod, uploads still go through this base; the upload
  //       response carries an absolute CDN URL pointing at GCS.
  //
  // Both addresses use 10.0.2.2 (the Android emulator's host alias)
  // to reach the developer's laptop.
  static const String _financialBase = 'http://10.0.2.2:8016';
  static const String _mediaBase = 'http://10.0.2.2:8011';

  final List<_ChatMessage> _messages = [];
  final TextEditingController _composer = TextEditingController();
  final ScrollController _scroll = ScrollController();
  Timer? _pollTimer;
  String? _sinceCursor; // RFC3339 of latest received message
  bool _initialLoading = true;
  String? _error;
  bool _sending = false;

  @override
  void initState() {
    super.initState();
    _composer.addListener(() => setState(() {}));
    _initialFetch();
    // Polling keeps the timeline live without a WebSocket. 5s is a
    // sane balance: snappy enough for casual chat, light enough on
    // the gateway. Switch to WS later by replacing the timer with
    // a stream subscription.
    _pollTimer = Timer.periodic(const Duration(seconds: 5), (_) => _pollDelta());
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _composer.dispose();
    _scroll.dispose();
    // Stop any in-flight recording so the file handle is released
    // even if the user dismisses the sheet mid-record.
    if (_recording && _recorder != null) {
      _recorder!.stop().catchError((_) => null);
    }
    _recorder?.dispose();
    super.dispose();
  }

  String? _authToken() {
    final state = context.read<AuthenticationCubit>().state;
    if (state is AuthenticationSuccess) {
      return state.profile.session.accessToken;
    }
    return null;
  }

  Future<void> _initialFetch() async {
    try {
      final msgs = await _fetchMessages(since: null);
      if (!mounted) return;
      setState(() {
        _messages
          ..clear()
          ..addAll(msgs);
        if (msgs.isNotEmpty) {
          _sinceCursor = msgs.last.sentAt.toUtc().toIso8601String();
        }
        _initialLoading = false;
      });
      _autoscroll();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = '$e';
        _initialLoading = false;
      });
    }
  }

  Future<void> _pollDelta() async {
    if (!mounted) return;
    try {
      final msgs = await _fetchMessages(since: _sinceCursor);
      if (!mounted || msgs.isEmpty) return;
      setState(() {
        _messages.addAll(msgs);
        _sinceCursor = msgs.last.sentAt.toUtc().toIso8601String();
      });
      _autoscroll();
    } catch (_) {
      // Polling errors are silent — the next tick retries.
    }
  }

  Future<List<_ChatMessage>> _fetchMessages({String? since}) async {
    final token = _authToken();
    if (token == null) {
      throw 'Not authenticated';
    }
    var path =
        '/v1/contributions/${widget.contribution.id}/messages?limit=100';
    if (since != null && since.isNotEmpty) {
      path += '&sinceRfc3339=${Uri.encodeQueryComponent(since)}';
    }
    final resp = await http.get(
      Uri.parse('$_financialBase$path'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (resp.statusCode < 200 || resp.statusCode >= 300) {
      throw 'List failed (${resp.statusCode})';
    }
    final body = jsonDecode(resp.body) as Map<String, dynamic>;
    final list = (body['messages'] as List?) ?? const [];
    return list
        .map((m) => _ChatMessage.fromJson(m as Map<String, dynamic>))
        .toList();
  }

  Future<void> _sendText() async {
    final text = _composer.text.trim();
    if (text.isEmpty || _sending) return;
    final token = _authToken();
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Not authenticated')),
      );
      return;
    }
    setState(() => _sending = true);
    try {
      final resp = await http.post(
        Uri.parse(
            '$_financialBase/v1/contributions/${widget.contribution.id}/messages'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'contributionId': widget.contribution.id,
          'kind': 'text',
          'body': text,
        }),
      );
      if (resp.statusCode < 200 || resp.statusCode >= 300) {
        throw 'Send failed (${resp.statusCode}): ${resp.body}';
      }
      final body = jsonDecode(resp.body) as Map<String, dynamic>;
      final msg = _ChatMessage.fromJson(body['message'] as Map<String, dynamic>);
      if (!mounted) return;
      setState(() {
        _messages.add(msg);
        _sinceCursor = msg.sentAt.toUtc().toIso8601String();
        _composer.clear();
        _sending = false;
      });
      _autoscroll();
    } catch (e) {
      if (!mounted) return;
      setState(() => _sending = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not send: $e')),
      );
    }
  }

  // ---------- Media: shared upload helper ----------

  /// POSTs the file as multipart/form-data to the group-accounts
  /// /messages/media endpoint. Returns the server-issued media URL
  /// (relative `/media/...` in dev, absolute CDN URL in prod). On
  /// failure throws a string for the caller to surface.
  Future<({String url, int durationMs})> _uploadMedia({
    required File file,
    required String kind,
    int? durationMs,
  }) async {
    final token = _authToken();
    if (token == null) throw 'Not authenticated';

    final uri = Uri.parse(
        '$_mediaBase/v1/contributions/${widget.contribution.id}/messages/media');
    final req = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['kind'] = kind
      ..files.add(await http.MultipartFile.fromPath('file', file.path));
    if (durationMs != null && durationMs > 0) {
      req.fields['durationMs'] = durationMs.toString();
    }
    final streamed = await req.send();
    final body = await streamed.stream.bytesToString();
    if (streamed.statusCode < 200 || streamed.statusCode >= 300) {
      throw 'Upload failed (${streamed.statusCode}): $body';
    }
    final json = jsonDecode(body) as Map<String, dynamic>;
    final url = (json['media_url'] ?? '') as String;
    final dms = (json['duration_ms'] is int)
        ? json['duration_ms'] as int
        : int.tryParse('${json['duration_ms'] ?? 0}') ?? 0;
    if (url.isEmpty) throw 'Server returned empty media_url';
    return (url: url, durationMs: dms);
  }

  /// Resolves a relative media URL (`/media/...`) against the
  /// media-serving base. Absolute URLs (prod CDN) are returned
  /// as-is so the same code works in dev + prod.
  String _resolveMediaUrl(String url) {
    if (url.startsWith('http://') || url.startsWith('https://')) return url;
    return '$_mediaBase$url';
  }

  // ---------- Image send ----------

  Future<void> _sendImage() async {
    if (_sending) return;
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80, // re-encode to keep upload small
        maxWidth: 1600,
      );
      if (picked == null) return;
      setState(() => _sending = true);
      final uploaded = await _uploadMedia(
        file: File(picked.path),
        kind: 'image',
      );
      // Now persist the message with the returned URL.
      await _sendMessageWithKind(
        kind: 'image',
        body: '',
        mediaUrl: uploaded.url,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image send failed: $e')),
      );
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  // ---------- Voice send (record on long-press) ----------

  AudioRecorder? _recorder;
  String? _recordingPath;
  DateTime? _recordingStart;
  bool _recording = false;

  Future<void> _startRecording() async {
    if (_recording) return;
    try {
      _recorder ??= AudioRecorder();
      if (!await _recorder!.hasPermission()) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Microphone permission denied')),
        );
        return;
      }
      final dir = await getTemporaryDirectory();
      _recordingPath =
          '${dir.path}/voice-${DateTime.now().millisecondsSinceEpoch}.m4a';
      await _recorder!.start(
        const RecordConfig(encoder: AudioEncoder.aacLc, bitRate: 64000, sampleRate: 22050),
        path: _recordingPath!,
      );
      setState(() {
        _recording = true;
        _recordingStart = DateTime.now();
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not start recording: $e')),
        );
      }
    }
  }

  Future<void> _stopAndSendRecording() async {
    if (!_recording || _recorder == null) return;
    setState(() => _recording = false);
    String? path;
    try {
      path = await _recorder!.stop();
    } catch (_) {
      path = _recordingPath;
    }
    if (path == null) return;
    final ms =
        DateTime.now().difference(_recordingStart ?? DateTime.now()).inMilliseconds;
    if (ms < 500) {
      // Drop ultra-short accidental taps.
      try {
        await File(path).delete();
      } catch (_) {}
      return;
    }
    try {
      setState(() => _sending = true);
      final uploaded =
          await _uploadMedia(file: File(path), kind: 'voice', durationMs: ms);
      await _sendMessageWithKind(
        kind: 'voice',
        body: '',
        mediaUrl: uploaded.url,
        durationMs: uploaded.durationMs > 0 ? uploaded.durationMs : ms,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Voice send failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _sending = false);
      try {
        await File(path).delete();
      } catch (_) {}
    }
  }

  Future<void> _cancelRecording() async {
    if (!_recording || _recorder == null) return;
    setState(() => _recording = false);
    try {
      final path = await _recorder!.stop();
      if (path != null) {
        try {
          await File(path).delete();
        } catch (_) {}
      }
    } catch (_) {}
  }

  // ---------- Message-send helper (used by image + voice) ----------

  Future<void> _sendMessageWithKind({
    required String kind,
    required String body,
    String mediaUrl = '',
    int? durationMs,
  }) async {
    final token = _authToken();
    if (token == null) throw 'Not authenticated';
    final resp = await http.post(
      Uri.parse(
          '$_financialBase/v1/contributions/${widget.contribution.id}/messages'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'contributionId': widget.contribution.id,
        'kind': kind,
        'body': body,
        if (mediaUrl.isNotEmpty) 'mediaUrl': mediaUrl,
        if (durationMs != null && durationMs > 0) 'durationMs': durationMs,
      }),
    );
    if (resp.statusCode < 200 || resp.statusCode >= 300) {
      throw 'Send failed (${resp.statusCode}): ${resp.body}';
    }
    final data = jsonDecode(resp.body) as Map<String, dynamic>;
    final msg = _ChatMessage.fromJson(data['message'] as Map<String, dynamic>);
    if (!mounted) return;
    setState(() {
      _messages.add(msg);
      _sinceCursor = msg.sentAt.toUtc().toIso8601String();
    });
    _autoscroll();
  }

  void _autoscroll() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          const Divider(color: Color(0xFF2D2D2D), height: 1),
          Expanded(child: _buildMessageList()),
          _buildComposer(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final memberCount = widget.contribution.members.length;
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 12.w, 8.h),
      child: Column(
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.contribution.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '$memberCount member${memberCount == 1 ? '' : 's'}',
                      style: GoogleFonts.inter(
                        color: Colors.grey[500],
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: Icon(Icons.close, color: Colors.grey[400], size: 20.sp),
                tooltip: 'Close',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    if (_initialLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF6366F1)),
      );
    }
    if (_error != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline,
                  color: const Color(0xFFEF4444), size: 28.sp),
              SizedBox(height: 12.h),
              Text(
                'Could not load chat',
                style: GoogleFonts.inter(
                  color: Colors.grey[300],
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: Colors.grey[500],
                  fontSize: 11.sp,
                ),
              ),
              SizedBox(height: 12.h),
              TextButton(
                onPressed: () {
                  setState(() {
                    _error = null;
                    _initialLoading = true;
                  });
                  _initialFetch();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }
    if (_messages.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.chat_bubble_outline,
                  color: Colors.grey[700], size: 36.sp),
              SizedBox(height: 12.h),
              Text(
                'No messages yet',
                style: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'Start the conversation. Members can chat here.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: Colors.grey[600],
                  fontSize: 11.sp,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return ListView.builder(
      controller: _scroll,
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
      itemCount: _messages.length,
      itemBuilder: (_, i) => _buildBubble(_messages[i]),
    );
  }

  Widget _buildBubble(_ChatMessage m) {
    final isMe = m.senderId == widget.currentUserId;
    final bubbleColor = isMe ? const Color(0xFF6366F1) : const Color(0xFF2D2D2D);
    final textColor = Colors.white;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 280.w),
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (!isMe) ...[
              Text(
                m.senderName,
                style: GoogleFonts.inter(
                  color: Colors.grey[300],
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 3.h),
            ],
            _buildMessageContent(m, textColor),
            SizedBox(height: 3.h),
            Text(
              _formatTime(m.sentAt),
              style: GoogleFonts.inter(
                color: textColor.withValues(alpha: 0.6),
                fontSize: 9.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageContent(_ChatMessage m, Color textColor) {
    switch (m.kind) {
      case _MessageKind.text:
        return Text(
          m.body ?? '',
          style: GoogleFonts.inter(color: textColor, fontSize: 13.sp),
        );
      case _MessageKind.voice:
        if (m.mediaUrl == null || m.mediaUrl!.isEmpty) {
          return Text(
            'Voice note (unavailable)',
            style: GoogleFonts.inter(color: textColor, fontSize: 11.sp),
          );
        }
        return _VoiceBubble(
          url: _resolveMediaUrl(m.mediaUrl!),
          durationSeconds: m.durationSeconds,
          accent: textColor,
        );
      case _MessageKind.image:
        if (m.mediaUrl == null || m.mediaUrl!.isEmpty) {
          return Container(
            width: 180.w,
            height: 120.h,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Icon(Icons.broken_image, color: textColor, size: 32.sp),
            ),
          );
        }
        final resolved = _resolveMediaUrl(m.mediaUrl!);
        return GestureDetector(
          onTap: () => _showImageFullScreen(resolved),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: CachedNetworkImage(
              imageUrl: resolved,
              width: 220.w,
              fit: BoxFit.cover,
              httpHeaders: _authHeaders(),
              placeholder: (_, __) => Container(
                width: 220.w,
                height: 140.h,
                color: Colors.black.withValues(alpha: 0.2),
                child: const Center(
                  child:
                      CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                ),
              ),
              errorWidget: (_, __, ___) => Container(
                width: 220.w,
                height: 140.h,
                color: Colors.black.withValues(alpha: 0.3),
                child: Icon(Icons.broken_image,
                    color: textColor, size: 32.sp),
              ),
            ),
          ),
        );
    }
  }

  Map<String, String> _authHeaders() {
    final t = _authToken();
    if (t == null) return const {};
    return {'Authorization': 'Bearer $t'};
  }

  void _showImageFullScreen(String url) {
    Navigator.of(context, rootNavigator: false).push(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,
          ),
          body: Center(
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 4,
              child: CachedNetworkImage(
                imageUrl: url,
                httpHeaders: _authHeaders(),
                fit: BoxFit.contain,
                placeholder: (_, __) => const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
                errorWidget: (_, __, ___) =>
                    const Icon(Icons.broken_image, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  Widget _buildComposer() {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_recording)
              Container(
                margin: EdgeInsets.only(bottom: 6.h),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.fiber_manual_record,
                        color: const Color(0xFFEF4444), size: 12.sp),
                    SizedBox(width: 6.w),
                    Text(
                      'Recording… release mic to send, swipe out to cancel',
                      style: GoogleFonts.inter(
                        color: Colors.grey[300],
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: _sending || _recording ? null : _sendImage,
                  icon: Icon(Icons.image_outlined,
                      color: Colors.grey[400], size: 22.sp),
                  tooltip: 'Send image',
                ),
                Expanded(
                  child: Container(
                    constraints:
                        BoxConstraints(minHeight: 40.h, maxHeight: 120.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A0A0A),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 14.w, vertical: 4.h),
                    child: TextField(
                      controller: _composer,
                      style: GoogleFonts.inter(
                          color: Colors.white, fontSize: 13.sp),
                      minLines: 1,
                      maxLines: 5,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendText(),
                      decoration: InputDecoration(
                        hintText: _recording ? 'Recording…' : 'Message',
                        hintStyle: GoogleFonts.inter(
                            color: Colors.grey[600], fontSize: 13.sp),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8.h),
                        isCollapsed: true,
                      ),
                      enabled: !_recording,
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                // Send button when there's text; long-press mic when empty.
                if (_composer.text.trim().isEmpty)
                  GestureDetector(
                    // Long-press starts recording, release stops + sends.
                    // Drag-up cancels (mirrors WhatsApp/Telegram UX).
                    onLongPressStart: (_) => _startRecording(),
                    onLongPressEnd: (_) => _stopAndSendRecording(),
                    onLongPressMoveUpdate: (details) {
                      // Cancel if user drags more than 60px upward
                      // (i.e. towards the message list).
                      if (details.localOffsetFromOrigin.dy < -60) {
                        _cancelRecording();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: _recording
                            ? const Color(0xFFEF4444).withValues(alpha: 0.2)
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.mic,
                        color: _recording
                            ? const Color(0xFFEF4444)
                            : Colors.grey[400],
                        size: 22.sp,
                      ),
                    ),
                  )
                else
                  IconButton(
                    onPressed: _sending ? null : _sendText,
                    icon: Icon(Icons.send,
                        color: const Color(0xFF6366F1), size: 22.sp),
                    tooltip: 'Send',
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatMessage {
  final String id;
  final String senderId;
  final String senderName;
  final String? body;
  final _MessageKind kind;
  final int? durationSeconds;
  final String? mediaUrl;
  final DateTime sentAt;

  const _ChatMessage({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.kind,
    required this.sentAt,
    this.body,
    this.durationSeconds,
    this.mediaUrl,
  });

  factory _ChatMessage.fromJson(Map<String, dynamic> j) {
    final kindStr = (j['kind'] ?? 'text') as String;
    _MessageKind k;
    switch (kindStr) {
      case 'voice':
        k = _MessageKind.voice;
        break;
      case 'image':
        k = _MessageKind.image;
        break;
      default:
        k = _MessageKind.text;
    }
    final createdAt = DateTime.tryParse((j['createdAt'] ?? '') as String) ??
        DateTime.now();
    final durMs = (j['durationMs'] is int)
        ? j['durationMs'] as int
        : int.tryParse('${j['durationMs'] ?? ''}') ?? 0;
    return _ChatMessage(
      id: (j['id'] ?? '') as String,
      senderId: (j['senderId'] ?? '') as String,
      senderName: (j['senderName'] ?? '') as String,
      kind: k,
      body: (j['body'] ?? '') as String,
      mediaUrl: (j['mediaUrl'] ?? '') as String,
      durationSeconds: durMs > 0 ? (durMs / 1000).round() : null,
      sentAt: createdAt,
    );
  }
}

enum _MessageKind { text, voice, image }

/// Voice-note bubble with play/pause + waveform-stub progress bar.
/// Uses just_audio for streaming playback. Each bubble owns its own
/// player so multiple notes can be paused/resumed independently;
/// memory cost is bounded because just_audio releases buffers when
/// the player is disposed.
class _VoiceBubble extends StatefulWidget {
  final String url;
  final int? durationSeconds;
  final Color accent;

  const _VoiceBubble({
    required this.url,
    required this.accent,
    this.durationSeconds,
  });

  @override
  State<_VoiceBubble> createState() => _VoiceBubbleState();
}

class _VoiceBubbleState extends State<_VoiceBubble> {
  AudioPlayer? _player;
  bool _ready = false;
  Duration _position = Duration.zero;
  Duration? _duration;

  Future<void> _ensurePlayer() async {
    if (_player != null) return;
    final p = AudioPlayer();
    _player = p;
    p.positionStream.listen((d) {
      if (mounted) setState(() => _position = d);
    });
    p.playerStateStream.listen((s) {
      if (s.processingState == ProcessingState.completed && mounted) {
        setState(() => _position = Duration.zero);
        p.pause();
        p.seek(Duration.zero);
      }
    });
    try {
      _duration = await p.setUrl(widget.url);
      if (mounted) setState(() => _ready = true);
    } catch (_) {
      if (mounted) setState(() => _ready = false);
    }
  }

  Future<void> _toggle() async {
    await _ensurePlayer();
    final p = _player;
    if (p == null) return;
    if (p.playing) {
      await p.pause();
    } else {
      await p.play();
    }
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _player?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final playing = _player?.playing ?? false;
    final totalSec = (_duration?.inMilliseconds ?? 0) > 0
        ? _duration!.inMilliseconds / 1000
        : (widget.durationSeconds ?? 0).toDouble();
    final pct = totalSec > 0
        ? (_position.inMilliseconds / 1000 / totalSec).clamp(0.0, 1.0)
        : 0.0;
    final remainingLabel = totalSec > 0
        ? '${(totalSec - _position.inMilliseconds / 1000).clamp(0, totalSec).toStringAsFixed(0)}s'
        : '${widget.durationSeconds ?? 0}s';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: _toggle,
          child: Icon(
            _player == null
                ? Icons.play_circle_outline
                : (playing ? Icons.pause_circle_filled : Icons.play_circle_filled),
            color: widget.accent,
            size: 22.sp,
          ),
        ),
        SizedBox(width: 8.w),
        SizedBox(
          width: 110.w,
          height: 4.h,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: widget.accent.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              FractionallySizedBox(
                widthFactor: pct,
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.accent,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          _ready ? remainingLabel : '${widget.durationSeconds ?? 0}s',
          style: GoogleFonts.inter(color: widget.accent, fontSize: 11.sp),
        ),
      ],
    );
  }
}
