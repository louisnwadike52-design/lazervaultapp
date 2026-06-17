import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/account_actions/presentation/cubit/account_actions_cubit.dart';
import 'package:lazervault/src/features/account_actions/presentation/cubit/account_actions_state.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import '../widgets/manage_card_tab.dart';
import '../widgets/security_settings_tab.dart';
import '../widgets/spending_limits_tab.dart';
import '../widgets/documents_tab.dart';
import '../widgets/help_tab.dart';
import '../widgets/account_preview_card.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// Tab enum for account actions
enum AccountActionTab {
  manageCard,
  security,
  limits,
  documents,
  help,
}

/// Account Actions Bottom Sheet - Clean, tabbed interface for card management
class AccountActionsBottomSheet extends StatefulWidget {
  final Map<String, dynamic> accountArgs;

  const AccountActionsBottomSheet({
    super.key,
    required this.accountArgs,
  });

  @override
  State<AccountActionsBottomSheet> createState() => _AccountActionsBottomSheetState();
}

class _AccountActionsBottomSheetState extends State<AccountActionsBottomSheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late AccountActionTab _selectedTab;

  /// Feature-flag the card-management surfaces. We don't ship card
  /// issuance yet, so the "MANAGE CARD" tab + its Card Frozen /
  /// Card Unfrozen / Card Details dialogs are hidden. Flip this to
  /// `true` when the cards backend goes live — every card path stays
  /// in code so the re-enable is one-flag.
  static const bool _cardsFeatureEnabled = false;

  /// Tabs surfaced in the sheet, in display order. When the cards
  /// feature is off we drop `manageCard` from this list — the enum
  /// value is preserved (kept in `AccountActionTab`) so the
  /// `_buildTabContent` switch stays exhaustive without dead branches.
  List<AccountActionTab> get _visibleTabs => [
        if (_cardsFeatureEnabled) AccountActionTab.manageCard,
        AccountActionTab.security,
        AccountActionTab.limits,
        AccountActionTab.documents,
        AccountActionTab.help,
      ];

  @override
  void initState() {
    super.initState();
    _selectedTab = _visibleTabs.first;
    _tabController = TabController(length: _visibleTabs.length, vsync: this);
    _tabController.addListener(_handleTabChange);

    // Fetch account details on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchAccountDetails();
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      setState(() {
        // Map TabController index → the matching enum via _visibleTabs
        // so hidden tabs (e.g. manageCard while the cards feature is
        // off) don't get accidentally selected by an off-by-one index.
        _selectedTab = _visibleTabs[_tabController.index];
      });
    }
  }

  void _fetchAccountDetails() {
    final accountId = widget.accountArgs['id']?.toString() ??
                     widget.accountArgs['uuid']?.toString() ??
                     widget.accountArgs['accountId']?.toString();

    if (accountId == null) {
      debugPrint('AccountActionsBottomSheet: No account ID found');
      return;
    }

    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      context.read<AccountActionsCubit>().getAccountDetails(
        accountId: accountId!,
        accessToken: authState.profile.session.accessToken,
      );
    }
  }

  String _getCurrencySymbol() {
    final currency = widget.accountArgs['currency'] as String? ?? 'NGN';
    switch (currency.toUpperCase()) {
      case 'NGN':
        return '₦';
      case 'GBP':
        return '£';
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      default:
        return '₦';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHandle(),
          _buildAccountPreview(),
          _buildTabBar(),
          Expanded(
            child: BlocConsumer<AccountActionsCubit, AccountActionsState>(
              listener: (context, state) {
                _handleStateListener(state);
              },
              builder: (context, state) {
                return _buildTabContent(state);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12.h),
        width: 40.w,
        height: 4.h,
        decoration: BoxDecoration(
          color: const Color(0xFF4A4A4A),
          borderRadius: BorderRadius.circular(2.r),
        ),
      ),
    );
  }

  Widget _buildAccountPreview() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: AccountPreviewCard(
        accountArgs: widget.accountArgs,
        currencySymbol: _getCurrencySymbol(),
      ),
    );
  }

  Widget _buildTabBar() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 20.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: const Color(0xFF2D2D2D),
              width: 1,
            ),
          ),
        ),
        child: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          indicatorColor: const Color(0xFF6366F1),
          indicatorWeight: 2.5,
          labelColor: const Color(0xFF6366F1),
          unselectedLabelColor: const Color(0xFF9CA3AF),
          labelStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          padding: EdgeInsets.zero,
          labelPadding: EdgeInsets.symmetric(horizontal: 12.w),
          // Tabs derived from _visibleTabs so the cards-feature flag
          // can hide MANAGE CARD without leaving an orphaned label.
          tabs: [
            for (final tab in _visibleTabs) Tab(text: _tabLabel(tab)),
          ],
        ),
      ),
    );
  }

  /// Display label for each tab. Pulled into a helper so the TabBar
  /// can generate labels from `_visibleTabs` without a parallel list.
  String _tabLabel(AccountActionTab tab) {
    switch (tab) {
      case AccountActionTab.manageCard:
        return 'MANAGE CARD';
      case AccountActionTab.security:
        return 'SECURITY';
      case AccountActionTab.limits:
        return 'LIMITS';
      case AccountActionTab.documents:
        return 'DOCUMENTS';
      case AccountActionTab.help:
        return 'HELP';
    }
  }

  Widget _buildTabContent(AccountActionsState state) {
    // Show loading overlay when state is loading
    if (state is AccountActionsLoading && state is! AccountDetailsLoaded) {
      return const Center(
        child: LazerVaultLoader.small(),
      );
    }

    switch (_selectedTab) {
      case AccountActionTab.manageCard:
        return ManageCardTab(
          accountArgs: widget.accountArgs,
          accountDetails: state is AccountDetailsLoaded
              ? (state as AccountDetailsLoaded).accountDetails
              : null,
          isLoading: state is AccountActionsLoading || state is AccountFreezing,
        );
      case AccountActionTab.security:
        return SecuritySettingsTab(
          accountArgs: widget.accountArgs,
          accountDetails: state is AccountDetailsLoaded
              ? (state as AccountDetailsLoaded).accountDetails
              : null,
          isLoading: state is SecuritySettingsUpdating,
        );
      case AccountActionTab.limits:
        return SpendingLimitsTab(
          accountArgs: widget.accountArgs,
          accountDetails: state is AccountDetailsLoaded
              ? (state as AccountDetailsLoaded).accountDetails
              : null,
          isLoading: state is SpendingLimitsUpdating,
        );
      case AccountActionTab.documents:
        return DocumentsTab(
          accountArgs: widget.accountArgs,
          isLoading: state is DocumentDownloading,
        );
      case AccountActionTab.help:
        return const HelpTab();
    }
  }

  void _handleStateListener(AccountActionsState state) {
    if (state is AccountActionsError) {
      Get.snackbar(
        'Error',
        state.message,
        backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.1),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (state is AccountFrozen && _cardsFeatureEnabled) {
      Get.snackbar(
        'Card Frozen',
        state.message,
        backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.1),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (state is AccountUnfrozen && _cardsFeatureEnabled) {
      Get.snackbar(
        'Card Unfrozen',
        state.message,
        backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.1),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (state is SecuritySettingsUpdated) {
      Get.snackbar(
        'Settings Updated',
        state.message,
        backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.1),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (state is SpendingLimitsUpdated) {
      Get.snackbar(
        'Limits Updated',
        state.message,
        backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.1),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (state is PINRevealed) {
      // Show PIN dialog
      _showPINDialog(state.pin, state.expiresAt);
    } else if (state is CardDetailsRevealed && _cardsFeatureEnabled) {
      // Show card details dialog (gated by cards feature flag)
      _showCardDetailsDialog(state);
    } else if (state is DocumentDownloaded) {
      Get.snackbar(
        'Document Ready',
        'Your ${state.document.title} is ready',
        backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.1),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _showPINDialog(String pin, DateTime? expiresAt) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Your PIN',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 4; i++)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8.w),
                width: 48.w,
                height: 56.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: const Color(0xFF6366F1).withValues(alpha: 0.3),
                  ),
                ),
                child: Center(
                  child: Text(
                    i < pin.length ? pin[i] : '•',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 4.w,
                    ),
                  ),
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Done',
              style: TextStyle(
                color: const Color(0xFF6366F1),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  void _showCardDetailsDialog(CardDetailsRevealed state) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Card Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Card Number', state.cardNumber),
            SizedBox(height: 16.h),
            _buildDetailRow('Expiry Date', state.expiryDate),
            SizedBox(height: 16.h),
            _buildDetailRow('CVV', state.cvv),
            SizedBox(height: 8.h),
            Text(
              '⚠️ Keep this information secure. Never share with anyone.',
              style: TextStyle(
                color: const Color(0xFFD97706),
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Done',
              style: TextStyle(
                color: const Color(0xFF6366F1),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF9CA3AF),
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.w,
          ),
        ),
      ],
    );
  }
}
