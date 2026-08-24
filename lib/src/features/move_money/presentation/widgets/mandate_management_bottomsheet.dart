import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/services/injection_container.dart';

import '../../cubit/mandate_cubit.dart';
import '../../cubit/mandate_state.dart';
import '../../domain/entities/mandate_entity.dart';
import '../../domain/mandate_auth_attempt_store.dart';
import 'mandate_setup_bottomsheet.dart';
import 'mandate_status_badge.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// Bottom sheet for managing an existing mandate (pause, resume, cancel)
/// or setting up a new one if none exists.
Future<void> showMandateManagementBottomSheet({
  required BuildContext context,
  required String linkedAccountId,
  required String userId,
  required String bankName,
  required String accountName,
  required MandateEntity? mandate,
  // When provided, an "Unlink bank" action is shown (dismisses the sheet, then
  // runs this). Null default → existing callers are unchanged.
  VoidCallback? onUnlink,
}) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: const Color(0xFF1F1F1F),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    // MandateCubit is a GetIt singleton; resolve from the service locator (not
    // context.read) so this works even when the caller provides MandateCubit
    // inside its own build() — e.g. the deposit screen, whose State context is
    // above that provider and would otherwise throw "Could not find
    // Provider<MandateCubit>". Same instance every other call site uses.
    builder: (ctx) => BlocProvider.value(
      value: serviceLocator<MandateCubit>(),
      child: _MandateManagementSheet(
        linkedAccountId: linkedAccountId,
        userId: userId,
        bankName: bankName,
        accountName: accountName,
        mandate: mandate,
        onUnlink: onUnlink,
      ),
    ),
  );
}

class _MandateManagementSheet extends StatefulWidget {
  final String linkedAccountId;
  final String userId;
  final String bankName;
  final String accountName;
  final MandateEntity? mandate;
  final VoidCallback? onUnlink;

  const _MandateManagementSheet({
    required this.linkedAccountId,
    required this.userId,
    required this.bankName,
    required this.accountName,
    required this.mandate,
    this.onUnlink,
  });

  @override
  State<_MandateManagementSheet> createState() =>
      _MandateManagementSheetState();
}

class _MandateManagementSheetState extends State<_MandateManagementSheet> {
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // The badge + action branches read the local auth-granted stamp
    // synchronously — hydrate so they work when this sheet is the first
    // mandate surface opened after an app restart. Idempotent.
    MandateAuthAttemptStore.hydrate();
  }

  /// Authorization was GRANTED (success callback, any device) and the mandate
  /// is provisioning with Mono/the bank — nothing for the user to do, and the
  /// spent auth link must not be reopened.
  bool get _isSettingUp {
    final m = widget.mandate;
    if (m == null) return false;
    return m.isActivating ||
        (m.awaitingUserAuthorization &&
            (m.authAttemptedRecently ||
                MandateAuthAttemptStore.openedRecently(m.id)));
  }

  /// Mandate exists but authorization was never granted — resumable via the
  /// setup sheet (CreateMandate reuses the same mandate + its Mono link).
  bool get _needsAuthorization {
    final m = widget.mandate;
    return m != null && m.awaitingUserAuthorization && !_isSettingUp;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MandateCubit, MandateState>(
      listener: (context, state) {
        if (state is MandatePaused ||
            state is MandateReinstated ||
            state is MandateCancelled) {
          if (context.mounted) Navigator.of(context).pop();
        } else if (state is MandateError) {
          setState(() {
            _errorMessage = state.message;
          });
        }
      },
      builder: (context, state) {
        final isLoading = state is MandateLoading;

        return Padding(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF6B7280),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 16.h),

              // Header
              Text(
                widget.bankName,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                widget.accountName,
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(height: 12.h),

              // Mandate status badge (large)
              MandateStatusBadge(mandate: widget.mandate),
              SizedBox(height: 16.h),

              // Inline error message
              if (_errorMessage != null) ...[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: const Color(0xFFEF4444).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        color: const Color(0xFFEF4444),
                        size: 18.sp,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: GoogleFonts.inter(
                            color: const Color(0xFFFCA5A5),
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
              ],

              if (widget.mandate != null) ...[
                // Info rows
                _buildInfoRow(
                    'Type', widget.mandate!.mandateType.name.toUpperCase()),
                _buildInfoRow(
                  'Limit',
                  widget.mandate!.amountLimit == 0
                      ? 'Unlimited'
                      : _formatKobo(widget.mandate!.amountLimit),
                ),
                _buildInfoRow(
                    'Used', _formatKobo(widget.mandate!.totalDebited)),
                if (widget.mandate!.amountLimit > 0)
                  _buildInfoRow(
                    'Remaining',
                    _formatKobo(widget.mandate!.remainingLimit),
                  ),
                _buildInfoRow(
                  'Expires',
                  DateFormat('MMM d, yyyy').format(widget.mandate!.endDate),
                ),
                SizedBox(height: 20.h),

                // Action buttons based on status
                if (widget.mandate!.switchProcessing) ...[
                  // A switch (pause/reinstate) is awaiting confirmation from the
                  // bank/Mono — show a read-only note instead of a Pause/Resume
                  // button so we don't fire a second switch before it settles.
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF818CF8).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: const Color(0xFF818CF8).withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.sync, color: const Color(0xFF818CF8), size: 18.sp),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            widget.mandate!.isSwitchingToDirectDebit
                                ? 'Switching to Direct Debit — confirming with your bank. This settles shortly.'
                                : 'Switching to one-time — confirming with your bank. This settles shortly.',
                            style: GoogleFonts.inter(
                              color: const Color(0xFFC7D2FE),
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else if (_isSettingUp) ...[
                  // Authorization granted — Mono/NIBSS are provisioning. Read-
                  // only: no CTA (the auth link is spent; reopening dead-ends).
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFB923C).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: const Color(0xFFFB923C).withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.hourglass_bottom,
                            color: const Color(0xFFFB923C), size: 18.sp),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            'Setting up Direct Debit — ${widget.bankName} is '
                            'confirming your authorization. This can take up to '
                            '30 minutes and completes automatically. One-time '
                            'approval is used until it is live.',
                            style: GoogleFonts.inter(
                              color: const Color(0xFFFDBA74),
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else if (_needsAuthorization) ...[
                  // Authorization never granted — the account behaves as
                  // one-time until the user finishes the bank authorization.
                  _buildMethodExplainer(
                    current: 'One-time (DirectPay)',
                    detail:
                        'Direct Debit isn\'t authorized yet — you approve each '
                        'transfer at your bank until you finish the setup.',
                  ),
                  SizedBox(height: 12.h),
                  _buildActionButton(
                    context: context,
                    label: 'Finish Direct Debit setup',
                    color: const Color(0xFFF59E0B),
                    icon: Icons.touch_app_outlined,
                    isLoading: isLoading,
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Resumes the SAME mandate: CreateMandate's reuse ladder
                      // re-points to it and reopens its Mono authorization.
                      showMandateSetupBottomSheet(
                        context: context,
                        linkedAccountId: widget.linkedAccountId,
                        userId: widget.userId,
                        bankName: widget.bankName,
                        accountName: widget.accountName,
                      );
                    },
                  ),
                ] else if (widget.mandate!.isActive) ...[
                  // Direct Debit is ON → offer switching to one-time (DirectPay).
                  // Mechanically this PAUSES the mandate (reversible, no re-auth) —
                  // same DirectPay⇄Direct-Debit model as the deposit screen.
                  _buildMethodExplainer(
                    current: 'Direct Debit',
                    detail:
                        'Transfers reuse your saved authorization — no bank login each time.',
                  ),
                  SizedBox(height: 12.h),
                  _buildActionButton(
                    context: context,
                    label: 'Switch to one-time (DirectPay)',
                    color: const Color(0xFFFBBF24),
                    icon: Icons.swap_horiz_rounded,
                    isLoading: isLoading,
                    onPressed: () {
                      setState(() => _errorMessage = null);
                      context.read<MandateCubit>().pauseMandate(
                            mandateId: widget.mandate!.id,
                            userId: widget.userId,
                          );
                    },
                  ),
                ] else if (widget.mandate!.status == MandateStatus.paused) ...[
                  // One-time (DirectPay) is active (mandate paused) → offer
                  // switching back to Direct Debit. Reinstates instantly, no re-auth.
                  _buildMethodExplainer(
                    current: 'One-time (DirectPay)',
                    detail:
                        'You approve each transfer at your bank. Switch to Direct Debit to skip that.',
                  ),
                  SizedBox(height: 12.h),
                  _buildActionButton(
                    context: context,
                    label: 'Switch to Direct Debit',
                    color: const Color(0xFF10B981),
                    icon: Icons.swap_horiz_rounded,
                    isLoading: isLoading,
                    onPressed: () {
                      setState(() => _errorMessage = null);
                      context.read<MandateCubit>().reinstateMandate(
                            mandateId: widget.mandate!.id,
                            userId: widget.userId,
                          );
                    },
                  ),
                ] else if (widget.mandate!.status == MandateStatus.expired ||
                    widget.mandate!.status == MandateStatus.rejected ||
                    widget.mandate!.status == MandateStatus.cancelled) ...[
                  _buildActionButton(
                    context: context,
                    label: 'Set Up Direct Debit',
                    color: const Color(0xFF10B981),
                    icon: Icons.verified_user_rounded,
                    isLoading: isLoading,
                    onPressed: () {
                      Navigator.of(context).pop();
                      showMandateSetupBottomSheet(
                        context: context,
                        linkedAccountId: widget.linkedAccountId,
                        userId: widget.userId,
                        bankName: widget.bankName,
                        accountName: widget.accountName,
                      );
                    },
                  ),
                ],

                // Cancel button (always available for non-terminal mandates)
                if (widget.mandate!.isActive ||
                    widget.mandate!.status == MandateStatus.paused) ...[
                  SizedBox(height: 12.h),
                  TextButton(
                    onPressed: isLoading
                        ? null
                        : () => _showCancelConfirmation(context),
                    child: Text(
                      'Cancel Direct Debit',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFEF4444),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ] else ...[
                // No mandate — offer setup
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Text(
                    'No Direct Debit set up for this account. '
                    'Enable it to skip bank login for future transfers.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 13.sp,
                      height: 1.5,
                    ),
                  ),
                ),
                _buildActionButton(
                  context: context,
                  label: 'Set Up Direct Debit',
                  color: const Color(0xFF10B981),
                  icon: Icons.verified_user_rounded,
                  isLoading: isLoading,
                  onPressed: () {
                    Navigator.of(context).pop();
                    showMandateSetupBottomSheet(
                      context: context,
                      linkedAccountId: widget.linkedAccountId,
                      userId: widget.userId,
                      bankName: widget.bankName,
                      accountName: widget.accountName,
                    );
                  },
                ),
              ],

              // Unlink bank — only when the caller wired it (e.g. LazerBeam).
              // Removes the bank entirely (and any mandate with it); confirmation
              // is handled by the caller's onUnlink.
              if (widget.onUnlink != null) ...[
                SizedBox(height: 12.h),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.onUnlink!.call();
                  },
                  icon: Icon(Icons.link_off_rounded,
                      size: 18.sp, color: Colors.redAccent),
                  label: Text('Unlink bank',
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600)),
                ),
              ],

              SizedBox(height: 8.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 13.sp,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Shows which deposit/transfer method is currently active and what the
  /// switch button below it does — so the DirectPay⇄Direct-Debit toggle reads
  /// the same across the deposit screen, Financial Analytics and LazerBeam.
  Widget _buildMethodExplainer({
    required String current,
    required String detail,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded,
              color: const Color(0xFF9CA3AF), size: 18.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current method: $current',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  detail,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 11.5.sp,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String label,
    required Color color,
    required IconData icon,
    required bool isLoading,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? LazerVaultLoader(size: 18)
            : Icon(icon, size: 20.sp),
        label: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          disabledBackgroundColor: color.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  void _showCancelConfirmation(BuildContext context) {
    // Capture cubit reference before dialog opens — dialog has its own context
    final cubit = context.read<MandateCubit>();
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(
          'Cancel Direct Debit?',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'You will need to authorize each transfer manually via bank login. '
          'You can set up Direct Debit again later.',
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: Text(
              'Keep',
              style: GoogleFonts.inter(color: const Color(0xFF9CA3AF)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogCtx).pop();
              setState(() => _errorMessage = null);
              cubit.cancelMandate(
                mandateId: widget.mandate!.id,
                userId: widget.userId,
                linkedAccountId: widget.linkedAccountId,
              );
            },
            child: Text(
              'Cancel Direct Debit',
              style: GoogleFonts.inter(color: const Color(0xFFEF4444)),
            ),
          ),
        ],
      ),
    );
  }

  String _formatKobo(int kobo) {
    final naira = kobo / 100.0;
    return 'NGN ${NumberFormat('#,##0.00', 'en_NG').format(naira)}';
  }
}
