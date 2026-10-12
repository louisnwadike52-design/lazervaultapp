part of 'group_entities.dart';

/// One page of a list, with everything the pager needs to draw itself.
///
/// Carried as a value rather than a bare list because a numbered pager has
/// to know how many pages there are BEFORE the user reaches the end — which
/// a list of items cannot tell it. The server already computes all of this
/// (GroupPaginationInfo); throwing it away on the client and guessing from
/// `items.length < pageSize` gets the last page wrong whenever the total is
/// an exact multiple of the page size.
class PagedResult<T> extends Equatable {
  final List<T> items;

  /// 1-based.
  final int page;
  final int pageSize;
  final int totalItems;
  final int totalPages;

  const PagedResult({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
  });

  /// An empty first page. The honest state before anything has loaded, and
  /// the one a failed read falls back to.
  const PagedResult.empty({this.pageSize = 5})
      : items = const [],
        page = 1,
        totalItems = 0,
        totalPages = 0;

  bool get hasNext => page < totalPages;
  bool get hasPrev => page > 1;
  bool get isEmpty => items.isEmpty;

  /// 0-based rank of this page's first row within the whole list.
  ///
  /// The reorder write needs it: numbering page 3 as 0,1,2… would teleport
  /// those rows to the front of the list.
  int get startIndex => (page - 1) * pageSize;

  PagedResult<T> copyWith({List<T>? items, int? page}) => PagedResult<T>(
        items: items ?? this.items,
        page: page ?? this.page,
        pageSize: pageSize,
        totalItems: totalItems,
        totalPages: totalPages,
      );

  @override
  List<Object?> get props => [items, page, pageSize, totalItems, totalPages];
}
