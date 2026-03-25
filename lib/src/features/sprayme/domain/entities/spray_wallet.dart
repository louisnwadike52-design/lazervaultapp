class SprayWallet {
  final String id;
  final String userId;
  final int balance;
  final String currency;
  final int totalFunded;
  final int totalSprayed;
  final int totalReceived;
  final int totalWithdrawn;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SprayWallet({
    required this.id,
    required this.userId,
    this.balance = 0,
    this.currency = 'NGN',
    this.totalFunded = 0,
    this.totalSprayed = 0,
    this.totalReceived = 0,
    this.totalWithdrawn = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  double get balanceMajor => balance / 100;
  double get totalFundedMajor => totalFunded / 100;
  double get totalSprayedMajor => totalSprayed / 100;
  double get totalReceivedMajor => totalReceived / 100;
  double get totalWithdrawnMajor => totalWithdrawn / 100;

  factory SprayWallet.fromJson(Map<String, dynamic> json) {
    return SprayWallet(
      id: json['id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      balance: (json['balance'] as num?)?.toInt() ?? 0,
      currency: json['currency'] as String? ?? 'NGN',
      totalFunded: (json['total_funded'] as num?)?.toInt() ?? 0,
      totalSprayed: (json['total_sprayed'] as num?)?.toInt() ?? 0,
      totalReceived: (json['total_received'] as num?)?.toInt() ?? 0,
      totalWithdrawn: (json['total_withdrawn'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}
