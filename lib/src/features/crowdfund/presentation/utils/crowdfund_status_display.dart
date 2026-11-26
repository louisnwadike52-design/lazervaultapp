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

  /// A glyph for the endings worth celebrating or flagging. Empty for the
  /// states where an emoji would be noise.
  String emoji,

  /// Render this one LOUDLY — a filled badge rather than a tinted pill.
  ///
  /// Only `completed` sets it. A campaign that met its target is the one row
  /// in a list that should not look like every other row, and it was drawn in
  /// exactly the same green pill as an ACTIVE campaign: same colour, same
  /// weight, differing only by a 12sp icon nobody reads. Reported as
  /// campaigns "showing completed" when they are not — which is what two
  /// states rendered identically actually looks like.
  bool emphatic,
});

/// RESERVED FOR `completed`. Nothing else may use it.
///
/// It used to be the ACTIVE colour as well, which is how an open campaign and
/// a finished one came to look the same on every surface that paints by colour
/// alone — the landing strip's icon and progress bar among them.
const Color _green = Color(0xFF10B981);
const Color _amber = Color(0xFFF59E0B);
const Color _red = Color(0xFFEF4444);

/// The brand accent, and the default for `active`. A live campaign is the
/// normal case and wears the product's own colour; green now means one thing.
const Color _accent = Color(0xFF8B5CF6);

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
        emoji: '🎉',
        emphatic: true,
      );
    case CrowdfundStatus.expired:
      return (
        color: _slate,
        label: 'Expired',
        icon: Icons.timer_off,
        blurb: 'The deadline passed before the target was reached. '
            'No further contributions are accepted.',
        emoji: '',
        emphatic: false,
      );
    case CrowdfundStatus.cancelling:
      return (
        color: _amber,
        label: 'Refunding',
        icon: Icons.sync,
        blurb: 'Cancelled, contributions are being refunded.',
        emoji: '↩️',
        emphatic: false,
      );
    case CrowdfundStatus.cancelled:
      return (
        color: _red,
        label: 'Cancelled',
        icon: Icons.block,
        blurb: 'This campaign was cancelled and contributions were refunded.',
        emoji: '',
        emphatic: false,
      );
    case CrowdfundStatus.paused:
      return (
        color: _amber,
        label: 'Paused',
        icon: Icons.pause_circle,
        blurb: 'The organiser paused this campaign. '
            'Contributions reopen if it resumes.',
        emoji: '⏸️',
        emphatic: false,
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
          emoji: '⏳',
          emphatic: false,
        );
      }
      return (
        color: activeColor ?? _accent,
        label: 'Active',
        icon: Icons.bolt,
        blurb: '',
        emoji: '',
        emphatic: false,
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
///
/// ## THE MODERATION GATE IS HERE, AND NOWHERE ELSE
///
/// `moderation.isFundable` mirrors the backend's `Fundable()`: approved and
/// restricted can take money, pending and escalated cannot, blocked cannot.
///
/// Adding it to this ONE predicate rather than to each surface is the whole
/// point of the predicate existing. The operator's requirement was that
/// "somebody does not create a campaign and then, before our AI system flags
/// it, it starts receiving money" — and the backend already enforces that
/// inside the row lock, so a campaign under review WILL be refused. What this
/// line buys is that the app does not offer the button first: a donor who
/// taps Donate, fills in an amount, enters their PIN and is then told no has
/// been failed by the app, not protected by the server.
///
/// Five surfaces call this. If the check lived in each of them, the next one
/// added would be the one that forgot.
bool crowdfundAcceptsContributions(Crowdfund c) =>
    c.status == CrowdfundStatus.active &&
    !c.isPastDeadline &&
    c.moderation.isFundable;

/// THE DONOR'S SIDE OF THE SAME VOCABULARY.
///
/// A contribution has its own five states, and THREE surfaces each carried a
/// private switch over them — the landing page's "My donations" strip, the
/// My Donations screen, and the donation detail sheet. Identical colours,
/// identical labels, three places to change and three places to forget. The
/// campaign side was consolidated for exactly this reason; the donation side
/// was left behind.
///
/// `completed` is the ending worth marking here too: it is the row that says
/// the money actually reached the campaign.
CrowdfundStatusVisual crowdfundDonationStatusVisual(DonationStatus s) {
  switch (s) {
    case DonationStatus.completed:
      return (
        color: _green,
        label: 'Completed',
        icon: Icons.check_circle,
        blurb: 'Your contribution reached the campaign.',
        emoji: '🎉',
        emphatic: true,
      );
    case DonationStatus.pending:
      return (
        color: _amber,
        label: 'Pending',
        icon: Icons.schedule,
        blurb: 'Waiting to be taken from your wallet.',
        emoji: '⏳',
        emphatic: false,
      );
    case DonationStatus.processing:
      return (
        color: _amber,
        label: 'Processing',
        icon: Icons.sync,
        blurb: 'On its way to the campaign.',
        emoji: '⏳',
        emphatic: false,
      );
    case DonationStatus.failed:
      return (
        color: _red,
        label: 'Failed',
        icon: Icons.error_outline,
        blurb: 'This contribution did not go through. Nothing was taken.',
        emoji: '',
        emphatic: false,
      );
    case DonationStatus.refunded:
      return (
        color: const Color(0xFF6B7280),
        label: 'Refunded',
        icon: Icons.undo,
        blurb: 'The campaign was cancelled and this went back to your wallet.',
        emoji: '↩️',
        emphatic: false,
      );
  }
}
