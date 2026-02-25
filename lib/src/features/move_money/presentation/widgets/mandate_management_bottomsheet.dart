import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../cubit/mandate_cubit.dart';
import '../../cubit/mandate_state.dart';
import '../../domain/entities/mandate_entity.dart';
import 'mandate_setup_bottomsheet.dart';
import 'mandate_status_badge.dart';

/// Bottom sheet for managing an existing mandate (pause, resume, cancel)
/// or setting up a new one if none exists.
Future<void> showMandateManagementBottomSheet({
  required BuildContext context,
  required String linkedAccountId,
  required String userId,
  required String bankName,
  required String accountName,
  required MandateEntity? mandate,
}) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: const Color(0xFF1F1F1F),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) => BlocProvider.value(
      value: context.read<MandateCubit>(),
      child: _MandateManagementSheet(
        linkedAccountId: linkedAccountId,
        userId: userId,
        bankName: bankName,
        accountName: accountName,
        mandate: mandate,
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

  const _MandateManagementSheet({
    required this.linkedAccountId,
    required this.userId,
    required this.bankName,
    required this.accountName,
    required this.mandate,
  });

  @override
  State<_MandateManagementSheet> createState() =>
      _MandateManagementSheetState();
}

class _MandateManagementSheetState extends State<_MandateManagementSheet> {
  String? _errorMessage;

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
                if (widget.mandate!.isActive) ...[
                  _buildActionButton(
                    context: context,
                    label: 'Pause Auto-Debit',
                    color: const Color(0xFFFBBF24),
                    icon: Icons.pause_circle_outline,
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
                  _buildActionButton(
                    context: context,
                    label: 'Resume Auto-Debit',
                    color: const Color(0xFF10B981),
                    icon: Icons.play_circle_outline,
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
                    label: 'Set Up Auto-Debit',
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
                      'Cancel Auto-Debit',
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
                    'No auto-debit set up for this account. '
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
                  label: 'Set Up Auto-Debit',
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
            ? SizedBox(
                width: 18.w,
                height: 18.w,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
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
          'Cancel Auto-Debit?',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'You will need to authorize each transfer manually via bank login. '
          'You can set up auto-debit again later.',
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
              'Cancel Auto-Debit',
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
