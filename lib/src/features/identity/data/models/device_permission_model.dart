import 'package:lazervault/src/features/identity/domain/entities/device_permission.dart';
import 'package:lazervault/src/generated/user.pb.dart' as pb;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart' as timestamppb;

class DevicePermissionModel extends DevicePermission {
  const DevicePermissionModel({
    required super.permissionType,
    required super.isGranted,
    super.grantedAt,
  });

  factory DevicePermissionModel.fromProto(pb.DevicePermission proto) {
    return DevicePermissionModel(
      permissionType: _mapPermissionType(proto.permissionType),
      isGranted: proto.isGranted,
      grantedAt: proto.hasGrantedAt() ? proto.grantedAt.toDateTime() : null,
    );
  }

  pb.DevicePermission toProto() {
    final proto = pb.DevicePermission()
      ..permissionType = _mapPermissionTypeToProto(permissionType)
      ..isGranted = isGranted;

    if (grantedAt != null) {
      proto.grantedAt = timestamppb.Timestamp.fromDateTime(grantedAt!);
    }

    return proto;
  }

  static PermissionType _mapPermissionType(pb.PermissionType protoType) {
    switch (protoType) {
      case pb.PermissionType.PERMISSION_TYPE_CAMERA:
        return PermissionType.camera;
      case pb.PermissionType.PERMISSION_TYPE_LOCATION:
        return PermissionType.location;
      case pb.PermissionType.PERMISSION_TYPE_MICROPHONE:
        return PermissionType.microphone;
      case pb.PermissionType.PERMISSION_TYPE_STORAGE:
        return PermissionType.storage;
      case pb.PermissionType.PERMISSION_TYPE_CONTACTS:
        return PermissionType.contacts;
      case pb.PermissionType.PERMISSION_TYPE_BIOMETRIC:
        return PermissionType.biometric;
      default:
        return PermissionType.camera;
    }
  }

  static pb.PermissionType _mapPermissionTypeToProto(PermissionType type) {
    switch (type) {
      case PermissionType.camera:
        return pb.PermissionType.PERMISSION_TYPE_CAMERA;
      case PermissionType.location:
        return pb.PermissionType.PERMISSION_TYPE_LOCATION;
      case PermissionType.microphone:
        return pb.PermissionType.PERMISSION_TYPE_MICROPHONE;
      case PermissionType.storage:
        return pb.PermissionType.PERMISSION_TYPE_STORAGE;
      case PermissionType.contacts:
        return pb.PermissionType.PERMISSION_TYPE_CONTACTS;
      case PermissionType.biometric:
        return pb.PermissionType.PERMISSION_TYPE_BIOMETRIC;
    }
  }
}
