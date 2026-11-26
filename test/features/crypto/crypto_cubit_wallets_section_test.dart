import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/cache/session_page_user.dart';
import 'package:lazervault/src/features/crypto/cubit/crypto_cubit.dart';
import 'package:lazervault/src/features/crypto/cubit/crypto_state.dart';
import 'package:lazervault/src/features/crypto/data/models/crypto_wallet_model.dart';
import 'package:lazervault/src/features/crypto/domain/entities/crypto_entity.dart';
import 'package:lazervault/src/features/crypto/domain/repositories/crypto_repository.dart';
import 'package:mocktail/mocktail.dart';

class _Repo extends Mock implements CryptoRepository {}

Crypto _asset(String symbol) => Crypto(
      id: symbol.toLowerCase(),
      symbol: symbol,
      name: symbol,
      image: '',
      currentPrice: 1,
      marketCap: 1,
      marketCapRank: 1,
      totalVolume: 1,
      high24h: 1,
      low24h: 1,
      priceChange24h: 0,
      priceChangePercentage24h: 0,
      circulatingSupply: 1,
      lastUpdated: DateTime(2026),
    );

/// `state.wallets` had no writer: every fetch left it at `const []`, so the
/// wallet screens fell back to a holdings-derived list with NO deposit
/// address and NO chain — a detail page with nothing to show or copy. The
/// cubit now loads the provisioned wallets beside the other authed sections.
void main() {
  setUp(() {
    sessionPageUserIdOverride = '';
    // The painted snapshot is a static, cross-instance cache: without this
    // the second test is handed the first test's state.
    CryptoCubit.invalidateSnapshot();
  });
  tearDown(() => sessionPageUserIdOverride = null);

  // Every other section is left unstubbed on purpose: mocktail throws, each
  // section catches, and the wallets section must be independent of them.
  test('wallets come from the repository, with their deposit addresses',
      () async {
    final repo = _Repo();
    when(() => repo.getSupportedAssets()).thenAnswer((_) async => [_asset('BTC')]);
    when(() => repo.getWallets()).thenAnswer((_) async => [
          CryptoWalletModel(
            id: 'w1',
            cryptoId: 'btc',
            cryptoSymbol: 'BTC',
            address: 'bc1qexampleaddress',
            balance: 0.5,
            walletType: 'trading',
            chain: 'bitcoin',
            cryptoName: 'Bitcoin',
          ),
        ]);
    final cubit = CryptoCubit(repository: repo);
    await cubit.loadCryptos();
    await Future<void>.delayed(Duration.zero);

    final s = cubit.state;
    expect(s, isA<CryptosLoaded>());
    final wallets = (s as CryptosLoaded).wallets;
    expect(wallets, hasLength(1));
    expect(wallets.single.address, 'bc1qexampleaddress');
    expect(wallets.single.chain, 'bitcoin');
    verify(() => repo.getWallets()).called(1);
    await cubit.close();
  });

  test('a failed wallet fetch leaves the holdings fallback intact', () async {
    final repo = _Repo();
    when(() => repo.getSupportedAssets()).thenAnswer((_) async => [_asset('ETH')]);
    when(() => repo.getWallets()).thenThrow(Exception('gateway down'));
    when(() => repo.getHoldings(unitsOnly: any(named: 'unitsOnly')))
        .thenAnswer((_) async => [
              CryptoHolding(
                id: 'eth',
                cryptoId: 'eth',
                cryptoSymbol: 'ETH',
                cryptoName: 'Ethereum',
                quantity: 2,
                averagePrice: 1,
                currentPrice: 1,
                totalValue: 2,
                totalGainLoss: 0,
                totalGainLossPercentage: 0,
                purchaseDate: DateTime(2026),
                lastUpdated: DateTime(2026),
              ),
            ]);
    final cubit = CryptoCubit(repository: repo);
    await cubit.loadCryptos();
    await Future<void>.delayed(Duration.zero);

    final s = cubit.state as CryptosLoaded;
    expect(s.wallets, isEmpty, reason: 'nothing fabricated on failure');
    expect(s.holdings.map((h) => h.cryptoSymbol), ['ETH'],
        reason: 'the holdings-derived fallback still has data to show');
    await cubit.close();
  });
}
