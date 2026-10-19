import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';

/// "RESUME" ON A GOAL THAT WAS ALREADY MET.
///
/// The details screen chose its CTA with `rule.isActive ? Pause : Resume`, so
/// a rule that had reached its target — status `completed`, nothing left to
/// save — offered to resume. A cancelled rule did the same. Neither can be,
/// and the server refuses, so the button was a dead end.
///
/// And the snackbar: "Couldn't save" titled above "Auto-save triggered
/// successfully". The error fallback printed whatever the backend said, and
/// what it said was the server's constant success message, because the app's
/// proto copy of this response declares different field numbers from the
/// contract the server implements.

AutoSaveRuleEntity rule(AutoSaveStatus status) => AutoSaveRuleEntity(
      id: 'r1',
      userId: 'u1',
      name: 'On wallet deposit',
      description: '',
      triggerType: TriggerType.onDeposit,
      amountType: AmountType.fixed,
      amountValue: 100,
      sourceAccountId: 'a1',
      destinationAccountId: 'a2',
      status: status,
      createdAt: DateTime(2026, 10, 1),
      updatedAt: DateTime(2026, 10, 19),
      triggerCount: 3,
      totalSaved: 300,
    );

void main() {
  group('which rules can be resumed', () {
    test('only a paused one', () {
      expect(rule(AutoSaveStatus.paused).canResume, isTrue);
      expect(rule(AutoSaveStatus.active).canResume, isFalse);
      expect(rule(AutoSaveStatus.completed).canResume, isFalse,
          reason: 'it met its target; there is nothing to resume');
      expect(rule(AutoSaveStatus.cancelled).canResume, isFalse);
    });

    test('completed and cancelled are finished, active and paused are not', () {
      expect(rule(AutoSaveStatus.completed).isFinished, isTrue);
      expect(rule(AutoSaveStatus.cancelled).isFinished, isTrue);
      expect(rule(AutoSaveStatus.active).isFinished, isFalse);
      expect(rule(AutoSaveStatus.paused).isFinished, isFalse);
    });
  });

  group('the details screen', () {
    final src = File(
      'lib/src/features/autosave/presentation/views/'
      'autosave_rule_details_screen.dart',
    ).readAsLinesSync().where((l) {
      final t = l.trimLeft();
      return !t.startsWith('//') && !t.startsWith('///');
    }).join('\n');

    test('hides pause/resume entirely on a finished rule', () {
      expect(src, contains('rule.isFinished'));
      expect(src, contains('if (pauseResume != null)'),
          reason: 'the row must cope with the button being absent');
    });

    test('calls the destructive action what it does', () {
      expect(src, contains("rule.isFinished ? 'Remove' : 'Cancel rule'"));
      expect(src, isNot(contains("label: 'Delete'")),
          reason: '"Delete" reads as erasing the saves, which it does not');
    });

    test('never prints backend text as the error fallback', () {
      expect(src, isNot(contains("_FriendlyError('Couldn\\'t save', raw)")),
          reason: 'that is what showed "Couldn\'t save / triggered successfully"');
      // The source escapes the apostrophe inside its single-quoted string.
      expect(src, contains(r"We couldn\'t complete that save"));
      expect(src, contains('Nothing has left your account'));
    });

    test('refreshes after a save, and on pull', () {
      expect(src, contains('void _refreshRule()'));
      expect(src, contains('_refreshRule();'));
      expect(src, contains('RefreshIndicator('));
      expect(src, contains('onRefresh: _onPullToRefresh'));
      expect(src, contains('AlwaysScrollableScrollPhysics'),
          reason: 'a short page must still be pullable');
    });

    test('the success line describes the money, not our RPC', () {
      expect(src, isNot(contains('Manual save triggered successfully')));
      expect(src, contains('moved into this goal'));
    });
  });

  test('an accepted save carries no invented id', () {
    // The reply cannot be read for the transaction while the proto copy is
    // adrift, so the repository records "accepted" and lets the refresh fill
    // in the figures. A made-up id would produce a receipt that resolves to
    // nothing.
    final src = File(
      'lib/src/features/autosave/data/models/autosave_rule_model.dart',
    ).readAsStringSync();
    expect(src, contains('factory AutoSaveTransactionModel.accepted('));
    expect(src, contains("id: '',"));
  });
}
