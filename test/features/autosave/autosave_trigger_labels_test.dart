import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/domain/repositories/i_autosave_repository.dart';
import 'package:lazervault/src/features/autosave/utils/autosave_trigger_labels.dart';

AutoSaveCapabilities caps({
  Map<String, String> labels = const {},
  Map<String, String> descriptions = const {},
}) =>
    AutoSaveCapabilities(
      bankInflowEnabled: true,
      minSave: 0,
      feeEnabled: false,
      triggerLabels: labels,
      triggerDescriptions: descriptions,
    );

void main() {
  group('admin-set trigger copy', () {
    // The Dart enum name is camelCase and the server's is snake_case.
    // Conflating them is how an override silently fails to apply.
    test('wireName matches the stored trigger_type', () {
      expect(AutoSaveTriggerLabels.wireName(TriggerType.roundUp), 'round_up');
      expect(AutoSaveTriggerLabels.wireName(TriggerType.onDeposit), 'on_deposit');
      expect(AutoSaveTriggerLabels.wireName(TriggerType.scheduledExternal),
          'scheduled_external');
      expect(AutoSaveTriggerLabels.wireName(TriggerType.externalInflow),
          'external_inflow');
      expect(AutoSaveTriggerLabels.wireName(TriggerType.scheduled), 'scheduled');
      expect(AutoSaveTriggerLabels.wireName(TriggerType.unknown), '');
    });

    test('an admin label wins over the built-in one', () {
      final c = caps(labels: {'round_up': 'Spending Round Up'});
      expect(AutoSaveTriggerLabels.nameFor(TriggerType.roundUp, c),
          'Spending Round Up');
      expect(AutoSaveTriggerLabels.chipLabelFor(TriggerType.roundUp, c),
          'SPENDING ROUND UP');
    });

    test('an admin description wins over the built-in one', () {
      final c = caps(descriptions: {'scheduled': 'Moves money on a timer.'});
      expect(AutoSaveTriggerLabels.descriptionFor(TriggerType.scheduled, c),
          'Moves money on a timer.');
    });

    // The whole safety story: every "I do not know" path must render exactly
    // today's wording.
    test('absent, blank, empty and null all fall back to the built-in copy', () {
      final builtIn = AutoSaveTriggerLabels.nameOf(TriggerType.roundUp);
      expect(AutoSaveTriggerLabels.nameFor(TriggerType.roundUp, null), builtIn);
      expect(AutoSaveTriggerLabels.nameFor(TriggerType.roundUp, caps()), builtIn);
      expect(
          AutoSaveTriggerLabels.nameFor(
              TriggerType.roundUp, caps(labels: {'round_up': '   '})),
          builtIn);
      expect(
          AutoSaveTriggerLabels.nameFor(
              TriggerType.roundUp, caps(labels: {'scheduled': 'Other'})),
          builtIn);
    });

    test('one trigger renamed does not rename another', () {
      final c = caps(labels: {'round_up': 'Spending Round Up'});
      expect(AutoSaveTriggerLabels.nameFor(TriggerType.scheduled, c),
          AutoSaveTriggerLabels.nameOf(TriggerType.scheduled));
    });

    test('an override is trimmed, not shown with its whitespace', () {
      final c = caps(labels: {'on_deposit': '  Payday Save  '});
      expect(AutoSaveTriggerLabels.nameFor(TriggerType.onDeposit, c),
          'Payday Save');
    });

    test('every selectable trigger has a non-empty built-in name', () {
      // A trigger rendering with no name at all would be worse than any
      // wording an admin could set.
      for (final t in AutoSaveTriggerLabels.selectableTriggers(caps())) {
        expect(AutoSaveTriggerLabels.nameFor(t, caps()), isNotEmpty,
            reason: '$t');
        expect(AutoSaveTriggerLabels.wireName(t), isNotEmpty, reason: '$t');
      }
    });
  });
}
