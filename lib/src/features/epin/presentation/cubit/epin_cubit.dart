import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import '../../../../../core/services/account_manager.dart';
import '../../../../../core/utils/friendly_error.dart';
import '../../domain/repositories/epin_repository.dart';
import 'epin_state.dart';

class EPinCubit extends Cubit<EPinState> {
  final EPinRepository repository;
  final AccountManager? _accountManager;

  EPinCubit({
    required this.repository,
    AccountManager? accountManager,
  })  : _accountManager = accountManager,
        super(const EPinInitial());

  Future<void> loadNetworks() async {
    if (isClosed) return;
    emit(const EPinNetworksLoading());
    try {
      final networks = await repository.getNetworks();
      if (isClosed) return;
      emit(EPinNetworksLoaded(
        networks: networks.where((n) => n.isActive).toList(),
      ));
    } catch (e) {
      if (isClosed) return;
      emit(EPinNetworksError(message: _friendlyError(e)));
    }
  }

  /// Purchase recharge cards. The PIN has already been validated by the caller
  /// (review screen) which passes the [verificationToken] + [transactionId].
  /// The [idempotencyKey] must be stable across retries of the same attempt.
  Future<void> purchase({
    required String network,
    required double denomination,
    required int quantity,
    required String sourceAccountId,
    required String phoneNumber,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
    String businessName = '',
  }) async {
    try {
      if (isClosed) return;
      emit(const EPinPurchaseProcessing(
        progress: 0.1,
        currentStep: 'Payment Initiated',
      ));

      if (_accountManager != null) {
        _accountManager!.setActiveAccount(sourceAccountId);
      }

      await Future.delayed(Duration.zero);
      if (isClosed) return;
      emit(const EPinPurchaseProcessing(
        progress: 0.4,
        currentStep: 'Confirming Details',
      ));

      await Future.delayed(Duration.zero);
      if (isClosed) return;
      emit(const EPinPurchaseProcessing(
        progress: 0.6,
        currentStep: 'Printing Cards',
      ));

      final result = await repository.initiatePurchase(
        network: network,
        denomination: denomination,
        quantity: quantity,
        sourceAccountId: sourceAccountId,
        phoneNumber: phoneNumber,
        transactionId: transactionId,
        verificationToken: verificationToken,
        idempotencyKey: idempotencyKey,
        businessName: businessName,
      );

      if (isClosed) return;
      if (result.order.isFailed) {
        emit(EPinPurchaseFailed(
          message: result.message.isNotEmpty
              ? sanitizeUserFacingError(result.message)
              : 'Recharge card printing failed',
        ));
        return;
      }

      emit(const EPinPurchaseProcessing(
        progress: 1.0,
        currentStep: 'Cards Ready',
      ));
      emit(EPinPurchaseSuccess(
        order: result.order,
        message: result.message,
      ));
    } catch (e) {
      if (isClosed) return;
      if (_isNetworkError(e)) {
        emit(const EPinPurchaseFailed(
          message:
              'No internet connection. Please check your network and try again.',
        ));
      } else {
        emit(EPinPurchaseFailed(message: _friendlyError(e)));
      }
    }
  }

  Future<void> loadOrders() async {
    if (isClosed) return;
    emit(const EPinOrdersLoading());
    try {
      final orders = await repository.listOrders();
      if (isClosed) return;
      emit(EPinOrdersLoaded(orders: orders));
    } catch (e) {
      if (isClosed) return;
      emit(EPinOrdersError(message: _friendlyError(e)));
    }
  }

  /// Re-open a single order to reveal its generated PINs.
  Future<void> loadOrder(String orderId) async {
    if (isClosed) return;
    emit(const EPinOrderLoading());
    try {
      final order = await repository.getOrder(orderId);
      if (isClosed) return;
      emit(EPinOrderLoaded(order: order));
    } catch (e) {
      if (isClosed) return;
      emit(EPinOrderError(message: _friendlyError(e)));
    }
  }

  bool _isNetworkError(dynamic error) => isNetworkError(error);

  /// Canonical error mapping (see `core/utils/friendly_error.dart`): network and
  /// frozen/suspended account get their platform-standard lines; business codes
  /// (FailedPrecondition / InvalidArgument) pass the backend's clean, actionable
  /// message through `sanitizeUserFacingError` (which strips anything technical);
  /// everything else is a safe generic. Raw `DEBIT_FAILED …` / rpc text never
  /// reaches the UI.
  String _friendlyError(dynamic error) {
    if (isNetworkError(error)) return networkErrorMessage;
    if (isFrozenAccountError(error)) return frozenAccountMessage;
    if (error is GrpcError) {
      switch (error.code) {
        case StatusCode.unauthenticated:
          return 'Your session has expired. Please sign in again.';
        case StatusCode.permissionDenied:
          return 'Transaction not authorized. Please verify your PIN and try again.';
        case StatusCode.resourceExhausted:
          return 'Too many requests. Please wait a moment and try again.';
        case StatusCode.failedPrecondition:
        case StatusCode.invalidArgument:
          return sanitizeUserFacingError(error.message);
        default:
          return 'Something went wrong. Please try again.';
      }
    }
    return sanitizeUserFacingError(error.toString());
  }
}
