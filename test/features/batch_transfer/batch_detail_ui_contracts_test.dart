import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Two batch-transfer UI rules that are easy to half-apply, pinned at source.
///
/// Both are MISSING-code defects in a screen that needs the whole service
/// locator to pump, which is why they are checked this way rather than by
/// widget test.
void main() {
  String stripComments(String src) => src
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');

  final history = stripComments(File(
          'lib/src/features/funds/presentation/view/batch_transfer/batch_transfer_history_screen.dart')
      .readAsStringSync());
  final detail = stripComments(File(
          'lib/src/features/funds/presentation/view/batch_transfer/batch_transfer_detail_screen.dart')
      .readAsStringSync());

  test('the history list re-reads when you come back from a detail', () {
    // The detail screen is not read-only: a batch can finish, a leg can be
    // retried and a scheduled batch can be cancelled while it is open. With no
    // handler the tile at the top of the list kept describing a state the
    // batch had already left, and only a pull-to-refresh the user had no
    // reason to attempt would correct it.
    final at = history.indexOf('AppRoutes.batchTransferDetail');
    expect(at, greaterThan(-1), reason: 'the detail navigation moved');
    final around = history.substring(
        (at - 400).clamp(0, history.length), (at + 400).clamp(0, history.length));
    expect(around.contains('await Get.toNamed(AppRoutes.batchTransferDetail'),
        isTrue,
        reason: 'the navigation must be awaited or there is nothing to run '
            'on the way back');
    expect(around.contains('await _refresh();'), isTrue,
        reason: 'returning from the detail must re-read the list');
    expect(around.contains('if (!mounted) return;'), isTrue,
        reason: 'the user can leave the screen while the detail is open');
  });

  test('one avatar rule serves both places a recipient is drawn', () {
    // The card and the sheet had drifted: the card already had bank logos
    // while the sheet drew Icons.account_balance for EVERY external leg, so a
    // recipient was identifiable in the list and anonymous once opened.
    expect(detail.contains('Widget _recipientAvatar('), isTrue,
        reason: 'the shared helper is gone, so the two can drift again');
    expect('_recipientAvatar('.allMatches(detail).length, 3,
        reason: 'one definition plus exactly two call sites — the card and '
            'the per-recipient sheet');

    final i = detail.indexOf('Widget _recipientAvatar(');
    final body = detail.substring(i, (i + 1500).clamp(0, detail.length));

    // Precedence, in order: photo, then the destination bank, then Lazervault.
    final photoAt = body.indexOf('photo.isNotEmpty');
    final externalAt = body.indexOf('item.isExternal');
    final internalAt = body.indexOf("bankName: 'Lazervault'");
    expect(photoAt, greaterThan(-1),
        reason: 'a profile picture must take precedence when supplied');
    expect(externalAt, greaterThan(photoAt),
        reason: 'the bank logo must not win over the person\'s own picture');
    expect(internalAt, greaterThan(externalAt),
        reason: 'an internal leg shows the Lazervault mark, and only after '
            'the external branch has been considered');

    // A failed leg keeps its status glyph ahead of any identity.
    expect(body.indexOf('isFailed'), lessThan(photoAt),
        reason: 'a failed leg must still read as failed first');
  });

  test('the source card is resolved, not read straight off the response', () {
    expect(detail.contains('batchSourceAccountDisplay('), isTrue,
        reason: 'reading detail.sourceAccountName directly shows '
            'accounts.account_name, which is frozen at mint time and names '
            'the rail that minted the account first rather than the one '
            'issuing its number now');
    // And the old direct read must be gone from the card.
    final i = detail.indexOf('Widget _buildSourceCard(');
    final body = detail.substring(i, (i + 2200).clamp(0, detail.length));
    expect(body.contains('src.holder'), isTrue);
    expect(body.contains('detail.sourceAccountName.isNotEmpty'), isFalse,
        reason: 'the card fell back to the stale column again');
  });
}
