import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/identity/cubit/identity_state.dart';
import 'package:lazervault/src/features/identity/domain/entities/device_permission.dart';
import 'package:lazervault/src/features/identity/domain/entities/id_document.dart';
import 'package:lazervault/src/features/identity/domain/repositories/i_identity_repository.dart';

class IdentityCubit extends Cubit<IdentityState> {
  final IIdentityRepository _repository;

  IdentityCubit({required IIdentityRepository repository})
      : _repository = repository,
        super(const IdentityInitial());

  // ID Document Methods
  Future<void> uploadIDDocument({
    required DocumentType documentType,
    required Uint8List frontImage,
    Uint8List? backImage,
  }) async {
    emit(const IdentityLoading());
    final result = await _repository.uploadIDDocument(
      documentType: documentType,
      frontImage: frontImage,
      backImage: backImage,
    );

    result.fold(
      (failure) => emit(IdentityError(failure.message)),
      (document) => emit(IDDocumentUploaded(
        document: document,
        message: 'ID document uploaded successfully',
      )),
    );
  }

  Future<void> getIDDocuments() async {
    emit(const IdentityLoading());
    final result = await _repository.getIDDocuments();

    result.fold(
      (failure) => emit(IdentityError(failure.message)),
      (documents) => emit(IDDocumentsLoaded(documents)),
    );
  }

  Future<void> verifyIDDocument({required String documentId}) async {
    emit(const IdentityLoading());
    final result = await _repository.verifyIDDocument(
      documentId: documentId,
    );

    result.fold(
      (failure) => emit(IdentityError(failure.message)),
      (document) => emit(IDDocumentVerified(
        document: document,
        message: 'ID document verified successfully',
      )),
    );
  }

  // Facial Recognition Methods
  Future<void> registerFace({required Uint8List faceImage}) async {
    emit(const IdentityLoading());
    final result = await _repository.registerFace(
      faceImage: faceImage,
    );

    result.fold(
      (failure) => emit(IdentityError(failure.message)),
      (facialData) => emit(FaceRegistered(
        facialData: facialData,
        message: 'Face registered successfully',
      )),
    );
  }

  Future<void> verifyFace({required Uint8List faceImage}) async {
    emit(const IdentityLoading());
    final result = await _repository.verifyFace(
      faceImage: faceImage,
    );

    result.fold(
      (failure) => emit(IdentityError(failure.message)),
      (verified) => emit(FaceVerified(
        verified: verified,
        message: verified
            ? 'Face verified successfully'
            : 'Face verification failed',
      )),
    );
  }

  Future<void> getFacialData() async {
    emit(const IdentityLoading());
    final result = await _repository.getFacialData();

    result.fold(
      (failure) => emit(IdentityError(failure.message)),
      (facialData) => emit(FacialDataLoaded(facialData)),
    );
  }

  // Passcode Methods
  Future<void> setPasscode({
    required String passcode,
    required String password,
  }) async {
    emit(const IdentityLoading());
    final result = await _repository.setPasscode(
      passcode: passcode,
      password: password,
    );

    result.fold(
      (failure) => emit(IdentityError(failure.message)),
      (_) => emit(const PasscodeSet('Passcode set successfully')),
    );
  }

  Future<void> verifyPasscode({required String passcode}) async {
    emit(const IdentityLoading());
    final result = await _repository.verifyPasscode(
      passcode: passcode,
    );

    result.fold(
      (failure) => emit(IdentityError(failure.message)),
      (verified) => emit(PasscodeVerified(
        verified: verified,
        message: verified
            ? 'Passcode verified successfully'
            : 'Invalid passcode',
      )),
    );
  }

  Future<void> removePasscode({required String password}) async {
    emit(const IdentityLoading());
    final result = await _repository.removePasscode(
      password: password,
    );

    result.fold(
      (failure) => emit(IdentityError(failure.message)),
      (_) => emit(const PasscodeRemoved('Passcode removed successfully')),
    );
  }

  Future<void> checkPasscodeExists() async {
    emit(const IdentityLoading());
    final result = await _repository.checkPasscodeExists();

    result.fold(
      (failure) => emit(IdentityError(failure.message)),
      (exists) => emit(PasscodeExistsChecked(exists)),
    );
  }

  // Permission Methods
  Future<void> updatePermissions({
    required List<DevicePermission> permissions,
  }) async {
    emit(const IdentityLoading());
    final result = await _repository.updatePermissions(
      permissions: permissions,
    );

    result.fold(
      (failure) => emit(IdentityError(failure.message)),
      (_) => emit(const PermissionsUpdated('Permissions updated successfully')),
    );
  }

  Future<void> getPermissions() async {
    emit(const IdentityLoading());
    final result = await _repository.getPermissions();

    result.fold(
      (failure) => emit(IdentityError(failure.message)),
      (permissions) => emit(PermissionsLoaded(permissions)),
    );
  }

  // Reset to initial state
  void reset() {
    emit(const IdentityInitial());
  }
}
