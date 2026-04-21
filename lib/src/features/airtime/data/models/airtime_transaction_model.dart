import 'dart:convert';
import '../../../../generated/utility-payments.pb.dart' as pb;
import '../../domain/entities/airtime_transaction.dart';
import '../../domain/entities/network_provider.dart';

class AirtimeTransactionModel extends AirtimeTransaction {
  const AirtimeTransactionModel({
    required super.id,
    required super.transactionReference,
    required super.networkProvider,
    required super.recipientPhoneNumber,
    super.recipientName,
    required super.amount,
    required super.currency,
    required super.status,
    required super.createdAt,
    super.completedAt,
    super.failureReason,
    super.metadata,
    required super.userId,
    super.discount,
    super.fee,
    required super.totalAmount,
  });

  factory AirtimeTransactionModel.fromBuyAirtimeResponse(
    pb.BuyAirtimeResponse response, {
    required String currency,
  }) {
    final payment = response.payment;
    // A successful gRPC response (no exception) with empty status means completed
    final effectiveStatus = payment.status.isEmpty ? 'completed' : payment.status;
    return AirtimeTransactionModel(
      id: payment.id,
      transactionReference: payment.reference,
      networkProvider: _networkTypeFromBillType(payment.providerId),
      recipientPhoneNumber: response.phoneNumber,
      amount: payment.amount,
      currency: currency,
      status: _statusFromString(effectiveStatus),
      createdAt: DateTime.tryParse(payment.createdAt) ?? DateTime.now(),
      userId: payment.userId,
      totalAmount: payment.amount,
      metadata: {
        'providerReference': response.providerReference,
        'commissionEarned': response.commissionEarned,
        'dataInfo': response.dataInfo,
      },
    );
  }

  /// Airtime transfer reuses the `BuyAirtime` RPC (see
  /// `airtime_remote_datasource.transferAirtime`). The resulting payment
  /// looks just like a top-up, so we layer the sender/recipient metadata on
  /// top here.
  factory AirtimeTransactionModel.fromTransferAirtimeResponse({
    required String senderPhone,
    required String recipientPhone,
    required String recipientName,
    required pb.BuyAirtimeResponse response,
    required String currency,
    String? transferNote,
  }) {
    final payment = response.payment;
    final effectiveStatus =
        payment.status.isEmpty ? 'completed' : payment.status;
    return AirtimeTransactionModel(
      id: payment.id,
      transactionReference: payment.reference,
      networkProvider: _networkTypeFromBillType(
          payment.providerId.isNotEmpty ? payment.providerId : recipientPhone),
      recipientPhoneNumber: recipientPhone,
      recipientName: recipientName,
      amount: payment.amount,
      currency: currency,
      status: _statusFromString(effectiveStatus),
      createdAt: DateTime.tryParse(payment.createdAt) ?? DateTime.now(),
      userId: payment.userId,
      totalAmount: payment.amount,
      metadata: {
        'providerReference': response.providerReference,
        'commissionEarned': response.commissionEarned,
        'isTransfer': true,
        'senderPhone': senderPhone,
        if (transferNote != null && transferNote.isNotEmpty)
          'transferNote': transferNote,
      },
    );
  }

  factory AirtimeTransactionModel.fromBillPaymentProto(
    pb.BillPayment payment, {
    String currency = 'NGN',
  }) {
    // Carry `bill_type` + country onto the entity's metadata map so the
    // history-scope classifiers (`isInternational`, `isAirtimeToCash`)
    // can distinguish the three airtime families when rows are returned
    // by the unified `GetBillPaymentHistory` endpoint (which doesn't
    // surface these via dedicated proto fields on AirtimeTransaction).
    final billType = payment.billType.toLowerCase();
    // `refund_source` is stamped by the backend whenever a hold was
    // released on a `failed` row — propagate it so the shared
    // [BillHistoryItem] can promote the chip from "Failed" to
    // "Refunded".
    final refundSource =
        payment.hasRefundSource() ? payment.refundSource : '';

    // Parse the JSON metadata blob the backend stamps on every payment
    // (country_code, dest_currency, operator_name, fx_rate_used, etc.
    // for intl rows; provider_response details for everything else).
    // Without this the receipt + history rows can't render destination
    // / FX info — the entity's metadata map would only carry the few
    // synthetic flags below.
    final Map<String, dynamic> mergedMeta = {
      'billType': billType,
      if (billType == 'intl_airtime') 'isInternational': true,
      if (billType == 'airtime_to_cash') 'isAirtimeToCash': true,
      if (refundSource.isNotEmpty) 'refund_source': refundSource,
    };
    if (payment.hasMetadata() && payment.metadata.isNotEmpty) {
      try {
        final decoded = jsonDecode(payment.metadata);
        if (decoded is Map<String, dynamic>) {
          mergedMeta.addAll(decoded);
        }
      } catch (_) {
        // Backend wrote bad JSON — ignore and keep just the synthetic flags.
      }
    }

    return AirtimeTransactionModel(
      id: payment.id,
      transactionReference: payment.reference,
      networkProvider: _networkTypeFromMetadata(
          payment.providerId, billType, mergedMeta),
      recipientPhoneNumber: payment.customerNumber,
      amount: payment.amount,
      currency: currency,
      status: _statusFromString(payment.status),
      createdAt: DateTime.tryParse(payment.createdAt) ?? DateTime.now(),
      userId: payment.userId,
      totalAmount: payment.amount,
      metadata: mergedMeta,
    );
  }

  /// Smarter network-type derivation that takes intl operators into
  /// account. The legacy `_networkTypeFromBillType` did string-matching
  /// on `providerId` — but for intl rows the providerId is a UUID with
  /// no operator hint, so it always defaulted to `mtn` (the bug that
  /// made South-Africa purchases show "MTN Nigeria" in recents).
  ///
  /// Order:
  ///   1. Intl rows → match against operator_name from metadata so the
  ///      display reads "Cell C / MTN Ghana / Vodacom" etc.
  ///   2. Local rows → fall back to the original providerId match.
  ///   3. Last resort → `mtn` (Nigerian default).
  static NetworkProviderType _networkTypeFromMetadata(
      String providerId, String billType, Map<String, dynamic> meta) {
    String? operatorHint;
    if (billType == 'intl_airtime') {
      operatorHint = (meta['operator_name'] ?? meta['operatorName'])
          ?.toString()
          .toLowerCase();
      // Map common intl operators to the closest enum.
      if (operatorHint != null && operatorHint.isNotEmpty) {
        if (operatorHint.contains('mtn ghana')) {
          return NetworkProviderType.mtnGhana;
        }
        if (operatorHint.contains('vodafone ghana')) {
          return NetworkProviderType.vodafoneGhana;
        }
        if (operatorHint.contains('airteltigo') ||
            operatorHint.contains('airtel tigo')) {
          return NetworkProviderType.airtelTigo;
        }
        if (operatorHint.contains('mtn south') ||
            operatorHint.contains('mtnsa')) {
          return NetworkProviderType.mtnSa;
        }
        if (operatorHint.contains('vodacom')) {
          return NetworkProviderType.vodacomSa;
        }
        if (operatorHint.contains('cell c')) return NetworkProviderType.cellC;
        // Order matters: check Telkom Kenya BEFORE the generic Telkom
        // pattern so Kenyan rows don't get tagged as Telkom Mobile (SA).
        if (operatorHint.contains('telkom kenya')) {
          return NetworkProviderType.telkomKenya;
        }
        if (operatorHint.contains('telkom')) {
          return NetworkProviderType.telkomMobile;
        }
        if (operatorHint.contains('safaricom')) {
          return NetworkProviderType.safaricom;
        }
        // Country-qualified Airtel BEFORE bare "airtel" so a Kenyan or
        // Indian Airtel row doesn't fall through to NG Airtel below.
        if (operatorHint.contains('airtel kenya')) {
          return NetworkProviderType.airtelKenya;
        }
        if (operatorHint.contains('airtel india') ||
            operatorHint.contains('airtel-india')) {
          return NetworkProviderType.airtelIndia;
        }
        if (operatorHint.contains('jio')) return NetworkProviderType.jio;
        if (operatorHint.contains('bsnl')) return NetworkProviderType.bsnl;
        if (operatorHint.contains('vi ') || operatorHint == 'vi') {
          return NetworkProviderType.vi;
        }
        if (operatorHint.contains('verizon')) {
          return NetworkProviderType.verizon;
        }
        if (operatorHint.contains('at&t') ||
            operatorHint.contains('att')) {
          return NetworkProviderType.att;
        }
        if (operatorHint.contains('t-mobile') ||
            operatorHint.contains('tmobile')) {
          return NetworkProviderType.tmobile;
        }
        if (operatorHint.contains('sprint')) {
          return NetworkProviderType.sprint;
        }
        if (operatorHint.contains('vodafone')) {
          return NetworkProviderType.vodafone;
        }
        if (operatorHint.contains('three') ||
            operatorHint.contains('three uk')) {
          return NetworkProviderType.three;
        }
        if (operatorHint == 'o2' ||
            operatorHint.contains('o2 uk') ||
            operatorHint.contains(' o2')) {
          return NetworkProviderType.o2;
        }
        if (operatorHint.startsWith('ee ') || operatorHint == 'ee') {
          return NetworkProviderType.ee;
        }
        // Fall through to the providerId-based match below.
      }
    }
    // Local Nigerian providers come back with a string that contains
    // the network short name in providerId. For unknown providers we
    // return mtn as a final last resort — for intl rows the
    // displayTitle getter on AirtimeTransaction reads operator_name
    // from metadata directly, so a wrong enum here only affects the
    // network-coloured avatar (not the user-facing copy).
    return _networkTypeFromBillType(providerId);
  }

  static AirtimeTransactionStatus _statusFromString(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return AirtimeTransactionStatus.completed;
      case 'failed':
        return AirtimeTransactionStatus.failed;
      case 'processing':
        return AirtimeTransactionStatus.processing;
      case 'refunded':
        return AirtimeTransactionStatus.refunded;
      default:
        return AirtimeTransactionStatus.pending;
    }
  }

  static NetworkProviderType _networkTypeFromBillType(String providerId) {
    final lower = providerId.toLowerCase();
    if (lower.contains('mtn')) return NetworkProviderType.mtn;
    if (lower.contains('airtel')) return NetworkProviderType.airtel;
    if (lower.contains('glo')) return NetworkProviderType.glo;
    if (lower.contains('9mobile') || lower.contains('etisalat')) {
      return NetworkProviderType.ninemobile;
    }
    return NetworkProviderType.mtn;
  }

  factory AirtimeTransactionModel.fromJson(Map<String, dynamic> json) {
    return AirtimeTransactionModel(
      id: json['id'] as String,
      transactionReference: json['transactionReference'] as String,
      networkProvider: NetworkProviderType.values.firstWhere(
        (e) => e.name == json['networkProvider'],
        orElse: () => NetworkProviderType.mtn,
      ),
      recipientPhoneNumber: json['recipientPhoneNumber'] as String,
      recipientName: json['recipientName'] as String?,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      status: AirtimeTransactionStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => AirtimeTransactionStatus.pending,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] != null 
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      failureReason: json['failureReason'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      userId: json['userId'] as String,
      discount: (json['discount'] as num?)?.toDouble(),
      fee: (json['fee'] as num?)?.toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transactionReference': transactionReference,
      'networkProvider': networkProvider.name,
      'recipientPhoneNumber': recipientPhoneNumber,
      'recipientName': recipientName,
      'amount': amount,
      'currency': currency,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'failureReason': failureReason,
      'metadata': metadata,
      'userId': userId,
      'discount': discount,
      'fee': fee,
      'totalAmount': totalAmount,
    };
  }

  @override
  AirtimeTransactionModel copyWith({
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
    return AirtimeTransactionModel(
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
} 