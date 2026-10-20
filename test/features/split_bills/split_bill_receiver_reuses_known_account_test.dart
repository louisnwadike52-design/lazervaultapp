import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// THE SAME CODE BEHAVED DIFFERENTLY DEPENDING ON WHERE YOU CAME FROM.
///
/// `AccountVerificationCubit` is provided ONCE, app-level in main.dart, and it
/// caches a resolved (country, bank, account) tuple for 30 minutes. Reaching
/// Create Split Bill through the Split Bills quick action on the send-funds
/// select-recipient screen therefore commonly arrives with the cubit already
/// sitting on `AccountVerificationSuccess` for the very account being entered.
///
/// Calling `verifyAccount` then re-emits an EQUAL state, bloc drops it as "no
/// change", the screen's listener never runs, and the holder name never
/// reaches the form — `_isBankReceiverReady` stays false and Next is dead.
/// Entering from quick services the cubit is `Initial`, the emit IS a change,
/// and the identical code works. That asymmetry was the entire reported
/// difference between the two doors into this flow.
///
/// Two properties close it, and both are source-level: the behaviour lives in
/// private methods of a StatefulWidget whose screen cannot be pumped without
/// the whole service locator, and the defect in each case is a MISSING early
/// exit rather than a wrong value.
void main() {
  final src = File('lib/src/features/split_bills/presentation/view/'
          'create_split_bill_screen.dart')
      .readAsStringSync()
      // This file explains both rules at length directly above the code that
      // implements them, so a raw scan would match the prose.
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');

  String bodyOf(String signature) {
    final i = src.indexOf(signature);
    expect(i, greaterThan(-1),
        reason: '$signature moved; re-point this guard');
    // Far enough to cover either method without running into the next region.
    final end = (i + 2600).clamp(0, src.length);
    return src.substring(i, end);
  }

  test('a saved recipient that is already resolved triggers no lookup', () {
    final body = bodyOf('void _applySavedExternalRecipient(RecipientModel r)');

    expect(body.contains('r.accountHolderName'), isTrue,
        reason: 'the saved record carries the payee\'s real account name. '
            'Ignoring it and re-running the name enquiry put a '
            'transfer-style validation step inside the split-bill flow, '
            'which fails outright when the provider is slow or breaker-open');

    final resolvedAt = body.indexOf('fullyResolved');
    expect(resolvedAt, greaterThan(-1),
        reason: 'the fully-resolved short circuit is gone');

    // The early return must come BEFORE either lookup, or it is not a short
    // circuit at all.
    final returnAt = body.indexOf('if (fullyResolved) return;');
    final verifyAt = body.indexOf('_verifyReceiverBankAccount()');
    final suggestAt = body.indexOf('_suggestReceiverBanksAutoPick(');
    expect(returnAt, greaterThan(-1),
        reason: 'no early return, so a known recipient still hits the rail');
    expect(returnAt, lessThan(verifyAt),
        reason: 'the return must precede the verify call');
    expect(returnAt, lessThan(suggestAt),
        reason: 'the return must precede the bank-suggestion call');
  });

  test('verification consumes the shared cubit\'s CURRENT state', () {
    final body = bodyOf('void _verifyReceiverBankAccount()');

    expect(body.contains('AccountVerificationSuccess'), isTrue,
        reason: 'the screen must read the state it already has. A listener '
            'reports transitions; an equal re-emit is not a transition, so '
            'waiting for one is what made the send-funds entry hang');

    expect(
        body.contains('current.accountNumber == acct') &&
            body.contains('current.bankCode == bankCode'),
        isTrue,
        reason: 'the held state must be matched against the account being '
            'entered — applying it unconditionally would paste the '
            'send-funds recipient into the split bill');

    final applyAt = body.indexOf('current.accountName');
    final callAt = body.indexOf('verifier.verifyAccount(');
    expect(applyAt, greaterThan(-1), reason: 'the held name is never applied');
    expect(applyAt, lessThan(callAt),
        reason: 'the cached-state branch must come before the network call');
  });

  test('the screen does NOT reset the app-wide verification cubit', () {
    // Deliberate. The send-funds screen that opened this one is still mounted
    // underneath and owns the same instance; resetting on entry would wipe the
    // recipient it had verified, and the user would find that flow broken on
    // the way back. Reading the current state instead needs no reset.
    expect(src.contains('AccountVerificationCubit>().reset()'), isFalse,
        reason: 'resetting the shared cubit breaks the flow underneath; the '
            'current-state read exists so no reset is needed');
  });
}
