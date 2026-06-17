import 'package:equatable/equatable.dart';

enum PermissionType {
  camera,
  location,
  microphone,
  storage,
  contacts,
  biometric,
}

class DevicePermission extends Equatable {
  final PermissionType permissionType;
  final bool isGranted;
  final DateTime? grantedAt;

  const DevicePermission({
    required this.permissionType,
    required this.isGranted,
    this.grantedAt,
  });

  @override
  List<Object?> get props => [
        permissionType,
        isGranted,
        grantedAt,
      ];

  String get permissionName {
    switch (permissionType) {
      case PermissionType.camera:
        return 'Camera';
      case PermissionType.location:
        return 'Location';
      case PermissionType.microphone:
        return 'Microphone';
      case PermissionType.storage:
        return 'Storage';
      case PermissionType.contacts:
        return 'Contacts';
      case PermissionType.biometric:
        return 'Biometric';
    }
  }

  String get permissionDescription {
    switch (permissionType) {
      case PermissionType.camera:
        return 'Access camera for facial recognition and document scanning';
      case PermissionType.location:
        return 'Access location for enhanced security verification';
      case PermissionType.microphone:
        return 'Access microphone for voice verification';
      case PermissionType.storage:
        return 'Access storage to save documents and images';
      case PermissionType.contacts:
        return 'Access contacts for peer-to-peer transactions';
      case PermissionType.biometric:
        return 'Access biometric authentication (fingerprint/face)';
    }
  }

  DevicePermission copyWith({
    PermissionType? permissionType,
    bool? isGranted,
    DateTime? grantedAt,
  }) {
    return DevicePermission(
      permissionType: permissionType ?? this.permissionType,
      isGranted: isGranted ?? this.isGranted,
      grantedAt: grantedAt ?? this.grantedAt,
    );
  }
}
