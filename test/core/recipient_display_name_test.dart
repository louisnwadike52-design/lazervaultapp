import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';

RecipientModel _r({required String name, String bankName = 'Lazervault', String? alias}) =>
    RecipientModel(
      id: '1',
      name: name,
      accountNumber: '0123456789',
      bankName: bankName,
      isFavorite: false,
      sortCode: '',
      alias: alias,
    );

/// A financial connection is a list of PEOPLE. Some recipients are stored with
/// the account label instead ("Lazervault/Nnaemeka Ezeke"), where the
/// institution is both redundant and the less useful half.
void main() {
  test('drops the recipient\'s own institution prefix', () {
    expect(_r(name: 'Lazervault/Nnaemeka Ezeke').displayName, 'Nnaemeka Ezeke');
    expect(_r(name: 'lazervault/Jane Doe').displayName, 'Jane Doe');
  });

  test('leaves a DIFFERENT institution visible rather than hiding it', () {
    // Not this recipient's bank — stripping would silently discard information.
    expect(_r(name: 'GTBank/Jane Doe').displayName, 'GTBank/Jane Doe');
  });

  test('never mangles a name that merely contains a slash', () {
    expect(_r(name: 'Ada/Chidi Joint').displayName, 'Ada/Chidi Joint');
  });

  test('never strips down to nothing', () {
    expect(_r(name: 'Lazervault/').displayName, 'Lazervault/');
  });

  test('alias still wins', () {
    expect(_r(name: 'Lazervault/Nnaemeka Ezeke', alias: 'Chris').displayName, 'Chris');
  });
}
