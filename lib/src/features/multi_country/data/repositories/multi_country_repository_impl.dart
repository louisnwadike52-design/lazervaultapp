import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/features/multi_country/domain/entities/locale_account_group.dart';
import 'package:lazervault/src/features/multi_country/domain/repositories/i_multi_country_repository.dart';
import 'package:lazervault/src/generated/multi_country.pbgrpc.dart';
import 'package:lazervault/src/generated/multi_country.pb.dart' as pb;

class MultiCountryRepositoryImpl implements IMultiCountryRepository {
  final MultiCountryAccountServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  MultiCountryRepositoryImpl(this._client, this._callOptionsHelper);

  @override
  Future<Either<Failure, ({
    List<LocaleAccountGroupEntity> locales,
    String activeLocale,
    String signupLocale,
  })>> getAccountsByLocale() async {
    try {
      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final request = pb.GetAccountsByLocaleRequest();
        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.getAccountsByLocale(request, options: callOptions);
      });

      final locales = response.locales
          .map(LocaleAccountGroupEntity.fromProto)
          .toList();

      // Sort: signup locale first, then locales with accounts, then others
      locales.sort((a, b) {
        if (a.isSignupLocale) return -1;
        if (b.isSignupLocale) return 1;
        if (a.hasAccounts && !b.hasAccounts) return -1;
        if (!a.hasAccounts && b.hasAccounts) return 1;
        return a.countryName.compareTo(b.countryName);
      });

      return Right((
        locales: locales,
        activeLocale: response.activeLocale,
        signupLocale: response.signupLocale,
      ));
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Failed to fetch accounts by locale.',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'An unexpected error occurred.',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, LocaleAccountEntity>> createLocaleAccount({
    required String locale,
    String? accountType,
    String? accountName,
  }) async {
    try {
      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final request = pb.CreateLocaleAccountRequest()
          ..locale = locale;
        if (accountType != null) request.accountType = accountType;
        if (accountName != null) request.accountName = accountName;

        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.createLocaleAccount(request, options: callOptions);
      });

      if (!response.hasAccount()) {
        return Left(ServerFailure(
          message: response.message,
          statusCode: 400,
        ));
      }

      return Right(LocaleAccountEntity.fromProto(response.account));
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Failed to create locale account.',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'An unexpected error occurred.',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, List<SupportedLocaleEntity>>> getSupportedLocales() async {
    try {
      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final request = pb.GetSupportedLocalesRequest();
        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.getSupportedLocales(request, options: callOptions);
      });

      final locales = response.locales
          .map(SupportedLocaleEntity.fromProto)
          .toList();

      return Right(locales);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Failed to fetch supported locales.',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'An unexpected error occurred.',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, ({String locale, String countryCode, String currencyCode, String signupLocale})>> getUserLocale() async {
    try {
      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final request = pb.GetUserLocaleRequest();
        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.getUserLocale(request, options: callOptions);
      });

      return Right((
        locale: response.locale,
        countryCode: response.countryCode,
        currencyCode: response.currencyCode,
        signupLocale: response.signupLocale,
      ));
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Failed to get user locale.',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'An unexpected error occurred.',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, String>> setUserLocale(String locale) async {
    try {
      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final request = pb.SetUserLocaleRequest()..locale = locale;
        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.setUserLocale(request, options: callOptions);
      });

      return Right(response.locale);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Failed to set user locale.',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'An unexpected error occurred.',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, ({String overallStatus, int totalLocales, int completedLocales})>> getAccountCreationStatus({String? jobId}) async {
    try {
      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final request = pb.GetAccountCreationStatusRequest();
        if (jobId != null) request.jobId = jobId;
        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.getAccountCreationStatus(request, options: callOptions);
      });

      return Right((
        overallStatus: response.overallStatus,
        totalLocales: response.totalLocales,
        completedLocales: response.completedLocales,
      ));
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Failed to get account creation status.',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'An unexpected error occurred.',
        statusCode: 500,
      ));
    }
  }
}
