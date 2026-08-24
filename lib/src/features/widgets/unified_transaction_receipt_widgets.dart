part of 'unified_transaction_receipt.dart';

/// Provider placeholder values that must never render on a customer receipt
/// ("Anonymous customer", "Unknown", ...). Rows carrying only these are hidden.
bool _isPlaceholderValue(String v) {
  switch (v.trim().toLowerCase()) {
    case '':
    case 'anonymous customer':
    case 'anonymous':
    case 'unknown':
    case 'n/a':
    case 'na':
    case 'null':
      return true;
  }
  return false;
}

/// Cleans a stored description for display: legacy ledger rows carry
/// "Deposit from Anonymous customer" -- collapse to neutral copy.
String _cleanDescription(String d) {
  final lower = d.toLowerCase();
  if (lower.contains('anonymous customer')) {
    if (lower.startsWith('deposit from')) return 'Bank transfer deposit';
    return d
        .replaceAll(RegExp('anonymous customer', caseSensitive: false), '')
        .trim();
  }
  return d;
}

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
