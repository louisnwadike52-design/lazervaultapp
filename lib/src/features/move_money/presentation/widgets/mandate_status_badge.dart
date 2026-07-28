import 'package:flutter/material.dart';

import '../../domain/entities/mandate_entity.dart';
import 'linked_account_state_chip.dart';

/// Maps a [MandateEntity] (or null) to the canonical [LinkedAccountState] used
/// by the shared chip — the single source of truth for mandate-state display.
LinkedAccountState linkedAccountStateForMandate(MandateEntity? mandate) {
  if (mandate == null) return LinkedAccountState.oneTime; // no mandate → DirectPay
  // A deposit-method switch awaiting Mono confirmation shows a transient
  // "Switching…" state everywhere, ahead of the (still-transitioning) status.
  if (mandate.switchProcessing) return LinkedAccountState.switching;
  switch (mandate.status) {
    case MandateStatus.readyToDebit:
    case MandateStatus.active:
      return LinkedAccountState.directDebit;
    case MandateStatus.authorized:
      // User authorized; only NIBSS/bank activation left → "Setting up".
      return LinkedAccountState.settingUp;
    case MandateStatus.awaitingAuthorization:
    case MandateStatus.pending:
      // User hasn't authorized yet (e.g. cancelled the sheet) → not set up.
      return LinkedAccountState.oneTime;
    case MandateStatus.paused:
      return LinkedAccountState.paused;
    case MandateStatus.expired:
      return LinkedAccountState.expired;
    case MandateStatus.rejected:
      return LinkedAccountState.rejected;
    case MandateStatus.cancelled:
      return LinkedAccountState.cancelled;
  }
}

/// Inline mandate/Direct-Debit status badge on account cards. Now a thin wrapper
/// over the shared [LinkedAccountStateChip] so every screen renders the SAME
/// pill. Public API unchanged (used by Beam, autosave, mandate management,
/// move account card).
class MandateStatusBadge extends StatelessWidget {
  final MandateEntity? mandate;
  final VoidCallback? onTap;

  const MandateStatusBadge({super.key, this.mandate, this.onTap});

  @override
  Widget build(BuildContext context) {
    return LinkedAccountStateChip(
      state: linkedAccountStateForMandate(mandate),
      onTap: onTap,
    );
  }
}
