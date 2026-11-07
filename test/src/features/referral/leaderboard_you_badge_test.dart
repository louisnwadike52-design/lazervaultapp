import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/referral/domain/entities/leaderboard_entry_entity.dart';
import 'package:lazervault/src/features/referral/presentation/widgets/leaderboard_list.dart';

// The badge used to compare `entry.userId == currentUserId` where BOTH were
// structurally 0 (the proto field is a uint64, real ids are UUIDs, and
// referral-service set neither), so every row on the public leaderboard was
// labelled "You".

LeaderboardEntryEntity _entry({
  required int rank,
  required String first,
  required String last,
  int referrals = 5,
}) {
  return LeaderboardEntryEntity(
    rank: rank,
    userId: 0, // what the backend actually sends
    username: '$first$last'.toLowerCase(),
    firstName: first,
    lastName: last,
    totalReferrals: referrals,
    totalRewardsEarned: 20000,
    currency: 'NGN',
  );
}

Future<void> _pump(WidgetTester tester, Widget child) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => MaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: child)),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  final board = [
    _entry(rank: 1, first: 'Ada', last: 'Obi'),
    _entry(rank: 2, first: 'Daniel', last: 'Emeh'),
    _entry(rank: 3, first: 'Chidi', last: 'Okeke'),
  ];

  testWidgets('exactly one row is badged, and it is the viewer', (t) async {
    await _pump(t, LeaderboardList(entries: board, currentUserName: 'Daniel Emeh'));
    expect(find.text('You'), findsOneWidget);
    // The badge must sit on Daniel's row, not merely exist somewhere.
    final you = find.text('You');
    final row = find.ancestor(of: you, matching: find.byType(Row)).last;
    expect(find.descendant(of: row, matching: find.textContaining('Daniel')),
        findsOneWidget);
  });

  testWidgets('no badge when the viewer is not on the board', (t) async {
    await _pump(t, LeaderboardList(entries: board, currentUserName: 'Someone Else'));
    expect(find.text('You'), findsNothing);
  });

  testWidgets('no badge when the name is unknown — never every row', (t) async {
    await _pump(t, LeaderboardList(entries: board, currentUserName: null));
    expect(find.text('You'), findsNothing);
  });

  testWidgets('an ambiguous name badges nobody rather than a stranger', (t) async {
    final twins = [
      _entry(rank: 1, first: 'Daniel', last: 'Emeh'),
      _entry(rank: 2, first: 'Daniel', last: 'Emeh'),
    ];
    await _pump(t, LeaderboardList(entries: twins, currentUserName: 'Daniel Emeh'));
    expect(find.text('You'), findsNothing);
  });

  testWidgets('referral counts are not shown on the public board', (t) async {
    await _pump(t, LeaderboardList(entries: board, currentUserName: 'Daniel Emeh'));
    expect(find.textContaining('referrals'), findsNothing,
        reason: 'how many people someone referred is private');
    expect(find.textContaining('5'), findsNothing,
        reason: 'the raw count must not leak in any form');
  });

  testWidgets('whitespace and case in the cached name still match', (t) async {
    await _pump(t, LeaderboardList(entries: board, currentUserName: '  daniel emeh '));
    expect(find.text('You'), findsOneWidget);
  });
}
