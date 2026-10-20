import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// TWO GAPS FOUND BY RE-WALKING THE TASK QUEUE, 2026-10-20.
///
/// Both are the same shape: something was BUILT but not CONNECTED, so it
/// looked done in the diff and did nothing at runtime.
///
///  1. `_cancelInFlight` on the split-bill detail screen was set when the
///     user confirmed a cancel and cleared when the result landed — and never
///     read to render anything. The confirm dialog pops before the request
///     starts, so the user was returned to an unchanged screen with no sign
///     anything was happening. The obvious response to that is to tap Cancel
///     again.
///
///  2. The chat agent's action chips navigate on `actionType == 'navigate'`
///     using a route chosen by the SERVER. The tile tap and the notification
///     deep link both refuse a service an admin has withdrawn or marked
///     unavailable; this third entry point did not, which is the
///     "hidden in one place, reachable in another" state that makes a gate
///     decorative.
///
/// Source-level because both defects are an absent call rather than a wrong
/// value, and there is no seam to drive. Comments are STRIPPED first: both
/// files now explain these bugs at length and name the very symbols being
/// searched for, so a raw-text scan would pass by matching its own
/// explanation — the mistake that made an earlier guard in this suite
/// useless until it was fixed the same way.
String _codeOnly(File f) {
  final out = <String>[];
  for (final line in f.readAsLinesSync()) {
    final t = line.trimLeft();
    if (t.startsWith('//') || t.startsWith('///')) continue;
    out.add(line);
  }
  return out.join('\n');
}

const _app = 'lib';

void main() {
  group('the split-bill Cancel CTA shows that it is working', () {
    final file = File('$_app/src/features/split_bills/presentation/view/'
        'split_bill_detail_screen.dart');

    test('the file is where this guard expects it', () {
      expect(file.existsSync(), isTrue,
          reason: 'split_bill_detail_screen.dart moved; re-point this guard');
    });

    test('_cancelInFlight is READ, not just assigned', () {
      final code = _codeOnly(file);
      // The whole defect: it was written in two places and read in none.
      expect(code.contains('onPressed: _cancelInFlight'), isTrue,
          reason: 'the Cancel button no longer disables itself while the '
              'cancel is in flight, so it can be tapped twice');
      expect(code.contains("_cancelInFlight ? 'Cancelling…' : 'Cancel'"), isTrue,
          reason: 'the Cancel button no longer shows progress. The confirm '
              'dialog pops before the request starts, so with no state here '
              'the user sees an unchanged screen and taps again');
      expect(code.contains('icon: _cancelInFlight'), isTrue,
          reason: 'the spinner is gone from the Cancel button');
    });

    test('and it is still cleared when the result lands', () {
      final code = _codeOnly(file);
      expect(code.contains('_cancelInFlight = false'), isTrue,
          reason: 'without the reset the button stays stuck in Cancelling… '
              'for the life of the screen');
    });

    test('Remove from my list keeps its own loading state', () {
      // The pair must behave alike; this one was already correct and is the
      // pattern the Cancel fix mirrors.
      final code = _codeOnly(file);
      expect(code.contains('onPressed: _removeInFlight'), isTrue);
      expect(code.contains("_removeInFlight ? 'Removing…'"), isTrue);
    });
  });

  group('a withdrawn service is not reachable from a chat action chip', () {
    final file = File('$_app/src/features/ai_chats/presentation/widgets/'
        'ai_chat_content.dart');

    test('the file is where this guard expects it', () {
      expect(file.existsSync(), isTrue,
          reason: 'ai_chat_content.dart moved; re-point this guard');
    });

    test('the navigate branch consults the gate before navigating', () {
      final code = _codeOnly(file);
      final i = code.indexOf("btn.actionType == 'navigate'");
      expect(i, greaterThan(-1),
          reason: 'the navigate action branch is gone; re-point this guard');

      // Everything between the branch and its Get.toNamed must contain the
      // check. Asserting mere presence in the file would pass even if the
      // guard sat AFTER the navigation, which would do nothing.
      final branch = code.substring(i);
      final navAt = branch.indexOf('Get.toNamed(btn.payload)');
      expect(navAt, greaterThan(-1));
      final beforeNav = branch.substring(0, navAt);

      expect(beforeNav.contains('serviceForRoute(btn.payload)'), isTrue,
          reason: 'the route is no longer mapped to a service, so the gate '
              'cannot be consulted at all');
      expect(beforeNav.contains('quickServiceEntryBlocked'), isTrue,
          reason: 'a chat chip can navigate into a service an admin has '
              'withdrawn. The payload is a route chosen by the server');
      expect(beforeNav.contains('showServiceUnavailableModal'), isTrue,
          reason: 'the refusal is silent. A chip that does nothing reads as '
              'the app ignoring the user');
      expect(beforeNav.contains('return;'), isTrue,
          reason: 'the gate does not stop the navigation — without the early '
              'return the modal shows AND the screen opens');
    });

    test('it uses the shared check, so it cannot drift from the tile', () {
      // quickServiceEntryBlocked folds in BOTH switches and the whitelist
      // override. Re-implementing the test here is how the two entry points
      // end up disagreeing.
      final code = _codeOnly(file);
      expect(code.contains('FeatureFlags.quickServiceEntryBlocked'), isTrue);
      expect(code.contains('quickServiceVisible(') ||
              code.contains('quickServiceAvailable('),
          isFalse,
          reason: 'this screen is re-deriving the gate from the individual '
              'switches instead of asking the shared question, which is how '
              'it drifts from the tile and the notification path');
    });
  });
}
