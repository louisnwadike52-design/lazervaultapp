import 'package:equatable/equatable.dart';
import '../../domain/entities/data_beneficiary.dart';

sealed class DataBeneficiaryState extends Equatable {
  const DataBeneficiaryState();

  @override
  List<Object?> get props => [];
}

class DataBeneficiaryInitial extends DataBeneficiaryState {}

class DataBeneficiariesLoading extends DataBeneficiaryState {}

class DataBeneficiariesLoaded extends DataBeneficiaryState {
  final List<DataBeneficiary> beneficiaries;
  const DataBeneficiariesLoaded({required this.beneficiaries});

  @override
  List<Object?> get props => [beneficiaries];
}

class DataBeneficiarySaved extends DataBeneficiaryState {
  final DataBeneficiary beneficiary;
  const DataBeneficiarySaved({required this.beneficiary});

  @override
  List<Object?> get props => [beneficiary];
}

class DataBeneficiaryUpdated extends DataBeneficiaryState {
  final DataBeneficiary? beneficiary;
  const DataBeneficiaryUpdated({this.beneficiary});

  @override
  List<Object?> get props => [beneficiary];
}

class DataBeneficiaryDeleted extends DataBeneficiaryState {
  final String id;
  const DataBeneficiaryDeleted({required this.id});

  @override
  List<Object?> get props => [id];
}

class DataBeneficiaryError extends DataBeneficiaryState {
  final String message;
  const DataBeneficiaryError({required this.message});

  @override
  List<Object?> get props => [message];
}
