import 'package:flutter/material.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/locale_manager.dart';

/// A slide-out panel that displays account and locale selection
///
/// This widget provides the central point of entry for:
/// 1. Selecting the active account (for payments, transfers, etc.)
/// 2. Selecting the locale/country (for localized content)
///
/// The slide can be triggered from anywhere in the app and persists
/// the user's selection globally.
class AccountSummarySlide extends StatefulWidget {
  final Widget child; // The child widget (usually the app's home screen)
  final List<AccountSummary> accounts; // Available accounts
  final VoidCallback? onAccountChanged;
  final VoidCallback? onLocaleChanged;

  const AccountSummarySlide({
    super.key,
    required this.child,
    required this.accounts,
    this.onAccountChanged,
    this.onLocaleChanged,
  });

  @override
  State<AccountSummarySlide> createState() => _AccountSummarySlideState();

  /// Static method to show the slide from anywhere in the app
  static void show(BuildContext context, {
    required List<AccountSummary> accounts,
    VoidCallback? onAccountChanged,
    VoidCallback? onLocaleChanged,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AccountSummarySlideContent(
        accounts: accounts,
        onAccountChanged: onAccountChanged,
        onLocaleChanged: onLocaleChanged,
      ),
    );
  }
}

class _AccountSummarySlideState extends State<AccountSummarySlide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      floatingActionButton: FloatingActionButton(
        onPressed: () => AccountSummarySlide.show(
          context,
          accounts: widget.accounts,
          onAccountChanged: widget.onAccountChanged,
          onLocaleChanged: widget.onLocaleChanged,
        ),
        child: const Icon(Icons.account_balance_wallet_outlined),
      ),
    );
  }
}

/// The content widget for the account summary slide
class AccountSummarySlideContent extends StatefulWidget {
  final List<AccountSummary> accounts;
  final VoidCallback? onAccountChanged;
  final VoidCallback? onLocaleChanged;

  const AccountSummarySlideContent({
    super.key,
    required this.accounts,
    this.onAccountChanged,
    this.onLocaleChanged,
  });

  @override
  State<AccountSummarySlideContent> createState() => _AccountSummarySlideContentState();
}

class _AccountSummarySlideContentState extends State<AccountSummarySlideContent> {
  // These will be injected via GetIt or passed from parent
  // For now, creating instances for demonstration
  late AccountManager _accountManager;
  late LocaleManager _localeManager;

  @override
  void initState() {
    super.initState();
    // TODO: Inject these properly via GetIt or pass from parent
    // _accountManager = GetIt.I<AccountManager>();
    // _localeManager = GetIt.I<LocaleManager>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Active Account Section
                  const Text(
                    'Active Account',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),

                  StreamBuilder<String?>(
                    stream: _accountManager.accountIdStream,
                    builder: (context, snapshot) {
                      final activeAccountId = snapshot.data;

                      if (widget.accounts.isEmpty) {
                        return _buildEmptyAccountCard();
                      }

                      return Column(
                        children: widget.accounts.map((account) {
                          final isActive = account.id == activeAccountId;
                          return _buildAccountCard(
                            account: account,
                            isActive: isActive,
                            onTap: () => _selectAccount(account.id),
                          );
                        }).toList(),
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  // Locale Selection Section
                  const Text(
                    'Locale / Country',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),

                  StreamBuilder<String>(
                    stream: _localeManager.localeStream,
                    builder: (context, snapshot) {
                      final currentLocale = snapshot.data ?? 'en-US';

                      return Column(
                        children: CountryLocales.all.take(10).map((countryLocale) {
                          final isActive = countryLocale.locale == currentLocale;
                          return _buildLocaleCard(
                            countryLocale: countryLocale,
                            isActive: isActive,
                            onTap: () => _selectLocale(countryLocale),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountCard({
    required AccountSummary account,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: isActive ? Colors.blue[50] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Account icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isActive ? Colors.blue : Colors.grey[400],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getAccountIcon(account.accountType),
                    color: Colors.white,
                    size: 24,
                  ),
                ),

                const SizedBox(width: 16),

                // Account details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        account.displayText,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        account.balanceText,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                // Active indicator
                if (isActive)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'ACTIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyAccountCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: const Center(
        child: Column(
          children: [
            Icon(
              Icons.account_balance_wallet_outlined,
              size: 48,
              color: Colors.grey,
            ),
            SizedBox(height: 12),
            Text(
              'No accounts available',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocaleCard({
    required CountryLocale countryLocale,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: isActive ? Colors.blue[50] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Flag emoji
                Text(
                  countryLocale.flag,
                  style: const TextStyle(fontSize: 32),
                ),

                const SizedBox(width: 16),

                // Country details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        countryLocale.countryName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        countryLocale.locale,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                // Active indicator
                if (isActive)
                  const Icon(
                    Icons.check_circle,
                    color: Colors.blue,
                    size: 24,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getAccountIcon(String accountType) {
    switch (accountType.toLowerCase()) {
      case 'savings':
        return Icons.savings;
      case 'checking':
        return Icons.account_balance;
      case 'investment':
        return Icons.trending_up;
      case 'credit':
        return Icons.credit_card;
      case 'debit':
        return Icons.payment;
      default:
        return Icons.account_balance_wallet;
    }
  }

  Future<void> _selectAccount(String accountId) async {
    _accountManager.setActiveAccount(accountId);
    widget.onAccountChanged?.call();
    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Active account updated'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _selectLocale(CountryLocale countryLocale) async {
    try {
      await _localeManager.updateLocale(
        locale: countryLocale.locale,
        country: countryLocale.countryCode,
      );
      widget.onLocaleChanged?.call();
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Locale changed to ${countryLocale.countryName}'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update locale: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
