import 'package:lazervault/src/features/channel_management/domain/entities/channel_registration.dart';
import 'package:lazervault/src/generated/transaction_pin.pb.dart' as pin_pb;

class ChannelRegistrationModel extends ChannelRegistration {
  const ChannelRegistrationModel({
    required super.id,
    required super.userId,
    required super.channelType,
    required super.phoneNumber,
    required super.status,
    required super.hasPin,
    super.activatedAt,
    super.createdAt,
  });

  factory ChannelRegistrationModel.fromProto(
      pin_pb.ChannelRegistrationDetails proto) {
    return ChannelRegistrationModel(
      id: proto.id,
      userId: proto.userId,
      channelType: proto.channelType,
      phoneNumber: proto.phoneNumber,
      status: proto.status,
      hasPin: proto.hasPin,
      activatedAt:
          proto.hasActivatedAt() ? proto.activatedAt.toDateTime() : null,
      createdAt: proto.hasCreatedAt() ? proto.createdAt.toDateTime() : null,
    );
  }
}
