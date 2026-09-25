import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/currency_exchange/presentation/widgets/international_payout_unavailable.dart';

/// The copy an admin selects is what a user is told about a service that does
/// not work. Getting it wrong is not cosmetic: "not available for your account"
/// while the corridor is off for EVERYONE sends people to support about an
/// account that is perfectly fine.
void main() {
  group('international payout unavailable copy', () {
    test('each scope says the right thing about who it affects', () {
      final (accountTitle, accountBody) =
          InternationalPayoutUnavailable.copyFor('account');
      expect(accountTitle.toLowerCase(), contains('account'));
      expect(accountBody.toLowerCase(), contains('account'));

      final (countryTitle, countryBody) =
          InternationalPayoutUnavailable.copyFor('country');
      expect(countryTitle.toLowerCase(), contains('country'));
      expect(countryBody.toLowerCase(), contains('country'));

      final (genericTitle, _) = InternationalPayoutUnavailable.copyFor('generic');
      // The generic message must NOT blame the account or the country, since it
      // is shown precisely when we are not claiming either.
      expect(genericTitle.toLowerCase(), isNot(contains('your account')));
      expect(genericTitle.toLowerCase(), isNot(contains('your country')));
    });

    test('an unknown scope falls back to generic, never to a specific claim',
        () {
      final expected = InternationalPayoutUnavailable.copyFor('generic');
      for (final unknown in ['', 'ACCOUNT ', 'maintenance', 'kyc', 'null']) {
        final got = InternationalPayoutUnavailable.copyFor(unknown);
        expect(got, expected,
            reason: 'scope "$unknown" must not produce a specific claim we '
                'cannot stand behind');
      }
    });

    test('every variant reassures about money and avoids blaming the user', () {
      for (final scope in ['generic', 'account', 'country']) {
        final (title, body) = InternationalPayoutUnavailable.copyFor(scope);
        final all = '$title $body'.toLowerCase();

        // A service being off must never read as the user's money being at risk.
        expect(all, contains('balance is unaffected'),
            reason: '$scope should say the balance is safe');

        // No blame, and no promises we cannot keep.
        for (final forbidden in [
          'you must',
          'your fault',
          'invalid',
          'rejected',
          'tomorrow',
          'next week',
        ]) {
          expect(all, isNot(contains(forbidden)),
              reason: '$scope must not contain "$forbidden"');
        }
      }
    });
  });
}
