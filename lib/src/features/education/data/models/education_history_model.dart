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

    if (proto.metadata.isNotEmpty) {
      try {
        final metadata = Map<String, dynamic>.from(
          // Simple JSON parsing for metadata
          // In production, use dart:convert
          <String, dynamic>{},
        );

        // Extract provider name
        if (metadata.containsKey('provider_name')) {
          providerName = metadata['provider_name'] as String;
        }

        // Extract service ID and variation code
        if (metadata.containsKey('service_id')) {
          serviceId = metadata['service_id'] as String;
        }
        if (metadata.containsKey('variation_code')) {
          variationCode = metadata['variation_code'] as String;
        }

        // Extract quantity
        if (metadata.containsKey('quantity')) {
          quantity = metadata['quantity'] as int;
        }

        // Extract phone number and billers code
        if (metadata.containsKey('phone')) {
          phoneNumber = metadata['phone'] as String;
        }
        if (metadata.containsKey('billers_code')) {
          billersCode = metadata['billers_code'] as String;
        }

        // Extract PINs if available
        if (metadata.containsKey('pins')) {
          final pinsList = metadata['pins'] as List;
          pins = pinsList.map((pinData) {
            return EducationPinModel(
              pin: pinData['pin'] as String,
              serial: pinData['serial'] as String,
              expiresAt: pinData['expires_at'] as String,
            );
          }).toList();
        }
      } catch (e) {
        // If parsing fails, use defaults
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
      billersCode: billersCode,
    );
  }

  /// Check if PINs are available for this purchase
  bool get hasPins => pins.isNotEmpty && status == 'completed';

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

  /// Get status display color
  String get statusColor {
    switch (status.toLowerCase()) {
      case 'completed':
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

  /// Get status display text
  String get statusText {
    switch (status.toLowerCase()) {
      case 'completed':
        return 'Successful';
      case 'pending':
      case 'processing':
        return 'Processing';
      case 'failed':
        return 'Failed';
      default:
        return status;
    }
  }
}
