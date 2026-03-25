import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import '../../../../generated/exchange.pbgrpc.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/entities/recipient_entity.dart';
import '../../domain/repositories/i_exchange_repository.dart';

class ExchangeRepositoryImpl implements IExchangeRepository {
  final ExchangeServiceClient _exchangeClient;
  final GrpcCallOptionsHelper _callOptionsHelper;

  // In-memory caches to reduce redundant gRPC calls
  List<SupportedCurrencyInfo>? _currencyCache;
  DateTime? _currencyCacheTime;
  static const _currencyCacheTTL = Duration(minutes: 10);

  final Map<String, _CachedRate> _rateCache = {};
  static const _rateCacheTTL = Duration(seconds: 30);

  ExchangeRepositoryImpl({
    required ExchangeServiceClient exchangeClient,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _exchangeClient = exchangeClient,
        _callOptionsHelper = callOptionsHelper;

  @override
  Future<Either<Failure, ExchangeRate>> getExchangeRate({
    required String fromCurrency,
    required String toCurrency,
    double? amount,
    bool forceRefresh = false,
  }) async {
    // Check cache first (only for no-amount or same-amount requests)
    if (!forceRefresh) {
      final cacheKey = '${fromCurrency}_${toCurrency}_${amount ?? 0}';
      final cached = _rateCache[cacheKey];
      if (cached != null && DateTime.now().difference(cached.fetchedAt) < _rateCacheTTL) {
        return Right(cached.rate);
      }
    }

    try {
      final request = GetExchangeRateRequest()
        ..fromCurrency = fromCurrency
        ..toCurrency = toCurrency;

      if (amount != null && amount > 0) {
        request.amount = amount;
      }

      final callOptions = await _callOptionsHelper.withAuth();
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
        fees: response.fee,
        feePercentage: response.feePercentage,
        rateValidSeconds: response.rateValidSeconds,
        rateId: response.rateId,
      );

      // Cache the result
      final cacheKey = '${fromCurrency}_${toCurrency}_${amount ?? 0}';
      _rateCache[cacheKey] = _CachedRate(rate: exchangeRate, fetchedAt: DateTime.now());

      return Right(exchangeRate);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Failed to get exchange rate'),
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
    required String verificationToken,
    required String idempotencyKey,
    String? rateId,
    String? purposeOfPayment,
    String? recipientName,
    String? recipientAccountNumber,
    String? recipientBankName,
    String? recipientBankCode,
    String? recipientSwiftCode,
    String? recipientCountry,
    String? recipientEmail,
    String? recipientRoutingNumber,
    String? recipientAddress,
    String? notes,
  }) async {
    try {
      final receiverDetails = ReceiverDetails()
        ..fullName = recipientName ?? ''
        ..accountNumber = recipientAccountNumber ?? ''
        ..bankName = recipientBankName ?? ''
        ..swiftBicCode = recipientSwiftCode ?? ''
        ..country = recipientCountry ?? ''
        ..bankCode = recipientBankCode ?? ''
        ..email = recipientEmail ?? ''
        ..routingNumber = recipientRoutingNumber ?? ''
        ..address = recipientAddress ?? '';

      final request = InitiateInternationalTransferRequest()
        ..fromCurrency = fromCurrency
        ..toCurrency = toCurrency
        ..amountFrom = amount
        ..receiverDetails = receiverDetails
        ..verificationToken = verificationToken
        ..idempotencyKey = idempotencyKey;

      if (rateId != null && rateId.isNotEmpty) {
        request.rateId = rateId;
      }
      if (purposeOfPayment != null && purposeOfPayment.isNotEmpty) {
        request.purposeOfPayment = purposeOfPayment;
      }

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _exchangeClient.initiateInternationalTransfer(
        request,
        options: callOptions,
      );

      final transaction = _mapTransactionFromProto(response.transaction);
      return Right(transaction);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Failed to initiate transfer'),
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
  Future<Either<Failure, CurrencyTransaction>> convertCurrency({
    required String fromCurrency,
    required String toCurrency,
    required double amount,
    required String verificationToken,
    required String idempotencyKey,
    String? rateId,
  }) async {
    try {
      final request = ConvertCurrencyRequest()
        ..fromCurrency = fromCurrency
        ..toCurrency = toCurrency
        ..amount = amount
        ..verificationToken = verificationToken
        ..idempotencyKey = idempotencyKey;

      if (rateId != null && rateId.isNotEmpty) {
        request.rateId = rateId;
      }

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _exchangeClient.convertCurrency(
        request,
        options: callOptions,
      );

      final transaction = _mapTransactionFromProto(response.transaction);
      return Right(transaction);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Failed to convert currency'),
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
  Future<Either<Failure, CurrencyTransaction>> getTransactionStatus({
    required String transactionId,
  }) async {
    try {
      final request = GetTransactionStatusRequest()
        ..transactionId = transactionId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _exchangeClient.getTransactionStatus(
        request,
        options: callOptions,
      );

      final transaction = _mapTransactionFromProto(response.transaction);
      return Right(transaction);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Failed to get transaction status'),
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

      final callOptions = await _callOptionsHelper.withAuth();
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
        message: friendlyGrpcError(e, 'Failed to get recent exchanges'),
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
  Future<Either<Failure, List<SupportedCurrencyInfo>>> getSupportedCurrencies() async {
    // Return cached currencies if fresh
    if (_currencyCache != null &&
        _currencyCacheTime != null &&
        DateTime.now().difference(_currencyCacheTime!) < _currencyCacheTTL) {
      return Right(_currencyCache!);
    }

    try {
      final request = GetSupportedCurrenciesRequest();

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _exchangeClient.getSupportedCurrencies(
        request,
        options: callOptions,
      );

      final currencies = response.currencies.map((c) => SupportedCurrencyInfo(
        code: c.code,
        name: c.name,
        symbol: c.symbol,
        country: c.country,
        supportsConversion: c.supportsConversion,
        supportsInternational: c.supportsInternational,
        minAmount: c.minAmount,
        maxAmount: c.maxAmount,
      )).toList();

      _currencyCache = currencies;
      _currencyCacheTime = DateTime.now();

      return Right(currencies);
    } on GrpcError catch (e) {
      // On error, return stale cache if available
      if (_currencyCache != null) {
        return Right(_currencyCache!);
      }
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Failed to get supported currencies'),
        statusCode: e.code,
      ));
    } catch (e) {
      if (_currencyCache != null) {
        return Right(_currencyCache!);
      }
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
      referenceNumber: protoTransaction.reference.isNotEmpty
          ? protoTransaction.reference
          : protoTransaction.transactionId,
      type: protoTransaction.exchangeType == ExchangeType.CONVERSION
          ? TransactionType.exchange
          : TransactionType.send,
      failureReason: protoTransaction.failureReason,
    );
  }

  Recipient _mapRecipientFromProto(ReceiverDetails protoRecipient) {
    return Recipient(
      id: '',
      name: protoRecipient.fullName,
      email: protoRecipient.email,
      accountNumber: protoRecipient.accountNumber,
      bankName: protoRecipient.bankName,
      swiftCode: protoRecipient.swiftBicCode,
      countryCode: protoRecipient.country,
      currency: '',
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
}

class _CachedRate {
  final ExchangeRate rate;
  final DateTime fetchedAt;

  _CachedRate({required this.rate, required this.fetchedAt});
}
