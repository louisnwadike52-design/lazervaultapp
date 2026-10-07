import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The auto-refresher drives a timer and a lifecycle observer. Both leak if a
/// screen forgets to tear them down, and a leaked observer keeps a disposed
/// State alive and polling behind whatever the user navigated to.
///
/// A widget test per receipt would need each screen's whole dependency graph,
/// so this pins the invariant at the source instead: every screen that STARTS
/// it must also DISPOSE it, and must mix in WidgetsBindingObserver.
void main() {
  final screens = Directory('lib/src/features')
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .where((f) => f.readAsStringSync().contains('startBillStatusAutoRefresh'))
      .toList();

  test('the auto-refresher is actually used somewhere', () {
    // A scan that silently matches nothing proves nothing.
    expect(screens, isNotEmpty,
        reason: 'no receipt starts the auto-refresher — either it was removed '
            'or this scan is looking in the wrong place');
  });

  test('every screen that starts the refresher also disposes it', () {
    final leaking = <String>[];
    for (final f in screens) {
      final src = f.readAsStringSync();
      if (!src.contains('disposeBillStatusAutoRefresh')) {
        leaking.add(f.path);
      }
    }
    expect(leaking, isEmpty,
        reason: 'a leaked lifecycle observer keeps a disposed State alive and '
            'polling behind whatever the user navigated to');
  });

  test('every consumer mixes in WidgetsBindingObserver', () {
    // Without it the mixin cannot pause on background, so an app left open
    // overnight polls all night.
    final missing = <String>[];
    for (final f in screens) {
      final src = f.readAsStringSync();
      if (!src.contains('WidgetsBindingObserver')) missing.add(f.path);
    }
    expect(missing, isEmpty);
  });

  test('no screen keeps a bespoke poller alongside the shared one', () {
    // internet_payment_receipt_screen had its own Timer.periodic(4s) that
    // polled while BACKGROUNDED and could stack requests. Two pollers on one
    // screen is worse than either alone.
    final doubled = <String>[];
    for (final f in screens) {
      // CODE only. The replacement is documented in a comment that names the
      // thing it replaced, and a scan that cannot tell prose from code reports
      // the fix as the defect.
      final code = f
          .readAsLinesSync()
          .where((l) {
            final t = l.trimLeft();
            return !t.startsWith('//') && !t.startsWith('///') &&
                !t.startsWith('*') && !t.startsWith('/*');
          })
          .join('\n');
      if (code.contains('Timer.periodic')) doubled.add(f.path);
    }
    expect(doubled, isEmpty,
        reason: 'a second poller on a screen that already has the shared one');
  });

  test('the comment-stripping scan still detects a real second poller', () {
    // Without this, tightening the scan above could have silenced it entirely
    // and the test would pass for the wrong reason.
    const withComment = '''
// Replaces a bespoke Timer.periodic(4s) that polled while backgrounded.
void good() {}
''';
    const withCode = '''
// A comment mentioning nothing in particular.
  _timer = Timer.periodic(const Duration(seconds: 4), (_) {});
''';
    String stripped(String src) => src
        .split('\n')
        .where((l) {
          final t = l.trimLeft();
          return !t.startsWith('//') && !t.startsWith('///') &&
              !t.startsWith('*') && !t.startsWith('/*');
        })
        .join('\n');
    expect(stripped(withComment).contains('Timer.periodic'), isFalse);
    expect(stripped(withCode).contains('Timer.periodic'), isTrue);
  });
}
