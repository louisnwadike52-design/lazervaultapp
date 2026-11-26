import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lazervault/core/config/feature_flags.dart';

/// `piggyvault_manual_activation` is the one flag in here whose safe answer
/// is ON.
///
/// Every other gate hides a feature when unset, so an unknown value costs the
/// user a missing button. This one decides whether the wizard WARNS that a
/// plan is held for review before it earns. Unset-means-off would hand a user
/// a maturity date and an interest projection starting today, take the money
/// out of their spendable balance, and then show them a plan that is not
/// running — which is the single thing this copy exists to prevent.
///
/// accounts-service's own resolver fails the same way for the same reason:
/// holding a plan costs a delay an operator clears in a click, while
/// promising returns on money nobody has placed anywhere cannot be undone.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('plans are assumed REVIEWED before any admin value arrives', () async {
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.init();
    expect(FeatureFlags.piggyvaultPlansAreReviewed, isTrue,
        reason: 'unset must warn, never over-promise');
  });

  test('follows the admin value once it arrives', () async {
    await FeatureFlags.init();
    final prefs = await SharedPreferences.getInstance();

    // The day the asset-company API lands, an operator turns this off and
    // plans start the moment they are created — the warning must go with it,
    // or the app keeps telling users about a review that no longer happens.
    await prefs.setBool(FeatureFlags.piggyvaultManualActivation, false);
    expect(FeatureFlags.piggyvaultPlansAreReviewed, isFalse);

    await prefs.setBool(FeatureFlags.piggyvaultManualActivation, true);
    expect(FeatureFlags.piggyvaultPlansAreReviewed, isTrue);

    await prefs.remove(FeatureFlags.piggyvaultManualActivation);
    expect(FeatureFlags.piggyvaultPlansAreReviewed, isTrue,
        reason: 'clearing the value falls back to reviewed, never to instant');
  });

  test('the key matches the name accounts-service reads', () {
    // The app and the service share one settings row. A typo here is not a
    // compile error — it is an app that silently never sees the operator's
    // choice, which in this direction means warning forever.
    expect(FeatureFlags.piggyvaultManualActivation,
        'piggyvault_manual_activation');
  });
}
