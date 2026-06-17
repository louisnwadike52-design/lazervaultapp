import 'package:equatable/equatable.dart';
import '../../domain/entities/education_beneficiary.dart';

sealed class EducationBeneficiaryState extends Equatable {
  const EducationBeneficiaryState();

  @override
  List<Object?> get props => [];
}

class EducationBeneficiaryInitial extends EducationBeneficiaryState {}

class EducationBeneficiariesLoading extends EducationBeneficiaryState {}

class EducationBeneficiariesLoaded extends EducationBeneficiaryState {
  final List<EducationBeneficiary> beneficiaries;
  const EducationBeneficiariesLoaded({required this.beneficiaries});

  @override
  List<Object?> get props => [beneficiaries];
}

class EducationBeneficiarySaved extends EducationBeneficiaryState {
  final EducationBeneficiary beneficiary;
  const EducationBeneficiarySaved({required this.beneficiary});

  @override
  List<Object?> get props => [beneficiary];
}

class EducationBeneficiaryUpdated extends EducationBeneficiaryState {
  final EducationBeneficiary? beneficiary;
  const EducationBeneficiaryUpdated({this.beneficiary});

  @override
  List<Object?> get props => [beneficiary];
}

class EducationBeneficiaryDeleted extends EducationBeneficiaryState {
  final String id;
  const EducationBeneficiaryDeleted({required this.id});

  @override
  List<Object?> get props => [id];
}

class EducationBeneficiaryError extends EducationBeneficiaryState {
  final String message;
  const EducationBeneficiaryError({required this.message});

  @override
  List<Object?> get props => [message];
}
