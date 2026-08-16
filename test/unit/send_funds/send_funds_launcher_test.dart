import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/funds/presentation/send_funds_launcher.dart';

/// Locks in the stack-clean rule behind [SendFundsLauncher] (via
/// `Get.offNamedUntil(_isCleanBase)`) that prevents the long and short send
/// flows from ever coexisting — the root cause of the "long-flow amount page
/// flashes before the receipt" bug. We can't drive GetX navigation in a unit
/// test, so we exercise the pure predicate against representative stacks.
void main() {
  // Reproduce what offNamedUntil does: remove routes from the TOP down until the
  // stop-predicate is true, keeping that route as the base. `stack[0]` is the
  // root (isFirst == true). Returns the surviving base stack; the fresh flow
  // route is then pushed on top of it.
  List<String?> unwind(List<String?> stack) {
    final kept = List<String?>.from(stack);
    while (kept.isNotEmpty) {
      final top = kept.length - 1;
      if (SendFundsLauncher.isCleanBaseRoute(kept[top], top == 0)) break;
      kept.removeLast();
    }
    return kept;
  }

  group('isCleanBaseRoute', () {
    test('stops at a named non-send page (dashboard)', () {
      expect(SendFundsLauncher.isCleanBaseRoute(AppRoutes.dashboard, false),
          isTrue);
    });

    test('does NOT stop at a send-flow route — it gets removed', () {
      expect(
          SendFundsLauncher.isCleanBaseRoute(AppRoutes.initiateSendFunds, false),
          isFalse);
      expect(
          SendFundsLauncher.isCleanBaseRoute(AppRoutes.selectRecipient, false),
          isFalse);
      expect(SendFundsLauncher.isCleanBaseRoute(AppRoutes.quickSend, false),
          isFalse);
      expect(SendFundsLauncher.isCleanBaseRoute(AppRoutes.transferProof, false),
          isFalse);
    });

    test('does NOT stop at an anonymous/transient sheet (null name)', () {
      expect(SendFundsLauncher.isCleanBaseRoute(null, false), isFalse);
    });

    test('always stops at the root, even a send route, so we never over-pop',
        () {
      expect(
          SendFundsLauncher.isCleanBaseRoute(AppRoutes.initiateSendFunds, true),
          isTrue);
      expect(SendFundsLauncher.isCleanBaseRoute(null, true), isTrue);
    });
  });

  group('stack unwinding on launch', () {
    test('THE BUG: short launched over a stale long screen + sheet → cleaned',
        () {
      // dashboard → initiateSendFunds(long, stale) → <repeat history sheet>
      final base = unwind([
        AppRoutes.dashboard,
        AppRoutes.initiateSendFunds,
        null, // anonymous "Repeat" bottom sheet the launch came from
      ]);
      // Everything above dashboard is removed; the short flow will sit directly
      // on dashboard — no long route left beneath it to flash on teardown.
      expect(base, [AppRoutes.dashboard]);
    });

    test('clean launch from dashboard leaves it untouched', () {
      expect(unwind([AppRoutes.dashboard]), [AppRoutes.dashboard]);
    });

    test('launch from a chat screen keeps the chat as the base', () {
      final base = unwind([AppRoutes.dashboard, AppRoutes.p2pChat]);
      expect(base.last, AppRoutes.p2pChat);
    });

    test('re-launch over an existing short flow drops the duplicate', () {
      final base = unwind([
        AppRoutes.dashboard,
        AppRoutes.selectRecipient,
        null,
      ]);
      expect(base, [AppRoutes.dashboard]);
    });

    test('a completed receipt beneath is removed on the next send', () {
      final base =
          unwind([AppRoutes.dashboard, AppRoutes.transferProof]);
      expect(base, [AppRoutes.dashboard]);
    });

    test('a stale transparent quick-send host is removed on the next send', () {
      final base = unwind([
        AppRoutes.dashboard,
        AppRoutes.p2pChat,
        AppRoutes.quickSend,
      ]);
      // quickSend is a send route → removed; the chat is the clean base.
      expect(base.last, AppRoutes.p2pChat);
    });
  });
}
