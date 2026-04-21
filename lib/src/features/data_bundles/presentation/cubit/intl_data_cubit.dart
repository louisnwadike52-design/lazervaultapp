import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import '../../data/datasources/intl_data_remote_datasource.dart';
import '../../domain/entities/intl_data_bundle.dart';
import '../../domain/entities/intl_data_operator.dart';

/// Single cubit driving the consolidated intl-data purchase screen.
/// Holds the full wizard state (selected country, operators, operator,
/// bundles, bundle, recipient, purchase outcome) in one place so the
/// UI stays a single screen with progressively-revealing sections —
/// mirrors the intl_airtime consolidated pattern without splitting
/// into separate screens.
class IntlDataCubit extends Cubit<IntlDataState> {
  final IntlDataRemoteDataSource remote;
  IntlDataCubit({required this.remote}) : super(const IntlDataState());

  Future<void> loadOperators(String countryCode, String countryName) async {
    emit(state.copyWith(
      selectedCountryCode: countryCode,
      selectedCountryName: countryName,
      operatorsLoading: true,
      operatorsError: null,
      operators: const [],
      selectedOperator: null,
      bundles: const [],
      selectedBundle: null,
    ));
    try {
      final page = await remote.getOperators(countryCode);
      emit(state.copyWith(
        operatorsLoading: false,
        operators: page.operators,
        currencyCode: page.currencyCode,
        currencySymbol: page.currencySymbol,
      ));
    } on GrpcError catch (e) {
      emit(state.copyWith(
        operatorsLoading: false,
        operatorsError: e.message ?? 'Failed to load operators',
      ));
    } catch (e) {
      emit(state.copyWith(operatorsLoading: false, operatorsError: e.toString()));
    }
  }

  Future<void> loadBundles(IntlDataOperator op) async {
    emit(state.copyWith(
      selectedOperator: op,
      bundlesLoading: true,
      bundlesError: null,
      bundles: const [],
      selectedBundle: null,
    ));
    try {
      final bundles = await remote.getBundles(op.id);
      emit(state.copyWith(bundlesLoading: false, bundles: bundles));
    } on GrpcError catch (e) {
      emit(state.copyWith(
        bundlesLoading: false,
        bundlesError: e.message ?? 'Failed to load bundles',
      ));
    } catch (e) {
      emit(state.copyWith(bundlesLoading: false, bundlesError: e.toString()));
    }
  }

  void selectBundle(IntlDataBundle b) {
    emit(state.copyWith(selectedBundle: b));
  }

  void setRecipient(String phone) {
    emit(state.copyWith(recipientPhone: phone));
  }

  Future<void> buy({
    required String accountId,
    required String idempotencyKey,
    required String pin,
    String? senderCurrency,
    double? senderAmount,
  }) async {
    final op = state.selectedOperator;
    final b = state.selectedBundle;
    if (op == null || b == null || state.recipientPhone.isEmpty) {
      emit(state.copyWith(
        purchaseError: 'Please pick an operator, bundle, and recipient first.',
      ));
      return;
    }
    emit(state.copyWith(purchaseLoading: true, purchaseError: null));
    try {
      // Resolve FX: bundle-level rate (snapshotted live from Reloadly at
      // list time) takes precedence over the operator-level rate. We do
      // NOT fall back to Reloadly's sender-wallet amount — the wallet
      // debit must be in the user's active currency.
      final effectiveRate = b.fxRate > 0 ? b.fxRate : op.fxRate;
      if (effectiveRate <= 0) {
        emit(state.copyWith(
          purchaseLoading: false,
          purchaseError:
              'FX rate unavailable for this bundle. Please retry in a moment.',
        ));
        return;
      }
      // Caller (checkout screen) passes the amount in the user's active
      // locale currency; use that as-is. Fallback computes the same
      // value so repeat-purchase / async callers get consistent math.
      final effectiveAmount = senderAmount ?? (b.localAmount * effectiveRate);
      // senderCurrency here is the user's active locale currency (e.g.
      // NGN) — the backend stores this as the payment row's `currency`
      // so history renders in the debit currency, not GBP/USD.
      final effectiveSenderCurrency = senderCurrency ?? b.senderCurrencyCode;
      final res = await remote.buyBundle(
        accountId: accountId,
        idempotencyKey: idempotencyKey,
        operatorId: op.id,
        bundleId: b.id,
        countryCode: state.selectedCountryCode,
        phoneNumber: state.recipientPhone,
        amount: effectiveAmount,
        senderCurrency: effectiveSenderCurrency,
        destCurrency: b.destCurrencyCode,
        destAmount: b.localAmount,
        fxRateSnapshot: effectiveRate,
        pin: pin,
      );
      emit(state.copyWith(purchaseLoading: false, purchase: res));
    } on GrpcError catch (e) {
      emit(state.copyWith(
        purchaseLoading: false,
        purchaseError: e.message ?? 'Purchase failed. Please try again.',
      ));
    } catch (e) {
      emit(state.copyWith(purchaseLoading: false, purchaseError: e.toString()));
    }
  }

  void reset() => emit(const IntlDataState());
}

class IntlDataState extends Equatable {
  final String selectedCountryCode;
  final String selectedCountryName;
  final String currencyCode;
  final String currencySymbol;
  final bool operatorsLoading;
  final String? operatorsError;
  final List<IntlDataOperator> operators;
  final IntlDataOperator? selectedOperator;
  final bool bundlesLoading;
  final String? bundlesError;
  final List<IntlDataBundle> bundles;
  final IntlDataBundle? selectedBundle;
  final String recipientPhone;
  final bool purchaseLoading;
  final String? purchaseError;
  final IntlDataPurchaseResult? purchase;

  const IntlDataState({
    this.selectedCountryCode = '',
    this.selectedCountryName = '',
    this.currencyCode = '',
    this.currencySymbol = '',
    this.operatorsLoading = false,
    this.operatorsError,
    this.operators = const [],
    this.selectedOperator,
    this.bundlesLoading = false,
    this.bundlesError,
    this.bundles = const [],
    this.selectedBundle,
    this.recipientPhone = '',
    this.purchaseLoading = false,
    this.purchaseError,
    this.purchase,
  });

  IntlDataState copyWith({
    String? selectedCountryCode,
    String? selectedCountryName,
    String? currencyCode,
    String? currencySymbol,
    bool? operatorsLoading,
    String? operatorsError,
    List<IntlDataOperator>? operators,
    IntlDataOperator? selectedOperator,
    bool? bundlesLoading,
    String? bundlesError,
    List<IntlDataBundle>? bundles,
    IntlDataBundle? selectedBundle,
    String? recipientPhone,
    bool? purchaseLoading,
    String? purchaseError,
    IntlDataPurchaseResult? purchase,
  }) {
    return IntlDataState(
      selectedCountryCode: selectedCountryCode ?? this.selectedCountryCode,
      selectedCountryName: selectedCountryName ?? this.selectedCountryName,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      operatorsLoading: operatorsLoading ?? this.operatorsLoading,
      operatorsError: operatorsError,
      operators: operators ?? this.operators,
      selectedOperator: selectedOperator ?? this.selectedOperator,
      bundlesLoading: bundlesLoading ?? this.bundlesLoading,
      bundlesError: bundlesError,
      bundles: bundles ?? this.bundles,
      selectedBundle: selectedBundle ?? this.selectedBundle,
      recipientPhone: recipientPhone ?? this.recipientPhone,
      purchaseLoading: purchaseLoading ?? this.purchaseLoading,
      purchaseError: purchaseError,
      purchase: purchase ?? this.purchase,
    );
  }

  @override
  List<Object?> get props => [
        selectedCountryCode,
        operators,
        selectedOperator,
        bundles,
        selectedBundle,
        recipientPhone,
        operatorsLoading,
        bundlesLoading,
        purchaseLoading,
        purchase,
        operatorsError,
        bundlesError,
        purchaseError,
      ];
}
