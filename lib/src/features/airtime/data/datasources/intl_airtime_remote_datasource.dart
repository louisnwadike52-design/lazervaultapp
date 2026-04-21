import 'package:grpc/grpc.dart';
import '../../../../core/network/grpc_client.dart';
import '../../../../generated/utility-payments.pb.dart' as pb;
import '../../domain/entities/intl_airtime_country.dart';
import '../../domain/entities/intl_airtime_operator.dart';
import '../../domain/repositories/intl_airtime_repository.dart';

abstract class IntlAirtimeRemoteDatasource {
  Future<List<IntlAirtimeCountry>> getCountries({bool includeInactive = false});
  Future<IntlAirtimeOperatorsResult> getOperators(String countryCode);
  Future<IntlAirtimeOperator?> autoDetectOperator(String phoneNumber, String countryCode);
  Future<IntlAirtimePurchaseResult> buyIntlAirtime({
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
  });
}

class IntlAirtimeRemoteDatasourceImpl implements IntlAirtimeRemoteDatasource {
  final GrpcClient grpcClient;

  IntlAirtimeRemoteDatasourceImpl({required this.grpcClient});

  @override
  Future<List<IntlAirtimeCountry>> getCountries({bool includeInactive = false}) async {
    try {
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getIntlAirtimeCountries(
        pb.GetIntlAirtimeCountriesRequest(includeInactive: includeInactive),
        options: options,
      );
      return response.countries.map((c) => _mapCountry(c)).toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch countries: ${e.message}');
    }
  }

  @override
  Future<IntlAirtimeOperatorsResult> getOperators(String countryCode) async {
    try {
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getIntlAirtimeOperators(
        pb.GetIntlAirtimeOperatorsRequest(countryCode: countryCode),
        options: options,
      );
      return IntlAirtimeOperatorsResult(
        operators: response.operators.map((o) => _mapOperator(o)).toList(),
        countryName: response.countryName,
        currencyCode: response.currencyCode,
        currencySymbol: response.currencySymbol,
      );
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch operators for $countryCode: ${e.message}');
    }
  }

  @override
  Future<IntlAirtimeOperator?> autoDetectOperator(
      String phoneNumber, String countryCode) async {
    try {
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .autoDetectIntlOperator(
        pb.AutoDetectIntlOperatorRequest(
          phoneNumber: phoneNumber,
          countryCode: countryCode,
        ),
        options: options,
      );
      if (!response.detected || !response.hasOperator()) return null;
      return _mapOperator(response.operator);
    } on GrpcError catch (e) {
      throw Exception('Failed to detect operator: ${e.message}');
    }
  }

  @override
  Future<IntlAirtimePurchaseResult> buyIntlAirtime({
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
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient.buyIntlAirtime(
        pb.BuyIntlAirtimeRequest(
          accountId: accountId,
          idempotencyKey: idempotencyKey,
          operatorId: operatorId,
          countryCode: countryCode,
          phoneNumber: phoneNumber,
          amount: amount,
          senderCurrency: senderCurrency,
          useLocalAmount: useLocalAmount ? destAmount : 0,
          fxRateSnapshot: fxRateSnapshot,
          destCurrency: destCurrency,
          destAmountEstimate: destAmount,
          transactionPin: pin,
        ),
        options: options,
      );
      return IntlAirtimePurchaseResult(
        paymentId: response.paymentId,
        reference: response.reference,
        status: response.status,
        amountPaid: response.amountPaid,
        senderCurrency: response.senderCurrency,
        deliveredAmount: response.deliveredAmount,
        deliveredCurrency: response.deliveredCurrency,
        fxRateUsed: response.fxRateUsed,
        operatorName: response.operatorName,
        countryName: response.countryName,
        phoneNumber: response.phoneNumber,
        message: response.message,
      );
    } on GrpcError catch (e) {
      throw Exception('Failed to buy international airtime: ${e.message}');
    }
  }

  IntlAirtimeCountry _mapCountry(pb.IntlAirtimeCountry c) {
    return IntlAirtimeCountry(
      id: c.id,
      countryCode: c.countryCode,
      countryName: c.countryName,
      dialCode: c.dialCode,
      currencyCode: c.currencyCode,
      currencySymbol: c.currencySymbol,
      flagEmoji: c.flagEmoji,
      isActive: c.isActive,
      reloadlySupported: c.reloadlySupported,
      vtpassSupported: c.vtpassSupported,
      operatorCount: c.operatorCount,
    );
  }

  IntlAirtimeOperator _mapOperator(pb.IntlAirtimeOperator o) {
    return IntlAirtimeOperator(
      id: o.id,
      countryCode: o.countryCode,
      countryName: o.countryName,
      operatorName: o.operatorName,
      logoUrl: o.logoUrl,
      denominationType: o.denominationType,
      fixedAmounts: o.fixedAmounts,
      localFixedAmounts: o.localFixedAmounts,
      minAmount: o.minAmount,
      maxAmount: o.maxAmount,
      localMinAmount: o.localMinAmount,
      localMaxAmount: o.localMaxAmount,
      fxRate: o.fxRate,
      senderCurrencyCode: o.senderCurrencyCode,
      destCurrencyCode: o.destCurrencyCode,
      supportsLocalAmounts: o.supportsLocalAmounts,
      isActive: o.isActive,
      reloadlyOperatorId: o.reloadlyOperatorId,
      vtpassOperatorId: o.vtpassOperatorId,
    );
  }
}
