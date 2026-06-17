import 'package:equatable/equatable.dart';
import 'bill_payment_entity.dart';

class BillBeneficiaryEntity extends Equatable {
  final String id;
  final String userId;
  final String providerId;
  final String providerCode;
  final String providerName;
  final String meterNumber;
  final String customerName;
  final String? customerAddress;
  final String? phoneNumber;
  final MeterType meterType;
  final String nickname;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastUsedAt;

  const BillBeneficiaryEntity({
    required this.id,
    required this.userId,
    required this.providerId,
    required this.providerCode,
    required this.providerName,
    required this.meterNumber,
    required this.customerName,
    this.customerAddress,
    this.phoneNumber,
    required this.meterType,
    required this.nickname,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
    this.lastUsedAt,
  });

  bool get isPrepaid => meterType == MeterType.prepaid;
  bool get isPostpaid => meterType == MeterType.postpaid;
  bool get hasBeenUsed => lastUsedAt != null;

  String get displayName => nickname.isNotEmpty ? nickname : customerName;

  @override
  List<Object?> get props => [
        id,
        userId,
        providerId,
        providerCode,
        providerName,
        meterNumber,
        customerName,
        customerAddress,
        phoneNumber,
        meterType,
        nickname,
        isDefault,
        createdAt,
        updatedAt,
        lastUsedAt,
      ];
}
