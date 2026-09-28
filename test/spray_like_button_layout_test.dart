import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lazervault/src/features/sprayme/presentation/widgets/like_counter_overlay.dart';
import 'package:lazervault/src/features/sprayme/presentation/widgets/spray_hearts_layer.dart';

/// The like control used to reserve 300pt of vertical space for its own heart
/// animation while living in the room's right-hand action rail — a rail that
/// also has to fit the host avatar and up to seven controls inside a clipping
/// scroll view. That single widget is why the host's "End" control was not on
/// screen. These tests pin the fix.
Future<void> _pump(WidgetTester tester, Widget child) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, __) => MaterialApp(
        home: Scaffold(
          body: Align(alignment: Alignment.topLeft, child: child),
        ),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  testWidgets('detached like button costs the rail only its own height',
      (tester) async {
    tester.view.physicalSize = const Size(414, 896);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    final controller = SprayHeartsController();
    addTearDown(controller.dispose);

    await _pump(
      tester,
      LikeCounterOverlay(
        totalLikes: 12,
        onLikeTap: () {},
        buttonSize: 40,
        heartsController: controller,
      ),
    );

    final size = tester.getSize(find.byType(LikeCounterOverlay));
    // Disc + gap + label. Anything near 300 means the runway crept back in
    // and the rail has lost its bottom controls again.
    expect(size.height, lessThan(90),
        reason: 'like control must not reserve heart runway in the rail');
    expect(size.height, greaterThan(40),
        reason: 'the button itself must still be there');
  });

  testWidgets('attached mode still reserves its runway for callers with room',
      (tester) async {
    tester.view.physicalSize = const Size(414, 896);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await _pump(
      tester,
      LikeCounterOverlay(totalLikes: 3, onLikeTap: () {}, runwayHeight: 200),
    );

    final size = tester.getSize(find.byType(LikeCounterOverlay));
    expect(size.height, closeTo(200, 1),
        reason: 'the un-detached widget keeps its documented behaviour');
  });

  testWidgets('tapping the detached button fires the shared controller',
      (tester) async {
    tester.view.physicalSize = const Size(414, 896);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    final controller = SprayHeartsController();
    addTearDown(controller.dispose);
    var taps = 0;

    await _pump(
      tester,
      LikeCounterOverlay(
        totalLikes: 0,
        onLikeTap: () => taps++,
        buttonSize: 40,
        heartsController: controller,
      ),
    );

    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pump();

    // Both halves must fire: the count goes to the server, the heart to the
    // detached layer. Dropping either is a silent regression — the like
    // still "works" while the animation dies, or vice versa.
    expect(taps, 1);
    expect(controller.tick, 1);
  });
}
