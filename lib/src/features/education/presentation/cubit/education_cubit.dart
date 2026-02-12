import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import '../../domain/repositories/education_repository.dart';
import 'education_state.dart';

class EducationCubit extends Cubit<EducationState> {
  final EducationRepository repository;

  EducationCubit({required this.repository}) : super(EducationInitial());

  Future<void> getProviders() async {
    try {
      if (isClosed) return;
      emit(EducationLoading());

      final result = await repository.getProviders(activeOnly: true);

      if (isClosed) return;
      result.fold(
        (failure) => emit(EducationError(message: failure.message)),
        (providers) => emit(EducationProvidersLoaded(providers: providers)),
      );
    } catch (e) {
      if (isClosed) return;
      emit(EducationError(message: _friendlyErrorMessage(e)));
    }
  }

  Future<void> purchasePin({
    required String serviceId,
    required int quantity,
    required String phone,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  }) async {
    try {
      if (isClosed) return;
      emit(const EducationPurchaseProcessing(
        progress: 0.2,
        currentStep: 'Validating purchase details...',
      ));

      await Future.delayed(const Duration(milliseconds: 500));
      if (isClosed) return;
      emit(const EducationPurchaseProcessing(
        progress: 0.3,
        currentStep: 'Verifying account balance...',
      ));

      await Future.delayed(const Duration(milliseconds: 400));
      if (isClosed) return;
      emit(const EducationPurchaseProcessing(
        progress: 0.5,
        currentStep: 'Processing payment...',
      ));

      final result = await repository.purchasePin(
        serviceId: serviceId,
        quantity: quantity,
        phone: phone,
        transactionId: transactionId,
        verificationToken: verificationToken,
        idempotencyKey: idempotencyKey,
      );

      if (isClosed) return;
      emit(const EducationPurchaseProcessing(
        progress: 0.8,
        currentStep: 'Generating PINs...',
      ));

      await Future.delayed(const Duration(milliseconds: 300));
      if (isClosed) return;

      result.fold(
        (failure) => emit(EducationPurchaseFailed(message: failure.message)),
        (purchase) {
          if (purchase.isCompleted) {
            emit(EducationPurchaseSuccess(purchase: purchase));
          } else if (purchase.isFailed) {
            emit(EducationPurchaseFailed(
              message: purchase.message.isNotEmpty
                  ? purchase.message
                  : 'Purchase failed. Please try again.',
            ));
          } else {
            emit(EducationPurchaseSuccess(purchase: purchase));
          }
        },
      );
    } catch (e) {
      if (isClosed) return;
      if (_isNetworkError(e)) {
        emit(const EducationPurchaseFailed(
          message: 'No internet connection. Please check your network and try again.',
        ));
      } else {
        emit(EducationPurchaseFailed(message: _friendlyErrorMessage(e)));
      }
    }
  }

  void reset() {
    if (isClosed) return;
    emit(EducationInitial());
  }

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
          return 'Invalid purchase details. Please check and try again.';
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
