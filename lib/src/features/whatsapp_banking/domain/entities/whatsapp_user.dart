class WhatsAppUser {
  final String id;
  final String userId;
  final String phoneNumber;
  final String whatsappId;
  final String linkStatus;
  final DateTime? linkedAt;
  final DateTime? lastActiveAt;

  const WhatsAppUser({
    required this.id,
    required this.userId,
    required this.phoneNumber,
    required this.whatsappId,
    required this.linkStatus,
    this.linkedAt,
    this.lastActiveAt,
  });

  bool get isLinked => linkStatus == 'linked';
  bool get isPending => linkStatus == 'pending';
  bool get isUnlinked => linkStatus == 'unlinked';
}
