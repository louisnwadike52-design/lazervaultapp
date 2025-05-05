import 'package:equatable/equatable.dart';
import '../domain/entities/account_summary_entity.dart';

abstract class AccountCardsSummaryState extends Equatable {
  const AccountCardsSummaryState();

  @override
  List<Object?> get props => [];
}

class AccountCardsSummaryInitial extends AccountCardsSummaryState {}

class AccountCardsSummaryLoading extends AccountCardsSummaryState {}

class AccountCardsSummaryLoaded extends AccountCardsSummaryState {
  final List<AccountSummaryEntity> accountSummaries;

  const AccountCardsSummaryLoaded(this.accountSummaries);

  @override
  List<Object?> get props => [accountSummaries];
}

class AccountCardsSummaryError extends AccountCardsSummaryState {
  final String message;
  final int? statusCode;

  const AccountCardsSummaryError(this.message, {this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
} 