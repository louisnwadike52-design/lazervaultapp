/// Represents a banking channel registration (WhatsApp, Phone/SMS).
class ChannelRegistration {
  final String id;
  final String userId;
  final String channelType; // 'whatsapp' or 'telephony'
  final String phoneNumber; // Masked: +234***5678
  final String status; // pending, active, suspended, deactivated
  final bool hasPin;
  final DateTime? activatedAt;
  final DateTime? createdAt;

  const ChannelRegistration({
    required this.id,
    required this.userId,
    required this.channelType,
    required this.phoneNumber,
    required this.status,
    required this.hasPin,
    this.activatedAt,
    this.createdAt,
  });

  bool get isActive => status == 'active';
  bool get isPending => status == 'pending';
  bool get isDeactivated => status == 'deactivated';
  bool get isSuspended => status == 'suspended';

  String get displayName {
    switch (channelType) {
      case 'whatsapp':
        return 'WhatsApp Banking';
      case 'telephony':
        return 'Phone & SMS Banking';
      default:
        return channelType;
    }
  }

  String get icon {
    switch (channelType) {
      case 'whatsapp':
        return 'whatsapp';
      case 'telephony':
        return 'phone';
      default:
        return 'channel';
    }
  }
}
