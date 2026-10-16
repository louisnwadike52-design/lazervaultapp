import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The PayID description has ALWAYS been optional, and only the UI implied
/// otherwise.
///
/// `_onNext` gates on nothing, `_onCreate` sends `null` when the field is
/// blank, the review step omits the row when empty, and id-pay-service does
/// not require it. But the step said "Add a description and set the expiry
/// duration" and the field carried a bare "Description" label — so people
/// filled it believing they had to.
void main() {
  String code(String p) => File(p)
      .readAsStringSync()
      .split('\n')
      .where((l) =>
          !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
      .join('\n');

  const screen =
      'lib/src/features/id_pay/presentation/view/create_id_pay_screen.dart';

  test('the UI says the field is optional', () {
    final s = code(screen);
    expect(s, contains("'(optional)'"),
        reason: 'the label gives no indication the field can be left empty');
    // Matched as a PATTERN, not an exact sentence. This asserted
    // 'A description is optional.' verbatim and broke when the step gained a
    // NAME field and the copy widened to "A name and description are
    // optional." — the UI had got strictly better and the test called it a
    // regression. What matters is that the subtitle still says the
    // description can be left out, in whatever sentence it ends up in.
    expect(s, matches(RegExp(r'description (is|are) optional')),
        reason: 'the step subtitle must still say the description is optional, '
            'or it reads as an instruction to add one');
    expect(
        s, isNot(contains("'Add a description and set the expiry duration'")),
        reason: 'the old instruction reads as a requirement');
  });

  test('nothing blocks Next on an empty description', () {
    final s = code(screen);
    final i = s.indexOf('void _onNext()');
    expect(i, greaterThan(-1));
    final body = s.substring(i, s.indexOf('\n  }', i));
    expect(body, isNot(contains('_descriptionController')),
        reason: 'Next must not start validating a field we call optional');
  });

  test('a blank description is sent as null, not an empty string', () {
    // An empty string would be stored and then rendered as a blank
    // description row on the payment page and the receipt.
    final s = code(screen);
    expect(s,
        contains('description: _descriptionController.text.trim().isNotEmpty'),
        reason: 'the create call must distinguish "not given" from ""');
  });

  test('the review step omits the row when there is no description', () {
    final s = code(screen);
    expect(s, contains("if (_descriptionController.text.trim().isNotEmpty)"),
        reason: 'an empty Description row on the review step reads as a '
            'field the user failed to fill');
  });
}
