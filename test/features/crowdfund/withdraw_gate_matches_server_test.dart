import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The client must not refuse a withdrawal the SERVER would allow.
///
/// Reported as "no ways to withdraw the funds". canWithdraw required
/// `!isTerminal`, and isTerminal includes isCompleted — so a campaign that
/// REACHED ITS GOAL could never be withdrawn from. The creator raised the
/// money and the app gave them no way to take it out.
///
/// fp_crowdfund_withdraw.go is the authority and refuses exactly two statuses,
/// 'cancelling' and 'cancelled' (money is being drained back to contributors
/// from that same wallet). Everything else — completed, expired, active,
/// paused — is permitted subject to: creator, destination != campaign wallet,
/// sufficient funds.
void main() {
  late String src;

  setUpAll(() {
    src = File(
      'lib/src/features/crowdfund/presentation/views/'
      'crowdfund_details_screen.dart',
    ).readAsStringSync();
  });

  /// Only the body of _buildOwnerMoneyActions.
  ///
  /// Unscoped `contains` is how an assertion goes vacuous here: several of
  /// these expressions also appear in the overflow menu's gates, so a check
  /// against the whole file passes even when this function is wrong. That
  /// happened to the donorCount assertion below.
  String actionsBody() {
    final i = src.indexOf('Widget _buildOwnerMoneyActions(');
    expect(i, greaterThan(-1), reason: 'the on-page action row is gone');
    final end = src.indexOf('\n  Widget _moneyActionButton(', i);
    expect(end, greaterThan(i), reason: 'could not bound the function');
    return src.substring(i, end);
  }

  test('the server still refuses only cancelling/cancelled', () {
    // Pinned in the SAME test as the client gate: if the server rule moves,
    // the client gate has to move with it, and this fails until it does.
    final f = File(
      '../microservices/financial-products-service/'
      'financial-products-microservice/internal/service/'
      'fp_crowdfund_withdraw.go',
    );
    if (!f.existsSync()) {
      markTestSkipped('server source not present in this checkout');
      return;
    }
    expect(
      f.readAsStringSync(),
      contains(
          'crowdfund.Status == "cancelling" || crowdfund.Status == "cancelled"'),
      reason: 'the server rule moved; re-derive the client gate from it',
    );
  });

  test('the client gate does not block a COMPLETED campaign', () {
    expect(
        src,
        isNot(contains(
            '!isTerminal &&\n                    crowdfund.currentAmount > 0')),
        reason: 'isTerminal includes isCompleted — that gate locked creators '
            'out of money they had successfully raised');
  });

  test('the client gate blocks exactly what the server blocks', () {
    expect(src, contains('!crowdfund.isCancelling'));
    expect(src, contains('!crowdfund.isCancelled'));
    expect(src, contains('crowdfund.currentAmount > 0'),
        reason: 'offering a withdrawal with nothing to withdraw is a dead '
            'button the server would reject anyway');
  });

  test('withdraw and refund are reachable on the page once a campaign ends',
      () {
    expect(src, contains('Widget _buildOwnerMoneyActions('));
    expect(src, contains('_buildOwnerMoneyActions(crowdfund)'),
        reason: 'defining it without rendering it changes nothing');
    expect(src, contains("label: 'Withdraw'"));
    expect(src, contains("label: 'Refund all'"));
  });

  test('a non-owner, or a running campaign, gets no money actions', () {
    final body = actionsBody();
    expect(
        body,
        contains(
            'if (!_isCampaignCreator(crowdfund)) return const SizedBox.shrink();'));
    expect(body, contains('if (!ended) return const SizedBox.shrink();'),
        reason: 'while funding is live the overflow stays the home for these');
  });

  test('refunding is not offered when there is nobody to refund', () {
    // An expired campaign that raised nothing has no money to move and no
    // contributor to return it to. Scoped to the function: this same
    // expression appears in the overflow gates, so a file-wide check passed
    // even with the guard deleted.
    expect(actionsBody(), contains('crowdfund.donorCount > 0'));
  });
}
