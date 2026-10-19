library;

import 'package:lazervault/src/features/crowdfund/domain/entities/crowdfund_entities.dart';

/// WHO CREATED THIS CAMPAIGN, ANSWERED THE SAME WAY EVERYWHERE.
///
/// The "Yours" pill existed only on Browse All, because the check that drives
/// it was a private one-liner inside that screen's State. Every other place a
/// campaign is listed — the leaderboard, the dashboard's trending rail, the
/// statistics page — had no way to ask the question, so a creator scrolling
/// past their own campaign got no signal that it was theirs.
///
/// ## Why username and not user id
///
/// `CrowdfundCreator.userId` is an `int` on the client because the wire field
/// is a legacy uint64, while the authenticated profile's id is a UUID. They
/// cannot be compared. The campaign row does carry a real UUID in
/// `crowdfunds.user_id`, but it is not what the listing payload exposes as
/// the creator id, so `creator.username` is the only stable crosswalk the
/// client actually holds. Measured on prod 2026-10-19: all three live
/// campaigns carry a populated `creator_username` ("chris", "onahpraiz").
///
/// If the creator id is ever widened to a UUID on the wire, compare that
/// instead — a username can be changed, and this match would then follow the
/// name rather than the person.
///
/// ## Matching rules
///
/// Case-insensitive, whitespace-trimmed, and a leading `@` is ignored on
/// either side: the profile stores a bare handle while plenty of UI (and some
/// payloads) carry the display form. An empty value on either side is never a
/// match — "unknown equals unknown" would badge every campaign as yours the
/// moment the profile failed to load.
bool crowdfundIsMine(Crowdfund campaign, String? myUsername) =>
    usernamesMatch(myUsername, campaign.creator.username);

/// The comparison itself, exposed so any listing that holds only a creator
/// handle (the leaderboard rail, a search result) can ask without a Crowdfund.
bool usernamesMatch(String? a, String? b) {
  final left = _normalise(a);
  final right = _normalise(b);
  if (left.isEmpty || right.isEmpty) return false;
  return left == right;
}

String _normalise(String? v) {
  var s = (v ?? '').trim();
  while (s.startsWith('@')) {
    s = s.substring(1);
  }
  return s.trim().toLowerCase();
}
