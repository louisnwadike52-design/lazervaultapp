import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/presentation/widgets/autosave_progress_indicator.dart';
import 'package:lazervault/src/features/move_money/cubit/mandate_cubit.dart';
import 'package:lazervault/src/features/move_money/cubit/mandate_state.dart';
import 'package:lazervault/src/features/move_money/domain/mandate_auth_attempt_store.dart';

class AutoSaveSwipeableCard extends StatelessWidget {
  final AutoSaveRuleEntity rule;
  final String? accountName; // Resolved account name
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final bool isSelected;
  final bool selectionMode;
  final Function(bool?)? onSelectionChanged;

  const AutoSaveSwipeableCard({
    super.key,
    required this.rule,
    this.accountName,
    required this.onTap,
    required this.onEdit,
    required this.onToggle,
    required this.onDelete,
    this.isSelected = false,
    this.selectionMode = false,
    this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(rule.id),
      enabled: !selectionMode,
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onEdit(),
            backgroundColor: const Color(0xFF3B82F6),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              bottomLeft: Radius.circular(12.r),
            ),
          ),
          SlidableAction(
            onPressed: (_) => onToggle(),
            backgroundColor: rule.isActive
                ? const Color(0xFFF59E0B)
                : const Color(0xFF10B981),
            foregroundColor: Colors.white,
            icon: rule.isActive ? Icons.pause : Icons.play_arrow,
            label: rule.isActive ? 'Pause' : 'Resume',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onDelete(),
            backgroundColor: const Color(0xFFEF4444),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12.r),
              bottomRight: Radius.circular(12.r),
            ),
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          // Slightly lifted surface against the page background gives
          // the row depth without a hairline. Keeps the same purple
          // accent for selected / active rules but as a subtle glow
          // (shadow) instead of a flat stroke.
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? const Color.fromARGB(255, 78, 3, 208)
                      .withValues(alpha: 0.25)
                  : (rule.isActive
                      ? const Color.fromARGB(255, 78, 3, 208)
                          .withValues(alpha: 0.18)
                      : Colors.black.withValues(alpha: 0.35)),
              blurRadius: isSelected ? 18 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12.r),
            onTap: selectionMode
                ? () => onSelectionChanged?.call(!isSelected)
                : onTap,
            onLongPress: !selectionMode
                ? () => onSelectionChanged?.call(true)
                : null,
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  if (selectionMode)
                    Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: Checkbox(
                        value: isSelected,
                        onChanged: onSelectionChanged,
                        activeColor: const Color.fromARGB(255, 78, 3, 208),
                      ),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                rule.name,
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            _buildStatusBadge(),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          rule.description,
                          style: TextStyle(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 12.sp,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 12.h),
                        // Wrap (not Row) so a long trigger label like
                        // "When money enters Guaranty Trust Bank" flows to a
                        // second line instead of overflowing the card; each
                        // chip is also width-capped + ellipsised as a final
                        // guard against an extreme single value.
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: [
                            _buildInfoChip(
                                Icons.repeat, rule.triggerDescription),
                            _buildInfoChip(
                                Icons.attach_money, rule.amountDescription),
                          ],
                        ),
                        _buildMandateAlertChip(),
                        if (accountName != null) ...[
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Icon(Icons.account_balance_wallet,
                                  size: 12.sp, color: const Color(0xFF9CA3AF)),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Text(
                                  'To: $accountName',
                                  style: TextStyle(
                                    color: const Color(0xFF9CA3AF),
                                    fontSize: 10.sp,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                        SizedBox(height: 8.h),
                        // Creation timestamp — "Created Jun 7, 2026 · 8:40 PM".
                        Row(
                          children: [
                            Icon(Icons.schedule,
                                size: 12.sp, color: const Color(0xFF6B7280)),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Text(
                                'Created ${DateFormat('MMM d, y · h:mm a').format(rule.createdAt.toLocal())}',
                                style: TextStyle(
                                  color: const Color(0xFF6B7280),
                                  fontSize: 10.sp,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        if (rule.targetAmount != null) ...[
                          SizedBox(height: 12.h),
                          _buildProgressIndicator(),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool get _isLinkedBankRule =>
      (rule.triggerType == TriggerType.externalInflow ||
          rule.triggerType == TriggerType.scheduledExternal) &&
      rule.sourceLinkedAccountId.isNotEmpty;

  /// Compact amber flag on a linked-bank rule whose Direct Debit mandate is no
  /// longer debitable — the automatic pull can't run until the user
  /// re-authorizes (they do that on the details screen this card opens). Reads
  /// the shared MandateCubit singleton; shows nothing until the mandate status
  /// is actually known, so it never false-alarms.
  Widget _buildMandateAlertChip() {
    if (!_isLinkedBankRule) return const SizedBox.shrink();
    final cubit = serviceLocator<MandateCubit>();
    // Idempotent; the pill below reads the auth-granted stamp synchronously.
    MandateAuthAttemptStore.hydrate();
    return BlocBuilder<MandateCubit, MandateState>(
      bloc: cubit,
      builder: (context, state) {
        final known = state is UserMandatesLoaded ||
            state is MandateCreated ||
            state is MandatePaused ||
            state is MandateReinstated ||
            state is MandateCancelled;
        if (!known) return const SizedBox.shrink();
        final mandate = cubit.getMandateForAccount(rule.sourceLinkedAccountId);
        if (mandate != null && mandate.isActive) return const SizedBox.shrink();
        // "Activating" includes a recently GRANTED authorization still
        // provisioning with the bank (success stamp) — informational, not an
        // action prompt.
        final activating = mandate != null &&
            (mandate.isActivating ||
                (mandate.awaitingUserAuthorization &&
                    (mandate.authAttemptedRecently ||
                        MandateAuthAttemptStore.openedRecently(mandate.id))));
        // Never-granted awaiting mandate → "finish", terminal/absent → "re-authorize".
        final needsFinish =
            !activating && mandate != null && mandate.awaitingUserAuthorization;
        final color =
            activating ? const Color(0xFF3B82F6) : const Color(0xFFFB923C);
        final label = activating
            ? 'Direct Debit setting up'
            : needsFinish
                ? 'Finish Direct Debit setup'
                : 'Re-authorize Direct Debit';
        return Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: color.withValues(alpha: 0.4)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  activating
                      ? Icons.hourglass_top_rounded
                      : Icons.warning_amber_rounded,
                  size: 12.sp,
                  color: color,
                ),
                SizedBox(width: 5.w),
                Flexible(
                  child: Text(
                    label,
                    style: GoogleFonts.inter(
                      color: color,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: _getStatusColor(rule.status).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        _getStatusText(rule.status),
        style: TextStyle(
          color: _getStatusColor(rule.status),
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      // Cap the chip so one very long value (e.g. a bank name) ellipsises
      // inside the chip rather than pushing past the card edge. ~62% of the
      // screen leaves room for the second chip to sit beside it when both
      // are short, and to wrap below it when they aren't.
      constraints: BoxConstraints(maxWidth: 0.62.sw),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.sp, color: const Color(0xFF9CA3AF)),
          SizedBox(width: 4.w),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 10.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              rule.formattedProgress,
              style: GoogleFonts.inter(
                color: const Color(0xFF4E03D0),
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${rule.progressPercentage.toStringAsFixed(0)}%',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        AutoSaveProgressIndicator(
          progressPercentage: rule.progressPercentage,
          height: 4,
        ),
      ],
    );
  }

  Color _getStatusColor(AutoSaveStatus status) {
    switch (status) {
      case AutoSaveStatus.active:
        return Colors.green;
      case AutoSaveStatus.paused:
        return Colors.orange;
      case AutoSaveStatus.completed:
        return Colors.blue;
      case AutoSaveStatus.cancelled:
        return Colors.red;
      default:
        return const Color(0xFF9CA3AF);
    }
  }

  String _getStatusText(AutoSaveStatus status) {
    switch (status) {
      case AutoSaveStatus.active:
        return 'ACTIVE';
      case AutoSaveStatus.paused:
        return 'PAUSED';
      case AutoSaveStatus.completed:
        return 'COMPLETED';
      case AutoSaveStatus.cancelled:
        return 'CANCELLED';
      default:
        return 'UNKNOWN';
    }
  }
}
