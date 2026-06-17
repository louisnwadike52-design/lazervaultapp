import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import 'package:lazervault/src/core/network/grpc_client.dart';
import '../../domain/entities/intl_data_bundle.dart';
import '../../domain/entities/intl_data_operator.dart';

/// Thin gRPC-client wrapper for the international data bundle RPCs.
/// Speaks to the backend endpoints exposed at
/// /api/v1/bills/intl-data/{operators,bundles,buy} via the
/// UtilityPaymentsService gRPC client. All calls are auth-gated by the
/// existing GrpcClient interceptor chain.
abstract class IntlDataRemoteDataSource {
  Future<IntlDataOperatorsPage> getOperators(String countryCode);
  Future<List<IntlDataBundle>> getBundles(String operatorId);
  Future<IntlDataPurchaseResult> buyBundle({
    required String accountId,
    required String idempotencyKey,
    required String operatorId,
    required String bundleId,
    required String countryCode,
    required String phoneNumber,
    required double amount,
    required String senderCurrency,
    required String destCurrency,
    required double destAmount,
    required double fxRateSnapshot,
    required String pin,
  });
}

class IntlDataOperatorsPage {
  final List<IntlDataOperator> operators;
  final String countryName;
  final String currencyCode;
  final String currencySymbol;
  const IntlDataOperatorsPage({
    required this.operators,
    required this.countryName,
    required this.currencyCode,
    required this.currencySymbol,
  });
}

class IntlDataPurchaseResult {
  final String paymentId;
  final String reference;
  final String status;
  final double amountPaid;
  final String senderCurrency;
  final double deliveredAmount;
  final String deliveredCurrency;
  final double fxRateUsed;
  final String phoneNumber;
  final String message;
  const IntlDataPurchaseResult({
    required this.paymentId,
    required this.reference,
    required this.status,
    required this.amountPaid,
    required this.senderCurrency,
    required this.deliveredAmount,
    required this.deliveredCurrency,
    required this.fxRateUsed,
    required this.phoneNumber,
    required this.message,
  });
}

class IntlDataRemoteDataSourceImpl implements IntlDataRemoteDataSource {
  final GrpcClient grpcClient;
  IntlDataRemoteDataSourceImpl({required this.grpcClient});

  @override
  Future<IntlDataOperatorsPage> getOperators(String countryCode) async {
    final req = pb.GetIntlDataOperatorsRequest()..countryCode = countryCode;
    final opts = await grpcClient.callOptions;
    final resp = await grpcClient.utilityPaymentsClient.getIntlDataOperators(
      req,
      options: opts,
    );
    return IntlDataOperatorsPage(
      operators: resp.operators
          .map((o) => IntlDataOperator(
                id: o.id,
                countryCode: o.countryCode,
                countryName: o.countryName,
                operatorName: o.operatorName,
                senderCurrencyCode: o.senderCurrencyCode,
                destCurrencyCode: o.destCurrencyCode,
                fxRate: o.fxRate,
                logoUrl: o.logoUrl,
                isActive: o.isActive,
                bundleCount: o.bundleCount,
              ))
          .toList(),
      countryName: resp.countryName,
      currencyCode: resp.currencyCode,
      currencySymbol: resp.currencySymbol,
    );
  }

  @override
  Future<List<IntlDataBundle>> getBundles(String operatorId) async {
    final req = pb.GetIntlDataBundlesRequest()..operatorId = operatorId;
    final opts = await grpcClient.callOptions;
    final resp = await grpcClient.utilityPaymentsClient.getIntlDataBundles(
      req,
      options: opts,
    );
    return resp.bundles
        .map((b) => IntlDataBundle(
              id: b.id,
              operatorId: b.operatorId,
              amount: b.amount,
              localAmount: b.localAmount,
              description: b.description,
              destCurrencyCode: b.destCurrencyCode,
              senderCurrencyCode: b.senderCurrencyCode,
              fxRate: b.fxRate,
            ))
        .toList();
  }

  @override
  Future<IntlDataPurchaseResult> buyBundle({
    required String accountId,
    required String idempotencyKey,
    required String operatorId,
    required String bundleId,
    required String countryCode,
    required String phoneNumber,
    required double amount,
    required String senderCurrency,
    required String destCurrency,
    required double destAmount,
    required double fxRateSnapshot,
    required String pin,
  }) async {
    final req = pb.BuyIntlDataRequest()
      ..accountId = accountId
      ..idempotencyKey = idempotencyKey
      ..operatorId = operatorId
      ..bundleId = bundleId
      ..countryCode = countryCode
      ..phoneNumber = phoneNumber
      ..amount = amount
      ..senderCurrency = senderCurrency
      ..destCurrency = destCurrency
      ..destAmount = destAmount
      ..fxRateSnapshot = fxRateSnapshot
      ..transactionPin = pin;
    final opts = await grpcClient.callOptions;
    final resp = await grpcClient.utilityPaymentsClient.buyIntlData(
      req,
      options: opts,
    );
    return IntlDataPurchaseResult(
      paymentId: resp.paymentId,
      reference: resp.reference,
      status: resp.status,
      amountPaid: resp.amountPaid,
      senderCurrency: resp.senderCurrency,
      deliveredAmount: resp.deliveredAmount,
      deliveredCurrency: resp.deliveredCurrency,
      fxRateUsed: resp.fxRateUsed,
      phoneNumber: resp.phoneNumber,
      message: resp.message,
    );
  }
}
