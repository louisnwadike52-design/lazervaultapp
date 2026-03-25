import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import '../../domain/entities/network_rate.dart';

class NetworkRateModel extends NetworkRate {
  const NetworkRateModel({
    required super.network,
    required super.conversionRate,
    required super.minAmount,
    required super.maxAmount,
    required super.automationFee,
    required super.isAvailable,
  });

  factory NetworkRateModel.fromProto(pb.AirtimeToCashNetworkRate rate) {
    return NetworkRateModel(
      network: rate.network,
      conversionRate: rate.conversionRate,
      minAmount: rate.minAmount,
      maxAmount: rate.maxAmount,
      automationFee: rate.automationFee,
      isAvailable: rate.isAvailable,
    );
  }

  factory NetworkRateModel.fromJson(Map<String, dynamic> json) {
    return NetworkRateModel(
      network: json['network'] as String,
      conversionRate: (json['conversionRate'] as num).toDouble(),
      minAmount: (json['minAmount'] as num).toDouble(),
      maxAmount: (json['maxAmount'] as num).toDouble(),
      automationFee: (json['automationFee'] as num).toDouble(),
      isAvailable: json['isAvailable'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'network': network,
      'conversionRate': conversionRate,
      'minAmount': minAmount,
      'maxAmount': maxAmount,
      'automationFee': automationFee,
      'isAvailable': isAvailable,
    };
  }

  @override
  NetworkRateModel copyWith({
    String? network,
    double? conversionRate,
    double? minAmount,
    double? maxAmount,
    double? automationFee,
    bool? isAvailable,
  }) {
    return NetworkRateModel(
      network: network ?? this.network,
      conversionRate: conversionRate ?? this.conversionRate,
      minAmount: minAmount ?? this.minAmount,
      maxAmount: maxAmount ?? this.maxAmount,
      automationFee: automationFee ?? this.automationFee,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}
