part of 'spray_room_screen.dart';

class _AIChatSheetState extends State<_AIChatSheet> {
  final _inputController = TextEditingController();
  final List<_ChatMessage> _messages = [];
  bool _isLoading = false;
  late final SprayMeChatService _chatService;
  bool _useBackend = true; // Try backend first, fallback to local

  @override
  void initState() {
    super.initState();
    _chatService = serviceLocator<SprayMeChatService>();
    // Welcome message
    _messages.add(_ChatMessage(
      text: 'Ask me anything about this Lazerspray session! Try:\n'
          '\u2022 "Who sprayed the most?"\n'
          '\u2022 "What\'s the total amount sprayed?"\n'
          '\u2022 "Show me gift rankings"\n'
          '\u2022 "How many participants?"',
      isBot: true,
    ));
    // Load chat history from backend
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    try {
      final history = await _chatService.getHistory(
        sessionId: 'sprayme_${widget.sessionId}',
        limit: 20,
      );
      if (mounted && history.isNotEmpty) {
        setState(() {
          // Insert history before the welcome message
          for (final msg in history) {
            _messages.add(_ChatMessage(
              text: msg.content,
              isBot: msg.role == 'assistant',
            ));
          }
        });
      }
    } catch (_) {
      // History fetch is non-fatal
    }
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final text = _inputController.text.trim();
    if (text.isEmpty || _isLoading) return;

    setState(() {
      _messages.add(_ChatMessage(text: text, isBot: false));
      _isLoading = true;
    });
    _inputController.clear();

    if (_useBackend) {
      try {
        final response = await _chatService.sendMessage(
          message: text,
          sessionId: 'sprayme_${widget.sessionId}',
        );
        if (mounted) {
          setState(() {
            _messages.add(_ChatMessage(text: response.response, isBot: true));
            _isLoading = false;
          });
        }
        return;
      } catch (_) {
        // Backend failed for THIS message only — fall back locally but keep
        // trying the real gateway on the next message (a transient error must
        // not permanently downgrade the whole session to canned responses).
      }
    }

    // Local fallback (last resort)
    final response = _generateLocalResponse(text, widget.state);
    if (mounted) {
      setState(() {
        _messages.add(_ChatMessage(text: response, isBot: true));
        _isLoading = false;
      });
    }
  }

  String _generateLocalResponse(String query, SprayRoomState state) {
    final q = query.toLowerCase();
    final currency = state.session?.currency ?? 'NGN';

    if (q.contains('total') && (q.contains('spray') || q.contains('amount') || q.contains('worth'))) {
      return 'Total session worth: $currency ${_fmt(state.totalWorthMajor)}\n'
          '\u2022 Cash sprayed: $currency ${_fmt(state.totalSprayedMajor)}\n'
          '\u2022 Gifts value: $currency ${_fmt(state.totalGiftsValueMajor)}\n'
          '\u2022 Total gifts sent: ${state.totalGiftsCount}\n'
          '\u2022 Total likes: ${state.totalLikes}';
    }

    if (q.contains('participant') || q.contains('how many people') || q.contains('who joined') || q.contains('attendees')) {
      return 'There are currently ${state.participantCount} participants in this session.\n\n'
          'Host: ${state.session?.hostName ?? "Unknown"}';
    }

    if (q.contains('gift') && (q.contains('most') || q.contains('ranking') || q.contains('top') || q.contains('popular'))) {
      if (state.totalGiftsCount == 0) {
        return 'No gifts have been sent yet in this session. Be the first to lazerspray a gift!';
      }
      return 'Gift stats for this session:\n'
          '\u2022 Total gifts sent: ${state.totalGiftsCount}\n'
          '\u2022 Total gift value: $currency ${_fmt(state.totalGiftsValueMajor)}\n\n'
          'Check the live event feed for details on who sent what!';
    }

    if (q.contains('who') && (q.contains('most') || q.contains('top') || q.contains('highest') || q.contains('ranking'))) {
      final sprayEvents = state.recentEvents.where((e) =>
        e.type == 'gift_sent' || e.type == 'money_sprayed'
      ).toList();

      if (sprayEvents.isEmpty) {
        return 'No spray activity yet! Be the first to lazerspray in this session.';
      }

      final senderTotals = <String, int>{};
      final senderNames = <String, String>{};
      for (final event in sprayEvents) {
        final senderId = event.senderId;
        final name = event.senderName.isNotEmpty ? event.senderName : 'Guest';
        senderNames[senderId] = name;
        final amount = event.type == 'gift_sent'
            ? (event.data['amount'] as num?)?.toInt() ?? 0
            : (event.data['total_amount'] as num?)?.toInt() ?? 0;
        senderTotals[senderId] = (senderTotals[senderId] ?? 0) + amount;
      }

      final sorted = senderTotals.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      final rankings = sorted.take(5).toList();
      final buffer = StringBuffer('Top sprayers (from recent activity):\n');
      for (int i = 0; i < rankings.length; i++) {
        final entry = rankings[i];
        final medal = i == 0 ? '\u{1F947}' : i == 1 ? '\u{1F948}' : i == 2 ? '\u{1F949}' : '${i + 1}.';
        buffer.writeln('$medal ${senderNames[entry.key]} - $currency ${_fmt(entry.value / 100)}');
      }
      return buffer.toString().trim();
    }

    if (q.contains('like') || q.contains('love') || q.contains('heart')) {
      return 'This session has received ${state.totalLikes} likes so far!';
    }

    if (q.contains('comment')) {
      return 'There are ${state.comments.length} comments in this session.';
    }

    if (q.contains('wallet') || q.contains('balance') || q.contains('my money')) {
      return 'Your Lazerspray wallet balance: $currency ${state.walletBalanceMajor.toStringAsFixed(0)}';
    }

    if (q.contains('session') || q.contains('info') || q.contains('details') || q.contains('about')) {
      return 'Session: ${state.session?.title ?? "N/A"}\n'
          'Host: ${state.session?.hostName ?? "N/A"}\n'
          'Occasion: ${state.session?.occasionType ?? "N/A"}\n'
          'Code: ${state.session?.sessionCode ?? "N/A"}\n'
          'Status: ${state.sessionEnded ? "Ended" : "Active"}\n'
          'Participants: ${state.participantCount}';
    }

    return 'Here\'s what I can help with:\n'
        '\u2022 "Total amount sprayed" - Session totals\n'
        '\u2022 "Who sprayed the most?" - Top sprayer rankings\n'
        '\u2022 "Gift rankings" - Gift statistics\n'
        '\u2022 "How many participants?" - Attendee count\n'
        '\u2022 "Session info" - Session details\n'
        '\u2022 "My wallet balance" - Your balance\n'
        '\u2022 "How many likes?" - Like count\n'
        '\u2022 "Comments count" - Comment stats';
  }

  String _fmt(double amount) {
    if (amount >= 1000000) return '${(amount / 1000000).toStringAsFixed(1)}M';
    if (amount >= 1000) return '${(amount / 1000).toStringAsFixed(amount % 1000 == 0 ? 0 : 1)}K';
    return amount.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Handle
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xFF9CA3AF).withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        ),

        // Title
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Icon(Icons.smart_toy_outlined, color: const Color(0xFF7C3AED), size: 22.sp),
              SizedBox(width: 8.w),
              Text(
                'Lazerspray AI',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'LIVE',
                  style: TextStyle(
                    color: const Color(0xFF10B981),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Divider(color: const Color(0xFF2D2D2D), height: 1),

        // Messages
        Expanded(
          child: ListView.builder(
            controller: widget.scrollController,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            itemCount: _messages.length + (_isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _messages.length) {
                return _buildTypingIndicator();
              }
              return _buildMessageBubble(_messages[index]);
            },
          ),
        ),

        // Input bar
        Container(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, MediaQuery.of(context).viewInsets.bottom + 12.h),
          decoration: const BoxDecoration(
            color: Color(0xFF111111),
            border: Border(top: BorderSide(color: Color(0xFF2D2D2D))),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 40.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: const Color(0xFF2D2D2D)),
                  ),
                  child: TextField(
                    controller: _inputController,
                    onSubmitted: (_) => _sendMessage(),
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    decoration: InputDecoration(
                      hintText: 'Ask about this session...',
                      hintStyle: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                    ),
                    textInputAction: TextInputAction.send,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: _sendMessage,
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFF7C3AED),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.send, color: Colors.white, size: 18.sp),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessageBubble(_ChatMessage message) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: message.isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (message.isBot) ...[
            CircleAvatar(
              radius: 14.r,
              backgroundColor: const Color(0xFF7C3AED).withValues(alpha: 0.2),
              child: Icon(Icons.smart_toy, size: 14.sp, color: const Color(0xFF7C3AED)),
            ),
            SizedBox(width: 8.w),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: message.isBot
                    ? const Color(0xFF1F1F1F)
                    : const Color(0xFF7C3AED).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: message.isBot
                      ? const Color(0xFF2D2D2D)
                      : const Color(0xFF7C3AED).withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 13.sp,
                  height: 1.4,
                ),
              ),
            ),
          ),
          if (!message.isBot) SizedBox(width: 8.w),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14.r,
            backgroundColor: const Color(0xFF7C3AED).withValues(alpha: 0.2),
            child: Icon(Icons.smart_toy, size: 14.sp, color: const Color(0xFF7C3AED)),
          ),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDot(0),
                SizedBox(width: 4.w),
                _buildDot(1),
                SizedBox(width: 4.w),
                _buildDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + index * 200),
      builder: (context, value, child) {
        return Container(
          width: 6.w,
          height: 6.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF9CA3AF).withValues(alpha: 0.3 + value * 0.5),
          ),
        );
      },
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isBot;

  const _ChatMessage({required this.text, required this.isBot});
}
