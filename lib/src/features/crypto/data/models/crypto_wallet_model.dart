/// Crypto wallet model representing a mirrored wallet from Quidax.
class CryptoWalletModel {
  final String id;
  final String cryptoId;
  final String cryptoSymbol;
  final String address;
  final double balance;
  final String walletType;
  final String chain;
  final String cryptoName;

  CryptoWalletModel({
    required this.id,
    required this.cryptoId,
    required this.cryptoSymbol,
    required this.address,
    required this.balance,
    required this.walletType,
    required this.chain,
    required this.cryptoName,
  });

  factory CryptoWalletModel.fromMap(Map<String, dynamic> map) {
    return CryptoWalletModel(
      id: map['id'] ?? '',
      cryptoId: map['crypto_id'] ?? '',
      cryptoSymbol: map['crypto_symbol'] ?? '',
      address: map['address'] ?? '',
      balance: (map['balance'] ?? 0).toDouble(),
      walletType: map['wallet_type'] ?? 'trading',
      chain: map['chain'] ?? '',
      cryptoName: map['crypto_name'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'crypto_id': cryptoId,
      'crypto_symbol': cryptoSymbol,
      'address': address,
      'balance': balance,
      'wallet_type': walletType,
      'chain': chain,
      'crypto_name': cryptoName,
    };
  }

  /// Get display symbol (uppercase)
  String get displaySymbol => cryptoSymbol.toUpperCase();

  /// Get formatted balance
  String get formattedBalance {
    if (balance < 0.000001) {
      return '${(balance * 1000000).toStringAsFixed(2)} μ';
    } else if (balance < 0.001) {
      return '${(balance * 1000).toStringAsFixed(2)} m';
    } else if (balance < 1) {
      return balance.toStringAsFixed(6);
    } else {
      return balance.toStringAsFixed(4);
    }
  }

  /// Check if wallet has a meaningful balance
  bool get hasBalance => balance > 0.00000001;

  CryptoWalletModel copyWith({
    String? id,
    String? cryptoId,
    String? cryptoSymbol,
    String? address,
    double? balance,
    String? walletType,
    String? chain,
    String? cryptoName,
  }) {
    return CryptoWalletModel(
      id: id ?? this.id,
      cryptoId: cryptoId ?? this.cryptoId,
      cryptoSymbol: cryptoSymbol ?? this.cryptoSymbol,
      address: address ?? this.address,
      balance: balance ?? this.balance,
      walletType: walletType ?? this.walletType,
      chain: chain ?? this.chain,
      cryptoName: cryptoName ?? this.cryptoName,
    );
  }
}
