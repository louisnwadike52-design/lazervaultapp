import 'package:equatable/equatable.dart';
import '../../domain/entities/beneficiary_entity.dart';

abstract class BeneficiaryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BeneficiaryInitial extends BeneficiaryState {}

class BeneficiaryLoading extends BeneficiaryState {}

class BeneficiarySaving extends BeneficiaryState {}

class BeneficiarySaved extends BeneficiaryState {
  final BillBeneficiaryEntity beneficiary;
  final String message;

  BeneficiarySaved({
    required this.beneficiary,
    this.message = 'Beneficiary saved successfully',
  });

  @override
  List<Object?> get props => [beneficiary, message];
}

class BeneficiariesLoaded extends BeneficiaryState {
  final List<BillBeneficiaryEntity> beneficiaries;

  BeneficiariesLoaded({required this.beneficiaries});

  @override
  List<Object?> get props => [beneficiaries];
}

class BeneficiaryLoaded extends BeneficiaryState {
  final BillBeneficiaryEntity beneficiary;

  BeneficiaryLoaded({required this.beneficiary});

  @override
  List<Object?> get props => [beneficiary];
}

class BeneficiaryUpdating extends BeneficiaryState {}

class BeneficiaryUpdated extends BeneficiaryState {
  final BillBeneficiaryEntity beneficiary;
  final String message;

  BeneficiaryUpdated({
    required this.beneficiary,
    this.message = 'Beneficiary updated successfully',
  });

  @override
  List<Object?> get props => [beneficiary, message];
}

class BeneficiaryDeleting extends BeneficiaryState {}

class BeneficiaryDeleted extends BeneficiaryState {
  final String message;

  BeneficiaryDeleted({this.message = 'Beneficiary deleted successfully'});

  @override
  List<Object?> get props => [message];
}

class BeneficiaryError extends BeneficiaryState {
  final String message;

  BeneficiaryError({required this.message});

  @override
  List<Object?> get props => [message];
}
