import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_session.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/sprayme_cubit.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/sprayme_state.dart';
import 'package:lazervault/src/features/sprayme/presentation/screens/spray_room_screen.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/spray_room_cubit.dart';
import 'package:lazervault/src/features/sprayme/presentation/screens/session_detail_screen.dart';
import 'package:lazervault/src/features/sprayme/presentation/screens/create_session_screen.dart' show OccasionTheme, CreateSessionScreen;
import 'package:lazervault/src/features/sprayme/presentation/screens/join_session_screen.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// My Sessions Screen - shows sessions created by user and sessions they joined
/// with tabs for "Created" and "Joined", pagination, and navigation to session details/stats
class MySessionsScreen extends StatefulWidget {
  const MySessionsScreen({super.key});

  @override
  State<MySessionsScreen> createState() => _MySessionsScreenState();
}

class _MySessionsScreenState extends State<MySessionsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // State for each tab
  final List<SpraySession> _createdSessions = [];
  final List<SpraySession> _joinedSessions = [];

  // Pagination state
  int _createdPage = 1;
  int _joinedPage = 1;
  bool _createdHasMore = true;
  bool _joinedHasMore = true;
  bool _createdLoading = false;
  bool _joinedLoading = false;

  // Initial load state
  bool _isLoadingInitial = true;
  String? _errorMessage;

  // Current user id — used to tell a session I HOST from one I merely joined,
  // so an own active session offers a "Re-enter" (host) CTA vs "Join".
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadCurrentUserId();
    _loadInitialSessions();
  }

  Future<void> _loadCurrentUserId() async {
    final id = await serviceLocator<SecureStorageService>().getUserId();
    if (mounted) setState(() => _currentUserId = id);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Track which tab's data we're loading for — 'created' or 'joined'
  String _currentLoadFilter = 'created';
  bool _loadingMore = false;

  Future<void> _loadInitialSessions() async {
    setState(() {
      _isLoadingInitial = true;
      _errorMessage = null;
    });

    // Load created sessions first; BlocListener will chain to joined
    _currentLoadFilter = 'created';
    context.read<SprayMeCubit>().loadMySessions(filter: 'created', page: 1);
  }

  void _onSessionsLoaded(MySessionsLoaded state) {
    if (_isLoadingInitial && _currentLoadFilter == 'created') {
      setState(() {
        _createdSessions.clear();
        _createdSessions.addAll(state.sessions);
        _createdPage = 1;
        _createdHasMore = state.sessions.length >= 20;
      });
      // Chain: now load joined sessions
      _currentLoadFilter = 'joined';
      context.read<SprayMeCubit>().loadMySessions(filter: 'joined', page: 1);
    } else if (_isLoadingInitial && _currentLoadFilter == 'joined') {
      setState(() {
        _joinedSessions.clear();
        _joinedSessions.addAll(state.sessions);
        _joinedPage = 1;
        _joinedHasMore = state.sessions.length >= 20;
        _isLoadingInitial = false;
      });
    } else if (_loadingMore && _currentLoadFilter == 'created') {
      setState(() {
        _createdSessions.addAll(state.sessions);
        _createdPage++;
        _createdHasMore = state.sessions.length >= 20;
        _createdLoading = false;
        _loadingMore = false;
      });
    } else if (_loadingMore && _currentLoadFilter == 'joined') {
      setState(() {
        _joinedSessions.addAll(state.sessions);
        _joinedPage++;
        _joinedHasMore = state.sessions.length >= 20;
        _joinedLoading = false;
        _loadingMore = false;
      });
    }
  }

  Future<void> _loadMoreCreatedSessions() async {
    if (_createdLoading || !_createdHasMore) return;
    setState(() => _createdLoading = true);
    _loadingMore = true;
    _currentLoadFilter = 'created';
    context.read<SprayMeCubit>().loadMySessions(filter: 'created', page: _createdPage + 1);
  }

  Future<void> _loadMoreJoinedSessions() async {
    if (_joinedLoading || !_joinedHasMore) return;
    setState(() => _joinedLoading = true);
    _loadingMore = true;
    _currentLoadFilter = 'joined';
    context.read<SprayMeCubit>().loadMySessions(filter: 'joined', page: _joinedPage + 1);
  }

  Future<void> _refresh() async {
    _createdPage = 1;
    _joinedPage = 1;
    _createdHasMore = true;
    _joinedHasMore = true;
    await _loadInitialSessions();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SprayMeCubit, SprayMeState>(
      listener: (context, state) {
        if (state is MySessionsLoaded) {
          _onSessionsLoaded(state);
        } else if (state is SprayMeError) {
          setState(() {
            _isLoadingInitial = false;
            _createdLoading = false;
            _joinedLoading = false;
            _loadingMore = false;
            _errorMessage = state.message;
          });
        }
      },
      child: Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'My Sessions',
          style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7C3AED), Color(0xFF9333EA)],
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: const Color(0xFF9CA3AF),
              unselectedLabelColor: const Color(0xFF6B7280),
              labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              tabs: const [
                Tab(text: 'Created'),
                Tab(text: 'Joined'),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Error message
          if (_errorMessage != null)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: const Color(0xFFEF4444).withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: const Color(0xFFEF4444), size: 16.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(color: const Color(0xFFEF4444), fontSize: 13.sp),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh, size: 16.sp),
                    color: const Color(0xFFEF4444),
                    onPressed: () {
                      setState(() => _errorMessage = null);
                      _refresh();
                    },
                  ),
                ],
              ),
            ),

          if (_errorMessage != null) SizedBox(height: 12.h),

          // Tab Content
          Expanded(
            child: _isLoadingInitial
                ? _buildLoadingShimmer()
                : TabBarView(
                    controller: _tabController,
                    children: [
                      _buildSessionsList(
                        sessions: _createdSessions,
                        isLoading: _createdLoading,
                        // Gate the load-more sentinel on no-error: otherwise a
                        // persistent 500 with zero cached rows makes the sentinel
                        // rebuild → loadMore() → error → rebuild in a tight loop.
                        hasMore: _createdHasMore && _errorMessage == null,
                        loadMore: _loadMoreCreatedSessions,
                        isEmpty: _createdSessions.isEmpty && _errorMessage == null,
                      ),
                      _buildSessionsList(
                        sessions: _joinedSessions,
                        isLoading: _joinedLoading,
                        hasMore: _joinedHasMore && _errorMessage == null,
                        loadMore: _loadMoreJoinedSessions,
                        isEmpty: _joinedSessions.isEmpty && _errorMessage == null,
                      ),
                    ],
                  ),
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildLoadingShimmer() {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: 5,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (_, __) {
        return Shimmer.fromColors(
          baseColor: const Color(0xFF1F1F1F),
          highlightColor: const Color(0xFF2D2D2D),
          child: Container(
            height: 90.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSessionsList({
    required List<SpraySession> sessions,
    required bool isLoading,
    required bool hasMore,
    required VoidCallback loadMore,
    required bool isEmpty,
  }) {
    // Empty tabs stay pull-to-refreshable too — wrap in a scrollable so the
    // RefreshIndicator can trigger.
    if (isEmpty) {
      return RefreshIndicator(
        onRefresh: _refresh,
        color: const Color(0xFF3B82F6),
        backgroundColor: const Color(0xFF1F1F1F),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(height: 120.h),
            _buildEmptyState(),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: sessions.length + (hasMore ? 1 : 0),
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
        itemBuilder: (context, index) {
          if (index >= sessions.length) {
            // Load more indicator
            loadMore();
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: isLoading
                    ? LazerVaultLoader.small()
                    : const SizedBox.shrink(),
              ),
            );
          }
          return _buildSessionCard(sessions[index]);
        },
      ),
    );
  }

  Widget _buildSessionCard(SpraySession session) {
    final statusColor = _statusColor(session.status);
    final occasionIcon = _occasionIcon(session.occasionType);
    final occasionColors = OccasionTheme.getGradient(session.occasionType);
    final isHost =
        _currentUserId != null && session.hostUserId == _currentUserId;

    return GestureDetector(
      onTap: () => _navigateToSession(session),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF1F1F1F),
              const Color(0xFF252525),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: session.isActive
                ? occasionColors[0].withOpacity(0.3)
                : const Color(0xFF2D2D2D),
            width: session.isActive ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row with occasion icon and status
            Row(
              children: [
                Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        occasionColors[0].withOpacity(0.2),
                        occasionColors.length > 1
                            ? occasionColors[1].withOpacity(0.1)
                            : occasionColors[0].withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    occasionIcon,
                    color: occasionColors[0],
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        session.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        _formatDate(session.createdAt),
                        style: TextStyle(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (session.isActive)
                        Container(
                          width: 6.w,
                          height: 6.w,
                          margin: EdgeInsets.only(right: 4.w),
                          decoration: const BoxDecoration(
                            color: Color(0xFF10B981),
                            shape: BoxShape.circle,
                          ),
                        ),
                      Text(
                        session.status.toUpperCase(),
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Stats row
            Row(
              children: [
                _buildStatChip(
                  icon: Icons.people_outline,
                  label: '${session.participantCount}',
                  tooltip: 'Participants',
                ),
                SizedBox(width: 8.w),
                _buildStatChip(
                  icon: Icons.card_giftcard,
                  label: '${session.totalGifts}',
                  tooltip: 'Gifts received',
                ),
                SizedBox(width: 8.w),
                _buildStatChip(
                  icon: Icons.favorite,
                  label: '${session.totalLikes}',
                  tooltip: 'Likes',
                ),
                Spacer(),
                if (session.totalSprayed > 0)
                  Text(
                    '${session.currency} ${(session.totalSprayed / 100).toStringAsFixed(0)}',
                    style: TextStyle(
                      color: const Color(0xFFFFD700),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),

            // One-tap re-entry for ACTIVE sessions — no code retype. Host sees
            // "Re-enter" (goes back in as host); a joiner sees "Rejoin".
            if (session.isActive) ...[
              SizedBox(height: 12.h),
              SizedBox(
                width: double.infinity,
                child: _buildBottomSheetButton(
                  icon: isHost
                      ? Icons.podcasts_rounded
                      : Icons.play_circle_filled,
                  label: isHost ? 'Re-enter session' : 'Rejoin session',
                  gradient: isHost
                      ? [const Color(0xFF7C3AED), const Color(0xFF4834D4)]
                      : [const Color(0xFF10B981), const Color(0xFF059669)],
                  onTap: () => _joinSession(session),
                ),
              ),
            ],

            // Host info (for joined sessions)
            if (session.isEnded)
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 14.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Hosted by ${session.hostName}',
                      style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip({
    required IconData icon,
    required String label,
    required String tooltip,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.sp, color: const Color(0xFF9CA3AF)),
        SizedBox(width: 4.w),
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF9CA3AF),
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_available_outlined,
            size: 56.sp,
            color: const Color(0xFF9CA3AF),
          ),
          SizedBox(height: 12.h),
          Text(
            'No sessions yet',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Sessions you create or join will appear here',
            style: TextStyle(
              color: const Color(0xFF9CA3AF).withValues(alpha: 0.6),
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 20.h),
          _buildCreateJoinButtons(),
        ],
      ),
    );
  }

  Widget _buildCreateJoinButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildActionButton(
          icon: Icons.add_circle_outline,
          label: 'Create',
          gradient: [const Color(0xFF7C3AED), const Color(0xFF9333EA)],
          onTap: () {
            HapticFeedback.lightImpact();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => serviceLocator<SprayMeCubit>(),
                  child: const CreateSessionScreen(),
                ),
              ),
            ).then((_) => _refresh());
          },
        ),
        SizedBox(width: 16.w),
        _buildActionButton(
          icon: Icons.login,
          label: 'Join',
          gradient: [const Color(0xFFD4A017), const Color(0xFFF59E0B)],
          onTap: () {
            HapticFeedback.lightImpact();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => serviceLocator<SprayMeCubit>(),
                  child: const JoinSessionScreen(),
                ),
              ),
            ).then((_) => _refresh());
          },
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradient),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 18.sp),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToSession(SpraySession session) async {
    HapticFeedback.lightImpact();

    // Show action sheet with options
    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Session preview
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF252525),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          _occasionIcon(session.occasionType),
                          color: _statusColor(session.status),
                          size: 24.sp,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                session.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                '${session.occasionType} • ${_formatDate(session.createdAt)}',
                                style: TextStyle(
                                  color: const Color(0xFF9CA3AF),
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: _statusColor(session.status).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            session.status.toUpperCase(),
                            style: TextStyle(
                              color: _statusColor(session.status),
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    // Quick stats
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildBottomSheetStat(
                          icon: Icons.people,
                          value: '${session.participantCount}',
                          label: 'People',
                        ),
                        _buildBottomSheetStat(
                          icon: Icons.card_giftcard,
                          value: '${session.totalGifts}',
                          label: 'Gifts',
                        ),
                        _buildBottomSheetStat(
                          icon: Icons.favorite,
                          value: '${session.totalLikes}',
                          label: 'Likes',
                        ),
                        if (session.totalSprayed > 0)
                          _buildBottomSheetStat(
                            icon: Icons.monetization_on,
                            value: '${(session.totalSprayed / 100).toStringAsFixed(0)}',
                            label: 'Sprayed',
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // Action buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (session.isActive) ...[
                      // Re-enter (host) or rejoin (viewer) the live session
                      SizedBox(
                        width: double.infinity,
                        child: _buildBottomSheetButton(
                          icon: _isOwn(session)
                              ? Icons.podcasts_rounded
                              : Icons.play_circle_filled,
                          label: _isOwn(session)
                              ? 'Re-enter session'
                              : 'Rejoin session',
                          gradient: _isOwn(session)
                              ? [const Color(0xFF7C3AED), const Color(0xFF4834D4)]
                              : [const Color(0xFF10B981), const Color(0xFF059669)],
                          onTap: () async {
                            Navigator.pop(context);
                            await _joinSession(session);
                          },
                        ),
                      ),
                      SizedBox(height: 10.h),
                    ],
                    // View Stats/History
                    SizedBox(
                      width: double.infinity,
                      child: _buildBottomSheetButton(
                        icon: Icons.analytics_outlined,
                        label: 'View Stats & History',
                        gradient: [const Color(0xFF3B82F6), const Color(0xFF7C3AED)],
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider(
                                create: (_) => serviceLocator<SprayMeCubit>(),
                                child: SessionDetailScreen(
                                  sessionId: session.id,
                                  session: session,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// True when the signed-in user hosts this session (vs merely joined it).
  bool _isOwn(SpraySession session) =>
      _currentUserId != null && session.hostUserId == _currentUserId;

  Future<void> _joinSession(SpraySession session) async {
    final storage = serviceLocator<SecureStorageService>();
    final token = await storage.getAccessToken();
    if (token == null || !mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => serviceLocator<SprayRoomCubit>(),
          child: SprayRoomScreen(
            sessionId: session.id,
            accessToken: token,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSheetStat({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, size: 18.sp, color: const Color(0xFF9CA3AF)),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
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
    );
  }

  Widget _buildBottomSheetButton({
    required IconData icon,
    required String label,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradient),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20.sp),
            SizedBox(width: 10.w),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'live':
        return const Color(0xFF10B981);
      case 'ended':
      case 'completed':
        return const Color(0xFF9CA3AF);
      case 'pending':
        return const Color(0xFFFB923C);
      default:
        return const Color(0xFF3B82F6);
    }
  }

  IconData _occasionIcon(String occasionType) {
    switch (occasionType.toLowerCase()) {
      case 'wedding':
        return Icons.favorite;
      case 'birthday':
        return Icons.cake;
      case 'graduation':
        return Icons.school;
      case 'naming ceremony':
      case 'baby shower':
        return Icons.child_care;
      case 'housewarming':
        return Icons.home;
      case 'funeral':
        return Icons.sentiment_satisfied_alt;
      case 'promotion':
        return Icons.trending_up;
      case 'engagement':
        return Icons.diamond;
      case 'anniversary':
        return Icons.calendar_today;
      case 'retirement':
        return Icons.beach_access;
      case 'send-off':
        return Icons.flight_takeoff;
      case 'house party':
        return Icons.music_note;
      default:
        return Icons.celebration;
    }
  }
}

