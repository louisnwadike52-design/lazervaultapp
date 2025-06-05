import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/insurance_entity.dart';

part 'insurance_hive_model.g.dart';

@HiveType(typeId: 20)
class InsuranceHiveModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String policyNumber;

  @HiveField(2)
  String policyHolderName;

  @HiveField(3)
  String policyHolderEmail;

  @HiveField(4)
  String policyHolderPhone;

  @HiveField(5)
  String type; // Store as string and convert to enum

  @HiveField(6)
  String provider;

  @HiveField(7)
  String providerLogo;

  @HiveField(8)
  double premiumAmount;

  @HiveField(9)
  double coverageAmount;

  @HiveField(10)
  String currency;

  @HiveField(11)
  DateTime startDate;

  @HiveField(12)
  DateTime endDate;

  @HiveField(13)
  DateTime nextPaymentDate;

  @HiveField(14)
  String status; // Store as string and convert to enum

  @HiveField(15)
  List<String> beneficiaries;

  @HiveField(16)
  Map<String, dynamic> coverageDetails;

  @HiveField(17)
  String? description;

  @HiveField(18)
  DateTime createdAt;

  @HiveField(19)
  DateTime updatedAt;

  @HiveField(20)
  String userId;

  InsuranceHiveModel({
    required this.id,
    required this.policyNumber,
    required this.policyHolderName,
    required this.policyHolderEmail,
    required this.policyHolderPhone,
    required this.type,
    required this.provider,
    required this.providerLogo,
    required this.premiumAmount,
    required this.coverageAmount,
    required this.currency,
    required this.startDate,
    required this.endDate,
    required this.nextPaymentDate,
    required this.status,
    required this.beneficiaries,
    required this.coverageDetails,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  // Convert from domain entity
  factory InsuranceHiveModel.fromEntity(Insurance insurance) {
    return InsuranceHiveModel(
      id: insurance.id,
      policyNumber: insurance.policyNumber,
      policyHolderName: insurance.policyHolderName,
      policyHolderEmail: insurance.policyHolderEmail,
      policyHolderPhone: insurance.policyHolderPhone,
      type: insurance.type.name,
      provider: insurance.provider,
      providerLogo: insurance.providerLogo,
      premiumAmount: insurance.premiumAmount,
      coverageAmount: insurance.coverageAmount,
      currency: insurance.currency,
      startDate: insurance.startDate,
      endDate: insurance.endDate,
      nextPaymentDate: insurance.nextPaymentDate,
      status: insurance.status.name,
      beneficiaries: List<String>.from(insurance.beneficiaries),
      coverageDetails: Map<String, dynamic>.from(insurance.coverageDetails),
      description: insurance.description,
      createdAt: insurance.createdAt,
      updatedAt: insurance.updatedAt,
      userId: insurance.userId,
    );
  }

  // Convert to domain entity
  Insurance toEntity() {
    return Insurance(
      id: id,
      policyNumber: policyNumber,
      policyHolderName: policyHolderName,
      policyHolderEmail: policyHolderEmail,
      policyHolderPhone: policyHolderPhone,
      type: InsuranceType.values.firstWhere((e) => e.name == type),
      provider: provider,
      providerLogo: providerLogo,
      premiumAmount: premiumAmount,
      coverageAmount: coverageAmount,
      currency: currency,
      startDate: startDate,
      endDate: endDate,
      nextPaymentDate: nextPaymentDate,
      status: InsuranceStatus.values.firstWhere((e) => e.name == status),
      beneficiaries: beneficiaries,
      coverageDetails: coverageDetails,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      userId: userId,
    );
  }
} 