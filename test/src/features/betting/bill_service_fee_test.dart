import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// FeatureFlags.billServiceFee must agree with calcSimpleFee in
/// utility-payments, key for key and default for default:
///
///   {bt}_service_fee_enabled  bool   master switch, default FALSE → fee 0
///   {bt}_fee_type             string "fixed" | "percentage" (default pct)
///   {bt}_fee_fixed            NGN    when type == fixed
///   {bt}_fee_percentage       pct    when type == percentage (1.0 == 1%)
///
/// The server is authoritative — it charges amount + fee and holds the total.
/// This mirror exists only so the amount sheet, the pay button and the
/// transaction-PIN sheet can SHOW the customer what they are about to pay
/// instead of displaying the funding amount and letting them discover the
/// total from their balance. A disagreement means a wrong number on the last
/// screen before a debit, so the arithmetic is pinned here.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // SharedPreferences caches its instance, so setMockInitialValues only takes
  // effect before the FIRST getInstance. Write through the live instance
  // instead — also closer to how the value really arrives, since the settings
  // refresh persists it into prefs at runtime rather than at boot. (Same
  // pattern as test/core/external_payout_floor_test.dart.)
  late SharedPreferences prefs;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.init();
    prefs = await SharedPreferences.getInstance();
  });

  Future<void> seed(Map<String, String> rows) async {
    for (final k in [
      'betting_service_fee_enabled', 'betting_fee_type',
      'betting_fee_fixed', 'betting_fee_percentage',
      'epin_service_fee_enabled', 'epin_fee_type',
      'epin_fee_fixed', 'epin_fee_percentage',
    ]) {
      await prefs.remove(k);
    }
    for (final e in rows.entries) {
      await prefs.setString(e.key, e.value);
    }
  }

  test('no fee at all until an admin switches it on — a rail nobody priced '
      'must look exactly as it did before', () async {
    await seed({'betting_fee_fixed': '28'});
    expect(FeatureFlags.billServiceFee('betting', 200), 0);
  });

  test('fixed: VTU surcharges ₦25, so ₦28 covers it and earns ₦3', () async {
    await seed({
      'betting_service_fee_enabled': 'true',
      'betting_fee_type': 'fixed',
      'betting_fee_fixed': '28',
    });
    // Flat, regardless of the funding amount — matching VTU's own flat charge.
    expect(FeatureFlags.billServiceFee('betting', 200), 28);
    expect(FeatureFlags.billServiceFee('betting', 1200), 28);
    expect(FeatureFlags.billServiceFee('betting', 100), 28);
  });

  test('percentage is the DEFAULT type, and 1.0 means 1%', () async {
    await seed({
      'betting_service_fee_enabled': 'true',
      'betting_fee_percentage': '1.5',
    });
    expect(FeatureFlags.billServiceFee('betting', 1000), 15);
  });

  test('a zero amount has no fee, so an empty field shows nothing', () async {
    await seed({
      'betting_service_fee_enabled': 'true',
      'betting_fee_type': 'fixed',
      'betting_fee_fixed': '28',
    });
    expect(FeatureFlags.billServiceFee('betting', 0), 0);
    expect(FeatureFlags.billServiceFee('betting', -5), 0);
  });

  test('a malformed or negative row reads as NO fee, never as a discount '
      'nobody authorised', () async {
    for (final bad in ['', '  ', 'abc', '-10', 'NaN', 'Infinity']) {
      await seed({
        'betting_service_fee_enabled': 'true',
        'betting_fee_type': 'fixed',
        'betting_fee_fixed': bad,
      });
      expect(FeatureFlags.billServiceFee('betting', 200), 0,
          reason: 'betting_fee_fixed=$bad must not reduce what the customer pays');
    }
  });

  test('ePIN shares the mechanism — same keys, its own values', () async {
    await seed({
      'epin_service_fee_enabled': 'true',
      'epin_fee_type': 'fixed',
      'epin_fee_fixed': '10',
      'betting_service_fee_enabled': 'true',
      'betting_fee_type': 'fixed',
      'betting_fee_fixed': '28',
    });
    expect(FeatureFlags.billServiceFee('epin', 500), 10);
    expect(FeatureFlags.billServiceFee('betting', 500), 28);
  });

  group('the settings poll must ingest the fee keys as STRINGS', () {
    test('all eight keys are ingested', () async {
      // Uses the instance bound in setUpAll. Re-calling setMockInitialValues
      // here does nothing — SharedPreferences caches its instance, which is
      // the very thing this file's header comment warns about, and my first
      // version of this test fell into it.
      await seed({});

      await FeatureFlags.applyRemoteSnapshot({
        'betting_service_fee_enabled': 'true',
        'betting_fee_type': 'fixed',
        'betting_fee_fixed': '28',
        'betting_fee_percentage': '0',
        'epin_service_fee_enabled': 'true',
        'epin_fee_type': 'fixed',
        'epin_fee_fixed': '10',
        'epin_fee_percentage': '0',
      });

      // Stored as STRINGS — getString must return them, because that is what
      // billServiceFee reads with.
      expect(prefs.getString('betting_fee_fixed'), '28',
          reason: 'a fee stored via setBool would read back null here');
      expect(prefs.getString('betting_fee_type'), 'fixed');
      expect(prefs.getString('betting_service_fee_enabled'), 'true',
          reason: 'the enabled flag is read with getString too, so it must be '
              'stored as a string, not a bool');

      // And the whole point: the fee is now visible to the UI.
      expect(FeatureFlags.billServiceFee('betting', 200), 28);
      expect(FeatureFlags.billServiceFee('epin', 500), 10);
    });

    test('the app list and admin-gateway list are the same eight keys', () {
      // admin-gateway's billFeeSettingKeys is the server half; if they drift,
      // the server merges a key the app discards.
      expect(FeatureFlags.billFeeSettingKeys.length, 8);
      for (final bt in ['betting', 'epin']) {
        for (final sfx in [
          '_service_fee_enabled', '_fee_type', '_fee_fixed', '_fee_percentage',
        ]) {
          expect(FeatureFlags.billFeeSettingKeys, contains('$bt$sfx'));
        }
      }
    });
  });

  test('the key names are exactly the ones the server prices from', () {
    expect(FeatureFlags.billFeeEnabledKey('betting'), 'betting_service_fee_enabled');
    expect(FeatureFlags.billFeeTypeKey('betting'), 'betting_fee_type');
    expect(FeatureFlags.billFeeFixedKey('betting'), 'betting_fee_fixed');
    expect(FeatureFlags.billFeePercentageKey('betting'), 'betting_fee_percentage');
  });
}

// The chain is only as good as its weakest link, and the weakest was the
/// INGEST. admin-gateway merges the fee keys into the settings response, but
/// applyRemoteSnapshot ingests an EXPLICIT list — a key not named there
/// arrives in the HTTP response and is discarded, so billServiceFee reads
/// nothing and every screen shows no fee while the server charges one.
///
/// It also matters WHICH list: one loop stores with setBool, the other with
/// setString, and billServiceFee reads all eight with getString. A fee of
/// "28" through the bool loop becomes `false`.
