import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/src/features/sprayme/domain/entities/spray_comment.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_session.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_stats.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_transaction.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/session_participant.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/sprayme_cubit.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/sprayme_state.dart';
import 'package:lazervault/src/features/sprayme/presentation/screens/create_session_screen.dart' show OccasionTheme;

/// Comprehensive session detail screen showing all activity for a past session.
/// Displays transactions, comments, participants, and stats for both created and joined sessions.
class SessionDetailScreen extends StatefulWidget {
  final String sessionId;
  final SpraySession? session; // Optional: if already loaded

  const SessionDetailScreen({
    super.key,
    required this.sessionId,
    this.session,
  });

  @override
  State<SessionDetailScreen> createState() => _SessionDetailScreenState();
}

class _SessionDetailScreenState extends State<SessionDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  SpraySession? _session;
  SessionStats? _stats;
  List<SprayTransaction> _transactions = [];
  List<SprayComment> _comments = [];
  List<SessionParticipant> _participants = [];
  bool _isLoading = true;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
    _session = widget.session;
    _loadData();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    _commentInputController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      setState(() => _selectedTabIndex = _tabController.index);
    }
  }

  // Track how many data loads have completed to know when loading is done
  int _pendingLoads = 0;

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final cubit = context.read<SprayMeCubit>();

    _pendingLoads = 0;

    // Load session if not provided
    if (_session == null) {
      _pendingLoads++;
      cubit.getSession(widget.sessionId);
    }

    // Load stats, transactions, comments, participants in parallel
    _pendingLoads += 4;
    cubit.loadSessionStats(widget.sessionId);
    cubit.loadSessionTransactions(widget.sessionId);
    cubit.loadComments(widget.sessionId);
    cubit.loadParticipants(widget.sessionId);
  }

  void _onLoadCompleted() {
    _pendingLoads--;
    if (_pendingLoads <= 0) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _refresh() async {
    // Preserve tab position on refresh
    await _loadData();
  }

  String _formatAmount(double amount) {
    if (amount >= 1000000) return '${(amount / 1000000).toStringAsFixed(1)}M';
    if (amount >= 1000) return '${(amount / 1000).toStringAsFixed(amount % 1000 == 0 ? 0 : 1)}K';
    return amount.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    final currency = _session?.currency ?? 'NGN';

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: BlocConsumer<SprayMeCubit, SprayMeState>(
        listener: (context, state) {
          if (state is SessionLoaded) {
            setState(() => _session = state.session);
            _onLoadCompleted();
          } else if (state is SessionStatsLoaded) {
            setState(() => _stats = state.stats);
            _onLoadCompleted();
          } else if (state is TransactionsLoaded) {
            setState(() => _transactions = state.transactions);
            _onLoadCompleted();
          } else if (state is CommentsLoaded) {
            setState(() => _comments = state.comments);
            _onLoadCompleted();
          } else if (state is ParticipantsLoaded) {
            setState(() => _participants = state.participants);
            _onLoadCompleted();
          } else if (state is SprayMeError) {
            _onLoadCompleted();
          }
        },
        builder: (context, state) {
          if (_isLoading && state is SprayMeLoading) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF3B82F6)));
          }

          if (_session == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48.sp, color: const Color(0xFF9CA3AF)),
                  SizedBox(height: 12.h),
                  Text('Session not found', style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: _refresh,
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6)),
                    child: const Text('Retry', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              // App Bar with session info
              SliverAppBar(
                expandedHeight: 180.h,
                pinned: true,
                backgroundColor: const Color(0xFF0A0A0A),
                flexibleSpace: FlexibleSpaceBar(
                  background: _buildHeader(currency),
                ),
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                actions: [
                  IconButton(
                    onPressed: _refresh,
                    icon: const Icon(Icons.refresh, color: Colors.white),
                  ),
                ],
              ),

              // Stats Row
              SliverToBoxAdapter(
                child: _buildStatsRow(currency),
              ),

              // Tabs
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverTabBarDelegate(
                  TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF7C3AED), Color(0xFF9333EA)],
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.white,
                    unselectedLabelColor: const Color(0xFF9CA3AF),
                    labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                    unselectedLabelStyle: TextStyle(fontSize: 13.sp),
                    tabs: const [
                      Tab(text: 'Activity'),
                      Tab(text: 'Comments'),
                      Tab(text: 'Participants'),
                    ],
                  ),
                ),
              ),

              // Tab Content
              SliverFillRemaining(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildActivityTab(currency),
                    _buildCommentsTab(),
                    _buildParticipantsTab(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(String currency) {
    final occasionColors = OccasionTheme.getGradient(_session!.occasionType);
    final occasionIcon = OccasionTheme.getIcon(_session!.occasionType);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            occasionColors[0].withOpacity(0.3),
            const Color(0xFF0A0A0A),
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Occasion icon
              Container(
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: occasionColors),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: occasionColors[0].withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(occasionIcon, color: Colors.white, size: 28.sp),
              ),
              SizedBox(height: 16.h),
              // Title
              Text(
                _session!.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 6.h),
              // Meta info
              Row(
                children: [
                  _buildMetaChip(
                    Icons.person_outline,
                    _session!.hostName,
                    const Color(0xFF3B82F6),
                  ),
                  SizedBox(width: 8.w),
                  _buildMetaChip(
                    Icons.calendar_today_outlined,
                    _formatDate(_session!.createdAt),
                    const Color(0xFF9CA3AF),
                  ),
                  SizedBox(width: 8.w),
                  _buildMetaChip(
                    Icons.code,
                    _session!.sessionCode,
                    const Color(0xFF10B981),
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: _session!.sessionCode));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Code ${_session!.sessionCode} copied!'),
                          backgroundColor: const Color(0xFF10B981),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ],
              ),
              if (_session!.description.isNotEmpty) ...[
                SizedBox(height: 10.h),
                Text(
                  _session!.description,
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetaChip(IconData icon, String label, Color color, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 13.sp),
            SizedBox(width: 4.w),
            Text(
              label,
              style: TextStyle(color: color, fontSize: 12.sp, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow(String currency) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              Icons.monetization_on,
              _formatAmount((_session!.totalSprayed / 100).toDouble()),
              currency,
              const Color(0xFF10B981),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: _buildStatCard(
              Icons.card_giftcard,
              _session!.totalGifts.toString(),
              'Gifts',
              const Color(0xFFFFD700),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: _buildStatCard(
              Icons.favorite,
              _session!.totalLikes.toString(),
              'Likes',
              const Color(0xFFFF1744),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String value, String label, Color color) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20.sp),
          SizedBox(height: 6.h),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTab(String currency) {
    if (_transactions.isEmpty) {
      return _buildEmpty('No activity yet', 'Start spraying to see activity here');
    }

    return ListView.separated(
      padding: EdgeInsets.all(16.w),
      itemCount: _transactions.length,
      separatorBuilder: (_, __) => SizedBox(height: 8.h),
      itemBuilder: (context, index) {
        return _buildTransactionCard(_transactions[index], currency);
      },
    );
  }

  Widget _buildTransactionCard(SprayTransaction tx, String currency) {
    IconData icon;
    Color color;
    String title;
    String subtitle;

    switch (tx.type) {
      case 'gift':
        icon = Icons.card_giftcard;
        color = const Color(0xFFFFD700);
        title = '${tx.giftEmoji ?? ""} ${tx.giftName ?? "Gift"} x${tx.quantity}';
        subtitle = '${tx.senderName} → ${tx.recipientName}';
      case 'money_spray':
        icon = Icons.monetization_on;
        color = const Color(0xFF10B981);
        title = 'Money Spray';
        subtitle = '${tx.senderName} sprayed $currency ${tx.amountMajor.toStringAsFixed(0)}';
      case 'like':
        icon = Icons.favorite;
        color = const Color(0xFFFF1744);
        title = 'Like';
        subtitle = tx.senderName;
      case 'fund_wallet':
        icon = Icons.add_circle;
        color = const Color(0xFF3B82F6);
        title = 'Wallet Funded';
        subtitle = tx.reference;
      case 'withdraw_wallet':
        icon = Icons.remove_circle;
        color = const Color(0xFFFB923C);
        title = 'Wallet Withdrawal';
        subtitle = tx.reference;
      default:
        icon = Icons.receipt;
        color = const Color(0xFF9CA3AF);
        title = tx.type;
        subtitle = tx.reference;
    }

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: color, size: 22.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (tx.amount > 0)
            Text(
              '$currency ${tx.amountMajor.toStringAsFixed(0)}',
              style: TextStyle(
                color: color,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }

  final _commentInputController = TextEditingController();
  bool _isSendingComment = false;

  void _submitComment() {
    final text = _commentInputController.text.trim();
    if (text.isEmpty || _isSendingComment) return;
    setState(() => _isSendingComment = true);
    context.read<SprayMeCubit>().addComment(
      sessionId: widget.sessionId,
      text: text,
    );
    _commentInputController.clear();
    // Reset after a short delay (comment will appear via reload)
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) setState(() => _isSendingComment = false);
    });
  }

  Widget _buildCommentsTab() {
    return Column(
      children: [
        Expanded(
          child: _comments.isEmpty
              ? _buildEmpty('No comments yet', 'Be the first to comment!')
              : ListView.separated(
                  padding: EdgeInsets.all(16.w),
                  itemCount: _comments.length,
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemBuilder: (context, index) {
                    return _buildCommentCard(_comments[index]);
                  },
                ),
        ),
        // Comment input bar
        Container(
          padding: EdgeInsets.fromLTRB(
            12.w, 8.h, 12.w,
            MediaQuery.of(context).viewInsets.bottom + 12.h,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFF111111),
            border: Border(top: BorderSide(color: Color(0xFF2D2D2D))),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 38.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(19.r),
                    border: Border.all(color: const Color(0xFF2D2D2D)),
                  ),
                  child: TextField(
                    controller: _commentInputController,
                    maxLength: 500,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    onSubmitted: (_) => _submitComment(),
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: 'Add a comment...',
                      hintStyle: TextStyle(
                        color: Colors.white.withValues(alpha: 0.4),
                        fontSize: 13.sp,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                    ),
                    textInputAction: TextInputAction.send,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: _isSendingComment ? null : _submitComment,
                child: Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: BoxDecoration(
                    color: _isSendingComment
                        ? const Color(0xFF3B82F6).withValues(alpha: 0.4)
                        : const Color(0xFF3B82F6),
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

  Widget _buildCommentCard(SprayComment comment) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: const Color(0xFF3B82F6),
            backgroundImage: comment.avatarUrl.isNotEmpty
                ? NetworkImage(comment.avatarUrl)
                : null,
            child: comment.avatarUrl.isEmpty
                ? Icon(Icons.person, size: 18.sp, color: Colors.white)
                : null,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.userName.isNotEmpty ? comment.userName : 'User',
                  style: TextStyle(
                    color: const Color(0xFF60A5FA),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  comment.text,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  _formatDate(comment.createdAt),
                  style: TextStyle(
                    color: const Color(0xFF6B7280),
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantsTab() {
    if (_participants.isEmpty) {
      return _buildEmpty('No participants yet', 'Sessions will show participants here');
    }

    return GridView.builder(
      padding: EdgeInsets.all(16.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 0.75,
      ),
      itemCount: _participants.length,
      itemBuilder: (context, index) {
        return _buildParticipantCard(_participants[index]);
      },
    );
  }

  Widget _buildParticipantCard(SessionParticipant participant) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundColor: const Color(0xFF3B82F6),
            backgroundImage: participant.avatarUrl.isNotEmpty
                ? NetworkImage(participant.avatarUrl)
                : null,
            child: participant.avatarUrl.isEmpty
                ? Icon(Icons.person, size: 24.sp, color: Colors.white)
                : null,
          ),
          SizedBox(height: 8.h),
          Text(
            participant.userName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          if (participant.totalSprayed > 0) ...[
            SizedBox(height: 4.h),
            Text(
              '${_session?.currency ?? 'NGN'} ${(participant.totalSprayed / 100).toStringAsFixed(0)}',
              style: TextStyle(
                color: const Color(0xFF10B981),
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmpty(String title, String subtitle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.hourglass_empty, size: 48.sp, color: const Color(0xFF9CA3AF)),
          SizedBox(height: 12.h),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: TextStyle(color: const Color(0xFF6B7280), fontSize: 13.sp),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays > 7) {
      return '${date.day}/${date.month}/${date.year}';
    } else if (diff.inDays > 0) {
      return '${diff.inDays}d ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours}h ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverTabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color(0xFF0A0A0A),
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}
