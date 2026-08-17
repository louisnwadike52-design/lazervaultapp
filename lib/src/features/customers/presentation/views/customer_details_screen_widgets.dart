part of 'customer_details_screen.dart';

class _DetailRow {
  final String label;
  final String value;
  final String? logoBankName;
  final String? logoBankCode;

  const _DetailRow(
    this.label,
    this.value, {
    this.logoBankName,
    this.logoBankCode,
  });
}
