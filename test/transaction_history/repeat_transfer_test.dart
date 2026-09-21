import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/transaction_history/utils/repeat_transfer.dart';

/// Repeating a transfer is not a display concern — getting the RAIL wrong
/// sends a bank account number into the LazerVault-user lookup and the
/// transfer fails outright, and getting the AMOUNT wrong silently sends more
/// money than the user sent last time.
void main() {
  group('recipientFrom — which rail does a repeat go out on', () {
    test('a stamped LazerVault user id proves INTERNAL', () {
      final r = RepeatTransfer.recipientFrom(
        counterpartyName: 'Praiz Onah',
        counterpartyAccount: '0279098300',
        metadata: const {'counterparty_user_id': 'abc-123'},
      );
      expect(r.type, 'internal');
      expect(r.internalUserId, 'abc-123');
      expect(r.bankName, 'LazerVault');
    });

    test('recipient_user_id is accepted as the same proof', () {
      final r = RepeatTransfer.recipientFrom(
        counterpartyName: 'Praiz Onah',
        counterpartyAccount: '0279098300',
        metadata: const {'recipient_user_id': 'def-456'},
      );
      expect(r.type, 'internal');
      expect(r.internalUserId, 'def-456');
    });

    test('a named external bank is EXTERNAL and keeps its code', () {
      final r = RepeatTransfer.recipientFrom(
        counterpartyName: 'NNAEMEKA CHRISTIAN EZEKE',
        counterpartyAccount: '0279098300',
        metadata: const {
          'recipient_bank_name': 'Wema Bank PLC',
          'destination_bank_code': '035',
        },
      );
      expect(r.type, 'external');
      expect(r.bankName, 'Wema Bank PLC');
      expect(r.sortCode, '035');
      expect(r.internalUserId, isNull);
    });

    test('NO evidence at all falls back to EXTERNAL, not internal', () {
      // This is the important one. Treating an unknown row as internal routes
      // a bank account number into the LazerVault-user lookup, which 404s and
      // fails every time. External is the read that can still complete, and
      // the confirm screen shows the user the rail before they commit.
      final r = RepeatTransfer.recipientFrom(
        counterpartyName: 'Someone',
        counterpartyAccount: '0279098300',
        metadata: const {},
      );
      expect(r.type, 'external');
    });

    test('a bank literally named LazerVault is INTERNAL', () {
      final r = RepeatTransfer.recipientFrom(
        counterpartyName: 'Praiz Onah',
        counterpartyAccount: '0279098300',
        metadata: const {'bank_name': 'LazerVault'},
      );
      expect(r.type, 'internal');
      expect(r.bankName, 'LazerVault');
    });

    test('null metadata does not throw', () {
      final r = RepeatTransfer.recipientFrom(
        counterpartyName: 'Someone',
        counterpartyAccount: '123',
      );
      expect(r.type, 'external');
    });
  });

  group('prefillAmountMinor — repeat the PRINCIPAL, never principal + fee', () {
    test('prefers the backend-stamped principal', () {
      // A completed external transfer's history row is the CAPTURE row, whose
      // amount already includes the fee.
      expect(
        RepeatTransfer.prefillAmountMinor(
          amount: 120.75,
          metadata: const {'principal_minor': 10000, 'total_fee_minor': 2075},
        ),
        10000,
      );
    });

    test('subtracts the total fee when only that is known', () {
      expect(
        RepeatTransfer.prefillAmountMinor(
          amount: 120.75,
          metadata: const {'total_fee_minor': 2075},
        ),
        10000,
      );
    });

    test('uses the amount as-is for internal / no-fee rows', () {
      expect(
        RepeatTransfer.prefillAmountMinor(amount: 500, metadata: const {}),
        50000,
      );
      expect(RepeatTransfer.prefillAmountMinor(amount: 25), 2500);
    });

    test('a fee >= the amount is ignored rather than yielding <= 0', () {
      // A mis-stamped row must never pre-fill zero or a negative amount.
      expect(
        RepeatTransfer.prefillAmountMinor(
          amount: 10,
          metadata: const {'total_fee_minor': 5000},
        ),
        1000,
      );
    });

    test('string-typed metadata values still parse', () {
      // jsonb comes back with inconsistent types depending on the writer.
      expect(
        RepeatTransfer.prefillAmountMinor(
          amount: 120.75,
          metadata: const {'principal_minor': '10000'},
        ),
        10000,
      );
    });
  });

  group('canRepeat — never render a dead button', () {
    test('false without a counterparty name', () {
      expect(
        RepeatTransfer.canRepeat(
            counterpartyName: '', counterpartyAccount: '0279098300'),
        isFalse,
      );
      expect(RepeatTransfer.canRepeat(counterpartyAccount: '0279098300'),
          isFalse);
    });

    test('false with a name but nothing to address the payee by', () {
      expect(
        RepeatTransfer.canRepeat(
            counterpartyName: 'Praiz', counterpartyAccount: '   '),
        isFalse,
      );
    });

    test('true with an account number', () {
      expect(
        RepeatTransfer.canRepeat(
            counterpartyName: 'Praiz', counterpartyAccount: '0279098300'),
        isTrue,
      );
    });

    test('true with a user id and NO account number (internal payee)', () {
      // An internal payee resolves by user id, so demanding an account number
      // would hide Repeat on exactly the transfers that repeat most cleanly.
      expect(
        RepeatTransfer.canRepeat(
          counterpartyName: 'Praiz',
          counterpartyAccount: '',
          metadata: const {'counterparty_user_id': 'abc-123'},
        ),
        isTrue,
      );
    });
  });
}
