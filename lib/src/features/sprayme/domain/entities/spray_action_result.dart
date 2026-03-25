import 'package:lazervault/src/features/sprayme/domain/entities/spray_wallet.dart';

class SprayActionResult {
  final bool success;
  final String message;
  final SprayWallet? wallet;
  final String? transactionId;
  final int? totalSprayed;

  const SprayActionResult({
    required this.success,
    this.message = '',
    this.wallet,
    this.transactionId,
    this.totalSprayed,
  });

  factory SprayActionResult.fromJson(Map<String, dynamic> json) {
    return SprayActionResult(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      wallet: json['wallet'] != null
          ? SprayWallet.fromJson(json['wallet'] as Map<String, dynamic>)
          : null,
      transactionId: json['transaction_id'] as String?,
      totalSprayed: (json['total_sprayed'] as num?)?.toInt(),
    );
  }
}
