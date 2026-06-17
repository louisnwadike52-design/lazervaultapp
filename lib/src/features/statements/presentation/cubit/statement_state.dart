import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/statements/domain/entities/statement_entity.dart';

sealed class StatementState extends Equatable {
  const StatementState();

  @override
  List<Object?> get props => [];
}

class StatementInitial extends StatementState {}

class StatementDownloading extends StatementState {}

class StatementDownloadSuccess extends StatementState {
  final StatementEntity statement;

  const StatementDownloadSuccess({required this.statement});

  @override
  List<Object?> get props => [statement];
}

class StatementDownloadFailure extends StatementState {
  final String message;

  const StatementDownloadFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class StatementHistoryLoading extends StatementState {}

class StatementHistoryLoaded extends StatementState {
  final List<StatementEntity> statements;

  const StatementHistoryLoaded({required this.statements});

  @override
  List<Object?> get props => [statements];
}

class StatementHistoryFailure extends StatementState {
  final String message;

  const StatementHistoryFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
