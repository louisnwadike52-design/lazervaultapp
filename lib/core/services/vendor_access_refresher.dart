import 'dart:async';

import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/vendor_access.dart';
import 'package:lazervault/src/features/vendor_campaigns/data/vendor_campaign_repository.dart';

/// Asks the server, once per session, whether this user is an enrolled vendor.
///
/// THE CHICKEN AND EGG THIS SOLVES. The Vendor Campaigns tile is hidden unless
/// VendorAccess says the user is a vendor, and VendorAccess is only updated by
/// a call the vendor screens make — which they cannot, because the tile that
/// opens them is hidden. So the answer has to be fetched independently, after
/// sign-in, before the grid is next built.
///
/// FIRE AND FORGET, DELIBERATELY. Nothing on a startup path may block on this:
/// a vendor is a handful of accounts out of everyone, and making every user
/// wait on a network call for a tile almost none of them have is the wrong
/// trade. The tile appears as soon as the answer lands and the grid rebuilds.
class VendorAccessRefresher {
  VendorAccessRefresher._();

  static bool _inFlight = false;
  static bool _answered = false;
  static DateTime? _answeredAt;

  /// How long a "you are not a vendor" answer is trusted before it is worth
  /// asking again.
  ///
  /// WHY A "NO" EXPIRES AT ALL. Enrolment is an admin act that happens while
  /// the vendor is holding the phone — somebody at the venue is told "you're
  /// set up now". Treating the first "no" as final for the whole session
  /// meant that person had to kill and reopen the app before the tile could
  /// appear, with nothing on screen to suggest that was the remedy. It read
  /// as the enrolment not having worked.
  ///
  /// A "YES" NEVER EXPIRES. Once the answer is yes it is latched for the
  /// session: re-asking could only ever take a working tile away from
  /// somebody mid-service, which is the one direction this must not move in.
  ///
  /// Five minutes, and only when the Vendor surface is actually looked at:
  /// almost everybody is not a vendor, so this must not become a round trip
  /// per tab visit for the whole user base.
  static const Duration _negativeAnswerTtl = Duration(minutes: 5);

  /// Refreshes the cached answer.
  ///
  /// ONCE PER SESSION for a YES, or until [_negativeAnswerTtl] elapses for a
  /// NO, unless [force] is set. The services grid rebuilds on every balance
  /// tick, account switch and reorder drag, and this is called from its
  /// initState — so without a latch a user who is not a vendor (which is
  /// almost everyone) would fire a round trip over and over for a tile they
  /// will never see.
  static Future<void> refresh({bool force = false}) async {
    if (_inFlight) return;
    if (_answered && !force && !_negativeAnswerIsStale()) return;
    _inFlight = true;
    try {
      if (!serviceLocator.isRegistered<VendorCampaignRepository>()) return;
      // getStatus writes the cache itself and never throws: a failure leaves
      // the previous answer in place rather than hiding the tile from a vendor
      // mid-service because one request timed out.
      final status =
          await serviceLocator<VendorCampaignRepository>().getStatus();
      // LATCH ONLY ON A REAL ANSWER.
      //
      // This set the flag unconditionally, and `getStatus` never throws — it
      // catches and returns `VendorStatus.unknown`, which is byte-identical to
      // "not a vendor". So a single failed call at launch (a cold gateway, a
      // token not yet refreshed, a moment without signal) was remembered as a
      // settled "no", and nothing asked again for the rest of the session. A
      // freshly enrolled vendor then saw no tile until the app was killed and
      // reopened, which reads as the enrolment not having worked.
      //
      // "I could not ask" and "the answer is no" are different, and only the
      // second one should stop us asking. Same distinction as the saved-payee
      // warm-up, which had the same bug for the same reason.
      if (!status.answered) return;
      _answered = true;
      _answeredAt = DateTime.now();
      // A YES is final for the session — see _negativeAnswerTtl. Recording
      // the time only matters for a NO, so this is where the two diverge.
      if (VendorAccess.isActiveVendor) _answeredAt = null;
      // Nudge anything listening on the flag revision so the grid rebuilds
      // without waiting for the next navigation.
      FeatureFlags.revision.value++;
    } catch (_) {
      // Already swallowed inside getStatus; this is belt and braces for a
      // missing registration during a hot reload.
    } finally {
      _inFlight = false;
    }
  }

  /// Whether a cached "not a vendor" is old enough to be worth re-asking.
  ///
  /// Returns false when the answer was YES (`_answeredAt` is cleared on a
  /// yes), so a working tile is never re-litigated.
  static bool _negativeAnswerIsStale() {
    final at = _answeredAt;
    if (at == null) return false;
    return DateTime.now().difference(at) >= _negativeAnswerTtl;
  }

  /// Starts the refresh without awaiting it.
  static void refreshInBackground() {
    unawaited(refresh());
  }

  /// Forgets the session latch. Called on logout so the next person signing in
  /// on this device is asked about afresh rather than inheriting the answer.
  static void resetForNewSession() {
    _answeredAt = null;
    _answered = false;
  }
}
