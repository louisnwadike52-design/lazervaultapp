part of 'autosave_rule_details_screen.dart';

/// Tiny pair returned by [_humaniseAutosaveError] — split-out so the
/// snackbar can show a strong title + softer detail line.
class _FriendlyError {
  final String title;
  final String body;
  const _FriendlyError(this.title, this.body);
}

// ── Accent ──────────────────────────────────────────────────────────────
// The screen used to paint every accent in #4E03D0 — a deep, heavily
// saturated purple that reads almost navy against the #0A0A0A background,
// so icons and the progress figure lost definition. These two lighter
// violets carry the same brand hue at a contrast that actually survives on
// black: [_accent] for icons / text / CTA tint, [_accentDeep] as the second
// gradient stop so fills still have depth.
const _accent = Color(0xFFA78BFA);
const _accentDeep = Color(0xFF8B5CF6);

/// Plain-language explanation of what each limit actually does, written
/// against the VERIFIED executor behaviour (autosave_executor.go:182-196
/// and the deposit / round-up consumers), not against the field name.
///
/// The minimum-balance copy is trigger-aware on purpose. That floor is only
/// enforced by the paths that hold a fresh source balance — the on-deposit
/// and round-up consumers read it off the balance-changed event and clamp
/// or skip the save. A scheduled / manual / bank-pull save has no such
/// event, so promising "we'll never take you below this" on those rules
/// would be a straight lie; they get the honest version instead.
String _minimumBalanceHint(TriggerType trigger) {
  // Same predicate the create wizard uses to decide whether to OFFER the
  // field, so a rule cannot be created under one rule and described under
  // another.
  final readsLiveBalance =
      AutoSaveTriggerLabels.enforcesMinimumBalance(trigger);
  return readsLiveBalance
      ? 'The floor you keep in your source account. A save is trimmed — or '
          'skipped entirely — rather than take you below this.'
      : 'Applies to wallet-deposit and round-up saves, which can read your '
          'live balance. This rule fires on a schedule, so only your '
          'available funds limit a save.';
}

const _targetAmountHint =
    'Your goal. Each save is trimmed so the total never overshoots, and the '
    'rule completes itself once you get here.';

const _maximumPerSaveHint =
    'The most any single save can move. A larger amount is trimmed down to '
    'this before the money leaves.';
