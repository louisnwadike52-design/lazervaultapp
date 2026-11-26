import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

/// THE PIN SHEET VALIDATES THE PIN. THE RECEIPT REPORTS THE PAYMENT.
///
/// A crypto-funded send is refused by crypto-service's gate BEFORE any quote
/// exists, so the answer arrives in milliseconds. That refusal used to be
/// thrown out of the PIN sheet's onPinValidated callback, which painted
/// "Transaction Failed · Something went wrong" over the PIN pad — the one
/// screen in the flow with no room to explain and nothing to act on. The PIN
/// was correct; the payment was declined, and those are different events.
///
/// Source-text guards: the behaviour is three coordinated arguments inside a
/// 2,000-line widget that cannot be driven without a gRPC stack, and the way
/// this regresses is somebody deleting one of the three.
void main() {
  final src = File('lib/src/features/recipients/presentation/widgets/'
          'select_recipients.dart')
      .readAsStringSync();

  test('the PIN sheet shows no money beat for a crypto-funded send', () {
    expect(src.contains('showProcessingPhase: !isCryptoFunded'), isTrue,
        reason: 'the sheet is back to running its Processing beat for a '
            'crypto send, so the payment outcome paints over the PIN pad '
            'again instead of on the receipt');
  });

  test('a refusal is carried to the receipt rather than thrown', () {
    expect(src.contains('deferFailureToReceipt: isCryptoFunded'), isTrue,
        reason: 'the call site no longer defers, so a declined payment is '
            'thrown out of onPinValidated and renders as a PIN-sheet failure');
    expect(src.contains('_shortDeferredFailure = terminal.message'), isTrue,
        reason: 'the deferral no longer records the refusal, so the receipt '
            'has nothing to explain');
    expect(src.contains('_buildShortFailureReceipt('), isTrue,
        reason: 'there is no failure receipt to navigate to');
  });

  test('a stale refusal can never be shown over a new transfer', () {
    expect(src.contains('_shortDeferredFailure = null;'), isTrue,
        reason: 'the deferred refusal is not cleared at the start of an '
            'attempt, so a previous decline would render on the next send');
  });

  test('a refused payment sets up no recurring schedule', () {
    final i = src.indexOf('if (_shortDeferredFailure != null) {');
    final j = src.indexOf('_setupRecurringShort(r, active, minor');
    expect(i, greaterThan(-1), reason: 'the refusal branch is gone');
    expect(j, greaterThan(-1), reason: 'the recurring setup call is gone');
    expect(i, lessThan(j),
        reason: 'the refusal branch must come BEFORE the recurring setup and '
            'return — scheduling a repeat for a payment that was declined '
            'would charge the customer later for something that never '
            'happened');
  });

  // ── The LONG flow has the same seams and had the same defect ───────────
  //
  // WHITESPACE-NORMALISED. These live inside deeply nested widget code, so
  // `dart format` decides where the line breaks fall and a literal match
  // against one particular wrapping is a guard that breaks on a reformat
  // rather than on the bug. Collapsing runs of whitespace compares the code,
  // not its layout.
  String flat(String src) => src.replaceAll(RegExp(r'\s+'), ' ');

  final longSrc = flat(File('lib/src/features/funds/presentation/widgets/'
          'send_funds/initiate_send_funds.dart')
      .readAsStringSync());

  test('the long flow also keeps the money outcome off the PIN pad', () {
    expect(longSrc.contains('showProcessingPhase: !_paySource.isCrypto'), isTrue,
        reason: 'the long flow runs its Processing beat for a crypto send '
            'again, so the payment outcome paints over the PIN pad');
    expect(longSrc.contains('_longDeferredFailure = finalState.message'), isTrue,
        reason: 'the long flow throws a crypto decline out of onPinValidated '
            'again instead of carrying it to the receipt');
    expect(longSrc.contains('_longDeferredFailure = null;'), isTrue,
        reason: 'a stale decline could render over a new transfer');
    expect(longSrc.contains("'failureReason': _longDeferredFailure"), isTrue,
        reason: 'the long flow never puts the reason on the receipt');
  });

  test('a non-crypto failure still fails the PIN sheet', () {
    // The deferral is SCOPED. An ordinary wallet transfer that fails is a
    // different event — it happens after the money path has run — and the
    // PIN sheet's failed state is the right place for it. Widening the
    // deferral to every transfer would silently change what a failed wallet
    // send looks like.
    expect(longSrc.contains('} else { throw Exception( finalState.message); }'),
        isTrue,
        reason: 'the non-crypto branch no longer throws, so an ordinary '
            'failed transfer would reach a receipt instead of the PIN '
            "sheet's failed state");
  });
}
