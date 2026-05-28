import 'package:equatable/equatable.dart';

/// Informational, READ-ONLY exchange success signals shown on the international
/// transfer confirmation step BEFORE PIN entry. This never blocks or moves
/// money. Mirrors the shape used by the transfer-prediction widget on the
/// domestic-send screen so the UI and copy stay consistent across the app.
///
/// Backend contract (to be implemented in exchange-service / financial-gateway
/// as a separate task — see widget header in
/// `presentation/widgets/exchange_prediction_alert.dart`):
///
///   rpc GetExchangeRecipientTrust(GetExchangeRecipientTrustRequest)
///       returns (GetExchangeRecipientTrustResponse);
///
///   GetExchangeRecipientTrustRequest {
///     string country = 1;          // ISO-3166-1 alpha-2 (e.g. "GB", "US")
///     string account_or_iban = 2;  // IBAN (EUR) or NUBAN/sort+acct/routing+acct
///     string currency_pair = 3;    // e.g. "NGN_USD"
///   }
///
///   GetExchangeRecipientTrustResponse {
///     string bank_band = 1;            // good | fair | poor | unknown
///     string recipient_trust_band = 2; // verified | new | caution | unknown
///     int32 prior_exchange_count = 3;
///     int64 recipient_known_since_unix = 4; // 0 == unknown
///     bool blocklisted = 5;
///     int32 bank_availability_pct = 6;
///     int32 bank_sample_size = 7;
///   }
///
/// Bands are intentionally string-typed to mirror the wire contract:
///   bankBand           -> good | fair | poor | unknown
///   recipientTrustBand -> verified | new | caution | unknown
class ExchangePredictionEntity extends Equatable {
  /// Rolling-window success rate for the destination corridor (0-100; 0 when
  /// unknown). Used for the "Corridor / bank network" line.
  final int bankAvailabilityPct;

  /// good | fair | poor | unknown
  final String bankBand;

  /// Number of resolved transfers in the window backing the bank band.
  final int bankSampleSize;

  /// verified | new | caution | unknown
  final String recipientTrustBand;

  /// Prior successful exchanges by THIS user to this recipient.
  final int priorExchangeCount;

  /// Earliest platform-wide success to the recipient; null when none.
  final DateTime? knownSince;

  /// True if the destination is on the fraud blocklist.
  final bool blocklisted;

  const ExchangePredictionEntity({
    required this.bankAvailabilityPct,
    required this.bankBand,
    required this.bankSampleSize,
    required this.recipientTrustBand,
    required this.priorExchangeCount,
    required this.knownSince,
    required this.blocklisted,
  });

  /// True when there's genuinely nothing to show. Callers should render
  /// NOTHING or a neutral placeholder.
  bool get isUnknown =>
      bankBand == 'unknown' && recipientTrustBand == 'unknown' && !blocklisted;

  @override
  List<Object?> get props => [
        bankAvailabilityPct,
        bankBand,
        bankSampleSize,
        recipientTrustBand,
        priorExchangeCount,
        knownSince,
        blocklisted,
      ];
}
