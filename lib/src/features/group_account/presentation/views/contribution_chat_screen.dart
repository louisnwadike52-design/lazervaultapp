import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../data/datasources/contribution_chat_remote_data_source.dart';
import '../cubit/contribution_chat_cubit.dart';

/// Full-screen group chat for one contribution.
///
/// A SCREEN rather than a bottom sheet: this is a conversation people stay in,
/// and a sheet fights the keyboard, can't own the back gesture cleanly, and
/// caps the reading area at a fraction of the display. The old in-memory sheet
/// is replaced by this.
class ContributionChatScreen extends StatefulWidget {
  final String contributionId;
  final String contributionTitle;
  final String currentUserId;

  /// Returns a fresh access token on each call — read lazily so a token
  /// refreshed mid-conversation is picked up without rebuilding the screen.
  final String Function() tokenProvider;

  const ContributionChatScreen({
    super.key,
    required this.contributionId,
    required this.contributionTitle,
    required this.currentUserId,
    required this.tokenProvider,
  });

  @override
  State<ContributionChatScreen> createState() => _ContributionChatScreenState();
}

class _ContributionChatScreenState extends State<ContributionChatScreen>
    with WidgetsBindingObserver {
  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _mine = Color(0xFF4E03D0);

  late final ContributionChatCubit _chat;
  final _input = TextEditingController();
  final _scroll = ScrollController();

  /// Tracks whether the viewer is parked near the newest message. New
  /// incoming messages auto-scroll ONLY then — otherwise someone reading
  /// history would be yanked to the bottom every few seconds.
  bool _atBottom = true;
  int _lastCount = 0;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Stop polling (and stop claiming reads) when the app isn't on screen.
    if (state == AppLifecycleState.resumed) {
      _chat.resume();
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.hidden) {
      _chat.pause();
    }
  }

  void _onScroll() {
    if (!_scroll.hasClients) return;
    final pos = _scroll.position;
    // 120px of slack: "near the bottom" counts as at the bottom, so a small
    // nudge doesn't disable auto-follow.
    final atBottom = pos.pixels >= pos.maxScrollExtent - 120;
    if (atBottom != _atBottom) {
      _atBottom = atBottom;
      _chat.viewerIsAtBottom = atBottom;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scroll.addListener(_onScroll);
    _chat = ContributionChatCubit(
      contributionId: widget.contributionId,
      currentUserId: widget.currentUserId,
      tokenProvider: widget.tokenProvider,
    )..addListener(_onChatChanged);
    _chat.start();
  }

  void _onChatChanged() {
    if (!mounted) return;
    final grew = _chat.messages.length > _lastCount;
    _lastCount = _chat.messages.length;
    setState(() {});
    // Follow the conversation only if the reader is already at the bottom.
    if (grew && _atBottom) _scrollToBottom();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scroll.removeListener(_onScroll);
    _chat.removeListener(_onChatChanged);
    _chat.dispose();
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    // Post-frame so the new bubble is laid out before we measure.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _send() async {
    final text = _input.text;
    if (text.trim().isEmpty) return;
    _input.clear();
    await _chat.send(text);
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: _bg,
        appBar: AppBar(
          backgroundColor: _bg,
          elevation: 0,
          titleSpacing: 0,
          // The back button and any action icons inherit from the global
          // AppBarTheme when unset, which resolves dark against this
          // near-black chat background — the control was there but you
          // couldn't see it. State the on-dark foreground explicitly.
          foregroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.white),
          actionsIconTheme: const IconThemeData(color: Colors.white),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.contributionTitle.isNotEmpty
                    ? widget.contributionTitle
                    : 'Contribution chat',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              // Live subtitle: who's typing, else how many can see this chat.
              Text(
                _subtitle(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: _chat.typing.isNotEmpty
                      ? const Color(0xFF10B981)
                      : Colors.grey[500],
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: _buildList()),
              if (_chat.typing.isNotEmpty) _buildTypingRow(),
              if (_chat.replyingTo != null) _buildReplyPreview(),
              _buildComposer(),
            ],
          ),
        ),
      ),
    );
  }

  String _subtitle() {
    final t = _chat.typing;
    if (t.isNotEmpty) {
      if (t.length == 1) return '${t.first.userName} is typing…';
      if (t.length == 2) {
        return '${t[0].userName} and ${t[1].userName} are typing…';
      }
      return '${t.length} people are typing…';
    }
    final n = _chat.readers.length;
    return n > 0 ? '$n member${n == 1 ? '' : 's'} in this chat' : 'Group chat';
  }

  Widget _buildList() {
    if (_chat.loading) {
      return const Center(child: CircularProgressIndicator(color: _mine));
    }
    // A failure (e.g. you were removed from the contribution → 403) must not
    // masquerade as an empty conversation: "No messages yet" would be a lie
    // that hides why the chat is blank.
    if (_chat.messages.isEmpty && _chat.error != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_outline, size: 44.sp, color: Colors.grey[600]),
              SizedBox(height: 12.h),
              Text(
                "Can't open this chat",
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6.h),
              Text(
                _chat.error!.contains('403') ||
                        _chat.error!.toLowerCase().contains('member')
                    ? "You're no longer a member of this contribution."
                    : 'We couldn\'t load the messages. Check your connection and try again.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: Colors.grey[500], fontSize: 12.sp, height: 1.4),
              ),
            ],
          ),
        ),
      );
    }
    if (_chat.messages.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.forum_outlined, size: 48.sp, color: Colors.grey[700]),
              SizedBox(height: 12.h),
              Text(
                'No messages yet',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6.h),
              Text(
                'Say hello to the other members of this contribution.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: Colors.grey[500], fontSize: 12.sp, height: 1.4),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      controller: _scroll,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      itemCount: _chat.messages.length,
      itemBuilder: (context, i) {
        final m = _chat.messages[i];
        final prev = i > 0 ? _chat.messages[i - 1] : null;
        // Date separator when the day changes — cheap orientation in a long
        // scrollback.
        final showDate = prev == null ||
            !_sameDay(prev.createdAt, m.createdAt);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (showDate) _dateChip(m.createdAt),
            _bubble(m, showSender: _showSender(m, prev)),
          ],
        );
      },
    );
  }

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  /// Group consecutive messages from the same sender — only the first of a run
  /// carries the name, like every messenger people already know.
  bool _showSender(ContributionMessage m, ContributionMessage? prev) {
    if (m.senderId == widget.currentUserId) return false;
    if (prev == null) return true;
    return prev.senderId != m.senderId;
  }

  Widget _dateChip(DateTime d) {
    final now = DateTime.now();
    String label;
    if (_sameDay(d, now)) {
      label = 'Today';
    } else if (_sameDay(d, now.subtract(const Duration(days: 1)))) {
      label = 'Yesterday';
    } else {
      label = DateFormat('d MMM yyyy').format(d);
    }
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(label,
            style:
                GoogleFonts.inter(color: Colors.grey[500], fontSize: 10.sp)),
      ),
    );
  }

  Widget _bubble(ContributionMessage m, {required bool showSender}) {
    final mine = m.senderId == widget.currentUserId;
    final status = _chat.statusOf(m);

    if (m.deletedForEveryone) {
      return _alignRow(
        mine,
        Container(
          margin: EdgeInsets.only(top: 4.h),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: _border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.block, size: 12.sp, color: Colors.grey[600]),
              SizedBox(width: 6.w),
              Text('This message was deleted',
                  style: GoogleFonts.inter(
                      color: Colors.grey[500],
                      fontSize: 12.sp,
                      fontStyle: FontStyle.italic)),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onLongPress: () => _showMessageActions(m, mine),
      child: _alignRow(
        mine,
        Container(
          margin: EdgeInsets.only(top: 4.h),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          constraints: BoxConstraints(maxWidth: 0.76.sw),
          decoration: BoxDecoration(
            color: mine ? _mine : _card,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.r),
              topRight: Radius.circular(14.r),
              bottomLeft: Radius.circular(mine ? 14.r : 4.r),
              bottomRight: Radius.circular(mine ? 4.r : 14.r),
            ),
            border: mine ? null : Border.all(color: _border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showSender)
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    m.senderName,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9B6DFF),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              if (m.hasReply) _replyQuote(m, mine),
              Text(
                m.body,
                style: GoogleFonts.inter(
                    color: Colors.white, fontSize: 14.sp, height: 1.35),
              ),
              SizedBox(height: 3.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (m.isEdited) ...[
                    Text('edited',
                        style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.55),
                            fontSize: 9.sp)),
                    SizedBox(width: 5.w),
                  ],
                  Text(
                    DateFormat('HH:mm').format(m.createdAt),
                    style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 9.sp),
                  ),
                  if (mine) ...[
                    SizedBox(width: 4.w),
                    _tick(status),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _alignRow(bool mine, Widget child) => Row(
        mainAxisAlignment:
            mine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [Flexible(child: child)],
      );

  Widget _replyQuote(ContributionMessage m, bool mine) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.h),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: mine ? 0.22 : 0.35),
        borderRadius: BorderRadius.circular(8.r),
        border: Border(
          left: BorderSide(color: const Color(0xFF9B6DFF), width: 3.w),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            m.replyToSender.isNotEmpty ? m.replyToSender : 'Message',
            style: GoogleFonts.inter(
                color: const Color(0xFF9B6DFF),
                fontSize: 10.sp,
                fontWeight: FontWeight.w700),
          ),
          Text(
            m.replyToBody,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.75), fontSize: 11.sp),
          ),
        ],
      ),
    );
  }

  /// Delivery ticks. One tick = stored; two = everyone has read it; a spinner
  /// while in flight; a retry affordance when it failed — so a message never
  /// silently disappears into nothing.
  Widget _tick(ChatDeliveryStatus s) {
    switch (s) {
      case ChatDeliveryStatus.sending:
        return SizedBox(
          width: 10.sp,
          height: 10.sp,
          child: CircularProgressIndicator(
              strokeWidth: 1.4, color: Colors.white.withValues(alpha: 0.7)),
        );
      case ChatDeliveryStatus.failed:
        return Icon(Icons.error_outline,
            size: 12.sp, color: const Color(0xFFFCA5A5));
      case ChatDeliveryStatus.read:
        return Icon(Icons.done_all, size: 13.sp, color: const Color(0xFF7DD3FC));
      case ChatDeliveryStatus.sent:
        return Icon(Icons.done,
            size: 13.sp, color: Colors.white.withValues(alpha: 0.7));
    }
  }

  Widget _buildTypingRow() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(left: 16.w, bottom: 6.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: _border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 10.sp,
              height: 10.sp,
              child: const CircularProgressIndicator(
                  strokeWidth: 1.4, color: Color(0xFF10B981)),
            ),
            SizedBox(width: 8.w),
            Text(_subtitle(),
                style: GoogleFonts.inter(
                    color: Colors.grey[400], fontSize: 11.sp)),
          ],
        ),
      ),
    );
  }

  Widget _buildReplyPreview() {
    final r = _chat.replyingTo!;
    return Container(
      padding: EdgeInsets.fromLTRB(12.w, 8.h, 8.w, 8.h),
      color: _card,
      child: Row(
        children: [
          Container(width: 3.w, height: 32.h, color: const Color(0xFF9B6DFF)),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Replying to ${r.senderName}',
                    style: GoogleFonts.inter(
                        color: const Color(0xFF9B6DFF),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600)),
                Text(r.body,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                        color: Colors.grey[400], fontSize: 11.sp)),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, size: 18.sp, color: Colors.grey[500]),
            onPressed: () => _chat.setReplyTo(null),
          ),
        ],
      ),
    );
  }

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
              controller: _input,
              onChanged: _chat.onTypingChanged,
              minLines: 1,
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: 'Message',
                hintStyle:
                    GoogleFonts.inter(color: Colors.grey[600], fontSize: 14.sp),
                filled: true,
                fillColor: _card,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22.r),
                  borderSide: const BorderSide(color: _border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22.r),
                  borderSide: const BorderSide(color: _border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22.r),
                  borderSide: const BorderSide(color: _mine, width: 1.5),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: _send,
            child: Container(
              padding: EdgeInsets.all(11.w),
              decoration: const BoxDecoration(
                  color: _mine, shape: BoxShape.circle),
              child: Icon(Icons.send_rounded, color: Colors.white, size: 18.sp),
            ),
          ),
        ],
      ),
    );
  }

  void _showMessageActions(ContributionMessage m, bool mine) {
    if (m.id.isEmpty) {
      // Still sending (or failed) — the only useful action is a retry.
      if (m.status == ChatDeliveryStatus.failed) _chat.retry(m);
      return;
    }
    showModalBottomSheet(
      context: context,
      backgroundColor: _card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8.h),
            _action(ctx, Icons.reply, 'Reply', () => _chat.setReplyTo(m)),
            _action(ctx, Icons.visibility_outlined, 'Seen by',
                () => _showSeenBy(m)),
            if (mine)
              _action(ctx, Icons.edit_outlined, 'Edit', () => _editDialog(m)),
            _action(
              ctx,
              Icons.delete_outline,
              'Delete for everyone',
              () => _chat.deleteForEveryone(m),
              danger: true,
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  Widget _action(BuildContext ctx, IconData icon, String label, VoidCallback onTap,
      {bool danger = false}) {
    final color = danger ? const Color(0xFFEF4444) : Colors.white;
    return ListTile(
      leading: Icon(icon, color: color, size: 20.sp),
      title: Text(label,
          style: GoogleFonts.inter(color: color, fontSize: 14.sp)),
      onTap: () {
        Navigator.pop(ctx);
        onTap();
      },
    );
  }

  /// The "views" surface: exactly who has read this message.
  void _showSeenBy(ContributionMessage m) {
    final seen = _chat.readersOf(m);
    showModalBottomSheet(
      context: context,
      backgroundColor: _card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Icons.done_all,
                      size: 16.sp, color: const Color(0xFF7DD3FC)),
                  SizedBox(width: 8.w),
                  Text(
                    seen.isEmpty
                        ? 'Not seen yet'
                        : 'Seen by ${seen.length} member${seen.length == 1 ? '' : 's'}',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              if (seen.isEmpty)
                Text(
                  'Nobody else has opened the chat since you sent this.',
                  style: GoogleFonts.inter(
                      color: Colors.grey[500], fontSize: 12.sp),
                )
              else
                ...seen.map(
                  (r) => Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 14.r,
                          backgroundColor: _mine.withValues(alpha: 0.2),
                          child: Text(
                            (r.userName.isNotEmpty ? r.userName[0] : '?')
                                .toUpperCase(),
                            style: GoogleFonts.inter(
                                color: const Color(0xFF9B6DFF),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            r.userName.isNotEmpty ? r.userName : 'Member',
                            style: GoogleFonts.inter(
                                color: Colors.white, fontSize: 13.sp),
                          ),
                        ),
                        if (r.lastReadAt != null)
                          Text(
                            DateFormat('HH:mm').format(r.lastReadAt!),
                            style: GoogleFonts.inter(
                                color: Colors.grey[500], fontSize: 11.sp),
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _editDialog(ContributionMessage m) {
    final controller = TextEditingController(text: m.body);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _card,
        title: Text('Edit message',
            style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp)),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLines: 4,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
          decoration: InputDecoration(
            filled: true,
            fillColor: _bg,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: _border),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel',
                style: GoogleFonts.inter(color: Colors.grey[400])),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _chat.edit(m, controller.text);
            },
            child: Text('Save',
                style: GoogleFonts.inter(
                    color: const Color(0xFF9B6DFF),
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
