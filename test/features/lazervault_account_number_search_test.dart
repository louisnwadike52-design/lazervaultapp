import 'package:flutter_test/flutter_test.dart';

import 'package:lazervault/core/utils/brand_bank.dart';
import 'package:lazervault/core/utils/masked_account_number.dart';
import 'package:lazervault/src/features/recipients/data/datasources/lazervault_account_lookup.dart';
import 'package:lazervault/src/features/recipients/domain/entities/account_suggestion.dart';
import 'package:lazervault/src/features/recipients/domain/entities/unified_search_result.dart';

/// Guards the two decisions that search-by-account-number rests on:
///
///  1. WHEN the account lookup runs. It is driven by the SHAPE of what the
///     user typed, because asking them to pick a mode is the thing this
///     feature exists to remove — so the shape test has to be exactly right.
///     It also must never swallow the phone search: the same digits are a
///     valid phone number, and both are looked up.
///  2. WHAT a resolved account turns into. A Lazervault account number must
///     produce an INTERNAL destination, with the positive proof
///     `RecipientModel.canSendAsInternal` demands — and it must do so through
///     `BrandBank`, never a hand-written brand literal.
void main() {
  group('account-number shape detection', () {
    test('accepts the real account-number lengths', () {
      expect(
          LazervaultAccountLookup.looksLikeAccountNumber('1234567890'), isTrue,
          reason: '10-digit NG NUBAN');
      expect(
          LazervaultAccountLookup.looksLikeAccountNumber('08012345678'), isTrue,
          reason: '11-digit wallet-phone form');
      expect(LazervaultAccountLookup.looksLikeAccountNumber('12345678'), isTrue,
          reason: '8-digit UK account number');
    });

    test('tolerates the separators people paste', () {
      expect(LazervaultAccountLookup.looksLikeAccountNumber('0123 456 789'),
          isTrue);
      expect(LazervaultAccountLookup.looksLikeAccountNumber('12-34-56-78'),
          isTrue);
    });

    test('rejects anything that is not purely digits', () {
      // The bug this exists to stop: stripping non-digits rather than
      // REQUIRING digits turned a name search into an account lookup.
      expect(LazervaultAccountLookup.looksLikeAccountNumber('praiz1234567'),
          isFalse);
      expect(
          LazervaultAccountLookup.looksLikeAccountNumber('praizonah'), isFalse);
      expect(LazervaultAccountLookup.looksLikeAccountNumber('ez@gmail.com'),
          isFalse);
      expect(LazervaultAccountLookup.looksLikeAccountNumber('+2348012345678'),
          isFalse);
    });

    test('rejects a number still being typed, and an over-long one', () {
      expect(
          LazervaultAccountLookup.looksLikeAccountNumber('1234567'), isFalse);
      expect(LazervaultAccountLookup.looksLikeAccountNumber('123456789012'),
          isFalse);
    });

    test('an 11-digit leading-zero number is also tried as its 10-digit NUBAN',
        () {
      expect(LazervaultAccountLookup.candidatesFor('08012345678'),
          <String>['08012345678', '8012345678']);
      // A plain 10-digit number is one probe, not two.
      expect(LazervaultAccountLookup.candidatesFor('1234567890'),
          <String>['1234567890']);
      expect(LazervaultAccountLookup.candidatesFor('praiz'), isEmpty);
    });
  });

  group('masking', () {
    test('masks a real account number to its last four', () {
      expect(maskedAccountNumber('1234567890'), '•••• 7890');
    });

    test('refuses to mask what is not an account number', () {
      // An internal payee created from a chat carries the user-id UUID here.
      // Masking it would print a meaningless fragment as the destination.
      expect(maskedAccountNumber('9f1c2b7a-0e44-4a1e-9f0e-7b2a1c3d4e5f'), '');
      expect(maskedAccountNumber('@praiz'), '');
      expect(maskedAccountNumber(''), '');
      expect(maskedAccountNumber(null), '');
    });
  });

  group('a resolved account becomes an INTERNAL destination', () {
    const match = LazervaultAccountMatch(
      accountId: 'acct-uuid-1',
      userId: 'user-uuid-1',
      accountNumber: '1234567890',
      holderName: 'Praiz Onah',
      username: 'praiz',
    );

    test('the search row routes internally and names the destination account',
        () {
      final row = UnifiedSearchResult.lazervaultAccount(
        userId: match.userId,
        accountId: match.accountId,
        accountNumber: match.accountNumber,
        holderName: match.holderName,
        username: match.username,
      );

      expect(row.accountNumberMatched, isTrue,
          reason: 'the row must be labelled so a phone match is '
              'distinguishable from an account match');
      expect(BrandBank.isOurs(row.bankName), isTrue,
          reason: 'the existing internal/external decision must see this '
              'as ours');
      expect(row.bankName, BrandBank.displayName,
          reason: 'displayed as "Lazervault", never the camel-cased sentinel');

      final recipient = row.toRecipientModel();
      expect(recipient.canSendAsInternal, isTrue);
      expect(recipient.type, 'internal');
      expect(recipient.internalUserId, match.userId);
      expect(recipient.internalAccountId, match.accountId,
          reason: 'the account the payer actually named is the destination');
      expect(recipient.accountNumber, match.accountNumber);
      expect(recipient.maskedAccount, '•••• 7890',
          reason: 'every row says WHICH account receives the money');
    });

    test('the bank suggestion is marked internal and carries the routing ids',
        () {
      final suggestion = AccountSuggestion.lazervault(
        accountNumber: match.accountNumber,
        accountName: match.holderName,
        userId: match.userId,
        accountId: match.accountId,
      );

      expect(suggestion.isLazervault, isTrue,
          reason: 'surfaces must be able to mark it internal + instant, and '
              'must never auto-apply it');
      expect(suggestion.bankCode, isEmpty,
          reason: 'there is no bank to pay out to');
      expect(suggestion.bankName, BrandBank.displayName);
      expect(BrandBank.isOurs(suggestion.bankName), isTrue);
      expect(suggestion.internalUserId, match.userId);
      expect(suggestion.internalAccountId, match.accountId);
    });

    test('an ordinary bank suggestion stays external', () {
      const external = AccountSuggestion(
        bankCode: '035',
        bankName: 'Wema Bank',
        accountName: 'Praiz Onah',
        accountNumber: '1234567890',
      );
      expect(external.isLazervault, isFalse);
      expect(external.internalUserId, isEmpty);
      expect(external.internalAccountId, isEmpty);
      expect(BrandBank.isOurs(external.bankName), isFalse);
    });
  });
}
