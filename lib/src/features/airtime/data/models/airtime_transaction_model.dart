import 'dart:convert';
import '../../../../generated/utility-payments.pb.dart' as pb;
import '../../domain/entities/airtime_transaction.dart';
import '../../domain/entities/network_provider.dart';
import '../../../../../core/utils/ng_network_prefixes.dart';

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
      networkProvider: _networkTypeFromBillType(payment.providerId,
          phone: response.phoneNumber),
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
      networkProvider: _networkTypeFromBillType(payment.providerId,
          phone: recipientPhone),
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
          payment.providerId, billType, mergedMeta,
          // customerNumber is always populated, where metadata.phone_number is
          // only present on some rows — pass it so prefix detection has a
          // number to work with even when metadata is sparse.
          phone: payment.customerNumber),
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

  /// Derives the network a transaction was placed against.
  ///
  /// Order, most authoritative first:
  ///   1. Intl rows → `operator_name` from metadata, so the display reads
  ///      "Cell C / MTN Ghana / Vodacom" rather than a Nigerian carrier.
  ///   2. `operator_id` / `network_name` / `network` from metadata — what the
  ///      purchase was actually placed against.
  ///   3. The recipient's own NCC prefix (domestic rows only).
  ///   4. A `providerId` that happens to name the network.
  ///   5. Last resort → `mtn`.
  ///
  /// Steps 2 and 3 are the fix for receipts stating the wrong carrier: rows
  /// whose providerId is a UUID fell straight from 1 to 5 and claimed MTN for
  /// every network.
  static NetworkProviderType _networkTypeFromMetadata(
      String providerId, String billType, Map<String, dynamic> meta,
      {String phone = ''}) {
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
    // Local Nigerian rows. providerId USUALLY carries the network short name
    // ("MTN"), but not always — some rows carry a UUID instead, and then the
    // substring match below finds nothing and the last resort claims MTN.
    //
    // That is not a harmless default. A real production row read
    // provider_id=02dd9d0f-…, customer_number=07012406678 (an Airtel prefix),
    // metadata.operator_id="AIRTEL" — and the receipt displayed "MTN Nigeria".
    // The comment here used to argue a wrong enum only tinted the avatar, but
    // the payment receipt renders networkProvider.displayName as the Network
    // field, so it states the wrong carrier to the customer on a document they
    // keep.
    //
    // The authoritative answer was in metadata all along: operator_id is what
    // the purchase was actually placed against. Ask it first, then the phone's
    // own prefix, and only then fall back to string-matching an id that may be
    // opaque.
    final metaNetwork = _networkFromMetadata(meta);
    if (metaNetwork != null) return metaNetwork;

    // NCC prefixes are Nigerian, so they are only evidence for a domestic
    // number. Running them over an international MSISDN could match a foreign
    // number onto a Nigerian carrier purely by digit coincidence.
    final isIntl = billType == 'intl_airtime';
    final effectivePhone =
        phone.isNotEmpty ? phone : (meta['phone_number']?.toString() ?? '');
    if (!isIntl) {
      final byPrefix = _networkFromPhone(effectivePhone);
      if (byPrefix != null) return byPrefix;
    }

    return _networkTypeFromBillType(providerId,
        phone: isIntl ? '' : effectivePhone);
  }

  /// Reads the network the purchase was actually placed against.
  ///
  /// Keys confirmed against live rows: airtime writes `operator_id` ("AIRTEL"),
  /// data writes `network_name` ("MTN") and `network` ("mtn-data").
  static NetworkProviderType? _networkFromMetadata(Map<String, dynamic> meta) {
    for (final key in const [
      'operator_id',
      'operatorId',
      'network_name',
      'networkName',
      'network',
      'network_code',
    ]) {
      final raw = meta[key]?.toString().toLowerCase().trim();
      if (raw == null || raw.isEmpty) continue;
      // Order matters: "9mobile"/"etisalat" before the generic checks, and
      // never substring-match "mtn" against something like "mtn-data" wrongly
      // — that IS mtn, so containment is correct here.
      if (raw.contains('9mobile') || raw.contains('etisalat')) {
        return NetworkProviderType.ninemobile;
      }
      if (raw.contains('airtel')) return NetworkProviderType.airtel;
      if (raw.contains('glo')) return NetworkProviderType.glo;
      if (raw.contains('mtn')) return NetworkProviderType.mtn;
    }
    return null;
  }

  /// Falls back to the NCC prefix allocation, the same canonical map the
  /// quick-buys detect with, so a receipt never contradicts what the user saw
  /// when they typed the number.
  static NetworkProviderType? _networkFromPhone(String phone) {
    switch (NgNetworkPrefixes.detect(phone)) {
      case 'mtn':
        return NetworkProviderType.mtn;
      case 'airtel':
        return NetworkProviderType.airtel;
      case 'glo':
        return NetworkProviderType.glo;
      case 'etisalat':
        return NetworkProviderType.ninemobile;
      default:
        return null;
    }
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

  /// Derives the network from an id that MAY name it, falling back to the
  /// recipient's own number.
  ///
  /// [providerId] is only sometimes a network short name — plenty of rows carry
  /// a UUID, and a UUID matches none of the branches below. The old code then
  /// returned mtn unconditionally, so any such row claimed MTN no matter which
  /// line was topped up. Passing [phone] lets the NCC prefix allocation answer
  /// instead, which is authoritative for a Nigerian number and is the same map
  /// the quick-buys detect with.
  static NetworkProviderType _networkTypeFromBillType(String providerId,
      {String phone = ''}) {
    final lower = providerId.toLowerCase();
    // 9mobile/etisalat first: neither substring collides with the others, but
    // keeping the most specific check ahead of the rest is what stops a future
    // brand alias from being swallowed.
    if (lower.contains('9mobile') || lower.contains('etisalat')) {
      return NetworkProviderType.ninemobile;
    }
    if (lower.contains('airtel')) return NetworkProviderType.airtel;
    if (lower.contains('glo')) return NetworkProviderType.glo;
    if (lower.contains('mtn')) return NetworkProviderType.mtn;

    final byPrefix = _networkFromPhone(phone.isNotEmpty ? phone : providerId);
    if (byPrefix != null) return byPrefix;

    // Nothing identified it. mtn remains the last resort because the enum has
    // no unknown member and every caller renders SOMETHING, but by this point
    // both the metadata and the number have been asked, so a Nigerian top-up
    // reaching here is genuinely unidentifiable rather than merely unmatched.
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