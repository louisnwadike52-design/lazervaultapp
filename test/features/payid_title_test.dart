import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/id_pay/domain/entities/id_pay_entity.dart';

/// A PayID can be NAMED.
///
/// A list of "PAY-A3K9X2 / PAY-H786KF / PAY-RSW6DQ" is unreadable the moment
/// somebody has more than two, and the code is not what the creator remembers
/// the request by. The name is distinct from the description: the description
/// is shown to the PAYER and says what they are paying for.
void main() {
  final fixedExpiry = DateTime.utc(2026, 12, 31);
  final fixedCreated = DateTime.utc(2026, 10, 15);

  IDPayEntity payId({String title = ''}) => IDPayEntity(
        id: 'id-1',
        payId: 'A1B2C3',
        creatorId: 'u-1',
        creatorName: 'Ada Obi',
        creatorUsername: 'ada',
        type: IDPayType.oneTime,
        amountMode: IDPayAmountMode.fixed,
        amount: 2500,
        minAmount: 0,
        maxAmount: 0,
        currency: 'NGN',
        description: 'Studio session',
        title: title,
        status: IDPayStatus.active,
        expiresAt: fixedExpiry,
        createdAt: fixedCreated,
        totalReceived: 0,
        paymentCount: 0,
      );

  group('an unnamed PayID still reads as something', () {
    test('displayTitle falls back to the code', () {
      // Every PayID created before this field existed has an empty title.
      expect(payId().displayTitle, 'PAY-A1B2C3');
      expect(payId(title: '   ').displayTitle, 'PAY-A1B2C3');
      expect(payId().hasTitle, isFalse);
      expect(payId(title: '  ').hasTitle, isFalse);
    });

    test('a named one leads with the name', () {
      expect(payId(title: 'October rent').displayTitle, 'October rent');
      expect(payId(title: '  October rent  ').displayTitle, 'October rent');
      expect(payId(title: 'October rent').hasTitle, isTrue);
    });
  });

  test('the title takes part in equality, or a rename would not repaint', () {
    expect(payId(title: 'a') == payId(title: 'b'), isFalse);
    expect(payId(title: 'a') == payId(title: 'a'), isTrue);
  });

  test('copyWith carries it', () {
    expect(payId().copyWith(title: 'Rent').title, 'Rent');
    expect(payId(title: 'Rent').copyWith().title, 'Rent');
  });

  group('the wiring', () {
    String codeOf(String p) => File(p)
        .readAsStringSync()
        .split('\n')
        .where((l) =>
            !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
        .join('\n');

    test('it survives every layer between the field and the wire', () {
      // A field that is collected and then dropped by one layer is the
      // commonest shape of this bug, and the only visible symptom is a name
      // that silently never saves.
      const layers = {
        'lib/src/features/id_pay/presentation/view/create_id_pay_screen.dart':
            'title: _titleController.text.trim().isNotEmpty',
        'lib/src/features/id_pay/presentation/cubit/id_pay_cubit.dart':
            'title: title,',
        'lib/src/features/id_pay/data/repositories/id_pay_repository_impl.dart':
            'title: title,',
        'lib/src/features/id_pay/data/datasources/id_pay_remote_datasource.dart':
            "..title = title ?? ''",
        'lib/src/features/id_pay/data/models/id_pay_model.dart':
            'title: proto.title,',
      };
      layers.forEach((path, needle) {
        expect(codeOf(path), contains(needle),
            reason: '$path drops the title');
      });
    });

    test('the creation field is capped where the column is', () {
      const create =
          'lib/src/features/id_pay/presentation/view/create_id_pay_screen.dart';
      final s = codeOf(create);
      final i = s.indexOf('controller: _titleController,');
      expect(i, greaterThan(-1), reason: 'the Name field is gone');
      expect(s.substring(i, i + 400), contains('maxLength: 60'),
          reason: 'the column is varchar(60) and the service caps at 60 — a '
              'longer field would fail the create after the button press '
              'instead of showing a counter');
    });

    test('the list leads with the name only when there is one', () {
      const card =
          'lib/src/features/id_pay/presentation/widgets/id_pay_card.dart';
      final s = codeOf(card);
      expect(s, contains('if (idPay.hasTitle)'),
          reason: 'an unnamed PayID must keep exactly the old layout, or '
              'every row created before this field looks broken');
      expect(s, contains('idPay.hasTitle ? 13.sp : 16.sp'),
          reason: 'the code shrinks to a subtitle when a name leads');
    });
  });
}
