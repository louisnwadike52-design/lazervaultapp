import 'package:lazervault/src/features/channel_management/domain/entities/channel_pin_status.dart';
import 'package:lazervault/src/generated/transaction_pin.pb.dart' as pin_pb;
import 'package:lazervault/src/generated/transaction_pin.pbenum.dart' as pin_enum;

class ChannelPinStatusModel extends ChannelPinStatus {
  const ChannelPinStatusModel({
    required super.channelType,
    required super.hasPin,
    required super.isActive,
    required super.isLocked,
    super.createdAt,
    super.lastUsedAt,
  });

  factory ChannelPinStatusModel.fromProto(pin_pb.ChannelPinStatus proto) {
    return ChannelPinStatusModel(
      channelType: _channelTypeFromProto(proto.channelType),
      hasPin: proto.hasPin,
      isActive: proto.isActive,
      isLocked: proto.isLocked,
      createdAt: proto.hasCreatedAt() ? proto.createdAt.toDateTime() : null,
      lastUsedAt:
          proto.hasLastUsedAt() ? proto.lastUsedAt.toDateTime() : null,
    );
  }

  static String _channelTypeFromProto(pin_enum.PinChannelType type) {
    switch (type) {
      case pin_enum.PinChannelType.PIN_CHANNEL_APP:
        return 'app';
      case pin_enum.PinChannelType.PIN_CHANNEL_WHATSAPP:
        return 'whatsapp';
      case pin_enum.PinChannelType.PIN_CHANNEL_TELEPHONY:
        return 'telephony';
      default:
        return 'app';
    }
  }
}
