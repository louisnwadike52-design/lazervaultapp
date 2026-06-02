import 'package:equatable/equatable.dart';

/// Informational, READ-ONLY transfer success signals shown on external-transfer
/// confirmation screens BEFORE PIN entry. This never blocks or moves money.
///
/// Bands are intentionally string-typed to mirror the backend contract:
///   bankBand           -> good | fair | poor | unknown
///   recipientTrustBand -> verified | new | caution | unknown
class TransferSuccessPrediction extends Equatable {
  /// Rolling-window success rate to the destination bank (0-100; 0 when unknown).
  final int bankAvailabilityPct;

  /// good | fair | poor | unknown
  final String bankBand;

  /// Number of resolved transfers in the window backing the bank band.
  final int bankSampleSize;

  /// verified | new | caution | unknown
  final String recipientTrustBand;

  /// Prior successful transfers by THIS user to the recipient.
  final int priorTransferCount;

  /// Earliest platform-wide success to the recipient; null when none.
  final DateTime? knownSince;

  /// True if the destination is on the fraud blocklist.
  final bool blocklisted;

  const TransferSuccessPrediction({
    required this.bankAvailabilityPct,
    required this.bankBand,
    required this.bankSampleSize,
    required this.recipientTrustBand,
    required this.priorTransferCount,
    required this.knownSince,
    required this.blocklisted,
  });

  /// True when there is genuinely nothing to show (cold-start / no data and no
  /// fraud signal). Callers should render NOTHING or a neutral placeholder.
  bool get isUnknown =>
      bankBand == 'unknown' && recipientTrustBand == 'unknown' && !blocklisted;

  @override
  List<Object?> get props => [
        bankAvailabilityPct,
        bankBand,
        bankSampleSize,
        recipientTrustBand,
        priorTransferCount,
        knownSince,
        blocklisted,
      ];
}
