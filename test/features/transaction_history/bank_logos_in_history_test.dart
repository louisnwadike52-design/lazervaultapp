import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// ONE ROW SHOWED A REAL BANK MARK, THE NEXT SHOWED TWO LETTERS.
///
/// Reported with a screenshot of general transaction history: a Zenith
/// transfer rendered the Zenith logo, the transfer under it fell back to
/// initials.
///
/// The row asks BankLogoLookup for the recipient bank's logo, and that index
/// is filled by the BANK LIST — which only loads when somebody opens a bank
/// picker. Open history without having started a transfer this session and
/// the index is empty, so only the handful of banks with a BUNDLED asset
/// (~38, Zenith among them) resolve; the ~280 that exist only as a
/// backend-served URL all fall through to initials.
///
/// Nothing was wrong with the lookup or the widget. The index simply had not
/// been told anything yet.
void main() {
  for (final screen in const [
    'dashboard_transaction_history_screen.dart',
    'service_transaction_history_screen.dart',
  ]) {
    group(screen, () {
      final src = File(
        'lib/src/features/transaction_history/presentation/screens/$screen',
      ).readAsLinesSync().where((l) {
        final t = l.trimLeft();
        return !t.startsWith('//') && !t.startsWith('///');
      }).join('\n');

      test('warms the bank-logo index when it opens', () {
        expect(src, contains("warmUp('NG')"));
      });

      test('warms it in initState, before the rows paint', () {
        final init = src.indexOf('void initState()');
        final warm = src.indexOf("warmUp('NG')");
        expect(init, greaterThan(0));
        expect(warm, greaterThan(init));
      });

      test('does not block the screen on it', () {
        // warmUp serves the cache and returns a future nobody awaits; the
        // lookup's revision notifier repaints the logos when it lands.
        expect(src, isNot(contains("await serviceLocator<BankRepository>()")));
      });
    });
  }

  group('the pieces that made warming sufficient', () {
    test('BankLogo repaints when the index changes', () {
      final widget =
          File('lib/core/widgets/bank_logo.dart').readAsStringSync();
      expect(widget, contains('ValueListenableBuilder<int>'));
      expect(widget, contains('BankLogoLookup.revision'));
    });

    test('the history row asks for a bank logo at all', () {
      final card = File(
        'lib/src/features/transaction_history/presentation/widgets/'
        'transaction_card.dart',
      ).readAsStringSync();
      expect(card, contains('BankLogo('));
      expect(card, contains("md?['bank_name']"));
      // Code is second, never first: codes are per-rail (Kuda is 50211 on
      // Flutterwave and 090267 on Nomba), so a code-keyed logo would vanish
      // the day the payout provider changed.
      expect(card, contains('bankCode: bankCode'));
    });
  });
}
