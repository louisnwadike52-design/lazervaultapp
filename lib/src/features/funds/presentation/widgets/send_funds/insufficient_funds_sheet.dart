import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/shared_widgets/server_refusal_sheet.dart';
import 'package:lazervault/core/types/app_routes.dart';

/// "You don't have enough" — said the same way in both send-funds flows.
///
/// WHY THIS IS SHARED
/// ------------------
/// The LONG flow already answered this properly: a sheet that stays until
/// dismissed, naming every figure, with an "Add money" button that goes
/// somewhere. The SHORT flow set a small red line under the amount field —
/// the same refusal, rendered as a validation hint, with nothing to do about
/// it. Reported as "we should have similar bottomsheet widget like this long
/// flow own for insufficient balance or other errors".
///
/// Both now call this. The wording lives here rather than in each flow,
/// because two copies of a money message written separately drift: the long
/// flow's fee variant names four figures and explains the arithmetic between
/// them, and a second implementation would have been a paraphrase.
///
/// The FEE VARIANT matters. "Insufficient balance" on a transfer whose amount
/// alone fits is baffling until you are told the fee pushed it over — so when
/// a fee is known it is named, added up, and compared out loud.

/// Builds the message both flows show. Pure, so the two can be compared.
///
/// [feeMajor] of 0 means no fee is known yet (no quote loaded, or an internal
/// transfer), in which case it is left out entirely rather than printed as
/// "₦0.00" — a zero fee line invites the question of whether it is really free
/// or merely unknown.
String insufficientFundsMessage({
  required String currencySymbol,
  required double amountMajor,
  required double feeMajor,
  required double availableMajor,
}) {
  final f = NumberFormat('#,##0.00');
  if (feeMajor > 0) {
    final total = amountMajor + feeMajor;
    return 'Insufficient balance. Amount ($currencySymbol${f.format(amountMajor)}) '
        '+ Fee ($currencySymbol${f.format(feeMajor)}) = '
        '$currencySymbol${f.format(total)} exceeds your balance of '
        '$currencySymbol${f.format(availableMajor)}';
  }
  return 'Your balance ($currencySymbol${f.format(availableMajor)}) is '
      'insufficient for this transfer of $currencySymbol${f.format(amountMajor)}. '
      'Please top up your account or use a different account.';
}

/// Shows the refusal, with the one action that resolves it.
///
/// "Nothing has been sent" is load-bearing: this fires before any money step,
/// and a refusal is the one case where the app can truthfully promise that.
Future<void> showInsufficientFunds(
  BuildContext context, {
  required String currencySymbol,
  required double amountMajor,
  required double feeMajor,
  required double availableMajor,
}) async {
  await showServerRefusal(
    context,
    title: 'Insufficient funds',
    message: insufficientFundsMessage(
      currencySymbol: currencySymbol,
      amountMajor: amountMajor,
      feeMajor: feeMajor,
      availableMajor: availableMajor,
    ),
    hint: 'Nothing has been sent.',
    actionLabel: 'Add money',
    onAction: () => Get.toNamed(AppRoutes.depositFunds),
  );
}
