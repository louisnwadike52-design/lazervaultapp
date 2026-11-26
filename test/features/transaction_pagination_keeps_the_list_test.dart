import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_state.dart';

/// APPENDING A PAGE MUST NOT TAKE THE LIST DOWN WITH IT.
///
/// Reported as "transaction history isn't paginating to show more items". The
/// trigger was present and the request was made; four separate things stopped
/// the rows ever reaching the screen, and none of them produced an error.
/// Each has a test here because each alone limits the list to one page.
void main() {
  /// Source with comment lines removed.
  ///
  /// Every file these tests read explains the bug it guards, in prose that
  /// names the very identifiers being searched for. Without this, a check
  /// that an identifier is ABSENT matches the sentence saying why it must be.
  String code(String s) => s
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .where((l) => !l.trimLeft().startsWith('///'))
      .join('\n');

  UnifiedTransaction tx(String id) => UnifiedTransaction(
        id: id,
        serviceType: TransactionServiceType.transfer,
        title: 'Row $id',
        amount: 100,
        currency: 'NGN',
        createdAt: DateTime(2026, 11, 20),
        status: UnifiedTransactionStatus.completed,
        flow: TransactionFlow.outgoing,
      );

  group('the Loaded state', () {
    test('can say "a page is in flight" WITHOUT ceasing to be Loaded', () {
      // THE BUG. loadMore emitted TransactionHistoryLoading, which every
      // screen renders as a full-page skeleton: the ListView was destroyed
      // mid-scroll, the offset reset to the top, and because the scroll
      // listeners only fire while the state is Loaded, nothing could ask for
      // page three. One page was all anybody could reach.
      const loaded = TransactionHistoryLoaded(
        transactions: [],
        hasMore: true,
        currentPage: 1,
        totalPages: 3,
      );
      final appending = loaded.copyWith(isLoadingMore: true);
      expect(appending, isA<TransactionHistoryLoaded>(),
          reason: 'it must stay Loaded, or the list unmounts and the '
              'listener that would fetch page three stops running');
      expect(appending.isLoadingMore, isTrue);
      expect(loaded.isLoadingMore, isFalse, reason: 'not appending by default');
    });

    test('an arrived page clears the flag without the caller saying so', () {
      // Every pre-existing copyWith call site is a page that has ARRIVED, so
      // the spinner has to clear itself; carrying it forward would leave a
      // footer spinning under a list that is complete.
      final appending = const TransactionHistoryLoaded(
        transactions: [],
        hasMore: true,
        currentPage: 1,
        totalPages: 3,
      ).copyWith(isLoadingMore: true);
      expect(appending.copyWith(currentPage: 2).isLoadingMore, isFalse);
    });

    test('the flag is part of equality, so the emit is not deduped', () {
      const a = TransactionHistoryLoaded(
          transactions: [], hasMore: true, currentPage: 1, totalPages: 3);
      expect(a.copyWith(isLoadingMore: true) == a, isFalse,
          reason: 'bloc drops an emit that compares equal — if the flag were '
              'outside props, the footer spinner would never appear');
    });
  });

  group('the cubit', () {
    final src = File('lib/src/features/transaction_history/presentation/'
            'cubit/transaction_history_cubit.dart')
        .readAsStringSync();
    final body = code(src);

    /// JUST loadMoreTransactions. The rest of the cubit emits
    /// TransactionHistoryLoading and TransactionHistoryError perfectly
    /// correctly, so a file-wide search would pass on the initial loaders and
    /// prove nothing about the append.
    ///
    /// The end anchor is a DECLARATION, not a doc comment: `code()` strips
    /// comment lines, so an anchor inside one is not there to be found. And
    /// it FAILS rather than falling back to the whole file — a source-scoped
    /// test that quietly widens its scope stops testing what it claims to.
    String loadMoreBody() {
      final from = body.indexOf('Future<void> loadMoreTransactions()');
      expect(from, greaterThan(0), reason: 'loadMoreTransactions is gone');
      final rest = body.substring(from);
      final to = rest.indexOf('String? _lastLoadMoreError;');
      expect(to, greaterThan(0),
          reason: 'the anchor bounding the function under test is gone, so '
              'this group would silently widen to the whole cubit');
      return rest.substring(0, to);
    }

    test('loadMore never emits a page-level loading state', () {
      final fn = loadMoreBody();
      expect(fn.contains('TransactionHistoryLoading'), isFalse,
          reason: 'that state is rendered as a full-page skeleton, which '
              'destroys the list being appended to');
      expect(fn.contains('isLoadingMore: true'), isTrue);
    });

    test('loadMore hands over a NEW list, never the mutated one', () {
      final fn = loadMoreBody();
      // Equatable deep-compares props. _cachedTransactions WAS the
      // repository's own list; addAll mutated it in place and the same
      // instance went into the new state, so whenever hasMore/currentPage/
      // totalPages also stayed put — which is exactly what cursor pagination
      // does — the state compared EQUAL and bloc dropped the emit. The rows
      // were fetched, appended, and never rendered.
      expect(fn.contains('_cachedTransactions.addAll'), isFalse,
          reason: 'mutating in place reads as "nothing changed", and it also '
              "writes into the repository's cache");
      expect(fn.contains('_appended(_cachedTransactions'), isTrue);
    });

    test('a failed page keeps the rows already read', () {
      final fn = loadMoreBody();
      expect(fn.contains('TransactionHistoryError'), isFalse,
          reason: 'replacing a good list with an error screen because page '
              'four timed out loses the reader’s place and everything they '
              'were looking at');
      expect(fn.contains('isLoadingMore: false'), isTrue,
          reason: 'and the flag must clear, or no further attempt is possible');
    });

    test('the failure message is set BEFORE the emit it is read on', () {
      final fn = loadMoreBody();
      // lastLoadMoreError is a plain field, not state, so the footer reads it
      // during the rebuild the emit causes. Assigning afterwards meant the
      // first failure rendered with no message at all.
      final at = fn.indexOf('_lastLoadMoreError = e.toString()');
      final emitAt = fn.indexOf('copyWith(isLoadingMore: false)');
      expect(at, greaterThan(0));
      expect(emitAt, greaterThan(0));
      expect(at, lessThan(emitAt),
          reason: 'set after the emit, the message appears only if something '
              'else happens to rebuild later');
    });

    test('one page at a time', () {
      final fn = loadMoreBody();
      // Scroll listeners fire every frame near the bottom; without this the
      // same page is requested repeatedly and each response appends.
      expect(fn.contains('if (currentState.isLoadingMore) return;'), isTrue);
    });
  });

  group('appending', () {
    test('drops rows already held', () {
      // Offset pagination over a table that takes new rows at the top shifts
      // everything down, so page two legitimately re-sends the last row of
      // page one. Appending blind gives duplicate ids, and a ListView keyed
      // on id throws on the duplicate.
      final existing = [tx('a'), tx('b')];
      final incoming = [tx('b'), tx('c')];
      final seen = existing.map((t) => t.id).toSet();
      final out = [
        ...existing,
        for (final t in incoming)
          if (t.id.isEmpty || seen.add(t.id)) t,
      ];
      expect(out.map((t) => t.id).toList(), ['a', 'b', 'c']);
    });

    test('keeps rows that carry no id at all', () {
      // An id-less row cannot be compared, and silently dropping it would
      // lose a real transaction. Better a possible duplicate than a
      // disappearance.
      final existing = [tx('a')];
      final incoming = [tx(''), tx('')];
      final seen = existing.map((t) => t.id).toSet();
      final out = [
        ...existing,
        for (final t in incoming)
          if (t.id.isEmpty || seen.add(t.id)) t,
      ];
      expect(out.length, 3);
    });
  });

  group('the shared pagination primitives', () {
    // COMMENTS STRIPPED. The header of that file explains these very
    // mistakes and names ScrollController while doing so, so a raw search
    // would match the explanation rather than the code — which is how a
    // source test comes to assert the opposite of what it means.
    final footer = code(File('lib/core/shared_widgets/load_more_footer.dart')
        .readAsStringSync());

    test('the trigger uses a notification, not a shared ScrollController', () {
      // ScrollController.position is _positions.single and THROWS the moment
      // a second view attaches — which is what happens when a sheet opens
      // over a list that is still mounted. A notification listener has no
      // such state and cannot be mis-shared.
      expect(
          footer.contains('NotificationListener<ScrollNotification>'), isTrue);
      expect(footer.contains('ScrollController'), isFalse,
          reason: 'owning one here would reintroduce the double-attach throw');
    });

    test('the trigger ignores nested and horizontal scrollables', () {
      // A horizontal rail or an inner list would otherwise report its own end
      // and pull a page of the OUTER list.
      expect(footer.contains('n.depth != 0'), isTrue);
      expect(footer.contains('m.axis != Axis.vertical'), isTrue);
    });

    test('the footer stays pressable when idle', () {
      // Scroll notifications are position-based, so a page that fails while
      // the reader is already at the bottom leaves maxScrollExtent unchanged
      // and generates nothing further. With no control, the list is stuck
      // behind a spinner for good.
      expect(footer.contains('onTap: onLoadMore'), isTrue);
      final idle = footer.substring(footer.indexOf('final failed ='));
      expect(idle.contains("'Try again'"), isTrue);
    });

    test('it never swallows the notification', () {
      // A RefreshIndicator or an outer listener upstream is entitled to the
      // same event.
      expect(footer.contains('return false;'), isTrue);
    });
  });

  group('hasMore describes the SERVER, not the assembled list', () {
    final repo = code(File('lib/src/features/transaction_history/data/'
            'repository/transaction_history_repository_grpc.dart')
        .readAsStringSync());

    test('neither page builder decides hasMore from the local list length', () {
      // THE BUG, reported 2026-11-26: a customer's dashboard history stopped
      // in early November though he had 567 ledger rows going back to August,
      // and "scroll down to load more" did nothing at all.
      //
      // `hasMore = transactions.length == limit` compared the ASSEMBLED list
      // against the page size. By that point the list is not the server's
      // page: on page 1 up to 200 external transfers are merged in from
      // core-payments, and three local filters can drop rows from any page.
      // His 310 core-payments rows made page one ~200 long, `200 == 20` was
      // false, and hasMore was false on the FIRST page.
      //
      // Nothing degrades gracefully from there: _onScroll requires
      // state.hasMore, loadMoreTransactions() returns early without it, and
      // itemCount only adds the LoadMoreFooter when it is true. No trigger,
      // no button.
      // Every `transactions.length == limit` left in the file must be reading
      // the SERVER's page (`response.transactions`). A bare one is the defect.
      final bare = RegExp(r'(^|[^.\w])transactions\.length == limit')
          .allMatches(repo)
          .length;
      expect(bare, 0,
          reason: 'hasMore must not be derived from the list after the '
              'external-transfer merge and the local filters have changed it');
    });

    test('it compares what was asked for against the server total', () {
      expect(repo, contains('requested < response.total'),
          reason: 'response.total is the server count for this filtered query '
              '(it already feeds totalPages); page * limit is what we have '
              'asked for');
      // The fallback for a server that reports no total must read the RAW
      // page, never the mutated local list.
      expect(repo, contains('response.transactions.length == limit'),
          reason: 'the no-total fallback must count the server page, not the '
              'merged and filtered one');
    });
  });
}
