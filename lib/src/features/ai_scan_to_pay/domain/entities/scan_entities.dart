import 'package:equatable/equatable.dart';

// Enum for different scan types
enum ScanType {
  accountDetails,
  invoice,
  barcode,
  utilityBill,
  giftCard,
  qrCode,
  receipt,
  bankDetails,
}

extension ScanTypeExtension on ScanType {
  String get displayName {
    switch (this) {
      case ScanType.accountDetails:
        return 'Account Details';
      case ScanType.invoice:
        return 'Invoice';
      case ScanType.barcode:
        return 'Barcode';
      case ScanType.utilityBill:
        return 'Utility Bill';
      case ScanType.giftCard:
        return 'Gift Card';
      case ScanType.qrCode:
        return 'QR Code';
      case ScanType.receipt:
        return 'Receipt';
      case ScanType.bankDetails:
        return 'Bank Details';
    }
  }

  String get description {
    switch (this) {
      case ScanType.accountDetails:
        return 'Scan bank account details for transfer';
      case ScanType.invoice:
        return 'Scan invoice to pay automatically';
      case ScanType.barcode:
        return 'Scan product barcode for payment';
      case ScanType.utilityBill:
        return 'Scan electricity, water, or gas bills';
      case ScanType.giftCard:
        return 'Scan gift card code to redeem';
      case ScanType.qrCode:
        return 'Scan QR code for quick payment';
      case ScanType.receipt:
        return 'Scan receipt for expense tracking';
      case ScanType.bankDetails:
        return 'Scan bank details for account setup';
    }
  }

  String get iconPath {
    switch (this) {
      case ScanType.accountDetails:
        return 'assets/icons/account-details.svg';
      case ScanType.invoice:
        return 'assets/icons/invoice.svg';
      case ScanType.barcode:
        return 'assets/icons/barcode.svg';
      case ScanType.utilityBill:
        return 'assets/icons/utility-bill.svg';
      case ScanType.giftCard:
        return 'assets/icons/gift-card.svg';
      case ScanType.qrCode:
        return 'assets/icons/qr-code.svg';
      case ScanType.receipt:
        return 'assets/icons/receipt.svg';
      case ScanType.bankDetails:
        return 'assets/icons/bank-details.svg';
    }
  }
}

// Where the scanned image came from.
enum ScanSource { camera, upload }

// What an analyzed scan resolved to — drives the unified confirm + dispatch.
enum ScanIntentType { bankDetails, qrPay, invoice, recipient, unknown }

/// Unified payment intent produced by analyzing a scan (QR decode or OCR).
/// Every target funnels through this so the confirm screen + cubit.pay() can be
/// generic. Only the fields relevant to [type] are populated.
class ScanPaymentIntent extends Equatable {
  final ScanIntentType type;

  /// Beneficiary headline (recipient/business/invoice title).
  final String title;

  /// Secondary line (e.g. "@username", masked account + bank, invoice number).
  final String subtitle;

  /// Pre-filled amount (major units). Null = user must enter.
  final double? amount;
  final String currency;

  /// False for fixed-amount targets (dynamic qr-pay, invoice) — amount is locked.
  final bool amountEditable;

  final String? description;

  // ── bankDetails ──
  final BankDetails? bankDetails;

  // ── recipient / internal user ──
  final String? username;
  final String? userId;
  final String? accountNumber;
  final String? bankName;
  final String? bankCode;

  // ── qrPay ──
  final String? qrCode;

  // ── invoice ──
  final String? invoiceId;

  /// Raw decoded payload / source string (audit + debugging).
  final String? raw;

  const ScanPaymentIntent({
    required this.type,
    required this.title,
    required this.subtitle,
    this.amount,
    this.currency = 'NGN',
    this.amountEditable = true,
    this.description,
    this.bankDetails,
    this.username,
    this.userId,
    this.accountNumber,
    this.bankName,
    this.bankCode,
    this.qrCode,
    this.invoiceId,
    this.raw,
  });

  ScanPaymentIntent copyWith({
    double? amount,
    String? currency,
    bool? amountEditable,
    String? description,
  }) {
    return ScanPaymentIntent(
      type: type,
      title: title,
      subtitle: subtitle,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      amountEditable: amountEditable ?? this.amountEditable,
      description: description ?? this.description,
      bankDetails: bankDetails,
      username: username,
      userId: userId,
      accountNumber: accountNumber,
      bankName: bankName,
      bankCode: bankCode,
      qrCode: qrCode,
      invoiceId: invoiceId,
      raw: raw,
    );
  }

  @override
  List<Object?> get props => [
        type,
        title,
        subtitle,
        amount,
        currency,
        amountEditable,
        description,
        bankDetails,
        username,
        userId,
        accountNumber,
        bankName,
        bankCode,
        qrCode,
        invoiceId,
        raw,
      ];
}

/// Rich result of an OCR scan analysis (POST /scan/bank-details). Unlike
/// [BankDetails] (which assumes a bank-account extraction), this exposes the
/// backend's `extraction_type` so the cubit can route to the right payment
/// target (bank details, internal user, phone, email, ambiguous, or no data).
class ScanAnalysis extends Equatable {
  /// One of: bank_details | internal_user | phone_number | email | ambiguous | no_data.
  final String extractionType;

  // Bank-account fields (extraction_type == bank_details).
  final String? accountNumber;
  final String? accountName;
  final String? bankName;
  final String? bankCode;
  final String? accountType; // "internal" | "external"
  final String? transferMethod;

  // Internal-user fields (extraction_type == internal_user).
  final String? username;
  final String? displayName;

  // Contact fields (phone_number / email).
  final String? phoneNumber;
  final String? email;

  // Optional pre-filled payment hints.
  final double? amount; // major units (derived from amount_minor)
  final String? description;

  // Disambiguation (extraction_type == ambiguous).
  final List<String> possibleTypes;
  final String? disambiguationHint;

  // Confidence.
  final double confidence;
  final Map<String, double> fieldConfidence;

  /// Raw extracted_data map for audit / fallthrough.
  final Map<String, dynamic> raw;

  const ScanAnalysis({
    required this.extractionType,
    this.accountNumber,
    this.accountName,
    this.bankName,
    this.bankCode,
    this.accountType,
    this.transferMethod,
    this.username,
    this.displayName,
    this.phoneNumber,
    this.email,
    this.amount,
    this.description,
    this.possibleTypes = const [],
    this.disambiguationHint,
    this.confidence = 0.0,
    this.fieldConfidence = const {},
    this.raw = const {},
  });

  bool get isBankDetails => extractionType == 'bank_details';
  bool get isInternalUser => extractionType == 'internal_user';
  bool get isPhone => extractionType == 'phone_number';
  bool get isEmail => extractionType == 'email';
  bool get isAmbiguous => extractionType == 'ambiguous';
  bool get isNoData => extractionType == 'no_data' || extractionType.isEmpty;

  /// Build a [BankDetails] from a bank_details extraction so the existing
  /// bank-details payment path can consume it unchanged.
  BankDetails toBankDetails() {
    return BankDetails(
      accountNumber: accountNumber ?? '',
      accountName: accountName ?? '',
      bankName: bankName ?? '',
      bankCode: bankCode,
      confidenceScore: confidence,
      fieldConfidence: fieldConfidence,
      accountType: accountType ?? 'external',
      transferMethod: transferMethod ?? 'paystack_transfer',
    );
  }

  @override
  List<Object?> get props => [
        extractionType,
        accountNumber,
        accountName,
        bankName,
        bankCode,
        accountType,
        transferMethod,
        username,
        displayName,
        phoneNumber,
        email,
        amount,
        description,
        possibleTypes,
        disambiguationHint,
        confidence,
        fieldConfidence,
      ];
}

/// One entry in the backend-driven AI Scan-to-Pay "Previous scans" history.
/// Resolved scans are `incomplete` until a payment completes, at which point
/// the [receipt] is attached and [status] becomes `completed`.
class AiScanHistoryEntry extends Equatable {
  final String id;
  final DateTime createdAt;
  final String title;
  final String subtitle;
  final String typeName; // ScanIntentType.name
  final double amount;
  final String currency;
  final String status; // 'completed' | 'incomplete'
  final PaymentReceipt? receipt;

  const AiScanHistoryEntry({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.subtitle,
    required this.typeName,
    required this.amount,
    required this.currency,
    required this.status,
    this.receipt,
  });

  bool get isCompleted => status == 'completed' && receipt != null;

  /// Parse a row from `GET /scan/ai-history`.
  factory AiScanHistoryEntry.fromBackend(Map<String, dynamic> j) {
    final rcpt = j['receipt'];
    return AiScanHistoryEntry(
      id: (j['id'] ?? '').toString(),
      createdAt: DateTime.tryParse(j['created_at']?.toString() ?? '') ??
          DateTime.now(),
      title: (j['title'] ?? 'Scan').toString(),
      subtitle: (j['subtitle'] ?? '').toString(),
      typeName: (j['scan_type'] ?? 'unknown').toString(),
      amount: (j['amount'] is num)
          ? (j['amount'] as num).toDouble()
          : double.tryParse('${j['amount']}') ?? 0,
      currency: (j['currency'] ?? 'NGN').toString(),
      status: (j['status'] ?? 'incomplete').toString(),
      receipt: rcpt is Map
          ? receiptFromJson(Map<String, dynamic>.from(rcpt))
          : null,
    );
  }

  static Map<String, dynamic> receiptToJson(PaymentReceipt r) => {
        'id': r.id,
        'reference': r.reference,
        'recipientName': r.recipientName,
        'accountNumber': r.accountNumber,
        'bankName': r.bankName,
        'amount': r.amount,
        'currency': r.currency,
        'status': r.status,
        'description': r.description,
        'transactionDate': r.transactionDate.toIso8601String(),
        'transferReference': r.transferReference,
        'isExternal': r.isExternal,
      };

  static PaymentReceipt receiptFromJson(Map<String, dynamic> j) => PaymentReceipt(
        id: (j['id'] ?? '').toString(),
        reference: (j['reference'] ?? '').toString(),
        recipientName: (j['recipientName'] ?? '').toString(),
        accountNumber: (j['accountNumber'] ?? '').toString(),
        bankName: (j['bankName'] ?? '').toString(),
        amount: (j['amount'] is num)
            ? (j['amount'] as num).toDouble()
            : double.tryParse('${j['amount']}') ?? 0,
        currency: (j['currency'] ?? 'NGN').toString(),
        status: (j['status'] ?? 'completed').toString(),
        description: j['description']?.toString(),
        transactionDate:
            DateTime.tryParse(j['transactionDate']?.toString() ?? '') ??
                DateTime.now(),
        transferReference: j['transferReference']?.toString(),
        isExternal: j['isExternal'] == true,
      );

  @override
  List<Object?> get props =>
      [id, createdAt, title, subtitle, typeName, amount, currency, status, receipt];
}

// Scan session entity
class ScanSession extends Equatable {
  final String id;
  final ScanType scanType;
  final DateTime createdAt;
  final ScanStatus status;
  final String? imagePath;
  final String? extractedData;
  final Map<String, dynamic>? metadata;

  const ScanSession({
    required this.id,
    required this.scanType,
    required this.createdAt,
    required this.status,
    this.imagePath,
    this.extractedData,
    this.metadata,
  });

  @override
  List<Object?> get props => [
        id,
        scanType,
        createdAt,
        status,
        imagePath,
        extractedData,
        metadata,
      ];

  ScanSession copyWith({
    String? id,
    ScanType? scanType,
    DateTime? createdAt,
    ScanStatus? status,
    String? imagePath,
    String? extractedData,
    Map<String, dynamic>? metadata,
  }) {
    return ScanSession(
      id: id ?? this.id,
      scanType: scanType ?? this.scanType,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      imagePath: imagePath ?? this.imagePath,
      extractedData: extractedData ?? this.extractedData,
      metadata: metadata ?? this.metadata,
    );
  }
}

// Enum for scan status
enum ScanStatus {
  pending,
  scanning,
  analyzing,
  extracting,
  completed,
  failed,
  cancelled,
}

extension ScanStatusExtension on ScanStatus {
  String get displayName {
    switch (this) {
      case ScanStatus.pending:
        return 'Pending';
      case ScanStatus.scanning:
        return 'Scanning';
      case ScanStatus.analyzing:
        return 'Analyzing';
      case ScanStatus.extracting:
        return 'Extracting Data';
      case ScanStatus.completed:
        return 'Completed';
      case ScanStatus.failed:
        return 'Failed';
      case ScanStatus.cancelled:
        return 'Cancelled';
    }
  }
}

// AI Chat message entity
class AiChatMessage extends Equatable {
  final String id;
  final String content;
  final bool isUser;
  final DateTime timestamp;
  final MessageType type;
  final Map<String, dynamic>? attachments;

  const AiChatMessage({
    required this.id,
    required this.content,
    required this.isUser,
    required this.timestamp,
    this.type = MessageType.text,
    this.attachments,
  });

  @override
  List<Object?> get props => [
        id,
        content,
        isUser,
        timestamp,
        type,
        attachments,
      ];

  AiChatMessage copyWith({
    String? id,
    String? content,
    bool? isUser,
    DateTime? timestamp,
    MessageType? type,
    Map<String, dynamic>? attachments,
  }) {
    return AiChatMessage(
      id: id ?? this.id,
      content: content ?? this.content,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      attachments: attachments ?? this.attachments,
    );
  }
}

// Enum for message types
enum MessageType {
  text,
  image,
  action,
  payment,
  confirmation,
}

// Payment instruction entity
class PaymentInstruction extends Equatable {
  final String id;
  final String recipient;
  final double amount;
  final String currency;
  final String? reference;
  final String? description;
  final Map<String, dynamic>? additionalData;

  const PaymentInstruction({
    required this.id,
    required this.recipient,
    required this.amount,
    required this.currency,
    this.reference,
    this.description,
    this.additionalData,
  });

  @override
  List<Object?> get props => [
        id,
        recipient,
        amount,
        currency,
        reference,
        description,
        additionalData,
      ];

  PaymentInstruction copyWith({
    String? id,
    String? recipient,
    double? amount,
    String? currency,
    String? reference,
    String? description,
    Map<String, dynamic>? additionalData,
  }) {
    return PaymentInstruction(
      id: id ?? this.id,
      recipient: recipient ?? this.recipient,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      reference: reference ?? this.reference,
      description: description ?? this.description,
      additionalData: additionalData ?? this.additionalData,
    );
  }
}

// Bank Details entity for scan-to-pay
class BankDetails extends Equatable {
  final String accountNumber;
  final String accountName;
  final String bankName;
  final String? bankCode;
  final String? routingNumber;
  final String? swiftCode;
  final double confidenceScore;
  final Map<String, double> fieldConfidence;
  final String accountType; // "internal" or "external"
  final String transferMethod; // "send_funds_grpc" or "paystack_transfer"

  const BankDetails({
    required this.accountNumber,
    required this.accountName,
    required this.bankName,
    this.bankCode,
    this.routingNumber,
    this.swiftCode,
    required this.confidenceScore,
    required this.fieldConfidence,
    required this.accountType,
    required this.transferMethod,
  });

  bool get isHighConfidence => confidenceScore >= 0.8;
  bool get isMediumConfidence => confidenceScore >= 0.6 && confidenceScore < 0.8;
  bool get isLowConfidence => confidenceScore < 0.6;
  bool get requiresReview => confidenceScore < 0.6;
  bool get isInternal => accountType == 'internal';
  bool get isExternal => accountType == 'external';

  String get maskedAccountNumber {
    if (accountNumber.length <= 4) return accountNumber;
    final visibleDigits = accountNumber.substring(accountNumber.length - 4);
    final maskedPart = '*' * (accountNumber.length - 4);
    return maskedPart + visibleDigits;
  }

  @override
  List<Object?> get props => [
        accountNumber,
        accountName,
        bankName,
        bankCode,
        routingNumber,
        swiftCode,
        confidenceScore,
        fieldConfidence,
        accountType,
        transferMethod,
      ];

  BankDetails copyWith({
    String? accountNumber,
    String? accountName,
    String? bankName,
    String? bankCode,
    String? routingNumber,
    String? swiftCode,
    double? confidenceScore,
    Map<String, double>? fieldConfidence,
    String? accountType,
    String? transferMethod,
  }) {
    return BankDetails(
      accountNumber: accountNumber ?? this.accountNumber,
      accountName: accountName ?? this.accountName,
      bankName: bankName ?? this.bankName,
      bankCode: bankCode ?? this.bankCode,
      routingNumber: routingNumber ?? this.routingNumber,
      swiftCode: swiftCode ?? this.swiftCode,
      confidenceScore: confidenceScore ?? this.confidenceScore,
      fieldConfidence: fieldConfidence ?? this.fieldConfidence,
      accountType: accountType ?? this.accountType,
      transferMethod: transferMethod ?? this.transferMethod,
    );
  }
}

// Payment Receipt entity
class PaymentReceipt extends Equatable {
  final String id;
  final String reference;
  final String recipientName;
  final String accountNumber;
  final String bankName;
  final double amount;
  final String currency;
  final String status;
  final String? description;
  final DateTime transactionDate;
  final String? transferReference; // Paystack reference for external transfers
  final bool isExternal;

  const PaymentReceipt({
    required this.id,
    required this.reference,
    required this.recipientName,
    required this.accountNumber,
    required this.bankName,
    required this.amount,
    required this.currency,
    required this.status,
    this.description,
    required this.transactionDate,
    this.transferReference,
    this.isExternal = false,
  });

  String get maskedAccountNumber {
    if (accountNumber.length <= 4) return accountNumber;
    final visibleDigits = accountNumber.substring(accountNumber.length - 4);
    final maskedPart = '*' * (accountNumber.length - 4);
    return maskedPart + visibleDigits;
  }

  String get formattedDate {
    return '${transactionDate.day}/${transactionDate.month}/${transactionDate.year}';
  }

  String get formattedTime {
    final hour = transactionDate.hour.toString().padLeft(2, '0');
    final minute = transactionDate.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String get statusDisplayText {
    switch (status.toLowerCase()) {
      case 'completed':
        return 'Completed';
      case 'processing':
        return 'Processing';
      case 'pending':
        return 'Pending';
      case 'failed':
        return 'Failed';
      default:
        return status;
    }
  }

  @override
  List<Object?> get props => [
        id,
        reference,
        recipientName,
        accountNumber,
        bankName,
        amount,
        currency,
        status,
        description,
        transactionDate,
        transferReference,
        isExternal,
      ];

  PaymentReceipt copyWith({
    String? id,
    String? reference,
    String? recipientName,
    String? accountNumber,
    String? bankName,
    double? amount,
    String? currency,
    String? status,
    String? description,
    DateTime? transactionDate,
    String? transferReference,
    bool? isExternal,
  }) {
    return PaymentReceipt(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      recipientName: recipientName ?? this.recipientName,
      accountNumber: accountNumber ?? this.accountNumber,
      bankName: bankName ?? this.bankName,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      description: description ?? this.description,
      transactionDate: transactionDate ?? this.transactionDate,
      transferReference: transferReference ?? this.transferReference,
      isExternal: isExternal ?? this.isExternal,
    );
  }
} 