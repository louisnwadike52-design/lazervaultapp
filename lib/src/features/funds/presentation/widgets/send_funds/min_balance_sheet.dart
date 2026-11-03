import 'package:flutter/material.dart';

import 'package:lazervault/core/shared_widgets/server_refusal_sheet.dart';
import 'package:lazervault/src/features/funds/domain/min_balance_policy.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/spendable_service_links.dart';

/// "Your wallet has to keep a minimum" — said once, used by every transfer flow.
///
/// WHY A SHEET AND NOT A RED LINE. This is the same judgement the insufficient-
/// funds sheet already records: a REFUSAL is not a validation hint. The figures
/// matter (the floor, what can still be sent), the user cannot fix it by
/// retyping, and the useful next step is not "correct this field" — it is
/// either send less or spend the balance on something the floor allows. A line
/// of red text under the field offers none of that.
///
/// WHY IT NAMES WHAT THE MONEY IS STILL FOR. The whole point of the policy is
/// that the retained balance is not frozen — it buys airtime, data, bills, gift
/// cards and crypto. Without saying so, "you can't transfer this" reads as the
/// money being locked, which is the opposite of true and the complaint this
/// would otherwise generate.
///
/// The ADMIN MAY REPLACE THE WHOLE SENTENCE (`..._message`), so the wording
/// below is a fallback, not policy. It is kept in step with the server's
/// fallback in microservices/shared/minbalance — two copies of a money message
/// written
/// separately drift, so if one changes the other should.

/// Builds the body text. Pure, so it can be tested and so the two flows cannot
/// render different sentences for the same refusal.
String minBalanceMessage({
  required String currencySymbol,
  required int minimumMinor,
  required int maxSendableMinor,
  String adminMessage = '',
  MinBalanceAction action = MinBalanceAction.transfer,
  bool grantRestricted = false,
}) {
  if (adminMessage.trim().isNotEmpty) return adminMessage.trim();

  // formatMinorForCopy, not a local NumberFormat: the server's fallback
  // sentence reaches older builds as a snackbar and must read the same as this
  // dialog. See its doc comment for the format that won.
  final floor = '$currencySymbol${formatMinorForCopy(minimumMinor)}';

  // THE BONUS IS NOT A FLOOR, and must not be described as one.
  //
  // Both constraints retain money, so they share this sheet — but their
  // REASONS are opposite. The operator's floor is a rule about the customer's
  // own balance. The grant is money we gave them, conditionally. Saying "your
  // wallet needs to keep at least ₦2,000" to someone we handed ₦2,000 reads as
  // their own savings being held hostage, which is the complaint this branch
  // exists to prevent. Mirrors the grant branch of `Policy.RefusalMessage` in
  // microservices/shared/minbalance so the dialog and the server's snackbar
  // backstop say the same thing.
  if (grantRestricted) {
    if (maxSendableMinor <= 0) {
      // "moved out", with no action verb. The server's version of this
      // sentence spliced the verb in and rendered "can't be transfern out";
      // the verb-free wording is correct for a transfer and a withdrawal
      // alike, and both sides now use it.
      return 'Your $floor welcome bonus is for spending on Lazervault, so it '
          "can't be moved out.\n\n"
          'Use it for airtime, data, bills, gift cards or crypto — and '
          'anything you add yourself stays free to move.';
    }
    final own = '$currencySymbol${formatMinorForCopy(maxSendableMinor)}';
    return 'Your $floor welcome bonus is for spending on Lazervault, so you '
        'can ${action.verb} up to $own of your own money right now.\n\n'
        'The bonus itself works for airtime, data, bills, gift cards and '
        'crypto.';
  }

  if (maxSendableMinor <= 0) {
    // Nothing can be sent, so do NOT offer "you can transfer up to ₦0" —
    // an offer of nothing reads as a bug.
    return 'Your wallet needs to keep at least $floor, so this ${action.noun} '
        "can't go through right now.\n\n"
        'That balance is still yours to spend on Lazervault — airtime, data, '
        'bills, gift cards and crypto all work as normal.';
  }
  final headroom = '$currencySymbol${formatMinorForCopy(maxSendableMinor)}';
  return 'Your wallet needs to keep at least $floor, so you can ${action.verb} '
      'up to $headroom right now.\n\n'
      'The rest stays available on Lazervault — airtime, data, bills, gift '
      'cards and crypto all work as normal.';
}

/// Shows the refusal. Returns when dismissed.
///
/// [onSendMax] is offered only when something CAN still be sent: an action
/// button that cannot do anything is worse than no button. When present it
/// should set the amount field to [maxSendableMinor] so the user's next tap
/// succeeds rather than landing them back here.
Future<void> showMinBalanceRefusal(
  BuildContext context, {
  required String currencySymbol,
  required MinBalancePolicy policy,
  required int availableMinor,
  int feeMinor = 0,
  VoidCallback? onSendMax,
  MinBalanceAction action = MinBalanceAction.transfer,
}) async {
  final maxSendable = policy.maxSendableMinor(
    availableMinor: availableMinor,
    feeMinor: feeMinor,
  );
  final canSendSomething = maxSendable > 0;

  // THE TWO WAYS OUT, shown rather than described.
  //
  // Depositing is the only action that changes this outcome — the floor is on
  // what REMAINS, so every naira added is a naira that can leave. Everything
  // else the balance is good for is listed under it, because "you can still
  // spend this on Lazervault" is a claim the customer has no way to act on
  // from a dead-end sheet.
  //
  // Deposit goes FIRST: it answers "how do I send this?", which is the
  // question they actually asked.
  final links = <RefusalLink>[
    depositLink(),
    ...buildSpendableServiceLinks(context),
  ];

  await showServerRefusal(
    context,
    links: links,
    // The title names the actual reason. "Minimum wallet balance" over a
    // bonus explanation is the same confiscation reading the body text goes
    // out of its way to avoid, restated in bold at the top.
    title: policy.grantRestricted
        ? 'Your welcome bonus'
        : 'Minimum wallet balance',
    message: minBalanceMessage(
      currencySymbol: currencySymbol,
      minimumMinor: policy.minimumMinor,
      maxSendableMinor: maxSendable,
      adminMessage: policy.message,
      action: action,
      grantRestricted: policy.grantRestricted,
    ),
    // Two facts, both of which the customer needs and neither of which the
    // main sentence should carry: that nothing was taken (the first worry on
    // seeing a refusal), and that topping up is what raises the limit. The
    // floor is on what REMAINS, so every naira deposited is a naira that can
    // leave — which is not obvious and is the difference between "this app
    // is holding my money" and "I need to add some first".
    hint: policy.grantRestricted
        // For the grant the reassurance is different and more important: the
        // bonus does not touch their own money. Repeating the floor's "the
        // limit is on what stays in your wallet" here would imply it does.
        ? 'Nothing has been sent. The bonus never blocks your own money — '
            'anything you add is free to ${action.verb} out straight away.'
        : 'Nothing has been sent. Adding money raises how much you can '
            '${action.verb} — the limit is on what stays in your wallet, not '
            'on what you put in.',
    // Only offered when it would do something. `showServerRefusal` renders no
    // button when the label is null, which is the honest state here.
    // The verb matches the flow: "Withdraw ₦475 instead" on the withdraw
    // screen, "Send ₦975 instead" on a transfer. Capitalised from the action so
    // adding a third flow cannot leave the button saying the wrong thing.
    actionLabel: canSendSomething && onSendMax != null
        ? '${_capitalise(action.verb)} $currencySymbol'
            '${formatMinorForCopy(maxSendable)} instead'
        : null,
    onAction: canSendSomething ? onSendMax : null,
  );
}

String _capitalise(String s) =>
    s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
