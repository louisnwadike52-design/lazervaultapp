import 'dart:ui';
import 'package:equatable/equatable.dart';
import 'network_provider.dart';
import 'package:lazervault/core/utils/bill_receipt_status.dart';

enum AirtimeTransactionStatus {
  pending,
  processing,
  completed,
  failed,
  refunded,
}

extension AirtimeTransactionStatusExtension on AirtimeTransactionStatus {
  String get displayName {
    switch (this) {
      case AirtimeTransactionStatus.pending:
        return 'Pending';
      case AirtimeTransactionStatus.processing:
        return 'Processing';
      case AirtimeTransactionStatus.completed:
        return 'Completed';
      case AirtimeTransactionStatus.failed:
        return 'Failed';
      case AirtimeTransactionStatus.refunded:
        return 'Refunded';
    }
  }

  String get statusColor {
    switch (this) {
      case AirtimeTransactionStatus.pending:
        return '#FFA500';
      case AirtimeTransactionStatus.processing:
        return '#0066CC';
      case AirtimeTransactionStatus.completed:
        return '#00AA4F';
      case AirtimeTransactionStatus.failed:
        return '#FF0000';
      case AirtimeTransactionStatus.refunded:
        return '#6B46C1';
    }
  }

  Color get color {
    switch (this) {
      case AirtimeTransactionStatus.pending:
        return const Color(0xFFFFA500);
      case AirtimeTransactionStatus.processing:
        return const Color(0xFF0066CC);
      case AirtimeTransactionStatus.completed:
        return const Color(0xFF00AA4F);
      case AirtimeTransactionStatus.failed:
        return const Color(0xFFFF0000);
      case AirtimeTransactionStatus.refunded:
        return const Color(0xFF6B46C1);
    }
  }
}

class AirtimeTransaction extends Equatable {
  final String id;
  final String transactionReference;
  final NetworkProviderType networkProvider;
  final String recipientPhoneNumber;
  final String? recipientName;
  final double amount;
  final String currency;
  final AirtimeTransactionStatus status;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? failureReason;
  final Map<String, dynamic>? metadata;
  final String userId;
  final double? discount;
  final double? fee;
  final double totalAmount;

  const AirtimeTransaction({
    required this.id,
    required this.transactionReference,
    required this.networkProvider,
    required this.recipientPhoneNumber,
    this.recipientName,
    required this.amount,
    required this.currency,
    required this.status,
    required this.createdAt,
    this.completedAt,
    this.failureReason,
    this.metadata,
    required this.userId,
    this.discount,
    this.fee,
    required this.totalAmount,
  });

  bool get isCompleted => status == AirtimeTransactionStatus.completed;
  bool get isFailed => status == AirtimeTransactionStatus.failed;
  bool get isPending =>
      status == AirtimeTransactionStatus.pending ||
      status == AirtimeTransactionStatus.processing;

  String get currencySymbol {
    switch (currency.toUpperCase()) {
      case 'NGN':
        return '\u20A6';
      case 'USD':
        return '\$';
      case 'GBP':
        return '\u00A3';
      case 'EUR':
        return '\u20AC';
      case 'KES':
        return 'KSh';
      case 'GHS':
        return 'GH\u20B5';
      case 'ZAR':
        return 'R';
      default:
        return '$currency ';
    }
  }

  String get formattedRecipientNumber {
    final cleanNumber = recipientPhoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanNumber.length == 11 && cleanNumber.startsWith('0')) {
      return '+234${cleanNumber.substring(1)}';
    }
    return recipientPhoneNumber;
  }

  String get displayRecipientNumber {
    if (recipientPhoneNumber.length >= 4) {
      final firstPart = recipientPhoneNumber.substring(0, 4);
      final lastPart =
          recipientPhoneNumber.substring(recipientPhoneNumber.length - 3);
      final middlePart = '*' * (recipientPhoneNumber.length - 7);
      return '$firstPart$middlePart$lastPart';
    }
    return recipientPhoneNumber;
  }

  AirtimeTransaction copyWith({
    String? id,
    String? transactionReference,
    NetworkProviderType? networkProvider,
    String? recipientPhoneNumber,
    String? recipientName,
    double? amount,
    String? currency,
    AirtimeTransactionStatus? status,
    DateTime? createdAt,
    DateTime? completedAt,
    String? failureReason,
    Map<String, dynamic>? metadata,
    String? userId,
    double? discount,
    double? fee,
    double? totalAmount,
  }) {
    return AirtimeTransaction(
      id: id ?? this.id,
      transactionReference: transactionReference ?? this.transactionReference,
      networkProvider: networkProvider ?? this.networkProvider,
      recipientPhoneNumber: recipientPhoneNumber ?? this.recipientPhoneNumber,
      recipientName: recipientName ?? this.recipientName,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      failureReason: failureReason ?? this.failureReason,
      metadata: metadata ?? this.metadata,
      userId: userId ?? this.userId,
      discount: discount ?? this.discount,
      fee: fee ?? this.fee,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  @override
  List<Object?> get props => [
        id,
        transactionReference,
        networkProvider,
        recipientPhoneNumber,
        recipientName,
        amount,
        currency,
        status,
        createdAt,
        completedAt,
        failureReason,
        metadata,
        userId,
        discount,
        fee,
        totalAmount,
      ];
}

/// Display + classification helpers that the history widgets read off each
/// transaction. All are metadata-driven so backend doesn't need new fields.
extension AirtimeTransactionDisplay on AirtimeTransaction {
  /// International purchases carry `isInternational` (or `country_code` !=
  /// NG) in their metadata so the list can show the country flag. Also
  /// accepts `billType == 'intl_airtime'` from the unified bill-payment
  /// history endpoint.
  ///
  /// Network-type guardrail: a transaction whose `networkProvider` is one
  /// of the Nigerian operators (MTN/Airtel/Glo/9mobile/etisalat) is
  /// treated as LOCAL even if `metadata['country_code']` happens to read
  /// NG (the default in some backend rows). Only a non-NG country code
  /// OR an explicit `billType == 'intl_airtime'` / explicit
  /// `isInternational: true` flips a Nigerian-network row into the
  /// International bucket — without this guard, all rows with a missing
  /// `country_code` were leaking into the International pill.
  bool get isInternational {
    const nigerianTypes = {
      NetworkProviderType.mtn,
      NetworkProviderType.airtel,
      NetworkProviderType.glo,
      NetworkProviderType.etisalat,
      NetworkProviderType.ninemobile,
    };
    final m = metadata;
    final isNgNetwork = nigerianTypes.contains(networkProvider);
    if (m == null) return !isNgNetwork; // intl-only network → intl
    final bt = m['billType']?.toString().toLowerCase();
    if (bt == 'intl_airtime') return true;
    final flag = m['isInternational'] ?? m['is_international'];
    if (flag is bool && flag) return true;
    final cc =
        (m['country_code'] ?? m['countryCode'])?.toString().toUpperCase();
    final hasNonNgCode = cc != null && cc.isNotEmpty && cc != 'NG';
    if (hasNonNgCode) return true;
    // Fall back to the network type itself: if the row carries an
    // intl-only network (e.g. mtnGhana, safaricom) treat as intl
    // regardless of what the metadata says (or doesn't say).
    return !isNgNetwork;
  }

  /// Airtime-to-cash conversions are stored with `isAirtimeToCash` or
  /// `airtimeToCash == true` in metadata. Keeps the a2c flow visually
  /// distinct on the unified history view. Also accepts
  /// `billType == 'airtime_to_cash'` from the bill-payment history feed.
  bool get isAirtimeToCash {
    final m = metadata;
    if (m == null) return false;
    final flag =
        m['isAirtimeToCash'] ?? m['airtime_to_cash'] ?? m['airtimeToCash'];
    if (flag is bool) return flag;
    final bt = m['billType']?.toString().toLowerCase();
    if (bt == 'airtime_to_cash') return true;
    final kind = (m['kind'] ?? m['type'])?.toString().toLowerCase();
    return kind == 'airtime_to_cash' || kind == 'a2c';
  }

  /// Short title for history rows + receipts.
  String get displayTitle {
    if (isAirtimeToCash) {
      return 'Airtime \u2192 Cash \u00B7 ${networkProvider.displayName}';
    }
    if (metadata != null && metadata!['isTransfer'] == true) {
      return 'Airtime Transfer \u00B7 ${networkProvider.displayName}';
    }
    if (isInternational) {
      // Prefer the live operator_name from the metadata so a SA Cell C
      // top-up reads "Cell C South Africa Airtime" instead of the
      // misleading "MTN Nigeria Airtime" the enum-based fallback used
      // to produce when we couldn't map the operator string.
      final m = metadata;
      final op = (m?['operator_name'] ?? m?['operatorName'])?.toString();
      if (op != null && op.isNotEmpty) return '$op Airtime';
      // Fall back to the country code if even the operator is missing
      // \u2014 at least the user knows where the top-up went.
      final cc = (m?['country_code'] ?? m?['countryCode'])?.toString();
      if (cc != null && cc.isNotEmpty)
        return 'International Airtime \u00B7 $cc';
      return 'International Airtime';
    }
    return '${networkProvider.displayName} Airtime';
  }

  /// Single-letter avatar fallback when there's no network logo.
  String get displayInitial {
    final name = networkProvider.displayName;
    if (name.isEmpty) return '?';
    return name.substring(0, 1).toUpperCase();
  }

  /// The backend's own `refund_source`, carried on metadata.
  ///
  /// IT WAS LOOKING FOR THE WRONG KEY. The model stamps `refund_source`
  /// (BillPayment field 14, whose proto comment literally says "the Flutter
  /// clients read this to promote the chip from Failed to Refunded"), and
  /// the two getters below probed `refundStatus` / `refund_status` — which
  /// nothing writes. So a ₦200 top-up that failed and was refunded showed
  /// "Payment Failed" with no mention of the money, on the receipt AND in
  /// its shared PDF. Measured on prod: AIR-1792095169-d068a8e9, status
  /// `failed`, refund_source `pre_charge_release`, with the ledger row
  /// already marked `refunded`.
  ///
  /// Both spellings are still read: a pending/failed REFUND (as opposed to a
  /// completed one) arrives as `refund_status`, and that distinction is what
  /// decides between "Refund In Progress" and "Payment Refunded".
  String? get refundSignal {
    final m = metadata;
    if (m == null) return null;
    for (final key in const ['refundStatus', 'refund_status', 'refund_source']) {
      final v = m[key]?.toString().trim();
      if (v != null && v.isNotEmpty && v.toLowerCase() != 'none') return v;
    }
    return null;
  }

  bool get hasRefundActivity =>
      isRefundLabel(
        billReceiptStatusLabel(
          status.name,
          refundSource: refundSignal,
          isRefunded: status == AirtimeTransactionStatus.refunded,
        ),
      ) ||
      // A refund still in flight is refund ACTIVITY but not yet a refund,
      // so the canonical label (which only promotes a settled one) does not
      // catch it — and "Refund In Progress" is exactly what the user needs
      // to read while their money is on its way back.
      _refundInFlight;

  bool get _refundInFlight {
    final signal = (refundSignal ?? '').toLowerCase();
    return signal.contains('pending') ||
        signal.contains('processing') ||
        signal.contains('fail') && signal.contains('refund');
  }

  String get refundDisplayLabel {
    final m = metadata;
    // An explicit refund STATUS is a stage in the refund pipeline and is
    // shown as-is ("Refund pending", "Refund failed"). A refund SOURCE only
    // ever means the money came back.
    final rs = m == null
        ? null
        : (m['refundStatus'] ?? m['refund_status'])?.toString().trim();
    if (rs != null && rs.isNotEmpty) {
      return rs[0].toUpperCase() + rs.substring(1);
    }
    if (status == AirtimeTransactionStatus.refunded) return 'Refunded';
    final src = (m?['refund_source'] ?? '').toString().trim();
    if (src.isNotEmpty && src.toLowerCase() != 'none') return 'Refunded';
    return '';
  }

  Color? get refundBadgeColor {
    if (!hasRefundActivity) return null;
    final label = refundDisplayLabel.toLowerCase();
    if (label.contains('pending') || label.contains('processing')) {
      return const Color(0xFFFB923C);
    }
    if (label.contains('fail')) return const Color(0xFFEF4444);
    if (label.contains('manual')) return const Color(0xFFFB923C);
    return const Color(0xFF6B21E0);
  }
}
