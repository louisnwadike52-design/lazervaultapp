import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The Lazerfunds list flickered because a failing thumbnail rebuilt it
/// continuously.
///
/// `errorBuilder` runs on EVERY build of a failing image, not once per
/// failure. It called `_retry()` each time, and `_retry()` scheduled a timer
/// each time — each timer evicted the image cache and called setState, which
/// caused the next build, which scheduled another timer. One broken cover in
/// a list of funds was enough.
///
/// The give-up branch made it worse: it called `setState` SYNCHRONOUSLY from
/// inside `errorBuilder`, i.e. during the build phase, which Flutter services
/// by scheduling another build straight into the same errorBuilder.
///
/// Source-level because the defect is about WHEN a call happens relative to
/// the build phase, which a widget test cannot distinguish from a correct
/// retry without driving real network failures.
void main() {
  const path =
      'lib/src/features/uplift/presentation/widgets/uplift_widgets.dart';

  String bodyOf(String marker, String src) {
    final i = src.indexOf(marker);
    expect(i, greaterThan(-1), reason: '$marker moved; re-point this guard');
    return src.substring(i, (i + 1400).clamp(0, src.length));
  }

  final raw = File(path).readAsStringSync();
  // Comments explain this defect and quote the old code, so a raw scan would
  // match its own explanation.
  final src = raw
      .split('\n')
      .where((l) =>
          !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
      .join('\n');

  test('a retry is scheduled once per failure, not once per build', () {
    final body = bodyOf('void _retry() {', src);
    expect(body, contains('_retryPending'),
        reason: 'without an in-flight guard, every rebuild of a failing image '
            'queues another timer and the list rebuilds forever');
    expect(body, contains('if (_givenUp || _retryPending) return;'),
        reason: 'the guard must be the FIRST thing _retry does, before any '
            'scheduling');
  });

  test('_retry never calls setState during the build phase', () {
    final body = bodyOf('void _retry() {', src);
    // The give-up branch must defer. Everything inside _retry that changes
    // state has to run from a callback, never inline.
    final giveUp = body.indexOf('_attempt >= _delays.length');
    expect(giveUp, greaterThan(-1));
    final window = body.substring(giveUp, (giveUp + 420).clamp(0, body.length));
    expect(window, contains('addPostFrameCallback'),
        reason: '_retry is called FROM errorBuilder, i.e. during build — a '
            'synchronous setState there schedules another build into the same '
            'errorBuilder');
  });

  test('the retry timer is cancelled on dispose and on a url change', () {
    expect(src, contains('Timer? _retryTimer;'),
        reason: 'Future.delayed cannot be cancelled, so a retry fires into a '
            'row the user has already scrolled away');
    final dispose = bodyOf('void dispose() {', src);
    expect(dispose, contains('_retryTimer?.cancel();'));
    final didUpdate = bodyOf('void didUpdateWidget(covariant UpRemoteImage', src);
    expect(didUpdate, contains('_retryTimer?.cancel();'),
        reason: 'a new url must not inherit the previous one\'s pending retry');
    expect(didUpdate, contains('_retryPending = false;'));
  });

  test('the attempts are still bounded', () {
    // The guard above must not have been satisfied by removing the retry.
    expect(src, contains('static const _delays = ['));
    expect(src, contains('_givenUp'),
        reason: 'a permanently broken url must end at the fallback rather '
            'than retrying forever');
  });

  test('the comment strip actually strips (self-check)', () {
    const sample = '// _retryPending\n  final x = 1;\n';
    final stripped = sample
        .split('\n')
        .where((l) => !l.trimLeft().startsWith('//'))
        .join('\n');
    expect(stripped, isNot(contains('_retryPending')));
    expect(stripped, contains('final x = 1;'));
  });
}
