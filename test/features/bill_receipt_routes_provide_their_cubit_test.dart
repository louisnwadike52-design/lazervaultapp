import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Every bill receipt that re-reads its status must be registered on a route
/// that PROVIDES the cubit it reads from.
///
/// The data receipt was not, and nothing noticed for as long as it shipped.
/// GetX gives each route its own subtree, so the BlocProvider on the
/// processing screen is not an ancestor of the receipt that follows it;
/// `context.read<DataBundlesCubit>()` therefore threw
/// ProviderNotFoundException on every refresh. Both callers swallow it — the
/// BillStatusAutoRefresh poll catches everything by design, and a throw out of
/// RefreshIndicator.onRefresh just retracts the spinner — so a purchase that
/// completed six seconds after it was requested showed "Processing" for ever
/// while the push notification correctly said it had succeeded.
///
/// Asserted against the ROUTER SOURCE rather than by pumping the widget,
/// because the defect is a missing wrapper in a 5,000-line route table: the
/// thing to check is that the registration has it, not that one screen happens
/// to render.
void main() {
  late String router;

  setUpAll(() {
    router = File('lib/src/features/presentation/app_router.dart')
        .readAsStringSync();
  });

  /// Screens that call context.read<SomeCubit>() from their refresh path,
  /// paired with the route constant that registers them.
  const needsProvider = <String, String>{
    'DataPaymentReceiptScreen': 'AppRoutes.dataBundlesPaymentReceipt',
    'PaymentReceiptScreen': 'AppRoutes.electricityBillReceipt',
    'AirtimePaymentConfirmationScreen': 'AppRoutes.airtimePaymentConfirmation',
  };

  for (final entry in needsProvider.entries) {
    final screen = entry.key;
    final route = entry.value;

    test('$route wraps $screen in a BlocProvider', () {
      final at = router.indexOf('name: $route,');
      expect(at, isNot(-1),
          reason: '$route is no longer registered under that name — if the '
              'route was renamed, rename it here too rather than deleting '
              'this case.');

      // The GetPage literal: from this name up to the next one.
      final nextPage = router.indexOf('GetPage(', at);
      final end = nextPage == -1 ? router.length : nextPage;
      // Comments stripped first. The fix for the data route carries a long
      // explanatory comment that names BlocProvider several times, and a bare
      // substring check passed on a route whose provider had been deleted —
      // it was matching the prose about the bug instead of the code. Verified
      // by removing the wrapper and watching this fail.
      final page = router
          .substring(at, end)
          .split('\n')
          .where((l) => !l.trimLeft().startsWith('//'))
          .join('\n');

      expect(page, contains(screen),
          reason: '$route no longer points at $screen.');
      expect(
        page,
        contains('BlocProvider'),
        reason: '$screen re-reads its status through context.read<...Cubit>(), '
            'and GetX gives this route its own subtree — without a '
            'BlocProvider here that read throws ProviderNotFoundException on '
            'every pull-to-refresh and every auto-refresh poll, and the '
            'receipt is frozen on whatever status it opened with.',
      );
    });
  }
}
