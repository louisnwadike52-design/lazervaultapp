import 'package:lazervault/src/features/whatsapp_banking/domain/entities/whatsapp_user.dart';
import 'package:lazervault/src/generated/whatsapp.pb.dart' as proto;

class WhatsAppUserModel extends WhatsAppUser {
  const WhatsAppUserModel({
    required super.id,
    required super.userId,
    required super.phoneNumber,
    required super.whatsappId,
    required super.linkStatus,
    super.linkedAt,
    super.lastActiveAt,
  });

  factory WhatsAppUserModel.fromProto(proto.WhatsAppUser protoUser) {
    return WhatsAppUserModel(
      id: protoUser.id,
      userId: protoUser.userId,
      phoneNumber: protoUser.phoneNumber,
      whatsappId: protoUser.whatsappId,
      linkStatus: protoUser.linkStatus,
      linkedAt: protoUser.hasLinkedAt()
          ? DateTime.fromMillisecondsSinceEpoch(
              protoUser.linkedAt.seconds.toInt() * 1000)
          : null,
      lastActiveAt: protoUser.hasLastActiveAt()
          ? DateTime.fromMillisecondsSinceEpoch(
              protoUser.lastActiveAt.seconds.toInt() * 1000)
          : null,
    );
  }
}
