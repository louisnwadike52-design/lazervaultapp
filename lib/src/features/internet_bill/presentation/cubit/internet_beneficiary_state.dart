import 'package:equatable/equatable.dart';
import '../../domain/entities/internet_beneficiary.dart';

sealed class InternetBeneficiaryState extends Equatable {
  const InternetBeneficiaryState();

  @override
  List<Object?> get props => [];
}

class InternetBeneficiaryInitial extends InternetBeneficiaryState {}

class InternetBeneficiariesLoading extends InternetBeneficiaryState {}

class InternetBeneficiariesLoaded extends InternetBeneficiaryState {
  final List<InternetBeneficiary> beneficiaries;
  const InternetBeneficiariesLoaded({required this.beneficiaries});

  @override
  List<Object?> get props => [beneficiaries];
}

class InternetBeneficiarySaved extends InternetBeneficiaryState {
  final InternetBeneficiary beneficiary;
  const InternetBeneficiarySaved({required this.beneficiary});

  @override
  List<Object?> get props => [beneficiary];
}

class InternetBeneficiaryUpdated extends InternetBeneficiaryState {
  final InternetBeneficiary? beneficiary;
  const InternetBeneficiaryUpdated({this.beneficiary});

  @override
  List<Object?> get props => [beneficiary];
}

class InternetBeneficiaryDeleted extends InternetBeneficiaryState {
  final String id;
  const InternetBeneficiaryDeleted({required this.id});

  @override
  List<Object?> get props => [id];
}

class InternetBeneficiaryError extends InternetBeneficiaryState {
  final String message;
  const InternetBeneficiaryError({required this.message});

  @override
  List<Object?> get props => [message];
}
