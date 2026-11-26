/// When a KYC TIER CAP is what stopped a payment.
///
/// WHY THIS IS ITS OWN FILE
/// -----------------------
/// Three surfaces — send funds, batch transfer and PiggyVault — each carried
/// their own copy of "if this looks like a tier cap, show KYCUpgradeModal with
/// currentKycTier()". Three copies of the same two defects:
///
///  1. **They asked the wrong service what tier the customer is on.**
///     [currentKycTier] reads the AUTH-service profile. The cap that refused
///     the payment is the one on the LEDGER row in accounts-service, and the
///     two drift: a customer approved to Tier 3 in auth can still be carrying
///     Tier-1 limits on their account if the tier-upgrade event never landed.
///     That is not hypothetical — it is the reported case where ₦1,000 went
///     through and ₦10,000 did not while the app showed Tier 3.
///
///  2. **At Tier 3 the modal had nothing to offer and said so anyway.**
///     With currentTier == requiredTier == 3 the copy read "You need Tier 3
///     verification … You're currently Tier 3, verify your identity to unlock
///     it", over a button routing to a BVN flow the customer had already
///     completed. A dead end dressed as an action.
///
/// So the enforcing tier is read from the SERVER'S OWN refusal where it sends
/// one (`kyc_tier: N`), the profile tier is only a fallback, and a disagreement
/// between them is named for what it is rather than papered over with "verify
/// your identity".
library;

import 'package:flutter/material.dart';

import 'package:lazervault/core/utils/kyc_tier_source.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/kyc_upgrade_modal.dart';
import 'package:lazervault/core/widgets/app_bottom_sheet.dart';

/// Whether [errorMessage] is a KYC TIER CAP rather than something retryable.
///
/// Shared so every money surface answers it the same way.
///
/// WHAT IS DELIBERATELY EXCLUDED, and why each exclusion earns its place:
///
///  * **'rate limit'** — a throttle. Routing someone to identity verification
///    because they tapped twice quickly is a worse dead end than the one this
///    exists to remove.
///  * **family allowances** — `family_spend_refusal.go` says "exceeds
///    per-transaction limit" and "this would exceed your daily limit of X
///    (already spent Y)". Those are a limit one FAMILY MEMBER set for another,
///    and verifying your identity does not raise them by a naira.
///    showFamilySpendRefusalDialog is the right answer there.
///
/// What it must catch, from accounts-service's own wording
/// (`accounts_spending_limits.go`):
///
///   single transaction limit exceeded (limit: …, attempted: …)
///   daily spending limit exceeded (limit: …, remaining: …, kyc_tier: N)
///   monthly spending limit exceeded (limit: …, remaining: …, kyc_tier: N)
///
/// The SINGLE-TRANSACTION one carries neither "daily", "monthly" nor "tier",
/// so the earlier predicate missed it entirely and it fell through to the
/// generic "Transfer Failed / Try Again" sheet — advice to repeat the one
/// thing that cannot succeed.
bool isTierCapRefusal(String errorMessage) {
  final lower = errorMessage.toLowerCase();
  if (lower.isEmpty) return false;

  // A throttle is not a cap.
  if (lower.contains('rate limit')) return false;

  // A family member's allowance is not a KYC tier. Matched on the exact
  // phrasings family_spend_refusal.go / family_accounts_spend.go produce.
  if (lower.contains('per-transaction limit') ||
      lower.contains('your daily limit of') ||
      lower.contains('your monthly limit of') ||
      lower.contains('family')) {
    return false;
  }

  // The server named the enforcing tier: unambiguous.
  if (lower.contains('kyc_tier') || lower.contains('kyc_tier_insufficient')) {
    return true;
  }

  // accounts-service's three exact refusals, plus the customer wording
  // friendlyError rewrites the per-transaction one into. Both forms matter:
  // the cubit classifies the server's sentence, the screen classifies the
  // rewritten one, and a form that only one of them recognises is a refusal
  // that gets copy and then no way to act on it.
  if (lower.contains('spending limit exceeded') ||
      lower.contains('single transaction limit') ||
      lower.contains('single-transfer limit')) {
    return true;
  }

  // Everything else must at least be about a limit being passed, and name the
  // window or the tier — this is what catches the FRIENDLIFIED copy
  // ("This would go over your daily transfer limit…") once friendlyError has
  // replaced the server's sentence.
  if (!lower.contains('limit') && !lower.contains('exceeded')) return false;
  return lower.contains('daily') ||
      lower.contains('monthly') ||
      lower.contains('tier');
}

/// The tier that ACTUALLY refused the payment, when the server named it.
///
/// accounts-service appends `kyc_tier: N` to its daily and monthly refusals
/// precisely so the caller need not guess. Must be read from the RAW error:
/// friendlyError replaces the server's sentence with customer copy and the
/// marker is gone by the time a screen sees the message, which is why the
/// cubit parses it at the point of failure and carries it in the state.
///
/// Returns null when there is no marker — never a guessed value, because a
/// wrong tier here produces a modal that states something false about the
/// customer's account.
int? enforcedTierFromRefusal(String? raw) {
  if (raw == null || raw.isEmpty) return null;
  final m = RegExp(r'kyc_tier:\s*(\d+)').firstMatch(raw);
  final digits = m?.group(1);
  if (digits == null) return null;
  final tier = int.tryParse(digits);
  if (tier == null || tier < 1 || tier > 3) return null;
  return tier;
}

/// What the modal should say, given what the two services each believe.
///
/// Separated from the presentation so the decision is testable without a
/// widget tree — it is the part that was wrong, not the layout.
@visibleForTesting
TierRefusalShape resolveTierRefusal({
  required int profileTier,
  int? enforcedTier,
}) {
  final current = enforcedTier ?? profileTier;

  // DRIFT: the ledger refused at a tier below the one the customer has been
  // approved for. They have nothing left to verify — the upgrade simply has
  // not reached their account — so offering "Verify Now" would send them to
  // redo work they have already done, and would not lift the cap.
  final drifted = enforcedTier != null && enforcedTier < profileTier;

  // TOP OF THE LADDER: there is no Tier 4. Whatever stopped a Tier-3 holder,
  // identity verification is not the remedy (Tier 3 is Unlimited by the
  // canonical matrix, so a cap at Tier 3 means a limit someone set, not a
  // regulatory ceiling).
  final atTop = current >= 3;

  return TierRefusalShape(
    currentTier: current,
    requiredTier: current < 3 ? current + 1 : 3,
    limitsOutOfSync: drifted || atTop,
    profileTier: profileTier,
  );
}

/// The resolved shape of a tier refusal.
@immutable
class TierRefusalShape {
  const TierRefusalShape({
    required this.currentTier,
    required this.requiredTier,
    required this.limitsOutOfSync,
    required this.profileTier,
  });

  /// The tier whose cap was applied.
  final int currentTier;

  /// The tier that would lift it — meaningless when [limitsOutOfSync].
  final int requiredTier;

  /// True when verifying cannot be the answer: either the ledger is behind the
  /// customer's approved tier, or they are already at the top of the ladder.
  final bool limitsOutOfSync;

  /// What the auth-service profile believes, kept so the copy can state both
  /// numbers rather than asking the customer to take one on trust.
  final int profileTier;
}

/// True while a tier-refusal sheet is on screen.
///
/// Every caller is an error path, and error paths re-fire: a cubit re-emitting
/// the same failure, two screens listening to one cubit, a rebuild. Without
/// this the customer dismisses the same sheet twice and the one underneath
/// looks like the app is stuck. Same shape as server_refusal_sheet.dart's
/// guard, including the mounted cross-check that keeps it from leaking shut if
/// the tree is torn down another way.
bool _sheetIsOpen = false;
BuildContext? _openSheetContext;

/// Shows the tier-cap refusal, and returns true when it handled [message].
///
/// Returns false when this was not a tier cap, so a caller can fall through to
/// its own handling unchanged:
///
/// ```dart
/// if (!await showTierLimitRefusalIfAny(context, msg, operationName: 'send money')) {
///   // existing handling
/// }
/// ```
///
/// [enforcedTier] is the tier the SERVER said it applied, where the caller has
/// the raw error to read it from. Omitted, the profile tier is used, which is
/// right for the ordinary case and wrong only in the drift case this exists to
/// name — so a caller that can supply it should.
///
/// NAVIGATION. This pushes a sheet, so the caller must have taken down any
/// sheet of its own FIRST. A sheet pushed over the PIN sheet while that sheet
/// still had a delayed `pop()` scheduled against it was the original bug: the
/// pop landed on whatever was topmost, which by then was this sheet, so the
/// refusal vanished after two seconds and the PIN sheet stayed.
Future<bool> showTierLimitRefusalIfAny(
  BuildContext context,
  String? message, {
  required String operationName,
  int? enforcedTier,
}) async {
  if (message == null || !isTierCapRefusal(message)) return false;
  if (!context.mounted) return false;

  if (_sheetIsOpen) {
    final open = _openSheetContext;
    if (open != null && open.mounted) return true; // already shown
    _sheetIsOpen = false; // stale flag — self-heal
  }

  final shape = resolveTierRefusal(
    profileTier: currentKycTier(),
    enforcedTier: enforcedTier,
  );

  _sheetIsOpen = true;
  _openSheetContext = context;
  try {
    await showAppBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => KYCUpgradeModal(
        currentTier: shape.currentTier,
        requiredTier: shape.requiredTier,
        operationName: operationName,
        limitsOutOfSync: shape.limitsOutOfSync,
        profileTier: shape.profileTier,
      ),
    );
  } finally {
    _sheetIsOpen = false;
    _openSheetContext = null;
  }
  return true;
}

/// Clears the re-entrancy guard. Tests only — a widget test that ends with the
/// sheet up discards the tree without completing the sheet's future.
@visibleForTesting
void resetTierRefusalGuardForTest() {
  _sheetIsOpen = false;
  _openSheetContext = null;
}
