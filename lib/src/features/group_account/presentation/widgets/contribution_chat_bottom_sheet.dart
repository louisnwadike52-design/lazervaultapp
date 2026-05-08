import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as ws_status;

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
  // Two bases because chat splits across services:
  //
  //   financialBase — financial-gateway, proxies gRPC for message
  //       send + list. Same path the rest of the contribution flow
  //       takes (port 8016 by default).
  //   mediaBase     — group-accounts HTTP server. Hosts the multipart
  //       upload endpoint (gRPC isn't a great fit for multipart) and
  //       serves local-FS files in dev (port 8011 by default). In
  //       prod the upload response carries an absolute CDN URL
  //       pointing at GCS, so the consumer doesn't need this base
  //       to read media back.
  //
  // Both bases are dotenv-driven with Android-emulator defaults so
  // the same build works for an iOS simulator (FINANCIAL_GATEWAY_HTTP=
  // http://localhost:8016), a real device (LAN IP), or a deployed
  // env (full https URLs). Falling back to 10.0.2.2 keeps the typical
  // ./start_all_local_no_docker.sh workflow zero-config.
  late final String _financialBase = _resolveBase(
      keys: const ['FINANCIAL_GATEWAY_HTTP', 'FINANCIAL_HTTP_URL'],
      fallback: 'http://10.0.2.2:8016');
  late final String _mediaBase = _resolveBase(
      keys: const ['GROUP_ACCOUNTS_HTTP', 'GROUP_ACCOUNTS_HTTP_URL'],
      fallback: 'http://10.0.2.2:8011');

  String _resolveBase({required List<String> keys, required String fallback}) {
    for (final k in keys) {
      final v = dotenv.maybeGet(k);
      if (v != null && v.trim().isNotEmpty) {
        return v.trim().replaceAll(RegExp(r'/$'), '');
      }
    }
    return fallback;
  }

  final List<_ChatMessage> _messages = [];
  // Pending bubbles for media that's still uploading. Keyed by a
  // synthesized client id so we can swap them for the real server-
  // issued message once the round-trip completes — gives users an
  // instant local preview instead of waiting for the next poll.
  final List<_PendingBubble> _pending = [];
  final TextEditingController _composer = TextEditingController();
  final ScrollController _scroll = ScrollController();
  String? _sinceCursor; // RFC3339 of latest received message
  bool _initialLoading = true;
  String? _error;
  bool _sending = false;
  // WebSocket state — the ONLY live channel for the timeline. On
  // disconnect we reconnect with exponential backoff and pull any
  // messages that arrived during the gap from the same `since`
  // cursor used for the initial fetch (so no message is lost).
  WebSocketChannel? _wsChannel;
  StreamSubscription<dynamic>? _wsSub;
  bool _hadFirstConnect = false;
  Timer? _wsReconnectTimer;
  int _wsBackoffMs = 1000;
  // Banner text shown above the composer when the last media op
  // failed. Distinct from _error which gates the whole timeline.
  String? _composerBanner;

  @override
  void initState() {
    super.initState();
    _composer.addListener(() => setState(() {}));
    // One-shot historical fetch so the timeline opens with the
    // backlog rendered, then hand off entirely to the WebSocket for
    // realtime updates. No more polling fallback — when the WS
    // reconnects after a drop, any missed messages get pulled via
    // _resyncOnReconnect with the existing cursor.
    _initialFetch();
    _connectWebSocket();
  }

  @override
  void dispose() {
    _wsReconnectTimer?.cancel();
    _wsSub?.cancel();
    _wsChannel?.sink.close(ws_status.normalClosure);
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

  /// Opens the WS channel scoped to this contribution. Backoff +
  /// retry on disconnect — the timeline always remains usable via
  /// the polling fallback even if WS is permanently unavailable.
  void _connectWebSocket() {
    if (!mounted) return;
    final token = _authToken();
    if (token == null) return;
    final base = _financialBase
        .replaceFirst(RegExp(r'^http://'), 'ws://')
        .replaceFirst(RegExp(r'^https://'), 'wss://');
    // Pass the user_id + auth as query params because Flutter's WS
    // client doesn't ship custom headers on the initial handshake on
    // every platform. The server reads X-User-Id from the auth
    // middleware, but the dev fallback (?user_id=) keeps local
    // testing straightforward.
    final uri = Uri.parse(
        '$base/ws/contributions/${widget.contribution.id}/messages'
        '?user_id=${Uri.encodeQueryComponent(widget.currentUserId)}'
        '&access_token=${Uri.encodeQueryComponent(token)}');
    try {
      final channel = WebSocketChannel.connect(uri);
      _wsChannel = channel;
      _wsSub = channel.stream.listen(
        _onWsFrame,
        onError: (_) => _scheduleWsReconnect(),
        onDone: _scheduleWsReconnect,
        cancelOnError: true,
      );
    } catch (_) {
      _scheduleWsReconnect();
    }
  }

  void _onWsFrame(dynamic raw) {
    if (!mounted) return;
    Map<String, dynamic> ev;
    try {
      ev = jsonDecode(raw is String ? raw : utf8.decode(raw))
          as Map<String, dynamic>;
    } catch (_) {
      return;
    }
    final type = (ev['event_type'] ?? '').toString();
    if (type == 'connected') {
      final wasReconnect = _hadFirstConnect;
      setState(() {
        _wsBackoffMs = 1000;
        _hadFirstConnect = true;
      });
      // Pull anything we missed during the disconnect window. On the
      // very first connect, _initialFetch already loaded the backlog,
      // so this only fires on reconnects.
      if (wasReconnect) {
        _pollDelta();
      }
      return;
    }
    if (type != 'message') return;
    // Translate the WS event into the JSON shape _ChatMessage expects
    // (REST listing uses camelCase, WS uses snake_case — bridge here
    // so the rest of the rendering pipeline stays unchanged).
    final translated = <String, dynamic>{
      'id': ev['id'],
      'senderId': ev['sender_user_id'],
      'senderName': ev['sender_name'],
      'kind': ev['kind'],
      'body': ev['body'],
      'mediaUrl': ev['attachment_url'],
      'durationMs': ev['duration_ms'],
      'createdAt': ev['sent_at'],
    };
    final msg = _ChatMessage.fromJson(translated);
    if (msg.id.isEmpty) return;
    final added = _appendMessage(msg);
    if (added) _autoscroll();
  }

  /// Single point of insertion for inbound messages — whether they
  /// arrive via the WebSocket echo, the HTTP send response, or the
  /// reconnect-window delta poll. Dedups by message id since the same
  /// message can land through multiple channels (the server publishes
  /// to WS the moment the row commits AND returns it in the HTTP body,
  /// so racing those two paths used to render the same bubble twice).
  ///
  /// Returns true when a new row was actually appended so callers can
  /// decide whether to autoscroll / nudge the sinceCursor; returns
  /// false on duplicate so the UI doesn't visibly tick.
  bool _appendMessage(_ChatMessage msg) {
    if (msg.id.isEmpty) return false;
    if (_messages.any((m) => m.id == msg.id)) return false;
    setState(() {
      _messages.add(msg);
      final cursor = msg.sentAt.toUtc().toIso8601String();
      if (_sinceCursor == null || cursor.compareTo(_sinceCursor!) > 0) {
        _sinceCursor = cursor;
      }
    });
    return true;
  }

  void _scheduleWsReconnect() {
    if (!mounted) return;
    _wsSub?.cancel();
    _wsChannel?.sink.close();
    _wsChannel = null;
    _wsSub = null;
    final delay = _wsBackoffMs.clamp(1000, 30000);
    _wsBackoffMs = (_wsBackoffMs * 2).clamp(1000, 30000);
    _wsReconnectTimer?.cancel();
    _wsReconnectTimer = Timer(Duration(milliseconds: delay), _connectWebSocket);
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
      // Route every row through the dedup helper. The poll is a
      // catch-up after a WS reconnect; if any of those messages were
      // already delivered via the live socket between the poll fire
      // and the response, the helper drops them silently.
      var addedAny = false;
      for (final m in msgs) {
        if (_appendMessage(m)) addedAny = true;
      }
      if (addedAny) _autoscroll();
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
      // Funnel into the same dedup helper the WS handler uses. The
      // server publishes the WS frame the moment the row commits, so
      // it can land before our HTTP response returns — without this
      // check the sender used to see their own bubble appear twice.
      _appendMessage(msg);
      setState(() {
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
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80, // re-encode to keep upload small
      maxWidth: 1600,
    );
    if (picked == null) return;

    // Push an optimistic bubble first so the user sees their image
    // immediately. The bubble carries the local file path (rendered
    // via Image.file in _buildPendingBubble) and a uploading flag.
    // On success we drop it; the server-issued message will arrive
    // either via the send response or the next poll tick.
    final pending = _PendingBubble(
      clientId: 'pending-${DateTime.now().microsecondsSinceEpoch}',
      kind: _MessageKind.image,
      localPath: picked.path,
      sentAt: DateTime.now(),
    );
    setState(() {
      _pending.add(pending);
      _sending = true;
      _composerBanner = null;
    });
    _autoscroll();

    try {
      final uploaded = await _uploadMedia(
        file: File(picked.path),
        kind: 'image',
      );
      await _sendMessageWithKind(
        kind: 'image',
        body: '',
        mediaUrl: uploaded.url,
      );
      if (mounted) setState(() => _pending.remove(pending));
    } catch (e) {
      if (!mounted) return;
      // Mark the pending bubble as failed so the user sees what didn't
      // go and can retry. Don't auto-remove — the failed marker is
      // the audit trail until they tap retry or dismiss.
      setState(() {
        pending.failed = true;
        pending.errorMessage = '$e';
        _composerBanner = 'Image send failed. Tap the bubble to retry.';
      });
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  /// Re-runs the upload + send for a pending bubble whose previous
  /// attempt failed. Called when the user taps the failure marker.
  Future<void> _retryPending(_PendingBubble p) async {
    if (p.localPath == null || _sending) return;
    setState(() {
      p.failed = false;
      p.errorMessage = null;
      _sending = true;
      _composerBanner = null;
    });
    try {
      final uploaded = await _uploadMedia(
        file: File(p.localPath!),
        kind: p.kind == _MessageKind.image ? 'image' : 'voice',
        durationMs: p.durationMs,
      );
      await _sendMessageWithKind(
        kind: p.kind == _MessageKind.image ? 'image' : 'voice',
        body: '',
        mediaUrl: uploaded.url,
        durationMs: uploaded.durationMs > 0 ? uploaded.durationMs : p.durationMs,
      );
      if (mounted) setState(() => _pending.remove(p));
    } catch (e) {
      if (!mounted) return;
      setState(() {
        p.failed = true;
        p.errorMessage = '$e';
        _composerBanner = 'Send failed. Tap the bubble to retry.';
      });
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

    // Optimistic bubble — same pattern as _sendImage. Voice carries
    // both the local path (so the user can scrub their own recording
    // immediately while the upload is in flight) and the duration.
    final pending = _PendingBubble(
      clientId: 'pending-${DateTime.now().microsecondsSinceEpoch}',
      kind: _MessageKind.voice,
      localPath: path,
      durationMs: ms,
      sentAt: DateTime.now(),
    );
    setState(() {
      _pending.add(pending);
      _sending = true;
      _composerBanner = null;
    });
    _autoscroll();

    try {
      final uploaded =
          await _uploadMedia(file: File(path), kind: 'voice', durationMs: ms);
      await _sendMessageWithKind(
        kind: 'voice',
        body: '',
        mediaUrl: uploaded.url,
        durationMs: uploaded.durationMs > 0 ? uploaded.durationMs : ms,
      );
      if (mounted) setState(() => _pending.remove(pending));
      // Local recording is no longer needed once it's persisted.
      try {
        await File(path).delete();
      } catch (_) {}
    } catch (e) {
      if (!mounted) return;
      setState(() {
        pending.failed = true;
        pending.errorMessage = '$e';
        _composerBanner = 'Voice send failed. Tap the bubble to retry.';
      });
      // Keep the file on disk so retry can re-upload it.
    } finally {
      if (mounted) setState(() => _sending = false);
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
    // Image / voice send share the same publish-then-return race with
    // the WS echo as text send — funnel into _appendMessage so the
    // duplicate is dropped if the WS frame got here first.
    _appendMessage(msg);
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

  // Chat surface palette. Modeled on industry chat-app dark themes
  // (WhatsApp dark, Telegram dark) so the contrast feels familiar:
  //
  //   _chrome      — header + composer chrome. Sits on top of the
  //                  app shell at the same elevation as bottom sheets
  //                  elsewhere, so the close button + composer read as
  //                  the same visual layer as the rest of LazerVault.
  //   _canvas      — message-list background. Deeper near-black with
  //                  a faint blue lift, the same tone WhatsApp uses
  //                  in dark mode (#0B141A).
  //   _bubbleMe    — outgoing bubble. LazerVault indigo at slightly
  //                  deeper saturation than the brand 500 so it
  //                  reads cleanly against _canvas without competing
  //                  with primary CTAs elsewhere on the screen.
  //   _bubbleOther — incoming bubble. Cool slate that pairs with
  //                  _canvas, the same hue used by Telegram's
  //                  incoming bubbles. White text reads softly against
  //                  it without the harsh contrast of pure dark gray.
  static const Color _chrome = Color(0xFF1A1F24);
  static const Color _canvas = Color(0xFF0B141A);
  static const Color _bubbleMe = Color(0xFF4F46E5);
  static const Color _bubbleOther = Color(0xFF1F2C34);
  // Subtle accent on the outgoing bubble for play buttons / waveform
  // active fill. Lighter than _bubbleMe so it pops on top of the
  // bubble fill.
  static const Color _accentMe = Color(0xFFA5B4FC);
  // Status-meta colors for timestamps + sender labels.
  static const Color _metaMe = Color(0xCFFFFFFF);
  static const Color _metaOther = Color(0xFF9FB3C2);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _chrome,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Container(height: 1, color: const Color(0xFF2D2D2D)),
          Expanded(
            child: Container(
              color: _canvas,
              child: _buildMessageList(),
            ),
          ),
          Container(height: 1, color: const Color(0xFF2D2D2D)),
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
    if (_messages.isEmpty && _pending.isEmpty) {
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
    final total = _messages.length + _pending.length;
    return ListView.builder(
      controller: _scroll,
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
      itemCount: total,
      itemBuilder: (_, i) {
        if (i < _messages.length) return _buildBubble(_messages[i]);
        // Pending bubbles render after the persisted timeline, in
        // the order they were started — so the optimistic preview
        // appears at the bottom (where the user expects their
        // outgoing message to land).
        return _buildPendingBubble(_pending[i - _messages.length]);
      },
    );
  }

  Widget _buildBubble(_ChatMessage m) {
    final isMe = m.senderId == widget.currentUserId;
    final bubbleColor = isMe ? _bubbleMe : _bubbleOther;
    const textColor = Colors.white;
    final tailSize = 6.w;
    // Cap bubble width to keep the timeline scannable on wide phones.
    // 78% of the screen leaves ~12% inset for the opposite side, which
    // matches the visual rhythm of WhatsApp / Telegram / iMessage.
    final maxBubbleWidth = MediaQuery.of(context).size.width * 0.78;
    return Container(
      margin: EdgeInsets.only(
        bottom: 6.h,
        // Outer margin pushes the bubble to "their" side; the tail
        // hangs off the inner side via the painter below.
        left: isMe ? 40.w : 0,
        right: isMe ? 0 : 40.w,
      ),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxBubbleWidth),
          child: CustomPaint(
            painter: _BubblePainter(
              color: bubbleColor,
              isMe: isMe,
              tailSize: tailSize,
              radius: 14.r,
            ),
            // Inset the content away from the tail side so the text
            // never overlaps the protrusion.
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                isMe ? 12.w : 12.w + tailSize,
                8.h,
                isMe ? 12.w + tailSize : 12.w,
                8.h,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isMe) ...[
                    Text(
                      m.senderName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: _accentMe,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 3.h),
                  ],
                  _buildMessageContent(m, textColor),
                  SizedBox(height: 3.h),
                  Text(
                    _formatTime(m.sentAt),
                    style: GoogleFonts.inter(
                      color: isMe ? _metaMe : _metaOther,
                      fontSize: 9.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Renders an optimistic local-only bubble for media that's still
  /// uploading or just failed. Visually identical to a real outgoing
  /// bubble, but with an opacity/spinner overlay while in flight and
  /// a tap-to-retry treatment when failed. As soon as the server
  /// round-trip succeeds the parent state removes this from _pending
  /// and the canonical bubble takes over.
  Widget _buildPendingBubble(_PendingBubble p) {
    final tailSize = 6.w;
    final maxBubbleWidth = MediaQuery.of(context).size.width * 0.78;
    return Container(
      margin: EdgeInsets.only(bottom: 6.h, left: 40.w),
      child: Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxBubbleWidth),
          child: GestureDetector(
            onTap: p.failed ? () => _retryPending(p) : null,
            child: CustomPaint(
              painter: _BubblePainter(
                color: p.failed
                    ? const Color(0xFF7F1D1D)
                    : _bubbleMe.withValues(alpha: 0.7),
                isMe: true,
                tailSize: tailSize,
                radius: 14.r,
              ),
              child: Padding(
                padding:
                    EdgeInsets.fromLTRB(12.w, 8.h, 12.w + tailSize, 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildPendingContent(p),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (p.failed) ...[
                          Icon(Icons.refresh,
                              color: Colors.white, size: 12.sp),
                          SizedBox(width: 4.w),
                          Text(
                            'Tap to retry',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ] else ...[
                          SizedBox(
                            width: 10.w,
                            height: 10.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 1.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Sending…',
                            style: GoogleFonts.inter(
                              color: _metaMe,
                              fontSize: 9.sp,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPendingContent(_PendingBubble p) {
    if (p.kind == _MessageKind.image && p.localPath != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Image.file(
          File(p.localPath!),
          width: 220.w,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            width: 220.w,
            height: 140.h,
            color: Colors.black.withValues(alpha: 0.3),
            child: Icon(Icons.broken_image, color: Colors.white, size: 32.sp),
          ),
        ),
      );
    }
    if (p.kind == _MessageKind.voice) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.mic, color: Colors.white, size: 18.sp),
          SizedBox(width: 6.w),
          Text(
            'Voice note · ${((p.durationMs ?? 0) / 1000).round()}s',
            style: GoogleFonts.inter(color: Colors.white, fontSize: 12.sp),
          ),
        ],
      );
    }
    return const SizedBox.shrink();
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
            if (_composerBanner != null)
              Container(
                margin: EdgeInsets.only(bottom: 8.h),
                padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF7F1D1D).withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                      color: const Color(0xFFEF4444).withValues(alpha: 0.4)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline,
                        color: const Color(0xFFFCA5A5), size: 14.sp),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        _composerBanner!,
                        style: GoogleFonts.inter(
                          color: const Color(0xFFFEE2E2),
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _composerBanner = null),
                      child: Icon(Icons.close,
                          color: const Color(0xFFFCA5A5), size: 14.sp),
                    ),
                  ],
                ),
              ),
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

/// Local-only bubble shown for media that is uploading or just
/// failed. Lives in `_pending` (parallel to `_messages`) so we can
/// render an instant preview while the multipart round-trip is in
/// flight, and surface a tap-to-retry treatment when it errors.
///
/// Removed when the round-trip succeeds — the parent state then
/// relies on the canonical message returned by send (and any later
/// poll tick) for display. We deliberately don't try to merge the
/// two paths into one model: pending bubbles need a local file path
/// that real messages don't (and shouldn't) carry.
class _PendingBubble {
  final String clientId;
  final _MessageKind kind;
  final String? localPath;
  final int? durationMs;
  final DateTime sentAt;
  bool failed;
  String? errorMessage;

  _PendingBubble({
    required this.clientId,
    required this.kind,
    required this.sentAt,
    this.localPath,
    this.durationMs,
  })  : failed = false,
        errorMessage = null;
}

/// Paints a chat bubble background with an asymmetric "tail" protruding
/// at the bottom on the side belonging to the sender. The tail mimics
/// the speech-bubble pointer used by WhatsApp / iMessage / Telegram.
///
/// Geometry:
///   - The main rounded rect occupies the full width minus `tailSize`,
///     leaving a margin on the tail side for the triangular pointer.
///   - The tail is a small triangle anchored at the bottom corner of
///     the bubble, jutting outward toward the avatar / edge of the
///     screen.
///   - All four corners have radius `radius` except the tail-side
///     bottom corner, which is squared (`tailCornerRadius` = 2) so the
///     tail flows naturally out of the body.
class _BubblePainter extends CustomPainter {
  final Color color;
  final bool isMe;
  final double tailSize;
  final double radius;

  const _BubblePainter({
    required this.color,
    required this.isMe,
    required this.tailSize,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final w = size.width;
    final h = size.height;
    const tailCornerRadius = 2.0;

    if (isMe) {
      // Body: occupy left/center, leave `tailSize` on the right edge.
      final body = Rect.fromLTWH(0, 0, w - tailSize, h);
      final rect = RRect.fromRectAndCorners(
        body,
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
        bottomLeft: Radius.circular(radius),
        bottomRight: const Radius.circular(tailCornerRadius),
      );
      canvas.drawRRect(rect, paint);

      // Tail: small right-leaning triangle anchored at body's
      // bottom-right edge. Sits below the rect so it appears as a
      // single connected shape.
      final tail = Path()
        ..moveTo(w - tailSize, h - tailSize - 2)
        ..lineTo(w, h)
        ..lineTo(w - tailSize, h)
        ..close();
      canvas.drawPath(tail, paint);
    } else {
      // Mirrored: leave `tailSize` on the left edge.
      final body = Rect.fromLTWH(tailSize, 0, w - tailSize, h);
      final rect = RRect.fromRectAndCorners(
        body,
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
        bottomLeft: const Radius.circular(tailCornerRadius),
        bottomRight: Radius.circular(radius),
      );
      canvas.drawRRect(rect, paint);

      final tail = Path()
        ..moveTo(tailSize, h - tailSize - 2)
        ..lineTo(0, h)
        ..lineTo(tailSize, h)
        ..close();
      canvas.drawPath(tail, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _BubblePainter old) {
    return old.color != color ||
        old.isMe != isMe ||
        old.tailSize != tailSize ||
        old.radius != radius;
  }
}

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
