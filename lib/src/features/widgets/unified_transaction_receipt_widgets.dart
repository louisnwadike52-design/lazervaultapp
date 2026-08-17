part of 'unified_transaction_receipt.dart';

class _DetailEntry {
  final String label;
  final String value;
  final bool copyable;
  final String? logoBankName;
  final String? logoBankCode;

  const _DetailEntry(
    this.label,
    this.value, {
    this.copyable = false,
    this.logoBankName,
    this.logoBankCode,
  });
}
