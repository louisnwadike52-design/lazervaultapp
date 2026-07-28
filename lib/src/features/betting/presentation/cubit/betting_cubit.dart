import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import '../../../../../core/services/account_manager.dart';
import '../../../../../core/utils/friendly_error.dart';
import '../../domain/repositories/betting_repository.dart';
import 'betting_state.dart';

class BettingCubit extends Cubit<BettingState> {
  final BettingRepository repository;
  final AccountManager? _accountManager;

  BettingCubit({
    required this.repository,
    AccountManager? accountManager,
  })  : _accountManager = accountManager,
        super(const BettingInitial());

  Future<void> loadPlatforms() async {
    if (isClosed) return;
    emit(const BettingPlatformsLoading());
    try {
      final platforms = await repository.getPlatforms();
      if (isClosed) return;
      emit(BettingPlatformsLoaded(
        platforms: platforms.where((p) => p.isActive).toList(),
      ));
    } catch (e) {
      if (isClosed) return;
      emit(BettingPlatformsError(message: _friendlyError(e)));
    }
  }

  Future<void> verifyAccount({
    required String platform,
    required String accountUserid,
  }) async {
    if (isClosed) return;
    emit(const BettingAccountVerifying());
    try {
      final result = await repository.verifyAccount(
        platform: platform,
        accountUserid: accountUserid,
      );
      if (isClosed) return;
      emit(BettingAccountVerified(verification: result));
    } catch (e) {
      if (isClosed) return;
      emit(BettingAccountVerifyError(message: _friendlyError(e)));
    }
  }

  /// Fund a betting account. PIN already validated by the caller; the
  /// [idempotencyKey] must be stable across retries of the same attempt.
  Future<void> fund({
    required String platform,
    required String accountUserid,
    required String accountName,
    required double amount,
    required String sourceAccountId,
    required String phoneNumber,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
    required bool saveBeneficiary,
    String? nickname,
  }) async {
    try {
      if (isClosed) return;
      emit(const BettingFundingProcessing(
        progress: 0.1,
        currentStep: 'Payment Initiated',
      ));

      if (_accountManager != null) {
        _accountManager!.setActiveAccount(sourceAccountId);
      }

      await Future.delayed(Duration.zero);
      if (isClosed) return;
      emit(const BettingFundingProcessing(
        progress: 0.4,
        currentStep: 'Confirming Details',
      ));

      await Future.delayed(Duration.zero);
      if (isClosed) return;
      emit(const BettingFundingProcessing(
        progress: 0.6,
        currentStep: 'Funding Account',
      ));

      final result = await repository.initiateFunding(
        platform: platform,
        accountUserid: accountUserid,
        accountName: accountName,
        amount: amount,
        sourceAccountId: sourceAccountId,
        phoneNumber: phoneNumber,
        transactionId: transactionId,
        verificationToken: verificationToken,
        idempotencyKey: idempotencyKey,
        saveBeneficiary: saveBeneficiary,
        nickname: nickname,
      );

      if (isClosed) return;
      if (result.payment.isFailed) {
        emit(BettingFundingFailed(
          message: result.message.isNotEmpty
              ? sanitizeUserFacingError(result.message)
              : 'Funding failed',
        ));
        return;
      }

      emit(const BettingFundingProcessing(
        progress: 1.0,
        currentStep: 'Wallet Funded',
      ));
      emit(BettingFundingSuccess(result: result));
    } catch (e) {
      if (isClosed) return;
      if (_isNetworkError(e)) {
        emit(const BettingFundingFailed(
          message:
              'No internet connection. Please check your network and try again.',
        ));
      } else {
        emit(BettingFundingFailed(message: _friendlyError(e)));
      }
    }
  }

  Future<void> loadHistory() async {
    if (isClosed) return;
    emit(const BettingHistoryLoading());
    try {
      final records = await repository.getHistory();
      if (isClosed) return;
      emit(BettingHistoryLoaded(records: records));
    } catch (e) {
      if (isClosed) return;
      emit(BettingHistoryError(message: _friendlyError(e)));
    }
  }

  Future<void> loadBeneficiaries() async {
    if (isClosed) return;
    emit(const BettingBeneficiariesLoading());
    try {
      final list = await repository.getBeneficiaries();
      if (isClosed) return;
      emit(BettingBeneficiariesLoaded(beneficiaries: list));
    } catch (e) {
      if (isClosed) return;
      emit(BettingBeneficiariesError(message: _friendlyError(e)));
    }
  }

  Future<void> deleteBeneficiary(String beneficiaryId) async {
    try {
      await repository.deleteBeneficiary(beneficiaryId);
      await loadBeneficiaries();
    } catch (e) {
      if (isClosed) return;
      emit(BettingBeneficiariesError(message: _friendlyError(e)));
    }
  }

  bool _isNetworkError(dynamic error) => isNetworkError(error);

  /// Canonical error mapping (see `core/utils/friendly_error.dart`): network and
  /// frozen/suspended account get their platform-standard lines; business codes
  /// (FailedPrecondition / InvalidArgument) pass the backend's clean, actionable
  /// message through `sanitizeUserFacingError`; everything else is a safe
  /// generic. Raw `DEBIT_FAILED …` / rpc text never reaches the UI.
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
