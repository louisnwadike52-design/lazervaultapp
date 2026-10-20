import 'package:flutter/material.dart';

import '../../domain/entities/crowdfund_entities.dart';

/// One vocabulary for "what state is this campaign in", shared by every
/// surface that shows it.
///
/// Three surfaces each carried their own copy and none of them agreed:
///
///   * the detail screen's `_statusVisuals` tested `isExpired && isActive`
///     first, so a campaign the deadline worker had already flipped to
///     `expired` matched no branch and fell through to **"Active"** — a
///     closed campaign inviting contributions it would refuse;
///   * `cancelling` matched no branch either, so a campaign mid-refund also
///     read "Active";
///   * the list card painted `expired` the same red as `cancelled`, which
///     says a campaign that simply missed its target did something wrong.
///
/// `completed`, `expired` and `cancelled` are three different endings and a
/// backer is owed the difference: the target was met; the clock ran out; or
/// the campaign was called off and the money came back. They get three
/// colours and three sentences.
typedef CrowdfundStatusVisual = ({
  Color color,
  String label,
  IconData icon,

  /// One line explaining the state in the backer's terms. Empty for
  /// `active`, where the badge alone is the whole story.
  String blurb,
});

const Color _green = Color(0xFF10B981);
const Color _amber = Color(0xFFF59E0B);
const Color _red = Color(0xFFEF4444);

/// Slate, deliberately not red. An expired campaign missed its target; it
/// did not misbehave, and colouring it like a cancellation reads as a
/// failure on the creator's part.
const Color _slate = Color(0xFF64748B);

CrowdfundStatusVisual crowdfundStatusVisual(
  Crowdfund c, {
  /// The detail screen's active colour is the brand accent rather than
  /// green; the cards use green. Only this one differs between surfaces.
  Color? activeColor,
}) =>
    crowdfundStatusVisualFor(
      c.status,
      pastDeadline: c.isPastDeadline,
      activeColor: activeColor,
    );

/// The vocabulary itself, keyed on the status rather than on a whole
/// campaign — because two surfaces hold only a cached status STRING and
/// cannot build an entity to ask with. They each grew their own four-arm
/// palette instead, and both had the same two holes: `paused` and
/// `cancelling` matched no arm and fell to the "not resolved yet" skeleton
/// pill, so a paused campaign and a campaign mid-REFUND both rendered as a
/// permanent "…". For a donor whose money is on its way back, that is the
/// one state they most need named.
CrowdfundStatusVisual crowdfundStatusVisualFor(
  CrowdfundStatus status, {
  /// Only knowable from a full campaign. A cached string has no deadline
  /// with it, so those surfaces pass nothing and simply never show
  /// "Closing" — the status they do have is still rendered correctly.
  bool pastDeadline = false,
  Color? activeColor,
}) {
  switch (status) {
    case CrowdfundStatus.completed:
      return (
        color: _green,
        label: 'Completed',
        icon: Icons.verified,
        blurb: 'Target reached, this campaign is closed.',
      );
    case CrowdfundStatus.expired:
      return (
        color: _slate,
        label: 'Expired',
        icon: Icons.timer_off,
        blurb: 'The deadline passed before the target was reached. '
            'No further contributions are accepted.',
      );
    case CrowdfundStatus.cancelling:
      return (
        color: _amber,
        label: 'Refunding',
        icon: Icons.sync,
        blurb: 'Cancelled, contributions are being refunded.',
      );
    case CrowdfundStatus.cancelled:
      return (
        color: _red,
        label: 'Cancelled',
        icon: Icons.block,
        blurb: 'This campaign was cancelled and contributions were refunded.',
      );
    case CrowdfundStatus.paused:
      return (
        color: _amber,
        label: 'Paused',
        icon: Icons.pause_circle,
        blurb: 'The organiser paused this campaign. '
            'Contributions reopen if it resumes.',
      );
    case CrowdfundStatus.active:
      // Still ACTIVE on the wire but past its own deadline: the worker has
      // not run yet. It is no longer collecting, and it is not yet known
      // whether it will close as completed or expired, so say exactly that
      // instead of inventing either ending.
      if (pastDeadline) {
        return (
          color: _amber,
          label: 'Closing',
          icon: Icons.hourglass_bottom,
          blurb: 'The deadline has passed. This campaign is being finalised.',
        );
      }
      return (
        color: activeColor ?? _green,
        label: 'Active',
        icon: Icons.bolt,
        blurb: '',
      );
  }
}

/// Parse the status name the API sends (and that the list screens cache) into
/// the enum. Returns null for an absent or unrecognised value, which is NOT
/// the same thing as a known status: a null means "we have not resolved this
/// campaign yet" and callers render their neutral placeholder for it. Folding
/// the two together is what made a paused campaign indistinguishable from one
/// still loading.
CrowdfundStatus? crowdfundStatusFromName(String? name) {
  switch ((name ?? '').trim().toLowerCase()) {
    case 'active':
      return CrowdfundStatus.active;
    case 'paused':
      return CrowdfundStatus.paused;
    case 'completed':
      return CrowdfundStatus.completed;
    case 'cancelling':
      return CrowdfundStatus.cancelling;
    case 'cancelled':
      return CrowdfundStatus.cancelled;
    case 'expired':
      return CrowdfundStatus.expired;
    default:
      return null;
  }
}

/// Visual for a cached status string, or null when there is nothing to show
/// yet. Lets the two string-only surfaces share this vocabulary instead of
/// keeping their own.
CrowdfundStatusVisual? crowdfundStatusVisualFromName(
  String? name, {
  Color? activeColor,
}) {
  final status = crowdfundStatusFromName(name);
  if (status == null) return null;
  return crowdfundStatusVisualFor(status, activeColor: activeColor);
}

/// The clock line that sits beside the donor count.
///
/// Both the card and the detail screen read `daysRemaining > 0` and said
/// "Deadline reached" otherwise — so a CANCELLED campaign was reported as
/// having reached its deadline, which is a different event entirely and,
/// for a campaign cancelled a month early, simply untrue.
String crowdfundDeadlineLabel(Crowdfund c) {
  switch (c.status) {
    case CrowdfundStatus.cancelling:
    case CrowdfundStatus.cancelled:
      return 'Cancelled';
    case CrowdfundStatus.completed:
      return 'Closed';
    case CrowdfundStatus.expired:
      return 'Ended';
    case CrowdfundStatus.paused:
    case CrowdfundStatus.active:
      // NO DEADLINE IS A REAL ANSWER, NOT A MISSING ONE.
      //
      // A deadline is optional — the create wizard labels it "Optional" and
      // its picker has a clear button, the service stores a null, the
      // deadline worker only ever selects `deadline IS NOT NULL`, and the
      // contribute path skips its past-deadline refusal on a zero one. Such
      // a campaign keeps collecting until it reaches its target or the
      // organiser stops it.
      //
      // This returned an empty string for that, and both call sites hide the
      // line when it is empty — so an open-ended campaign showed no clock at
      // all and looked like a campaign whose dates had failed to load. Say
      // the actual thing instead.
      if (!c.hasDeadline) {
        return 'No deadline';
      }
      if (c.isPastDeadline) return 'Deadline reached';
      final days = c.daysRemaining;
      // `daysRemaining` truncates, so anything under 24h floors to 0 while
      // the campaign is still open — "0 days left" reads as closed.
      if (days == 0) return 'Last day';
      if (days == 1) return '1 day left';
      return '$days days left';
  }
}

/// Amber urgency on the clock line, for an open campaign only. It was
/// keyed on `daysRemaining < 7`, which is true (0) of every terminal
/// campaign, so finished campaigns wore a "hurry" colour forever.
bool crowdfundDeadlineIsUrgent(Crowdfund c) =>
    c.status == CrowdfundStatus.active &&
    c.hasDeadline &&
    !c.isPastDeadline &&
    c.daysRemaining < 7;

/// Whether this campaign can take money right now. The single predicate
/// behind every Contribute/Donate button, so a disabled button and a
/// server-side refusal can never disagree.
bool crowdfundAcceptsContributions(Crowdfund c) =>
    c.status == CrowdfundStatus.active && !c.isPastDeadline;
