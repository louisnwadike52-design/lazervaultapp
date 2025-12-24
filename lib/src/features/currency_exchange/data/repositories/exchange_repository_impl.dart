import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/grpc_client.dart';
import '../../../../generated/exchange.pbgrpc.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/entities/recipient_entity.dart';
import '../../domain/repositories/i_exchange_repository.dart';

class ExchangeRepositoryImpl implements IExchangeRepository {
  final GrpcClient grpcClient;

  ExchangeRepositoryImpl({required this.grpcClient});

  ExchangeServiceClient get _exchangeClient => grpcClient.exchangeClient;

  @override
  Future<Either<Failure, ExchangeRate>> getExchangeRate({
    required String fromCurrency,
    required String toCurrency,
  }) async {
    try {
      final request = GetExchangeRateRequest()
        ..fromCurrency = fromCurrency
        ..toCurrency = toCurrency;

      final callOptions = await grpcClient.callOptions;
      final response = await _exchangeClient.getExchangeRate(
        request,
        options: callOptions,
      );

      final exchangeRate = ExchangeRate(
        fromCurrency: response.fromCurrency,
        toCurrency: response.toCurrency,
        rate: response.rate,
        timestamp: DateTime.fromMillisecondsSinceEpoch(
          response.timestamp.seconds.toInt() * 1000,
        ),
        fees: _calculateFees(0.0, fromCurrency), // Fees calculated separately
      );

      return Right(exchangeRate);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Failed to get exchange rate',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, CurrencyTransaction>> initiateInternationalTransfer({
    required String fromCurrency,
    required String toCurrency,
    required double amount,
    required String recipientId,
    String? notes,
  }) async {
    try {
      // For now, we'll need to get recipient details from somewhere
      // This should be passed from the UI or fetched from recipient repository
      final receiverDetails = ReceiverDetails()
        ..fullName = '' // To be filled from recipient data
        ..accountNumber = ''
        ..bankName = ''
        ..swiftBicCode = '';

      final request = InitiateInternationalTransferRequest()
        ..fromCurrency = fromCurrency
        ..toCurrency = toCurrency
        ..amountFrom = amount
        ..receiverDetails = receiverDetails;

      final callOptions = await grpcClient.callOptions;
      final response = await _exchangeClient.initiateInternationalTransfer(
        request,
        options: callOptions,
      );

      final transaction = _mapTransactionFromProto(response.transaction);
      return Right(transaction);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Failed to initiate transfer',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, List<CurrencyTransaction>>> getRecentExchanges({
    int? limit,
    int? offset,
  }) async {
    try {
      final request = GetRecentExchangesRequest();
      if (limit != null) request.pageSize = limit;

      final callOptions = await grpcClient.callOptions;
      final response = await _exchangeClient.getRecentExchanges(
        request,
        options: callOptions,
      );

      final transactions = response.transactions
          .map((exchange) => _mapTransactionFromProto(exchange))
          .toList();

      return Right(transactions);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Failed to get recent exchanges',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  // Helper methods
  CurrencyTransaction _mapTransactionFromProto(ExchangeTransaction protoTransaction) {
    final totalCost = protoTransaction.amountFrom + protoTransaction.fees;

    return CurrencyTransaction(
      id: protoTransaction.transactionId,
      fromCurrency: protoTransaction.fromCurrency,
      toCurrency: protoTransaction.toCurrency,
      fromAmount: protoTransaction.amountFrom,
      toAmount: protoTransaction.amountTo,
      exchangeRate: protoTransaction.exchangeRate,
      fees: protoTransaction.fees,
      totalCost: totalCost,
      recipient: _mapRecipientFromProto(protoTransaction.receiverDetails),
      status: _mapTransactionStatus(protoTransaction.status),
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        protoTransaction.createdAt.seconds.toInt() * 1000,
      ),
      completedAt: protoTransaction.hasUpdatedAt()
          ? DateTime.fromMillisecondsSinceEpoch(
              protoTransaction.updatedAt.seconds.toInt() * 1000,
            )
          : null,
      transactionHash: protoTransaction.transactionId,
      referenceNumber: protoTransaction.transactionId,
      type: TransactionType.exchange,
    );
  }

  Recipient _mapRecipientFromProto(ReceiverDetails protoRecipient) {
    return Recipient(
      id: '', // No ID in proto
      name: protoRecipient.fullName,
      email: '', // Not in proto
      accountNumber: protoRecipient.accountNumber,
      bankName: protoRecipient.bankName,
      swiftCode: protoRecipient.swiftBicCode,
      countryCode: '', // Not in proto
      currency: '', // Not in proto
      createdAt: DateTime.now(),
    );
  }

  TransactionStatus _mapTransactionStatus(ExchangeStatus status) {
    switch (status) {
      case ExchangeStatus.PENDING:
        return TransactionStatus.pending;
      case ExchangeStatus.PROCESSING:
        return TransactionStatus.processing;
      case ExchangeStatus.COMPLETED:
        return TransactionStatus.completed;
      case ExchangeStatus.FAILED:
        return TransactionStatus.failed;
      default:
        return TransactionStatus.pending;
    }
  }

  double _calculateFees(double amount, String currency) {
    // Simple fee calculation: 1% of amount with minimum $2 and maximum $50
    const feePercentage = 0.01;
    final fee = amount * feePercentage;
    const minFee = 2.0;
    const maxFee = 50.0;
    return fee.clamp(minFee, maxFee);
  }
}
