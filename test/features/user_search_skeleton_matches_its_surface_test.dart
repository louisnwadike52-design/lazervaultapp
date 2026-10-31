import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/user_search_skeleton.dart';

/// The search skeleton hardcoded the crypto/statistics shimmer palette
/// (#1F1F1F base) on the reasoning that every loading state should look the
/// same. Those two skeletons sit on dark screens; almost every user-search
/// sheet is `Colors.white`, so the "consistent" choice painted near-black bars
/// onto a white sheet. Consistency is with the SURFACE, not the other file.
///
/// It also drew with no horizontal padding while the result lists it stands in
/// for use 16.w / 20.w, so the bars sat left of the rows and the list slid
/// sideways the moment results arrived — the exact jump the skeleton exists to
/// prevent.
void main() {
  Widget wrap(Widget child, {Color ground = Colors.white}) => ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (_, __) => MaterialApp(
          home: Scaffold(backgroundColor: ground, body: child),
        ),
      );

  Shimmer shimmerOf(WidgetTester t) =>
      t.widget<Shimmer>(find.byType(Shimmer).first);

  /// Shimmer exposes its colours only through the gradient it was built with.
  List<Color> colorsOf(Shimmer s) => s.gradient.colors;

  testWidgets('defaults to the LIGHT palette, for a white sheet',
      (tester) async {
    await tester.pumpWidget(wrap(const UserSearchSkeleton(rows: 2)));
    await tester.pump(const Duration(milliseconds: 50));

    final colors = colorsOf(shimmerOf(tester));
    // Every stop must be light. The regression was a near-black base, so the
    // assertion is on luminance rather than on exact values — it survives a
    // deliberate palette tweak and still fails the actual bug.
    for (final c in colors) {
      expect(c.computeLuminance(), greaterThan(0.55),
          reason: 'a dark stop ($c) in the default palette puts near-black '
              'bars on a white search sheet, which is the reported defect');
    }
  });

  testWidgets('onDark: true restores the dark palette', (tester) async {
    await tester.pumpWidget(wrap(
      const UserSearchSkeleton(rows: 2, onDark: true),
      ground: const Color(0xFF1F1F1F),
    ));
    await tester.pump(const Duration(milliseconds: 50));

    final colors = colorsOf(shimmerOf(tester));
    expect(colors.any((c) => c.computeLuminance() < 0.2), isTrue,
        reason: 'the dark surfaces (SprayMe tag sheet) still need the dark '
            'palette — this flag is the only way they get it');
  });

  testWidgets('renders the requested number of rows', (tester) async {
    await tester.pumpWidget(wrap(const UserSearchSkeleton(rows: 4)));
    await tester.pump(const Duration(milliseconds: 50));
    // One circle per row; the avatar is the only circular box in the tree.
    final circles = tester
        .widgetList<Container>(find.byType(Container))
        .where((c) =>
            c.decoration is BoxDecoration &&
            (c.decoration as BoxDecoration).shape == BoxShape.circle)
        .length;
    expect(circles, 4);
  });

  test('the one DARK search surface passes onDark', () {
    // SprayMe's tag sheet grounds on _bg = #1F1F1F. If it stops passing the
    // flag it silently gets light-on-light bars, which is invisible in review.
    final src = File(
      'lib/src/features/sprayme/presentation/widgets/tag_people_sheet.dart',
    ).readAsStringSync();
    expect(src.contains('onDark: true'), isTrue,
        reason: 'tag_people_sheet is the dark search sheet; without onDark it '
            'draws the light palette on a #1F1F1F ground');
  });

  test('skeletons stand in for rows at the same inset as those rows', () {
    // The alignment half of the fix. Each sheet's skeleton must carry the same
    // horizontal padding as the list whose rows replace it, EXCEPT where the
    // skeleton already sits inside that padded list.
    const cases = <String, String>{
      'lib/src/features/recipients/presentation/widgets/unified_user_search_sheet.dart':
          'horizontal: 16.w',
      'lib/src/features/recipients/presentation/widgets/enhanced_recipient_selection_bottom_sheet.dart':
          'horizontal: 20.w',
    };
    cases.forEach((path, inset) {
      final src = File(path).readAsStringSync();
      final i = src.indexOf('UserSearchSkeleton');
      expect(i, greaterThan(-1), reason: '$path no longer uses the skeleton');
      expect(src.contains(inset), isTrue,
          reason: '$path should pad its skeleton by $inset to match the list '
              'it stands in for, or the rows jump sideways on arrival');
    });
  });
}
