import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/bills/presentation/utils/bills_back_navigation.dart';

/// Backing out of a utility landing screen must return the user to WHERE THEY
/// CAME FROM. Both entry points — the Bills Hub tile and the dashboard
/// quick-service tile — push, so the stack already holds the truthful answer.
///
/// The bug: every landing screen hardcoded `Get.offAllNamed(billsHub)`, so a
/// user who opened Airtime from the dashboard pressed back and arrived in
/// Bills Hub, a screen they had never visited, with the rest of their stack
/// discarded.
void main() {
  Widget harness() => GetMaterialApp(
        initialRoute: '/dashboard',
        getPages: [
          GetPage(name: '/dashboard', page: () => const Text('DASHBOARD')),
          GetPage(
              name: AppRoutes.billsHub, page: () => const Text('BILLS HUB')),
          GetPage(
            name: AppRoutes.airtime,
            page: () => Scaffold(
              body: Column(children: [
                const Text('AIRTIME'),
                TextButton(
                  onPressed: popBillsLandingScreen,
                  child: const Text('back'),
                ),
              ]),
            ),
          ),
        ],
      );

  testWidgets('from the DASHBOARD, back returns to the dashboard', (t) async {
    await t.pumpWidget(harness());
    await t.pumpAndSettle();
    expect(find.text('DASHBOARD'), findsOneWidget);

    Get.toNamed(AppRoutes.airtime); // the dashboard quick-service tile pushes
    await t.pumpAndSettle();
    expect(find.text('AIRTIME'), findsOneWidget);

    await t.tap(find.text('back'));
    await t.pumpAndSettle();

    expect(find.text('DASHBOARD'), findsOneWidget,
        reason: 'opened from the dashboard, so back belongs to the dashboard');
    expect(find.text('BILLS HUB'), findsNothing,
        reason: 'the user never opened Bills Hub — landing there is the bug');
  });

  testWidgets('from BILLS HUB, back returns to Bills Hub', (t) async {
    await t.pumpWidget(harness());
    await t.pumpAndSettle();

    Get.toNamed(AppRoutes.billsHub); // the hub
    await t.pumpAndSettle();
    Get.toNamed(AppRoutes.airtime); // its tile pushes
    await t.pumpAndSettle();
    expect(find.text('AIRTIME'), findsOneWidget);

    await t.tap(find.text('back'));
    await t.pumpAndSettle();

    expect(find.text('BILLS HUB'), findsOneWidget,
        reason: 'opened from the hub, so back belongs to the hub');
  });

  testWidgets('deep-linked with nothing to pop, falls back to the hub',
      (t) async {
    await t.pumpWidget(GetMaterialApp(
      // Straight into the service, as a notification deep link does.
      initialRoute: AppRoutes.airtime,
      getPages: [
        GetPage(name: AppRoutes.billsHub, page: () => const Text('BILLS HUB')),
        GetPage(
          name: AppRoutes.airtime,
          page: () => Scaffold(
            body: TextButton(
              onPressed: popBillsLandingScreen,
              child: const Text('back'),
            ),
          ),
        ),
      ],
    ));
    await t.pumpAndSettle();

    await t.tap(find.text('back'));
    await t.pumpAndSettle();

    expect(find.text('BILLS HUB'), findsOneWidget,
        reason: 'nothing to pop, so the service hub is the sensible parent');
  });

  testWidgets('an already-handled OS back does not pop a second route',
      (t) async {
    await t.pumpWidget(harness());
    await t.pumpAndSettle();
    Get.toNamed(AppRoutes.billsHub);
    await t.pumpAndSettle();
    Get.toNamed(AppRoutes.airtime);
    await t.pumpAndSettle();

    // didPop == true means the framework already popped. Acting again would
    // take the user off a screen they never asked to leave.
    onBillsLandingPopInvoked(true);
    await t.pumpAndSettle();

    expect(find.text('AIRTIME'), findsOneWidget,
        reason: 'nothing further should happen when the pop already occurred');
  });
}
