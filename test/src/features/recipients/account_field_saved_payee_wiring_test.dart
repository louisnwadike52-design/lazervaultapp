import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The account-number field's saved-payee wiring.
///
/// AddRecipient needs a service locator, several blocs and ScreenUtil to pump,
/// and the regressions worth catching here are not visual — they are a value
/// not passed and a branch taken on the wrong condition, each of which
/// compiles perfectly and shows up only against a live form. Pinning the
/// wiring is what catches those; the behaviour itself is covered against the
/// cubit in saved_payee_as_you_type_test.dart.
void main() {
  late final String src;

  setUpAll(() {
    src = File(
      'lib/src/features/recipients/presentation/widgets/add_recipient.dart',
    ).readAsStringSync();
  });

  test('matches are computed on the keystroke, not behind the debounce', () {
    final onChanged = src.substring(
      src.indexOf('void _onAccountNumberChanged('),
      src.indexOf('void _revealBankField('),
    );
    final savedAt = onChanged.indexOf('_savedMatchesFor(value)');
    final timerAt = onChanged.indexOf('_suggestDebounce = Timer(');
    expect(savedAt, greaterThan(-1),
        reason: 'the saved-payee match is gone from the typing path');
    expect(savedAt, lessThan(timerAt),
        reason: 'the payer\'s own saved set is already in memory. Putting it '
            'behind the 400ms debounce — or behind the bank name-enquiry, '
            'which takes seconds — is latency for nothing.');
    expect(onChanged.contains('_bankSuggestions = saved'), isTrue,
        reason: 'the matches are computed and then dropped');
  });

  test('a partial number still shows matches', () {
    final onChanged = src.substring(
      src.indexOf('void _onAccountNumberChanged('),
      src.indexOf('void _revealBankField('),
    );
    expect(onChanged.contains('if (!complete) {\n        _bankSuggestions = [];'),
        isFalse,
        reason: 'an incomplete number is clearing the list again, which is '
            'exactly the behaviour that made saved payees invisible until '
            'the tenth digit');
  });

  test('the bank lookup does not blank the list it is adding to', () {
    expect(
      src.contains('(_loadingSuggestions && _bankSuggestions.isEmpty)'),
      isTrue,
      reason: 'the spinner is an either/or with the matches again — the saved '
          'payee the payer is reaching for vanishes at the tenth digit and '
          'returns seconds later, under their thumb',
    );
  });

  test('selecting a match fills the field with the FULL number', () {
    for (final fn in const [
      'void _selectSuggestion(AccountSuggestion s) {',
      'void _selectLazervaultSuggestion(AccountSuggestion s) {',
    ]) {
      final at = src.indexOf(fn);
      expect(at, greaterThan(-1), reason: '$fn is gone');
      final body = src.substring(at, at + 400);
      expect(body.contains('_syncAccountFieldTo(s.accountNumber)'), isTrue,
          reason: 'a suggestion can now be tapped from a PARTIAL number. '
              'Without this the field keeps the three digits typed while the '
              'confirmation sheet shows a resolved payee, and cancelling '
              'strands the form in a state it cannot act on.');
    }
  });

  test('dismissing a typing preview does not open the bank fallback', () {
    final at = src.indexOf('void _dismissSuggestionsRevealBank() {');
    final body = src.substring(at, src.indexOf('}', src.indexOf('_revealBankField();', at)));
    expect(body.contains('if (_savedOnlyPreview) return;'), isTrue,
        reason: 'the Bank field means "we could not resolve this number". A '
            'payer three digits in has not reached that question, and the '
            'form should not push itself open under them mid-type.');
  });

  test('the bounds come from the admin settings, not from literals', () {
    expect(src.contains('FeatureFlags.savedPayeeMinDigits'), isTrue);
    expect(src.contains('FeatureFlags.savedPayeeMaxRows'), isTrue);
  });
}
