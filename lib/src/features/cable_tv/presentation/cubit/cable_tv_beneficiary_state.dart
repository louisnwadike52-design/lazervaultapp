import 'package:equatable/equatable.dart';
import '../../domain/entities/cable_tv_beneficiary.dart';

sealed class CableTVBeneficiaryState extends Equatable {
  const CableTVBeneficiaryState();

  @override
  List<Object?> get props => [];
}

class CableTVBeneficiaryInitial extends CableTVBeneficiaryState {}

class CableTVBeneficiariesLoading extends CableTVBeneficiaryState {}

class CableTVBeneficiariesLoaded extends CableTVBeneficiaryState {
  final List<CableTVBeneficiary> beneficiaries;
  const CableTVBeneficiariesLoaded({required this.beneficiaries});

  @override
  List<Object?> get props => [beneficiaries];
}

class CableTVBeneficiarySaved extends CableTVBeneficiaryState {
  final CableTVBeneficiary beneficiary;
  const CableTVBeneficiarySaved({required this.beneficiary});

  @override
  List<Object?> get props => [beneficiary];
}

class CableTVBeneficiaryUpdated extends CableTVBeneficiaryState {
  final CableTVBeneficiary? beneficiary;
  const CableTVBeneficiaryUpdated({this.beneficiary});

  @override
  List<Object?> get props => [beneficiary];
}

class CableTVBeneficiaryDeleted extends CableTVBeneficiaryState {
  final String id;
  const CableTVBeneficiaryDeleted({required this.id});

  @override
  List<Object?> get props => [id];
}

class CableTVBeneficiaryError extends CableTVBeneficiaryState {
  final String message;
  const CableTVBeneficiaryError({required this.message});

  @override
  List<Object?> get props => [message];
}
