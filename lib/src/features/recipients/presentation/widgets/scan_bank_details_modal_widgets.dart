part of 'scan_bank_details_modal.dart';

// ── Action types returned from the sheet ────────────────────────────────────

enum ScanActionType {
  bankTransfer,
  internalTransfer,
  // The scan resolved to an existing Lazervault user — route as a free internal
  // C2C transfer using resolvedUserId / resolvedAccountId (no username search).
  resolvedUserTransfer,
  phoneTransfer,
  retryCapture,
}

class ScanAction {
  final ScanActionType type;
  final String? accountNumber;
  final String? accountName;
  final String? bankName;
  final String? bankCode;
  final String? username;
  final String? phoneNumber;
  // Resolved Lazervault user (resolvedUserTransfer).
  final String? resolvedUserId;
  final String? resolvedAccountId;
  final String? resolvedDisplayName;
  // Optional pre-fill values flowed in from the OCR result when the
  // server detects an invoice / payment slip. amountMinor is kobo
  // (or pence) so it can be handed straight to the amount controller
  // without rounding drift. The send-funds widget pre-fills both when
  // present and lets the user override.
  final int? amountMinor;
  final String? description;

  const ScanAction({
    required this.type,
    this.accountNumber,
    this.accountName,
    this.bankName,
    this.bankCode,
    this.username,
    this.phoneNumber,
    this.resolvedUserId,
    this.resolvedAccountId,
    this.resolvedDisplayName,
    this.amountMinor,
    this.description,
  });
}
