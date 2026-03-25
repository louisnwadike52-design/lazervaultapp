import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/data_bundles_repository.dart';
import 'auto_renew_state.dart';

class AutoRenewCubit extends Cubit<AutoRenewState> {
  final DataBundlesRepository repository;
  bool _isOperating = false;

  AutoRenewCubit({required this.repository}) : super(AutoRenewInitial());

  Future<void> loadAutoRenewSubscriptions() async {
    if (isClosed) return;
    emit(AutoRenewLoading());

    try {
      final result = await repository.getAutoRenewSubscriptions();

      if (isClosed) return;
      result.fold(
        (failure) => emit(AutoRenewError(message: failure.message)),
        (subs) => emit(AutoRenewLoaded(subscriptions: subs)),
      );
    } catch (e) {
      if (isClosed) return;
      emit(AutoRenewError(message: 'Failed to load subscriptions. Please try again.'));
    }
  }

  Future<void> enableAutoRenew({
    required String subscriptionId,
    required String variationId,
    required String network,
    required double amount,
  }) async {
    if (isClosed || _isOperating) return;
    _isOperating = true;
    emit(AutoRenewToggling());

    try {
      // Validate inputs before making API call
      if (subscriptionId.isEmpty) {
        emit(AutoRenewError(message: 'Invalid subscription'));
        _isOperating = false;
        return;
      }
      if (variationId.isEmpty || network.isEmpty || amount <= 0) {
        emit(AutoRenewError(message: 'Invalid plan details for auto-renewal'));
        _isOperating = false;
        return;
      }

      final result = await repository.enableAutoRenew(
        subscriptionId: subscriptionId,
        variationId: variationId,
        network: network,
        amount: amount,
      );

      if (isClosed) return;
      result.fold(
        (failure) => emit(AutoRenewError(message: failure.message)),
        (_) => emit(AutoRenewToggled(
          enabled: true,
          message: 'Auto-renewal enabled. Your data will never expire!',
        )),
      );
    } catch (e) {
      if (isClosed) return;
      emit(AutoRenewError(message: 'Failed to enable auto-renewal. Please try again.'));
    } finally {
      _isOperating = false;
    }
  }

  Future<void> disableAutoRenew({required String subscriptionId}) async {
    if (isClosed || _isOperating) return;
    _isOperating = true;
    emit(AutoRenewToggling());

    try {
      if (subscriptionId.isEmpty) {
        emit(AutoRenewError(message: 'Invalid subscription'));
        _isOperating = false;
        return;
      }

      final result = await repository.disableAutoRenew(
        subscriptionId: subscriptionId,
      );

      if (isClosed) return;
      result.fold(
        (failure) => emit(AutoRenewError(message: failure.message)),
        (_) => emit(AutoRenewToggled(
          enabled: false,
          message: 'Auto-renewal disabled.',
        )),
      );
    } catch (e) {
      if (isClosed) return;
      emit(AutoRenewError(message: 'Failed to disable auto-renewal. Please try again.'));
    } finally {
      _isOperating = false;
    }
  }

  void reset() {
    if (isClosed) return;
    _isOperating = false;
    emit(AutoRenewInitial());
  }
}
