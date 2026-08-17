part of 'send_crypto_screen.dart';

/// Immutable snapshot of a submitted send — captured at PIN-confirm time so the
/// receipt screen can render the crypto amount, recipient, and network without
/// re-reading the (possibly-cleared) form controllers.
class _SentDetails {
  final double amount;
  final String symbol;
  final String recipient;
  final String network;
  final String note;
  final bool isInternal;
  const _SentDetails({
    required this.amount,
    required this.symbol,
    required this.recipient,
    required this.network,
    required this.note,
    required this.isInternal,
  });
}
