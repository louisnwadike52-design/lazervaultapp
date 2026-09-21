import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../data/datasources/contribution_chat_remote_data_source.dart';
import '../cubit/contribution_chat_cubit.dart';
import '../../utils/mention_text.dart';
import '../widgets/mention_picker.dart';

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
    this.mentionCandidates = const [],
  });

  /// Members who can be @-mentioned. Supplied by the caller because the chat
  /// screen has no member list of its own, and deriving candidates from who has
  /// spoken would make a quiet member impossible to tag.
  final List<MentionCandidate> mentionCandidates;

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

  // Media capture state. Mirrors p2p_chat_input_bar so both chats behave the
  // same way and share its Android fixes.
  final ImagePicker _imagePicker = ImagePicker();
  final AudioRecorder _recorder = AudioRecorder();
  bool _isRecording = false;
  Duration _recordingDuration = Duration.zero;
  Timer? _recordingTimer;
  // Drives the send/mic swap. Held in state so the composer rebuilds on the
  // empty↔non-empty transition only, not on every keystroke.
  bool _hasText = false;
  // Voice playback. One player for the screen so a second tap
  // replaces the first note rather than overlapping voices.
  final AudioPlayer _voicePlayer = AudioPlayer();
  String? _playingMessageId;
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
    _recordingTimer?.cancel();
    _voicePlayer.dispose();
    _recorder.dispose();
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

  /// Ids picked from the picker, mapped to the display name inserted for them.
  ///
  /// The name is kept so the text can be re-checked at send time: a mention is
  /// only real while its text is, and someone who picks Ada then deletes her
  /// name must not still notify her.
  final Map<String, String> _pickedMentions = {};

  /// End of the most recently completed mention. Names contain spaces, so a
  /// trailing space cannot close a token — this boundary is what does.
  int _mentionBoundary = 0;

  MentionQuery? _mentionQuery;

  List<MentionCandidate> get _mentionMatches {
    final q = _mentionQuery;
    if (q == null) return const [];
    return MentionText.rank(
      widget.mentionCandidates.where((c) => c.userId != widget.currentUserId),
      q.term,
      nameOf: (c) => c.name,
    ).take(12).toList();
  }

  void _onComposerChanged(String value) {
    final sel = _input.selection;
    final caret = sel.isValid ? sel.baseOffset : value.length;
    // Editing BEFORE the boundary invalidates it — otherwise deleting an
    // earlier mention would leave the scan refusing to look at text that is
    // now live again.
    if (_mentionBoundary > value.length) _mentionBoundary = 0;
    final q = MentionText.queryAt(value, caret, notBefore: _mentionBoundary);
    if (q?.term != _mentionQuery?.term ||
        (q == null) != (_mentionQuery == null)) {
      setState(() => _mentionQuery = q);
    } else {
      _mentionQuery = q;
    }
  }

  void _applyMention(MentionCandidate c) {
    final q = _mentionQuery;
    if (q == null) return;
    final r = MentionText.applyMention(_input.text, q, c.name);
    _input.value = TextEditingValue(
      text: r.text,
      selection: TextSelection.collapsed(offset: r.caret),
    );
    setState(() {
      _pickedMentions[c.userId] = c.name;
      _mentionBoundary = r.caret;
      _mentionQuery = null;
      _hasText = r.text.trim().isNotEmpty;
    });
  }

  /// Message text with any @mentions highlighted.
  ///
  /// Without this the whole feature is invisible: the ids were stored, sent and
  /// notified on, but the bubble painted plain text — so a tag looked exactly
  /// like someone typing a name, which is the one thing a mention must not do.
  ///
  /// Highlighting is driven by the member NAMES rather than by scanning for
  /// "@word", because names contain spaces: an "@word" rule would colour
  /// "@Praiz" and leave "Onah Flw" plain, reading as a rendering fault.
  Widget _bodyWithMentions(ContributionMessage m) {
    final base =
        GoogleFonts.inter(color: Colors.white, fontSize: 14.sp, height: 1.35);

    if (m.mentionedUserIds.isEmpty) return Text(m.body, style: base);

    final namesById = {
      for (final c in widget.mentionCandidates) c.userId: c.name,
    };
    final spans = MentionHighlighting.spans(
      m.body,
      m.mentionedUserIds,
      namesById,
      selfUserId: widget.currentUserId,
    );

    // Nothing resolved — every mentioned member has since left, so there is no
    // name to match. Render plain rather than inventing a highlight.
    if (spans.length == 1 && !spans.first.isMention) {
      return Text(m.body, style: base);
    }

    return RichText(
      text: TextSpan(
        style: base,
        children: [
          for (final sp in spans)
            TextSpan(
              text: sp.text,
              style: sp.isMention
                  ? base.copyWith(
                      // Your OWN name is what you scan a busy thread for, so it
                      // gets the stronger treatment; other people's mentions
                      // are merely marked.
                      color: sp.isSelf
                          ? const Color(0xFFFFD166)
                          : const Color(0xFF9B6DFF),
                      fontWeight: FontWeight.w700,
                    )
                  : null,
            ),
        ],
      ),
    );
  }

  Future<void> _send() async {
    final text = _input.text;
    if (text.trim().isEmpty) return;
    // Re-derived from the final text, not from what was picked: a name deleted
    // after selection must not still notify that person.
    final mentions = MentionText.survivingMentions(text, _pickedMentions);
    _input.clear();
    setState(() {
      _pickedMentions.clear();
      _mentionBoundary = 0;
      _mentionQuery = null;
    });
    await _chat.send(text, mentionedUserIds: mentions);
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
              // Directly above the composer: the choice is about the word under
              // the caret, so it belongs next to it. The picker hides itself
              // when nothing matches, so an '@' that means nothing costs no UI.
              if (_mentionQuery != null)
                MentionPicker(
                  candidates: _mentionMatches,
                  onSelected: _applyMention,
                ),
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
        final showDate = prev == null || !_sameDay(prev.createdAt, m.createdAt);
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
            style: GoogleFonts.inter(color: Colors.grey[500], fontSize: 10.sp)),
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
              // Media bubbles render their content instead of the body. A
              // voice note or image has no text, so the previous unconditional
              // Text painted an empty line where the media should be.
              if (m.kind == 'image')
                _imageBubble(m)
              else if (m.kind == 'voice')
                _voiceBubble(m)
              else
                _bodyWithMentions(m),
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
        return Icon(Icons.done_all,
            size: 13.sp, color: const Color(0xFF7DD3FC));
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
          if (!_isRecording)
            GestureDetector(
              onTap: _pickImage,
              child: Padding(
                padding: EdgeInsets.only(right: 6.w, bottom: 6.h),
                child: Icon(Icons.add_photo_alternate_outlined,
                    color: Colors.grey[500], size: 24.sp),
              ),
            ),
          if (_isRecording) _buildRecordingBar(),
          if (!_isRecording)
            Expanded(
              child: TextField(
                controller: _input,
                onChanged: (v) {
                  _chat.onTypingChanged(v);
                  _onComposerChanged(v);
                  final has = v.trim().isNotEmpty;
                  if (has != _hasText) setState(() => _hasText = has);
                },
                minLines: 1,
                maxLines: 5,
                textCapitalization: TextCapitalization.sentences,
                style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
                decoration: InputDecoration(
                  hintText: 'Message',
                  hintStyle: GoogleFonts.inter(
                      color: Colors.grey[600], fontSize: 14.sp),
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
          // Send when there is text to send, microphone when there is not.
          // One control rather than two: a composer with a permanently greyed
          // send button next to a mic reads as broken, and the p2p bar already
          // established this shape.
          GestureDetector(
            onTap: _hasText ? _send : _toggleRecording,
            child: Container(
              padding: EdgeInsets.all(11.w),
              decoration: BoxDecoration(
                color: _isRecording ? const Color(0xFFEF4444) : _mine,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _hasText
                    ? Icons.send_rounded
                    : (_isRecording ? Icons.stop_rounded : Icons.mic_rounded),
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Recording strip shown in place of the text field while capturing.
  ///
  /// Cancel is deliberately as prominent as send: a voice note recorded by
  /// accident, or one the user thinks better of, must be discardable without
  /// sending it to the whole group.
  Widget _buildRecordingBar() {
    final secs = _recordingDuration.inSeconds;
    final mm = (secs ~/ 60).toString().padLeft(2, '0');
    final ss = (secs % 60).toString().padLeft(2, '0');
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(color: const Color(0xFFEF4444)),
        ),
        child: Row(
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              decoration: const BoxDecoration(
                  color: Color(0xFFEF4444), shape: BoxShape.circle),
            ),
            SizedBox(width: 10.w),
            Text('$mm:$ss',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600)),
            const Spacer(),
            GestureDetector(
              onTap: _cancelRecording,
              child: Text('Cancel',
                  style: GoogleFonts.inter(
                      color: Colors.grey[400], fontSize: 13.sp)),
            ),
          ],
        ),
      ),
    );
  }

  // ── media capture ────────────────────────────────────────────────────
  //
  // Mirrors p2p_chat_input_bar, deliberately: that implementation carries a
  // hard-won Android fix (mono capture) and re-deriving it here would risk
  // re-introducing the bug it solved.

  Future<void> _pickImage() async {
    if (_isRecording) return;
    try {
      final picked = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        // Chat images are viewed on a phone; full-resolution originals cost
        // the sender's data and the group's load time for no visible gain.
        maxWidth: 1600,
        imageQuality: 85,
      );
      if (picked == null) return;
      await _chat.sendImage(File(picked.path));
    } catch (_) {
      _toast('Could not attach that image');
    }
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      await _stopRecording(send: true);
    } else {
      await _startRecording();
    }
  }

  Future<void> _startRecording() async {
    if (_isRecording) return;
    if (!await _recorder.hasPermission()) {
      _toast('Microphone permission is required for voice notes');
      return;
    }
    final dir = await getTemporaryDirectory();
    final path =
        '${dir.path}/group_voice_${DateTime.now().millisecondsSinceEpoch}.m4a';
    try {
      // Mono @44.1kHz, not the package default of stereo: Android's
      // AudioRecord silently fails to initialise in stereo on most mics, which
      // records an empty clip and makes voice notes "not send" on Android while
      // iOS works. Learned in the p2p chat; kept identical here.
      await _recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.aacLc,
          numChannels: 1,
          sampleRate: 44100,
          bitRate: 128000,
        ),
        path: path,
      );
    } catch (_) {
      _toast('Could not start recording. Please try again.');
      return;
    }
    if (!mounted) return;
    setState(() {
      _isRecording = true;
      _recordingDuration = Duration.zero;
    });
    _recordingTimer?.cancel();
    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _recordingDuration += const Duration(seconds: 1));
    });
  }

  Future<void> _cancelRecording() => _stopRecording(send: false);

  Future<void> _stopRecording({required bool send}) async {
    _recordingTimer?.cancel();
    _recordingTimer = null;
    final elapsed = _recordingDuration;
    String? path;
    try {
      path = await _recorder.stop();
    } catch (_) {
      // Fall through: the UI must leave the recording state regardless, or the
      // composer is stuck showing a timer that will never advance.
    }
    if (mounted) {
      setState(() {
        _isRecording = false;
        _recordingDuration = Duration.zero;
      });
    }
    if (!send || path == null || path.isEmpty) {
      if (path != null && path.isNotEmpty) {
        // Discarded: delete the clip rather than leaving it in temp.
        try {
          File(path).deleteSync();
        } catch (_) {}
      }
      return;
    }
    // A tap that lands as a sub-second clip is almost always an accident, and
    // an empty voice note in a group chat is pure noise.
    if (elapsed.inMilliseconds < 1000) {
      try {
        File(path).deleteSync();
      } catch (_) {}
      _toast('Hold to record a voice note');
      return;
    }
    await _chat.sendVoiceNote(File(path), durationMs: elapsed.inMilliseconds);
  }

  void _toast(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(message), backgroundColor: const Color(0xFFEF4444)),
    );
  }

  /// Image bubble.
  ///
  /// While a send is in flight the message still points at the LOCAL file, so
  /// the picture is visible immediately rather than appearing only after the
  /// upload completes.
  Widget _imageBubble(ContributionMessage m) {
    final url = m.mediaUrl;
    final isLocal = !url.startsWith('http');
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 220.h, maxWidth: 240.w),
        child: isLocal
            ? Image.file(File(url), fit: BoxFit.cover)
            : Image.network(
                url,
                fit: BoxFit.cover,
                loadingBuilder: (c, child, progress) => progress == null
                    ? child
                    : SizedBox(
                        height: 120.h,
                        width: 200.w,
                        child: const Center(child: LazerVaultLoader.small()),
                      ),
                // A broken image must not render as a red exception box in the
                // middle of a conversation.
                errorBuilder: (_, __, ___) => Container(
                  height: 120.h,
                  width: 200.w,
                  color: Colors.white10,
                  child: Center(
                    child: Icon(Icons.broken_image_outlined,
                        color: Colors.grey[500], size: 26.sp),
                  ),
                ),
              ),
      ),
    );
  }

  /// Voice-note bubble.
  ///
  /// Deliberately a play affordance plus a duration rather than a waveform:
  /// the duration is the one thing a listener wants before committing to
  /// playing something in a group chat, and it is already on the message.
  Widget _voiceBubble(ContributionMessage m) {
    final secs = (m.durationMs / 1000).round();
    final mm = (secs ~/ 60).toString().padLeft(2, '0');
    final ss = (secs % 60).toString().padLeft(2, '0');
    final playing = _playingMessageId == m.id && m.id.isNotEmpty;
    return GestureDetector(
      onTap: () => _toggleVoicePlayback(m),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(playing ? Icons.pause_circle_filled : Icons.play_circle_fill,
              color: Colors.white, size: 30.sp),
          SizedBox(width: 8.w),
          Icon(Icons.graphic_eq, color: Colors.white70, size: 18.sp),
          SizedBox(width: 8.w),
          Text('$mm:$ss',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp)),
        ],
      ),
    );
  }

  /// Plays or pauses a voice note.
  ///
  /// Only one note plays at a time — starting a second while the first is
  /// running would overlap two voices in the same conversation.
  Future<void> _toggleVoicePlayback(ContributionMessage m) async {
    final url = m.mediaUrl;
    if (url.isEmpty) return;
    try {
      if (_playingMessageId == m.id) {
        await _voicePlayer.stop();
        if (mounted) setState(() => _playingMessageId = null);
        return;
      }
      await _voicePlayer.stop();
      if (url.startsWith('http')) {
        await _voicePlayer.setUrl(url);
      } else {
        await _voicePlayer.setFilePath(url);
      }
      if (mounted) setState(() => _playingMessageId = m.id);
      await _voicePlayer.play();
      if (mounted && _playingMessageId == m.id) {
        setState(() => _playingMessageId = null);
      }
    } catch (_) {
      if (mounted) setState(() => _playingMessageId = null);
      _toast('Could not play that voice note');
    }
  }

  void _showMessageActions(ContributionMessage m, bool mine) {
    if (m.id.isEmpty) {
      // Still sending (or failed) — the only useful action is a retry.
      // Media retries re-upload the local file; the text path re-posts a body,
      // so sending a media bubble down it would post an empty message.
      if (m.status == ChatDeliveryStatus.failed) {
        if (m.kind == 'image' || m.kind == 'voice') {
          _chat.retryMedia(m);
        } else {
          _chat.retry(m);
        }
      }
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

  Widget _action(
      BuildContext ctx, IconData icon, String label, VoidCallback onTap,
      {bool danger = false}) {
    final color = danger ? const Color(0xFFEF4444) : Colors.white;
    return ListTile(
      leading: Icon(icon, color: color, size: 20.sp),
      title:
          Text(label, style: GoogleFonts.inter(color: color, fontSize: 14.sp)),
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
