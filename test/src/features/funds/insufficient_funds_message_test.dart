import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

/// Two defects in the send-funds pre-flight, both on the insufficient-funds path.
///
/// 1. `NumberFormat('#,###.00')` has no zero in the integer part, so any value
///    below 1 renders with NO leading digit: ₦0.50 became "₦.50" and zero became
///    "₦.00". This file was the only place in the app using that pattern — 93 other
///    call sites already use '#,##0.00' — and the message it corrupts is the one
///    shown when the balance is LOW, which is exactly when sub-₦1 figures appear.
///
/// 2. The message itself, in the fee variant, names four figures and explains the
///    arithmetic between them. It was delivered as five seconds of translucent red
///    over the bottom of the form.
void main() {
  group('the money format keeps its leading zero', () {
    test('values below one are not rendered as a bare decimal', () {
      // The reported shape of the bug.
      expect(NumberFormat('#,###.00').format(0.5), '.50');
      // The fix.
      expect(NumberFormat('#,##0.00').format(0.5), '0.50');
      expect(NumberFormat('#,##0.00').format(0.05), '0.05');
      expect(NumberFormat('#,##0.00').format(0), '0.00');
    });

    test('larger values are unaffected, so nothing else changes', () {
      for (final v in <double>[1.5, 12.0, 1844.0, 1234567.89]) {
        expect(
          NumberFormat('#,##0.00').format(v),
          NumberFormat('#,###.00').format(v),
          reason: '$v must render identically before and after the fix',
        );
      }
    });
  });

  group('the send-funds screen', () {
    late String source;

    setUpAll(() {
      final file = File(
        'lib/src/features/funds/presentation/widgets/send_funds/'
        'initiate_send_funds.dart',
      );
      expect(file.existsSync(), isTrue,
          reason: 'initiate_send_funds.dart moved — update this test');
      source = file.readAsStringSync();
    });

    test('no longer uses the pattern that drops the zero', () {
      expect(source, isNot(contains("NumberFormat('#,###.00')")));
      expect(source, contains("NumberFormat('#,##0.00')"));
    });

    test('insufficient funds is a sheet, not a five-second flash', () {
      expect(source, contains("title: 'Insufficient funds'"));
      final idx = source.indexOf("title: 'Insufficient funds'");
      final call = source.substring(idx - 200, idx + 400);
      expect(call, contains('showServerRefusal'));
      // "Top up your account" is an instruction with somewhere to go.
      expect(call, contains('AppRoutes.depositFunds'));
      // And it must say the money did not move — this check runs BEFORE any
      // debit, so unlike a mid-flight failure it can state that truthfully.
      expect(call, contains('Nothing has been sent.'));
    });

    test('a failed recipient save is reported, not printed', () {
      // The user ticked a box asking for it. print() is invisible in release, so
      // the recipient was simply absent next time with nothing said.
      expect(source, isNot(contains('Warning: Failed to save recipient')));
      expect(source, contains("Couldn't save \$savedName to your recipients"));
      // Worded transfer-first, so a failed bookmark cannot read as a failed
      // payment.
      expect(source, contains("'Transfer sent',"));
    });

    test('the post-save callback guards the async gap', () {
      // It assigns to a field and reads a cubit off the BuildContext after an
      // await, and on the normal path the transfer has already navigated away.
      final idx = source.indexOf('(saved) {');
      expect(idx, greaterThan(-1));
      expect(
          source.substring(idx, idx + 400), contains('if (!mounted) return;'));
    });

    test('the fire-and-forget save says so', () {
      // It was assigned to a Future field that nothing ever read, which looked
      // like it was being awaited somewhere.
      expect(source, isNot(contains('_pendingRecipientSave')));
      expect(source, contains('unawaited(addRecipientUseCase('));
    });
  });
}
