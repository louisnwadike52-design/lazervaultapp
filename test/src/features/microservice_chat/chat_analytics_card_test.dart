import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_analytics_card.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_analytics_charts.dart';

/// The analytics card renders a claim about the user's own money as a picture,
/// so these tests are mostly about what it must REFUSE to draw and what it must
/// never silently rescale.
///
/// Amounts arrive in MAJOR units (naira): `transactions.amount` is a
/// `numeric(_,2)` and the accounts-service analytics handlers pass it through
/// unscaled. A card that divided would report ₦288,088 as ₦2,880.88 — the same
/// class of error that read a ₦1,844 balance out as ₦18.44.

Map<String, dynamic> card({
  Map<String, dynamic>? totals,
  List<Map<String, dynamic>>? charts,
  String partialReason = '',
  String title = 'Your money',
}) =>
    {
      'title': title,
      'period_label': 'This Month',
      'currency': 'NGN',
      'totals': totals ??
          {
            'total_income': 274451.53,
            'total_expenses': 288088.00,
            'net': -13636.47,
            'transaction_count': 106,
          },
      'charts': charts ?? const [],
      if (partialReason.isNotEmpty) 'partial_reason': partialReason,
    };

Map<String, dynamic> donut() => {
      'kind': 'donut',
      'title': 'Where your money went',
      'unit': 'currency',
      'points': [
        {
          'label': 'Transfers',
          'value': 288088.0,
          'percentage': 62.0,
          'count': 74
        },
        {
          'label': 'Utilities',
          'value': 14505.22,
          'percentage': 38.0,
          'count': 49
        },
      ],
    };

Map<String, dynamic> line() => {
      'kind': 'line',
      'title': 'Money in vs money out',
      'unit': 'currency',
      'series_labels': ['Money in', 'Money out'],
      'points': [
        {'label': 'Aug', 'value': 10000.0, 'secondary': 4000.0},
        {'label': 'Sep', 'value': 7000.0, 'secondary': 9000.0},
      ],
    };

Future<void> pump(WidgetTester tester, Map<String, dynamic> payload) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: ChatAnalyticsCard(payload: payload),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 50));
}

void main() {
  group('amounts are shown as naira, never rescaled', () {
    testWidgets('the headline totals print at full precision', (tester) async {
      await pump(tester, card());
      expect(find.text('₦274,451.53'), findsOneWidget);
      expect(find.text('₦288,088.00'), findsOneWidget);
      // Net is shown as a magnitude under an "Ahead by"/"Behind by" label, so
      // the minus sign is carried by the WORD, not repeated on the number.
      expect(find.text('Behind by'), findsOneWidget);
      expect(find.text('₦13,636.47'), findsOneWidget);
    });

    testWidgets('a negative net is labelled behind, a positive one ahead',
        (tester) async {
      await pump(tester, card(totals: {'net': 5000.0, 'total_income': 5000.0}));
      expect(find.text('Ahead by'), findsOneWidget);
      expect(find.text('Behind by'), findsNothing);
    });

    testWidgets('compact form spells out the magnitude with a suffix',
        (_) async {
      // The "₦1,100, not ₦1.1" rule: shortening by division is only safe when a
      // suffix states the scale, so ₦1.1k can never be misread as ₦1.10.
      expect(analyticsMoneyCompact(1100, 'NGN'), '₦1.1k');
      expect(analyticsMoneyCompact(288088, 'NGN'), '₦288.1k');
      expect(analyticsMoneyCompact(1500000, 'NGN'), '₦1.5M');
      expect(analyticsMoneyCompact(2000000000, 'NGN'), '₦2.0B');
      // Below a thousand there is nothing to shorten, so it stays exact.
      expect(analyticsMoneyCompact(950, 'NGN'), '₦950');
      expect(analyticsMoneyCompact(-1100, 'NGN'), '-₦1.1k');
    });

    testWidgets('full form keeps kobo', (_) async {
      expect(analyticsMoney(1844.00, 'NGN'), '₦1,844.00');
      // The exact value that was once reported as ₦18.44.
      expect(analyticsMoney(1844.00, 'NGN'), isNot('₦18.44'));
    });
  });

  group('the card refuses to draw nothing', () {
    testWidgets('an entirely empty payload renders no card at all',
        (tester) async {
      await pump(
        tester,
        card(totals: {
          'total_income': 0,
          'total_expenses': 0,
          'net': 0,
          'transaction_count': 0
        }),
      );
      // The agent's sentence already said "nothing this month" in words; an
      // empty card under it would read as a widget that failed.
      expect(find.byType(Container), findsNothing);
      expect(find.text('This Month'), findsNothing);
    });

    testWidgets('totals with no charts still render', (tester) async {
      await pump(tester, card());
      expect(find.text('Money in'), findsOneWidget);
      expect(find.text('Money out'), findsOneWidget);
      expect(find.byType(PieChart), findsNothing);
    });

    testWidgets('a chart with no points is skipped, not drawn empty',
        (tester) async {
      await pump(
        tester,
        card(charts: [
          {'kind': 'donut', 'title': 'Nothing here', 'points': []},
        ]),
      );
      expect(find.text('Nothing here'), findsNothing);
      expect(find.byType(PieChart), findsNothing);
    });

    testWidgets('an unknown chart kind is skipped rather than guessed at',
        (tester) async {
      await pump(
        tester,
        card(charts: [
          {
            'kind': 'radar-from-the-future',
            'title': 'Mystery',
            'points': [
              {'label': 'a', 'value': 1.0}
            ],
          },
          donut(),
        ]),
      );
      // The unknown one vanishes; the known one still draws.
      expect(find.text('Mystery'), findsNothing);
      expect(find.text('Where your money went'), findsOneWidget);
      expect(find.byType(PieChart), findsOneWidget);
    });

    testWidgets('a point with no label is dropped, not labelled Unknown',
        (tester) async {
      await pump(
        tester,
        card(charts: [
          {
            'kind': 'donut',
            'title': 'Where your money went',
            'points': [
              {'value': 500.0},
              {'label': 'Named', 'value': 500.0},
            ],
          },
        ]),
      );
      expect(find.text('Named'), findsOneWidget);
      expect(find.text('Unknown'), findsNothing);
    });
  });

  group('charts render with their legends', () {
    testWidgets('the donut names each slice with its amount and share',
        (tester) async {
      await pump(tester, card(charts: [donut()]));
      expect(find.byType(PieChart), findsOneWidget);
      expect(find.text('Transfers'), findsOneWidget);
      expect(find.text('Utilities'), findsOneWidget);
      expect(find.text('62%'), findsOneWidget);
      // The total belongs in the hole — it is the denominator every slice is a
      // fraction of.
      expect(find.text('Total'), findsOneWidget);
    });

    testWidgets('the trend line names both series', (tester) async {
      await pump(tester, card(charts: [line()]));
      expect(find.byType(LineChart), findsOneWidget);
      expect(find.text('Money in vs money out'), findsOneWidget);
      // Two series with only one named is a mystery, not information.
      expect(find.text('Money in'), findsWidgets);
      expect(find.text('Money out'), findsWidgets);
    });

    testWidgets('a one-point trend is not drawn as a trend', (tester) async {
      await pump(
        tester,
        card(charts: [
          {
            'kind': 'line',
            'title': 'Money in vs money out',
            'points': [
              {'label': 'Sep', 'value': 10.0, 'secondary': 4.0}
            ],
          },
        ]),
      );
      // A single dot on an axis invites the reader to infer a direction the
      // data does not contain.
      expect(find.byType(LineChart), findsNothing);
    });

    testWidgets('a footnote naming what was folded is shown', (tester) async {
      final d = donut();
      d['footnote'] = '“Other” folds in 3 smaller categories.';
      await pump(tester, card(charts: [d]));
      expect(
          find.text('“Other” folds in 3 smaller categories.'), findsOneWidget);
    });
  });

  group('honesty about what is missing or unknown', () {
    testWidgets('a partial load says so instead of passing as complete',
        (tester) async {
      await pump(
        tester,
        card(
            charts: [donut()],
            partialReason: "Couldn't load the monthly trend."),
      );
      expect(find.text("Couldn't load the monthly trend."), findsOneWidget);
    });

    testWidgets('an absent change figure prints nothing, not 0%',
        (tester) async {
      await pump(tester, card());
      // No *_change_percent in the fixture: there was no previous period, and
      // "0%" would claim spending held steady on data that does not exist.
      expect(find.textContaining('%'), findsNothing);
    });

    testWidgets('a real change figure prints with a direction', (tester) async {
      await pump(
        tester,
        card(totals: {
          'total_income': 100.0,
          'total_expenses': 50.0,
          'net': 50.0,
          'transaction_count': 3,
          'income_change_percent': 12.0,
          'expense_change_percent': -8.0,
        }),
      );
      expect(find.text('▲ 12%'), findsOneWidget);
      expect(find.text('▼ 8%'), findsOneWidget);
    });

    testWidgets('sub-half-percent movement reads as level, not as a direction',
        (tester) async {
      await pump(
        tester,
        card(totals: {
          'total_income': 100.0,
          'total_expenses': 50.0,
          'net': 50.0,
          'transaction_count': 3,
          'income_change_percent': 0.2,
        }),
      );
      expect(find.text('about level'), findsOneWidget);
      expect(find.textContaining('▲'), findsNothing);
    });

    testWidgets('the transaction count is singular for one', (tester) async {
      await pump(
        tester,
        card(totals: {'total_expenses': 10.0, 'transaction_count': 1}),
      );
      expect(find.text('Across 1 transaction'), findsOneWidget);
    });

    testWidgets('and plural otherwise', (tester) async {
      await pump(tester, card());
      expect(find.text('Across 106 transactions'), findsOneWidget);
    });
  });

  group('malformed payloads degrade instead of crashing', () {
    testWidgets('string numbers are parsed', (tester) async {
      await pump(
        tester,
        card(totals: {
          'total_income': '5000.50',
          'total_expenses': '2000',
          'net': '3000.50',
          'transaction_count': '4',
        }),
      );
      expect(find.text('₦5,000.50'), findsOneWidget);
      expect(find.text('Across 4 transactions'), findsOneWidget);
    });

    testWidgets('a non-map totals value does not throw', (tester) async {
      await pump(tester, {
        'title': 'Your money',
        'period_label': 'This Month',
        'totals': 'not-a-map',
        'charts': [donut()],
      });
      expect(tester.takeException(), isNull);
      expect(find.byType(PieChart), findsOneWidget);
    });

    testWidgets('a non-list charts value does not throw', (tester) async {
      await pump(tester, {
        'title': 'Your money',
        'period_label': 'This Month',
        'totals': {'total_expenses': 10.0, 'transaction_count': 1},
        'charts': 'not-a-list',
      });
      expect(tester.takeException(), isNull);
      expect(find.text('Across 1 transaction'), findsOneWidget);
    });

    testWidgets('a missing currency falls back to naira', (tester) async {
      await pump(tester, {
        'title': 'Your money',
        'period_label': 'This Month',
        'totals': {'total_expenses': 1000.0, 'transaction_count': 1},
      });
      expect(find.text('₦1,000.00'), findsOneWidget);
    });
  });
}
