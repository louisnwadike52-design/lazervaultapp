import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/widgets/system_bottom_inset.dart';

/// THE BOTTOM NAV IS INSET EXACTLY ONCE.
///
/// Two bugs, one after the other, both visible to users:
///
///  1. the bar drawn UNDER the phone's back/home/recents buttons, because
///     Android 15 lays every app out edge to edge and the third-party bar did
///     not inset itself;
///  2. then the bar floating a whole navigation bar too HIGH, with a dead
///     white band under it — because MotionTabBar's `useSafeArea` defaults to
///     TRUE, so once the wrapper padded it the package padded it again.
///
/// A `Padding` does not consume what it pads. These pin that
/// [SystemBottomInset] both applies the inset AND removes it from the
/// MediaQuery it hands down, so neither bug can come back.
///
/// The window is driven through `tester.view` rather than a hand-built
/// MediaQuery, so `padding`, `viewPadding` and `viewInsets` relate to each
/// other and to the render surface the way they do on a real device — a
/// fabricated `size` that disagrees with the surface measures nothing.
void main() {
  const double w = 400;
  const double h = 800;

  void setView(
    WidgetTester tester, {
    double padBottom = 48,
    double? viewPadBottom,
    double viewInsetBottom = 0,
    double height = h,
  }) {
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = Size(w, height);
    tester.view.padding = FakeViewPadding(bottom: padBottom);
    tester.view.viewPadding = FakeViewPadding(bottom: viewPadBottom ?? padBottom);
    tester.view.viewInsets = FakeViewPadding(bottom: viewInsetBottom);
    addTearDown(tester.view.reset);
  }

  Widget harness(Widget child) => MaterialApp(
        home: Align(
          alignment: Alignment.bottomCenter,
          child: SystemBottomInset(
            background: Colors.white,
            debugLabel: 'test bar',
            child: child,
          ),
        ),
      );

  double bottomOf(GlobalKey key) {
    final box = key.currentContext!.findRenderObject() as RenderBox;
    return box.localToGlobal(Offset(0, box.size.height)).dy;
  }

  testWidgets('the child sees no bottom padding, so it cannot inset again',
      (tester) async {
    setView(tester);
    double? seen;
    await tester.pumpWidget(harness(Builder(builder: (context) {
      seen = MediaQuery.paddingOf(context).bottom;
      return const SizedBox(height: 55, width: w);
    })));

    expect(seen, 0,
        reason: 'a child that applies SafeArea or reads padding.bottom — '
            'MotionTabBar does both by default — would otherwise add a '
            'second navigation bar of empty space under the tabs');
  });

  testWidgets('a child that insets itself adds nothing on top', (tester) async {
    setView(tester);
    final key = GlobalKey();
    await tester.pumpWidget(harness(SafeArea(
      // Exactly what MotionTabBar does internally (useSafeArea: true).
      bottom: true,
      child: SizedBox(key: key, height: 55, width: w),
    )));

    expect(bottomOf(key), closeTo(h - 48, 0.5),
        reason: 'the tab row must sit exactly one system-bar height above the '
            'bottom of the screen — not two');
    final box = key.currentContext!.findRenderObject() as RenderBox;
    expect(box.size.height, 55,
        reason: 'the bar itself must not be squeezed by the inset');
  });

  testWidgets('the bar is lifted clear of the system navigation bar',
      (tester) async {
    setView(tester);
    final key = GlobalKey();
    await tester.pumpWidget(harness(SizedBox(key: key, height: 55, width: w)));

    expect(bottomOf(key), closeTo(h - 48, 0.5),
        reason: 'this is the original bug: without the inset the bar is drawn '
            'under the back/home/recents buttons');
  });

  testWidgets('with no system bar there is no gap at all', (tester) async {
    setView(tester, padBottom: 0);
    final key = GlobalKey();
    await tester.pumpWidget(harness(SizedBox(key: key, height: 55, width: w)));

    expect(bottomOf(key), closeTo(h, 0.5),
        reason: 'an older Android reports no inset and must get no padding — '
            'a floor would be a permanent dead band');
  });

  testWidgets('the keyboard does not leave a dead band above the keys',
      (tester) async {
    // padding = viewPadding - viewInsets: the real relationship when the
    // keyboard is up. The navigation bar is then behind the keyboard.
    setView(tester, padBottom: 0, viewPadBottom: 48, viewInsetBottom: 300);
    final key = GlobalKey();
    await tester.pumpWidget(harness(SizedBox(key: key, height: 55, width: w)));
    await tester.pump();
    await tester.pump();

    expect(bottomOf(key), closeTo(h, 0.5),
        reason: 'insetting for a navigation bar hidden behind the keyboard '
            'would push the bar up off the keys');
  });

  testWidgets('the watchdog corrects a device that under-reports its inset',
      (tester) async {
    // A phone whose MediaQuery claims no bottom padding while the system bar
    // is genuinely 48dp tall. Nothing in the reported padding would save the
    // bar; only measuring where it actually landed does.
    setView(tester, padBottom: 0, viewPadBottom: 48);
    final key = GlobalKey();
    await tester.pumpWidget(harness(SizedBox(key: key, height: 55, width: w)));

    // First frame lays out wrong; the post-frame measurement corrects it.
    await tester.pump();
    await tester.pump();

    expect(bottomOf(key), closeTo(h - 48, 1.0),
        reason: 'the bar was measured 48dp inside the system navigation bar '
            'and must have been lifted clear of it');
  });

  testWidgets('the correction is dropped when the window changes',
      (tester) async {
    setView(tester, padBottom: 0, viewPadBottom: 48);
    final key = GlobalKey();
    await tester.pumpWidget(harness(SizedBox(key: key, height: 55, width: w)));
    await tester.pump();
    await tester.pump();
    expect(bottomOf(key), closeTo(h - 48, 1.0));

    // Rotation / fold / the user switching to gesture navigation: the old
    // measurement describes a layout that no longer exists, so it must not
    // persist as a permanent gap.
    tester.view.physicalSize = const Size(w, 700);
    tester.view.padding = FakeViewPadding.zero;
    tester.view.viewPadding = FakeViewPadding.zero;
    await tester.pumpAndSettle();

    expect(bottomOf(key), closeTo(700, 1.0),
        reason: 'no system bar in the new window means no padding at all');
  });
}
