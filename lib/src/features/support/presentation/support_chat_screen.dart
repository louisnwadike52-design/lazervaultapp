import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';

import '../data/support_api.dart';
import '../data/support_models.dart';
import 'package:lazervault/src/features/p2p_chat/data/services/p2p_chat_media_upload_service.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

/// Live "Chat with support" screen. Opens (or resumes) the user's support
/// thread and polls for staff replies. Replies from support arrive here AND by
/// email (support-service mirrors both).
class SupportChatScreen extends StatefulWidget {
  /// When null, resolves/creates the user's live-chat thread. When set (e.g.
  /// opened from a report), shows that specific ticket.
  final SupportTicket? ticket;

  const SupportChatScreen({super.key, this.ticket});

  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _primary = Color(0xFF4E03D0);
  static const _textSecondary = Color(0xFF9CA3AF);

  // Standard support-message limit — matches support-service maxUserText (5000).
  static const _maxMessage = 5000;

  late final SupportApi _api;
  final _input = TextEditingController();
  final _scroll = ScrollController();

  SupportTicket? _ticket;
  List<SupportMessage> _messages = [];
  bool _loading = true;
  bool _sending = false;
  bool _uploading = false;

  /// The uploaded attachment waiting to go out with the next message, and the
  /// local file backing its preview. Both cleared on send.
  String _pendingMediaUrl = '';
  String _pendingMediaPath = '';

  final _uploader = P2PChatMediaUploadService();
  String? _error;
  Timer? _poll;

  /// True once the user replies on a resolved/closed ticket — the backend
  /// reopens it on reply, so the "will reopen" notice disappears.
  bool _reopened = false;

  @override
  void initState() {
    super.initState();
    _api = SupportApi(serviceLocator<SecureStorageService>());
    _ticket = widget.ticket;
    _bootstrap();
  }

  @override
  void dispose() {
    _poll?.cancel();
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _bootstrap() async {
    try {
      _ticket ??= await _api.getOrCreateChat();
      await _refresh();
      _api.markRead(_ticket!.id);
      _poll = Timer.periodic(const Duration(seconds: 3), (_) => _refresh());
    } catch (e) {
      if (mounted)
        setState(() => _error = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  /// Re-run bootstrap after a failure (e.g. support-service was unreachable).
  Future<void> _retry() async {
    _poll?.cancel();
    setState(() {
      _loading = true;
      _error = null;
    });
    await _bootstrap();
  }

  Future<void> _refresh() async {
    final t = _ticket;
    if (t == null) return;
    try {
      final msgs = await _api.getMessages(t.id);
      if (!mounted) return;
      final grew = msgs.length != _messages.length;
      setState(() => _messages = msgs);
      if (grew) _scrollToEnd();
    } catch (_) {
      // keep last good — polling will retry
    }
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(_scroll.position.maxScrollExtent,
            duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
      }
    });
  }

  /// Pick an image and attach it to the composer.
  ///
  /// The file is uploaded IMMEDIATELY rather than on send, so the user sees
  /// whether it worked while they are still writing — discovering a failed
  /// upload at send time means retyping the message too.
  Future<void> _attachImage() async {
    if (_sending || _uploading) return;
    try {
      final picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        // Capped here as well as in the compressor: a 50MP phone photo is a
        // slow upload on the mobile data a stuck user is probably on.
        maxWidth: 2000,
        imageQuality: 90,
      );
      if (picked == null) return;
      setState(() => _uploading = true);
      final res = await _uploader.uploadFromFile(File(picked.path));
      if (!mounted) return;
      setState(() {
        _pendingMediaUrl = res.publicUrl;
        _pendingMediaPath = picked.path;
      });
    } catch (_) {
      if (!mounted) return;
      // Never surface the raw failure. An upload can fail on a storage
      // allow-list, a signed-URL expiry or a dropped connection, and none of
      // those mean anything to someone trying to send a screenshot.
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Couldn't attach that image. Please try again."),
      ));
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  void _clearAttachment() {
    setState(() {
      _pendingMediaUrl = '';
      _pendingMediaPath = '';
    });
  }

  Future<void> _send() async {
    final text = _input.text.trim();
    final media = _pendingMediaUrl;
    final t = _ticket;
    // An image on its own is a complete message — "here is the screen" needs
    // no caption, and demanding one makes people type "see image".
    if ((text.isEmpty && media.isEmpty) || t == null || _sending) return;
    setState(() => _sending = true);
    _input.clear();
    final hadPath = _pendingMediaPath;
    _pendingMediaUrl = '';
    _pendingMediaPath = '';
    try {
      await _api.postMessage(t.id, text, mediaUrl: media);
      if (t.isClosed) _reopened = true; // reply reopens a resolved ticket
      await _refresh();
    } catch (e) {
      if (mounted) {
        // Put the message BACK, attachment included — the upload already
        // succeeded, so the user should not have to pick the image again.
        setState(() {
          _input.text = text;
          _pendingMediaUrl = media;
          _pendingMediaPath = hadPath;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))),
        );
      }
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        elevation: 0,
        // The near-black background hides theme-default (dark) icons, so the
        // back arrow + title must be forced white to stay visible.
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Support',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
            if (_ticket != null)
              Text(_ticket!.ticketNumber,
                  style: TextStyle(fontSize: 11.sp, color: _textSecondary)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _buildBody()),
          // A resolved/closed ticket reopens when the user replies — say so
          // instead of silently accepting a message on a "closed" thread.
          if (_ticket != null && _ticket!.isClosed && !_reopened)
            _buildReopenNotice(),
          // Only offer the composer once a real thread exists — while loading
          // or after a bootstrap failure there's nothing to send to.
          if (_ticket != null) _buildComposer(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator(color: _primary));
    }
    if (_error != null && _messages.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.cloud_off, color: _textSecondary, size: 40.sp),
              SizedBox(height: 14.h),
              Text('Couldn\'t start the chat.\n$_error',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: _textSecondary, fontSize: 13.sp)),
              SizedBox(height: 16.h),
              OutlinedButton.icon(
                onPressed: _retry,
                icon: Icon(Icons.refresh, color: Colors.white, size: 18.sp),
                label: const Text('Try again',
                    style: TextStyle(color: Colors.white)),
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: _primary)),
              ),
            ],
          ),
        ),
      );
    }
    if (_messages.isEmpty) {
      return Center(
        child: Text('Say hello — our team will reply here and by email.',
            style: TextStyle(color: _textSecondary, fontSize: 13.sp)),
      );
    }
    return ListView.builder(
      controller: _scroll,
      padding: EdgeInsets.all(16.w),
      itemCount: _messages.length,
      itemBuilder: (_, i) => _bubble(_messages[i]),
    );
  }

  Widget _bubble(SupportMessage m) {
    if (m.isSystem) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Center(
          child: Text(m.body,
              style: TextStyle(color: _textSecondary, fontSize: 11.sp)),
        ),
      );
    }
    final mine = !m.isStaff; // user's own messages on the right
    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        constraints: BoxConstraints(maxWidth: 0.75.sw),
        decoration: BoxDecoration(
          color: mine ? _primary : _card,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14.r),
            topRight: Radius.circular(14.r),
            bottomLeft: Radius.circular(mine ? 14.r : 4.r),
            bottomRight: Radius.circular(mine ? 4.r : 14.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!mine)
              Padding(
                padding: EdgeInsets.only(bottom: 3.h),
                child: Text(m.senderName.isNotEmpty ? m.senderName : 'Support',
                    style: TextStyle(
                        color: _textSecondary,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600)),
              ),
            // The attachment, above any caption. Tapping opens it full-screen —
            // a screenshot of an error message is unreadable at bubble width,
            // which is the whole reason it was sent.
            if (m.hasImage)
              Padding(
                padding: EdgeInsets.only(bottom: m.body.isEmpty ? 0 : 8.h),
                child: GestureDetector(
                  onTap: () => _openImage(m.mediaUrl),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.network(
                      m.mediaUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Container(
                          height: 140.h,
                          width: 0.55.sw,
                          color: Colors.black26,
                          child: const Center(
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white70),
                          ),
                        );
                      },
                      // A dead URL must not leave a silent blank bubble: say
                      // an image was sent and could not be loaded, so the
                      // conversation still makes sense.
                      errorBuilder: (_, __, ___) => Container(
                        height: 90.h,
                        width: 0.55.sw,
                        color: Colors.black26,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.broken_image_outlined,
                                  color: Colors.white54, size: 20.sp),
                              SizedBox(height: 4.h),
                              Text('Image unavailable',
                                  style: TextStyle(
                                      color: Colors.white54, fontSize: 10.sp)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (m.body.isNotEmpty)
              Text(m.body,
                  style: TextStyle(
                      color: Colors.white, fontSize: 14.sp, height: 1.35)),
            if (m.viaEmail)
              Padding(
                padding: EdgeInsets.only(top: 3.h),
                child: Text('via email',
                    style: TextStyle(
                        color: mine ? Colors.white70 : _textSecondary,
                        fontSize: 9.sp)),
              ),
          ],
        ),
      ),
    );
  }

  /// Full-screen viewer for an attachment, pinch-to-zoom.
  void _openImage(String url) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black87,
      builder: (ctx) => GestureDetector(
        onTap: () => Navigator.of(ctx).pop(),
        child: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                minScale: 1,
                maxScale: 4,
                child: Image.network(
                  url,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Icon(Icons.broken_image_outlined,
                      color: Colors.white54, size: 48.sp),
                ),
              ),
            ),
            Positioned(
              top: 48.h,
              right: 20.w,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white, size: 26.sp),
                onPressed: () => Navigator.of(ctx).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReopenNotice() {
    return Container(
      margin: EdgeInsets.fromLTRB(12.w, 0, 12.w, 4.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10.r),
        border:
            Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.30)),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline,
              size: 14.sp, color: const Color(0xFF10B981)),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'This ticket is resolved. Sending a message will reopen it.',
              style: TextStyle(color: const Color(0xFF10B981), fontSize: 11.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComposer() {
    final len = _input.text.characters.length;
    return Container(
      padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 12.h),
      color: _bg,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Live counter — only once the user starts typing, so an empty
          // composer stays clean. Turns red at the limit.
          if (len > 0)
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 6.w, bottom: 4.h),
                child: Text(
                  '$len/$_maxMessage',
                  style: TextStyle(
                    color: len >= _maxMessage
                        ? const Color(0xFFEF4444)
                        : _textSecondary,
                    fontSize: 10.sp,
                  ),
                ),
              ),
            ),
          // The attachment waiting to go out. Shown as a thumbnail with a
          // clear X: an attachment you cannot see or remove is one you send by
          // accident.
          if (_pendingMediaPath.isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.file(
                        File(_pendingMediaPath),
                        width: 64.w,
                        height: 64.w,
                        fit: BoxFit.cover,
                        // The preview is a convenience; a missing local file
                        // must not break the composer the attachment is
                        // already uploaded to.
                        errorBuilder: (_, __, ___) => Container(
                          width: 64.w,
                          height: 64.w,
                          color: _card,
                          child: Icon(Icons.image_outlined,
                              color: _textSecondary, size: 20.sp),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -6,
                      right: -6,
                      child: GestureDetector(
                        onTap: _clearAttachment,
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: EdgeInsets.all(3.w),
                          decoration: const BoxDecoration(
                            color: Color(0xFF1F1F1F),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.close,
                              size: 13.sp, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Row(
            children: [
              // Attach. Disabled while an upload is in flight so a double-tap
              // cannot replace the image someone just picked.
              GestureDetector(
                onTap: _uploading ? null : _attachImage,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.only(right: 4.w),
                  child: SizedBox(
                    width: 40.w,
                    height: 46.w,
                    child: Center(
                      child: _uploading
                          ? SizedBox(
                              width: 18.w,
                              height: 18.w,
                              child: const CircularProgressIndicator(
                                  strokeWidth: 2, color: _primary),
                            )
                          : Icon(Icons.add_photo_alternate_outlined,
                              color: _textSecondary, size: 22.sp),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _input,
                  minLines: 1,
                  maxLines: 5,
                  maxLength: _maxMessage,
                  // Enforce the cap but hide the default counter (we render our own
                  // above so the composer row keeps its height).
                  buildCounter: (context,
                          {required int currentLength,
                          required bool isFocused,
                          int? maxLength}) =>
                      null,
                  onChanged: (_) => setState(() {}),
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  decoration: InputDecoration(
                    hintText: 'Message support…',
                    hintStyle:
                        TextStyle(color: _textSecondary, fontSize: 14.sp),
                    filled: true,
                    fillColor: _card,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: _send,
                child: Container(
                  width: 46.w,
                  height: 46.w,
                  decoration: const BoxDecoration(
                    color: _primary,
                    shape: BoxShape.circle,
                  ),
                  child: _sending
                      ? Padding(
                          padding: EdgeInsets.all(12.w),
                          child: const CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : Icon(Icons.send_rounded,
                          color: Colors.white, size: 20.sp),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
