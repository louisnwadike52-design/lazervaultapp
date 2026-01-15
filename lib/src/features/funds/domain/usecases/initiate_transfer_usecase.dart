import 'package:fixnum/fixnum.dart';
import 'package:dartz/dartz.dart'; // Use dartz
// import 'package:fpdart/fpdart.dart' show Either; // Remove fpdart
import 'package:equatable/equatable.dart';

import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/usecase/usecase.dart';
import 'package:lazervault/core/typedefs.dart'; // Keep typedefs import
import 'package:lazervault/src/features/funds/domain/entities/transfer_entity.dart';
import 'package:lazervault/src/features/funds/domain/repositories/i_transfer_repository.dart';

class InitiateTransferUseCase
    extends UseCaseWithParams<TransferEntity, InitiateTransferParams> {
  final ITransferRepository repository;

  InitiateTransferUseCase(this.repository);

  @override
  // Use dartz's Either
  Future<Either<Failure, TransferEntity>> call(
      InitiateTransferParams params) async {
    // repository.initiateTransfer returns dartz's Either
    return await repository.initiateTransfer(
      fromAccountId: params.fromAccountId,
      amount: params.amount,
      accessToken: params.accessToken,
      toAccountId: params.toAccountId,
      recipientId: params.recipientId,
      category: params.category,
      reference: params.reference,
      scheduledAt: params.scheduledAt,
      transactionId: params.transactionId,
      verificationToken: params.verificationToken,
    );
    // No need for intermediate variable 'result'
  }
}

class InitiateTransferParams extends Equatable {
  final Int64 fromAccountId;
  final Int64 amount;
  final String accessToken;
  final Int64? toAccountId;
  final Int64? recipientId;
  final String? category;
  final String? reference;
  final DateTime? scheduledAt;
  final String? transactionId;
  final String? verificationToken;

  const InitiateTransferParams({
    required this.fromAccountId,
    required this.amount,
    required this.accessToken,
    this.toAccountId,
    this.recipientId,
    this.category,
    this.reference,
    this.scheduledAt,
    this.transactionId,
    this.verificationToken,
  });

  @override
  List<Object?> get props => [
        fromAccountId,
        amount,
        accessToken,
        toAccountId,
        recipientId,
        category,
        reference,
        scheduledAt,
        transactionId,
        verificationToken,
      ];
} 