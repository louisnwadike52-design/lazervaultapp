import 'package:flutter/material.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/linked_bank_account.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_state.dart';
import 'scope_pills.dart';

/// Bank-scope selector for the analytics filter bar.
///
/// A thin mapping onto [ScopePills]. The pill rendering, overflow behaviour and
/// bottom-sheet checklist used to live here and were about to be copied for the
/// wallet selector; they now live in one widget that both sides configure, so
/// the two scopes cannot drift apart.
class BankScopePills extends StatelessWidget {
  const BankScopePills({
    super.key,
    required this.banks,
    required this.selectedIds,
    required this.onChanged,
    this.inlineCount = 2,
  });

  final List<LinkedBankAccount> banks;

  /// Empty = "All banks".
  final Set<String> selectedIds;
  final ValueChanged<Set<String>> onChanged;
  final int inlineCount;

  static List<ScopeItem> _items(List<LinkedBankAccount> banks) => [
        for (final b in banks)
          ScopeItem(
            id: b.id,
            label: b.bankName,
            subtitle: b.accountNumber.isEmpty ? null : b.accountNumber,
          ),
      ];

  @override
  Widget build(BuildContext context) => ScopePills(
        items: _items(banks),
        selectedIds: selectedIds,
        onChanged: onChanged,
        allLabel: 'All banks',
        icon: Icons.account_balance_rounded,
        sheetTitle: 'Filter by bank',
        sheetAllHint: 'Showing all linked banks',
        inlineCount: inlineCount,
      );
}

/// LazerVault wallet-scope selector.
///
/// Same widget, different content. A user holds a personal, business, savings,
/// family and campaign wallet per currency, so "my LazerVault spending" is a
/// question about a SET of wallets. Only wallets in the ACTIVE currency are
/// offered: totals are never summed across currencies.
class WalletScopePills extends StatelessWidget {
  const WalletScopePills({
    super.key,
    required this.wallets,
    required this.selectedIds,
    required this.onChanged,
    this.inlineCount = 2,
  });

  final List<StatisticsWallet> wallets;

  /// Empty = "All wallets".
  final Set<String> selectedIds;
  final ValueChanged<Set<String>> onChanged;
  final int inlineCount;

  static List<ScopeItem> _items(List<StatisticsWallet> wallets) => [
        for (final w in wallets)
          ScopeItem(
            id: w.id,
            label: w.name.trim().isEmpty ? w.typeLabel : w.name,
            // The masked account number, falling back to the type. Two wallets
            // belonging to the same person carry the same NAME, so the type
            // alone ("Personal", "Personal") did not separate them either.
            subtitle: w.identifierLabel,
          ),
      ];

  @override
  Widget build(BuildContext context) => ScopePills(
        items: _items(wallets),
        selectedIds: selectedIds,
        onChanged: onChanged,
        allLabel: 'All wallets',
        icon: Icons.account_balance_wallet_rounded,
        sheetTitle: 'Filter by wallet',
        sheetAllHint: 'Showing all your wallets',
        inlineCount: inlineCount,
      );
}

/// Shared multi-select bank-filter sheet, kept as a named entry point because
/// the consolidated top filter bar calls it directly.
Future<Set<String>?> showBankFilterSheet(
  BuildContext context, {
  required List<LinkedBankAccount> banks,
  required Set<String> selectedIds,
}) =>
    showScopeFilterSheet(
      context,
      items: BankScopePills._items(banks),
      selectedIds: selectedIds,
      title: 'Filter by bank',
      icon: Icons.account_balance_rounded,
      allHint: 'Showing all linked banks',
    );

/// Shared multi-select wallet-filter sheet, for the top filter bar's Wallets
/// chip.
Future<Set<String>?> showWalletFilterSheet(
  BuildContext context, {
  required List<StatisticsWallet> wallets,
  required Set<String> selectedIds,
}) =>
    showScopeFilterSheet(
      context,
      items: WalletScopePills._items(wallets),
      selectedIds: selectedIds,
      title: 'Filter by wallet',
      icon: Icons.account_balance_wallet_rounded,
      allHint: 'Showing all your wallets',
    );
