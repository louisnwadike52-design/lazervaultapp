/// Re-raises an escrow action failure that the cubit has already absorbed.
///
/// [EscrowCubit.fundOffer] and [EscrowCubit.validateRelease] catch their own
/// errors, emit `EscrowError` and return null. That is the right shape for a
/// screen driven by BlocListener, and the wrong shape for the PIN sheet: the
/// sheet decides between its success and failure beats by whether the callback
/// it was given THREW. A callback that quietly returns makes the sheet announce
/// "Funds released" over a release that did not happen.
///
/// So the callback re-raises. The message carried here is the cubit's own
/// cleaned message, which the sheet's `failureMessageBuilder` renders verbatim
/// rather than replacing with generic transfer copy.
class EscrowActionException implements Exception {
  const EscrowActionException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// The message to show for a failed escrow action.
///
/// Pulls [EscrowActionException]'s own text through untouched; anything else
/// falls back to the caller's generic line, because an unexpected object here is
/// as likely to be a transport error as a business one.
String escrowActionFailureMessage(Object error, {required String fallback}) {
  if (error is EscrowActionException && error.message.trim().isNotEmpty) {
    return error.message.trim();
  }
  return fallback;
}
