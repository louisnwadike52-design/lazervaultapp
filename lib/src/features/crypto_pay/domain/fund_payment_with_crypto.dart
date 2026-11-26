import 'package:fixnum/fixnum.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/core/grpc/crypto_grpc_client.dart';

/// The outcome of asking for a payment to be funded by crypto.
class CryptoFundingStart {
  const CryptoFundingStart({
    required this.fundedPaymentId,
    required this.status,
    required this.alreadyExists,
  });

  final String fundedPaymentId;
  final String status;

  /// True when this request had already been made. The caller must NOT treat
  /// it as a second conversion — it is the original record coming back.
  final bool alreadyExists;
}

/// Starts the conversion that funds an already-authorised payment.
///
/// ORDER IS THE SAFETY PROPERTY, and it is fixed:
///
///   1. The payment is authorised and recorded first (core-payments, via the
///      x-funding-source metadata on SendFunds). Nothing is converted.
///   2. ONLY THEN is this called, naming that payment's reference.
///
/// A conversion started without a payment waiting for it would sell the
/// customer's crypto for an errand nothing is tracking — and because the sale
/// is irreversible, there would be no way to undo it. If this step never
/// happens, core-payments' sweep closes the authorisation and nothing was
/// converted.
///
/// THE IDEMPOTENCY KEY IS DERIVED FROM THE PAYMENT REFERENCE, never generated
/// fresh. That is what makes a retry — a tapped-twice button, a reconnect
/// mid-call — return the original conversion instead of opening a second one
/// against the same payment.
Future<CryptoFundingStart> fundPaymentWithCrypto({
  required String accountId,
  required String paymentReference,
  required int requiredMinor,
  required String asset,
  String service = 'transfer',
  String currency = 'NGN',
}) async {
  final resp = await serviceLocator<CryptoGrpcClient>().createFundedPayment(
    accountId: accountId,
    paymentReference: paymentReference,
    requiredMinor: Int64(requiredMinor),
    asset: asset,
    service: service,
    currency: currency,
    // Stable by construction. One payment reference can only ever open one
    // conversion, however many times this is called.
    idempotencyKey: 'fund:$paymentReference',
  );
  return CryptoFundingStart(
    fundedPaymentId: resp.fundedPaymentId,
    status: resp.status,
    alreadyExists: resp.alreadyExists,
  );
}
