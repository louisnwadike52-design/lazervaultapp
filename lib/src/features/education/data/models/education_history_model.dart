import 'dart:convert';

import 'package:lazervault/core/utils/bill_receipt_status.dart';
import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import '../../domain/entities/education_history_entity.dart';
import 'education_pin_model.dart';

class EducationHistoryModel extends EducationHistoryEntity {
  const EducationHistoryModel({
    required super.id,
    required super.providerId,
    required super.providerName,
    required super.serviceId,
    required super.variationCode,
    required super.quantity,
    required super.amount,
    required super.status,
    required super.reference,
    required super.createdAt,
    required super.pins,
    required super.phoneNumber,
    required super.billersCode,
    super.refundSource,
  });

  factory EducationHistoryModel.fromProto(pb.BillPayment proto) {
    // Parse metadata to extract PINs
    List<EducationPinModel> pins = [];
    String providerName = proto.providerId;
    String serviceId = '';
    String variationCode = '';
    int quantity = 1;
    String phoneNumber = '';
    String billersCode = '';

    // The metadata WAS being parsed into an empty literal map:
    //
    //   final metadata = Map<String, dynamic>.from(<String, dynamic>{});
    //
    // with a note to "use dart:convert in production". So every lookup below
    // missed, every field fell through to its default, and nothing failed
    // loudly: the history row showed the provider ID instead of its name, a
    // quantity of 1 whatever the customer bought, an empty billers code, and
    // `hasPins` false — which meant a customer who had PAID for exam PINs
    // could not read them back from history at all. The purchase worked; the
    // record of it was blank.
    if (proto.metadata.isNotEmpty) {
      try {
        final decoded = jsonDecode(proto.metadata);
        final metadata = decoded is Map
            ? Map<String, dynamic>.from(decoded)
            : <String, dynamic>{};

        providerName = _str(metadata['provider_name']) ?? providerName;
        serviceId = _str(metadata['service_id']) ?? serviceId;
        variationCode = _str(metadata['variation_code']) ?? variationCode;
        phoneNumber = _str(metadata['phone']) ?? phoneNumber;
        billersCode = _str(metadata['billers_code']) ?? billersCode;

        // Written by Go as a JSON number, but a hand-fixed or re-serialised
        // row can hold the string. Both are the same quantity.
        final q = metadata['quantity'];
        if (q is num) {
          quantity = q.toInt();
        } else if (q is String) {
          quantity = int.tryParse(q.trim()) ?? quantity;
        }

        final pinsRaw = metadata['pins'];
        if (pinsRaw is List) {
          pins = pinsRaw
              .whereType<Map>()
              .map((p) => EducationPinModel(
                    // EducationPinInfo on the service side carries NO json
                    // tags, so Go marshals it as Pin/Serial/ExpiresAt. Rows
                    // already in the database hold exactly those keys, so
                    // both spellings are read — adding tags server-side would
                    // not retroactively rewrite history.
                    pin: _str(p['pin']) ?? _str(p['Pin']) ?? '',
                    serial: _str(p['serial']) ?? _str(p['Serial']) ?? '',
                    expiresAt: _str(p['expires_at']) ??
                        _str(p['ExpiresAt']) ??
                        _str(p['expiresAt']) ??
                        '',
                  ))
              .where((p) => p.pin.isNotEmpty)
              .toList();
        }
      } catch (_) {
        // Unparseable metadata leaves the defaults in place rather than
        // dropping the row — the amount, status and reference are columns,
        // not metadata, so the history entry is still truthful about the
        // money.
      }
    }

    return EducationHistoryModel(
      id: proto.id,
      providerId: proto.providerId,
      providerName: providerName,
      serviceId: serviceId,
      variationCode: variationCode,
      quantity: quantity,
      amount: proto.amount,
      status: proto.status,
      reference: proto.reference,
      createdAt: proto.createdAt,
      pins: pins,
      phoneNumber: phoneNumber,
      // The billers/profile code lives in its own column; metadata never
      // carried `billers_code` despite being read for it, so this was always
      // empty before.
      billersCode: billersCode.isNotEmpty ? billersCode : proto.customerNumber,
      refundSource: proto.hasRefundSource() ? proto.refundSource : '',
    );
  }

  /// Check if PINs are available for this purchase
  /// Whether the customer has PINs to read.
  ///
  /// Keyed on the PINs actually being present, not on a status literal: a row
  /// that reached `completed` via the reconciler or a webhook is spelled the
  /// same, but a post-charge-ambiguous row settled later arrives as
  /// `processing` with PINs already attached, and withholding them because
  /// one string did not match would hide something the customer paid for.
  bool get hasPins => pins.isNotEmpty;

  /// Get formatted amount
  String get formattedAmount {
    if (amount >= 1000) {
      final intAmount = amount.toInt();
      final result = StringBuffer();
      final str = intAmount.toString();
      for (var i = 0; i < str.length; i++) {
        if (i > 0 && (str.length - i) % 3 == 0) {
          result.write(',');
        }
        result.write(str[i]);
      }
      return result.toString();
    }
    return amount.toStringAsFixed(0);
  }

  /// Status colour, with refunds distinguished from failures.
  ///
  /// This used to switch on the raw status alone, so a purchase the customer
  /// had already been refunded for rendered in failure red — the same
  /// disagreement with the receipt that bill_receipt_status.dart exists to
  /// end. The LABEL comes from there; only the colour is chosen here.
  String get statusColor {
    final label = statusText;
    if (isRefundLabel(label)) return '#6B7280'; // gray — money returned
    switch (label.toLowerCase()) {
      case 'completed':
      case 'successful':
        return '#10B981'; // Green
      case 'pending':
      case 'processing':
        return '#FB923C'; // Orange
      case 'failed':
        return '#EF4444'; // Red
      default:
        return '#9CA3AF'; // Gray
    }
  }

  /// Canonical user-facing status text, refund-aware.
  String get statusText =>
      billReceiptStatusLabel(status, refundSource: refundSource);
}

/// A trimmed non-empty string, or null. Metadata values arrive as dynamic and
/// an empty string must not win over a real column value.
String? _str(Object? v) {
  if (v == null) return null;
  final s = v.toString().trim();
  return s.isEmpty ? null : s;
}
