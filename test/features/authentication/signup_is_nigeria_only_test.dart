import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/country_config.dart';

/// Only Nigeria may be selected when opening an account.
///
/// Onboarding runs on BVN/NIN, which exist only in Nigeria, and the licensed
/// partners behind the accounts are licensed there. Every other country the app
/// knows about stays ACTIVE — international transfers, intl data, airtime and
/// currency exchange legitimately need the UK, US, Ghana, Kenya and South
/// Africa — so the two ideas had to stop being the same flag.
void main() {
  group('signup country availability', () {
    test('Nigeria is the only country available for signup', () {
      final signup = CountryConfigs.activeCountries
          .where((c) => c.isAvailableForSignup)
          .map((c) => c.code)
          .toList();
      expect(signup, ['NG'],
          reason: 'signup offered $signup; only NG may open an account');
    });

    test('the other countries stay ACTIVE for the features that need them', () {
      // The regression this guards: narrowing isActive instead of signup
      // availability, which would silently break international transfers and
      // intl data/airtime.
      final active = CountryConfigs.activeCountries.map((c) => c.code).toSet();
      for (final code in ['GB', 'US', 'GH', 'KE', 'ZA']) {
        expect(active.contains(code), isTrue,
            reason: '$code was removed from activeCountries — that breaks '
                'international transfers and intl data, not just signup');
      }
    });
  });

  group('every auth surface filters its picker', () {
    // A picker reading activeCountries directly shows all six again. This is a
    // source check because the screens are widgets with heavy dependencies, and
    // the failure mode is one screen being forgotten — which is exactly what
    // happened to email_sign_in_screen and sign_up.
    const base = 'lib/src/features/authentication/presentation';
    const surfaces = [
      '$base/views/phone_entry_screen.dart',
      '$base/views/email_sign_in_screen.dart',
      '$base/views/phone_passcode_login_screen.dart',
      '$base/views/forgot_passcode_phone_screen.dart',
      '$base/widgets/sign_up.dart',
      '$base/widgets/device_phone_hint.dart',
    ];

    for (final path in surfaces) {
      test('${path.split('/').last} does not list countries unfiltered', () {
        final src = File(path).readAsStringSync();
        if (!src.contains('activeCountries')) return; // lists nothing
        expect(
          src.contains('isAvailableForSignup') ||
              src.contains('_selectableCountries'),
          isTrue,
          reason: '$path reads activeCountries without filtering to signup '
              'countries, so it still offers every country',
        );
      });
    }
  });
}
