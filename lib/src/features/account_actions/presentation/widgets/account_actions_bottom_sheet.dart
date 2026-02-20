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
  AccountActionTab _selectedTab = AccountActionTab.manageCard;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
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
        _selectedTab = AccountActionTab.values[_tabController.index];
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
        color: const Color(0xFF1E1E1E),
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
          color: Colors.white.withValues(alpha: 0.3),
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicatorColor: const Color(0xFF3B82F6),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withValues(alpha: 0.5),
        labelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: const [
          Tab(text: 'MANAGE CARD'),
          Tab(text: 'SECURITY'),
          Tab(text: 'LIMITS'),
          Tab(text: 'DOCUMENTS'),
          Tab(text: 'HELP'),
        ],
      ),
    );
  }

  Widget _buildTabContent(AccountActionsState state) {
    // Show loading overlay when state is loading
    if (state is AccountActionsLoading && state is! AccountDetailsLoaded) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
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
    } else if (state is AccountFrozen) {
      Get.snackbar(
        'Card Frozen',
        state.message,
        backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.1),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (state is AccountUnfrozen) {
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
    } else if (state is CardDetailsRevealed) {
      // Show card details dialog
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
        backgroundColor: const Color(0xFF1E1E1E),
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
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.5),
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
                color: const Color(0xFF3B82F6),
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
        backgroundColor: const Color(0xFF1E1E1E),
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
                color: Colors.orange.withValues(alpha: 0.8),
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
                color: const Color(0xFF3B82F6),
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
            color: Colors.white.withValues(alpha: 0.5),
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
