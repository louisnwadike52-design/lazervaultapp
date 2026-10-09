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
  });

  final String dealId;
  final String dealTitle;
  final String viewerUserId;

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

  EscrowRepository get _repo => serviceLocator<EscrowRepository>();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final msgs = await _repo.listDealMessages(widget.dealId);
      if (!mounted) return;
      setState(() {
        _messages = msgs;
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
  void _jumpToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      _scroll.jumpTo(_scroll.position.maxScrollExtent);
    });
  }

  Future<void> _send() async {
    final body = _controller.text.trim();
    if (body.isEmpty || _sending) return;
    setState(() => _sending = true);
    try {
      final sent = await _repo.sendDealMessage(dealId: widget.dealId, body: body);
      if (!mounted) return;
      setState(() {
        // Appended locally rather than re-fetching the whole thread: the
        // server already returned the stored message, and a refetch would
        // make a one-line reply cost a full page load on a slow connection.
        _messages = [..._messages, sent];
        _controller.clear();
        _sending = false;
      });
      _jumpToEnd();
    } catch (e) {
      if (!mounted) return;
      setState(() => _sending = false);
      // The draft is deliberately NOT cleared on failure — losing what
      // someone typed because the network blinked is its own bug.
      showAppSnackbar('Escrow Pay', _friendly(e), type: AppSnackbarType.error);
    }
  }

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
                        'LazerVault support can read this conversation and reply in it.',
                        style: GoogleFonts.inter(
                            color: _muted, fontSize: 10.5.sp, height: 1.35),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: _buildBody()),
              _buildComposer(),
            ],
          ),
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
    if (_messages.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 36.w),
          child: Text(
            'No messages yet. Ask a question about this deal — delivery, '
            'condition, timing — and it stays attached to it.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: _muted, fontSize: 12.5.sp, height: 1.4),
          ),
        ),
      );
    }
    return RefreshIndicator(
      color: _accent,
      onRefresh: _load,
      child: ListView.builder(
        controller: _scroll,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(12.w, 6.h, 12.w, 10.h),
        itemCount: _messages.length,
        itemBuilder: (_, i) => _bubble(_messages[i]),
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
                Text(m.senderName.isEmpty ? 'LazerVault Support' : m.senderName,
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
            Text(_time(m.createdAt),
                style: GoogleFonts.inter(
                    color: mine ? Colors.white70 : _muted, fontSize: 9.5.sp)),
          ],
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
          Expanded(
            child: TextField(
              controller: _controller,
              minLines: 1,
              maxLines: 4,
              // Matches the server's limit, so a long message is stopped
              // where it is typed rather than refused after sending.
              maxLength: 4000,
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
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: _sending ? null : _send,
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
                  : Icon(Icons.send_rounded, color: Colors.white, size: 18.sp),
            ),
          ),
        ],
      ),
    );
  }
}
