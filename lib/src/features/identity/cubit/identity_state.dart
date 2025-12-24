import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/identity/domain/entities/id_document.dart';
import 'package:lazervault/src/features/identity/domain/entities/facial_data.dart';
import 'package:lazervault/src/features/identity/domain/entities/device_permission.dart';

abstract class IdentityState extends Equatable {
  const IdentityState();

  @override
  List<Object?> get props => [];
}

class IdentityInitial extends IdentityState {
  const IdentityInitial();
}

class IdentityLoading extends IdentityState {
  const IdentityLoading();
}

// ID Document States
class IDDocumentUploaded extends IdentityState {
  final IDDocument document;
  final String message;

  const IDDocumentUploaded({
    required this.document,
    required this.message,
  });

  @override
  List<Object?> get props => [document, message];
}

class IDDocumentsLoaded extends IdentityState {
  final List<IDDocument> documents;

  const IDDocumentsLoaded(this.documents);

  @override
  List<Object?> get props => [documents];
}

class IDDocumentVerified extends IdentityState {
  final IDDocument document;
  final String message;

  const IDDocumentVerified({
    required this.document,
    required this.message,
  });

  @override
  List<Object?> get props => [document, message];
}

// Facial Recognition States
class FaceRegistered extends IdentityState {
  final FacialData facialData;
  final String message;

  const FaceRegistered({
    required this.facialData,
    required this.message,
  });

  @override
  List<Object?> get props => [facialData, message];
}

class FaceVerified extends IdentityState {
  final bool verified;
  final String message;

  const FaceVerified({
    required this.verified,
    required this.message,
  });

  @override
  List<Object?> get props => [verified, message];
}

class FacialDataLoaded extends IdentityState {
  final FacialData? facialData;

  const FacialDataLoaded(this.facialData);

  @override
  List<Object?> get props => [facialData];
}

// Passcode States
class PasscodeSet extends IdentityState {
  final String message;

  const PasscodeSet(this.message);

  @override
  List<Object?> get props => [message];
}

class PasscodeVerified extends IdentityState {
  final bool verified;
  final String message;

  const PasscodeVerified({
    required this.verified,
    required this.message,
  });

  @override
  List<Object?> get props => [verified, message];
}

class PasscodeRemoved extends IdentityState {
  final String message;

  const PasscodeRemoved(this.message);

  @override
  List<Object?> get props => [message];
}

class PasscodeExistsChecked extends IdentityState {
  final bool exists;

  const PasscodeExistsChecked(this.exists);

  @override
  List<Object?> get props => [exists];
}

// Permission States
class PermissionsUpdated extends IdentityState {
  final String message;

  const PermissionsUpdated(this.message);

  @override
  List<Object?> get props => [message];
}

class PermissionsLoaded extends IdentityState {
  final List<DevicePermission> permissions;

  const PermissionsLoaded(this.permissions);

  @override
  List<Object?> get props => [permissions];
}

// Error State
class IdentityError extends IdentityState {
  final String message;

  const IdentityError(this.message);

  @override
  List<Object?> get props => [message];
}
