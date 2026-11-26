import 'package:grpc/grpc.dart';

/// Attaches the pay-with-crypto choice to an outgoing gRPC call.
///
/// ONE DEFINITION, used by every money path that can be funded by a
/// conversion — transfers, airtime, data, electricity, cable TV, internet and
/// water. The header names and the normalisation rule are a contract with
/// seven server handlers; copied into each data source they would drift, and a
/// drift here is not a cosmetic bug: a header the server does not recognise
/// means the purchase quietly takes the ordinary wallet path and fails on
/// insufficient funds, while a stray one means a customer's crypto is sold for
/// a purchase they asked to pay for from their wallet.
///
/// EMPTY MEANS UNCHANGED. The ordinary wallet-funded call must go out
/// byte-for-byte as it did before this feature existed, so a null, blank, or
/// whitespace-only asset adds nothing at all rather than an empty header —
/// "crypto" without a coin cannot be priced and is refused server-side.
extension CryptoFundingCallOptions on CallOptions {
  CallOptions withCryptoFunding(String? asset) {
    final normalised = asset?.trim().toLowerCase() ?? '';
    if (normalised.isEmpty) return this;
    return mergedWith(CallOptions(metadata: {
      'x-funding-source': 'crypto',
      'x-funding-asset': normalised,
    }));
  }
}
