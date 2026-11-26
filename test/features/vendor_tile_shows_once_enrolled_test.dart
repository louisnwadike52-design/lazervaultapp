import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/vendor_campaigns/domain/vendor_entities.dart';

/// "HE IS A VENDOR AND THE TILE IS NOT THERE."
///
/// Reported after an enrolment that had in fact worked. The backend was
/// right — `GetVendorStatus` sets `is_active` from the vendor row's status
/// and campaigns do not enter into it — and the deployed binary was current.
/// What was wrong was the app's handling of a call that did not come back.
///
/// `getStatus()` never throws: it catches and returns `VendorStatus.unknown`,
/// which was BYTE-IDENTICAL to a genuine "not a vendor". The refresher then
/// latched as though it had been told no, and nothing asked again for the
/// rest of the session. One cold gateway or unrefreshed token at launch, and
/// a freshly enrolled vendor saw nothing until the app was killed.
///
/// "I could not ask" and "the answer is no" are different. Only the second
/// should stop us asking.
void main() {
  String code(String s) => s
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .where((l) => !l.trimLeft().startsWith('///'))
      .join('\n');

  group('a failure is not an answer', () {
    test('the unknown status is marked unanswered', () {
      expect(VendorStatus.unknown.answered, isFalse,
          reason: 'a caught exception must not look like a decision');
      expect(VendorStatus.unknown.isVendor, isFalse,
          reason: 'and it must still hide the tile — the safe direction');
    });

    test('a real answer of "no" is distinguishable from a failure', () {
      // Both hide the tile. Only one of them is worth remembering.
      const no = VendorStatus(answered: true);
      expect(no.isVendor, isFalse);
      expect(no.answered, isTrue);
      expect(no.answered, isNot(VendorStatus.unknown.answered));
    });

    test('the repository marks what the server actually returned', () {
      final src = code(File(
              'lib/src/features/vendor_campaigns/data/vendor_campaign_repository.dart')
          .readAsStringSync());
      expect(src.contains('answered: true'), isTrue,
          reason: 'a status built from a response must say so, or the '
              'refresher cannot tell it from the catch below it');
      // And the catch must NOT claim an answer.
      final catchPart = src.substring(src.indexOf('} catch'));
      expect(catchPart.contains('answered: true'), isFalse);
    });

    test('the refresher latches only on a real answer', () {
      final src =
          code(File('lib/core/services/vendor_access_refresher.dart')
              .readAsStringSync());
      final at = src.indexOf('if (!status.answered) return;');
      final latch = src.indexOf('_answered = true;');
      expect(at, greaterThan(0),
          reason: 'nothing stops a failed call being remembered as a "no"');
      expect(at, lessThan(latch),
          reason: 'the guard must come BEFORE the latch, or it guards nothing');
    });
  });

  group('an enrolment becomes visible without reinstalling', () {
    final src = code(
        File('lib/core/services/vendor_access_refresher.dart').readAsStringSync());

    test('a "no" expires, so a mid-session enrolment is picked up', () {
      // Enrolment happens while the vendor is holding the phone — somebody at
      // the venue is told "you're set up now". A "no" that lasted the whole
      // session meant killing and reopening the app, with nothing on screen
      // to suggest that was the remedy.
      expect(src.contains('_negativeAnswerTtl'), isTrue);
      expect(src.contains('_negativeAnswerIsStale()'), isTrue);
    });

    test('a "yes" never expires', () {
      // Re-asking after a yes could only ever take a working tile away from
      // somebody mid-service. That is the one direction this must not move.
      expect(src.contains('if (VendorAccess.isActiveVendor) _answeredAt = null;'),
          isTrue,
          reason: 'a yes must clear the timestamp so it is never re-litigated');
    });

    test('signing out forgets both halves', () {
      final reset = src.substring(src.indexOf('resetForNewSession'));
      expect(reset.contains('_answeredAt = null'), isTrue);
      expect(reset.contains('_answered = false'), isTrue,
          reason: 'on a shared device the next holder must get their own '
              'answer, not inherit a flag saying somebody already asked');
    });
  });

  group('the tile does not require campaigns', () {
    test('the gate is the ROLE alone', () {
      // Stated by the operator: "once a user has been marked as vendor, the
      // service should show, with or without him having campaigns". The
      // backend already agrees — GetVendorStatus derives is_active from the
      // vendor row and counts campaigns separately — so this pins the app
      // side, which is where a campaign check would be cheap to add and
      // wrong.
      final lifestyle = code(File(
              'lib/src/features/lifestyle/presentation/screens/lifestyle_screen.dart')
          .readAsStringSync());
      // The whole entry, bounded by the next entry or the end of the list —
      // `indexOf('),')` lands on the first nested close, which is inside the
      // colour list, so it cut the block before `visible:` and asserted on
      // nothing.
      final from = lifestyle.indexOf("'Vendor Campaigns'");
      expect(from, greaterThan(0), reason: 'the entry is gone from the tab');
      final visible = lifestyle.substring(
          from, from + 600 > lifestyle.length ? lifestyle.length : from + 600);
      expect(visible.contains('VendorAccess.isActiveVendor'), isTrue);
      expect(visible.contains('activeCampaigns'), isFalse,
          reason: 'a vendor with no campaign yet is still a vendor');
    });

    test('the Lifestyle tab fetches the role itself', () {
      // It is the LAST bottom-nav item and the surface that shows the entry.
      // It used to read a cache that only the dashboard's services grid ever
      // populated, so its content depended on another tab having been built.
      final lifestyle = code(File(
              'lib/src/features/lifestyle/presentation/screens/lifestyle_screen.dart')
          .readAsStringSync());
      expect(lifestyle.contains('VendorAccessRefresher.refreshInBackground()'),
          isTrue);
    });
  });
}
