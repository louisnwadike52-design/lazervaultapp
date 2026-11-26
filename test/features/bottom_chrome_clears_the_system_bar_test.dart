import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/widgets/system_bottom_inset.dart';

/// THE BOTTOM NAV SAT UNDER THE PHONE'S OWN BUTTONS.
///
/// Reported with a screenshot: the app's Dashboard / analytics / Beam /
/// Lifestyle bar drawn behind Samsung's back, home and recents keys, and a
/// bottom sheet whose "Cancel" was half-swallowed the same way.
///
/// From Android 15 (API 35) the system lays every app out EDGE TO EDGE and
/// ignores the old window flags, so insetting the app's own chrome became the
/// app's job. Material's `BottomNavigationBar` does it; `MotionTabBar`,
/// `CurvedNavigationBar` and a hand-built sheet with a fixed bottom padding do
/// not.
void main() {
  group('SystemBottomInset', () {
    testWidgets('pads by the system navigation bar and paints behind it',
        (t) async {
      await t.pumpWidget(MediaQuery(
        data: const MediaQueryData(padding: EdgeInsets.only(bottom: 48)),
        // Center so the widget takes its natural size rather than the
        // screen's — this is a measurement test, not a layout one.
        child: const Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: SystemBottomInset(
              background: Color(0xFF1E1E1E),
              child: SizedBox(height: 55, width: 100),
            ),
          ),
        ),
      ));
      expect(t.getSize(find.byType(SystemBottomInset)).height, 55 + 48);
      expect(find.byType(ColoredBox), findsOneWidget,
          reason: 'the inset strip must be painted or the page shows through');
    });

    testWidgets('collapses while the keyboard is up', (t) async {
      // padding is viewPadding minus the keyboard, so it is already zero here.
      // Insetting anyway would leave a dead band above the keys.
      // This IS what the engine reports with a keyboard up: viewPadding keeps
      // the navigation bar, viewInsets holds the keyboard, and padding — the
      // difference — is zero. Reading viewPadding here would leave a dead band
      // above the keys.
      await t.pumpWidget(const MediaQuery(
        data: MediaQueryData(
          viewPadding: EdgeInsets.only(bottom: 48),
          viewInsets: EdgeInsets.only(bottom: 300),
        ),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: SystemBottomInset(child: SizedBox(height: 55, width: 100)),
          ),
        ),
      ));
      expect(t.getSize(find.byType(SystemBottomInset)).height, 55);
    });
  });

  group('nothing bypasses the inset-aware helpers', () {
    Iterable<File> dartFiles() => Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'));

    test('every bottom sheet goes through showAppBottomSheet', () {
      // ANCHORED. Unanchored, `showModalBottomSheet` matches inside
      // `showAppBottomSheet`'s own body and doc comment, and a guard that
      // matches the fix can never fail.
      final raw = RegExp(r'(?<![A-Za-z0-9_.])showModalBottomSheet(?=[<(])');
      final get = RegExp(r'(?<![A-Za-z0-9_.])Get\.bottomSheet(?=[<(])');
      final offenders = <String>[];
      for (final f in dartFiles()) {
        if (f.path.endsWith('core/widgets/app_bottom_sheet.dart')) continue;
        final src = f.readAsStringSync();
        for (final m in [...raw.allMatches(src), ...get.allMatches(src)]) {
          final line = '\n'.allMatches(src.substring(0, m.start)).length + 1;
          offenders.add('${f.path}:$line');
        }
      }
      expect(offenders, isEmpty,
          reason: 'a raw bottom sheet puts its last row under the phone\'s '
              'navigation buttons on Android 15+. Use showAppBottomSheet / '
              'showAppGetBottomSheet:\n${offenders.join('\n')}');
    });

    // THE TWO DASHBOARD NAVS ARE FLUSH, BY INSTRUCTION — and this test used
    // to assert the opposite.
    //
    // Both were wrapped in SystemBottomInset so they would clear the phone's
    // navigation buttons under Android 15's edge-to-edge layout. The operator
    // then reported the result as the bar "lifted too high" — in the same
    // words they had used for the original complaint — and asked for it back
    // at the bottom. They are the one looking at the device.
    //
    // So the guard is inverted rather than deleted: it now pins the decision
    // that is actually in force, and says why, so nobody restores the inset
    // from first principles without talking to the operator first.
    //
    // THE PROTECTION THAT MATTERS IS UNTOUCHED. The test above this still
    // refuses any raw bottom sheet, which is where a last row genuinely
    // disappears under the navigation buttons. MotionTabBar's own
    // `useSafeArea` also still defaults to true, so the package applies
    // whatever its own SafeArea resolves to — nothing is added on top.
    test('both dashboard bottom navs sit flush, as the operator asked', () {
      final src = File(
              'lib/src/features/presentation/views/dashboard/dashboard_screen.dart')
          .readAsStringSync();
      final nav =
          src.substring(src.indexOf('Widget _buildAdaptiveBottomNav()'));
      final body = nav.substring(0, nav.indexOf('Widget _buildCurvedNavItem'));
      expect(RegExp(r'SystemBottomInset\(').allMatches(body).length, 0,
          reason: 'a bottom nav has been re-wrapped in SystemBottomInset. '
              'That was tried and the operator reported the bar as lifted too '
              'high, twice. If a three-button device needs it back, it needs '
              'their eyes on the result, not a revert.');
    });
  });
}
