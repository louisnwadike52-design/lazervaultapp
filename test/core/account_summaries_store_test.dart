import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/services/account_summaries_store.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';

AccountSummaryEntity _row(String id) =>
    AccountSummaryEntity(
      id: id,
      accountType: 'personal',
      currency: 'NGN',
      balance: 1000,
      availableBalance: 1000,
      accountNumberLast4: '6014',
      trendPercentage: 0,
    );

void main() {
  setUp(AccountSummariesStore.clear);

  group('AccountSummariesStore', () {
    test('an empty publish never blanks rows another instance loaded', () {
      AccountSummariesStore.publish([_row('a')], userId: 'u1');
      AccountSummariesStore.publish(const [], userId: 'u1');
      expect(AccountSummariesStore.rows().length, 1,
          reason: 'a cubit emitting its initial/loading state must not erase '
              'summaries a different instance already has');
    });

    test('rows are withheld from a different user', () {
      AccountSummariesStore.publish([_row('a')], userId: 'chris');
      expect(AccountSummariesStore.rows(forUserId: 'chris').length, 1);
      expect(AccountSummariesStore.rows(forUserId: 'ella'), isEmpty,
          reason: 'two people sharing one phone must never be offered each '
              "other's wallets as a funding source");
    });

    test('clear drops rows and the owner', () {
      AccountSummariesStore.publish([_row('a')], userId: 'u1');
      AccountSummariesStore.clear();
      expect(AccountSummariesStore.rows(), isEmpty);
      expect(AccountSummariesStore.userId, isNull);
      // A cleared store must not keep answering for the previous user.
      expect(AccountSummariesStore.rows(forUserId: 'u1'), isEmpty);
    });

    test('revision moves on publish and on a clear that changes something', () {
      final before = AccountSummariesStore.revision.value;
      AccountSummariesStore.publish([_row('a')], userId: 'u1');
      expect(AccountSummariesStore.revision.value, greaterThan(before));
      final afterPublish = AccountSummariesStore.revision.value;
      AccountSummariesStore.clear();
      expect(AccountSummariesStore.revision.value, greaterThan(afterPublish));
      // A no-op clear must not churn every listening sheet.
      final afterClear = AccountSummariesStore.revision.value;
      AccountSummariesStore.clear();
      expect(AccountSummariesStore.revision.value, afterClear);
    });
  });

  // ── the regression guard ────────────────────────────────────────────────
  //
  // "No account selected" on Lazerspray's Fund Wallet sheet survived several
  // rounds of fixes because every fix resolved against
  // `serviceLocator<AccountCardsSummaryCubit>().state`. That registration is
  // `registerFactory`: the locator CONSTRUCTS a cubit on each call, so the
  // state read was always `AccountCardsSummaryInitial` and the account list
  // always empty — while the dashboard, holding a different instance, showed
  // the account perfectly well.
  //
  // Nothing about that is visible at the call site, which is why it has to be
  // pinned by a test rather than a comment.
  group('the account-resolution helpers never read a locator-made cubit', () {
    test('active_account_snapshot resolves from the shared store', () {
      final src =
          File('lib/core/services/active_account_snapshot.dart').readAsStringSync();
      expect(src.contains('AccountSummariesStore.rows'), isTrue,
          reason: 'the resolver must read the shared store');
      expect(
        RegExp(r'serviceLocator<AccountCardsSummaryCubit>\(\)\s*\.?\s*state')
            .hasMatch(src),
        isFalse,
        reason: 'AccountCardsSummaryCubit is a FACTORY registration — reading '
            '.state off a locator-made instance always yields the initial '
            'state, which is the "No account selected" bug',
      );
    });

    test('AccountCardsSummaryCubit is still a factory', () {
      // If someone switches it to a singleton, the store is no longer load
      // bearing — but a singleton is unsafe here, because ~20 routes provide
      // it with `BlocProvider(create: ...)`, which CLOSES the cubit it was
      // given when the route pops. This test exists so that change is made
      // deliberately rather than by accident.
      final di = File('lib/core/services/injection_container.dart')
          .readAsStringSync();
      expect(di.contains('registerFactory<AccountCardsSummaryCubit>'), isTrue,
          reason: 'if this moved to a singleton, re-check every '
              'BlocProvider(create: ...) that would close it on pop');
    });

    test('nothing else reads the cubit state through the locator', () {
      final offenders = <String>[];
      for (final f in Directory('lib')
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'))) {
        final src = f.readAsStringSync();
        if (RegExp(r'(serviceLocator|GetIt\.I)<AccountCardsSummaryCubit>\(\)\s*\.state')
            .hasMatch(src)) {
          offenders.add(f.path);
        }
        // Binding a BlocBuilder/BlocListener to a locator-made instance is the
        // same bug with a rebuild-time cubit leak on top.
        if (RegExp(r'bloc:\s*(serviceLocator|GetIt\.I)<AccountCardsSummaryCubit>\(\)')
            .hasMatch(src)) {
          offenders.add('${f.path} (bloc: binding)');
        }
      }
      expect(offenders, isEmpty,
          reason: 'these read a freshly-constructed cubit that has never '
              'loaded; use activeAccountSnapshot()/accountSummaryById() or '
              'AccountSummariesStore.revision instead');
    });
  });
}
