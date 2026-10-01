import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';

import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/server_refusal_sheet.dart';
import 'package:lazervault/src/features/family_account/presentation/widgets/family_spend_refusal_dialog.dart';
import 'package:lazervault/core/utils/friendly_error.dart';

/// How a bill purchase failed, from the app's point of view.
///
/// The three are handled differently because they need DIFFERENT THINGS FROM THE
/// USER, and a snackbar cannot express any of them:
///
/// * [unavailable] — our side. A provider float ran dry, a rail is down, a
///   service id is misconfigured. The user did nothing wrong and cannot fix it;
///   the only useful action is to try again later. Telling them to "add funds"
///   here — which is what a FailedPrecondition renders as — is both wrong and the
///   kind of wrong that loses trust when it is OUR wallet that is empty.
/// * [correctable] — theirs. A wrong number, an amount the product does not
///   accept. Retrying unchanged will fail identically, so the action is to go
///   back and change something.
/// * [alreadyProcessing] — the provider accepted it and we cannot yet confirm
///   the outcome. The user must be steered to their HISTORY, never offered a
///   retry: on a rail with no requery endpoint, a second attempt is how one
///   purchase becomes two.
enum BillFailureKind { unavailable, correctable, alreadyProcessing }

/// Classifies a bill-purchase error by the gRPC code the backend chose.
///
/// The backend picks the code for exactly this purpose (see
/// mapEPinsErrorToGRPC): Unavailable means "we are at fault, offer a retry",
/// InvalidArgument means "the customer can fix this", AlreadyExists means "it is
/// in flight, do not retry". Reading the CODE rather than the message text is
/// what keeps the two sides from drifting apart when copy changes.
BillFailureKind classifyBillFailure(Object? error) {
  if (error is GrpcError) {
    switch (error.code) {
      case StatusCode.unavailable:
      // Deadline exceeded means we could not CONFIRM — not the user's fault,
      // and not something they can correct by editing a field.
      case StatusCode.deadlineExceeded:
      case StatusCode.internal:
      case StatusCode.resourceExhausted:
        return BillFailureKind.unavailable;
      case StatusCode.alreadyExists:
        return BillFailureKind.alreadyProcessing;
      case StatusCode.invalidArgument:
      case StatusCode.failedPrecondition:
      case StatusCode.notFound:
      case StatusCode.permissionDenied:
      case StatusCode.unauthenticated:
        return BillFailureKind.correctable;
      default:
        // An unexpected code is treated as OURS. Blaming the user for something
        // we cannot classify is the worse of the two mistakes.
        return BillFailureKind.unavailable;
    }
  }
  // A transport-level failure is ours-or-the-network, never the user's input.
  return BillFailureKind.unavailable;
}

/// Classifies from a bare status code, for the cubits that keep `Failure.statusCode`
/// rather than the original exception.
///
/// Threading the CODE through state instead of re-deriving intent from the message
/// text is what stops the two sides drifting when copy changes — a rewritten
/// sentence must never turn a "do not retry" into a "try again".
BillFailureKind classifyBillFailureCode(dynamic statusCode) {
  if (statusCode is int) {
    return classifyBillFailure(GrpcError.custom(statusCode, ''));
  }
  return BillFailureKind.unavailable;
}

/// True when a failure must NOT offer a retry, because the provider has already
/// accepted the purchase.
///
/// On a rail with no requery endpoint — ePINs has none — a retry after code 104
/// is how one purchase silently becomes two, and nothing downstream would ever
/// notice. So this is a money guard, not a UX preference.
bool billFailureForbidsRetry(dynamic statusCode) =>
    classifyBillFailureCode(statusCode) == BillFailureKind.alreadyProcessing;

/// Shows a bill-purchase failure as a MODAL the user has to dismiss.
///
/// WHY NOT A SNACKBAR
/// ------------------
/// A bill failure is a money event. The sentence that matters most —
/// "you have not been charged" — is the one a three-second flash truncates, and
/// it is also the one the user most needs in order to decide whether to try
/// again. Worse, a snackbar offers nothing to do: the two useful next steps here
/// are "try again later" and "check your history", and neither fits.
///
/// [onRetry] is offered ONLY for [BillFailureKind.unavailable]. A correctable
/// error needs an edit, not a retry, and an in-flight purchase must never be
/// retried at all — on a provider with no requery endpoint that is how one
/// purchase silently becomes two.
Future<void> showBillFailure(
  BuildContext context, {
  required Object? error,
  required String serviceLabel,
  VoidCallback? onRetry,
  VoidCallback? onViewHistory,
}) async {
  final kind = classifyBillFailure(error);
  // friendlyError maps by gRPC CODE, never by raw message, and already strips
  // provider/transport noise — so the backend's deliberate wording reaches the
  // user while an unexpected shape degrades to something safe.
  final message = friendlyError(error);

  switch (kind) {
    case BillFailureKind.unavailable:
      await showServerRefusal(
        context,
        title: '$serviceLabel is temporarily unavailable',
        message: message,
        tone: ServerRefusalTone.failure,
        actionLabel: onRetry == null ? null : 'Try again',
        onAction: onRetry,
        dismissLabel: 'Close',
        hint: 'Your money has not left your account.',
      );
      return;

    case BillFailureKind.alreadyProcessing:
      await showServerRefusal(
        context,
        title: 'This purchase is already on its way',
        message: message,
        tone: ServerRefusalTone.refusal,
        // Deliberately NOT a retry. The provider has already accepted it.
        actionLabel: onViewHistory == null ? null : 'View history',
        onAction: onViewHistory,
        dismissLabel: 'Close',
        hint: 'Check your history before trying again, so you are not charged twice.',
      );
      return;

    case BillFailureKind.correctable:
      // A FAMILY WALLET refusal is correctable in the gRPC sense and not at all
      // in the human one: there is nothing on this screen to check. The wallet
      // may hold plenty while THIS member's allowance does not, and the way out
      // depends on whether the family runs a shared pool or per-member
      // allowances — so it gets its own dialog with its own action.
      //
      // The active wallet comes off AccountManager, mirrored there by the account
      // carousel, because this function is called from four processing screens
      // and none of them carries the source account.
      final am = serviceLocator<AccountManager>();
      if (am.isActiveAccountFamily && familyRefusalIsAboutFunds(message)) {
        if (!context.mounted) return;
        await showFamilySpendRefusalDialog(
          context,
          message: message,
          mode: familyFundModeFrom(am.activeFamilyFundMode),
        );
        return;
      }
      await showServerRefusal(
        context,
        title: "$serviceLabel couldn't be completed",
        message: message,
        tone: ServerRefusalTone.refusal,
        dismissLabel: 'Close',
        hint: 'Check the details above and try again.',
      );
      return;
  }
}
