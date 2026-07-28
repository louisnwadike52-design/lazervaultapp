import 'package:flutter/widgets.dart';

/// Adds "load the next page when the user scrolls near the bottom" to a list
/// screen. Backends already return `page/limit/totalPages`, so pagination is
/// driven screen-locally: keep an accumulated list, bump [page], append.
///
/// Usage:
/// ```dart
/// class _MyScreenState extends State<MyScreen> with InfiniteScrollMixin<MyScreen> {
///   @override void initState() { super.initState(); attachInfiniteScroll(); _loadFirst(); }
///   @override void dispose() { detachInfiniteScroll(); super.dispose(); }
///   @override Future<void> onLoadMore() async { /* fetch page, append, update hasMore */ }
///   // ListView(controller: scrollController, itemCount: items.length + (isLoadingMore ? 1 : 0), ...)
/// }
/// ```
mixin InfiniteScrollMixin<T extends StatefulWidget> on State<T> {
  final ScrollController scrollController = ScrollController();

  /// 1-based page cursor of the LAST loaded page.
  int page = 1;

  /// Whether another page exists (currentPage < totalPages).
  bool hasMore = true;

  /// Guards against overlapping load-more requests.
  bool isLoadingMore = false;

  /// Pixels-from-bottom at which the next page starts loading.
  double get loadMoreThreshold => 320;

  /// Implement: fetch `page + 1`, append its items, then set [page]/[hasMore].
  /// Wrap the body in `isLoadingMore = true` … `false` via [runLoadMore].
  Future<void> onLoadMore();

  void _onScroll() {
    if (!hasMore || isLoadingMore || !scrollController.hasClients) return;
    final pos = scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - loadMoreThreshold) {
      onLoadMore();
    }
  }

  /// Call from initState.
  void attachInfiniteScroll() => scrollController.addListener(_onScroll);

  /// Call from dispose.
  void detachInfiniteScroll() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
  }

  /// Reset the cursor (e.g. on pull-to-refresh or after a mutation).
  void resetPagination() {
    page = 1;
    hasMore = true;
    isLoadingMore = false;
  }

  /// Runs [body] with the [isLoadingMore] guard + a setState around it, so
  /// callers only supply the fetch/append logic.
  Future<void> runLoadMore(Future<void> Function() body) async {
    if (isLoadingMore || !hasMore) return;
    setState(() => isLoadingMore = true);
    try {
      await body();
    } finally {
      if (mounted) setState(() => isLoadingMore = false);
    }
  }
}
