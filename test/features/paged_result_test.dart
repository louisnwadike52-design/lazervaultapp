import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/group_account/domain/entities/group_entities.dart';

/// PagedResult drives the pager AND the reorder write. startIndex in
/// particular is load-bearing: get it wrong and reordering page 3 renumbers
/// those rows to the front of the whole list.
void main() {
  PagedResult<String> page({
    int page = 1,
    int size = 5,
    int total = 12,
    int pages = 3,
    List<String>? items,
  }) =>
      PagedResult<String>(
        items: items ?? const ['a', 'b', 'c'],
        page: page,
        pageSize: size,
        totalItems: total,
        totalPages: pages,
      );

  test('startIndex is the rank of the first row in the whole list', () {
    expect(page(page: 1).startIndex, 0);
    expect(page(page: 2).startIndex, 5);
    expect(page(page: 3).startIndex, 10);
    // A different page size moves it with the page.
    expect(page(page: 3, size: 20).startIndex, 40);
  });

  test('hasNext and hasPrev read off the page bounds', () {
    expect(page(page: 1, pages: 3).hasPrev, isFalse);
    expect(page(page: 1, pages: 3).hasNext, isTrue);
    expect(page(page: 2, pages: 3).hasPrev, isTrue);
    expect(page(page: 2, pages: 3).hasNext, isTrue);
    expect(page(page: 3, pages: 3).hasNext, isFalse);
  });

  test('a single page has no next and no prev', () {
    final p = page(page: 1, pages: 1, total: 3);
    expect(p.hasNext, isFalse);
    expect(p.hasPrev, isFalse);
  });

  test('the empty page is an honest zero', () {
    // What a failed read falls back to, and what is held before anything
    // loads. It must not claim a page exists.
    const empty = PagedResult<String>.empty();
    expect(empty.items, isEmpty);
    expect(empty.isEmpty, isTrue);
    expect(empty.totalPages, 0);
    expect(empty.hasNext, isFalse);
    expect(empty.hasPrev, isFalse);
    expect(empty.page, 1);
  });

  test('copyWith keeps the pagination facts it was not given', () {
    final p = page(page: 2);
    final moved = p.copyWith(items: const ['x']);
    expect(moved.items, ['x']);
    expect(moved.page, 2);
    expect(moved.pageSize, p.pageSize);
    expect(moved.totalItems, p.totalItems);
    expect(moved.totalPages, p.totalPages);
  });

  test('equality covers the pagination, not just the rows', () {
    // The pager rebuilds off this; two pages with the same rows but a
    // different page number are NOT the same state.
    expect(page(page: 1) == page(page: 1), isTrue);
    expect(page(page: 1) == page(page: 2), isFalse);
  });
}
