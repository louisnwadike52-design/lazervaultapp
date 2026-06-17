import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';

import '../../data/datasources/intl_airtime_remote_datasource.dart';
import '../../domain/entities/intl_airtime_country.dart';
import 'intl_airtime_state.dart';

class IntlAirtimeCubit extends Cubit<IntlAirtimeState> {
  final IntlAirtimeRemoteDatasource _datasource;

  IntlAirtimeCubit({required IntlAirtimeRemoteDatasource datasource})
      : _datasource = datasource,
        super(const IntlAirtimeInitial());

  // ---------------------------------------------------------------------------
  // Countries
  // ---------------------------------------------------------------------------

  Future<void> loadCountries() async {
    try {
      if (isClosed) return;
      emit(const IntlAirtimeLoading());

      final countries = await _datasource.getCountries();

      if (isClosed) return;
      emit(IntlAirtimeCountriesLoaded(countries: countries));
    } catch (e) {
      if (isClosed) return;
      emit(IntlAirtimeError(message: _friendlyErrorMessage(e)));
    }
  }

  // ---------------------------------------------------------------------------
  // Operators
  // ---------------------------------------------------------------------------

  Future<void> loadOperators(
    String countryCode,
    IntlAirtimeCountry country,
  ) async {
    try {
      if (isClosed) return;
      emit(const IntlAirtimeLoading());

      final result = await _datasource.getOperators(countryCode);

      if (isClosed) return;
      emit(IntlAirtimeOperatorsLoaded(
        operators: result.operators,
        country: country,
        countryName: result.countryName.isNotEmpty
            ? result.countryName
            : country.countryName,
        currencyCode: result.currencyCode.isNotEmpty
            ? result.currencyCode
            : country.currencyCode,
        currencySymbol: result.currencySymbol.isNotEmpty
            ? result.currencySymbol
            : country.currencySymbol,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(IntlAirtimeError(message: _friendlyErrorMessage(e)));
    }
  }

  // ---------------------------------------------------------------------------
  // Auto-detect operator
  // ---------------------------------------------------------------------------

  Future<void> autoDetectOperator(
    String phoneNumber,
    String countryCode,
  ) async {
    try {
      if (isClosed) return;
      emit(const IntlAirtimeLoading());

      final operator =
          await _datasource.autoDetectOperator(phoneNumber, countryCode);

      if (isClosed) return;
      if (operator != null) {
        emit(IntlAirtimeOperatorDetected(operator: operator));
      } else {
        emit(const IntlAirtimeError(
            message: 'Could not detect operator for this number'));
      }
    } catch (e) {
      if (isClosed) return;
      emit(IntlAirtimeError(message: _friendlyErrorMessage(e)));
    }
  }

  // ---------------------------------------------------------------------------
  // Purchase
  // ---------------------------------------------------------------------------

  Future<void> buyIntlAirtime({
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
      if (isClosed) return;
      emit(const IntlAirtimePurchasing());

      final result = await _datasource.buyIntlAirtime(
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

      if (isClosed) return;
      emit(IntlAirtimePurchaseSuccess(
        paymentId: result.paymentId,
        reference: result.reference,
        status: result.status,
        amountPaid: result.amountPaid > 0 ? result.amountPaid : amount,
        senderCurrency: result.senderCurrency.isNotEmpty
            ? result.senderCurrency
            : senderCurrency,
        deliveredAmount: result.deliveredAmount,
        deliveredCurrency: result.deliveredCurrency.isNotEmpty
            ? result.deliveredCurrency
            : destCurrency,
        fxRateUsed:
            result.fxRateUsed > 0 ? result.fxRateUsed : fxRateSnapshot,
        operatorName: result.operatorName,
        countryName: result.countryName,
        phoneNumber:
            result.phoneNumber.isNotEmpty ? result.phoneNumber : phoneNumber,
      ));
    } catch (e) {
      if (isClosed) return;
      if (_isNetworkError(e)) {
        emit(const IntlAirtimeError(
          message:
              'No internet connection. Please check your network and try again.',
        ));
      } else {
        emit(IntlAirtimeError(message: _friendlyErrorMessage(e)));
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Reset
  // ---------------------------------------------------------------------------

  void reset() {
    if (isClosed) return;
    emit(const IntlAirtimeInitial());
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  bool _isNetworkError(dynamic error) {
    if (error is GrpcError) {
      return error.code == StatusCode.unavailable ||
          error.code == StatusCode.deadlineExceeded ||
          error.code == StatusCode.unknown;
    }
    final errorStr = error.toString().toLowerCase();
    return errorStr.contains('network') ||
        errorStr.contains('connection') ||
        errorStr.contains('timeout') ||
        errorStr.contains('unavailable') ||
        errorStr.contains('failed to connect') ||
        errorStr.contains('socket') ||
        errorStr.contains('unreachable');
  }

  String _friendlyErrorMessage(dynamic error) {
    if (_isNetworkError(error)) {
      return 'No internet connection. Please check your network and try again.';
    }
    if (error is GrpcError) {
      switch (error.code) {
        case StatusCode.permissionDenied:
          return 'Transaction not authorized. Please verify your PIN and try again.';
        case StatusCode.invalidArgument:
          return 'Invalid transaction details. Please check and try again.';
        case StatusCode.resourceExhausted:
          return 'Too many requests. Please wait a moment and try again.';
        case StatusCode.notFound:
          return 'Service not available. Please try again later.';
        default:
          return error.message ?? 'Something went wrong. Please try again.';
      }
    }
    final msg = error.toString();
    if (msg.contains('Exception:')) {
      return msg.replaceFirst(RegExp(r'^Exception:\s*'), '');
    }
    return msg;
  }
}
