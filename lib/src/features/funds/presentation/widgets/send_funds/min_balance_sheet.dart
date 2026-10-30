import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
/// fallback in transfer_min_balance.go — two copies of a money message written
/// separately drift, so if one changes the other should.

/// Builds the body text. Pure, so it can be tested and so the two flows cannot
/// render different sentences for the same refusal.
String minBalanceMessage({
  required String currencySymbol,
  required int minimumMinor,
  required int maxSendableMinor,
  String adminMessage = '',
}) {
  if (adminMessage.trim().isNotEmpty) return adminMessage.trim();

  final f = NumberFormat('#,##0.00');
  final floor = '$currencySymbol${f.format(minimumMinor / 100.0)}';

  if (maxSendableMinor <= 0) {
    // Nothing can be sent, so do NOT offer "you can transfer up to ₦0.00" —
    // an offer of nothing reads as a bug.
    return 'Your wallet needs to keep at least $floor, so this transfer '
        "can't go through right now.\n\n"
        'That balance is still yours to spend on Lazervault — airtime, data, '
        'bills, gift cards and crypto all work as normal.';
  }
  final headroom = '$currencySymbol${f.format(maxSendableMinor / 100.0)}';
  return 'Your wallet needs to keep at least $floor, so you can transfer up '
      'to $headroom right now.\n\n'
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
    ),
    hint: 'Nothing has been sent.',
    // Only offered when it would do something. `showServerRefusal` renders no
    // button when the label is null, which is the honest state here.
    actionLabel: canSendSomething && onSendMax != null
        ? 'Send ${NumberFormat('#,##0.00').format(maxSendable / 100.0)} instead'
        : null,
    onAction: canSendSomething ? onSendMax : null,
  );
}
