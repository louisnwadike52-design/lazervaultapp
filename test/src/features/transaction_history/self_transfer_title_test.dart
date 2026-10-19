import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/transaction_history/utils/self_transfer_title.dart';

/// A LAZERBEAM SHOWED THE USER THEIR OWN NAME.
///
/// The history row for a move between a user's own accounts read "Transfer
/// from Praiz Onah" — to Praiz Onah. The generic transfer titling prefers
/// counterparty_name, and on a self-transfer the counterparty is the user, so
/// it overwrote a description that was already correct.
///
/// Measured on prod: both legs carry counterparty_name 'Praiz Onah' and
/// counterparty_user_id equal to the sender's own id, while the description
/// says "Transfer from Personal to Business". 16 rows have that two-sided
/// shape; person-to-person rows are one-sided ("Transfer from Praiz Onah").
void main() {
  group('it recognises a beam by its two-sided description', () {
    test('the prod row, both legs', () {
      const desc = 'Transfer from Personal to Business';
      expect(selfTransferTitle(description: desc, isIncoming: true),
          'Transfer from your Personal',
          reason: 'the credit into Business should say where it came from');
      expect(selfTransferTitle(description: desc, isIncoming: false),
          'Transfer to your Business',
          reason: 'the debit out of Personal should say where it went');
    });

    test('matching is case-insensitive', () {
      expect(
          selfTransferTitle(
              description: 'transfer from Savings to Personal',
              isIncoming: true),
          'Transfer from your Savings');
    });

    test('surrounding whitespace does not defeat it', () {
      expect(
          selfTransferTitle(
              description: '  Transfer from Personal to Business  ',
              isIncoming: false),
          'Transfer to your Business');
    });
  });

  group('it does NOT claim a person-to-person transfer is a beam', () {
    test('the one-sided send-funds narration is left alone', () {
      // This is the row whose title SHOULD be the other person's name.
      expect(
          selfTransferTitle(
              description: 'Transfer from Praiz Onah', isIncoming: true),
          isNull);
      expect(
          selfTransferTitle(
              description: 'Transfer to Emmanuella Nwanne', isIncoming: false),
          isNull);
    });

    test('a custom narration is the user\'s own words and is kept', () {
      expect(
          selfTransferTitle(description: 'Rent money', isIncoming: true),
          isNull);
      expect(
          selfTransferTitle(description: '', isIncoming: true), isNull);
    });

    test('a bill or other description is not mistaken for one', () {
      expect(
          selfTransferTitle(
              description: 'Data purchase - MTN-DATA 07033609489',
              isIncoming: false),
          isNull);
    });
  });

  group('account names that contain the separator', () {
    test('splits on the LAST " to ", not the first', () {
      // "Trip to Ghana" is a legitimate account name. Splitting on the first
      // separator would report the money as coming from "Trip".
      final ends =
          parseSelfTransferDescription('Transfer from Trip to Ghana to Business');
      expect(ends, isNotNull);
      expect(ends!.from, 'Trip to Ghana');
      expect(ends.to, 'Business');
      expect(
          selfTransferTitle(
              description: 'Transfer from Trip to Ghana to Business',
              isIncoming: true),
          'Transfer from your Trip to Ghana');
    });

    test('a destination containing the separator still resolves', () {
      final ends =
          parseSelfTransferDescription('Transfer from Personal to Trip to Ghana');
      expect(ends!.from, 'Personal to Trip');
      expect(ends.to, 'Ghana',
          reason: 'ambiguous by construction — the LAST separator wins, and '
              'the full description remains visible in the subtitle');
    });
  });

  group('malformed input is refused rather than half-parsed', () {
    test('no destination', () {
      expect(parseSelfTransferDescription('Transfer from Personal to '), isNull);
      expect(parseSelfTransferDescription('Transfer from  to Business'), isNull);
    });

    test('prefix only', () {
      expect(parseSelfTransferDescription('Transfer from '), isNull);
      expect(parseSelfTransferDescription('Transfer from'), isNull);
    });
  });
}
