import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';

/// Financial Connections and the saved lists are about PEOPLE, so the name
/// shown is the person's — not the account name a rail returned.
///
/// Name-enquiry and settlement rails decorate the account holder at either
/// end: a prefix ("LAZERVAULT/Nnaemeka Ezeke") or a trailing processor tag
/// ("Promise Ezike FLW"). Both were reaching the Connections list verbatim.
///
/// The prefix stripper existed but gave up when the record carried no
/// bankName — which a P2P connection row usually does not — and nothing
/// handled a suffix at all.
RecipientModel _r({
  required String name,
  String bankName = '',
  String accountNumber = '0123456789',
}) =>
    RecipientModel(
      id: 'r1',
      name: name,
      accountNumber: accountNumber,
      bankName: bankName,
      sortCode: '',
      isFavorite: false,
    );

void main() {
  group('institution prefix', () {
    test('stripped when the record carries no bank — the leaking case', () {
      expect(_r(name: 'LAZERVAULT/Nnaemeka Ezeke').displayName,
          'Nnaemeka Ezeke');
    });

    test('stripped when it matches the record bank', () {
      expect(
        _r(name: 'Kuda/Ada Obi', bankName: 'Kuda').displayName,
        'Ada Obi',
      );
    });

    test('a slash that is NOT an institution is left alone', () {
      expect(_r(name: 'Ada/Obi Trading').displayName, 'Ada/Obi Trading');
    });
  });

  group('processor suffix', () {
    test('a trailing tag is dropped', () {
      expect(_r(name: 'Promise Ezike FLW').displayName, 'Promise Ezike');
    });

    test('a real surname is never eaten', () {
      expect(_r(name: 'Promise Ezike').displayName, 'Promise Ezike');
    });

    test('only the final token, and only a known one', () {
      expect(_r(name: 'Flw Adaobi Nwosu').displayName, 'Flw Adaobi Nwosu');
    });
  });

  test('both ends at once', () {
    expect(_r(name: 'LAZERVAULT/Promise Ezike FLW').displayName,
        'Promise Ezike');
  });

  test('never strips down to nothing', () {
    // An empty row is worse than a decorated one.
    expect(_r(name: 'LAZERVAULT/').displayName.isNotEmpty, isTrue);
  });
}
