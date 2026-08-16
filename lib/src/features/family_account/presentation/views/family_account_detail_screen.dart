import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/family_account/domain/entities/family_account_entities.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_cubit.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_state.dart';
import 'package:lazervault/src/features/family_account/presentation/views/family_account_report_screen.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// Family Account Detail Screen
/// Shows:
/// - Family account overview
/// - Member list with allocations and spending
/// - Recent transactions
/// - Manage members button
/// - Account settings
class FamilyAccountDetailScreen extends StatefulWidget {
  const FamilyAccountDetailScreen({
    super.key,
    required this.familyId,
  });

  final String familyId;

  @override
  State<FamilyAccountDetailScreen> createState() => _FamilyAccountDetailScreenState();
}

class _FamilyAccountDetailScreenState extends State<FamilyAccountDetailScreen>
    with SingleTickerProviderStateMixin {
  final FamilyAccountCubit _cubit = serviceLocator<FamilyAccountCubit>();
  final FamilyAccountCubit _transactionsCubit = serviceLocator<FamilyAccountCubit>();
  late TabController _tabController;
  FamilyTransactionType? _transactionFilter;
  String? _memberFilter; // memberId to filter by
  DateTimeRange? _dateFilter; // time-range filter (null = all time)
  bool _activityLoaded = false;
  // Last successfully-loaded account. Kept so a transient ACTION failure
  // (member removal, allocation, etc. — all emit the shared FamilyAccountError
  // state) surfaces only via a snackbar and does NOT blank the whole screen.
  FamilyAccount? _loadedAccount;
  // Card issuance is disabled until a card provider is wired (no provider in
  // this environment) — flip to true to re-enable the "Issue Card" action.
  static const bool _cardIssuanceEnabled = false;
  // One-shot: if we land here before auth resolves (deep-link edge), the
  // admin-gated UI (Allocate, freeze, delete, invite) reads a null user id and
  // hides. Rebuild once auth becomes available so those gates re-evaluate.
  StreamSubscription<AuthenticationState>? _authSub;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
    _loadFamilyAccount();
    if (_currentUserId == null) {
      _authSub = context.read<AuthenticationCubit>().stream.listen((state) {
        if (state is AuthenticationSuccess && mounted) {
          setState(() {});
          _authSub?.cancel();
          _authSub = null;
        }
      });
    }
  }

  @override
  void dispose() {
    _authSub?.cancel();
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    // Reload activity every time the Activity tab is (re)selected — not just
    // the first time — so spends made elsewhere in the session show up when
    // the member returns to this tab. Guard on indexIsChanging so we fire once
    // per swipe, not on every animation frame.
    if (_tabController.index == 2 &&
        (_tabController.indexIsChanging || !_activityLoaded)) {
      _activityLoaded = true;
      _loadTransactions();
    }
  }

  void _loadTransactions() {
    _transactionsCubit.loadTransactions(
      familyId: widget.familyId,
      memberId: _memberFilter,
      type: _transactionFilter,
      startDate: _dateFilter?.start,
      endDate: _dateFilter?.end,
    );
  }

  void _loadFamilyAccount() {
    _cubit.loadFamilyAccount(widget.familyId);
  }

  /// Force-refresh the dashboard account carousel so the family card's balance /
  /// status reflects a money or status change made here (fund, allocate, remove,
  /// freeze) WITHOUT a manual pull-to-refresh. The dashboard's FamilyAccountCubit
  /// is a separate factory instance, so it can't react to these states on its
  /// own; the shared AccountCardsSummaryCubit (provided high in the tree) is the
  /// bridge — the same one the create carousel refreshes on completion.
  void _refreshDashboardSummaries() {
    try {
      final accountsCubit = context.read<AccountCardsSummaryCubit>();
      if (accountsCubit.currentUserId != null) {
        accountsCubit.fetchAccountSummaries(userId: accountsCubit.currentUserId!);
      }
    } catch (_) {
      // Non-fatal: the dashboard refreshes on its own pull-to-refresh regardless.
    }
  }

  /// Pulls the currently-authenticated user ID from AuthenticationCubit.
  /// Returns null while auth is still loading — callers should treat null
  /// as "definitely not authorized" (no admin UI is exposed).
  String? get _currentUserId {
    final auth = context.read<AuthenticationCubit>().state;
    if (auth is AuthenticationSuccess) {
      return auth.profile.userId;
    }
    return null;
  }

  /// Whether the current viewer may see ALL members' spending. Mirrors the
  /// creator's "Spending Transparency" choice: when spending visibility is
  /// enabled every member sees everyone's spend; when disabled only the
  /// creator/admin retains full visibility (the rest see only their own).
  bool _canSeeAllSpending(FamilyAccount account) {
    return account.spendingVisibilityEnabled ||
        account.isCurrentUserAdmin(_currentUserId);
  }

  /// Whether THIS member's spending figures should be shown to the viewer:
  /// either visibility is on / the viewer is admin, or it's the viewer's own
  /// row (you can always see your own spending).
  bool _canSeeMemberSpending(FamilyAccount account, FamilyMember member) {
    if (_canSeeAllSpending(account)) return true;
    final uid = _currentUserId;
    return uid != null && uid.isNotEmpty && member.userId == uid;
  }

  void _showAddMemberSheet() {
    // Navigate directly to the new invite member flow screen
    Get.toNamed(AppRoutes.familyInviteMemberFlow, arguments: {
      'familyId': widget.familyId,
    })?.then((result) {
      // Reload the family account if a member was added
      if (result == true) {
        _loadFamilyAccount();
      }
    });
  }

  void _showMemberOptions(FamilyAccount account, FamilyMember member) {
    // Role gate: only the family's accepted admin can mutate other members.
    // Non-admins still see the bottom sheet but only the "View Details"
    // option (read-only) — the destructive options are filtered out.
    final viewerIsAdmin = account.isCurrentUserAdmin(_currentUserId);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        decoration: BoxDecoration(
          // Lifted surface: lighter than the 0xFF0A0A0A page background.
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 16.h),

            // Member info
            Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    color: _kFamilyPurple.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _kFamilyPurple.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: (member.avatarUrl?.isNotEmpty ?? false)
                      ? ClipOval(
                          child: Image.network(
                            member.avatarUrl!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Center(
                          child: Text(
                            _memberInitial(member),
                            style: GoogleFonts.inter(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: _kFamilyPurple,
                            ),
                          ),
                        ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        member.fullName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        member.role.name.toUpperCase(),
                        style: TextStyle(
                          color: member.role == FamilyMemberRole.admin
                              ? _kFamilyPurple
                              : Colors.white.withValues(alpha: 0.6),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Options. Mutations are gated on the VIEWER being an admin
            // (server enforces too, but matching here avoids surfacing
            // actions that would 403). Editing/removing another admin is
            // still hidden by member.role != admin to keep destructive
            // peer-admin actions out of the bottom sheet UX; demotion is
            // available via Edit Limits → role picker (future work) or
            // via the admin dashboard.
            if (viewerIsAdmin && member.role != FamilyMemberRole.admin) ...[
              _buildOption(
                Icons.edit,
                'Edit Limits',
                'Update spending limits',
                () {
                  Get.back();
                  Get.toNamed(
                    AppRoutes.familyEditMemberLimits,
                    arguments: {
                      'familyId': widget.familyId,
                      'member': member,
                    },
                  )?.then((result) {
                    if (result == true) _loadFamilyAccount();
                  });
                },
              ),
              SizedBox(height: 12.h),
              _buildOption(
                Icons.account_balance_wallet,
                'Allocate Funds',
                'Add more funds to member',
                () {
                  Get.back();
                  _showAllocateFundsDialog(member);
                },
              ),
              SizedBox(height: 12.h),
            ],
            _buildOption(
              Icons.info_outline,
              'View Details',
                'See member activity',
              () {
                Get.back();
                _showMemberDetailSheet(account, member);
              },
            ),
            if (viewerIsAdmin && member.role != FamilyMemberRole.admin) ...[
              SizedBox(height: 12.h),
              _buildOption(
                Icons.remove_circle_outline,
                'Remove Member',
                'Remove from family account',
                () {
                  Get.back();
                  _confirmRemoveMember(member);
                },
                color: Colors.red,
              ),
            ],
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  void _showAllocateFundsDialog(FamilyMember member) {
    final amountController = TextEditingController(text: '0');
    final descriptionController = TextEditingController();

    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF0A0A0A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Allocate Funds to ${member.fullName}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
                prefixText: '${CurrencySymbols.currentSymbol} ',
                prefixStyle: TextStyle(
                  color: _kFamilyPurple,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: descriptionController,
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
              decoration: InputDecoration(
                labelText: 'Description (Optional)',
                labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text) ?? 0;
              if (amount > 0) {
                Get.back();
                _cubit.allocateFundsToMember(
                  familyId: widget.familyId,
                  memberId: member.id,
                  amount: amount,
                  description: descriptionController.text.trim().isEmpty
                      ? null
                      : descriptionController.text.trim(),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _kFamilyPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Allocate',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Fund flow (top up pool + allocate to multiple members) ────────

  /// Prominent Fund action under the hero. Members can top up the pool;
  /// admins can additionally allocate to members.
  Widget _buildFundActions(FamilyAccount account) {
    if (!account.isActive) return const SizedBox.shrink();
    if (!account.isCurrentUserMember(_currentUserId)) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
      child: SizedBox(
        width: double.infinity,
        height: 48.h,
        child: ElevatedButton.icon(
          onPressed: () => _showFundSheet(account),
          icon: Icon(Icons.savings_outlined, size: 20.sp),
          label: Text(
            'Fund',
            style: GoogleFonts.inter(fontSize: 15.sp, fontWeight: FontWeight.w700),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: _kFamilyPurple,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          ),
        ),
      ),
    );
  }

  void _showFundSheet(FamilyAccount account) {
    final isAdmin = account.isCurrentUserAdmin(_currentUserId);
    final activeMembers = account.members.where((m) => m.isActive).toList();
    final symbol = CurrencySymbols.currentSymbol;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Container(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text('Fund the account',
                style: GoogleFonts.inter(
                    color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700)),
            SizedBox(height: 4.h),
            Text('Pool balance: $symbol${account.totalPoolBalance.toStringAsFixed(2)}',
                style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13.sp)),
            SizedBox(height: 16.h),
            _fundOptionTile(
              icon: Icons.volunteer_activism,
              color: const Color(0xFF10B981),
              title: 'Top up pool',
              subtitle: 'Move money from your wallet into the shared pool',
              onTap: () {
                Navigator.of(ctx).pop();
                _showContributeDialog(account);
              },
            ),
            if (isAdmin) ...[
              SizedBox(height: 12.h),
              _fundOptionTile(
                icon: Icons.groups_2_outlined,
                color: _kFamilyPurple,
                title: 'Allocate to members',
                subtitle: activeMembers.isEmpty
                    ? 'No active members yet'
                    : 'Split pool funds across ${activeMembers.length} member${activeMembers.length == 1 ? '' : 's'}',
                onTap: activeMembers.isEmpty
                    ? null
                    : () {
                        Navigator.of(ctx).pop();
                        _showMultiAllocateSheet(account);
                      },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _fundOptionTile({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    final disabled = onTap == null;
    return Opacity(
      opacity: disabled ? 0.5 : 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: const Color(0xFF0A0A0A),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 22.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600)),
                    SizedBox(height: 3.h),
                    Text(subtitle,
                        style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 12.sp)),
                  ],
                ),
              ),
              if (!disabled)
                Icon(Icons.chevron_right, color: Colors.grey[500], size: 22.sp),
            ],
          ),
        ),
      ),
    );
  }

  /// Allocate pool funds to several active members in one pass.
  void _showMultiAllocateSheet(FamilyAccount account) {
    final symbol = CurrencySymbols.currentSymbol;
    final activeMembers = account.members.where((m) => m.isActive).toList();
    final controllers = {
      for (final m in activeMembers) m.id: TextEditingController(),
    };
    bool submitting = false;

    double sumOf() => controllers.values.fold<double>(
        0, (s, c) => s + (double.tryParse(c.text.trim()) ?? 0));

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) {
          final allocated = sumOf();
          final remaining = account.totalPoolBalance - allocated;
          final over = remaining < 0;
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
            child: Container(
              constraints: BoxConstraints(maxHeight: 0.85.sh),
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text('Allocate to members',
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700)),
                  SizedBox(height: 4.h),
                  Text('Pool balance: $symbol${account.totalPoolBalance.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13.sp)),
                  SizedBox(height: 16.h),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        children: activeMembers.map((m) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 10.h),
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0A0A0A),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: const Color(0xFF2D2D2D)),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 18.r,
                                  backgroundColor: _kFamilyPurple.withValues(alpha: 0.2),
                                  child: Text(
                                    m.fullName.isNotEmpty
                                        ? m.fullName[0].toUpperCase()
                                        : '?',
                                    style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Text(
                                    m.fullName.isNotEmpty
                                        ? m.fullName
                                        : (m.username ?? 'Member'),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                SizedBox(
                                  width: 110.w,
                                  child: TextField(
                                    controller: controllers[m.id],
                                    keyboardType:
                                        const TextInputType.numberWithOptions(decimal: true),
                                    textAlign: TextAlign.right,
                                    onChanged: (_) => setSheetState(() {}),
                                    style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w700),
                                    decoration: InputDecoration(
                                      hintText: '0.00',
                                      hintStyle:
                                          TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
                                      prefixText: '$symbol ',
                                      prefixStyle: TextStyle(
                                          color: Colors.grey[400], fontSize: 14.sp),
                                      isDense: true,
                                      filled: true,
                                      fillColor: const Color(0xFF1F1F1F),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 10.h),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.r),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Remaining in pool',
                          style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13.sp)),
                      Text('$symbol${remaining.toStringAsFixed(2)}',
                          style: GoogleFonts.inter(
                              color: over ? const Color(0xFFEF4444) : const Color(0xFF10B981),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  // Explain WHY the button is disabled instead of a silent
                  // greyed-out CTA (the #1 "allocate does nothing" report).
                  if (account.totalPoolBalance <= 0)
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline,
                              color: const Color(0xFFFB923C), size: 15.sp),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Text(
                              'Your pool is empty. Close this and tap "Top up pool" to add funds before allocating.',
                              style: GoogleFonts.inter(
                                  color: const Color(0xFFFB923C), fontSize: 12.sp),
                            ),
                          ),
                        ],
                      ),
                    )
                  else if (over)
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Text(
                        'You\'re allocating more than the pool holds. Reduce the amounts.',
                        style: GoogleFonts.inter(
                            color: const Color(0xFFEF4444), fontSize: 12.sp),
                      ),
                    ),
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      // Keep the button live when over-allocated so tapping it
                      // surfaces an explanatory modal instead of dead-ending on
                      // a silent greyed-out CTA.
                      onPressed: (submitting || allocated <= 0)
                          ? null
                          : () async {
                              if (over) {
                                _showFamilyErrorDialog(
                                    'You\'re allocating more than the pool holds. Reduce the amounts so the total fits within the available pool balance.');
                                return;
                              }
                              setSheetState(() => submitting = true);
                              final entries = <MapEntry<String, double>>[];
                              controllers.forEach((id, c) {
                                final v = double.tryParse(c.text.trim()) ?? 0;
                                if (v > 0) entries.add(MapEntry(id, v));
                              });
                              Navigator.of(ctx).pop();
                              await _runMultiAllocate(entries);
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _kFamilyPurple,
                        disabledBackgroundColor: _kFamilyPurple.withValues(alpha: 0.4),
                        shape:
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      ),
                      child: submitting
                          ? LazerVaultLoader.small()
                          : Text('Allocate $symbol${allocated.toStringAsFixed(2)}',
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ).whenComplete(() {
      for (final c in controllers.values) {
        c.dispose();
      }
    });
  }

  /// Runs the per-member allocations sequentially on a dedicated cubit
  /// instance (FamilyAccountCubit is a factory) so the screen's shared
  /// listener doesn't fire per allocation. Refreshes once at the end.
  Future<void> _runMultiAllocate(List<MapEntry<String, double>> entries) async {
    if (entries.isEmpty) return;
    final allocCubit = serviceLocator<FamilyAccountCubit>();
    int ok = 0;
    final failed = <String>[];
    String? firstError;
    try {
      for (final e in entries) {
        final completer = Completer<FamilyAccountState>();
        late final StreamSubscription<FamilyAccountState> sub;
        sub = allocCubit.stream
            .where((s) => s is FundsAllocated || s is FamilyAccountError)
            .listen((s) {
          if (!completer.isCompleted) completer.complete(s);
          sub.cancel();
        });
        allocCubit.allocateFundsToMember(
          familyId: widget.familyId,
          memberId: e.key,
          amount: e.value,
        );
        final res = await completer.future.timeout(
          const Duration(seconds: 20),
          onTimeout: () {
            sub.cancel();
            // Empty message → falls through to the friendly fallback in the
            // dialog below (never shows the raw sentinel "timeout" to the user).
            return const FamilyAccountError('');
          },
        );
        if (res is FundsAllocated) {
          ok++;
        } else {
          failed.add(e.key);
          // Capture the REAL backend reason (e.g. "only admins can allocate",
          // "insufficient pool balance", "funding policy: …"). The multi-allocate
          // runs on a throwaway cubit that bypasses the screen's FamilyAccountError
          // listener, so without this the reason is lost and the CTA "does nothing".
          if (res is FamilyAccountError &&
              firstError == null &&
              res.message.trim().isNotEmpty) {
            firstError = res.message;
          }
        }
      }
    } finally {
      // Factory instance — dispose it so the per-allocate stream doesn't leak.
      await allocCubit.close();
    }

    if (!mounted) return;
    _loadFamilyAccount();
    _refreshDashboardSummaries();
    final symbol = CurrencySymbols.currentSymbol;
    if (ok > 0) {
      final total = entries
          .where((e) => !failed.contains(e.key))
          .fold<double>(0, (s, e) => s + e.value);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            failed.isEmpty
                ? 'Allocated $symbol${total.toStringAsFixed(2)} to $ok member${ok == 1 ? '' : 's'}'
                : 'Allocated to $ok member${ok == 1 ? '' : 's'}; ${failed.length} failed',
          ),
          backgroundColor: failed.isEmpty ? const Color(0xFF10B981) : const Color(0xFFFB923C),
        ),
      );
    }
    // Surface the first real error in a dialog so the user knows WHY it failed
    // (not just a silent "N failed").
    if (failed.isNotEmpty) {
      _showFamilyErrorDialog(firstError ??
          'The allocation couldn\'t be completed. Please try again.');
    }
  }

  void _showMemberDetailSheet(FamilyAccount account, FamilyMember member) {
    final showSpend = _canSeeMemberSpending(account, member);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            // Lighter than the page background (0xFF0A0A0A) so the sheet reads
            // as a distinct surface lifted above the screen.
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: ListView(
            controller: scrollController,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Avatar + Name + Role — name-based initial when there's no photo.
              Center(
                child: Container(
                  width: 72.w,
                  height: 72.w,
                  decoration: BoxDecoration(
                    color: _kFamilyPurple.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _kFamilyPurple.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: (member.avatarUrl?.isNotEmpty ?? false)
                      ? ClipOval(
                          child: Image.network(member.avatarUrl!, fit: BoxFit.cover),
                        )
                      : Center(
                          child: Text(
                            _memberInitial(member),
                            style: GoogleFonts.inter(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w600,
                              color: _kFamilyPurple,
                            ),
                          ),
                        ),
                ),
              ),
              SizedBox(height: 12.h),
              Center(
                child: Text(
                  member.fullName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: member.isAdmin
                        ? Colors.orange.withValues(alpha: 0.2)
                        : _kFamilyPurple.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    member.role.displayName,
                    style: TextStyle(
                      color: member.isAdmin ? Colors.orange : _kFamilyPurple,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              // Contact info
              if (member.email != null || member.phone != null || member.username != null) ...[
                Center(
                  child: Text(
                    member.username ?? member.email ?? member.phone ?? '',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
              ],

              // Balance Card — spend figures gated by visibility setting.
              if (showSpend)
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        _kFamilyPurple.withValues(alpha: 0.15),
                        const Color(0xFF60A5FA).withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: _kFamilyPurple.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildDetailStat(
                              'Allocated',
                              '${CurrencySymbols.currentSymbol}${member.allocatedBalance.toStringAsFixed(2)}',
                            ),
                          ),
                          Expanded(
                            child: _buildDetailStat(
                              'Remaining',
                              '${CurrencySymbols.currentSymbol}${member.remainingBalance.toStringAsFixed(2)}',
                              valueColor: member.remainingBalance > 0
                                  ? const Color(0xFF10B981)
                                  : const Color(0xFFEF4444),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Expanded(
                            child: _buildDetailStat(
                              'Spent Today',
                              '${CurrencySymbols.currentSymbol}${member.spentToday.toStringAsFixed(2)}',
                            ),
                          ),
                          Expanded(
                            child: _buildDetailStat(
                              'Spent This Month',
                              '${CurrencySymbols.currentSymbol}${member.spentThisMonth.toStringAsFixed(2)}',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              else
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.visibility_off_outlined,
                          size: 18.sp, color: Colors.white.withValues(alpha: 0.5)),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          "This member's spending is hidden by the account's visibility settings.",
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.6),
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 20.h),

              // Limits Section — caps are always shown; the spend-vs-limit bars
              // (which reveal spending) are only drawn when spend is visible.
              Text(
                'Spending Limits',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12.h),
              if (member.hasDailyLimit)
                showSpend
                    ? _buildLimitBar(
                        'Daily Limit',
                        member.spentToday,
                        member.dailySpendingLimit,
                      )
                    : _buildInfoRow(
                        Icons.today,
                        'Daily Limit',
                        '${CurrencySymbols.currentSymbol}${member.dailySpendingLimit.toStringAsFixed(2)}',
                      ),
              if (member.hasMonthlyLimit) ...[
                SizedBox(height: 10.h),
                showSpend
                    ? _buildLimitBar(
                        'Monthly Limit',
                        member.spentThisMonth,
                        member.monthlySpendingLimit,
                      )
                    : _buildInfoRow(
                        Icons.calendar_month,
                        'Monthly Limit',
                        '${CurrencySymbols.currentSymbol}${member.monthlySpendingLimit.toStringAsFixed(2)}',
                      ),
              ],
              if (member.hasPerTransactionLimit) ...[
                SizedBox(height: 10.h),
                _buildInfoRow(
                  Icons.payment,
                  'Per Transaction',
                  '${CurrencySymbols.currentSymbol}${member.perTransactionLimit.toStringAsFixed(2)}',
                ),
              ],
              if (!member.hasDailyLimit && !member.hasMonthlyLimit && !member.hasPerTransactionLimit)
                Text(
                  'No spending limits set',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 13.sp,
                  ),
                ),
              SizedBox(height: 20.h),

              // Card Info
              if (member.hasCard) ...[
                Text(
                  'Card',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                _buildInfoRow(
                  Icons.credit_card,
                  'Card',
                  '**** ${member.cardLastFour ?? '----'}',
                ),
                SizedBox(height: 20.h),
              ],

              // Issue Card (M1) — admin can issue a virtual card for an accepted
              // member who doesn't have one yet (wires the existing
              // generateCard cubit method / GenerateMemberCard RPC).
              if (_cardIssuanceEnabled &&
                  !member.hasCard &&
                  member.invitationStatus == InvitationStatus.accepted &&
                  account.isCurrentUserAdmin(_currentUserId)) ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                      _cubit.generateCard(
                        familyId: widget.familyId,
                        memberId: member.id,
                        cardName:
                            member.fullName.isNotEmpty ? member.fullName : null,
                      );
                    },
                    icon: Icon(Icons.add_card, size: 18.sp),
                    label: Text('Issue Card',
                        style: TextStyle(fontSize: 13.sp)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],

              // Actions
              if (member.role != FamilyMemberRole.admin) ...[
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Get.back();
                          Get.toNamed(
                            AppRoutes.familyEditMemberLimits,
                            arguments: {
                              'familyId': widget.familyId,
                              'member': member,
                            },
                          );
                        },
                        icon: Icon(Icons.edit, size: 18.sp),
                        label: Text('Edit Limits', style: TextStyle(fontSize: 13.sp)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.1),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Get.back();
                          _showAllocateFundsDialog(member);
                        },
                        icon: Icon(Icons.account_balance_wallet, size: 18.sp),
                        label: Text('Allocate', style: TextStyle(fontSize: 13.sp)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _kFamilyPurple,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailStat(String label, String value, {Color? valueColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.5),
            fontSize: 11.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildLimitBar(String label, double used, double limit) {
    final percentage = limit > 0 ? (used / limit).clamp(0.0, 1.0) : 0.0;
    final percentText = (percentage * 100).toStringAsFixed(0);
    final barColor = percentage > 0.8
        ? const Color(0xFFEF4444)
        : percentage > 0.5
            ? const Color(0xFFFB923C)
            : const Color(0xFF10B981);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 12.sp,
              ),
            ),
            Text(
              '${CurrencySymbols.currentSymbol}${used.toStringAsFixed(2)} / ${CurrencySymbols.currentSymbol}${limit.toStringAsFixed(2)} ($percentText%)',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Container(
          height: 6.h,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(3.r),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage,
            child: Container(
              decoration: BoxDecoration(
                color: barColor,
                borderRadius: BorderRadius.circular(3.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _confirmRemoveMember(FamilyMember member) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF0A0A0A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Remove ${member.fullName}?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'This will remove ${member.fullName} from the family account. Their remaining balance will be returned to the pool.',
          style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              _cubit.removeMember(
                familyId: widget.familyId,
                memberId: member.id,
                reason: 'Removed by admin',
                returnBalanceToPool: true,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Remove',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  /// Presents a family-flow error as a modal dialog (never a snackbar). The
  /// backend prefixes funding-permission rejections with "funding policy:" so we
  /// can render a clear, friendly "who can fund" explanation with the right title.
  void _showFamilyErrorDialog(String rawMessage) {
    if (!mounted) return;
    final msg = rawMessage.toLowerCase();
    String title = 'Something went wrong';
    String body = rawMessage;
    if (msg.contains('funding policy') ||
        msg.contains('only the creator') ||
        msg.contains('only selected members') ||
        msg.contains('contributions are not allowed')) {
      title = 'You can\'t add money here';
      if (msg.contains('only the creator')) {
        body =
            'Only the account creator can add money to this pool. Ask them to fund it, or switch to a pool you can contribute to.';
      } else if (msg.contains('only selected members')) {
        body =
            'Only selected members can add money to this pool. Ask an admin to enable funding for you.';
      } else {
        body =
            'Member contributions are turned off for this family account. An admin can enable them in the account settings.';
      }
    } else if (msg.contains('does not belong') || msg.contains('permission')) {
      title = 'Not allowed';
      body =
          'This action isn\'t available on this account. If you think that\'s a mistake, contact the account owner.';
    } else if (msg.contains('exceed') || msg.contains('insufficient')) {
      title = 'Allocation exceeds balance';
    }
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600)),
        content: Text(body,
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.75), fontSize: 14.sp)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            style: TextButton.styleFrom(foregroundColor: _kFamilyPurple),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  void _showContributeDialog(FamilyAccount account) {
    final amountController = TextEditingController();
    final descriptionController = TextEditingController();
    final symbol = CurrencySymbols.currentSymbol;

    // Resolve the contributor's own member id up front — only an actual member
    // may contribute, and the money moves from THIS user's personal account.
    String? myMemberId;
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      final uid = authState.profile.userId;
      myMemberId =
          account.members.where((m) => m.userId == uid).firstOrNull?.id;
    }

    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Contribute to Pool',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Move money from your personal account into the shared pool for everyone to use.',
              style: GoogleFonts.inter(
                  color: Colors.grey[400], fontSize: 13.sp),
            ),
            SizedBox(height: 16.h),
            // From → To money path so the source is unambiguous.
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                children: [
                  _buildContributeFlowRow(
                    Icons.account_balance_wallet_outlined,
                    'From',
                    'Your Personal Account',
                    const Color(0xFF3B82F6),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    child: Icon(Icons.arrow_downward,
                        size: 16.sp, color: const Color(0xFF9CA3AF)),
                  ),
                  _buildContributeFlowRow(
                    Icons.family_restroom,
                    'To',
                    '${account.name} pool',
                    _kFamilyPurple,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: TextStyle(color: Colors.grey[400]),
                prefixText: '$symbol ',
                prefixStyle: GoogleFonts.inter(
                  color: const Color(0xFF10B981),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: descriptionController,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
              decoration: InputDecoration(
                labelText: 'Note (Optional)',
                labelStyle: TextStyle(color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(color: Colors.grey[400]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text.trim()) ?? 0;
              // Validation: positive amount (modal dialog, not a snackbar).
              if (amount <= 0) {
                showDialog<void>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: const Color(0xFF1F1F1F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    title: Text('Enter an amount',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600)),
                    content: Text(
                        'Please enter a valid amount greater than zero.',
                        style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.75),
                            fontSize: 14.sp)),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        style: TextButton.styleFrom(
                            foregroundColor: _kFamilyPurple),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
                return;
              }
              // Validation: caller must be a member (money leaves THEIR wallet).
              if (myMemberId == null || myMemberId.isEmpty) {
                Get.back();
                _showFamilyErrorDialog(
                    'Only family members can contribute to the pool.');
                return;
              }
              Get.back();
              // Real money move: backend debits this user's personal account and
              // credits the family pool (insufficient-balance is rejected
              // server-side and surfaced via the error listener).
              _cubit.contributeToPool(
                familyId: widget.familyId,
                memberId: myMemberId,
                amount: amount,
                description: descriptionController.text.trim().isEmpty
                    ? null
                    : descriptionController.text.trim(),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Contribute',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  /// One row of the Contribute "From → To" money-path card.
  Widget _buildContributeFlowRow(
      IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 16.sp),
        ),
        SizedBox(width: 10.w),
        Text(
          label,
          style: GoogleFonts.inter(color: Colors.grey[500], fontSize: 12.sp),
        ),
        const Spacer(),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  /// Account-details card for the settings sheet: the pool's real bank name +
  /// NUBAN once provisioned (a "Setting up…" note while processing), plus the
  /// funding policy so members know who can add money.
  Widget _buildAccountDetailsCard(FamilyAccount account) {
    final processing = account.isVirtualAccountProcessing;
    final hasNuban = (account.accountNumber?.isNotEmpty ?? false);
    String policyLine;
    switch (account.fundingPolicy) {
      case 'creator_only':
        policyLine = 'Only the creator can add money';
        break;
      case 'specific_members':
        policyLine = 'Only selected members can add money';
        break;
      default:
        policyLine = 'Any member can add money';
    }

    Widget row(IconData icon, String label, String value) => Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: Row(
            children: [
              Icon(icon, size: 16.sp, color: Colors.white.withValues(alpha: 0.5)),
              SizedBox(width: 10.w),
              Text(label,
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.55),
                      fontSize: 12.sp)),
              const Spacer(),
              Flexible(
                child: Text(value,
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Account details',
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600)),
          SizedBox(height: 6.h),
          if (processing)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              child: Row(
                children: [
                  SizedBox(
                    width: 13.w,
                    height: 13.w,
                    child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(_kFamilyPurple)),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      'Setting up your account — your deposit account number will appear here once ready.',
                      style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 12.sp),
                    ),
                  ),
                ],
              ),
            )
          else if (hasNuban) ...[
            row(Icons.account_balance_outlined, 'Bank',
                account.bankName?.isNotEmpty == true ? account.bankName! : '—'),
            row(Icons.numbers, 'Account number', account.accountNumber!),
          ],
          row(Icons.group_outlined, 'Funding', policyLine),
        ],
      ),
    );
  }

  void _showAccountSettings(FamilyAccount account) {
    // Resolved once at sheet-open time so we don't re-read the auth
    // cubit per option render. If the user signs out while the sheet is
    // open, the buttons fail open (no-op visually, server rejects).
    final viewerIsAdmin = account.isCurrentUserAdmin(_currentUserId);
    final viewerIsCreator = account.isCurrentUserCreator(_currentUserId);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        decoration: BoxDecoration(
          // Lifted surface: lighter than the 0xFF0A0A0A page background.
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 16.h),

            Text(
              'Account Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),

            _buildAccountDetailsCard(account),
            SizedBox(height: 12.h),

            // Account statement — available to every member (read-only export).
            _buildOption(
              Icons.receipt_long_outlined,
              'Account Statement',
              'View and share a PDF statement',
              () {
                Get.back();
                Get.to(() => FamilyAccountReportScreen(account: account));
              },
            ),

            // Role gating mirrors the backend RPCs:
            //   • Change distribution / freeze / unfreeze: family admin only
            //   • Delete: creator only
            //   • Sent invitations: admin only (read-only history of
            //     invites the admin has sent for this family)
            // Non-admin members see only the read-only options.
            if (viewerIsAdmin) ...[
              _buildOption(
                Icons.send_outlined,
                'Sent Invitations',
                'See invitations you sent for this family',
                () {
                  Get.back();
                  Get.toNamed(
                    AppRoutes.familySentInvitations,
                    arguments: {'familyId': widget.familyId},
                  );
                },
              ),
              SizedBox(height: 12.h),
            ],
            if (viewerIsAdmin && account.status == FamilyAccountStatus.active) ...[
              _buildOption(
                Icons.swap_horiz,
                'Change Distribution Mode',
                'Switch how funds are distributed',
                () {
                  Get.back();
                  _showDistributionModePicker(account);
                },
              ),
              SizedBox(height: 12.h),
            ],
            if (viewerIsAdmin)
              _buildOption(
                account.status == FamilyAccountStatus.active
                    ? Icons.ac_unit
                    : Icons.wb_sunny,
                account.status == FamilyAccountStatus.active ? 'Freeze Account' : 'Unfreeze Account',
                account.status == FamilyAccountStatus.active
                    ? 'Temporarily freeze all spending'
                    : 'Reactivate account',
                () {
                  Get.back();
                  if (account.status == FamilyAccountStatus.active) {
                    _confirmFreezeAccount(account);
                  } else {
                    _confirmUnfreezeAccount(account);
                  }
                },
              ),
            if (viewerIsAdmin) SizedBox(height: 12.h),
            if (viewerIsCreator)
              _buildOption(
                Icons.delete_outline,
                'Delete Account',
                'Permanently delete family account',
                () {
                  Get.back();
                  _confirmDeleteAccount(account);
                },
                color: Colors.red,
              ),
            // Self-serve leave: any accepted non-creator member. Their
            // allocation returns to the pool; the creator must delete instead.
            if (!viewerIsCreator &&
                _currentUserId != null &&
                account.members.any((m) =>
                    m.userId == _currentUserId &&
                    m.invitationStatus == InvitationStatus.accepted))
              _buildOption(
                Icons.exit_to_app,
                'Leave Family',
                'Leave this family account',
                () {
                  Get.back();
                  _confirmLeaveFamily(account);
                },
                color: Colors.red,
              ),
            if (!viewerIsAdmin && !viewerIsCreator)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                child: Text(
                  'Only family admins can change account settings.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 12.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  void _showDistributionModePicker(FamilyAccount account) {
    FundDistributionMode selectedMode = account.fundDistributionMode;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: const Color(0xFF0A0A0A),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Change Distribution Mode',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Current: ${account.fundDistributionMode.displayName}',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 13.sp),
              ),
              SizedBox(height: 20.h),
              ...FundDistributionMode.values.map((mode) {
                final isSelected = selectedMode == mode;
                final isCurrent = account.fundDistributionMode == mode;
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: InkWell(
                    onTap: () => setSheetState(() => selectedMode = mode),
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF2D2B6B).withValues(alpha: 0.3)
                            : const Color(0xFF1F1F1F),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF7C6BF0)
                              : Colors.white.withValues(alpha: 0.1),
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                            color: isSelected ? const Color(0xFF7C6BF0) : Colors.white.withValues(alpha: 0.4),
                            size: 20.sp,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      mode.displayName,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if (isCurrent) ...[
                                      SizedBox(width: 8.w),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF7C6BF0).withValues(alpha: 0.2),
                                          borderRadius: BorderRadius.circular(4.r),
                                        ),
                                        child: Text(
                                          'Current',
                                          style: TextStyle(
                                            color: const Color(0xFFB8ABFF),
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  mode.description,
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.5),
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(height: 8.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedMode == account.fundDistributionMode
                      ? null
                      : () {
                          Get.back();
                          _cubit.updateDistributionMode(
                            familyId: widget.familyId,
                            fundDistributionMode: selectedMode.value,
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kFamilyPurple,
                    disabledBackgroundColor: _kFamilyPurple.withValues(alpha: 0.3),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Update Distribution Mode',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmFreezeAccount(FamilyAccount account) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF0A0A0A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Freeze ${account.name}?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'This will temporarily freeze all spending on this family account. You can unfreeze it at any time.',
          style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              _cubit.freezeAccount(familyId: widget.familyId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _kFamilyPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Freeze',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmUnfreezeAccount(FamilyAccount account) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF0A0A0A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Unfreeze ${account.name}?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'This will reactivate the account and allow spending again.',
          style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              _cubit.unfreezeAccount(widget.familyId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Unfreeze',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmLeaveFamily(FamilyAccount account) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(
          'Leave ${account.name}?',
          style: GoogleFonts.inter(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'You will be removed from this family account. Any funds allocated to you will return to the shared pool.',
          style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel', style: GoogleFonts.inter(color: Colors.grey[400])),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              _cubit.leaveFamily(familyId: widget.familyId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
            child: Text('Leave', style: GoogleFonts.inter(fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteAccount(FamilyAccount account) {
    final confirmationController = TextEditingController();

    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF0A0A0A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Delete ${account.name}?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'This action cannot be undone. All remaining funds will be returned to your account.',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14.sp),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: confirmationController,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
              decoration: InputDecoration(
                // The backend requires the confirmation code to match the family
                // account NAME (case-insensitive), so prompt for exactly that.
                hintText: 'Type "${account.name}" to confirm',
                hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.4)),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Match the account NAME (case-insensitive) and send the typed
              // value AS the confirmation code — the backend validates
              // confirmation_code == family account name (EqualFold). Sending a
              // literal like 'USER_CONFIRMED' always failed InvalidArgument.
              final typed = confirmationController.text.trim();
              if (typed.toLowerCase() == account.name.trim().toLowerCase()) {
                Get.back();
                _cubit.deleteAccount(
                  familyId: widget.familyId,
                  confirmationCode: typed,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: SafeArea(
          child: BlocConsumer<FamilyAccountCubit, FamilyAccountState>(
          bloc: _cubit,
          listener: (context, state) {
            if (state is FamilyAccountLoaded) {
              _loadedAccount = state.familyAccount;
            } else if (state is FamilyAccountError) {
              // Money/action errors surface as a modal dialog (not a primitive
              // snackbar) — with a tailored message for the funding-policy block.
              _showFamilyErrorDialog(state.message);
            } else if (state is FamilyMemberAdded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Member added successfully'),
                  backgroundColor: Colors.green,
                ),
              );
              _loadFamilyAccount();
            } else if (state is FamilyMemberRemoved) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Member removed. ${CurrencySymbols.currentSymbol}${state.returnedBalance.toStringAsFixed(2)} returned to pool'),
                  backgroundColor: Colors.green,
                ),
              );
              _loadFamilyAccount();
              _refreshDashboardSummaries();
            } else if (state is FundsAllocated) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Funds allocated successfully'),
                  backgroundColor: Colors.green,
                ),
              );
              _loadFamilyAccount();
              _refreshDashboardSummaries();
            } else if (state is MemberCardGenerated) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Card issued for ${state.member.fullName.isNotEmpty ? state.member.fullName : 'member'}'),
                  backgroundColor: Colors.green,
                ),
              );
              _loadFamilyAccount();
            } else if (state is FamilyAccountFrozen) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Account frozen successfully'),
                  backgroundColor: Colors.green,
                ),
              );
              _loadFamilyAccount();
              _refreshDashboardSummaries();
            } else if (state is FamilyAccountUnfrozen) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Account unfrozen successfully'),
                  backgroundColor: Colors.green,
                ),
              );
              _loadFamilyAccount();
              _refreshDashboardSummaries();
            } else if (state is MemberContributionProcessed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Contribution processed successfully'),
                  backgroundColor: Colors.green,
                ),
              );
              _loadFamilyAccount();
              _refreshDashboardSummaries();
            } else if (state is FundDistributionModeUpdated) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Distribution mode updated successfully'),
                  backgroundColor: Colors.green,
                ),
              );
              _loadFamilyAccount();
              _refreshDashboardSummaries();
            } else if (state is FamilyAccountDeleted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Account deleted. ${CurrencySymbols.currentSymbol}${state.returnedBalance.toStringAsFixed(2)} returned'),
                  backgroundColor: Colors.green,
                ),
              );
              Get.back(); // Go back to previous screen
            } else if (state is FamilyAccountLeft) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('You have left the family account'),
                  backgroundColor: Colors.green,
                ),
              );
              Get.back(); // Pop back to the list
            }
          },
          builder: (context, state) {
            if (state is FamilyAccountLoading && _loadedAccount == null) {
              return Column(
                children: [
                  _buildBackHeader('Family Account'),
                  Expanded(
                    child: Center(
                      child: LazerVaultLoader.small(),
                    ),
                  ),
                ],
              );
            }

            // Render the loaded account from the current state OR the cached
            // copy — so a transient action error (which emits FamilyAccountError)
            // keeps the screen instead of blanking it (the error shows as a
            // snackbar via the listener). Only fall through to the "Unable to
            // load" view when nothing was ever loaded.
            final account = state is FamilyAccountLoaded
                ? state.familyAccount
                : _loadedAccount;
            if (account != null) {
              return Column(
                children: [
                  // Group-funds-style header: back + name + settings
                  _buildFamilyHeader(account),
                  // Purple hero with the family balance + key stats
                  _buildFamilyHero(account),
                  // Prominent Fund action: top up the pool + allocate to members
                  _buildFundActions(account),
                  SizedBox(height: 4.h),
                  // Purple pill tab bar (matches group details)
                  _buildFamilyTabBar(),
                  // Tab Content
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildOverviewTab(account),
                        _buildMembersTab(account),
                        _buildActivityTab(account),
                      ],
                    ),
                  ),
                ],
              );
            }

            return Column(
              children: [
                _buildBackHeader('Family Account'),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.error_outline,
                            color: Colors.white.withValues(alpha: 0.6), size: 40.sp),
                        SizedBox(height: 12.h),
                        Text(
                          'Unable to load account',
                          style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
                        ),
                        SizedBox(height: 16.h),
                        ElevatedButton.icon(
                          onPressed: _loadFamilyAccount,
                          icon: Icon(Icons.refresh, size: 18.sp),
                          label: const Text('Retry'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _kFamilyPurple,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          ),
        ),
      ),
    );
  }

  /// Brand purple shared with the group-funds (joint) UI, used across the
  /// redesigned header, hero card, tab bar and primary actions so the Family
  /// & Friends detail screen matches the group landing page.
  static const Color _kFamilyPurple = Color.fromARGB(255, 78, 3, 208);

  /// Minimal back header used for the loading / error states (the full header
  /// needs a loaded account).
  Widget _buildBackHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// Group-funds-style header: back button in a dark rounded box, the family
  /// name + description, and a settings affordance on the right.
  Widget _buildFamilyHeader(FamilyAccount account) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  account.name,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (account.description != null &&
                    account.description!.isNotEmpty)
                  Text(
                    account.description!,
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 13.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _showAccountSettings(account),
            child: Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.settings_outlined, color: Colors.white, size: 20.sp),
            ),
          ),
        ],
      ),
    );
  }

  /// Purple gradient hero mirroring the group-funds overview card: the family
  /// balance headline plus Members / Pool / Spent-today stats and a pool
  /// utilization bar.
  Widget _buildFamilyHero(FamilyAccount account) {
    final symbol = CurrencySymbols.currentSymbol;
    final isSharedPool =
        account.fundDistributionMode == FundDistributionMode.sharedPool;
    final spendable =
        isSharedPool ? account.totalPoolBalance : account.totalAllocatedBalance;
    final spentToday =
        account.members.fold<double>(0, (s, m) => s + m.spentToday);
    final total = account.totalBalance > 0
        ? account.totalBalance
        : (account.totalPoolBalance + account.totalAllocatedBalance);
    final usedFraction = total > 0 ? (spentToday / total).clamp(0.0, 1.0) : 0.0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _kFamilyPurple,
            _kFamilyPurple.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: _kFamilyPurple.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.family_restroom,
                  color: Colors.white.withValues(alpha: 0.9), size: 16.sp),
              SizedBox(width: 6.w),
              Text(
                isSharedPool ? 'Shared Pool Balance' : 'Family Balance',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.white.withValues(alpha: 0.85),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            '$symbol${spendable.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              _buildHeroStat('Members', '${account.activeMemberCount}', Icons.people),
              Container(
                width: 1,
                height: 30.h,
                color: Colors.white.withValues(alpha: 0.2),
              ),
              _buildHeroStat(
                'Allocated',
                '$symbol${account.totalAllocatedBalance.toStringAsFixed(0)}',
                Icons.pie_chart,
              ),
              Container(
                width: 1,
                height: 30.h,
                color: Colors.white.withValues(alpha: 0.2),
              ),
              _buildHeroStat(
                'Spent Today',
                '$symbol${spentToday.toStringAsFixed(0)}',
                Icons.trending_up,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            height: 5.h,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(3.r),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: usedFraction,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroStat(String title, String value, IconData icon) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white.withValues(alpha: 0.85), size: 14.sp),
              SizedBox(width: 4.w),
              Flexible(
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFamilyTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: _kFamilyPurple,
          borderRadius: BorderRadius.circular(12.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[400],
        labelStyle: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 13.sp),
        tabs: const [
          Tab(text: 'Overview'),
          Tab(text: 'Members'),
          Tab(text: 'Activity'),
        ],
      ),
    );
  }

  /// Funding + spending breakdown for the Overview tab: monthly stat tiles, a
  /// "Contributors" list (who funded the pool + how much), and a "Top spenders"
  /// list. Backed by account.summary (GetFamilyAccount). Renders nothing until
  /// the summary is available. Spenders respect the spending-visibility gate;
  /// funders (contributions) are shown to every member.
  Widget _buildFamilyStatsSection(FamilyAccount account) {
    final s = account.summary;
    if (s == null) return const SizedBox.shrink();
    final symbol = CurrencySymbols.currentSymbol;
    final canSeeSpenders = _canSeeAllSpending(account);
    String money(double v) => '$symbol${v.toStringAsFixed(2)}';

    Widget statTile(String label, String value, IconData icon, Color color) {
      return Expanded(
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 16.sp),
              SizedBox(height: 8.h),
              Text(value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700)),
              SizedBox(height: 2.h),
              Text(label,
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5), fontSize: 10.sp)),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('This month',
            style: TextStyle(
                color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 12.h),
        Row(
          children: [
            statTile('Funded', money(s.totalContributed),
                Icons.volunteer_activism, const Color(0xFF10B981)),
            // Spent + transaction-count are spending-derived; the backend already
            // zeroes them for members who can't see spending, and we hide the tiles
            // so a non-admin never sees even the family-wide spend count.
            if (canSeeSpenders) ...[
              SizedBox(width: 10.w),
              statTile('Spent', money(s.totalSpentThisMonth),
                  Icons.shopping_cart_outlined, const Color(0xFFEF4444)),
              SizedBox(width: 10.w),
              statTile('Transactions', '${s.transactionCountThisMonth}',
                  Icons.receipt_long_outlined, _kFamilyPurple),
            ],
          ],
        ),
        if (s.topFunders.isNotEmpty) ...[
          SizedBox(height: 20.h),
          _breakdownHeader('Contributors', 'Who funded the pool this month'),
          SizedBox(height: 10.h),
          ...s.topFunders.map((m) => _buildBreakdownRow(m, money, isFunder: true)),
        ],
        if (canSeeSpenders && s.topSpenders.isNotEmpty) ...[
          SizedBox(height: 20.h),
          _breakdownHeader('Top spenders', 'Who spent from the pool this month'),
          SizedBox(height: 10.h),
          ...s.topSpenders.map((m) => _buildBreakdownRow(m, money, isFunder: false)),
        ],
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _breakdownHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 2.h),
        Text(subtitle,
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5), fontSize: 11.sp)),
      ],
    );
  }

  Widget _buildBreakdownRow(
      FamilyMemberSpending m, String Function(double) money,
      {required bool isFunder}) {
    final accent = isFunder ? const Color(0xFF10B981) : const Color(0xFFEF4444);
    final name = m.memberName.isNotEmpty ? m.memberName : 'Member';
    final initial = name.trim().isNotEmpty ? name.trim()[0].toUpperCase() : '?';
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16.r,
            backgroundColor: accent.withValues(alpha: 0.18),
            backgroundImage: (m.memberAvatar != null && m.memberAvatar!.isNotEmpty)
                ? NetworkImage(m.memberAvatar!)
                : null,
            child: (m.memberAvatar == null || m.memberAvatar!.isEmpty)
                ? Text(initial,
                    style: TextStyle(
                        color: accent, fontSize: 13.sp, fontWeight: FontWeight.w700))
                : null,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: 13.sp)),
                Text(
                    '${m.transactionCount} ${isFunder ? (m.transactionCount == 1 ? 'contribution' : 'contributions') : (m.transactionCount == 1 ? 'transaction' : 'transactions')}',
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.45), fontSize: 10.sp)),
              ],
            ),
          ),
          Text('${isFunder ? '+' : '-'}${money(m.amountSpent)}',
              style: GoogleFonts.inter(
                  color: accent, fontSize: 13.sp, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(FamilyAccount account) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),

          // Account Status
          Builder(builder: (context) {
            final (statusColor, statusIcon, statusLabel) = switch (account.status) {
              FamilyAccountStatus.active => (Colors.green, Icons.check_circle, 'Account Active'),
              FamilyAccountStatus.frozen => (Colors.blue, Icons.ac_unit, 'Account Frozen'),
              FamilyAccountStatus.pendingSetup => (const Color(0xFFFB923C), Icons.settings, 'Pending Setup'),
              FamilyAccountStatus.closed => (Colors.red, Icons.cancel, 'Account Closed'),
            };
            return Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: statusColor.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(statusIcon, color: statusColor, size: 20.sp),
                  SizedBox(width: 12.w),
                  Text(
                    statusLabel,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }),
          SizedBox(height: 20.h),

          // Funding + spending breakdown (who funded, top spenders, monthly stats).
          _buildFamilyStatsSection(account),

          // Settings Info
          Text(
            'Settings',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            Icons.category_outlined,
            'Distribution Mode',
            account.fundDistributionMode.displayName,
          ),
          SizedBox(height: 8.h),
          _buildInfoRow(
            Icons.visibility_outlined,
            'Spending Visibility',
            account.spendingVisibilityEnabled ? 'Enabled' : 'Disabled',
          ),
          SizedBox(height: 8.h),
          _buildInfoRow(
            Icons.people_outline,
            'Member Contributions',
            account.allowMemberContributions ? 'Enabled' : 'Disabled',
          ),
          SizedBox(height: 8.h),
          _buildInfoRow(
            Icons.person,
            'Created by',
            account.creatorName,
          ),
          SizedBox(height: 8.h),
          _buildInfoRow(
            Icons.calendar_today,
            'Created',
            '${account.createdAt.day}/${account.createdAt.month}/${account.createdAt.year}',
          ),
          if (account.allowMemberContributions) ...[
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton.icon(
                onPressed: () => _showContributeDialog(account),
                icon: Icon(Icons.volunteer_activism, size: 20.sp),
                label: Text(
                  'Contribute to Pool',
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
          ],
          SizedBox(height: 30.h),
        ],
      ),
    );
  }

  Widget _buildMembersTab(FamilyAccount account) {
    // Mirrors the backend AddFamilyMember admin-only check — non-admins
    // see the members list read-only without the Add Member CTA.
    final canInvite = account.isCurrentUserAdmin(_currentUserId) &&
        account.canAcceptMembers;
    return RefreshIndicator(
      onRefresh: () async => _loadFamilyAccount(),
      color: _kFamilyPurple,
      backgroundColor: const Color(0xFF1F1F1F),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          // Group-funds-style header: "N Members" with an Add affordance.
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${account.members.length} Members',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  if (canInvite)
                    ElevatedButton.icon(
                      onPressed: _showAddMemberSheet,
                      icon: Icon(Icons.add, size: 16.sp),
                      label: Text(
                        'Add Member',
                        style: GoogleFonts.inter(fontSize: 12.sp),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _kFamilyPurple,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) =>
                    _buildMemberCard(account, account.members[index]),
                childCount: account.members.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTab(FamilyAccount account) {
    final activeMembers = account.members
        .where((m) => m.invitationStatus == InvitationStatus.accepted)
        .toList();

    // Spending-visibility gate: when the viewer may not see everyone's
    // spending, hide the per-member filter and restrict the activity list to
    // the viewer's own transactions.
    final canSeeAll = _canSeeAllSpending(account);
    String? myMemberId;
    final uid = _currentUserId;
    if (uid != null) {
      for (final m in account.members) {
        if (m.userId == uid) {
          myMemberId = m.id;
          break;
        }
      }
    }

    return Column(
      children: [
        if (!canSeeAll)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Row(
              children: [
                Icon(Icons.lock_outline,
                    size: 13.sp, color: Colors.white.withValues(alpha: 0.5)),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    'Only your activity is shown. The account owner controls spending visibility.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 11.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        // Two clean dropdown controls — one at the left (members), one at the
        // right (type + time) — instead of scrolling pill rows. Each opens a
        // bottom sheet the user picks from, keeping the header uncluttered.
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          child: Row(
            children: [
              if (canSeeAll)
                Expanded(
                  child: _buildFilterDropdown(
                    icon: Icons.people_alt_outlined,
                    label: _memberFilterLabel(activeMembers),
                    onTap: () => _openMemberFilterSheet(activeMembers),
                  ),
                ),
              if (canSeeAll) SizedBox(width: 10.w),
              Expanded(
                child: _buildFilterDropdown(
                  icon: Icons.tune,
                  label: _typeTimeFilterLabel(),
                  onTap: _openTypeTimeFilterSheet,
                ),
              ),
            ],
          ),
        ),
        // Transaction list
        Expanded(
          child: BlocBuilder<FamilyAccountCubit, FamilyAccountState>(
            bloc: _transactionsCubit,
            builder: (context, state) {
              if (state is FamilyAccountLoading) {
                return Center(
                  child: LazerVaultLoader.small(),
                );
              }
              if (state is FamilyTransactionsLoaded) {
                // Restrict to own rows when visibility is gated. If we can't
                // resolve the viewer's member id, fail closed to empty rather
                // than leaking everyone's activity.
                final visibleTxns = canSeeAll
                    ? state.transactions
                    : state.transactions
                        .where((t) => myMemberId != null && t.memberId == myMemberId)
                        .toList();
                if (visibleTxns.isEmpty) {
                  // Keep pull-to-refresh available even when empty so a member
                  // can re-pull after spending without leaving the screen.
                  return RefreshIndicator(
                    onRefresh: () async => _loadTransactions(),
                    color: _kFamilyPurple,
                    backgroundColor: const Color(0xFF1F1F1F),
                    child: _buildEmptyActivityState(),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async => _loadTransactions(),
                  color: _kFamilyPurple,
                  backgroundColor: const Color(0xFF1F1F1F),
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: visibleTxns.length,
                    itemBuilder: (context, index) {
                      return _buildTransactionCard(visibleTxns[index]);
                    },
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () async => _loadTransactions(),
                color: _kFamilyPurple,
                backgroundColor: const Color(0xFF1F1F1F),
                child: _buildEmptyActivityState(),
              );
            },
          ),
        ),
      ],
    );
  }

  // ── Activity filters: two dropdown controls → bottom sheets ──────────────

  /// A single dropdown-style control (icon + label + chevron). Active when a
  /// non-default filter is applied (purple accent), neutral otherwise.
  Widget _buildFilterDropdown({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 11.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 15.sp, color: Colors.white.withValues(alpha: 0.6)),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(Icons.keyboard_arrow_down,
                size: 18.sp, color: Colors.white.withValues(alpha: 0.5)),
          ],
        ),
      ),
    );
  }

  String _memberFilterLabel(List<FamilyMember> members) {
    if (_memberFilter == null) return 'All members';
    for (final m in members) {
      if (m.id == _memberFilter) {
        return m.fullName.isNotEmpty ? m.fullName : (m.username ?? 'Member');
      }
    }
    return 'Member';
  }

  String _typeTimeFilterLabel() {
    final parts = <String>[];
    if (_transactionFilter != null) {
      parts.add(_transactionTypeLabel(_transactionFilter!));
    }
    if (_dateFilter != null) parts.add(_dateRangeLabel(_dateFilter!));
    return parts.isEmpty ? 'All activity' : parts.join(' · ');
  }

  String _transactionTypeLabel(FamilyTransactionType t) {
    switch (t) {
      case FamilyTransactionType.allocation:
        return 'Allocations';
      case FamilyTransactionType.spending:
        return 'Spending';
      case FamilyTransactionType.refund:
        return 'Refunds';
      case FamilyTransactionType.contribution:
        return 'Contributions';
      case FamilyTransactionType.adjustment:
        return 'Adjustments';
      case FamilyTransactionType.removal:
        return 'Removals';
    }
  }

  String _dateRangeLabel(DateTimeRange r) {
    final f = DateFormat('d MMM');
    return '${f.format(r.start)}–${f.format(r.end)}';
  }

  void _openMemberFilterSheet(List<FamilyMember> members) {
    _showFilterBottomSheet(
      title: 'Filter by member',
      children: [
        _filterSheetTile(
          label: 'All members',
          selected: _memberFilter == null,
          onTap: () {
            setState(() => _memberFilter = null);
            _loadTransactions();
          },
        ),
        ...members.map((m) => _filterSheetTile(
              label: m.fullName.isNotEmpty ? m.fullName : (m.username ?? 'Member'),
              icon: Icons.person,
              selected: _memberFilter == m.id,
              onTap: () {
                setState(() => _memberFilter = m.id);
                _loadTransactions();
              },
            )),
      ],
    );
  }

  void _openTypeTimeFilterSheet() {
    const types = <FamilyTransactionType?>[
      null,
      FamilyTransactionType.allocation,
      FamilyTransactionType.spending,
      FamilyTransactionType.refund,
      FamilyTransactionType.contribution,
    ];
    _showFilterBottomSheet(
      title: 'Filter activity',
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.w, top: 4.h, bottom: 4.h),
          child: Text('Type',
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.4), fontSize: 11.sp)),
        ),
        ...types.map((t) => _filterSheetTile(
              label: t == null ? 'All types' : _transactionTypeLabel(t),
              selected: _transactionFilter == t,
              onTap: () {
                setState(() => _transactionFilter = t);
                _loadTransactions();
              },
            )),
        Divider(color: Colors.white.withValues(alpha: 0.08), height: 20.h),
        Padding(
          padding: EdgeInsets.only(left: 20.w, bottom: 4.h),
          child: Text('Time',
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.4), fontSize: 11.sp)),
        ),
        _filterSheetTile(
          label: 'All time',
          selected: _dateFilter == null,
          onTap: () {
            setState(() => _dateFilter = null);
            _loadTransactions();
          },
        ),
        _filterSheetTile(
          label: 'Last 7 days',
          selected: _isPresetRange(7),
          onTap: () => _applyPresetRange(7),
        ),
        _filterSheetTile(
          label: 'Last 30 days',
          selected: _isPresetRange(30),
          onTap: () => _applyPresetRange(30),
        ),
        _filterSheetTile(
          label: 'Custom range…',
          icon: Icons.calendar_today_outlined,
          selected: false,
          onTap: _pickCustomDateRange,
        ),
      ],
    );
  }

  bool _isPresetRange(int days) {
    final r = _dateFilter;
    if (r == null) return false;
    final now = DateTime.now();
    return r.end.difference(now).inDays.abs() <= 1 &&
        r.start.difference(now.subtract(Duration(days: days))).inDays.abs() <= 1;
  }

  void _applyPresetRange(int days) {
    final now = DateTime.now();
    setState(() {
      _dateFilter = DateTimeRange(
        start: now.subtract(Duration(days: days)),
        end: now,
      );
    });
    _loadTransactions();
  }

  Future<void> _pickCustomDateRange() async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 3),
      lastDate: now,
      initialDateRange: _dateFilter,
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.dark(primary: _kFamilyPurple),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      // showDateRangePicker returns dates at midnight; extend the end to the end
      // of that day so transactions later on the last day aren't excluded by the
      // backend's `created_at <= end` filter.
      final normalized = DateTimeRange(
        start: picked.start,
        end: DateTime(picked.end.year, picked.end.month, picked.end.day, 23, 59, 59),
      );
      setState(() => _dateFilter = normalized);
      _loadTransactions();
    }
  }

  void _showFilterBottomSheet({
    required String title,
    required List<Widget> children,
  }) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Column(children: children),
              ),
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  Widget _filterSheetTile({
    required String label,
    required bool selected,
    required VoidCallback onTap,
    IconData? icon,
  }) {
    return ListTile(
      dense: true,
      leading: icon != null
          ? Icon(icon, size: 18.sp, color: Colors.white.withValues(alpha: 0.6))
          : null,
      title: Text(
        label,
        style: TextStyle(
          color: selected ? _kFamilyPurple : Colors.white.withValues(alpha: 0.85),
          fontSize: 14.sp,
          fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing: selected
          ? Icon(Icons.check, size: 18.sp, color: _kFamilyPurple)
          : null,
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
    );
  }

  Widget _buildTransactionCard(FamilyTransaction transaction) {
    final isCredit = transaction.type == FamilyTransactionType.allocation ||
        transaction.type == FamilyTransactionType.refund ||
        transaction.type == FamilyTransactionType.contribution;
    final amountColor = isCredit ? const Color(0xFF10B981) : const Color(0xFFEF4444);
    final amountPrefix = isCredit ? '+' : '-';

    IconData typeIcon;
    switch (transaction.type) {
      case FamilyTransactionType.allocation:
        typeIcon = Icons.account_balance_wallet;
      case FamilyTransactionType.spending:
        typeIcon = Icons.shopping_cart;
      case FamilyTransactionType.refund:
        typeIcon = Icons.replay;
      case FamilyTransactionType.adjustment:
        typeIcon = Icons.tune;
      case FamilyTransactionType.removal:
        typeIcon = Icons.person_remove;
      case FamilyTransactionType.contribution:
        typeIcon = Icons.volunteer_activism;
    }

    final memberName =
        transaction.memberName.isNotEmpty ? transaction.memberName : 'Member';
    final subtitle = _familyTxnAction(transaction);

    return GestureDetector(
      onTap: () => _showTransactionDetail(transaction),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: amountColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(typeIcon, color: amountColor, size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // WHO performed it
                  Text(
                    memberName,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  // WHAT they did
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      color: Colors.grey[500],
                      fontSize: 12.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$amountPrefix${CurrencySymbols.currentSymbol}${transaction.amount.abs().toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: amountColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  _shortDate(transaction.createdAt),
                  style: GoogleFonts.inter(
                    color: Colors.grey[600],
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
            SizedBox(width: 4.w),
            Icon(Icons.chevron_right, color: Colors.grey[700], size: 18.sp),
          ],
        ),
      ),
    );
  }

  /// Human one-liner for what happened in a family transaction. Prefers the
  /// stored (now-cleaned) description, then builds from the recipient, then a
  /// type-based fallback — so the Activity row reads like "Sent funds to X".
  String _familyTxnAction(FamilyTransaction t) {
    String stripSentTo(String s) {
      var v = s.trim();
      final low = v.toLowerCase();
      for (final p in ['sent funds to ', 'sent to ']) {
        if (low.startsWith(p)) {
          v = v.substring(p.length).trim();
          break;
        }
      }
      return v;
    }

    final desc = t.description?.trim() ?? '';
    final merchant = t.merchantName?.trim() ?? '';
    switch (t.type) {
      case FamilyTransactionType.spending:
        if (desc.isNotEmpty) return desc;
        final who = merchant.isNotEmpty ? stripSentTo(merchant) : 'recipient';
        return 'Sent funds to ${who.isNotEmpty ? who : 'recipient'}';
      case FamilyTransactionType.contribution:
        return desc.isNotEmpty ? desc : 'Contributed to the pool';
      case FamilyTransactionType.allocation:
        return desc.isNotEmpty ? desc : 'Allocated funds';
      case FamilyTransactionType.refund:
        return desc.isNotEmpty ? desc : 'Refund received';
      case FamilyTransactionType.removal:
        return desc.isNotEmpty ? desc : 'Returned to pool on removal';
      case FamilyTransactionType.adjustment:
        return desc.isNotEmpty ? desc : 'Balance adjustment';
    }
  }

  String _shortDate(DateTime d) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final m = (d.month >= 1 && d.month <= 12) ? months[d.month - 1] : '';
    return '$m ${d.day}';
  }

  /// Detail bottom sheet for a single activity item — opened by tapping the
  /// Activity row. Lifted (0xFF1F1F1F) surface so it contrasts with the page.
  void _showTransactionDetail(FamilyTransaction transaction) {
    final isCredit = transaction.type == FamilyTransactionType.allocation ||
        transaction.type == FamilyTransactionType.refund ||
        transaction.type == FamilyTransactionType.contribution;
    final amountColor =
        isCredit ? const Color(0xFF10B981) : const Color(0xFFEF4444);
    final amountPrefix = isCredit ? '+' : '-';
    final symbol = CurrencySymbols.currentSymbol;
    final memberName =
        transaction.memberName.isNotEmpty ? transaction.memberName : 'Member';
    // The family account this transaction belongs to — threaded onto the
    // receipt so it's clear which family & friends account it came from.
    final familyName = _loadedAccount?.name.trim() ?? '';
    final reference = transaction.transactionId ??
        (transaction.metadata?['payment_ref']?.toString() ?? '—');
    final d = transaction.createdAt;
    final dateStr = '${_shortDate(d)}, ${d.year} · '
        '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

    IconData typeIcon;
    switch (transaction.type) {
      case FamilyTransactionType.allocation:
        typeIcon = Icons.account_balance_wallet;
      case FamilyTransactionType.spending:
        typeIcon = Icons.shopping_cart;
      case FamilyTransactionType.refund:
        typeIcon = Icons.replay;
      case FamilyTransactionType.adjustment:
        typeIcon = Icons.tune;
      case FamilyTransactionType.removal:
        typeIcon = Icons.person_remove;
      case FamilyTransactionType.contribution:
        typeIcon = Icons.volunteer_activism;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 28.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                color: amountColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(typeIcon, color: amountColor, size: 28.sp),
            ),
            SizedBox(height: 12.h),
            Text(
              '$amountPrefix$symbol${transaction.amount.abs().toStringAsFixed(2)}',
              style: GoogleFonts.inter(
                color: amountColor,
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              _familyTxnAction(transaction),
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.grey[300],
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 20.h),
            if (familyName.isNotEmpty)
              _buildTxnDetailRow('Account', familyName),
            _buildTxnDetailRow('Type', transaction.type.displayName),
            _buildTxnDetailRow('By', memberName),
            if ((transaction.merchantName?.isNotEmpty ?? false) &&
                transaction.type == FamilyTransactionType.spending)
              _buildTxnDetailRow('Recipient', transaction.merchantName!),
            if ((transaction.merchantCategory?.isNotEmpty ?? false) &&
                transaction.merchantCategory!.toLowerCase() != 'general' &&
                transaction.type == FamilyTransactionType.spending)
              _buildTxnDetailRow('Category', transaction.merchantCategory!),
            _buildTxnDetailRow('Date', dateStr),
            _buildTxnDetailRow('Reference', reference),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _shareTransactionReceipt(
                  transaction,
                  familyName: familyName,
                  memberName: memberName,
                  reference: reference,
                  dateStr: dateStr,
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: _kFamilyPurple,
                  side: BorderSide(color: _kFamilyPurple.withValues(alpha: 0.6)),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                icon: Icon(Icons.ios_share, size: 16.sp),
                label: Text('Share receipt',
                    style: TextStyle(
                        fontSize: 14.sp, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ASCII-safe currency label for a shared PDF (default Helvetica has no '₦'
  /// glyph → tofu). Mirrors the family statement's PDF label.
  static String _pdfCurrency(String code) {
    switch (code.toUpperCase()) {
      case 'NGN':
        return 'NGN ';
      case 'GBP':
        return 'GBP ';
      case 'EUR':
        return 'EUR ';
      case 'USD':
        return 'USD ';
      case 'ZAR':
        return 'ZAR ';
      case 'GHS':
        return 'GHS ';
      case 'KES':
        return 'KES ';
      default:
        return '$code ';
    }
  }

  /// Renders a single Family & Friends transaction to a shareable one-page PDF
  /// receipt. Reuses the same ASCII-safe currency handling as the full statement.
  Future<void> _shareTransactionReceipt(
    FamilyTransaction transaction, {
    required String familyName,
    required String memberName,
    required String reference,
    required String dateStr,
  }) async {
    try {
      final cur = _pdfCurrency(CurrencySymbols.currentCurrency);
      final isCredit = transaction.type == FamilyTransactionType.allocation ||
          transaction.type == FamilyTransactionType.refund ||
          transaction.type == FamilyTransactionType.contribution;
      final amountStr =
          '${isCredit ? '+' : '-'}$cur${transaction.amount.abs().toStringAsFixed(2)}';

      final doc = pw.Document();
      pw.Widget row(String k, String v) => pw.Padding(
            padding: const pw.EdgeInsets.symmetric(vertical: 4),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(k, style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey700)),
                pw.Text(v, style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold)),
              ],
            ),
          );

      doc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a5,
          build: (ctx) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Family & Friends Receipt',
                  style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 4),
              if (familyName.isNotEmpty)
                pw.Text(familyName, style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey700)),
              pw.SizedBox(height: 16),
              pw.Center(
                child: pw.Text(amountStr,
                    style: pw.TextStyle(fontSize: 26, fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 16),
              pw.Divider(),
              row('Type', transaction.type.displayName),
              row('By', memberName),
              if ((transaction.merchantName?.isNotEmpty ?? false) &&
                  transaction.type == FamilyTransactionType.spending)
                row('Recipient', transaction.merchantName!),
              if ((transaction.merchantCategory?.isNotEmpty ?? false) &&
                  transaction.merchantCategory!.toLowerCase() != 'general' &&
                  transaction.type == FamilyTransactionType.spending)
                row('Category', transaction.merchantCategory!),
              row('Date', dateStr),
              row('Reference', reference),
              pw.SizedBox(height: 24),
              pw.Text('Generated by Lazervault',
                  style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600)),
            ],
          ),
        ),
      );

      final bytes = await doc.save();
      await Printing.sharePdf(
        bytes: bytes,
        filename: 'family-receipt-${reference.replaceAll(RegExp(r'[^A-Za-z0-9]'), '')}.pdf',
      );
    } catch (e) {
      if (!mounted) return;
      // Surface as a dialog (not a snackbar) per the family-flow UX rules.
      showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: const Color(0xFF1F1F1F),
          title: const Text('Could not create receipt',
              style: TextStyle(color: Colors.white)),
          content: Text('Please try again.\n\n$e',
              style: const TextStyle(color: Colors.white70)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildTxnDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(color: Colors.grey[500], fontSize: 13.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyActivityState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 80.h),
        Icon(
          Icons.history,
          size: 48.sp,
          color: Colors.white.withValues(alpha: 0.3),
        ),
        SizedBox(height: 16.h),
        Center(
          child: Text(
            'No transactions yet',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Center(
          child: Text(
            'Transactions will appear here as members use the account',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 13.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  /// Best display name for a member: full name, then @username, then a
  /// generic fallback. Used for the name-based default avatar.
  String _memberDisplayName(FamilyMember member) {
    if (member.fullName.isNotEmpty) return member.fullName;
    if (member.username != null && member.username!.isNotEmpty) {
      return member.username!;
    }
    return 'Member';
  }

  /// First letter of the member's display name, for the photoless avatar.
  String _memberInitial(FamilyMember member) {
    final name = _memberDisplayName(member);
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  Widget _buildMemberCard(FamilyAccount account, FamilyMember member) {
    final isAccepted = member.invitationStatus == InvitationStatus.accepted;
    final isShared =
        account.fundDistributionMode == FundDistributionMode.sharedPool;
    final canSee = _canSeeMemberSpending(account, member);
    final symbol = CurrencySymbols.currentSymbol;
    final displayName = member.fullName.isNotEmpty
        ? member.fullName
        : (member.username != null && member.username!.isNotEmpty
            ? member.username!
            : 'Member');
    final initial = displayName.isNotEmpty ? displayName[0].toUpperCase() : '?';
    final username = member.username;
    final showUsername = username != null &&
        username.isNotEmpty &&
        username.toLowerCase() != displayName.toLowerCase();
    final remainingHealthy = member.allocatedBalance <= 0 ||
        (member.remainingBalance / member.allocatedBalance) > 0.2;

    // Trailing headline figure: shared pools track each member's spend; split /
    // custom allocations track each member's remaining allowance.
    final trailingLabel = isShared ? 'Spent' : 'Remaining';
    final trailingValue = isShared
        ? '$symbol${member.spentThisMonth.toStringAsFixed(2)}'
        : '$symbol${member.remainingBalance.toStringAsFixed(2)}';
    final trailingColor = isShared
        ? Colors.white
        : (remainingHealthy
            ? const Color(0xFF10B981)
            : const Color(0xFFFB923C));

    // Secondary one-liner under the badges.
    final secondaryLine = isShared
        ? 'Today $symbol${member.spentToday.toStringAsFixed(2)}'
        : 'Allocated $symbol${member.allocatedBalance.toStringAsFixed(2)}';

    return GestureDetector(
      onTap: () => _showMemberOptions(account, member),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: isAccepted
              ? null
              : Border.all(
                  color: _kFamilyPurple.withValues(alpha: 0.3),
                  width: 1,
                ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar — initial letter on a purple ring (matches group member card)
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: _kFamilyPurple.withValues(alpha: 0.2),
                shape: BoxShape.circle,
                border: Border.all(
                  color: _kFamilyPurple.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: (member.avatarUrl?.isNotEmpty ?? false)
                  ? ClipOval(
                      child: Image.network(member.avatarUrl!, fit: BoxFit.cover),
                    )
                  : Center(
                      child: Text(
                        initial,
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: _kFamilyPurple,
                        ),
                      ),
                    ),
            ),
            SizedBox(width: 12.w),

            // Identity + badges + a single spending summary line
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    displayName,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (showUsername) ...[
                    SizedBox(height: 2.h),
                    Text(
                      '@${username.startsWith('@') ? username.substring(1) : username}',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF3B82F6),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      _buildMemberBadge(
                        member.role == FamilyMemberRole.admin ? 'Admin' : 'Member',
                        member.role == FamilyMemberRole.admin
                            ? const Color(0xFFF59E0B)
                            : const Color(0xFF10B981),
                      ),
                      if (!isAccepted) ...[
                        SizedBox(width: 8.w),
                        _buildMemberBadge(
                          member.invitationStatus.name.toUpperCase(),
                          _kFamilyPurple,
                        ),
                      ],
                    ],
                  ),
                  if (isAccepted && canSee) ...[
                    SizedBox(height: 8.h),
                    Text(
                      secondaryLine,
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.grey[500],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ] else if (isAccepted && !canSee) ...[
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(Icons.visibility_off_outlined,
                            size: 13.sp, color: Colors.grey[600]),
                        SizedBox(width: 4.w),
                        Text(
                          'Spending hidden',
                          style: GoogleFonts.inter(
                            fontSize: 11.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    SizedBox(height: 6.h),
                    Text(
                      'Invitation ${member.invitationStatus.name}',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: _kFamilyPurple,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Trailing spending figure (mirrors the group card's right column)
            if (isAccepted && canSee) ...[
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    trailingLabel,
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      color: Colors.grey[500],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    trailingValue,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: trailingColor,
                    ),
                  ),
                ],
              ),
            ],
            SizedBox(width: 6.w),
            Icon(Icons.chevron_right, color: Colors.grey[600], size: 20.sp),
          ],
        ),
      ),
    );
  }

  /// Small rounded pill used for member role / invitation status, matching
  /// the group-account member card badge style (0.2-alpha tint, 12.r radius).
  Widget _buildMemberBadge(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white.withValues(alpha: 0.6),
          size: 18.sp,
        ),
        SizedBox(width: 12.w),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 13.sp,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildOption(
    IconData icon,
    String title,
    String description,
    VoidCallback onTap, {
    Color? color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Icon(
              icon,
              color: color ?? Colors.white.withValues(alpha: 0.6),
              size: 20.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: color ?? Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (description.isNotEmpty) ...[
                    SizedBox(height: 2.h),
                    Text(
                      description,
                      style: TextStyle(
                        color: color?.withValues(alpha: 0.7) ?? Colors.white.withValues(alpha: 0.5),
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
