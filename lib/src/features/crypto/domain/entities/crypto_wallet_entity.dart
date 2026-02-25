import 'package:equatable/equatable.dart';

class CryptoWalletEntity extends Equatable {
  final String id;
  final String cryptoId;
  final String cryptoSymbol;
  final String cryptoName;
  final String address;
  final double balance;
  final String walletType;
  final String chain;

  const CryptoWalletEntity({
    required this.id,
    required this.cryptoId,
    required this.cryptoSymbol,
    required this.cryptoName,
    required this.address,
    required this.balance,
    required this.walletType,
    required this.chain,
  });

  String get chainDisplayName {
    switch (chain) {
      case 'ethereum':
        return 'Ethereum';
      case 'polygon':
        return 'Polygon';
      case 'binance-smart-chain':
        return 'BSC';
      case 'avalanche':
        return 'Avalanche';
      case 'celo':
        return 'Celo';
      case 'solana':
        return 'Solana';
      default:
        return chain;
    }
  }

  String get truncatedAddress {
    if (address.length <= 10) return address;
    return '${address.substring(0, 6)}...${address.substring(address.length - 4)}';
  }

  @override
  List<Object?> get props => [id, cryptoId, cryptoSymbol, cryptoName, address, balance, walletType, chain];
}
