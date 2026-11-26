import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/navigation/back_or_home.dart';
import 'package:lazervault/core/navigation/nav_stack.dart';
import 'package:lazervault/core/types/app_routes.dart';

/// THE ANDROID BACK BUTTON CLOSED THE APP.
///
/// Reported on tag pay: create a tag, land on the creation receipt, press the
/// phone's back button — and the app exits to the home screen. The in-app back
/// arrow on the same screen worked, which is why it went unnoticed for so
/// long.
///
/// The cause is `Get.offAllNamed(AppRoutes.tagPay)`. It is right about the
/// thing it was written for (the amount and processing screens must not be
/// behind the back button after a tag exists) and wrong about everything else,
/// because it leaves a stack of exactly ONE route. The OS back button, the
/// Android back gesture and the iOS edge swipe all pop the only route there
/// is.
///
/// It was not one screen. Roughly a hundred call sites across every quick
/// service did the same: bill receipts, processing screens, exchange, gift
/// cards, crowdfund, autosave, split bills, tag pay, transfers.
void main() {
  group('offAllKeepingHome', () {
    Widget app() => GetMaterialApp(
          initialRoute: AppRoutes.dashboard,
          navigatorObservers: [NavStackObserver()],
          getPages: [
            GetPage(
                name: AppRoutes.dashboard, page: () => const Text('dashboard')),
            GetPage(name: AppRoutes.tagPay, page: () => const Text('tagPay')),
            GetPage(
                name: AppRoutes.tagPaymentReceipt,
                page: () => const Text('receipt')),
          ],
        );

    setUp(() => NavStackObserver.debugSetStack(const []));

    testWidgets('leaves the dashboard under a finished flow', (t) async {
      await t.pumpWidget(app());
      await t.pumpAndSettle();

      Get.toNamed(AppRoutes.tagPay);
      await t.pumpAndSettle();
      Get.toNamed(AppRoutes.tagPaymentReceipt);
      await t.pumpAndSettle();

      offAllKeepingHome(AppRoutes.tagPay);
      await t.pumpAndSettle();

      expect(find.text('tagPay'), findsOneWidget);
      expect(Get.key.currentState!.canPop(), isTrue,
          reason: 'the OS back button must have somewhere to go — this is the '
              'exact state in which Android closed the app');

      // And the flow itself is gone: back goes HOME, not to the receipt.
      Get.key.currentState!.pop();
      await t.pumpAndSettle();
      expect(find.text('dashboard'), findsOneWidget);
      expect(find.text('receipt'), findsNothing,
          reason: 'a completed payment must not be re-enterable by going back');
    });

    testWidgets('builds a dashboard when there is none to keep', (t) async {
      // The cold-start deep-link case: the app opened straight onto a service
      // screen, so there is no dashboard to preserve. One is created rather
      // than leaving the user on a single-route stack.
      await t.pumpWidget(GetMaterialApp(
        initialRoute: AppRoutes.tagPay,
        navigatorObservers: [NavStackObserver()],
        getPages: [
          GetPage(
              name: AppRoutes.dashboard, page: () => const Text('dashboard')),
          GetPage(name: AppRoutes.tagPay, page: () => const Text('tagPay')),
        ],
      ));
      await t.pumpAndSettle();
      expect(NavStackObserver.contains(AppRoutes.dashboard), isFalse);

      offAllKeepingHome(AppRoutes.tagPay);
      await t.pumpAndSettle();

      expect(find.text('tagPay'), findsOneWidget);
      expect(Get.key.currentState!.canPop(), isTrue);
    });

    testWidgets('going home is still just going home', (t) async {
      await t.pumpWidget(app());
      await t.pumpAndSettle();
      Get.toNamed(AppRoutes.tagPay);
      await t.pumpAndSettle();

      offAllKeepingHome(AppRoutes.dashboard);
      await t.pumpAndSettle();

      expect(find.text('dashboard'), findsOneWidget);
      expect(Get.key.currentState!.canPop(), isFalse,
          reason:
              'the dashboard IS the root; back from it exits, as it should');
    });
  });

  group('no screen may empty the stack to reach another in-app screen', () {
    /// Routes that SHOULD clear the stack. Leaving a finished login, or a
    /// half-finished signup, behind the back button is a security problem, not
    /// a convenience — and the dashboard is the root, so resetting to it is
    /// the thing every other reset is measured against.
    bool mayClearTheStack(String arg) {
      const exact = {
        'AppRoutes.dashboard',
        "'/dashboard'",
        'AppRoutes.transactionPinSetup',
      };
      if (exact.contains(arg)) return true;
      // Auth, onboarding and identity, by prefix so a new screen in those
      // flows does not have to be added here.
      for (final r in const [
        'AppRoutes.loginEntry',
        'AppRoutes.freshLoginEntry',
        'AppRoutes.signIn',
        'AppRoutes.emailSignIn',
        'AppRoutes.passcodeLogin',
        'AppRoutes.phonePasscodeLogin',
        'AppRoutes.passcodeSetup',
        'AppRoutes.passwordRecovery',
        'AppRoutes.phoneEntry',
        'AppRoutes.signupEntry',
        'AppRoutes.emailVerification',
        'AppRoutes.phoneVerification',
        'AppRoutes.kycBVNVerification',
      ]) {
        if (arg.contains(r)) return true;
      }
      // Destinations computed at the call site are reviewed by hand; they are
      // named here so adding one is a deliberate act.
      const dynamic_ = {
        'route',
        'fallbackRoute',
        'widget.nextRoute!',
        '_nextRoute()',
        'next',
        'next.name',
        'dest.name',
        '_postResetRoute',
      };
      return dynamic_.contains(arg);
    }

    /// The first argument of a `Get.offAllNamed(` call starting at [open].
    String firstArg(String src, int open) {
      var depth = 1;
      var j = open;
      while (j < src.length && depth > 0) {
        final c = src[j];
        if (c == '(') {
          depth++;
        } else if (c == ')') {
          depth--;
        }
        j++;
      }
      final args = src.substring(open, j - 1);
      var d = 0;
      for (var k = 0; k < args.length; k++) {
        final c = args[k];
        if ('([{'.contains(c)) {
          d++;
        } else if (')]}'.contains(c)) {
          d--;
        } else if (c == ',' && d == 0) {
          return args.substring(0, k).trim();
        }
      }
      return args.trim();
    }

    test('every offAllNamed in lib/ either clears auth or keeps home', () {
      final offenders = <String>[];
      for (final f in Directory('lib')
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'))) {
        if (f.path.endsWith('core/navigation/back_or_home.dart')) continue;
        final src = f.readAsStringSync();
        // ANCHORED on purpose. An unanchored search matches the token inside
        // `offAllKeepingHome`'s own doc comment and inside a method named
        // something_Get.offAllNamed, and a guard that matches the fix is a
        // guard that cannot fail.
        final re = RegExp(r'(^|[^A-Za-z0-9_.])Get\.offAllNamed(<[^>]*>)?\(');
        for (final m in re.allMatches(src)) {
          final lineStart = src.lastIndexOf('\n', m.start) + 1;
          final before = src.substring(lineStart, m.start).trimLeft();
          if (before.startsWith('//') || before.startsWith('*')) continue;
          final arg = firstArg(src, m.end);
          if (mayClearTheStack(arg)) continue;
          final line = '\n'.allMatches(src.substring(0, m.start)).length + 1;
          offenders.add('${f.path}:$line  ->  $arg');
        }
      }
      expect(offenders, isEmpty,
          reason: 'Get.offAllNamed empties the navigator, so the phone back '
              'button closes the app on the screen it lands on. Use '
              'offAllKeepingHome(...) for an in-app destination:\n'
              '${offenders.join('\n')}');
    });

    test('every PopScope that refuses a pop says what happens instead', () {
      final offenders = <String>[];
      // A dialog or sheet is dismissed by its own code, not by the back
      // button, and the ones here all close in a `finally`.
      const modalShims = {
        'payment_receipt_shared.dart',
        'deposit_funds_screen.dart',
        'add_recipient.dart',
        'voice_pin_entry_dialog.dart',
        'bank_link_fee_mixin.dart',
        'bank_link_kyc_gate.dart',
        // Blocking every exit IS the feature: the app is below the minimum
        // supported build.
        'forced_update_screen.dart',
        // The KYC save overlay. Same shape as the entries above and the
        // clearest example of it: `runKycSave` pops it in a `finally`, so it
        // comes down on success, on a throw and on a timeout alike, and
        // kyc_saving_overlay_test asserts all three. A back press while an
        // identity field is being written has nothing to offer — the write
        // either lands or times out within a bounded wait, and letting the
        // customer leave mid-flight is how a screen resumes against a stale
        // profile and re-sends the value that was just corrected.
        'kyc_saving_overlay.dart',
      };
      for (final f in Directory('lib')
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'))) {
        if (modalShims.any(f.path.endsWith)) continue;
        final lines = f.readAsStringSync().split('\n');
        for (var i = 0; i < lines.length; i++) {
          if (!RegExp(r'^\s*canPop:\s*false\s*,').hasMatch(lines[i])) continue;
          final from = i - 8 < 0 ? 0 : i - 8;
          final to = i + 10 > lines.length ? lines.length : i + 10;
          final window = lines.sublist(from, to).join('\n');
          if (window.contains('onPopInvoked')) continue;
          offenders.add('${f.path}:${i + 1}');
        }
      }
      expect(offenders, isEmpty,
          reason: 'canPop: false with no onPopInvokedWithResult is a back '
              'button that silently does nothing:\n${offenders.join('\n')}');
    });
  });
}
