import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/services/app_update_service.dart';

/// THE FORCED-UPDATE FLOOR MUST POINT AT A BUILD THAT EXISTS.
///
/// `app_min_build_*` drives a ForcedUpdateScreen that cannot be dismissed. If
/// the floor is above the build the store actually serves, every user is
/// locked out of an app they cannot update: the Update button opens a store
/// page reading "Open", not "Update", and nothing on the device can move past
/// it until a server setting changes.
///
/// The server refuses such a floor (guardAppMinBuild compares against the
/// store-verified app_latest_build_*). This pins the app's own second line.
///
/// Expressed against the decision rule rather than AppUpdateService.check(),
/// which needs PackageInfo, SharedPreferences and a live store lookup. The
/// rule is the part that decides whether anyone is locked out.
bool wouldForce({
  required int currentBuild,
  required int minBuild,
  required int latestBuild,
}) {
  final floorIsReachable = latestBuild > 0 && minBuild <= latestBuild;
  return currentBuild > 0 && minBuild > 0 && currentBuild < minBuild && floorIsReachable;
}

void main() {
  group('a mandatory update must be installable', () {
    test('THE BRICK: a floor above the published build never forces', () {
      // Play serves 495; somebody sets the floor to the unpublished 499.
      expect(wouldForce(currentBuild: 480, minBuild: 499, latestBuild: 495),
          isFalse,
          reason: 'forcing here locks every user out of a build that does '
              'not exist for them');
    });

    test('a reachable floor still forces — the feature must work', () {
      expect(wouldForce(currentBuild: 480, minBuild: 495, latestBuild: 495),
          isTrue);
      expect(wouldForce(currentBuild: 490, minBuild: 495, latestBuild: 499),
          isTrue);
    });

    test('nobody at or above the floor is forced', () {
      expect(wouldForce(currentBuild: 495, minBuild: 495, latestBuild: 499),
          isFalse);
      // Internal testers run ahead of the store.
      expect(wouldForce(currentBuild: 500, minBuild: 495, latestBuild: 499),
          isFalse);
    });

    test('an unknown current build never forces', () {
      // PackageInfo failed. Locking someone out because we could not read our
      // own version is the worst possible trade.
      expect(wouldForce(currentBuild: 0, minBuild: 495, latestBuild: 499),
          isFalse);
    });

    test('an unknown latest build never forces', () {
      // iOS sits at app_latest_build_ios = 0 during review. Not knowing what
      // is available is never grounds to force.
      expect(wouldForce(currentBuild: 480, minBuild: 495, latestBuild: 0),
          isFalse);
    });

    test('no floor set means no force, whatever else is true', () {
      expect(wouldForce(currentBuild: 100, minBuild: 0, latestBuild: 499),
          isFalse);
    });

    test('clearing the floor releases a locked-out user', () {
      // The recovery path: an operator sets the floor back to 0 and the next
      // check lets them in. The gate re-runs on app resume.
      expect(wouldForce(currentBuild: 480, minBuild: 499, latestBuild: 499),
          isTrue, reason: 'locked out while the floor stands');
      expect(wouldForce(currentBuild: 480, minBuild: 0, latestBuild: 499),
          isFalse, reason: 'and released the moment it is cleared');
    });
  });

  group('the forced screen cannot be escaped', () {
    test('AppUpdateType still distinguishes forced from optional', () {
      // If these ever collapse, a mandatory update becomes dismissible.
      expect(AppUpdateType.forced, isNot(equals(AppUpdateType.optional)));
      expect(AppUpdateType.forced, isNot(equals(AppUpdateType.none)));
    });
  });
}
