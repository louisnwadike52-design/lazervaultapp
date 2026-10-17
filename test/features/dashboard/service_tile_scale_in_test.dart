import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/widgets/service_tile_scale_in.dart';

/// The quick-service tiles scale in when the dashboard first appears.
///
/// The thing that makes this safe rather than annoying is that it plays ONCE.
/// The grid rebuilds constantly — balance refreshes, account switches, the
/// reorder drag, every cubit emission behind it — and animating on each
/// rebuild would make the dashboard twitch for the rest of the session.
void main() {
  double scaleOf(WidgetTester tester) {
    final t = tester.widget<Transform>(find.descendant(
      of: find.byType(ServiceTileScaleIn),
      matching: find.byType(Transform),
    ));
    // The scale is on the matrix diagonal.
    return t.transform.storage[0];
  }

  Widget host(Set<String> played, {bool reduceMotion = false}) => MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(disableAnimations: reduceMotion),
          child: ServiceTileScaleIn(
            id: 'send_funds',
            index: 0,
            played: played,
            child: const SizedBox(width: 10, height: 10),
          ),
        ),
      );

  testWidgets('a tile starts smaller than full size and settles at 1.0',
      (tester) async {
    await tester.pumpWidget(host(<String>{}));
    await tester.pump(); // first frame, animation not yet advanced
    expect(scaleOf(tester), lessThan(1.0),
        reason: 'it must actually start scaled down, or there is no animation');

    await tester.pumpAndSettle();
    expect(scaleOf(tester), closeTo(1.0, 0.001),
        reason: 'it must end at exactly full size — a tile left at 0.98 is a '
            'permanently wrong layout, not an animation');
  });

  testWidgets('it does NOT replay for a tile that already animated',
      (tester) async {
    final played = <String>{};
    await tester.pumpWidget(host(played));
    await tester.pumpAndSettle();

    // Rebuild from scratch with the SAME played set — this is what a cubit
    // emission behind the grid does.
    await tester.pumpWidget(const SizedBox());
    await tester.pumpWidget(host(played));
    await tester.pump();

    expect(scaleOf(tester), closeTo(1.0, 0.001),
        reason: 'a rebuilt tile must appear at full size immediately; '
            'replaying is what makes a dashboard twitch all session');
  });

  testWidgets('reduce-motion shows the tile with no transform at all',
      (tester) async {
    await tester.pumpWidget(host(<String>{}, reduceMotion: true));
    await tester.pump();
    expect(
      find.descendant(
        of: find.byType(ServiceTileScaleIn),
        matching: find.byType(Transform),
      ),
      findsNothing,
      reason: 'the OS reduce-motion setting must skip the animation entirely',
    );
  });

  testWidgets('a tile disposed mid-stagger does not throw', (tester) async {
    // Tiles are built inside a PageView and can be disposed during their
    // stagger delay — an account switch, or popping the dashboard.
    await tester.pumpWidget(MaterialApp(
      home: ServiceTileScaleIn(
        id: 'late',
        index: 10, // a long stagger delay
        played: <String>{},
        child: const SizedBox(width: 10, height: 10),
      ),
    ));
    await tester.pump();
    await tester.pumpWidget(const SizedBox()); // dispose mid-delay
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
