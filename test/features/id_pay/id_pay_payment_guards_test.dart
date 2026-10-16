import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/id_pay/presentation/cubit/id_pay_state.dart';
import 'package:lazervault/src/features/id_pay/presentation/view/id_pay_payment_guards.dart';

/// Production report these guards exist for: a payer tapped Pay on their OWN
/// PayID. The transaction PIN sheet announced "Transaction Successful!", a red
/// "cannot pay your own PayID" snackbar arrived for the same tap, and a push
/// notification claimed the transfer had succeeded.
void main() {
  group('isOwnPayId mirrors the server rule (idPay.CreatorID == payerID)', () {
    test('refuses when the payer created the PayID', () {
      expect(isOwnPayId(signedInUserId: 'u-1', creatorId: 'u-1'), isTrue);
    });

    test('allows a payment to someone else', () {
      expect(isOwnPayId(signedInUserId: 'u-1', creatorId: 'u-2'), isFalse);
    });

    test('ignores case and surrounding whitespace', () {
      // The id arrives from two different sources (auth profile, PayID
      // lookup); a casing difference must not let a self-payment through.
      expect(
        isOwnPayId(signedInUserId: ' U-1 ', creatorId: 'u-1'),
        isTrue,
      );
    });

    test('fails OPEN when the signed-in id is unknown', () {
      // Blocking a legitimate payment is worse than a refusal that arrives one
      // step later from the server, which checks this too.
      expect(isOwnPayId(signedInUserId: null, creatorId: 'u-1'), isFalse);
      expect(isOwnPayId(signedInUserId: '', creatorId: 'u-1'), isFalse);
      expect(isOwnPayId(signedInUserId: '   ', creatorId: 'u-1'), isFalse);
    });

    test('fails OPEN when the creator id is unknown', () {
      expect(isOwnPayId(signedInUserId: 'u-1', creatorId: null), isFalse);
      expect(isOwnPayId(signedInUserId: 'u-1', creatorId: ''), isFalse);
    });
  });

  group('throwIfPaymentRefused turns a refusal into a failed sheet', () {
    test('an error state throws, carrying the server sentence', () {
      expect(
        () => throwIfPaymentRefused(
            IDPayError(message: 'cannot pay your own PayID')),
        throwsA(isA<IDPayPaymentRefused>().having(
          (e) => e.message,
          'message',
          'cannot pay your own PayID',
        )),
      );
    });

    test('insufficient funds throws its own sentence', () {
      expect(
        () => throwIfPaymentRefused(
            IDPayInsufficientFunds(message: 'Balance too low')),
        throwsA(isA<IDPayPaymentRefused>()
            .having((e) => e.message, 'message', 'Balance too low')),
      );
    });

    test('an empty server message still produces usable copy', () {
      // A blank message must not render a blank failure sheet.
      expect(
        () => throwIfPaymentRefused(IDPayError(message: '   ')),
        throwsA(isA<IDPayPaymentRefused>()
            .having((e) => e.message.trim(), 'message', isNotEmpty)),
      );
    });

    test('a successful payment does NOT throw', () {
      // This is the case that must stay silent: the sheet is only allowed to
      // say "Payment Successful" when the cubit reached IDPayPaid.
      expect(() => throwIfPaymentRefused(IDPayInitial()), returnsNormally);
      expect(
        () => throwIfPaymentRefused(
            IDPayProcessing(payId: 'PAY-1', amount: 200)),
        returnsNormally,
      );
    });
  });

  group('idPayPaymentFailureMessage', () {
    test('passes a refusal through verbatim', () {
      // Running it through friendlyError would replace the one sentence that
      // tells the user what to change.
      expect(
        idPayPaymentFailureMessage(
            const IDPayPaymentRefused('cannot pay your own PayID')),
        'cannot pay your own PayID',
      );
    });

    test('never leaks a raw throw', () {
      final raw = Exception(
          'You are not whitelisted to access this resource (ip 1.2.3.4)');
      final shown = idPayPaymentFailureMessage(raw);
      expect(shown.toLowerCase(), isNot(contains('whitelist')));
      expect(shown, isNot(contains('1.2.3.4')));
      expect(shown.trim(), isNotEmpty);
    });
  });
}
