import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/user_search_skeleton.dart';

/// The skeleton that replaced the spinner in every user search.
///
/// Sixteen surfaces open the shared search sheet — send funds, batch transfer,
/// TagPay, crypto send, escrow, group and family accounts, invoices, payroll,
/// chat — so the thing they all render while waiting is worth pinning.
Future<void> _pump(WidgetTester tester, Widget child) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => MaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: child)),
      ),
    ),
  );
  // One frame only: Shimmer animates forever, so pumpAndSettle would hang.
  await tester.pump();
}

void main() {
  testWidgets('renders a shimmer, not a spinner', (tester) async {
    await _pump(tester, const UserSearchSkeleton());
    expect(find.byType(Shimmer), findsOneWidget,
        reason: 'the loading state must be a shimmer skeleton');
    expect(find.byType(CircularProgressIndicator), findsNothing,
        reason: 'a spinner in an empty sheet says only "wait"');
  });

  testWidgets('one shimmer wraps the whole list', (tester) async {
    // Not one per row: the highlight should sweep across the list as a single
    // motion rather than every row pulsing in lockstep.
    await _pump(tester, const UserSearchSkeleton(rows: 6));
    expect(find.byType(Shimmer), findsOneWidget);
  });

  testWidgets('draws the requested number of rows', (tester) async {
    for (final n in [1, 3, 6]) {
      await _pump(tester, UserSearchSkeleton(rows: n, showSectionHeader: false));
      // Each row is a circle avatar plus two bars.
      final circles = tester.widgetList<Container>(find.byType(Container)).where((c) {
        final d = c.decoration;
        return d is BoxDecoration && d.shape == BoxShape.circle;
      }).length;
      expect(circles, n, reason: 'expected $n avatar placeholders');
    }
  });

  testWidgets('the section header can be withheld', (tester) async {
    // Load-more and the contacts list append below existing content, where a
    // heading placeholder would read as a new section that never arrives.
    await _pump(tester, const UserSearchSkeleton(rows: 1, showSectionHeader: false));
    final withoutHeader = tester.widgetList<Container>(find.byType(Container)).length;
    await _pump(tester, const UserSearchSkeleton(rows: 1));
    final withHeader = tester.widgetList<Container>(find.byType(Container)).length;
    expect(withHeader, greaterThan(withoutHeader));
  });

  testWidgets('row widths vary, so it reads as text and not as a graphic',
      (tester) async {
    await _pump(tester, const UserSearchSkeleton(rows: 6, showSectionHeader: false));
    final widths = tester
        .widgetList<Container>(find.byType(Container))
        .map((c) => c.constraints?.maxWidth)
        .whereType<double>()
        .toSet();
    expect(widths.length, greaterThan(2),
        reason: 'identical bars read as a loading graphic rather than pending text');
  });

  testWidgets('is safe to render with zero rows', (tester) async {
    // Guards the load-more path if a caller ever passes a computed count.
    await _pump(tester, const UserSearchSkeleton(rows: 0, showSectionHeader: false));
    expect(tester.takeException(), isNull);
  });
}
