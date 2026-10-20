import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// CTA STATES ON THE SPLIT-BILL DETAIL AND CREATE SCREENS.
///
/// Three reported problems, all about a button that does not say what it is
/// doing:
///   - Cancel left the page instead of re-rendering with the cancelled status
///     and the CTAs that go with it;
///   - "Remove from my list" had no progress at all and always failed,
///     because the RPC was never forwarded by the gateway;
///   - a duplicate title was only caught at submit, after the whole flow.
void main() {
  String strip(String src) => src
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');

  final detail = strip(File(
          'lib/src/features/split_bills/presentation/view/split_bill_detail_screen.dart')
      .readAsStringSync());
  final create = strip(File(
          'lib/src/features/split_bills/presentation/view/create_split_bill_screen.dart')
      .readAsStringSync());

  group('cancel', () {
    test('re-renders the page instead of leaving it', () {
      final i = detail.indexOf('state is SplitBillCancelled');
      expect(i, greaterThan(-1));
      // Bounded by the NEXT branch: SplitBillHidden legitimately still
      // leaves, because a hidden bill is gone from this user's list.
      final end = detail.indexOf('state is SplitBillHidden', i);
      expect(end, greaterThan(i), reason: 'the Hidden branch moved');
      final body = detail.substring(i, end);
      expect(body.contains('loadBillDetail(splitBillId)'), isTrue,
          reason: 'cancelling changes what the page offers — status, banner '
              'and the Remove CTA — so it has to reload, not pop');
      expect(body.contains('_leaveAfterTerminalAction'), isFalse,
          reason: 'popping hid the cancelled state the user just created');
    });

    test('the CTA carries its own progress', () {
      expect(detail.contains('_cancelInFlight'), isTrue);
    });
  });

  group('remove from my list', () {
    test('the CTA has a loading state and cannot be double-tapped', () {
      expect(detail.contains('bool _removeInFlight'), isTrue);
      expect(detail.contains('onPressed: _removeInFlight'), isTrue,
          reason: 'the button must disable itself while removing');
      expect(detail.contains("'Removing…'"), isTrue,
          reason: 'the label should say what is happening');
    });

    test('a failure clears the spinner so it can be retried', () {
      final i = detail.indexOf('if (_removeInFlight)');
      expect(i, greaterThan(-1),
          reason: 'nothing resets the flag, so a failed removal leaves the '
              'button disabled for ever');
    });

    test('progress starts only after the confirmation is accepted', () {
      final i = detail.indexOf('if (ok != true) return;');
      expect(i, greaterThan(-1),
          reason: 'showing progress while the dialog is open claims work '
              'that has not started');
    });
  });

  group('duplicate title', () {
    test('is checked on blur, not on every keystroke', () {
      expect(create.contains('_titleFocus'), isTrue);
      expect(create.contains('if (!_titleFocus.hasFocus) _checkTitleForDuplicate();'),
          isTrue,
          reason: 'per-keystroke checking flags "Dinn" on the way to '
              '"Dinner 2" and fights the user as they type');
    });

    test('is checked again on Next', () {
      final i = create.indexOf('void _goToStepTwo()');
      expect(i, greaterThan(-1));
      final body = create.substring(i, (i + 900).clamp(0, create.length));
      expect(body.contains('_checkTitleForDuplicate();'), isTrue,
          reason: 'a user who types then taps Next never blurs the field');
    });

    test('shows inline under the field and clears as they retype', () {
      expect(create.contains('errorText: _titleDuplicateWarning'), isTrue);
      expect(create.contains('_titleDuplicateWarning = null'), isTrue,
          reason: 'leaving the warning up while they fix it is noise');
    });
  });
}
