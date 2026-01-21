import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/errors/failure.dart';
import 'package:lazervault/src/features/kyc/domain/entities/kyc_tier_entity.dart';
import 'package:lazervault/src/features/kyc/domain/repositories/kyc_repository.dart';

/// KYC Cubit states
abstract class KYCState extends Equatable {
  const KYCState();

  @override
  List<Object?> get props => [];
}

class KYCInitial extends KYCState {
  const KYCInitial();
}

class KYCLoading extends KYCState {
  const KYCLoading();
}

class KYCStatusLoaded extends KYCState {
  final UserKYCProfile profile;

  const KYCStatusLoaded({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class CountryRequirementsLoaded extends KYCState {
  final CountryKYCRequirements requirements;

  const CountryRequirementsLoaded({required this.requirements});

  @override
  List<Object?> get props => [requirements];
}

class KYCInitiated extends KYCState {
  final KYCInitiationResponse response;

  const KYCInitiated({required this.response});

  @override
  List<Object?> get props => [response];
}

class IDVerificationSuccess extends KYCState {
  final VerifyIDResponse response;

  const IDVerificationSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

class DocumentsLoaded extends KYCState {
  final List<VerificationDocument> documents;

  const DocumentsLoaded({required this.documents});

  @override
  List<Object?> get props => [documents];
}

class KYCSkipped extends KYCState {
  final SkipKYCResponse response;

  const KYCSkipped({required this.response});

  @override
  List<Object?> get props => [response];
}

class KYCError extends KYCState {
  final Failure failure;
  final String? userMessage;

  const KYCError({
    required this.failure,
    this.userMessage,
  });

  @override
  List<Object?> get props => [failure, userMessage];
}

/// KYC Cubit for managing KYC state
class KYCCubit extends Cubit<KYCState> {
  final KYCRepository repository;

  KYCCubit({required this.repository}) : super(const KYCInitial());

  /// Get user's KYC status
  Future<void> getKYCStatus(String userId) async {
    emit(const KYCLoading());
    final result = await repository.getKYCStatus(userId);

    result.fold(
      (failure) => emit(KYCError(
        failure: failure,
        userMessage: _getUserMessage(failure),
      )),
      (profile) => emit(KYCStatusLoaded(profile: profile)),
    );
  }

  /// Get country requirements
  Future<void> getCountryRequirements(String countryCode) async {
    emit(const KYCLoading());
    final result = await repository.getCountryRequirements(countryCode);

    result.fold(
      (failure) => emit(KYCError(
        failure: failure,
        userMessage: _getUserMessage(failure),
      )),
      (requirements) =>
          emit(CountryRequirementsLoaded(requirements: requirements)),
    );
  }

  /// Initiate KYC verification
  Future<void> initiateKYC({
    required String userId,
    required KYCTier targetTier,
  }) async {
    emit(const KYCLoading());
    final result = await repository.initiateKYC(
      userId: userId,
      targetTier: targetTier,
    );

    result.fold(
      (failure) => emit(KYCError(
        failure: failure,
        userMessage: _getUserMessage(failure),
      )),
      (response) => emit(KYCInitiated(response: response)),
    );
  }

  /// Verify ID (BVN, NIN, etc.)
  Future<void> verifyID(IDVerificationRequest request) async {
    emit(const KYCLoading());
    final result = await repository.verifyID(request);

    result.fold(
      (failure) => emit(KYCError(
        failure: failure,
        userMessage: _getUserMessage(failure),
      )),
      (response) => emit(IDVerificationSuccess(response: response)),
    );
  }

  /// Upload document
  Future<void> uploadDocument(DocumentUploadRequest request) async {
    emit(const KYCLoading());
    final result = await repository.uploadDocument(request);

    result.fold(
      (failure) => emit(KYCError(
        failure: failure,
        userMessage: _getUserMessage(failure),
      )),
      (response) => emit(IDVerificationSuccess(response: response)),
    );
  }

  /// Get user documents
  Future<void> getUserDocuments(String userId) async {
    emit(const KYCLoading());
    final result = await repository.getUserDocuments(userId);

    result.fold(
      (failure) => emit(KYCError(
        failure: failure,
        userMessage: _getUserMessage(failure),
      )),
      (documents) => emit(DocumentsLoaded(documents: documents)),
    );
  }

  /// Skip KYC upgrade
  Future<void> skipKYCUpgrade({
    required String userId,
    bool skipTier2 = true,
  }) async {
    emit(const KYCLoading());
    final result = await repository.skipKYCUpgrade(
      userId: userId,
      skipTier2: skipTier2,
    );

    result.fold(
      (failure) => emit(KYCError(
        failure: failure,
        userMessage: _getUserMessage(failure),
      )),
      (response) => emit(KYCSkipped(response: response)),
    );
  }

  /// Reset to initial state
  void reset() {
    emit(const KYCInitial());
  }

  /// Convert technical failures to user-friendly messages
  String _getUserMessage(Failure failure) {
    switch (failure.statusCode) {
      case 400:
        return 'Invalid information provided. Please check and try again.';
      case 401:
        return 'Session expired. Please log in again.';
      case 403:
        return 'You are not authorized to perform this action.';
      case 404:
        return 'Requested resource not found.';
      case 409:
        return 'This information has already been used.';
      case 422:
        return 'ID verification failed. Please check your details and try again.';
      case 429:
        return 'Too many attempts. Please try again later.';
      case 500:
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
