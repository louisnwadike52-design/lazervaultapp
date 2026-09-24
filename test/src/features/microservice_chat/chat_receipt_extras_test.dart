import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_receipt_extras.dart';

/// A chat receipt is the artefact people screenshot and send to each other, and
/// it was rendering the backend's internal plumbing.
///
/// The cards looped over `extra` and title-cased each key, so a transfer receipt
/// carried a "Source Account Id" row with a raw UUID in it, a "Recipient Image
/// Url", a "Recipient Bank Code", and a second fee in kobo ("Fee Minor: 510")
/// next to the formatted one.
///
/// It also could not answer the question the user asked for: which of MY accounts
/// did this money leave. source_account_id was present but unreadable, so the
/// backend now sends source_account_label and it leads the rows as "From".

/// A real transfer payload's extras, as chat-transfers-service builds them.
Map<String, dynamic> realExtras() => {
      'source_account_id': '3fa85f64-5717-4562-b3fc-2c963f66afa6',
      'source_account_label': 'Main · ••••3493',
      'recipient_display_name': 'Chris Nnaemeka',
      'recipient_username': 'chris',
      'recipient_account_number': 'NG202613493',
      'recipient_bank_name': 'Lazervault',
      'recipient_bank_code': '000014',
      'recipient_image_url': 'https://cdn.example/avatar.png',
      'narration': 'Lunch',
      'transfer_type': 'domestic',
      'fee_minor': 510,
      'fee_display': '₦5.10',
      'new_balance_minor': 184400,
      'new_balance_display': '₦1,844.00',
    };

void main() {
  group('the From row', () {
    test('leads the rows, because it is what the receipt could not answer', () {
      final rows = chatReceiptExtraRows(realExtras());
      expect(rows.first.key, 'From');
      expect(rows.first.value, 'Main · ••••3493');
    });
  });

  group('internal plumbing never reaches the receipt', () {
    test('the source account UUID is hidden', () {
      final rows = chatReceiptExtraRows(realExtras());
      expect(rows.any((r) => r.value.contains('3fa85f64')), isFalse,
          reason:
              'a UUID on a receipt tells the reader nothing and looks broken');
      expect(rows.any((r) => r.key == 'Source Account Id'), isFalse);
    });

    test('the avatar URL is hidden — the card draws it, it is not a row', () {
      final rows = chatReceiptExtraRows(realExtras());
      expect(rows.any((r) => r.value.startsWith('https://')), isFalse);
    });

    test('kobo duplicates are hidden so the fee appears once', () {
      final rows = chatReceiptExtraRows(realExtras());
      final fees = rows.where((r) => r.key.toLowerCase().contains('fee'));
      expect(fees.length, 1);
      expect(fees.first.value, '₦5.10',
          reason: 'the formatted value, not the 510 in kobo beside it');
    });

    test('the bank code is hidden but the bank name is not', () {
      final rows = chatReceiptExtraRows(realExtras());
      expect(rows.any((r) => r.value == '000014'), isFalse);
      expect(rows.any((r) => r.value == 'Lazervault'), isTrue);
    });

    test('routing hints are hidden', () {
      final rows = chatReceiptExtraRows(realExtras());
      expect(rows.any((r) => r.value == 'domestic'), isFalse);
    });
  });

  group('labels are readable', () {
    test('known keys get real names, not title-cased identifiers', () {
      final rows = chatReceiptExtraRows(realExtras());
      final labels = rows.map((r) => r.key).toList();
      expect(labels, contains('From'));
      expect(labels, contains('To'));
      expect(labels, contains('Account number'));
      expect(labels, contains('Note'));
      expect(labels, contains('Balance after'));
      // The raw shapes must be gone.
      expect(labels, isNot(contains('Source Account Label')));
      expect(labels, isNot(contains('Recipient Display Name')));
      expect(labels, isNot(contains('New Balance Display')));
    });

    test('an unknown key still shows, title-cased', () {
      // A field a newer backend adds must appear rather than be dropped by a UI
      // that has not heard of it.
      final rows = chatReceiptExtraRows({'settlement_window': '2 hours'});
      expect(rows.single.key, 'Settlement Window');
      expect(rows.single.value, '2 hours');
    });
  });

  group('malformed input degrades quietly', () {
    test('a non-map is no rows, not a crash', () {
      expect(chatReceiptExtraRows(null), isEmpty);
      expect(chatReceiptExtraRows('nope'), isEmpty);
      expect(chatReceiptExtraRows(<String>['a']), isEmpty);
    });

    test('nested values are skipped rather than stringified', () {
      // A Map's toString on a receipt row is unreadable noise.
      final rows = chatReceiptExtraRows({
        'narration': 'Lunch',
        'nested': {'a': 1},
        'list': [1, 2],
      });
      expect(rows.length, 1);
      expect(rows.single.key, 'Note');
    });

    test('empty and whitespace values are dropped', () {
      final rows = chatReceiptExtraRows({
        'narration': '   ',
        'category': '',
        'recipient_username': 'chris',
      });
      expect(rows.length, 1);
      expect(rows.single.value, 'chris');
    });
  });
}
