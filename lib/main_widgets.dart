part of 'main.dart';

/// Feeds its subtree a MediaQuery whose WIDTH is clamped to [maxWidth]. Placed
/// ABOVE [ScreenUtilInit] so ScreenUtil computes its .w/.h scale factors against
/// the capped width — otherwise on a tablet every `.w` would balloon to fill the
/// full screen. On phones (real width <= maxWidth) it is a pass-through.
class _MaxWidthMediaQuery extends StatelessWidget {
  final double maxWidth;
  final Widget child;
  const _MaxWidthMediaQuery({required this.maxWidth, required this.child});

  @override
  Widget build(BuildContext context) {
    // MediaQuery.fromView establishes a LIVE MediaQuery from the root view
    // (there is no MediaQuery ancestor this high in the tree) that also updates
    // on rotation / window resize.
    return MediaQuery.fromView(
      view: View.of(context),
      child: Builder(
        builder: (context) {
          final base = MediaQuery.of(context);
          if (base.size.width <= maxWidth) return child;
          return MediaQuery(
            data: base.copyWith(size: Size(maxWidth, base.size.height)),
            child: child,
          );
        },
      ),
    );
  }
}

/// Letterboxes the app content to [maxWidth] on large screens: the content is
/// centered in a phone-width column and the surrounding area is filled with the
/// scaffold background. The inner MediaQuery is re-capped so widgets that read
/// `MediaQuery.size` directly also see the constrained width (WidgetsApp resets
/// it to the real view size below GetMaterialApp). Phones are a pass-through.
class _MaxWidthShell extends StatelessWidget {
  final double maxWidth;
  final Widget child;
  const _MaxWidthShell({required this.maxWidth, required this.child});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    if (mq.size.width <= maxWidth) return child;
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: ClipRect(
          child: SizedBox(
            width: maxWidth,
            child: MediaQuery(
              data: mq.copyWith(size: Size(maxWidth, mq.size.height)),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
