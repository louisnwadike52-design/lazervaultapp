part of 'spray_room_screen.dart';

/// The main spray room - TikTok-like full-screen immersive experience.
/// Shows host avatar/image, real-time spray animations, gift effects,
/// like counter, comments, and action buttons.
///
/// Thin wrapper that provides [SprayLiveCubit] ABOVE the stateful view, so the
/// view's State.context can `read` it from anywhere (including modal sheets) —
/// providing it inside the view's own build() would make State.context an
/// ancestor of the provider → ProviderNotFound on `context.read`.
class SprayRoomScreen extends StatelessWidget {
  final String sessionId;
  final String accessToken;

  const SprayRoomScreen({
    super.key,
    required this.sessionId,
    required this.accessToken,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SprayLiveCubit>(
      create: (_) => serviceLocator<SprayLiveCubit>(),
      child: _SprayRoomView(sessionId: sessionId, accessToken: accessToken),
    );
  }
}

class _SprayRoomView extends StatefulWidget {
  final String sessionId;
  final String accessToken;

  const _SprayRoomView({
    required this.sessionId,
    required this.accessToken,
  });

  @override
  State<_SprayRoomView> createState() => _SprayRoomViewState();
}

// ─── Inline Live Event Item (for non-comment mode) ──────────────

class _LiveEventItem extends StatefulWidget {
  final SprayRoomEvent event;
  final String currency;

  const _LiveEventItem({
    super.key,
    required this.event,
    required this.currency,
  });

  @override
  State<_LiveEventItem> createState() => _LiveEventItemState();
}

class _LiveEventItemState extends State<_LiveEventItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _slide = Tween<Offset>(
      begin: const Offset(-0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    final (message, emoji, nameColor) = _parseEvent(event);
    if (message.isEmpty) return const SizedBox.shrink();

    return SlideTransition(
      position: _slide,
      child: FadeTransition(
        opacity: _fade,
        child: Container(
          margin: EdgeInsets.only(bottom: 4.h),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 12.r,
                backgroundColor: nameColor.withValues(alpha: 0.3),
                child: Icon(
                  event.type == 'gift_sent' ? Icons.card_giftcard :
                  event.type == 'money_sprayed' ? Icons.monetization_on :
                  event.type == 'participant_joined' ? Icons.person_add :
                  Icons.info_outline,
                  size: 12.sp, color: Colors.white,
                ),
              ),
              SizedBox(width: 6.w),
              Flexible(
                child: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: event.senderName.isNotEmpty
                            ? event.senderName
                            : 'Guest',
                        style: TextStyle(
                          color: nameColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' $message',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 12.sp,
                        ),
                      ),
                      if (emoji.isNotEmpty)
                        TextSpan(
                          text: ' $emoji',
                          style: TextStyle(fontSize: 14.sp),
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

  (String message, String emoji, Color nameColor) _parseEvent(SprayRoomEvent event) {
    switch (event.type) {
      case 'gift_sent':
        final giftEmoji = event.data['gift_emoji'] as String? ?? '';
        final giftName = event.data['gift_name'] as String? ?? 'gift';
        final qty = (event.data['quantity'] as num?)?.toInt() ?? 1;
        return (
          'lazersprayed a $giftName${qty > 1 ? ' x$qty' : ''}',
          giftEmoji,
          const Color(0xFFFFD700),
        );
      case 'money_sprayed':
        final amount = ((event.data['total_amount'] as num?) ?? 0) / 100;
        return (
          'lazersprayed ${widget.currency} ${amount.toStringAsFixed(0)}',
          '\u{1F4B5}',
          const Color(0xFF34D399),
        );
      case 'participant_joined':
        return ('joined', '\u{1F44B}', const Color(0xFF60A5FA));
      case 'participant_left':
        return ('left the room', '', const Color(0xFF9CA3AF));
      case 'session_ended':
        return ('Session ended', '\u{1F3C1}', const Color(0xFFEF4444));
      default:
        return ('', '', Colors.white);
    }
  }
}

// ─── Spray Note Animation ───────────────────────────────────────

class _SprayNoteAnimation extends StatefulWidget {
  final String text;
  final double startX;
  final VoidCallback onComplete;

  const _SprayNoteAnimation({
    super.key,
    required this.text,
    required this.startX,
    required this.onComplete,
  });

  @override
  State<_SprayNoteAnimation> createState() => _SprayNoteAnimationState();
}

class _SprayNoteAnimationState extends State<_SprayNoteAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final _random = Random();
  late final double _rotateEnd;
  late final double _driftX;

  @override
  void initState() {
    super.initState();
    _rotateEnd = (_random.nextDouble() - 0.5) * 1.5;
    _driftX = (_random.nextDouble() - 0.5) * 100;

    _controller = AnimationController(
      duration: Duration(milliseconds: 1200 + _random.nextInt(600)),
      vsync: this,
    );
    _controller.forward().then((_) => widget.onComplete());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final progress = _controller.value;
        final y = screenSize.height * 0.5 - progress * screenSize.height * 0.6;
        final x = screenSize.width * widget.startX + _driftX * progress;
        final opacity = progress < 0.7 ? 1.0 : (1.0 - (progress - 0.7) / 0.3);
        final rotate = _rotateEnd * progress;
        final scale = progress < 0.15 ? progress / 0.15 : 1.0 - (progress - 0.15) * 0.3;

        return Positioned(
          left: x,
          top: y,
          child: Opacity(
            opacity: opacity.clamp(0.0, 1.0),
            child: Transform.rotate(
              angle: rotate,
              child: Transform.scale(
                scale: scale.clamp(0.3, 1.5),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF10B981).withValues(alpha: 0.4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─── Stats Sheet ────────────────────────────────────────────────

class _StatsSheet extends StatelessWidget {
  final SprayRoomState state;

  const _StatsSheet({required this.state});

  @override
  Widget build(BuildContext context) {
    final currency = state.session?.currency ?? 'NGN';
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFF9CA3AF).withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Session Stats',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),

            // Total Worth (prominent)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1A1A3E), Color(0xFF0D1B2A)],
                ),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFFFFD700).withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Text(
                    'Total Worth',
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 11.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '$currency ${_formatAmount(state.totalWorthMajor)}',
                    style: TextStyle(
                      color: const Color(0xFFFFD700),
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Cash: $currency ${_formatAmount(state.totalSprayedMajor)} + Gifts: $currency ${_formatAmount(state.totalGiftsValueMajor)}',
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),

            // Stats grid — compact
            Row(
              children: [
                _buildStatCard(
                  icon: Icons.monetization_on,
                  value: '$currency ${_formatAmount(state.totalSprayedMajor)}',
                  label: 'Cash Sprayed',
                  color: const Color(0xFF10B981),
                ),
                SizedBox(width: 8.w),
                _buildStatCard(
                  icon: Icons.card_giftcard,
                  value: '${state.totalGiftsCount}',
                  label: 'Gifts Sent',
                  color: const Color(0xFFFFD700),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                _buildStatCard(
                  icon: Icons.favorite,
                  value: _formatCount(state.totalLikeTaps),
                  label: 'Likes',
                  color: const Color(0xFFFF1744),
                ),
                SizedBox(width: 8.w),
                _buildStatCard(
                  icon: Icons.people,
                  value: '${state.participantCount}',
                  label: 'Participants',
                  color: const Color(0xFF3B82F6),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                _buildStatCard(
                  icon: Icons.chat_bubble,
                  value: '${state.comments.length}',
                  label: 'Comments',
                  color: const Color(0xFF60A5FA),
                ),
                SizedBox(width: 8.w),
                _buildStatCard(
                  icon: Icons.account_balance_wallet,
                  value: '$currency ${state.walletBalanceMajor.toStringAsFixed(0)}',
                  label: 'Your Wallet',
                  color: const Color(0xFF10B981),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            _buildLeaderboard(currency),
          ],
        ),
      ),
    );
  }

  // ── Top-sprayer leaderboard ──
  Widget _buildLeaderboard(String currency) {
    if (state.topSprayers.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.emoji_events, color: const Color(0xFFFFD700), size: 16.sp),
            SizedBox(width: 6.w),
            Text(
              'Top Sprayers',
              style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ...state.topSprayers.take(10).map((s) => _leaderboardRow(s, currency)),
      ],
    );
  }

  Widget _leaderboardRow(dynamic s, String currency) {
    final rank = s.rank as int;
    final name = (s.userName as String).isNotEmpty ? s.userName as String : 'Guest';
    final amountMajor = (s.totalAmount as int) / 100;
    Color rankColor;
    switch (rank) {
      case 1:
        rankColor = const Color(0xFFFFD700);
        break;
      case 2:
        rankColor = const Color(0xFFC0C0C0);
        break;
      case 3:
        rankColor = const Color(0xFFCD7F32);
        break;
      default:
        rankColor = const Color(0xFF9CA3AF);
    }
    return Container(
      margin: EdgeInsets.only(bottom: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(10.r),
        border: rank <= 3 ? Border.all(color: rankColor.withValues(alpha: 0.5)) : null,
      ),
      child: Row(
        children: [
          Container(
            width: 24.w,
            height: 24.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: rankColor.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Text('$rank',
                style: TextStyle(color: rankColor, fontSize: 12.sp, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 10.w),
          CircleAvatar(
            radius: 12.r,
            backgroundColor: const Color(0xFF3B82F6),
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : '?',
              style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              name,
              style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            '$currency ${_formatAmount(amountMajor)}',
            style: TextStyle(color: const Color(0xFFFFD700), fontSize: 13.sp, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20.sp),
            SizedBox(height: 4.h),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatAmount(double amount) {
    if (amount >= 1000000) return '${(amount / 1000000).toStringAsFixed(1)}M';
    if (amount >= 1000) return '${(amount / 1000).toStringAsFixed(amount % 1000 == 0 ? 0 : 1)}K';
    return amount.toStringAsFixed(0);
  }

  String _formatCount(int count) {
    if (count >= 1000000) return '${(count / 1000000).toStringAsFixed(1)}M';
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}K';
    return count.toString();
  }
}

// ─── Viewers (participant list) Sheet ───────────────────────────

class _ViewersSheet extends StatelessWidget {
  final SprayRoomState state;

  const _ViewersSheet({required this.state});

  @override
  Widget build(BuildContext context) {
    final currency = state.session?.currency ?? 'NGN';
    // Host first, then by amount sprayed.
    final viewers = [...state.participants]
      ..sort((a, b) {
        if (a.isHost != b.isHost) return a.isHost ? -1 : 1;
        return b.totalSprayed.compareTo(a.totalSprayed);
      });
    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFF9CA3AF).withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.people, color: const Color(0xFF3B82F6), size: 18.sp),
                SizedBox(width: 6.w),
                Text(
                  'Viewers (${state.participantCount})',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            if (viewers.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: Text('No viewers yet',
                    style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 13.sp)),
              )
            else
              Flexible(
                child: ListView.separated(
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
                  shrinkWrap: true,
                  itemCount: viewers.length,
                  separatorBuilder: (_, __) => SizedBox(height: 8.h),
                  itemBuilder: (_, i) => _viewerRow(viewers[i], currency),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _viewerRow(dynamic p, String currency) {
    final name = (p.userName as String).isNotEmpty ? p.userName as String : 'Guest';
    final isHost = p.isHost as bool;
    final sprayedMajor = (p.totalSprayed as int) / 100;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 16.r,
                backgroundColor: isHost ? const Color(0xFFFFD700) : const Color(0xFF3B82F6),
                child: Text(
                  name.isNotEmpty ? name[0].toUpperCase() : '?',
                  style: TextStyle(
                      color: isHost ? Colors.black : Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              if (p.isOnline as bool)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 9.w,
                    height: 9.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF2D2D2D), width: 1.5),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    name,
                    style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isHost) ...[
                  SizedBox(width: 6.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD700).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text('HOST',
                        style: TextStyle(
                            color: const Color(0xFFFFD700), fontSize: 9.sp, fontWeight: FontWeight.bold)),
                  ),
                ],
              ],
            ),
          ),
          if ((p.totalSprayed as int) > 0)
            Text(
              '$currency ${sprayedMajor >= 1000 ? '${(sprayedMajor / 1000).toStringAsFixed(1)}K' : sprayedMajor.toStringAsFixed(0)}',
              style: TextStyle(color: const Color(0xFF10B981), fontSize: 12.sp, fontWeight: FontWeight.w600),
            ),
        ],
      ),
    );
  }
}

// ─── AI Chat Sheet ──────────────────────────────────────────────

class _AIChatSheet extends StatefulWidget {
  final SprayRoomState state;
  final ScrollController scrollController;
  final String sessionId;
  final String accessToken;

  const _AIChatSheet({
    required this.state,
    required this.scrollController,
    required this.sessionId,
    required this.accessToken,
  });

  @override
  State<_AIChatSheet> createState() => _AIChatSheetState();
}
