import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/funds/domain/batch_source_account_display.dart';

// THE SOURCE ACCOUNT WAS NAMED BY WHICHEVER RAIL MINTED IT FIRST.
//
// `accounts.account_name` is frozen at mint time and is not rewritten when a
// wallet's virtual account moves to another provider, so after the
// Flutterwave to Nomba switch a Nomba-issued number was still presented as
// "Praiz Onah FLW". The batch detail showed that column and nothing else, so
// every batch looked as though it had been paid from the old rail.
//
// The live per-rail name is already on the device as
// virtualAccountHolderName, projected from account_virtual_accounts for the
// account's ACTIVE provider.

AccountSummaryEntity _account({
  required String id,
  required String accountType,
  String? accountNumber,
  String last4 = '',
  String? bankName,
  String? holder,
  String? label,
}) {
  return AccountSummaryEntity(
    id: id,
    accountType: accountType,
    currency: 'NGN',
    balance: 0,
    availableBalance: 0,
    reservedBalance: 0,
    accountNumberLast4: last4,
    accountNumber: accountNumber,
    bankName: bankName,
    virtualAccountHolderName: holder,
    trendPercentage: 0,
    isPrimary: false,
    accountLabel: label,
    status: 'active',
    isFamilyAccount: false,
  );
}

void main() {
  test('the rail holder name wins over the frozen account_name', () {
    final out = batchSourceAccountDisplay(
      sourceAccountNumber: '1234567890',
      sourceAccountName: 'Praiz Onah FLW', // the stale mint-time value
      accounts: [
        _account(
          id: 'a1',
          accountType: 'personal',
          accountNumber: '1234567890',
          bankName: 'Nomba',
          holder: 'Praiz Onah',
        ),
      ],
    );
    expect(out.holder, 'Praiz Onah',
        reason: 'the name on the rail issuing the number NOW');
    expect(out.bankName, 'Nomba',
        reason: 'the provider actually used, not the first one');
    expect(out.label, 'Personal');
    expect(out.resolvedLocally, isTrue);
  });

  test('a user label beats the account type', () {
    final out = batchSourceAccountDisplay(
      sourceAccountNumber: '2222222222',
      sourceAccountName: 'whatever',
      accounts: [
        _account(
          id: 'a2',
          accountType: 'family',
          accountNumber: '2222222222',
          label: 'Smith Family',
          holder: 'Smith Family Pool',
        ),
      ],
    );
    expect(out.label, 'Smith Family');
  });

  test('an unknown account type is not guessed as personal', () {
    // Mislabelling a wallet "Personal" is not cosmetic elsewhere in the app —
    // personal-only behaviour is gated on that type.
    final out = batchSourceAccountDisplay(
      sourceAccountNumber: '3333333333',
      sourceAccountName: 'x',
      accounts: [
        _account(
          id: 'a3',
          accountType: 'something_new',
          accountNumber: '3333333333',
          holder: 'Holder',
        ),
      ],
    );
    expect(out.label, 'Account');
  });

  test('a masked summary still matches on the last four', () {
    final out = batchSourceAccountDisplay(
      sourceAccountNumber: '9876543210',
      sourceAccountName: 'stale',
      accounts: [
        _account(
          id: 'a4',
          accountType: 'savings',
          last4: '3210',
          bankName: 'Wema Bank',
          holder: 'Live Holder',
        ),
      ],
    );
    expect(out.resolvedLocally, isTrue,
        reason: 'refusing to match the tail would send an identifiable '
            'account down the unresolved path');
    expect(out.holder, 'Live Holder');
  });

  test('an account not on this device falls back without inventing a label',
      () {
    final out = batchSourceAccountDisplay(
      sourceAccountNumber: '5555555555',
      sourceAccountName: 'Server Supplied Name',
      accounts: const [],
    );
    expect(out.resolvedLocally, isFalse);
    expect(out.holder, 'Server Supplied Name',
        reason: 'show what the server said rather than nothing');
    expect(out.label, isEmpty,
        reason: 'a label we cannot verify must not be guessed — the caller '
            'falls back to the generic heading');
    expect(out.bankName, isEmpty);
  });

  test('a wallet with no minted virtual account keeps the server name', () {
    final out = batchSourceAccountDisplay(
      sourceAccountNumber: '7777777777',
      sourceAccountName: 'Only Known Name',
      accounts: [
        _account(
          id: 'a5',
          accountType: 'personal',
          accountNumber: '7777777777',
          holder: '', // no rail has reported one
        ),
      ],
    );
    expect(out.holder, 'Only Known Name');
    expect(out.label, 'Personal');
  });
}
