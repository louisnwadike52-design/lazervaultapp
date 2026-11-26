import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/services/saved_recipients_snapshot.dart';
import 'package:lazervault/src/features/recipients/data/datasources/recipient_verification_remote_datasource.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_cubit.dart';

class _UnusedDataSource implements RecipientVerificationRemoteDataSource {
  // The matcher under test is synchronous and network-free; any call reaching
  // here would mean it had stopped being so.
  @override
  dynamic noSuchMethod(Invocation i) =>
      throw StateError('the saved-payee matcher must not touch the network');
}

RecipientModel _payee(String number, String name) => RecipientModel(
      id: 'id-$number',
      name: name,
      accountNumber: number,
      bankName: 'Access Bank',
      sortCode: '044',
      countryCode: 'NG',
      currency: 'NGN',
      type: 'external',
      isFavorite: false,
      isSaved: true,
    );

/// WHY THE DROPDOWN WAS EMPTY, AND IT WAS NOT THE MATCHER.
///
/// Reported: typing an account number that belongs to a saved recipient
/// offered nothing. The matcher itself was correct the whole time — these
/// first tests pin that, so a future change here is not mistaken for the same
/// bug. What was wrong was everything that FILLS the set it searches.
void main() {
  tearDown(SavedRecipientsSnapshot.clear);

  AccountVerificationCubit matcher() => AccountVerificationCubit(
        dataSource: _UnusedDataSource(),
        savedRecipients: () => SavedRecipientsSnapshot.current,
      );

  group('the matcher', () {
    test('offers a saved payee from a partial number', () {
      SavedRecipientsSnapshot.publish([_payee('0123456789', 'Lawrence N')]);
      // Three digits in — the whole point of the feature is that this answers
      // before the 4-6s bank name-enquiry has opened a socket.
      expect(matcher().savedRecipientMatches('012').single.accountName,
          'Lawrence N');
    });

    test('ranks a prefix above a mere contains', () {
      // A number is typed from the LEFT, so a prefix is what the payer is
      // doing; contains is the "I remember the last four digits" case.
      SavedRecipientsSnapshot.publish([
        _payee('9990123456', 'Contains Match'),
        _payee('0123456789', 'Prefix Match'),
      ]);
      final out = matcher().savedRecipientMatches('012');
      expect(out.map((s) => s.accountName).toList(),
          ['Prefix Match', 'Contains Match']);
    });

    test('an empty snapshot is an empty answer, never a throw', () {
      // This is the state the bug left every payer in. It has to degrade to
      // "no suggestions", because the alternative on a money screen is an
      // exception where a convenience was expected.
      expect(matcher().savedRecipientMatches('012'), isEmpty);
    });
  });

  group('what fills the snapshot', () {
    final cubit = File('lib/src/features/recipients/presentation/cubit/'
            'recipient_cubit.dart')
        .readAsStringSync();
    final warmup = File('lib/src/features/recipients/presentation/cubit/'
            'saved_recipients_warmup.dart')
        .readAsStringSync();

    /// Source with comment lines removed. The prose in both files explains
    /// these very bugs and names the things being searched for, so a raw
    /// search would pass on the explanation rather than the code.
    String code(String src) => src
        .split('\n')
        .where((l) => !l.trimLeft().startsWith('//'))
        .where((l) => !l.trimLeft().startsWith('///'))
        .join('\n');

    test('the snapshot is NOT fed from the list page size', () {
      // THE BUG. SavedRecipientsSnapshot is published out of
      // RecipientCubit.onChange, which only ever saw the recipients LIST —
      // paged twenty at a time because that is what a reader scrolls. So a
      // payer with twenty-one saved payees could type the exact account
      // number of the last one and be offered nothing. A page boundary is
      // invisible to the payer, so it reads as the feature being broken.
      final body = code(cubit);
      expect(body.contains('warmSavedRecipientsSnapshot'), isTrue,
          reason: 'the snapshot needs a fetch of its own: the matcher '
              'searches by number, and what a reader scrolls is a '
              'different quantity from what a search has to cover');
      final warm = body.substring(body.indexOf('warmSavedRecipientsSnapshot'));
      final end = warm.indexOf('\n  Future<PaginatedRecipientsResult>');
      final fn = end > 0 ? warm.substring(0, end) : warm;
      expect(fn.contains('FeatureFlags.savedPayeeSnapshotRows'), isTrue,
          reason: 'the page size must be the admin-tunable search bound, not '
              'the list page size and not a literal');
      expect(fn.contains('_pageSize'), isFalse,
          reason: '_pageSize is the LIST page size — reusing it here is '
              'exactly the bug');
      expect(fn.contains('SavedRecipientsSnapshot.publish'), isTrue);
      expect(fn.contains('emit('), isFalse,
          reason: 'emitting would drop hundreds of rows into the list widget '
              'and reset hasMore, currentPage and the scroll position as a '
              'side effect of warming a cache');
    });

    test('a warm-up that could not even try does not burn the one attempt', () {
      // THE OTHER HALF. The flag was set BEFORE the preconditions were
      // checked, so a call from a screen with no RecipientCubit above it
      // (Split Bill and Batch Transfer both warm from the dashboard, where
      // there is none) consumed the single attempt without sending anything.
      // Every later surface then read an empty snapshot for the rest of the
      // session — indistinguishable from the matcher being broken.
      final body = code(warmup);
      final flagAt = body.indexOf('_dispatched = true');
      final readAt = body.indexOf('context.read<RecipientCubit>()');
      expect(flagAt, greaterThan(0));
      expect(readAt, greaterThan(0));
      expect(flagAt, greaterThan(readAt),
          reason: 'the attempt must be claimed only AFTER everything needed '
              'to make it has been obtained — "I could not look" and "there '
              'is nothing to find" are different answers, and only the '
              'second should stop us looking again');
      expect(body.contains('if (!sent) _dispatched = false;'), isTrue,
          reason: 'a fetch that failed outright did not answer the question, '
              'so the next surface must be allowed to ask again rather than '
              'leaving the payer with a dead matcher until they restart');
    });

    test('an empty snapshot heals itself on the keystroke that needs it', () {
      // initState warms one frame after mount, which can be before the
      // session or the cubit is reachable. Typing is the moment the snapshot
      // is actually wanted, so it asks again there — otherwise a single early
      // miss is unrecoverable without restarting the app.
      //
      // DERIVED, NOT LISTED. The surfaces are found by searching the feature
      // tree for the ones that already call the shared warm-up, so a FOURTH
      // account field wired to this matcher fails here without anybody
      // remembering to extend a list — which is exactly how split bill came
      // to have the initState call and not this one.
      final surfaces = Directory('lib/src/features')
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'))
          .where((f) {
        final body = code(f.readAsStringSync());
        return body.contains('ensureSavedRecipientsWarm(context)');
      }).toList();

      expect(surfaces.length, greaterThanOrEqualTo(3),
          reason: 'send funds, batch transfer and split bill all type into '
              'the shared matcher; finding fewer means the search no longer '
              'locates them and this guard is inert');

      for (final f in surfaces) {
        final body = code(f.readAsStringSync());
        expect(
          body.contains('if (saved.isEmpty) ensureSavedRecipientsWarm(context);'),
          isTrue,
          reason: '${f.path} warms the saved-payee snapshot on mount but not '
              'on the keystroke. The mount warm-up can run before the session '
              'or the recipient cubit is reachable, and a single early miss '
              'then leaves the matcher dead for the whole session with no way '
              'back short of restarting the app.',
        );
      }
    });
  });
}
