import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/config/locale_gating.dart';
import 'package:lazervault/core/services/locale_manager.dart';

/// A wallet is denominated in one currency and can only be spent in it.
///
/// Reported from a device: NGN Family & Friends accounts appearing under the
/// GBP locale. That is a card the user can select, send from, and have
/// refused — and its balance reads as part of their GBP money, which is the
/// part that actually misleads.
void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.debugResetForTest();
    if (GetIt.I.isRegistered<LocaleManager>()) {
      await GetIt.I.unregister<LocaleManager>();
    }
  });

  void setLocaleCurrency(String code) {
    final lm = LocaleManager();
    lm.setCurrency(code);
    GetIt.I.registerSingleton<LocaleManager>(lm);
  }

  test('a wallet in another currency is hidden', () {
    setLocaleCurrency('GBP');
    expect(LocaleGating.accountCurrencyAllowed('NGN'), isFalse);
    expect(LocaleGating.accountCurrencyAllowed('USD'), isFalse);
  });

  test('a wallet in the active currency is shown', () {
    setLocaleCurrency('GBP');
    expect(LocaleGating.accountCurrencyAllowed('GBP'), isTrue);
    expect(LocaleGating.accountCurrencyAllowed('gbp'), isTrue);
    expect(LocaleGating.accountCurrencyAllowed(' GBP '), isTrue);
  });

  test('the rule is symmetric — a GBP wallet is hidden on a Naira dashboard',
      () {
    // Not a restricted-locale rule. You cannot spend one currency's wallet in
    // another's locale in either direction.
    setLocaleCurrency('NGN');
    expect(LocaleGating.accountCurrencyAllowed('GBP'), isFalse);
    expect(LocaleGating.accountCurrencyAllowed('NGN'), isTrue);
  });

  test('an account with no currency stamped is still shown', () {
    // Provisioning placeholders carry no currency yet. Hiding a real account
    // because a field has not been written is the worse of the two failures.
    setLocaleCurrency('GBP');
    expect(LocaleGating.accountCurrencyAllowed(null), isTrue);
    expect(LocaleGating.accountCurrencyAllowed(''), isTrue);
    expect(LocaleGating.accountCurrencyAllowed('   '), isTrue);
  });
}
