library;

import 'entities/group_entities.dart';

/// WHAT THIS CYCLE HAS COLLECTED — AND NOTHING FROM THE LAST ONE.
///
/// The contribution details screen counted "fully paid" and "partial" by
/// folding the contribution's LIFETIME payment list and comparing each
/// member's running total against the PER-CYCLE share. Those two are not the
/// same question, and after a rotation advances they disagree completely: two
/// members who paid their cycle-1 share kept reading as "2 fully paid"
/// throughout cycle 2, when nobody had paid anything into it.
///
/// The authoritative per-cycle source already exists on the member and is
/// maintained by the server on both edges:
///
///  * a completed payment adds to `cycle_paid_amount` and flips
///    `has_paid_current_cycle` once the cumulative reaches the regular
///    amount (contribution_member_bookkeeping.go), and
///  * the rotation advance sets both back to zero/false for every ACTIVE
///    member (payout_rotation.go).
///
/// So a new cycle genuinely starts from zero; the screen simply was not
/// reading it.
///
/// Only ACTIVE members are counted, mirroring the server: a `pending_invite`
/// shadow has not consented to take part, and counting it would make the
/// denominator — and therefore the share every member owes — wrong.
class CycleProgress {
  const CycleProgress({
    required this.activeMembers,
    required this.fullyPaid,
    required this.partial,
    required this.collected,
  });

  /// Members taking part in this cycle.
  final int activeMembers;

  /// Members whose share for THIS cycle is settled in full.
  final int fullyPaid;

  /// Members who have put something in but not the whole share.
  final int partial;

  /// Sum of what the members have put into this cycle.
  final double collected;

  /// Anyone who has paid anything into this cycle.
  int get contributors => fullyPaid + partial;

  /// Members who have paid nothing into this cycle yet.
  int get awaiting => activeMembers - contributors;

  /// True when every active member has settled this cycle. This is the
  /// condition a rotation should satisfy before it moves on.
  bool get everyoneHasPaid => activeMembers > 0 && fullyPaid == activeMembers;

  static const empty = CycleProgress(
    activeMembers: 0,
    fullyPaid: 0,
    partial: 0,
    collected: 0,
  );
}

/// Reads the current cycle's standing off the members.
CycleProgress cycleProgressFromMembers(List<ContributionMember> members) {
  var active = 0;
  var fully = 0;
  var partial = 0;
  var collected = 0.0;

  for (final m in members) {
    if (m.membershipStatus != ContributionMembershipStatus.active) continue;
    active++;
    collected += m.cyclePaidAmount;
    if (m.hasPaidCurrentCycle) {
      fully++;
    } else if (m.cyclePaidAmount > 0) {
      partial++;
    }
  }

  return CycleProgress(
    activeMembers: active,
    fullyPaid: fully,
    partial: partial,
    collected: collected,
  );
}

/// Merges the payments the server reports FOR ONE CYCLE with the ones this
/// device has just made, newest first.
///
/// Local payments are always this cycle's — they were made seconds ago on
/// this screen — and they are kept so a member sees their own payment the
/// instant it lands, rather than after the next refresh. Server rows win on
/// identity so a local optimistic row does not double up with its own
/// persisted copy.
List<ContributionPayment> mergeCyclePayments({
  required List<ContributionPayment> local,
  required List<ContributionPayment> cycle,
}) {
  final out = <ContributionPayment>[];
  final ids = <String>{};
  final txns = <String>{};

  void add(ContributionPayment p) {
    final txn = p.transactionId?.trim();
    if (!ids.add(p.id)) return;
    if (txn != null && txn.isNotEmpty && !txns.add(txn)) return;
    out.add(p);
  }

  for (final p in cycle) {
    add(p);
  }
  for (final p in local) {
    add(p);
  }

  out.sort((a, b) => b.paymentDate.compareTo(a.paymentDate));
  return out;
}
