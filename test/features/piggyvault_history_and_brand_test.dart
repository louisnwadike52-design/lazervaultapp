import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// A Piggyvault withdrawal landed in the account and was invisible in the
/// transaction history.
///
/// accounts-service books three categories for Piggyvault — `lock_funds`
/// (money in), `lock_funds_autosave` (the plan's own recurring debit) and
/// `unlock_funds` (the payout, the single largest credit a plan ever makes).
/// None was classified, so the row fell through the classifier's fallback with
/// no name, no icon and no service filter. Measured on prod: a ₦7,232.42
/// `unlock_funds` credit, completed, that the user could not find.
///
/// `unlock_funds` is also the one row whose `service_name` is EMPTY, so the
/// service_name rules cannot reach it — the category is the only thing that
/// identifies it.
void main() {
  const classifier =
      'lib/src/features/transaction_history/data/repository/transaction_classifier.dart';

  String code(String p) => File(p)
      .readAsStringSync()
      .split('\n')
      .where((l) =>
          !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
      .join('\n');

  group('a Piggyvault row is recognised', () {
    final src = code(classifier);

    test('all three categories are classified', () {
      for (final cat in ['unlock_funds', 'lock_funds', 'lock_funds_autosave']) {
        expect(src, contains("cat == '$cat'"),
            reason: '$cat falls through to the generic fallback, which is why '
                'a withdrawal cannot be found in the history');
      }
    });

    test('the category check runs BEFORE the service_name rules', () {
      // unlock_funds carries an EMPTY service_name, so a service_name rule
      // could never reach it.
      final catIdx = src.indexOf("cat == 'unlock_funds'");
      final svcIdx = src.indexOf("svc.contains('giftcard')");
      expect(catIdx, greaterThan(-1));
      expect(svcIdx, greaterThan(-1));
      expect(catIdx, lessThan(svcIdx),
          reason: 'the only thing identifying an unlock is its category');
    });

    test('each has a title', () {
      for (final cat in ['unlock_funds', 'lock_funds', 'lock_funds_autosave']) {
        expect(src, contains("case '$cat':"),
            reason: '$cat has no title, so the row renders unnamed');
      }
    });

    test('they map to lockFunds, NOT autosave', () {
      // Piggyvault's recurring debit and the AutoSave product move money to
      // different places — AutoSave to the savings account, Piggyvault into a
      // locked plan. Filing both under one filter is how somebody concludes
      // their AutoSave is taking money they cannot see.
      final i = src.indexOf("case 'lock_funds_autosave':\n      return TransactionServiceType");
      final window = i >= 0
          ? src.substring(i, (i + 200).clamp(0, src.length))
          : src.substring(src.indexOf("case 'unlock_funds':\n    case 'lock_funds':"));
      expect(window, contains('TransactionServiceType.lockFunds'));
      expect(window, isNot(contains('TransactionServiceType.autosave')),
          reason: 'Piggyvault is not AutoSave');
    });

    test('the auto-save title names Piggyvault', () {
      expect(src, contains("'Piggyvault Auto-save'"),
          reason: 'calling it "AutoSave" in the history is the exact '
              'confusion that was reported');
    });
  });

  group('the brand is not PascalCase', () {
    test('no user-facing string says PiggyVault', () {
      final offenders = <String>[];
      final dir = Directory('lib');
      for (final f in dir.listSync(recursive: true).whereType<File>()) {
        if (!f.path.endsWith('.dart')) continue;
        if (f.path.contains('/generated/')) continue;
        final lines = f.readAsStringSync().split('\n');
        for (var i = 0; i < lines.length; i++) {
          final l = lines[i];
          final t = l.trimLeft();
          // Comments may still spell it however the author did; this is about
          // what a user reads.
          if (t.startsWith('//') || t.startsWith('*')) continue;
          if (RegExp("['\"][^'\"]*PiggyVault").hasMatch(l)) {
            offenders.add('${f.path}:${i + 1}');
          }
        }
      }
      expect(offenders, isEmpty,
          reason: 'the brand is "Piggyvault". Offenders: ${offenders.join(', ')}');
    });
  });
}
