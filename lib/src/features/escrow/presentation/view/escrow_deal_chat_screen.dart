import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/app_snackbar.dart';
import 'package:lazervault/core/utils/dismiss_keyboard.dart';
import 'package:lazervault/src/features/escrow/domain/entities/escrow_message_entity.dart';
import 'package:lazervault/src/features/escrow/domain/repositories/escrow_repository.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/src/features/escrow/data/services/escrow_media_upload_service.dart';
import 'package:lazervault/src/features/escrow/domain/entities/escrow_deal_entity.dart';
import 'package:lazervault/src/features/escrow/presentation/widgets/escrow_media_viewer.dart';
import 'package:lazervault/core/services/voice_record_configs.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_voice_note_player.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

/// The conversation attached to ONE escrow deal.
///
/// Escrow is the flow where two people who may not know each other are
/// mid-transaction over something physical — "have you posted it", "which
/// colour", "here's the tracking number". That conversation used to happen
/// in their general direct-message thread, which was fine until a deal went
/// wrong:
///
///   * a dispute needs "the chat for THIS deal", and a general thread spans
///     every deal the pair ever did plus everything unrelated;
///   * handing support that general thread to adjudicate one transaction is
///     far more of the parties' private correspondence than the job needs.
///
/// So this thread belongs to the deal. Support can read it and reply into
/// it, and both parties see when they do.
class EscrowDealChatScreen extends StatefulWidget {
  const EscrowDealChatScreen({
    super.key,
    required this.dealId,
    required this.dealTitle,
    required this.viewerUserId,
    this.buyerName = '',
    this.sellerName = '',
    this.viewerIsBuyer = false,
  });

  final String dealId;
  final String dealTitle;
  final String viewerUserId;

  /// Both parties, so the header can name who is in the conversation.
  /// Empty is tolerated: an open-link deal may not have resolved a name yet,
  /// and a blank chip is better than a wrong one.
  final String buyerName;
  final String sellerName;
  final bool viewerIsBuyer;

  @override
  State<EscrowDealChatScreen> createState() => _EscrowDealChatScreenState();
}

class _EscrowDealChatScreenState extends State<EscrowDealChatScreen> {
  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _muted = Color(0xFF8E8E93);
  static const _accent = Color(0xFF4E03D0);
  static const _supportTint = Color(0xFF0E7490);

  final _controller = TextEditingController();
  final _scroll = ScrollController();

  List<EscrowMessageEntity> _messages = const [];
  bool _loading = true;
  bool _sending = false;
  String? _error;

  /// Local ids of messages shown before the server confirmed them, and of
  /// those whose send failed. A sent message that sits invisible until a
  /// round trip completes reads as a dropped message, which is why the
  /// bubble goes up first and is marked rather than withheld.
  final Set<String> _pendingIds = {};
  final Set<String> _failedIds = {};

  /// Images shared IN this thread. They ride the deal's attachment rail
  /// under the `chat_attachment` purpose rather than a media field on the
  /// message, so there is one upload path, one validation path and one
  /// retention story — see models.AttachmentPurposeChatAttachment.
  List<EscrowAttachmentEntity> _chatImages = const [];
  bool _uploading = false;

  /// Media that has been chosen or recorded but is not yet on the server.
  ///
  /// The photo goes into the thread the instant it is picked, showing the
  /// LOCAL file, exactly as the text bubble goes up before its round trip.
  /// Waiting for the upload meant tapping send and watching nothing happen
  /// for several seconds on a slow connection, which reads as a dropped
  /// message — the very thing the text path already refuses to do.
  final List<_PendingMedia> _pendingMedia = [];

  /// Voice capture. One recorder for the screen, stopped in dispose: an
  /// abandoned recorder keeps the microphone open after the user leaves.
  final AudioRecorder _recorder = AudioRecorder();
  bool _recording = false;
  Duration _recordedFor = Duration.zero;
  Timer? _recordTimer;

  /// Hard stop for a recording the user forgets to end. Matches the server's
  /// five-minute cap, so the composer can never produce a clip the backend
  /// will refuse.
  static const _maxRecording = Duration(minutes: 5);

  /// Admin-set caps; the built-in defaults until the server answers.
  EscrowPolicy _policy = EscrowPolicy.fallback;

  late final EscrowMediaUploadService _uploader =
      EscrowMediaUploadService(endpoints: endpointRegistry);

  EscrowRepository get _repo => serviceLocator<EscrowRepository>();

  @override
  void initState() {
    super.initState();
    _load();
    _repo.getPolicy().then((p) {
      if (mounted) setState(() => _policy = p);
    });
  }

  @override
  void dispose() {
    _recordTimer?.cancel();
    // Release the mic and stop any note still playing: both outlive this
    // screen otherwise, and a voice note that keeps playing after you leave
    // the conversation is startling.
    _recorder.dispose();
    ChatVoiceNotePlayer.instance.stop();
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final msgs = await _repo.listDealMessages(widget.dealId);
      // Best-effort: a thread that cannot list its images still reads. The
      // conversation is the product; the pictures are an attachment to it.
      List<EscrowAttachmentEntity> imgs = const [];
      try {
        final deal = await _repo.getDeal(widget.dealId);
        imgs = deal.attachments
            .where((a) => a.purpose == 'chat_attachment')
            .toList(growable: false);
      } catch (_) {}
      if (!mounted) return;
      setState(() {
        _messages = msgs;
        _chatImages = imgs;
        _loading = false;
        _error = null;
      });
      _jumpToEnd();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = _friendly(e);
      });
    }
  }

  /// The newest message is the one you came to read.
  ///
  /// Scrolled TWICE on purpose. One post-frame callback lands before the
  /// list has finished laying out tall or wrapped bubbles, so maxScrollExtent
  /// is still short and the thread opens part-way up. The second pass runs
  /// once that layout has settled.
  void _jumpToEnd() {
    void go() {
      if (!mounted || !_scroll.hasClients) return;
      _scroll.jumpTo(_scroll.position.maxScrollExtent);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      go();
      WidgetsBinding.instance.addPostFrameCallback((_) => go());
    });
  }

  Future<void> _send() async {
    final body = _controller.text.trim();
    if (body.isEmpty || _sending) return;

    // OPTIMISTIC. The bubble appears on the tap, not on the round trip.
    // Waiting for the server left a visibly empty thread for as long as the
    // network took, which reads as "my message did not send" and provokes a
    // second send of the same thing.
    final localId = 'local-${DateTime.now().microsecondsSinceEpoch}';
    final optimistic = EscrowMessageEntity(
      id: localId,
      dealId: widget.dealId,
      senderId: widget.viewerUserId,
      senderRole: widget.viewerIsBuyer ? 'buyer' : 'seller',
      senderName: '',
      body: body,
      createdAt: DateTime.now(),
    );
    setState(() {
      _messages = [..._messages, optimistic];
      _pendingIds.add(localId);
      _controller.clear();
      _sending = true;
    });
    _jumpToEnd();
    await _deliver(localId, body);
  }

  /// Push one optimistic message to the server and settle its bubble.
  ///
  /// Split out of [_send] so a FAILED bubble can be sent again without
  /// retyping it. The p2p chat this screen was modelled on has had
  /// retryMessage since it shipped; here a failure left "Not sent" on screen
  /// with no way forward, so the only recovery was to select the text, copy
  /// it, and type it again.
  Future<void> _deliver(String localId, String body) async {
    try {
      final sent =
          await _repo.sendDealMessage(dealId: widget.dealId, body: body);
      if (!mounted) return;
      setState(() {
        // Swap the local copy for the stored one, in place, so the bubble
        // does not jump. A refetch of the whole thread would make a one-line
        // reply cost a full page load on a slow connection.
        _messages = [
          for (final m in _messages) if (m.id == localId) sent else m,
        ];
        _pendingIds.remove(localId);
        _failedIds.remove(localId);
        _sending = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _pendingIds.remove(localId);
        // Kept in the thread and MARKED, not silently removed. A message
        // that vanishes is indistinguishable from one that was sent.
        _failedIds.add(localId);
        _sending = false;
      });
      showAppSnackbar('Escrow Pay', _friendly(e), type: AppSnackbarType.error);
    }
  }

  /// Send a failed message again, from its own bubble.
  Future<void> _retry(EscrowMessageEntity m) async {
    if (_sending || !_failedIds.contains(m.id)) return;
    setState(() {
      _failedIds.remove(m.id);
      _pendingIds.add(m.id);
      _sending = true;
    });
    await _deliver(m.id, m.body);
  }

  /// Offer the three things you can put in a deal thread.
  ///
  /// A single "add photo" button was the whole of the media story here, which
  /// is why a buyer asked to send a screenshot could reply only in words and
  /// a seller could not show the parcel moving.
  Future<void> _showAttachSheet() async {
    if (_uploading || _recording) return;
    final choice = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: _card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8.h),
            Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: _border,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 8.h),
            ListTile(
              leading: Icon(Icons.photo_outlined, color: Colors.white, size: 20.sp),
              title: Text('Photo',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp)),
              subtitle: Text('Up to 8 MB',
                  style: GoogleFonts.inter(color: _muted, fontSize: 10.5.sp)),
              onTap: () => Navigator.pop(ctx, 'image'),
            ),
            ListTile(
              leading: Icon(Icons.videocam_outlined, color: Colors.white, size: 20.sp),
              title: Text('Video',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp)),
              subtitle: Text('Up to 60 seconds',
                  style: GoogleFonts.inter(color: _muted, fontSize: 10.5.sp)),
              onTap: () => Navigator.pop(ctx, 'video'),
            ),
            SizedBox(height: 6.h),
          ],
        ),
      ),
    );
    if (choice == 'image') {
      await _sendMedia(kind: 'image');
    } else if (choice == 'video') {
      await _sendMedia(kind: 'video');
    }
  }

  /// Pick a photo or video and share it in the thread.
  ///
  /// Optimistic, like the text path: the tile appears from the LOCAL file as
  /// soon as it is chosen, carries a spinner while it uploads, and is marked
  /// — not removed — if it fails. A tile that vanishes is indistinguishable
  /// from one that sent.
  Future<void> _sendMedia({required String kind}) async {
    if (_uploading) return;
    _PendingMedia? pending;
    // The tile goes up from the LOCAL file the moment the picker returns, so
    // the thread reacts to the tap rather than to the upload finishing.
    void onPicked(File f) {
      if (!mounted) return;
      pending = _PendingMedia(
        localId: 'local-${DateTime.now().microsecondsSinceEpoch}',
        kind: kind,
        localPath: f.path,
        at: DateTime.now(),
      );
      setState(() {
        _pendingMedia.add(pending!);
        _uploading = true;
      });
      _jumpToEnd();
    }

    try {
      final up = kind == 'video'
          ? await _uploader.pickAndUploadVideo(onPicked: onPicked)
          : await _uploader.pickAndUploadImage(onPicked: onPicked);
      if (up == null) {
        // Cancelled at the picker — nothing was ever shown.
        if (mounted) setState(() => _uploading = false);
        return;
      }
      await _repo.addAttachment(
        dealId: widget.dealId,
        purpose: 'chat_attachment',
        mediaKind: up.mediaKind,
        url: up.publicUrl,
        contentType: up.contentType,
        sizeBytes: up.sizeBytes,
      );
      if (!mounted) return;
      setState(() {
        if (pending != null) _pendingMedia.remove(pending);
        _uploading = false;
      });
      await _load();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        if (pending != null) pending!.failed = true;
        _uploading = false;
      });
      showAppSnackbar('Escrow Pay', escrowMediaErrorMessage(e), type: AppSnackbarType.error);
    }
  }

  // ---- Voice notes --------------------------------------------------------

  Future<void> _toggleRecording() async {
    if (_recording) {
      await _stopRecording(send: true);
    } else {
      await _startRecording();
    }
  }

  Future<void> _startRecording() async {
    if (_recording || _uploading) return;
    if (!await _recorder.hasPermission()) {
      if (!mounted) return;
      showAppSnackbar('Escrow Pay',
          'Microphone access is needed to record a voice note.',
          type: AppSnackbarType.error);
      return;
    }
    final dir = await getTemporaryDirectory();
    final path =
        '${dir.path}/escrow_voice_${DateTime.now().millisecondsSinceEpoch}.m4a';
    try {
      // kVoiceNoteRecordConfig, not a hand-rolled RecordConfig: the package
      // default is STEREO, which silently fails to initialise on most Android
      // mics and writes an empty file. See voice_record_configs.dart.
      await _recorder.start(kVoiceNoteRecordConfig, path: path);
    } catch (_) {
      if (!mounted) return;
      showAppSnackbar('Escrow Pay',
          'Could not start recording. Please try again.',
          type: AppSnackbarType.error);
      return;
    }
    if (!mounted) return;
    setState(() {
      _recording = true;
      _recordedFor = Duration.zero;
    });
    _recordTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _recordedFor += const Duration(seconds: 1));
      if (_recordedFor >= _maxRecording) _stopRecording(send: true);
    });
  }

  Future<void> _stopRecording({required bool send}) async {
    _recordTimer?.cancel();
    _recordTimer = null;
    if (!_recording) return;
    final ms = _recordedFor.inMilliseconds;
    final path = await _recorder.stop();
    if (mounted) {
      setState(() {
        _recording = false;
        _recordedFor = Duration.zero;
      });
    }
    if (!send || path == null) return;
    if (ms < 700) {
      if (mounted) {
        showAppSnackbar('Escrow Pay', 'Hold the mic a little longer to record.',
            type: AppSnackbarType.error);
      }
      return;
    }
    // A capture can fail without throwing — the file exists but is empty.
    // Catching it here is the difference between "try again" and a bubble
    // that plays nothing.
    var ok = false;
    try {
      ok = await File(path).length() > 1024;
    } catch (_) {}
    if (!ok) {
      if (mounted) {
        showAppSnackbar('Escrow Pay',
            'That recording came out empty. Please try again.',
            type: AppSnackbarType.error);
      }
      return;
    }
    await _sendVoice(path, ms);
  }

  Future<void> _sendVoice(String path, int durationMs) async {
    final pending = _PendingMedia(
      localId: 'local-${DateTime.now().microsecondsSinceEpoch}',
      kind: 'voice',
      localPath: path,
      durationMs: durationMs,
      at: DateTime.now(),
    );
    setState(() {
      _pendingMedia.add(pending);
      _uploading = true;
    });
    _jumpToEnd();
    try {
      final up =
          await _uploader.uploadVoiceNote(File(path), durationMs: durationMs);
      await _repo.addAttachment(
        dealId: widget.dealId,
        purpose: 'chat_attachment',
        mediaKind: up.mediaKind,
        url: up.publicUrl,
        contentType: up.contentType,
        sizeBytes: up.sizeBytes,
        durationSeconds: up.durationSeconds,
      );
      if (!mounted) return;
      setState(() {
        _pendingMedia.remove(pending);
        _uploading = false;
      });
      await _load();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        pending.failed = true;
        _uploading = false;
      });
      showAppSnackbar('Escrow Pay', escrowMediaErrorMessage(e), type: AppSnackbarType.error);
    }
  }

  /// Copy for a failed ATTACHMENT, which is not a failed message.
  ///
  /// Everything unrecognised used to collapse to "Could not send your
  /// message", which was wrong twice over: it named the wrong thing, and it
  /// told the user to retry a refusal that will fail identically every time
  /// — a cap reached, a clip too long, a deal already closed. The server
  /// sends those as sentences meant to be read, so they are shown.
  String _friendly(Object e) {
    final s = e.toString().toLowerCase();
    if (s.contains('not found')) {
      // The server answers NOT_FOUND to a non-party too, so this copy has
      // to work for "no such deal" and "not yours" alike.
      return 'This conversation is not available.';
    }
    if (s.contains('unavailable') || s.contains('socket') || s.contains('network')) {
      return 'Server not reachable. Please try again.';
    }
    if (s.contains('too long')) return 'That message is too long.';
    return 'Could not send your message. Please try again.';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => dismissKeyboard(),
      child: Scaffold(
        backgroundColor: _bg,
        appBar: AppBar(
          backgroundColor: _bg,
          elevation: 0,
          // Beside the back button, not centred. iOS centres by default and
          // the two-line title then sits oddly adrift from the control that
          // owns it; every other chat in the app reads left-aligned.
          centerTitle: false,
          titleSpacing: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
            onPressed: () => Get.back(),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Deal chat',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700)),
              Text(
                widget.dealTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(color: _muted, fontSize: 11.sp),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Say what this thread is, once. Two people who have also DM'd
              // each other need to know which conversation they are in and
              // that it is attached to the money.
              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 4.h),
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: _card,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: _border),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.shield_outlined, size: 14.sp, color: _muted),
                    SizedBox(width: 7.w),
                    Expanded(
                      child: Text(
                        'Messages here belong to this deal. If it is disputed, '
                        'Lazervault support can read this conversation and reply in it.',
                        style: GoogleFonts.inter(
                            color: _muted, fontSize: 10.5.sp, height: 1.35),
                      ),
                    ),
                  ],
                ),
              ),
              _buildParticipants(),
              Expanded(child: _buildBody()),
              _buildComposer(),
            ],
          ),
        ),
      ),
    );
  }

  /// Who is in this conversation.
  ///
  /// Two strangers mid-transaction, plus support if it is disputed — and
  /// until now the thread named nobody, so a user could not tell a
  /// counterparty's message from support's except by the tint. Omitted
  /// entirely when neither name resolved, because two blank chips say less
  /// than no chips.
  Widget _buildParticipants() {
    final buyer = widget.buyerName.trim();
    final seller = widget.sellerName.trim();
    if (buyer.isEmpty && seller.isEmpty) return const SizedBox.shrink();

    Widget chip(String name, String role, bool isYou) => Container(
          margin: EdgeInsets.only(right: 8.w),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: isYou
                ? _accent.withValues(alpha: 0.18)
                : _card,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
                color: isYou ? _accent.withValues(alpha: 0.55) : _border),
          ),
          child: Text(
            isYou ? '$name (you)' : '$name · $role',
            style: GoogleFonts.inter(
              color: isYou ? Colors.white : _muted,
              fontSize: 10.5.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        );

    return Padding(
      padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 2.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            if (buyer.isNotEmpty)
              chip(buyer, 'buyer', widget.viewerIsBuyer),
            if (seller.isNotEmpty)
              chip(seller, 'seller', !widget.viewerIsBuyer),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator(color: _accent));
    }
    if (_error != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_error!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(color: _muted, fontSize: 13.sp)),
              SizedBox(height: 12.h),
              TextButton(
                onPressed: () {
                  setState(() {
                    _loading = true;
                    _error = null;
                  });
                  _load();
                },
                child: Text('Try again',
                    style: GoogleFonts.inter(color: _accent, fontSize: 13.sp)),
              ),
            ],
          ),
        ),
      );
    }
    if (_messages.isEmpty && _chatImages.isEmpty && _pendingMedia.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 36.w),
          child: Text(
            'No messages yet. Ask a question about this deal, delivery, '
            'condition, timing, and it stays attached to it.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: _muted, fontSize: 12.5.sp, height: 1.4),
          ),
        ),
      );
    }
    // Text and images are two stores (messages, attachments) but ONE
    // conversation, so they are merged and ordered by time. Anything with no
    // timestamp sorts last rather than jumping to the top, which is what an
    // epoch-zero fallback would do.
    final items = <({DateTime? at, Widget child})>[
      for (final m in _messages) (at: m.createdAt, child: _bubble(m)),
      for (final a in _chatImages) (at: a.createdAt, child: _mediaBubble(a)),
      // Not yet on the server, so they sort by when they were picked — which
      // is always "now", i.e. the bottom of the thread, where the user is
      // looking.
      for (final m in _pendingMedia) (at: m.at, child: _pendingBubble(m)),
    ]..sort((x, y) {
        if (x.at == null && y.at == null) return 0;
        if (x.at == null) return 1;
        if (y.at == null) return -1;
        return x.at!.compareTo(y.at!);
      });

    return RefreshIndicator(
      color: _accent,
      onRefresh: _load,
      child: ListView.builder(
        controller: _scroll,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(12.w, 6.h, 12.w, 10.h),
        itemCount: items.length,
        itemBuilder: (_, i) => items[i].child,
      ),
    );
  }

  Widget _bubble(EscrowMessageEntity m) {
    final mine = m.isMine(widget.viewerUserId);
    // A support message is centred and tinted rather than taking a side.
    // Putting it on the left would make it look like the counterparty said
    // it, which in a dispute is exactly the wrong impression.
    if (m.isFromAdmin) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: _supportTint.withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: _supportTint.withValues(alpha: 0.45)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.verified_user, size: 12.sp, color: Colors.white70),
                SizedBox(width: 5.w),
                Text(m.senderName.isEmpty ? 'Lazervault Support' : m.senderName,
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700)),
                const Spacer(),
                Text(_time(m.createdAt),
                    style: GoogleFonts.inter(color: _muted, fontSize: 9.5.sp)),
              ],
            ),
            SizedBox(height: 4.h),
            Text(m.body,
                style: GoogleFonts.inter(
                    color: Colors.white, fontSize: 12.5.sp, height: 1.35)),
          ],
        ),
      );
    }

    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 0.76.sw),
        margin: EdgeInsets.symmetric(vertical: 4.h),
        padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: mine ? _accent : _card,
          borderRadius: BorderRadius.circular(12.r),
          border: mine ? null : Border.all(color: _border),
        ),
        child: Column(
          crossAxisAlignment:
              mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (!mine && m.senderName.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: Text(m.senderName,
                    style: GoogleFonts.inter(
                        color: _muted,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600)),
              ),
            Text(m.body,
                style: GoogleFonts.inter(
                    color: Colors.white, fontSize: 12.5.sp, height: 1.35)),
            SizedBox(height: 3.h),
            // An optimistic bubble must say it is not yet confirmed, and a
            // failed one must say it did not go — a message that merely
            // appears is indistinguishable from one that was delivered.
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_time(m.createdAt),
                    style: GoogleFonts.inter(
                        color: mine ? Colors.white70 : _muted,
                        fontSize: 9.5.sp)),
                if (_pendingIds.contains(m.id)) ...[
                  SizedBox(width: 5.w),
                  SizedBox(
                    width: 8.sp,
                    height: 8.sp,
                    child: CircularProgressIndicator(
                        strokeWidth: 1.4, color: Colors.white70),
                  ),
                ] else if (_failedIds.contains(m.id)) ...[
                  SizedBox(width: 5.w),
                  Icon(Icons.error_outline,
                      size: 11.sp, color: const Color(0xFFFCA5A5)),
                  SizedBox(width: 3.w),
                  Text('Not sent',
                      style: GoogleFonts.inter(
                          color: const Color(0xFFFCA5A5), fontSize: 9.5.sp)),
                  // The way out of a failed send. Without it "Not sent" is a
                  // dead end and the only recovery is to retype the message.
                  SizedBox(width: 6.w),
                  GestureDetector(
                    onTap: () => _retry(m),
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      // Widens the tap target without moving the text.
                      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.w),
                      child: Text('Retry',
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 9.5.sp,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white70)),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Anything shared in the thread, dispatched by kind.
  Widget _mediaBubble(EscrowAttachmentEntity a) {
    if (a.mediaKind == 'voice') return _voiceBubble(a);
    if (a.mediaKind == 'video') return _videoBubble(a);
    return _imageBubble(a);
  }

  /// A clip shared in the thread.
  ///
  /// Deliberately NOT an Image.network of the video URL — that was what the
  /// single image path did to anything that was not a photo, and it rendered
  /// every clip as "Image unavailable". There is no server-side thumbnail, so
  /// the tile states what it is and opens the player on tap.
  Widget _videoBubble(EscrowAttachmentEntity a) {
    final mine = a.uploadedBy == widget.viewerUserId;
    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: GestureDetector(
          onTap: () => showEscrowMediaViewer(
            context,
            url: a.url,
            isVideo: true,
            heroTag: 'chat-${a.id}',
          ),
          child: Hero(
            tag: 'chat-${a.id}',
            child: Container(
              width: 190.w,
              height: 120.h,
              decoration: BoxDecoration(
                color: _card,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: _border),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_circle_fill,
                      color: Colors.white, size: 34.sp),
                  SizedBox(height: 6.h),
                  Text(
                    a.durationSeconds > 0
                        ? 'Video · ${_clock(Duration(seconds: a.durationSeconds))}'
                        : 'Video',
                    style: GoogleFonts.inter(color: _muted, fontSize: 10.5.sp),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// A voice note. Playback goes through the app-wide single player so that
  /// scrolling the bubble off-screen does not dispose the audio mid-sentence.
  Widget _voiceBubble(EscrowAttachmentEntity a) {
    final mine = a.uploadedBy == widget.viewerUserId;
    final id = a.url;
    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: Container(
          constraints: BoxConstraints(maxWidth: 230.w),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 9.h),
          decoration: BoxDecoration(
            color: mine ? _accent : _card,
            borderRadius: BorderRadius.circular(12.r),
            border: mine ? null : Border.all(color: _border),
          ),
          child: ValueListenableBuilder<String?>(
            valueListenable: ChatVoiceNotePlayer.instance.currentId,
            builder: (_, currentId, __) {
              final isCurrent = currentId == id;
              return ValueListenableBuilder<bool>(
                valueListenable: ChatVoiceNotePlayer.instance.playing,
                builder: (_, playing, __) {
                  final isPlaying = isCurrent && playing;
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () => ChatVoiceNotePlayer.instance.toggle(
                          id,
                          mediaUrl: a.url,
                          fallbackDurationMs: a.durationSeconds * 1000,
                        ),
                        child: Icon(
                          isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_fill,
                          color: Colors.white,
                          size: 28.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(Icons.graphic_eq,
                          color: Colors.white.withValues(alpha: 0.75),
                          size: 16.sp),
                      SizedBox(width: 8.w),
                      Text(
                        _clock(Duration(seconds: a.durationSeconds)),
                        style: GoogleFonts.inter(
                            color: Colors.white, fontSize: 11.5.sp),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  /// Media that is still uploading, or whose upload failed.
  Widget _pendingBubble(_PendingMedia m) {
    final failed = m.failed;
    Widget inner;
    if (m.kind == 'voice') {
      inner = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.mic, color: Colors.white, size: 18.sp),
          SizedBox(width: 8.w),
          Text(_clock(Duration(milliseconds: m.durationMs)),
              style:
                  GoogleFonts.inter(color: Colors.white, fontSize: 11.5.sp)),
        ],
      );
    } else if (m.kind == 'video') {
      inner = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.videocam, color: Colors.white, size: 18.sp),
          SizedBox(width: 8.w),
          Text('Video',
              style:
                  GoogleFonts.inter(color: Colors.white, fontSize: 11.5.sp)),
        ],
      );
    } else {
      inner = ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: Image.file(
          File(m.localPath),
          width: 150.w,
          height: 110.h,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => SizedBox(
            width: 150.w,
            height: 110.h,
            child: Center(
              child: Icon(Icons.photo, color: _muted, size: 22.sp),
            ),
          ),
        ),
      );
    }

    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: Opacity(
          opacity: failed ? 0.65 : 0.85,
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: _accent,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                inner,
                SizedBox(height: 4.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (failed) ...[
                      Icon(Icons.error_outline,
                          size: 11.sp, color: const Color(0xFFFCA5A5)),
                      SizedBox(width: 3.w),
                      Text('Not sent',
                          style: GoogleFonts.inter(
                              color: const Color(0xFFFCA5A5), fontSize: 9.5.sp)),
                    ] else ...[
                      SizedBox(
                        width: 9.sp,
                        height: 9.sp,
                        child: const CircularProgressIndicator(
                            strokeWidth: 1.5, color: Colors.white),
                      ),
                      SizedBox(width: 5.w),
                      Text('Sending…',
                          style: GoogleFonts.inter(
                              color: Colors.white70, fontSize: 9.5.sp)),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static String _clock(Duration d) {
    final m = d.inMinutes;
    final sec = d.inSeconds % 60;
    return '$m:${sec.toString().padLeft(2, '0')}';
  }

  /// A photo shared in the thread. Tap to open the same viewer the deal's
  /// evidence uses, so there is one way to look at escrow media.
  Widget _imageBubble(EscrowAttachmentEntity a) {
    final mine = a.uploadedBy == widget.viewerUserId;
    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: GestureDetector(
          onTap: () => showEscrowMediaViewer(
            context,
            url: a.url,
            isVideo: a.mediaKind == 'video',
            heroTag: 'chat-${a.id}',
          ),
          child: Hero(
            tag: 'chat-${a.id}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                constraints: BoxConstraints(maxWidth: 210.w, maxHeight: 210.h),
                color: _card,
                child: Image.network(
                  a.url,
                  fit: BoxFit.cover,
                  // A broken image must not be a grey void the user cannot
                  // interpret — say it did not load.
                  errorBuilder: (_, __, ___) => Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Text('Image unavailable',
                        style: GoogleFonts.inter(
                            color: _muted, fontSize: 11.sp)),
                  ),
                  loadingBuilder: (c, child, progress) => progress == null
                      ? child
                      : SizedBox(
                          width: 160.w,
                          height: 120.h,
                          child: const Center(
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: _accent)),
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// A message whose timestamp did not parse still reads; it just has no
  /// time against it.
  String _time(DateTime? t) =>
      t == null ? '' : DateFormat('d MMM, HH:mm').format(t);

  Widget _buildComposer() {
    return Container(
      padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 10.h),
      decoration: const BoxDecoration(
        color: _bg,
        border: Border(top: BorderSide(color: _border)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            tooltip: 'Share a photo or video',
            onPressed: (_uploading || _recording) ? null : _showAttachSheet,
            icon: _uploading
                ? SizedBox(
                    width: 18.sp,
                    height: 18.sp,
                    child: const CircularProgressIndicator(
                        strokeWidth: 2, color: _accent),
                  )
                : Icon(Icons.add_photo_alternate_outlined,
                    color: _muted, size: 22.sp),
          ),
          if (_recording)
            Expanded(
              child: Row(
                children: [
                  // Cancel, deliberately to the LEFT of the send control and
                  // visually distinct: discarding a recording by mistake is
                  // the one irreversible thing this composer can do.
                  IconButton(
                    tooltip: 'Discard recording',
                    onPressed: () => _stopRecording(send: false),
                    icon: Icon(Icons.delete_outline,
                        color: const Color(0xFFFCA5A5), size: 20.sp),
                  ),
                  Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEF4444),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    _clock(_recordedFor),
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Recording… tap the tick to send',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          GoogleFonts.inter(color: _muted, fontSize: 11.sp),
                    ),
                  ),
                ],
              ),
            )
          else
            Expanded(
            child: TextField(
              controller: _controller,
              minLines: 1,
              maxLines: 4,
              // The server's limit, read from policy rather than compiled
              // in: it is admin-tunable, so a hardcoded 4000 would start
              // lying the moment an operator changed it.
              maxLength: _policy.message,
              textInputAction: TextInputAction.newline,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp),
              decoration: InputDecoration(
                counterText: '',
                hintText: 'Message about this deal…',
                hintStyle: GoogleFonts.inter(color: _muted, fontSize: 12.5.sp),
                filled: true,
                fillColor: _card,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          if (!_recording)
            IconButton(
              tooltip: 'Record a voice note',
              onPressed: _uploading ? null : _toggleRecording,
              icon: Icon(Icons.mic_none_rounded, color: _muted, size: 22.sp),
            ),
          SizedBox(width: 4.w),
          GestureDetector(
            onTap: _recording
                ? () => _stopRecording(send: true)
                : (_sending ? null : _send),
            child: Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: _sending ? _card : _accent,
                shape: BoxShape.circle,
              ),
              child: _sending
                  ? Padding(
                      padding: EdgeInsets.all(11.w),
                      child: const CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : Icon(_recording ? Icons.check_rounded : Icons.send_rounded,
                      color: Colors.white, size: 18.sp),
            ),
          ),
        ],
      ),
    );
  }
}

/// One picture, clip or voice note that is in the thread but not yet on the
/// server. Mutable `failed` only: everything else about it is fixed at the
/// moment of picking.
class _PendingMedia {
  _PendingMedia({
    required this.localId,
    required this.kind,
    required this.localPath,
    required this.at,
    this.durationMs = 0,
  });

  final String localId;
  final String kind; // image | video | voice
  final String localPath;
  final DateTime at;
  final int durationMs;
  bool failed = false;
}

/// The sentence a person sees when sharing a file in a deal chat fails.
///
/// Top-level, and therefore testable: this function is the only thing standing
/// between an internal error string and the user, and it has leaked once
/// already. See the guard inside for what went wrong.
String escrowMediaErrorMessage(Object e) {
  final raw = e.toString();
  final s = raw.toLowerCase();
  if (s.contains('unavailable') || s.contains('socket') || s.contains('network')) {
    return 'Server not reachable. Please try again.';
  }
  if (s.contains('not found')) return 'This conversation is not available.';
  // Never pass a TECHNICAL sentence through, whatever else it contains.
  //
  // The marker list below exists to let the server's own user-facing
  // refusals ("you can attach up to 5 photos") reach the person unchanged.
  // But the storage gateway's allow-list refusal named request fields and
  // happened to contain the phrase "voice note", so it matched a marker and
  // the user was shown "filename or content_type must identify a supported
  // image (jpg, png, webp, heic, gif), video (mp4, mov, webm) or voice note
  // (m4a, aac, mp3)". The gateway's wording is fixed, but the shape of the
  // bug is the marker list trusting a substring, so this closes it here too:
  // anything that mentions a wire field or a MIME type is ours to phrase,
  // not the server's.
  for (final internal in const [
    'content_type',
    'content-type',
    'filename',
    'must identify',
    'mime',
    'keyspace',
    'unsupported_media_type',
  ]) {
    if (s.contains(internal)) {
      return 'That file type is not supported. Share a photo, a video, or a voice note.';
    }
  }
  for (final marker in const [
    'you can attach',
    'voice note',
    'shared files',
    'too big',
    'too large',
    'seconds long',
    'this deal is closed',
    'minutes long',
    'came out empty',
    'signed in',
  ]) {
    if (s.contains(marker)) {
      // Strip the gRPC envelope so the sentence reads on its own.
      final m = RegExp(r'desc\s*=\s*(.+)$', dotAll: true).firstMatch(raw);
      final text = (m?.group(1) ?? raw).trim();
      return text.isEmpty ? 'That file could not be shared.' : text;
    }
  }
  return 'That file could not be shared. Please try again.';
}
