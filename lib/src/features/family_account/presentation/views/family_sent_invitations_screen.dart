import 'package:flutter/material.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/family_account/domain/entities/family_account_entities.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_cubit.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_state.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// Inviter-side view: shows every invitation the current user (as a
/// family admin) has sent. Filterable by status. When [familyId] is
/// provided, restricts to a single family; otherwise spans every family
/// the user admins.
///
/// Reached from the family detail screen's settings sheet ("Sent
/// Invitations" — admin-only). The backend RPC is GetSentInvitations
/// which already gates on the caller being an accepted admin of ≥1 family.
class FamilySentInvitationsScreen extends StatefulWidget {
  const FamilySentInvitationsScreen({
    super.key,
    this.familyId,
  });

  /// Optional — when set, the list is scoped to a single family. When
  /// null, the screen shows the user's sent invitations across every
  /// family they admin.
  final String? familyId;

  @override
  State<FamilySentInvitationsScreen> createState() =>
      _FamilySentInvitationsScreenState();
}

class _FamilySentInvitationsScreenState extends State<FamilySentInvitationsScreen> {
  final FamilyAccountCubit _cubit = serviceLocator<FamilyAccountCubit>();
  String _statusFilter = ''; // '' = all

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    _cubit.loadSentInvitations(
      familyId: widget.familyId,
      statusFilter: _statusFilter,
    );
  }

  void _setStatusFilter(String f) {
    setState(() => _statusFilter = f);
    _load();
  }

  Future<void> _onRefresh() async => _load();

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
          widget.familyId != null ? 'Sent Invitations' : 'My Sent Invitations',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
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
                bloc: _cubit,
                builder: (context, state) {
                  if (state is SentInvitationsLoading) {
                    return const Center(
                      child: LazerVaultLoader.small(),
                    );
                  }
                  if (state is SentInvitationsLoaded) {
                    if (state.entries.isEmpty) {
                      return _buildEmpty();
                    }
                    return RefreshIndicator(
                      onRefresh: _onRefresh,
                      color: const Color(0xFF4E03D0),
                      backgroundColor: const Color(0xFF1F1F1F),
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                        itemCount: state.entries.length,
                        separatorBuilder: (_, __) => SizedBox(height: 12.h),
                        itemBuilder: (context, i) => _buildSentCard(state.entries[i]),
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
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String filterValue) {
    final selected = _statusFilter == filterValue;
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => _setStatusFilter(filterValue),
        backgroundColor: const Color(0xFF1F1F1F),
        selectedColor: const Color(0xFF4E03D0),
        labelStyle: TextStyle(
          color: selected ? Colors.white : const Color(0xFF9CA3AF),
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
        side: BorderSide(
          color: selected ? const Color(0xFF4E03D0) : const Color(0xFF2D2D2D),
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 120.h),
        Icon(Icons.send_outlined, size: 64.sp, color: const Color(0xFF9CA3AF)),
        SizedBox(height: 16.h),
        Text(
          'No sent invitations',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          widget.familyId != null
              ? 'Invitations you send for this family will appear here.'
              : 'Invitations you send across your family accounts will appear here.',
          textAlign: TextAlign.center,
          style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildSentCard(SentInvitationEntry e) {
    final color = _statusColor(e.status);
    final label = _statusLabel(e.status);
    final displayName = e.invitedUserName.isNotEmpty
        ? e.invitedUserName
        : e.invitationDestination;
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${_methodLabel(e.invitationMethod)} · ${e.invitationDestination}',
                      style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 11.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
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
          SizedBox(height: 10.h),
          if (widget.familyId == null) ...[
            Text(
              'Family: ${e.familyName}',
              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
            ),
            SizedBox(height: 6.h),
          ],
          Text(
            'Sent ${_fmtDate(e.createdAt)}'
            '${e.respondedAt != null ? "  ·  ${_actionVerb(e.status)} ${_fmtDate(e.respondedAt!)}" : ""}',
            style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 11.sp),
          ),
          if (e.initialAllocation > 0) ...[
            SizedBox(height: 6.h),
            Text(
              'Allocation: ${CurrencySymbols.currentSymbol}${e.initialAllocation.toStringAsFixed(2)}'
              '${e.dailyLimit > 0 ? "  ·  Daily ${CurrencySymbols.currentSymbol}${e.dailyLimit.toStringAsFixed(2)}" : ""}'
              '${e.monthlyLimit > 0 ? "  ·  Monthly ${CurrencySymbols.currentSymbol}${e.monthlyLimit.toStringAsFixed(2)}" : ""}',
              style: TextStyle(color: const Color(0xFF10B981), fontSize: 11.sp),
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

  static String _methodLabel(String m) {
    switch (m) {
      case 'email':
        return 'Email';
      case 'phone':
        return 'SMS';
      case 'username':
        return 'Username';
      default:
        return m;
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
}
