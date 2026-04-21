import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/intl_airtime_country.dart';
import '../../domain/entities/intl_airtime_operator.dart';
import '../../domain/repositories/intl_airtime_repository.dart';
import '../datasources/intl_airtime_remote_datasource.dart';

class IntlAirtimeRepositoryImpl implements IntlAirtimeRepository {
  final IntlAirtimeRemoteDatasource remoteDatasource;

  IntlAirtimeRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, List<IntlAirtimeCountry>>> getCountries({
    bool includeInactive = false,
  }) async {
    try {
      final countries = await remoteDatasource.getCountries(
        includeInactive: includeInactive,
      );
      return Right(countries);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, IntlAirtimeOperatorsResult>> getOperators(
      String countryCode) async {
    try {
      final result = await remoteDatasource.getOperators(countryCode);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, IntlAirtimeOperator>> autoDetectOperator(
      String phoneNumber, String countryCode) async {
    try {
      final operator =
          await remoteDatasource.autoDetectOperator(phoneNumber, countryCode);
      if (operator == null) {
        return Left(ServerFailure(
          message: 'Could not detect operator for this number',
          statusCode: 422,
        ));
      }
      return Right(operator);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, IntlAirtimePurchaseResult>> buyIntlAirtime({
    required String accountId,
    required String operatorId,
    required String countryCode,
    required String phoneNumber,
    required double amount,
    required String senderCurrency,
    bool useLocalAmount = false,
    double destAmount = 0,
    required String destCurrency,
    required double fxRateSnapshot,
    String variationCode = '',
    required String pin,
    required String idempotencyKey,
  }) async {
    try {
      final result = await remoteDatasource.buyIntlAirtime(
        accountId: accountId,
        operatorId: operatorId,
        countryCode: countryCode,
        phoneNumber: phoneNumber,
        amount: amount,
        senderCurrency: senderCurrency,
        useLocalAmount: useLocalAmount,
        destAmount: destAmount,
        destCurrency: destCurrency,
        fxRateSnapshot: fxRateSnapshot,
        variationCode: variationCode,
        pin: pin,
        idempotencyKey: idempotencyKey,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }
}
