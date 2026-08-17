part of 'bank_scan_datasource.dart';

/// A single past smart-scan, as returned by `GET /scan/history`.
///
/// Deliberately lean: the history sheet only needs enough to render a
/// summary row and to re-build a [SmartScanResult] for re-applying. The
/// [data] map is kept raw so [toSmartScanResult] can hand it straight to
/// [SmartScanResult.fromJson] — reusing the exact same field-parsing the
/// live scan uses (account_number, amount_minor, possible_types, …).
class ScanHistoryItem {
  final int id;
  final String? imageUrl;
  final String extractionType;
  final double confidence;
  final Map<String, dynamic> data;
  final DateTime? createdAt;

  const ScanHistoryItem({
    required this.id,
    required this.imageUrl,
    required this.extractionType,
    required this.confidence,
    required this.data,
    required this.createdAt,
  });

  /// Parse one history entry. Returns null only if the row is so malformed
  /// it can't be rendered (no id at all). A missing image_url is fine —
  /// the row is driven by the extracted text, not the image.
  static ScanHistoryItem? tryFromJson(Map<String, dynamic> json) {
    final rawId = json['id'];
    final int? id = rawId is int
        ? rawId
        : (rawId is num ? rawId.toInt() : int.tryParse(rawId?.toString() ?? ''));
    if (id == null) return null;

    final rawData = json['data'];
    final data = rawData is Map<String, dynamic> ? rawData : <String, dynamic>{};

    final rawConfidence = json['confidence'];
    final confidence = rawConfidence is num
        ? rawConfidence.toDouble()
        : double.tryParse(rawConfidence?.toString() ?? '') ?? 0.0;

    final rawImage = json['image_url'];
    final imageUrl =
        rawImage is String && rawImage.trim().isNotEmpty ? rawImage.trim() : null;

    DateTime? createdAt;
    final rawCreated = json['created_at'];
    if (rawCreated is String && rawCreated.isNotEmpty) {
      createdAt = DateTime.tryParse(rawCreated)?.toLocal();
    }

    return ScanHistoryItem(
      id: id,
      imageUrl: imageUrl,
      extractionType: json['extraction_type']?.toString() ?? 'no_data',
      confidence: confidence.clamp(0.0, 1.0),
      data: data,
      createdAt: createdAt,
    );
  }

  /// Re-hydrate a [SmartScanResult] from this stored scan so a past
  /// extraction can flow through the exact same result-sheet / routing
  /// path the live scan uses. Reuses [SmartScanResult.fromJson] so the
  /// field parsing (amount_minor, possible_types, etc.) stays identical.
  SmartScanResult toSmartScanResult() {
    return SmartScanResult.fromJson({
      'extraction_type': extractionType,
      'confidence': confidence,
      'data': data,
    });
  }
}

/// Result from smart OCR scan — supports 5 extraction types.
class SmartScanResult {
  final String extractionType;
  final double confidence;

  // Bank details
  final String? accountNumber;
  final String? accountName;
  final String? bankName;
  final String? bankCode;
  final String? routingNumber;

  // Internal user
  final String? username;
  final String? displayName;

  // Phone number
  final String? phoneNumber;
  final String? phoneCarrier;

  // Email
  final String? email;

  // Resolved Lazervault user (backend matched the scanned phone/email/username
  // to an existing user). When [isLazervaultUser] is true the scan is routable
  // as a FREE internal C2C transfer to [resolvedUserId] / [resolvedAccountId].
  final bool isLazervaultUser;
  final String? resolvedUserId;
  final String? resolvedUsername;
  final String? resolvedDisplayName;
  final String? resolvedAccountId;

  // Ambiguous
  final List<String> possibleTypes;
  final String? disambiguationHint;

  // Optional pre-fill payload — when the OCR detects an invoice or
  // payment slip with a stated amount or memo, these are non-null and
  // flow into the send-funds amount + reference fields via the route
  // Map. Amount is in MINOR units (kobo / pence) so it round-trips
  // through the InitiateSendFunds amount controller without rounding
  // drift; the OCR side is expected to emit minor units explicitly.
  final int? amountMinor;
  final String? description;

  // Metadata
  final Map<String, double> fieldConfidence;
  final List<String> missingFields;

  SmartScanResult({
    required this.extractionType,
    required this.confidence,
    this.accountNumber,
    this.accountName,
    this.bankName,
    this.bankCode,
    this.routingNumber,
    this.username,
    this.displayName,
    this.phoneNumber,
    this.phoneCarrier,
    this.email,
    this.isLazervaultUser = false,
    this.resolvedUserId,
    this.resolvedUsername,
    this.resolvedDisplayName,
    this.resolvedAccountId,
    this.possibleTypes = const [],
    this.disambiguationHint,
    this.amountMinor,
    this.description,
    this.fieldConfidence = const {},
    this.missingFields = const [],
  });

  factory SmartScanResult.fromJson(Map<String, dynamic> json) {
    // Safely extract nested data map
    final rawData = json['data'];
    final data = rawData is Map<String, dynamic> ? rawData : <String, dynamic>{};

    // 4.5: Safely parse field_confidence — skip non-numeric values
    final rawFieldConf = data['field_confidence'];
    final Map<String, double> fieldConfidence = {};
    if (rawFieldConf is Map<String, dynamic>) {
      for (final entry in rawFieldConf.entries) {
        final v = entry.value;
        if (v is num) {
          fieldConfidence[entry.key] = v.toDouble();
        } else if (v is String) {
          final parsed = double.tryParse(v);
          if (parsed != null) fieldConfidence[entry.key] = parsed;
        }
      }
    }

    // Safely parse missing_fields
    final rawMissing = json['missing_fields'];
    final List<String> missingFields = rawMissing is List
        ? rawMissing.map((e) => e.toString()).toList()
        : [];

    // Safely parse possible_types
    final rawPossible = data['possible_types'];
    final List<String> possibleTypes = rawPossible is List
        ? rawPossible.map((e) => e.toString()).toList()
        : [];

    // Safely parse confidence
    final rawConfidence = json['confidence'];
    final confidence = rawConfidence is num
        ? rawConfidence.toDouble()
        : double.tryParse(rawConfidence?.toString() ?? '') ?? 0.0;

    // Optional amount / description (invoice + payment-slip extraction).
    // Servers may emit `amount_minor` directly OR a major-units `amount`
    // field; accept either, prefer minor. A 0 / negative amount is
    // treated as no-prefill so a glitched extract doesn't dump junk into
    // the amount field.
    int? amountMinor;
    final rawAmountMinor = data['amount_minor'] ?? data['amountMinor'];
    if (rawAmountMinor is num && rawAmountMinor > 0) {
      amountMinor = rawAmountMinor.toInt();
    } else {
      final rawAmount = data['amount'];
      if (rawAmount is num && rawAmount > 0) {
        amountMinor = (rawAmount * 100).round();
      } else if (rawAmount is String) {
        final parsed = double.tryParse(rawAmount);
        if (parsed != null && parsed > 0) {
          amountMinor = (parsed * 100).round();
        }
      }
    }
    final rawDescription = data['description'] ?? data['memo'] ?? data['narration'];
    final description = rawDescription is String && rawDescription.trim().isNotEmpty
        ? rawDescription.trim()
        : null;

    return SmartScanResult(
      extractionType: json['extraction_type']?.toString() ?? 'no_data',
      confidence: confidence.clamp(0.0, 1.0),
      accountNumber: data['account_number']?.toString(),
      accountName: data['account_name']?.toString(),
      bankName: data['bank_name']?.toString(),
      bankCode: data['bank_code']?.toString(),
      routingNumber: data['routing_number']?.toString(),
      username: data['username']?.toString(),
      displayName: data['display_name']?.toString(),
      phoneNumber: data['phone_number']?.toString(),
      phoneCarrier: data['phone_carrier']?.toString(),
      email: data['email']?.toString(),
      isLazervaultUser: data['is_lazervault_user'] == true,
      resolvedUserId: data['resolved_user_id']?.toString(),
      resolvedUsername: data['resolved_username']?.toString(),
      resolvedDisplayName: data['resolved_display_name']?.toString(),
      resolvedAccountId: data['resolved_account_id']?.toString(),
      possibleTypes: possibleTypes,
      disambiguationHint: data['disambiguation_hint']?.toString(),
      amountMinor: amountMinor,
      description: description,
      fieldConfidence: fieldConfidence,
      missingFields: missingFields,
    );
  }

  /// Whether this result has enough data for the claimed extraction type.
  bool get hasRequiredFields => switch (extractionType) {
        'bank_details' => accountNumber != null && accountNumber!.isNotEmpty,
        'internal_user' => (username != null && username!.isNotEmpty) ||
            (resolvedUserId != null && resolvedUserId!.isNotEmpty),
        'phone_number' => phoneNumber != null && phoneNumber!.isNotEmpty,
        'email' => (email != null && email!.isNotEmpty) ||
            (resolvedUserId != null && resolvedUserId!.isNotEmpty),
        'ambiguous' => possibleTypes.isNotEmpty,
        _ => false,
      };

  /// True when the scan resolved to an existing Lazervault user that we can
  /// send to directly as a free internal transfer.
  bool get hasResolvedUser =>
      isLazervaultUser &&
      resolvedUserId != null &&
      resolvedUserId!.isNotEmpty;
}

class BankScanException implements Exception {
  final String message;
  BankScanException(this.message);

  @override
  String toString() => message;
}
