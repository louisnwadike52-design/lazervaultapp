import 'package:flutter_test/flutter_test.dart';

import 'package:lazervault/src/features/electricity_bill/domain/entities/bill_payment_entity.dart';
import 'package:lazervault/src/features/electricity_bill/domain/repositories/electricity_bill_repository.dart';
import 'package:lazervault/src/features/electricity_bill/presentation/view/meter_entry_mode.dart';

/// The disco name-lookup does not answer for every meter — some discos are
/// intermittently down, some meters are absent from the vendor directory, and
/// a few return a blank name for an account that pays fine. That was a dead
/// end: a red snackbar and no way past it, for a customer holding a meter
/// card with the number printed on it.
///
/// Manual mode accepts what they know. What it must NOT do is pretend the
/// lookup succeeded: paying the wrong meter is unrecoverable, and the user is
/// the only person who can catch it.
void main() {
  group('manualMeterResult', () {
    test('is explicitly NOT valid', () {
      // The whole point. Downstream code asking "did this verify?" must get
      // no — naming it valid to simplify the screens would be a lie told at
      // the one moment it costs money.
      final r = manualMeterResult(
        meterNumber: '04123456789',
        meterType: MeterType.prepaid,
      );
      expect(r.isValid, isFalse);
      expect(r.customerName, isEmpty);
      expect(r.meterNumber, '04123456789');
      expect(r.meterType, MeterType.prepaid);
    });

    test('carries the meter type the user chose', () {
      final r = manualMeterResult(
        meterNumber: '123',
        meterType: MeterType.postpaid,
      );
      expect(r.meterType, MeterType.postpaid);
    });
  });

  group('meterHolderLabel', () {
    test('shows the verified name when there is one', () {
      const r = MeterValidationResult(
        customerName: 'GRACE C. ONWUANAKU',
        meterNumber: '04123456789',
        meterType: MeterType.prepaid,
        isValid: true,
      );
      expect(meterHolderLabel(r), 'GRACE C. ONWUANAKU');
    });

    test('never renders blank — it says so out loud', () {
      // A blank line reads as a rendering bug and invites the user to tap on
      // past the one field that would have caught a wrong meter number.
      final r = manualMeterResult(
        meterNumber: '04123456789',
        meterType: MeterType.prepaid,
      );
      final label = meterHolderLabel(r);
      expect(label, isNotEmpty);
      expect(label.toLowerCase(), contains('not confirmed'));
    });

    test('a whitespace-only name from the disco is also unconfirmed', () {
      // Some discos answer with a space rather than an error.
      const r = MeterValidationResult(
        customerName: '   ',
        meterNumber: '04123456789',
        meterType: MeterType.prepaid,
        isValid: true,
      );
      expect(meterHolderLabel(r).toLowerCase(), contains('not confirmed'));
    });
  });

  test('MeterEntryMode.isManual', () {
    expect(MeterEntryMode.manual.isManual, isTrue);
    expect(MeterEntryMode.auto.isManual, isFalse);
  });
}
