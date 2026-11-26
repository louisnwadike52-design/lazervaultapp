import 'package:flutter/material.dart';
import 'package:lazervault/core/shared_widgets/load_more_footer.dart' as shared;

/// THE TICKETING LISTS' FOOTER — now a thin wrapper.
///
/// This used to be its own `TextButton`, which made it the second
/// implementation of a footer the rest of the app also needed, and the two
/// drifted: this one knew how many rows remained (which is the better idea,
/// and survives) while the other had the spinner, the dark/light grounds and
/// the retry affordance. The visuals now come from
/// `core/shared_widgets/load_more_footer.dart` and only the count arithmetic
/// and the hide-when-complete rule live here.
///
/// It stays a named widget rather than being deleted because `remaining <= 0`
/// collapsing to nothing is a ticketing rule — these lists carry a known
/// total, so a footer offering more when there is no more would be a lie.
class LoadMoreFooter extends StatelessWidget {
  const LoadMoreFooter({
    super.key,
    required this.loaded,
    required this.total,
    required this.onLoadMore,
    this.loading = false,
  });

  final int loaded;
  final int total;
  final VoidCallback onLoadMore;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final remaining = total - loaded;
    if (remaining <= 0) return const SizedBox.shrink();
    return shared.LoadMoreFooter(
      loading: loading,
      remaining: remaining,
      onLoadMore: onLoadMore,
    );
  }
}
