import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/utils/autosave_trigger_labels.dart';
import 'package:lazervault/src/features/widgets/receipt_metadata_humanizer.dart';

/// Reported: an AutoSave receipt in the dashboard's transaction history said
/// only "Trigger · Scheduled". That tells the user nothing they did not
/// already know from the word AutoSave, and it does not distinguish the two
/// cases that actually matter to them — money moved INSIDE Lazervault, or
/// money PULLED FROM A LINKED BANK, which carries a bank-debit fee and can
/// fail at the bank.
///
/// The app already owns one canonical vocabulary for these. The receipt — the
/// document a user keeps — was the one surface still printing the raw wire
/// value.
void main() {
  HumanizedReceiptEntry? humanize(String key, String value) =>
      humanizeReceiptMetadataEntry(key, value, formatKey: (k) => k);

  group('the receipt names the trigger', () {
    test('the reported case: scheduled is no longer just "Scheduled"', () {
      final e = humanize('trigger', 'scheduled');
      expect(e, isNotNull);
      expect(e!.label, 'Trigger');
      expect(e.value, 'Scheduled from Wallet');
    });

    test('a linked-bank pull is named as one', () {
      // The distinction the user asked for: is this my bank or my wallet?
      expect(humanize('trigger', 'scheduled_external')!.value,
          'Recurring Bank Debit');
      expect(humanize('trigger', 'external_inflow')!.value, 'Bank Inflow');
    });

    test('every wire value the server can send is covered', () {
      for (final t in TriggerType.values) {
        final wire = AutoSaveTriggerLabels.wireName(t);
        if (wire.isEmpty) continue; // unknown has no wire form
        expect(humanize('trigger', wire), isNotNull,
            reason: 'no receipt wording for "$wire"');
      }
    });

    // The local table in the humanizer exists so the receipt layer does not
    // import the autosave feature. That is only safe while the two agree —
    // this is what makes a rename over there fail over here.
    test('the wording matches the vocabulary the rest of the app uses', () {
      for (final t in TriggerType.values) {
        final wire = AutoSaveTriggerLabels.wireName(t);
        if (wire.isEmpty) continue;
        expect(humanize('trigger', wire)!.value,
            AutoSaveTriggerLabels.nameOf(t),
            reason: 'receipt and app disagree about "$wire"');
      }
    });

    test('the key is matched however the backend spells it', () {
      for (final k in ['trigger', 'trigger_type', 'autosave_trigger']) {
        expect(humanize(k, 'on_deposit')!.value, 'On Wallet Deposit',
            reason: k);
      }
    });
  });

  group('it degrades rather than hiding information', () {
    test('a trigger the app does not know yet still prints', () {
      // A server can ship a new trigger before the app does. Falling through
      // to the ordinary formatting shows something; returning null would show
      // nothing at all.
      final e = humanize('trigger', 'some_new_rail');
      expect(e, isNotNull);
      expect(e!.value, 'some_new_rail');
    });

    test('an unrelated key is untouched', () {
      expect(humanize('rule', 'December Hair')!.value, 'December Hair');
    });
  });
}
