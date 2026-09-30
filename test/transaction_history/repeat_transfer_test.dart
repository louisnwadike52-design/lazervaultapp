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
      // Normal case — BrandBank.displayName, the spelling the backend writes.
      expect(r.bankName, 'Lazervault');
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

    test('NO evidence at all reads as INTERNAL — the only read with a route',
        () {
      // This one reversed on production evidence.
      //
      // The original rule was "absent proof, go out EXTERNAL, because that is
      // the read that can still complete". It cannot. Every internal transfer
      // in `payments.payments` lands with `metadata = {}` — no bank, no type,
      // no user id — so the external read produces a payee with an EMPTY bank
      // code, and the send-funds form refuses it outright with "Bank details
      // are incomplete. Please verify the recipient's bank information."
      // Nothing with empty metadata could ever be repeated, which is most
      // internal transfers.
      //
      // Read as internal, a genuinely internal transfer repeats. A genuinely
      // external one fails at the recipient lookup with a sentence that says
      // what to do next ("That recipient isn't a LazerVault account. Send to
      // their bank instead"). Neither path moves money on a mistake, and only
      // one of them ever succeeds.
      final r = RepeatTransfer.recipientFrom(
        counterpartyName: 'Someone',
        counterpartyAccount: '0279098300',
        metadata: const {},
      );
      expect(r.type, 'internal');
    });

    test('a bank CODE alone is enough to go out external', () {
      // The production shape this whole fix exists for: core-payments stamps
      // `destination_bank` holding the CODE and often no name at all (28 of
      // the 69 external transfers on record). Both readers looked only for
      // `destination_bank_code`, which is never written, so every external
      // Redo was built with an empty bank and refused by the form.
      final r = RepeatTransfer.recipientFrom(
        counterpartyName: 'GRACE C. ONWUANAKU',
        counterpartyAccount: '2083014282',
        metadata: const {'destination_bank': '057'},
      );
      expect(r.type, 'external');
      expect(r.sortCode, '057');
      expect(r.bankName, 'Zenith Bank', reason: 'named from the code');
    });

    test('rail_bank_code is read too', () {
      final r = RepeatTransfer.recipientFrom(
        counterpartyName: 'GRACE C. ONWUANAKU',
        counterpartyAccount: '2083014282',
        metadata: const {'rail_bank_code': '035'},
      );
      expect(r.type, 'external');
      expect(r.sortCode, '035');
    });

    test('a bank literally named LazerVault is INTERNAL', () {
      final r = RepeatTransfer.recipientFrom(
        counterpartyName: 'Praiz Onah',
        counterpartyAccount: '0279098300',
        metadata: const {'bank_name': 'LazerVault'},
      );
      expect(r.type, 'internal');
      // Camel-cased IN (an older build saved it that way), normal-case OUT.
      expect(r.bankName, 'Lazervault');
    });

    test('null metadata does not throw', () {
      final r = RepeatTransfer.recipientFrom(
        counterpartyName: 'Someone',
        counterpartyAccount: '123',
      );
      expect(r.type, 'internal');
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
      expect(
          RepeatTransfer.canRepeat(counterpartyAccount: '0279098300'), isFalse);
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
  /// The invariant that makes "Redo" trustworthy: the button is offered
  /// exactly when the send-funds form will accept the payee it rebuilds.
  ///
  /// The long flow refuses an external payee missing either half of its bank
  /// details. canRepeat used to ask only for a name plus an account number, so
  /// on every external transfer in production it said yes and the flow then
  /// said "Bank details are incomplete." Deriving canRepeat from recipientFrom
  /// makes the two incapable of disagreeing.
  group('canRepeat agrees with what the send-funds form accepts', () {
    bool formWouldAccept(Map<String, dynamic>? md, String account) {
      final r = RepeatTransfer.recipientFrom(
        counterpartyName: 'Payee',
        counterpartyAccount: account,
        metadata: md,
      );
      // initiate_send_funds.dart: an external payee needs BOTH halves.
      if (r.type == 'external') {
        return r.accountNumber.isNotEmpty &&
            r.sortCode.trim().isNotEmpty &&
            r.bankName.trim().isNotEmpty;
      }
      return (r.internalUserId ?? '').isNotEmpty || r.accountNumber.isNotEmpty;
    }

    final rows = <String, Map<String, dynamic>>{
      'external with code only (the production shape)': {
        'destination_bank': '057',
      },
      'external with code and name': {
        'destination_bank': '035',
        'bank_name': 'Wema Bank PLC',
      },
      'external with an UNKNOWN code we cannot name': {
        'destination_bank': '999999',
      },
      'internal by user id': {'counterparty_user_id': 'abc-123'},
      'internal by bank name': {'bank_name': 'Lazervault'},
      'empty metadata (every internal transfer on record)':
          <String, dynamic>{},
    };

    rows.forEach((label, md) {
      test(label, () {
        for (final account in const ['2083014282', '']) {
          expect(
            RepeatTransfer.canRepeat(
              counterpartyName: 'Payee',
              counterpartyAccount: account,
              metadata: md,
            ),
            formWouldAccept(md, account),
            reason: '$label (account: "$account") — the button and the form '
                'must never disagree',
          );
        }
      });
    });
  });

}
