import 'package:equatable/equatable.dart';
import '../../domain/entities/water_beneficiary.dart';

sealed class WaterBeneficiaryState extends Equatable {
  const WaterBeneficiaryState();

  @override
  List<Object?> get props => [];
}

class WaterBeneficiaryInitial extends WaterBeneficiaryState {}

class WaterBeneficiariesLoading extends WaterBeneficiaryState {}

class WaterBeneficiariesLoaded extends WaterBeneficiaryState {
  final List<WaterBeneficiary> beneficiaries;
  const WaterBeneficiariesLoaded({required this.beneficiaries});

  @override
  List<Object?> get props => [beneficiaries];
}

class WaterBeneficiarySaved extends WaterBeneficiaryState {
  final WaterBeneficiary beneficiary;
  const WaterBeneficiarySaved({required this.beneficiary});

  @override
  List<Object?> get props => [beneficiary];
}

class WaterBeneficiaryUpdated extends WaterBeneficiaryState {
  final WaterBeneficiary? beneficiary;
  const WaterBeneficiaryUpdated({this.beneficiary});

  @override
  List<Object?> get props => [beneficiary];
}

class WaterBeneficiaryDeleted extends WaterBeneficiaryState {
  final String id;
  const WaterBeneficiaryDeleted({required this.id});

  @override
  List<Object?> get props => [id];
}

class WaterBeneficiaryError extends WaterBeneficiaryState {
  final String message;
  const WaterBeneficiaryError({required this.message});

  @override
  List<Object?> get props => [message];
}
