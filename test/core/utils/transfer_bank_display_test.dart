import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/transfer_bank_display.dart';

void main() {
  group('TransferBankDisplay.resolve', () {
    test('names an external bank and keeps its code for logo lookup', () {
      final r = TransferBankDisplay.resolve(
        {'bank_name': 'Access Bank', 'bank_code': '044'},
        isTransfer: true,
      );
      expect(r, isNotNull);
      expect(r!.name, 'Access Bank');
      expect(r.code, '044');
      expect(r.isLazerVault, isFalse);
      expect(r.shortLabel, 'Access Bank');
    });

    test('an internal transfer resolves to LazerVault instead of nothing', () {
      // The bug this exists for: with no bank in metadata the receipt rendered
      // NO institution row at all, so the one field saying where the money
      // went was blank on every internal transfer.
      final r = TransferBankDisplay.resolve(
        {'transfer_type': 'internal'},
        isTransfer: true,
      );
      expect(r, isNotNull);
      expect(r!.name, 'LazerVault');
      expect(r.isLazerVault, isTrue);
      expect(r.shortLabel, 'LV');
    });

    test('a resolved LazerVault user id is proof of internal', () {
      final r = TransferBankDisplay.resolve(
        {'recipient_user_id': 'e2b1c0de-0000-4000-8000-000000000001'},
        isTransfer: true,
      );
      expect(r?.isLazerVault, isTrue);
    });

    test('a bank literally named LazerVault normalises to internal', () {
      final r = TransferBankDisplay.resolve(
        {'bank_name': 'Lazervault'},
        isTransfer: true,
      );
      expect(r?.isLazerVault, isTrue);
      expect(r?.name, 'LazerVault');
      expect(r?.code, isNull);
    });

    test('an external bank wins over any type flag', () {
      // Positive evidence of an external destination beats a stale/defaulted
      // type field — the same defaulting that mis-routed live transfers.
      final r = TransferBankDisplay.resolve(
        {'bank_name': 'GTBank', 'transfer_type': 'internal'},
        isTransfer: true,
      );
      expect(r?.isLazerVault, isFalse);
      expect(r?.name, 'GTBank');
    });

    test('a transfer with no bank and no proof claims nothing', () {
      // Guessing "internal" from the ABSENCE of a bank is the mistake that
      // caused live transfers to be rejected. Showing no row is correct.
      final r = TransferBankDisplay.resolve(
        {'note': 'lunch'},
        isTransfer: true,
      );
      expect(r, isNull);
    });

    test('non-transfers never claim an institution', () {
      final r = TransferBankDisplay.resolve(
        {'transfer_type': 'internal'},
        isTransfer: false,
      );
      expect(r, isNull);
    });

    test('null and empty metadata are safe', () {
      expect(TransferBankDisplay.resolve(null, isTransfer: true), isNull);
      expect(TransferBankDisplay.resolve({}, isTransfer: true), isNull);
      expect(
        TransferBankDisplay.resolve({'bank_name': '   '}, isTransfer: true),
        isNull,
      );
    });

    test('camelCase metadata keys resolve too', () {
      final r = TransferBankDisplay.resolve(
        {'destinationBankName': 'Zenith Bank', 'destinationBankCode': '057'},
        isTransfer: true,
      );
      expect(r?.name, 'Zenith Bank');
      expect(r?.code, '057');
    });
  });
}
