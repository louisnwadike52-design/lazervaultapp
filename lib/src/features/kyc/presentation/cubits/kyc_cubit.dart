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

class VerificationSessionCreated extends KYCState {
  final VerificationSession session;

  const VerificationSessionCreated({required this.session});

  @override
  List<Object?> get props => [session];
}

class VerificationConfirmed extends KYCState {
  final ConfirmVerificationResult result;

  const VerificationConfirmed({required this.result});

  @override
  List<Object?> get props => [result];
}

class DocumentUploadURLReady extends KYCState {
  final DocumentUploadURL uploadURL;

  const DocumentUploadURLReady({required this.uploadURL});

  @override
  List<Object?> get props => [uploadURL];
}

class DocumentsSubmitted extends KYCState {
  final String message;

  const DocumentsSubmitted({required this.message});

  @override
  List<Object?> get props => [message];
}

class NameConfirmationRequired extends KYCState {
  final String verificationId;
  final String verifiedName;
  final String profileName;
  final double matchScore;

  const NameConfirmationRequired({
    required this.verificationId,
    required this.verifiedName,
    required this.profileName,
    required this.matchScore,
  });

  @override
  List<Object?> get props => [verificationId, verifiedName, profileName, matchScore];
}

class BVNNameConfirmed extends KYCState {
  final String message;

  const BVNNameConfirmed({required this.message});

  @override
  List<Object?> get props => [message];
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
    if (isClosed) return;
    emit(const KYCLoading());
    final result = await repository.getKYCStatus(userId);

    result.fold(
      (failure) {
        if (!isClosed) emit(KYCError(failure: failure, userMessage: _getUserMessage(failure)));
      },
      (profile) {
        if (!isClosed) emit(KYCStatusLoaded(profile: profile));
      },
    );
  }

  /// Get country requirements
  Future<void> getCountryRequirements(String countryCode) async {
    if (isClosed) return;
    emit(const KYCLoading());
    final result = await repository.getCountryRequirements(countryCode);

    result.fold(
      (failure) {
        if (!isClosed) emit(KYCError(failure: failure, userMessage: _getUserMessage(failure)));
      },
      (requirements) {
        if (!isClosed) emit(CountryRequirementsLoaded(requirements: requirements));
      },
    );
  }

  /// Initiate KYC verification
  Future<void> initiateKYC({
    required String userId,
    required KYCTier targetTier,
  }) async {
    if (isClosed) return;
    emit(const KYCLoading());
    final result = await repository.initiateKYC(
      userId: userId,
      targetTier: targetTier,
    );

    result.fold(
      (failure) {
        if (!isClosed) emit(KYCError(failure: failure, userMessage: _getUserMessage(failure)));
      },
      (response) {
        if (!isClosed) emit(KYCInitiated(response: response));
      },
    );
  }

  /// Verify ID (BVN, NIN, etc.)
  Future<void> verifyID(IDVerificationRequest request) async {
    if (isClosed) return;
    emit(const KYCLoading());
    final result = await repository.verifyID(request);

    result.fold(
      (failure) {
        if (!isClosed) emit(KYCError(failure: failure, userMessage: _getUserMessage(failure)));
      },
      (response) {
        if (!isClosed) emit(IDVerificationSuccess(response: response));
      },
    );
  }

  /// Upload document
  Future<void> uploadDocument(DocumentUploadRequest request) async {
    if (isClosed) return;
    emit(const KYCLoading());
    final result = await repository.uploadDocument(request);

    result.fold(
      (failure) {
        if (!isClosed) emit(KYCError(failure: failure, userMessage: _getUserMessage(failure)));
      },
      (response) {
        if (!isClosed) emit(IDVerificationSuccess(response: response));
      },
    );
  }

  /// Get user documents
  Future<void> getUserDocuments(String userId) async {
    if (isClosed) return;
    emit(const KYCLoading());
    final result = await repository.getUserDocuments(userId);

    result.fold(
      (failure) {
        if (!isClosed) emit(KYCError(failure: failure, userMessage: _getUserMessage(failure)));
      },
      (documents) {
        if (!isClosed) emit(DocumentsLoaded(documents: documents));
      },
    );
  }

  /// Skip KYC upgrade
  Future<void> skipKYCUpgrade({
    required String userId,
    bool skipTier2 = true,
  }) async {
    if (isClosed) return;
    emit(const KYCLoading());
    final result = await repository.skipKYCUpgrade(
      userId: userId,
      skipTier2: skipTier2,
    );

    result.fold(
      (failure) {
        if (!isClosed) emit(KYCError(failure: failure, userMessage: _getUserMessage(failure)));
      },
      (response) {
        if (!isClosed) emit(KYCSkipped(response: response));
      },
    );
  }

  /// Create a verification session with an external provider
  Future<void> createVerificationSession({
    required String userId,
    required KYCTier targetTier,
    required String countryCode,
    required IDType idType,
    required String idNumber,
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    String? phoneNumber,
  }) async {
    if (isClosed) return;
    emit(const KYCLoading());
    final result = await repository.createVerificationSession(
      userId: userId,
      targetTier: targetTier,
      countryCode: countryCode,
      idType: idType,
      idNumber: idNumber,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      phoneNumber: phoneNumber,
    );

    result.fold(
      (failure) {
        if (!isClosed) emit(KYCError(failure: failure, userMessage: _getUserMessage(failure)));
      },
      (session) {
        if (!isClosed) emit(VerificationSessionCreated(session: session));
      },
    );
  }

  /// Confirm a verification session after provider callback
  Future<void> confirmVerification({
    required String verificationId,
    required String provider,
    String? providerAuthCode,
    Map<String, String>? metadata,
  }) async {
    if (isClosed) return;
    emit(const KYCLoading());
    final result = await repository.confirmVerification(
      verificationId: verificationId,
      provider: provider,
      providerAuthCode: providerAuthCode,
      metadata: metadata,
    );

    result.fold(
      (failure) {
        if (!isClosed) emit(KYCError(failure: failure, userMessage: _getUserMessage(failure)));
      },
      (confirmResult) {
        final recon = confirmResult.bvnNameReconciliation;
        final needsNameConfirm = confirmResult.message == 'name_confirmation_required' ||
            (recon != null && recon.nameAction == 'confirm');
        if (needsNameConfirm) {
          if (!isClosed) {
            emit(NameConfirmationRequired(
              verificationId: verificationId,
              verifiedName: recon?.verifiedName ?? '',
              profileName: recon?.profileName ?? '',
              matchScore: recon?.nameMatchScore ?? 0.0,
            ));
          }
        } else {
          if (!isClosed) emit(VerificationConfirmed(result: confirmResult));
        }
      },
    );
  }

  /// Confirm BVN name after reconciliation dialog
  Future<void> confirmBVNName({
    required String verificationId,
    required String action,
  }) async {
    if (isClosed) return;
    emit(const KYCLoading());
    final result = await repository.confirmBVNName(
      verificationId: verificationId,
      action: action,
    );

    result.fold(
      (failure) {
        if (!isClosed) emit(KYCError(failure: failure, userMessage: _getUserMessage(failure)));
      },
      (message) {
        if (!isClosed) emit(BVNNameConfirmed(message: message));
      },
    );
  }

  /// Get a pre-signed URL for document upload
  Future<void> getDocumentUploadURL({
    required String documentType,
    required String contentType,
  }) async {
    if (isClosed) return;
    emit(const KYCLoading());
    final result = await repository.getDocumentUploadURL(
      documentType: documentType,
      contentType: contentType,
    );

    result.fold(
      (failure) {
        if (!isClosed) emit(KYCError(failure: failure, userMessage: _getUserMessage(failure)));
      },
      (uploadURL) {
        if (!isClosed) emit(DocumentUploadURLReady(uploadURL: uploadURL));
      },
    );
  }

  /// Submit uploaded documents for review
  Future<void> submitDocumentsForReview({
    required String userId,
    required List<DocumentSubmissionItem> documents,
  }) async {
    if (isClosed) return;
    emit(const KYCLoading());
    final result = await repository.submitDocumentsForReview(
      userId: userId,
      documents: documents,
    );

    result.fold(
      (failure) {
        if (!isClosed) emit(KYCError(failure: failure, userMessage: _getUserMessage(failure)));
      },
      (message) {
        if (!isClosed) emit(DocumentsSubmitted(message: message));
      },
    );
  }

  /// Reset to initial state
  void reset() {
    if (!isClosed) emit(const KYCInitial());
  }

  /// Convert technical failures to user-friendly messages
  String _getUserMessage(Failure failure) {
    final statusCode = failure.statusCode;
    switch (statusCode) {
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
      default:
        if (statusCode >= 500) return 'Server error. Please try again later.';
        if (statusCode >= 400) return 'Request failed. Please check your details.';
        return 'Something went wrong. Please try again.';
    }
  }
}
