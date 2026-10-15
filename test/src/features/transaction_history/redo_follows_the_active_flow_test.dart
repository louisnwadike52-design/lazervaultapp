import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// "Redo" must open whichever send-funds flow the user is actually on.
///
/// There are two flows — the short one (quick-send sheet) and the long one
/// (initiate → confirm → receipt) — chosen by send_funds_short_flow_enabled.
/// SendFundsLauncher.open is the ONE place that decision is made, and it does
/// more than pick a route: it uses offNamedUntil(_isCleanBase) so a stale send
/// route can never be left on the stack and the two flows can never coexist.
///
/// A Redo that navigates straight to a send screen would therefore do two
/// wrong things at once — ignore the user's flow, and bypass the stack
/// cleanup. This is a SOURCE-level check because the defect would be the
/// ABSENCE of a call: no stub round-trip can notice a branch nobody wrote.
void main() {
  final root = Directory('lib/src/features');

  /// Files that render a "Redo" / "Repeat" control.
  List<File> redoSurfaces() => root
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .where((f) {
        final s = f.readAsStringSync();
        return s.contains("'Redo'") || s.contains('"Redo"');
      })
      .toList();

  test('there are Redo surfaces to check', () {
    // If this ever finds nothing, the test below is passing vacuously.
    expect(redoSurfaces(), isNotEmpty,
        reason: 'no Redo controls found — has the label been renamed? '
            'Update this guard rather than deleting it.');
  });

  test('no Redo surface navigates to a send screen itself', () {
    final offenders = <String>[];
    for (final f in redoSurfaces()) {
      final src = f.readAsStringSync();
      // A NAVIGATION CALL to a send destination, not a mention of one.
      //
      // The first cut matched any occurrence of the route constant and
      // flagged transfer_receipt_screen.dart, which lists exactly these
      // routes in `_sendFlowRoutes` — the set it must never fall BACK into.
      // Naming a route to avoid it is the opposite of navigating to it, and a
      // guard that cannot tell the difference trains people to delete it.
      final navToSend = RegExp(
        r'(?:toNamed|offNamed|offNamedUntil|offAllNamed)\s*\(\s*'
        r'AppRoutes\.(initiateSendFunds|quickSend)\b',
      );
      for (final m in navToSend.allMatches(src)) {
        offenders.add('${f.path} → AppRoutes.${m.group(1)}');
      }
    }
    expect(offenders, isEmpty,
        reason: 'these must call SendFundsLauncher.open (directly or via '
            'RepeatTransfer) instead:\n${offenders.join('\n')}');
  });

  test('the launcher is the only place the flow is chosen', () {
    final launcher =
        File('lib/src/features/funds/presentation/send_funds_launcher.dart');
    expect(launcher.existsSync(), isTrue);
    final src = launcher.readAsStringSync();

    // It must BRANCH on the active flow, not merely mention it.
    //
    // Asserting on the name alone passed when the condition was replaced with
    // `if (false)`, because the doc comment above also names the flag — the
    // guard was reading prose. The branch is the behaviour.
    expect(
      RegExp(r'if\s*\(\s*FeatureFlags\.sendFlowShortForSession\s*\)')
          .hasMatch(src),
      isTrue,
      reason: 'the launcher stopped branching on the active flow — every '
          'Redo, chat send and QR send would silently pick one form',
    );

    // ...and clean the stack rather than pushing onto a live send screen.
    expect(src.contains('offNamedUntil'), isTrue,
        reason: 'the launcher must replace any stale send route, or the two '
            'flows can coexist on the stack');
  });

  test('RepeatTransfer reconstructs once, for every surface that repeats', () {
    final f = File('lib/src/features/transaction_history/utils/'
        'repeat_transfer.dart');
    expect(f.existsSync(), isTrue);
    final src = f.readAsStringSync();
    // The rail inference, the principal-not-principal+fee amount and the
    // payee's stamped id live here precisely so the sheet and the receipt
    // cannot drift apart. If this stops going through the launcher, they do.
    expect(src.contains('SendFundsLauncher.open'), isTrue,
        reason: 'RepeatTransfer must route through the launcher so a repeat '
            'follows the active flow');
  });
}
