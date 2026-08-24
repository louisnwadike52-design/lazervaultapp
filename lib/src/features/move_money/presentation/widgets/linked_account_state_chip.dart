import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The single linked-bank-account state surface used across every money/bank
/// screen (Deposit, Beam, Withdrawal, AI budgeting) so the badges never drift.
///
/// It spans BOTH dimensions of "linking state":
///   - Direct Debit mandate (pull rail): [directDebit] / [settingUp] / [oneTime]
///   - Connection / data-access rail:     [verified] / [connected] / [reconnect]
///
/// Each screen maps its own state into one of these and renders the same chip.
enum LinkedAccountState {
  /// Active recurring Direct Debit mandate — debits instantly, no per-txn approval.
  directDebit,

  /// Mandate authorized but still activating with NIBSS — one-time approval meanwhile.
  settingUp,

  /// Mandate created but the bank authorization was never completed (the user
  /// closed the Mono webview). Actionable: tap to finish the authorization.
  finishSetup,

  /// One-time DirectPay — the user approves each transaction at their bank.
  oneTime,

  /// Payout destination whose account ownership is verified (withdrawal rail).
  verified,

  /// Connected for data access (budgeting / statistics).
  connected,

  /// Session expired — needs reauthorization before it can be used.
  reconnect,

  /// Mandate paused — currently using one-time approval, reinstatable.
  paused,

  /// A deposit-method switch (Direct Debit ⇄ one-time) is awaiting confirmation
  /// from the bank/Mono — transient "processing" state.
  switching,

  /// Mandate expired — needs a fresh setup.
  expired,

  /// Mandate cancelled.
  cancelled,

  /// Mandate rejected by the bank/user.
  rejected,
}

class _ChipCfg {
  final Color color;
  final IconData icon;
  final String label;
  const _ChipCfg(this.color, this.icon, this.label);
}

_ChipCfg _configFor(LinkedAccountState s) {
  switch (s) {
    case LinkedAccountState.directDebit:
      return const _ChipCfg(Color(0xFF10B981), Icons.autorenew, 'Direct Debit');
    case LinkedAccountState.settingUp:
      return const _ChipCfg(Color(0xFFFB923C), Icons.hourglass_bottom, 'Setting up');
    case LinkedAccountState.finishSetup:
      return const _ChipCfg(Color(0xFFF59E0B), Icons.touch_app_outlined, 'Finish setup');
    case LinkedAccountState.oneTime:
      return const _ChipCfg(Color(0xFF9CA3AF), Icons.bolt, 'One-time');
    case LinkedAccountState.verified:
      return const _ChipCfg(Color(0xFF10B981), Icons.verified_rounded, 'Verified');
    case LinkedAccountState.connected:
      return const _ChipCfg(Color(0xFF10B981), Icons.link_rounded, 'Connected');
    case LinkedAccountState.reconnect:
      return const _ChipCfg(Color(0xFFFB923C), Icons.refresh, 'Reconnect');
    case LinkedAccountState.paused:
      return const _ChipCfg(Color(0xFFFBBF24), Icons.pause_circle_outline, 'Paused');
    case LinkedAccountState.switching:
      return const _ChipCfg(Color(0xFF818CF8), Icons.sync, 'Switching…');
    case LinkedAccountState.expired:
      return const _ChipCfg(Color(0xFFEF4444), Icons.error_outline, 'Expired');
    case LinkedAccountState.cancelled:
      return const _ChipCfg(Color(0xFF6B7280), Icons.cancel_outlined, 'Cancelled');
    case LinkedAccountState.rejected:
      return const _ChipCfg(Color(0xFFEF4444), Icons.block, 'Rejected');
  }
}

/// One consistent pill for any [LinkedAccountState]. Pass [onTap] to make it
/// tappable (e.g. open the info modal, or run the reconnect flow); set
/// [showInfoAffordance] to append a small info dot hinting it's tappable.
class LinkedAccountStateChip extends StatelessWidget {
  final LinkedAccountState state;
  final VoidCallback? onTap;
  final bool showInfoAffordance;

  const LinkedAccountStateChip({
    super.key,
    required this.state,
    this.onTap,
    this.showInfoAffordance = false,
  });

  @override
  Widget build(BuildContext context) {
    final cfg = _configFor(state);
    final chip = Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: cfg.color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: cfg.color.withValues(alpha: 0.40)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(cfg.icon, color: cfg.color, size: 11.sp),
          SizedBox(width: 3.w),
          Text(cfg.label,
              style: TextStyle(color: cfg.color, fontSize: 10.sp, fontWeight: FontWeight.w700)),
          if (showInfoAffordance) ...[
            SizedBox(width: 4.w),
            Icon(Icons.info_outline, color: cfg.color.withValues(alpha: 0.70), size: 10.sp),
          ],
        ],
      ),
    );
    if (onTap == null) return chip;
    return GestureDetector(onTap: onTap, child: chip);
  }
}
