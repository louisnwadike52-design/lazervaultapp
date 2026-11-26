import 'package:grpc/grpc.dart';

/// WHY A CONVERSION DID NOT START, in words a customer can act on.
///
/// Every caller of [fundPaymentWithCrypto] used to catch the error, discard
/// it, and say the same sentence:
///
///     "We could not confirm the conversion. Check this purchase in your
///      history before trying again."
///
/// That sentence is CORRECT for exactly one case — a reply we lost — and
/// wrong for every other. The feature shipped dark behind a server-side gate,
/// so every attempt came back `FailedPrecondition: Paying with crypto is not
/// available on your account right now.`, and the customer was told to go and
/// check a history that would never show anything, about money that had never
/// moved. The server said precisely what was wrong and the app threw it away.
///
/// ## The distinction that matters
///
/// A REFUSAL means the server decided and did nothing: the gate is off, the
/// coin is not supported, the amount is below the minimum, the holding is too
/// small. Nothing was converted and nothing was charged, so the customer can
/// be told so plainly and can act — pick another coin, raise the amount, pay
/// from the wallet.
///
/// AMBIGUITY means we do not know: the call timed out, the socket dropped, the
/// service was unreachable mid-flight. The conversion may have started. There
/// the old sentence is right, because guessing either way about somebody's
/// money is worse than saying what we know.
class CryptoFundingFailure {
  const CryptoFundingFailure({
    required this.message,
    required this.refused,
  });

  /// What to show the customer.
  final String message;

  /// True when the server refused outright — nothing was converted, nothing
  /// charged. A caller may say so, and may offer the fiat route instead.
  final bool refused;

  /// Whether the customer may simply pay from their wallet instead.
  ///
  /// Only on a refusal: after an ambiguous failure a second payment could be
  /// the second one this customer makes.
  bool get mayRetryWithWallet => refused;

  static const String _ambiguous =
      'We could not confirm the conversion. Check this payment in your '
      'history before trying again.';

  /// Read an error thrown by the funding call.
  static CryptoFundingFailure from(Object error) {
    if (error is GrpcError) {
      final msg = (error.message ?? '').trim();
      switch (error.code) {
        // The server decided. These all mean NOTHING MOVED.
        //
        // failedPrecondition — the gate, the daily cap, a holding too small.
        // invalidArgument    — an unsupported coin, an amount below the floor.
        // outOfRange         — an amount outside the configured band.
        // permissionDenied   — not enabled for this account.
        // notFound           — the payment this was to fund is not there.
        case StatusCode.failedPrecondition:
        case StatusCode.invalidArgument:
        case StatusCode.outOfRange:
        case StatusCode.permissionDenied:
        case StatusCode.notFound:
          return CryptoFundingFailure(
            // The server writes these for customers — "Paying with crypto is
            // not available on your account right now", "That amount is below
            // the minimum we can convert". Passing it through is the whole
            // point; a message we invent here would be a worse copy of it.
            message: msg.isEmpty
                ? 'Paying with crypto is not available for this payment right '
                    'now. Nothing has been charged.'
                : msg,
            refused: true,
          );
        // alreadyExists is NOT a failure: the conversion is already running,
        // which is what an idempotent retry is supposed to return. It is
        // listed so nobody later files it under "refused" and tells a
        // customer nothing happened while their coin is being sold.
        case StatusCode.alreadyExists:
          return const CryptoFundingFailure(
            message: 'That conversion is already running.',
            refused: false,
          );
      }
    }
    return const CryptoFundingFailure(message: _ambiguous, refused: false);
  }
}
