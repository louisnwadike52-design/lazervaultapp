import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';

import '../data/support_api.dart';
import '../data/support_models.dart';

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
      if (mounted) setState(() => _error = e.toString().replaceFirst('Exception: ', ''));
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

  Future<void> _send() async {
    final text = _input.text.trim();
    final t = _ticket;
    if (text.isEmpty || t == null || _sending) return;
    setState(() => _sending = true);
    _input.clear();
    try {
      await _api.postMessage(t.id, text);
      if (t.isClosed) _reopened = true; // reply reopens a resolved ticket
      await _refresh();
    } catch (e) {
      if (mounted) {
        setState(() => _input.text = text);
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
            Text('Support', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
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
            Text(m.body,
                style: TextStyle(color: Colors.white, fontSize: 14.sp, height: 1.35)),
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

  Widget _buildReopenNotice() {
    return Container(
      margin: EdgeInsets.fromLTRB(12.w, 0, 12.w, 4.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
            color: const Color(0xFF10B981).withValues(alpha: 0.30)),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline,
              size: 14.sp, color: const Color(0xFF10B981)),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'This ticket is resolved. Sending a message will reopen it.',
              style: TextStyle(
                  color: const Color(0xFF10B981), fontSize: 11.sp),
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
          Row(
            children: [
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
                  : Icon(Icons.send_rounded, color: Colors.white, size: 20.sp),
            ),
          ),
            ],
          ),
        ],
      ),
    );
  }
}
