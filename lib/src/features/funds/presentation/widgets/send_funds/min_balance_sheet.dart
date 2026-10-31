import 'package:flutter/material.dart';

import 'package:lazervault/core/shared_widgets/server_refusal_sheet.dart';
import 'package:lazervault/src/features/funds/domain/min_balance_policy.dart';

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
}) {
  if (adminMessage.trim().isNotEmpty) return adminMessage.trim();

  // formatMinorForCopy, not a local NumberFormat: the server's fallback
  // sentence reaches older builds as a snackbar and must read the same as this
  // dialog. See its doc comment for the format that won.
  final floor = '$currencySymbol${formatMinorForCopy(minimumMinor)}';

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

  await showServerRefusal(
    context,
    title: 'Minimum wallet balance',
    message: minBalanceMessage(
      currencySymbol: currencySymbol,
      minimumMinor: policy.minimumMinor,
      maxSendableMinor: maxSendable,
      adminMessage: policy.message,
      action: action,
    ),
    hint: 'Nothing has been sent.',
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
