/// PIN status for a specific banking channel.
class ChannelPinStatus {
  final String channelType; // 'app', 'whatsapp', 'telephony'
  final bool hasPin;
  final bool isActive;
  final bool isLocked;
  final DateTime? createdAt;
  final DateTime? lastUsedAt;

  const ChannelPinStatus({
    required this.channelType,
    required this.hasPin,
    required this.isActive,
    required this.isLocked,
    this.createdAt,
    this.lastUsedAt,
  });

  String get displayName {
    switch (channelType) {
      case 'app':
        return 'App PIN';
      case 'whatsapp':
        return 'WhatsApp PIN';
      case 'telephony':
        return 'Phone & SMS PIN';
      default:
        return '$channelType PIN';
    }
  }
}
