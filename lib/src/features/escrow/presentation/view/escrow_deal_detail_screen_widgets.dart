part of 'escrow_deal_detail_screen.dart';

/// Result of the seller's mark-delivered sheet: an optional note + optional
/// proof-of-delivery media (already uploaded to storage by the picker).
class _DeliveryResult {
  final String note;
  final List<EscrowMediaUploadResult> media;
  const _DeliveryResult({required this.note, this.media = const []});
}
