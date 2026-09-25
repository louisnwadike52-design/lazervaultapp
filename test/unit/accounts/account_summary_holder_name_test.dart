import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/generated/accounts.pb.dart';

/// virtualAccountHolderName was hand-added to the generated AccountSummary,
/// because the checked-in proto is behind the generated Dart (it lacks bank_name
/// and bank_code entirely) and regenerating from it would delete fields the app
/// uses today.
///
/// Hand-editing generated protobuf carries one specific hazard: the accessor
/// index ($_getSZ/$_setString) is the field's ORDINAL position, while the
/// TagNumber is the wire number. Get the index wrong and the field silently
/// returns a NEIGHBOUR's value — which is exactly the failure being fixed here,
/// where the card showed one rail's number beside another rail's holder name.
///
/// These tests read the neighbours back alongside it, so a wrong index shows up
/// as a crossed value rather than passing unnoticed.
void main() {
  group('AccountSummary.virtualAccountHolderName', () {
    test('round-trips without disturbing its neighbours', () {
      final s = AccountSummary()
        ..accountName = 'Smith Family'
        ..bankName = 'Nombank MFB'
        ..bankCode = '090645'
        ..virtualAccountHolderName = 'LAZERVAULT/Praiz Onah';

      expect(s.virtualAccountHolderName, 'LAZERVAULT/Praiz Onah');
      // If the index collided, one of these would come back as the holder name.
      expect(s.bankCode, '090645');
      expect(s.bankName, 'Nombank MFB');
      expect(s.accountName, 'Smith Family');
    });

    test('survives a serialize/parse cycle on the wire', () {
      final original = AccountSummary()
        ..bankName = 'Nombank MFB'
        ..bankCode = '090645'
        ..accountName = 'Smith Family'
        ..virtualAccountHolderName = 'LAZERVAULT/Praiz Onah';

      final decoded = AccountSummary.fromBuffer(original.writeToBuffer());

      // The real journey is backend -> bytes -> app. A tag mismatch would be
      // invisible in-process and only fail here.
      expect(decoded.virtualAccountHolderName, 'LAZERVAULT/Praiz Onah');
      expect(decoded.bankCode, '090645');
      expect(decoded.bankName, 'Nombank MFB');
      expect(decoded.accountName, 'Smith Family');
    });

    test('is absent rather than defaulted when the backend omits it', () {
      final s = AccountSummary()..bankName = 'Nombank MFB';
      expect(s.hasVirtualAccountHolderName(), isFalse);
      expect(s.virtualAccountHolderName, '');
    });

    test('the factory constructor sets it', () {
      final s = AccountSummary(
        bankCode: '090645',
        virtualAccountHolderName: 'LAZERVAULT/Praiz Onah',
      );
      expect(s.virtualAccountHolderName, 'LAZERVAULT/Praiz Onah');
      expect(s.bankCode, '090645');
    });

    test('the holder name is distinct from the wallet label', () {
      // The whole point of the separate field: a user-chosen label must not be
      // replaced by the bank holder name, and vice versa.
      final s = AccountSummary()
        ..accountName = 'Investment'
        ..virtualAccountHolderName = 'LAZERVAULT/Promise Ezike';
      expect(s.accountName, 'Investment');
      expect(s.virtualAccountHolderName, 'LAZERVAULT/Promise Ezike');
    });
  });
}
