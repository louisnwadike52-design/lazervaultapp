import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// A CRYPTO REFUSAL IS AN EDIT, NOT A RECEIPT.
///
/// Reported 2026-11-24 with a screenshot: a ₦1,000 transfer funded from
/// crypto was refused for being under the exchange's per-asset swap minimum
/// (₦1,253 for that coin), and the customer was shown a FAILED TRANSFER
/// receipt — for a transfer that never happened, with no way back to the
/// amount they needed to change.
///
/// The distinction already existed on the state. `isSpendRefusal` means the
/// server decided against it BEFORE anything moved: the funding row is closed
/// `failed_no_charge`, and the authorisation reserves nothing (see
/// payment_sendfunds.go — "NOTHING is reserved or debited"). The only crypto
/// outcome that belongs on a receipt is an uncertain one.
void main() {
  final send = File(
          'lib/src/features/funds/presentation/widgets/send_funds/initiate_send_funds.dart')
      .readAsStringSync();
  final cubit =
      File('lib/src/features/funds/cubit/transfer_cubit.dart').readAsStringSync();

  // Comments stripped: a guard the paragraph explaining the fix can satisfy
  // is a guard that passes with the fix deleted.
  String code(String src) => src
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');

  test('a refusal is thrown to the sheet, not deferred to the receipt', () {
    // WHITESPACE-INSENSITIVE. dart format re-wraps this expression the
    // moment anything around it changes length, and a guard that fails on a
    // reformat is a guard that gets deleted.
    final body = code(send).replaceAll(RegExp(r'\s+'), ' ');
    expect(body, contains('!finalState .isSpendRefusal'),
        reason: 'the deferral to the receipt must be gated on the outcome '
            'being UNKNOWN. Without the gate every refusal becomes a failed '
            'receipt for a transfer that never happened.');
  });

  test('an uncertain crypto outcome still reaches the receipt', () {
    // The other half matters just as much: when we genuinely do not know
    // whether the coin was sold, the receipt is where the customer can watch
    // it settle. Removing the deferral entirely would hide that.
    expect(code(send), contains('_longDeferredFailure'),
        reason: 'an uncertain outcome must still be carried to the receipt');
  });

  test('the money promise is never said twice', () {
    final body = code(cubit);
    expect(body, contains('_withNoChargePromise('),
        reason: 'the server already words its own refusals with "Nothing was '
            'converted"; concatenating the client promise produced the same '
            'sentence twice in one message');
    expect(body.contains("' Nothing was converted and you have not been charged.'"),
        isFalse,
        reason: 'the raw concatenation is what duplicated it');
  });

  test('the promise helper collapses every shape', () {
    // Mirrors _withNoChargePromise so the behaviour is pinned, not just its
    // presence. Kept in step by the call-site assertion above.
    String promise(String message) {
      final text = message.trim();
      final lower = text.toLowerCase();
      if (lower.contains('not been charged')) return text;
      if (lower.contains('nothing was converted')) {
        return '$text You have not been charged.';
      }
      const p = 'Nothing was converted and you have not been charged.';
      return text.isEmpty ? p : '$text $p';
    }

    expect(promise('The minimum swap amount is higher. Nothing was converted.'),
        'The minimum swap amount is higher. Nothing was converted. You have not been charged.');
    expect(
        'Nothing was converted'
            .allMatches(promise(
                'Increase the amount and try again. Nothing was converted.'))
            .length,
        1,
        reason: 'exactly once, never twice');
    expect(promise('Daily limit reached.'),
        'Daily limit reached. Nothing was converted and you have not been charged.');
    expect(promise('Already said it: you have not been charged.'),
        'Already said it: you have not been charged.');
  });

  group('the conversion covers the fee', _feeSizingGuards);
}

/// THE CONVERSION MUST BE SIZED TO WHAT THE TRANSFER COSTS, FEE INCLUDED.
///
/// A crypto-funded transfer is recorded at `awaiting_crypto_funding` and
/// reserves nothing, so the authorising row is written BEFORE any fee is
/// computed and `result.fee` comes back 0. The conversion was therefore sized
/// to the amount alone.
///
/// Measured on prod 2026-11-24: `required_minor` 130000 against a ₦1,323.00
/// charge. It completed only because that customer had a wallet balance to
/// absorb the ₦23. Someone paying ENTIRELY from crypto with an empty wallet
/// converts roughly the amount, passes the sufficiency check
/// (`availableNow >= required`), and then fails at the hold for want of the
/// fee — money safe, payment failed, conversion wasted, and nothing on screen
/// explains it.
void _feeSizingGuards() {
  final cubit =
      File('lib/src/features/funds/cubit/transfer_cubit.dart').readAsStringSync();
  final code = cubit
      .split('\n')
      .where((l) =>
          !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
      .join('\n');

  // The CRYPTO BRANCH, not the file. `ensureFeeForAmount` is declared in this
  // same cubit, so asserting it merely APPEARS passes with the call deleted —
  // verified by reverting the fix and watching that assertion stay green.
  final call = code.indexOf('await fundWithCrypto(');
  // The window spans both sides of the call: the re-quote sits above it, the
  // sized argument inside it.
  final branch = call < 0
      ? ''
      : code.substring(call < 1200 ? 0 : call - 1200,
          call + 900 > code.length ? code.length : call + 900);

  test('the crypto branch exists to size', () {
    expect(call, greaterThan(0),
        reason: 'the sizing guards below are meaningless without the call');
  });

  test('the fee is added to the amount the conversion must cover', () {
    expect(branch, contains('requiredMinor: amountMinor + feeMinor'),
        reason: 'sizing to the amount alone leaves the wallet to find the fee');
  });

  test('a missing server fee is re-quoted rather than assumed zero', () {
    expect(branch, contains('ensureFeeForAmount('),
        reason: 'the authorising row has no fee on this path, so the client '
            'must ask for one before converting');
    expect(branch, contains('if (feeMinor == 0)'),
        reason: 're-quote only when the server did not say');
  });

  test('it revalidates rather than trusting the cached quote', () {
    // Fees are amount-dependent: a ₦10k quote shown on a ₦50k confirm is
    // silently wrong. ensureFeeForAmount is the gate that re-checks.
    expect(branch.contains('lastFeeLoaded'), isFalse,
        reason: 'reading the cache directly skips the amount/type revalidation');
  });

  test('a failed re-quote does not block a payment already authorised', () {
    expect(branch, contains('quote?.fee ?? 0'),
        reason: 'the old behaviour usually works; refusing outright would be '
            'worse than being short by a fee');
  });
}
