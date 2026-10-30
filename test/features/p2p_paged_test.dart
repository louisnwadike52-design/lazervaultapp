import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_paged.dart';

/// PAGING ARITHMETIC, PINNED.
///
/// The connections list showed only the first 20 rows with no way to reach the
/// rest. The server had always sent `total`, `page` and `limit` alongside the
/// rows — the client parsed the rows and discarded the numbers, so the list
/// could not know a second page existed. These assertions cover the two ways
/// that fix goes wrong: stopping early (rows unreachable again) and never
/// stopping (an endless request loop at the bottom of the list).
void main() {
  P2PPaged<String> page({
    required int items,
    required int total,
    required int page,
    int limit = 20,
  }) =>
      P2PPaged<String>(
        items: List.generate(items, (i) => 'row$i'),
        total: total,
        page: page,
        limit: limit,
      );

  group('hasMore', () {
    test('a full first page of a longer list has more', () {
      expect(page(items: 20, total: 134, page: 1).hasMore, isTrue);
    });

    test('the last partial page does not', () {
      // 134 rows at 20 → page 7 holds 14.
      expect(page(items: 14, total: 134, page: 7).hasMore, isFalse);
    });

    test('an EXACT multiple stops at the right page', () {
      // The trap: 40 rows at 20 per page. Page 2 comes back FULL, so "did this
      // page look full" would ask for a third page that does not exist, and
      // the scroll listener would keep asking forever.
      expect(page(items: 20, total: 40, page: 1).hasMore, isTrue);
      expect(page(items: 20, total: 40, page: 2).hasMore, isFalse);
    });

    test('a single short page is complete', () {
      expect(page(items: 7, total: 7, page: 1).hasMore, isFalse);
    });

    test('an empty list is complete, not pending', () {
      expect(page(items: 0, total: 0, page: 1).hasMore, isFalse);
      expect(P2PPaged.empty<String>().hasMore, isFalse);
    });

    test('a zero or negative limit cannot claim more', () {
      // Guards a division-by-zero style trap if the server ever omits limit.
      expect(page(items: 0, total: 10, page: 1, limit: 0).hasMore, isFalse);
    });

    test('a nonsense negative total is treated as complete', () {
      expect(page(items: 5, total: -1, page: 1).hasMore, isFalse);
    });
  });

  group('nextPage', () {
    test('is the following page while more remain', () {
      expect(page(items: 20, total: 134, page: 1).nextPage, 2);
      expect(page(items: 20, total: 134, page: 3).nextPage, 4);
    });

    test('is null once complete, so the caller stops asking', () {
      expect(page(items: 14, total: 134, page: 7).nextPage, isNull);
      expect(page(items: 20, total: 40, page: 2).nextPage, isNull);
    });
  });

  group('page size the client actually requests', () {
    test('a 50-row page reaches the end of a 134-row list in three', () {
      expect(page(items: 50, total: 134, page: 1, limit: 50).hasMore, isTrue);
      expect(page(items: 50, total: 134, page: 2, limit: 50).hasMore, isTrue);
      expect(page(items: 34, total: 134, page: 3, limit: 50).hasMore, isFalse);
    });
  });
}
