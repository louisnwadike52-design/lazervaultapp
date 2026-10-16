import 'package:lazervault/core/utils/friendly_error.dart';

import '../cubit/id_pay_state.dart';

/// Guards for the PayID payment screen, kept out of the screen so each one is
/// a pure function with a real unit test.
///
/// They exist because of one production report: a payer tapped Pay on their
/// OWN PayID, the transaction PIN sheet announced "Transaction Successful!",
/// and a red "cannot pay your own PayID" snackbar arrived for the same tap —
/// plus a push notification claiming the transfer had succeeded.

/// A refusal the server (or a pre-flight check) returned as a sentence already
/// fit to show the user.
///
/// It exists so the PIN sheet's failure phase can render the server's exact
/// reason — "cannot pay your own PayID", "PayID has expired" — instead of the
/// generic "We couldn't complete your transfer" that a bare throw would get.
class IDPayPaymentRefused implements Exception {
  final String message;
  const IDPayPaymentRefused(this.message);

  @override
  String toString() => message;
}

/// Mirrors the server's self-payment rule exactly: id-pay-service refuses when
/// `idPay.CreatorID == payerID`.
///
/// Checked on the client so the refusal lands BEFORE the PIN sheet opens. The
/// server's own check sits inside the payment transaction, which is correct but
/// too late to stop the sheet from having already claimed success.
///
/// Returns false when either id is unknown — if we cannot resolve who is
/// signed in we let the server decide, because blocking a legitimate payment is
/// worse than a refusal that arrives one step later.
bool isOwnPayId({required String? signedInUserId, required String? creatorId}) {
  final me = signedInUserId?.trim() ?? '';
  final creator = creatorId?.trim() ?? '';
  if (me.isEmpty || creator.isEmpty) return false;
  return me.toLowerCase() == creator.toLowerCase();
}

/// Converts a terminal [IDPayState] into a throw, so a payment awaited inside
/// the PIN sheet's `onPinValidated` fails the sheet instead of completing it.
///
/// A no-op for every non-terminal and successful state.
void throwIfPaymentRefused(IDPayState state) {
  if (state is IDPayInsufficientFunds) {
    throw IDPayPaymentRefused(state.message.trim().isNotEmpty
        ? state.message.trim()
        : "Your selected account doesn't have enough funds for this payment.");
  }
  if (state is IDPayError) {
    throw IDPayPaymentRefused(state.message.trim().isNotEmpty
        ? state.message.trim()
        : "We couldn't complete your payment. Please try again.");
  }
}

/// Failure copy for the PIN sheet.
///
/// An [IDPayPaymentRefused] is passed through verbatim — it is already the
/// server's user-facing sentence, and running it through [friendlyError] would
/// replace "cannot pay your own PayID" with a generic line that tells the user
/// nothing about what to change. Anything else is an unexpected throw and does
/// go through [friendlyError], which is what keeps transport and provider
/// internals (an IP-allowlist refusal, a gateway 503) off the screen.
String idPayPaymentFailureMessage(Object error) {
  if (error is IDPayPaymentRefused) return error.message;
  return friendlyError(error, context: 'complete your payment');
}

/// The sentence shown when the payer is the PayID's own creator.
const String ownPayIdRefusalMessage =
    "This is your own PayID — you can't pay it. Share it with someone else to "
    'receive money.';
