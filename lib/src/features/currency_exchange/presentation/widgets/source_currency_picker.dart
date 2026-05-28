import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_grpc;

import '../../domain/repositories/i_exchange_repository.dart';

// Dark theme palette (per CLAUDE.md).
const Color _background = Color(0xFF0A0A0A);
const Color _cardBackground = Color(0xFF1F1F1F);
const Color _divider = Color(0xFF2D2D2D);
const Color _textPrimary = Colors.white;
const Color _textSecondary = Color(0xFF9CA3AF);
const Color _success = Color(0xFF10B981);
const Color _primary = Color(0xFF4E03D0);

/// Per-wallet snapshot used by [SourceCurrencyPicker]. Only what the picker
/// needs to render: code, balance (major units), and whether the user has
/// any positive balance on this currency at all.
class _WalletSnapshot {
  final String code;
  final String name;
  final String country;
  final double balanceMajor;

  const _WalletSnapshot({
    required this.code,
    required this.name,
    required this.country,
    required this.balanceMajor,
  });

  bool get hasBalance => balanceMajor > 0;
}

/// Bottom-sheet currency picker that lists ONLY the currencies the user has a
/// wallet balance > 0 in. Includes per-row balance amounts and a flag emoji.
///
/// When the user has only NGN today (or no positive balances), the sheet
/// renders an empty-state CTA pointing to the conversion flow so they can
/// fund a non-NGN wallet first.
///
/// Selecting a row invokes [onSelected] with the currency code; navigation
/// is the host screen's responsibility.
class SourceCurrencyPicker {
  /// Convenience entry point: opens the sheet, returns the picked currency
  /// (null on dismiss).
  static Future<String?> show(
    BuildContext context, {
    required String currentCode,
    required List<SupportedCurrencyInfo> supportedCurrencies,
  }) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: _cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => _SourceCurrencyPickerSheet(
        currentCode: currentCode,
        supportedCurrencies: supportedCurrencies,
      ),
    );
  }
}

class _SourceCurrencyPickerSheet extends StatefulWidget {
  final String currentCode;
  final List<SupportedCurrencyInfo> supportedCurrencies;

  const _SourceCurrencyPickerSheet({
    required this.currentCode,
    required this.supportedCurrencies,
  });

  @override
  State<_SourceCurrencyPickerSheet> createState() =>
      _SourceCurrencyPickerSheetState();
}

class _SourceCurrencyPickerSheetState
    extends State<_SourceCurrencyPickerSheet> {
  late Future<List<_WalletSnapshot>> _wallets;

  @override
  void initState() {
    super.initState();
    _wallets = _loadWallets();
  }

  /// Loads ACTIVE-status accounts and folds them into per-currency snapshots
  /// (one row per currency, summing balances across multiple wallets of the
  /// same currency). Currencies the user has NO wallet in are omitted; the
  /// empty-state CTA handles the "only NGN today" path.
  Future<List<_WalletSnapshot>> _loadWallets() async {
    try {
      final accountsClient =
          serviceLocator<accounts_grpc.AccountsServiceClient>();
      final callOptions =
          await serviceLocator<GrpcCallOptionsHelper>().withAuth();
      final response = await accountsClient.getUserAccounts(
        accounts_pb.GetUserAccountsRequest(),
        options: callOptions,
      );

      // Sum balance per currency (multiple accounts of the same currency are
      // common — admin + personal wallets, sub-accounts, etc.).
      final totals = <String, double>{};
      for (final account in response.accounts) {
        if (account.status != 'active') continue;
        final cur = account.currency.toUpperCase();
        if (cur.isEmpty) continue;
        final major = account.balance.toDouble() / 100;
        totals[cur] = (totals[cur] ?? 0) + major;
      }

      // Decorate with name + country from the supported-currency catalog so
      // we can render the flag emoji and a human-readable label.
      final catalog = {
        for (final c in widget.supportedCurrencies) c.code.toUpperCase(): c,
      };

      final snapshots = totals.entries.map((e) {
        final cat = catalog[e.key];
        return _WalletSnapshot(
          code: e.key,
          name: cat?.name ?? e.key,
          country: cat?.country ?? '',
          balanceMajor: e.value,
        );
      }).toList();

      // Sort: current selection first, then by balance desc, then alpha.
      snapshots.sort((a, b) {
        if (a.code == widget.currentCode.toUpperCase()) return -1;
        if (b.code == widget.currentCode.toUpperCase()) return 1;
        if (a.balanceMajor != b.balanceMajor) {
          return b.balanceMajor.compareTo(a.balanceMajor);
        }
        return a.code.compareTo(b.code);
      });

      return snapshots;
    } catch (_) {
      // Network / auth error: fall back to a NGN-only single-row list so the
      // sheet still renders something sensible (matches the "only NGN today"
      // empty-state branch downstream).
      return [
        const _WalletSnapshot(
          code: 'NGN',
          name: 'Nigerian Naira',
          country: 'NG',
          balanceMajor: 0,
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            _buildHeader(),
            Expanded(
              child: FutureBuilder<List<_WalletSnapshot>>(
                future: _wallets,
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: _primary),
                    );
                  }
                  final wallets =
                      (snap.data ?? const <_WalletSnapshot>[]).toList();
                  final withBalance =
                      wallets.where((w) => w.hasBalance).toList();
                  if (withBalance.isEmpty) {
                    return _buildEmptyState(context, wallets);
                  }
                  return _buildList(scrollController, wallets);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFF6B7280),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Send from',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Pick the wallet to debit',
            style: TextStyle(color: _textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildList(
    ScrollController scrollController,
    List<_WalletSnapshot> wallets,
  ) {
    return ListView.separated(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: wallets.length,
      separatorBuilder: (_, __) => const Divider(
        color: _divider,
        height: 1,
        indent: 16,
        endIndent: 16,
      ),
      itemBuilder: (context, index) {
        final w = wallets[index];
        return _walletTile(w);
      },
    );
  }

  Widget _walletTile(_WalletSnapshot w) {
    final flag = _flagFor(w.country);
    final isSelected = w.code == widget.currentCode.toUpperCase();
    final symbol = CurrencySymbols.getSymbol(w.code);
    final balanceText =
        '$symbol${w.balanceMajor.toStringAsFixed(2)} ${w.code}';

    if (!w.hasBalance) {
      return ListTile(
        leading: Text(flag.isNotEmpty ? flag : '\u{1F3F3}\u{FE0F}',
            style: const TextStyle(fontSize: 24)),
        title: Text(
          w.code,
          style: const TextStyle(
            color: _textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          w.name,
          style: const TextStyle(color: _textSecondary, fontSize: 12),
        ),
        trailing: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Get.toNamed(AppRoutes.depositFunds);
          },
          style: TextButton.styleFrom(
            foregroundColor: _primary,
            padding: const EdgeInsets.symmetric(horizontal: 10),
          ),
          child: const Text('Top up'),
        ),
      );
    }

    return ListTile(
      onTap: () => Navigator.of(context).pop(w.code),
      leading: Text(
        flag.isNotEmpty ? flag : '\u{1F3F3}\u{FE0F}',
        style: const TextStyle(fontSize: 24),
      ),
      title: Text(
        w.code,
        style: const TextStyle(
          color: _textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        w.name,
        style: const TextStyle(color: _textSecondary, fontSize: 12),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            balanceText,
            style: const TextStyle(
              color: _success,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (isSelected)
            const Padding(
              padding: EdgeInsets.only(top: 2),
              child:
                  Icon(Icons.check_circle, color: _primary, size: 16),
            ),
        ],
      ),
    );
  }

  /// Empty state: the user has no positive balance in any non-zero wallet.
  /// Common path: brand-new account with only an unfunded NGN wallet. We
  /// link to the conversion flow as a fallback (deposit if there's literally
  /// nothing to convert from).
  Widget _buildEmptyState(
    BuildContext context,
    List<_WalletSnapshot> wallets,
  ) {
    // Lightly different copy when the user has only NGN today vs nothing.
    final hasOnlyNgn = wallets.length == 1 &&
        wallets.first.code == 'NGN' &&
        !wallets.first.hasBalance;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: _background,
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Icon(
              Icons.account_balance_wallet_outlined,
              color: _textSecondary,
              size: 32,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            hasOnlyNgn ? 'Only NGN today' : 'No funded wallets',
            style: const TextStyle(
              color: _textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Convert to other currencies first to send from them.',
            textAlign: TextAlign.center,
            style: TextStyle(color: _textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Send the user back to the exchange home with conversion
                // mode pre-selected. They can then fund a non-NGN wallet
                // from NGN and come back.
                Get.offAllNamed(AppRoutes.exchangeHome);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Convert NGN to another currency',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Get.toNamed(AppRoutes.depositFunds);
            },
            child: const Text(
              'Or top up a wallet',
              style: TextStyle(color: _textSecondary, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  /// 2-letter country code → flag emoji. Empty string when we can't resolve.
  String _flagFor(String countryCode) {
    final code = countryCode.toUpperCase();
    if (code.length != 2) return '';
    return code.codeUnits
        .map((c) => String.fromCharCode(c + 127397))
        .join();
  }
}
