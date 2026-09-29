import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// A crypto receipt must never assert a terminal status it did not hear from
/// the backend.
///
/// WHAT HAPPENED
/// -------------
/// crypto_processing_screen built its receipt with a literal
/// `status: CryptoTransactionStatus.completed`. The submit RPC returning
/// success means the order was ACCEPTED — for a buy that is swap_pending, which
/// then runs through Quidax and a reconciler to completed/delivered, or to
/// failed. A real production buy took five minutes. Throughout that window the
/// receipt announced a completed trade the user did not have, while the history
/// list, reading the real status, correctly showed Processing.
///
/// It also disabled its own cure. CryptoReceiptScreen polls every 4s until the
/// swap resolves, but computes `_terminal` from the status it is HANDED — so a
/// receipt born "completed" was terminal at birth, the poller never ran, and
/// the badge could never correct itself. Holdings and history were never
/// refreshed either, because that happens when the poll sees a terminal state.
///
/// WHY A SOURCE SCAN
/// -----------------
/// The bug was one literal in one constructor, reachable only by driving a real
/// trade through a live backend. A widget test would need the whole flow to
/// reproduce it; a grep states the invariant directly and costs nothing. Same
/// approach as no_dead_controls_app_wide_test.
void main() {
  test('no crypto surface hardcodes a terminal receipt status', () {
    // Terminal = anything that stops CryptoReceiptScreen from polling. Pending
    // and verifying are fine: they keep the poller alive and self-correct.
    const terminal = ['completed', 'failed', 'refunded'];

    final offenders = <String>[];
    final dir = Directory('lib/src/features/crypto');
    if (!dir.existsSync()) {
      fail('lib/src/features/crypto not found — did the feature move?');
    }

    for (final f in dir.listSync(recursive: true).whereType<File>()) {
      if (!f.path.endsWith('.dart')) continue;
      final lines = f.readAsLinesSync();
      for (var i = 0; i < lines.length; i++) {
        final line = lines[i];
        // Only the receipt's own `status:` argument. A local variable or a
        // comparison against the enum is not an assertion about a trade.
        if (!line.contains('status: CryptoTransactionStatus.')) continue;
        final isTerminal =
            terminal.any((t) => line.contains('CryptoTransactionStatus.$t'));
        if (!isTerminal) continue;
        // A ternary that CHOOSES a terminal value from real state is correct —
        // that is what crypto_confirmation_screen and swap_flow_dispatcher do.
        // The whole expression may wrap, so look at a small window.
        final window = lines
            .sublist(i, (i + 4).clamp(0, lines.length))
            .join(' ');
        final derived = window.contains('?') ||
            window.contains('mapBackendCryptoTxStatus') ||
            window.contains('_isTerminal');
        if (!derived) {
          offenders.add('${f.path}:${i + 1}: ${line.trim()}');
        }
      }
    }

    expect(
      offenders,
      isEmpty,
      reason: 'A receipt may only report a terminal status it actually heard '
          'from the backend — map it through mapBackendCryptoTxStatus, and '
          'default to pending when nothing has been heard. Offenders:\n'
          '${offenders.join('\n')}',
    );
  });

  test('the canonical mapper is what crypto surfaces use', () {
    // The mapper documents itself as the single source of truth. If the
    // processing screen stops importing it, the fix has been undone.
    final f = File(
        'lib/src/features/crypto/presentation/view/crypto_processing_screen.dart');
    expect(f.existsSync(), isTrue);
    final src = f.readAsStringSync();
    expect(
      src.contains('mapBackendCryptoTxStatus'),
      isTrue,
      reason: 'crypto_processing_screen must derive the receipt status from '
          'the backend through the canonical mapper, not assert one.',
    );
  });
}
