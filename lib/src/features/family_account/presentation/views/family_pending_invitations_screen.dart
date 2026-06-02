import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/family_account/domain/entities/family_account_entities.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_cubit.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_state.dart';

class FamilyPendingInvitationsScreen extends StatefulWidget {
  const FamilyPendingInvitationsScreen({super.key});

  @override
  State<FamilyPendingInvitationsScreen> createState() =>
      _FamilyPendingInvitationsScreenState();
}

class _FamilyPendingInvitationsScreenState
    extends State<FamilyPendingInvitationsScreen>
    with SingleTickerProviderStateMixin {
  // Two independent cubit instances so the Pending tab's state isn't
  // overwritten when the History tab loads. Both flow through the same
  // FamilyAccountCubit class — DI registers a factory so each lookup
  // returns a fresh instance.
  final FamilyAccountCubit _pendingCubit = serviceLocator<FamilyAccountCubit>();
  final FamilyAccountCubit _historyCubit = serviceLocator<FamilyAccountCubit>();
  late final TabController _tabController;
  bool _historyLoaded = false;
  String _historyStatusFilter = ''; // '' = all (default)

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
    _pendingCubit.loadPendingInvitations();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    // Lazy-load history the first time the user lands on tab 1
    if (_tabController.index == 1 && !_historyLoaded) {
      _historyLoaded = true;
      _historyCubit.loadInvitationHistory(statusFilter: _historyStatusFilter);
    }
  }

  Future<void> _onRefresh() async {
    _pendingCubit.loadPendingInvitations();
  }

  Future<void> _onHistoryRefresh() async {
    _historyCubit.loadInvitationHistory(statusFilter: _historyStatusFilter);
  }

  void _setHistoryStatusFilter(String f) {
    setState(() => _historyStatusFilter = f);
    _historyCubit.loadInvitationHistory(statusFilter: f);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Invitations',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF3B82F6),
          labelColor: Colors.white,
          unselectedLabelColor: const Color(0xFF9CA3AF),
          labelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildPendingTab(),
            _buildHistoryTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildPendingTab() {
    return BlocConsumer<FamilyAccountCubit, FamilyAccountState>(
      bloc: _pendingCubit,
      listener: (context, state) {
        if (state is InvitationAccepted) {
          Get.snackbar(
            'Success',
            'Invitation accepted! You have joined the family account.',
            backgroundColor: const Color(0xFF10B981),
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.all(16.w),
          );
          Get.offNamed(AppRoutes.familyDetails,
              arguments: {'familyId': state.familyAccount.id});
        } else if (state is InvitationDeclined) {
          Get.snackbar(
            'Declined',
            'Invitation has been declined.',
            backgroundColor: const Color(0xFF1F1F1F),
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.all(16.w),
          );
          _pendingCubit.loadPendingInvitations();
          // Also bust the history cache so a freshly-declined invite
          // appears on the History tab next time it's opened.
          _historyLoaded = false;
        } else if (state is FamilyAccountError) {
          Get.snackbar(
            'Error',
            state.message,
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.all(16.w),
          );
        }
      },
      builder: (context, state) {
        if (state is FamilyAccountLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
          );
        }
        if (state is PendingInvitationsLoaded) {
          if (state.invitations.isEmpty) {
            return _buildEmptyState();
          }
          return _buildInvitationsList(state.invitations);
        }
        // Transient accept/decline state → spinner while reload fires
        return const Center(
          child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
        );
      },
    );
  }

  Widget _buildHistoryTab() {
    return Column(
      children: [
        // Status filter chips
        SizedBox(
          height: 48.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            children: [
              _buildFilterChip('All', ''),
              _buildFilterChip('Pending', 'pending'),
              _buildFilterChip('Accepted', 'accepted'),
              _buildFilterChip('Declined', 'declined'),
              _buildFilterChip('Expired', 'expired'),
              _buildFilterChip('Removed', 'removed'),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<FamilyAccountCubit, FamilyAccountState>(
            bloc: _historyCubit,
            builder: (context, state) {
              if (state is InvitationHistoryLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
                );
              }
              if (state is InvitationHistoryLoaded) {
                if (state.entries.isEmpty) {
                  return _buildEmptyHistory();
                }
                return RefreshIndicator(
                  onRefresh: _onHistoryRefresh,
                  color: const Color(0xFF3B82F6),
                  backgroundColor: const Color(0xFF1F1F1F),
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    itemCount: state.entries.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder: (context, i) =>
                        _buildHistoryCard(state.entries[i]),
                  ),
                );
              }
              if (state is FamilyAccountError) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Text(
                      state.message,
                      style: TextStyle(color: const Color(0xFFEF4444), fontSize: 13.sp),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, String filterValue) {
    final selected = _historyStatusFilter == filterValue;
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => _setHistoryStatusFilter(filterValue),
        backgroundColor: const Color(0xFF1F1F1F),
        selectedColor: const Color(0xFF3B82F6),
        labelStyle: TextStyle(
          color: selected ? Colors.white : const Color(0xFF9CA3AF),
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
        side: BorderSide(
          color: selected
              ? const Color(0xFF3B82F6)
              : const Color(0xFF2D2D2D),
        ),
      ),
    );
  }

  Widget _buildEmptyHistory() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 120.h),
        Icon(Icons.history, size: 64.sp, color: const Color(0xFF9CA3AF)),
        SizedBox(height: 16.h),
        Text(
          'No invitations in history',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Past invitations will appear here\nonce you accept, decline, or they expire.',
          textAlign: TextAlign.center,
          style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildHistoryCard(InvitationHistoryEntry e) {
    final color = _statusColor(e.status);
    final label = _statusLabel(e.status);
    final responded = e.respondedAt;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  e.familyName.isEmpty ? '(unnamed family)' : e.familyName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            'Invited by ${e.invitedBy.isEmpty ? "—" : e.invitedBy}',
            style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
          ),
          SizedBox(height: 10.h),
          Text(
            'Sent ${_fmtDate(e.createdAt)}'
            '${responded != null ? "  ·  ${_actionVerb(e.status)} ${_fmtDate(responded)}" : ""}',
            style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 11.sp),
          ),
          if (e.initialAllocation > 0) ...[
            SizedBox(height: 8.h),
            Text(
              'Initial allocation: \$${e.initialAllocation.toStringAsFixed(2)}',
              style: TextStyle(color: const Color(0xFF10B981), fontSize: 12.sp),
            ),
          ],
        ],
      ),
    );
  }

  static Color _statusColor(InvitationStatus s) {
    switch (s) {
      case InvitationStatus.pending:
        return const Color(0xFFFB923C);
      case InvitationStatus.accepted:
        return const Color(0xFF10B981);
      case InvitationStatus.declined:
        return const Color(0xFFEF4444);
      case InvitationStatus.removed:
        return const Color(0xFF6B7280);
      case InvitationStatus.expired:
        return const Color(0xFF9CA3AF);
    }
  }

  static String _statusLabel(InvitationStatus s) {
    switch (s) {
      case InvitationStatus.pending:
        return 'PENDING';
      case InvitationStatus.accepted:
        return 'ACCEPTED';
      case InvitationStatus.declined:
        return 'DECLINED';
      case InvitationStatus.removed:
        return 'REMOVED';
      case InvitationStatus.expired:
        return 'EXPIRED';
    }
  }

  static String _actionVerb(InvitationStatus s) {
    switch (s) {
      case InvitationStatus.accepted:
        return 'joined';
      case InvitationStatus.declined:
        return 'declined';
      case InvitationStatus.removed:
        return 'removed';
      case InvitationStatus.expired:
        return 'expired';
      case InvitationStatus.pending:
        return 'pending';
    }
  }

  static String _fmtDate(DateTime d) {
    final local = d.toLocal();
    return '${local.year}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')}';
  }

  Widget _buildEmptyState() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 120.h),
          Icon(
            Icons.mail_outline,
            size: 64.sp,
            color: const Color(0xFF9CA3AF),
          ),
          SizedBox(height: 16.h),
          Text(
            'No Pending Invitations',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'You don\'t have any pending family\naccount invitations right now.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvitationsList(List<PendingInvitation> invitations) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        itemCount: invitations.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          return _buildInvitationCard(invitations[index]);
        },
      ),
    );
  }

  Widget _buildInvitationCard(PendingInvitation invitation) {
    final bool expiringsSoon =
        !invitation.isExpired && invitation.daysUntilExpiration < 3;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF2D2D2D),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Family name
          Text(
            invitation.familyName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 6.h),

          // Creator name
          Text(
            'Invited by ${invitation.creatorName}',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 12.h),

          // Divider
          Container(
            height: 1,
            color: const Color(0xFF2D2D2D),
          ),
          SizedBox(height: 12.h),

          // Initial allocation
          Row(
            children: [
              Text(
                'Initial Allocation',
                style: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                '\$${invitation.initialAllocation.toStringAsFixed(2)}',
                style: TextStyle(
                  color: const Color(0xFF10B981),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // Spending limits
          Row(
            children: [
              Text(
                'Spending Limits',
                style: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                'Daily: \$${invitation.dailyLimit.toStringAsFixed(2)} / Monthly: \$${invitation.monthlyLimit.toStringAsFixed(2)}',
                style: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // Expiry countdown
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 14.sp,
                color: invitation.isExpired
                    ? const Color(0xFFEF4444)
                    : expiringsSoon
                        ? const Color(0xFFFB923C)
                        : const Color(0xFF9CA3AF),
              ),
              SizedBox(width: 4.w),
              Text(
                invitation.isExpired
                    ? 'Expired'
                    : 'Expires in ${invitation.daysUntilExpiration} days',
                style: TextStyle(
                  color: invitation.isExpired
                      ? const Color(0xFFEF4444)
                      : expiringsSoon
                          ? const Color(0xFFFB923C)
                          : const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Action buttons
          Row(
            children: [
              // Decline button
              Expanded(
                child: OutlinedButton(
                  onPressed: invitation.isExpired
                      ? null
                      : () {
                          _pendingCubit.declineInvitation(invitation.invitationToken);
                        },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xFFEF4444),
                      width: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    disabledForegroundColor:
                        const Color(0xFF9CA3AF).withValues(alpha: 0.5),
                  ),
                  child: Text(
                    'Decline',
                    style: TextStyle(
                      color: invitation.isExpired
                          ? const Color(0xFF9CA3AF).withValues(alpha: 0.5)
                          : const Color(0xFFEF4444),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // Accept button
              Expanded(
                child: ElevatedButton(
                  onPressed: invitation.isExpired
                      ? null
                      : () {
                          _pendingCubit.acceptInvitation(invitation.invitationToken);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    disabledBackgroundColor:
                        const Color(0xFF3B82F6).withValues(alpha: 0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  child: Text(
                    'Accept',
                    style: TextStyle(
                      color: invitation.isExpired
                          ? Colors.white.withValues(alpha: 0.4)
                          : Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
