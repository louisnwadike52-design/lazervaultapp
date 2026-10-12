import 'package:flutter/material.dart';

/// Horizontal swipe moves to the next or previous tab.
///
/// WHY A GESTURE DETECTOR AND NOT A PAGEVIEW. The lists under these tabs are
/// vertically scrolling and are rebuilt from one filtered source, not held as
/// separate pages. Wrapping them in a PageView would mean keeping a page per
/// tab alive and keeping its scroll position in sync with a filter that can
/// change from elsewhere. This reads the drag instead and leaves the existing
/// list exactly as it is.
///
/// Only a decisive horizontal drag counts: the child is a vertical list, and
/// a swipe that is mostly vertical belongs to it. [_minVelocity] ignores a
/// slow drift, which is usually a user adjusting their grip rather than
/// asking for the next tab.
class SwipeBetweenTabs extends StatelessWidget {
  final Widget child;

  /// Called to move forward (swipe left) and back (swipe right). Either may
  /// be null at the ends of the range, which makes the swipe a no-op rather
  /// than wrapping around: wrapping from the last tab to the first loses a
  /// user's place with no way to tell it happened.
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;

  const SwipeBetweenTabs({
    super.key,
    required this.child,
    this.onNext,
    this.onPrevious,
  });

  static const double _minVelocity = 220;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Only horizontal drags are claimed, so the vertical list underneath
      // keeps its own gestures untouched.
      onHorizontalDragEnd: (details) {
        final v = details.primaryVelocity ?? 0;
        if (v <= -_minVelocity) {
          onNext?.call();
        } else if (v >= _minVelocity) {
          onPrevious?.call();
        }
      },
      // Transparent, not opaque: an opaque behaviour would swallow taps on
      // the cards inside.
      behavior: HitTestBehavior.translucent,
      child: child,
    );
  }
}
