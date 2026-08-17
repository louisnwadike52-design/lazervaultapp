part of 'group_details_screen.dart';

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _SliverTabBarDelegate({required this.child, required this.height});

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color(0xFF0A0A0A),
      child: child,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return oldDelegate.height != height;
  }
}
