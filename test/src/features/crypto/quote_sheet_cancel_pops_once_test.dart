import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Cancelling a crypto quote must close the SHEET, not the screen under it.
///
/// The Cancel button called `onCancelled` — whose implementation popped the
/// sheet — and then popped again itself. Two pops: the first dismissed the
/// quote sheet, the second dismissed the Swap screen beneath it. So a user who
/// wanted to change an amount was thrown back to the crypto landing page and
/// had to walk into Swap again.
///
/// A widget test would need a live CryptoCubit (repositories, network); the
/// defect is a structural one — who owns the pop — so it is pinned
/// structurally, with comments stripped so the test cannot pass by matching
/// its own explanation.
String _codeOf(String path) {
  final raw = File(path).readAsStringSync();
  return raw
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');
}

void main() {
  const path =
      'lib/src/features/crypto/presentation/widgets/quote_timer_card.dart';

  test('the Cancel button does not pop twice', () {
    final code = _codeOf(path);
    final cancelIdx = code.indexOf("child: const Text('Cancel')");
    expect(cancelIdx, greaterThan(0), reason: 'Cancel button moved');

    // The handler is the ~30 lines above the label.
    final start = code.lastIndexOf('onPressed:', cancelIdx);
    final handler = code.substring(start, cancelIdx);

    final popCalls = RegExp(r'\.pop\(\)|maybePop\(\)')
        .allMatches(handler)
        .length;
    expect(popCalls, lessThanOrEqualTo(1),
        reason: 'the handler performs $popCalls pops; the second one closes '
            'the swap screen under the sheet');
  });

  test('the sheet host does not also pop on cancel', () {
    // Both popping is the same bug arriving from the other side.
    final code = _codeOf(path);
    final hostIdx = code.indexOf('onCancelled: () {');
    expect(hostIdx, greaterThan(0), reason: 'sheet host handler moved');
    final end =
        (hostIdx + 200) < code.length ? hostIdx + 200 : code.length;
    final host = code.substring(hostIdx, end);
    expect(host.contains('.pop('), isFalse,
        reason: 'the card owns the single pop; popping here too closes the '
            'screen beneath the sheet');
  });
}
