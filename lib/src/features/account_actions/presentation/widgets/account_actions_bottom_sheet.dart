import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lazervault/src/features/account_actions/domain/entities/account_details_entity.dart';
import 'package:lazervault/src/features/account_actions/domain/entities/document_entity.dart';
import 'package:lazervault/src/features/account_actions/presentation/cubit/account_actions_cubit.dart';
import 'package:lazervault/src/features/account_actions/presentation/cubit/account_actions_state.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import '../widgets/manage_card_tab.dart';
import '../widgets/account_controls_tab.dart';
import '../widgets/spending_limits_tab.dart';
import '../widgets/documents_tab.dart';
import '../widgets/help_tab.dart';
import '../widgets/account_preview_card.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// Tab enum for account actions
enum AccountActionTab {
  manageCard,
  controls,
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
        AccountActionTab.controls,
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
        accountId: accountId,
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
        // Subtly brand-tinted dark: a faint purple wash at the top fading to
        // near-black, so the sheet reads as themed while the 0xFF1F1F1F content
        // cards still sit in clear contrast on top of it.
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A1230), Color(0xFF120C1C), Color(0xFF0A0A0A)],
          stops: [0.0, 0.28, 0.62],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        border: Border.all(color: const Color(0xFF241A38), width: 1),
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
    // Group-funds pill style: a dark rounded container with an equal-width
    // rounded purple pill indicator, so the tabs read as one segmented
    // control spread evenly across the sheet (matches the Group Accounts
    // tab strip). The 3-4 short labels fit at equal width on any phone.
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color(0xFF4E03D0),
          borderRadius: BorderRadius.circular(12.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[400],
        labelStyle: GoogleFonts.inter(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 6.w),
        // Tabs derived from _visibleTabs so the cards-feature flag
        // can hide Manage card without leaving an orphaned label.
        tabs: [
          for (final tab in _visibleTabs) Tab(text: _tabLabel(tab)),
        ],
      ),
    );
  }

  /// Display label for each tab. Pulled into a helper so the TabBar
  /// can generate labels from `_visibleTabs` without a parallel list.
  String _tabLabel(AccountActionTab tab) {
    switch (tab) {
      case AccountActionTab.manageCard:
        return 'Manage card';
      case AccountActionTab.controls:
        return 'Controls';
      case AccountActionTab.limits:
        return 'Limits';
      case AccountActionTab.documents:
        return 'Documents';
      case AccountActionTab.help:
        return 'Help';
    }
  }

  /// Resolves the latest account details from ANY state that carries them —
  /// not just AccountDetailsLoaded. After a mutation (freeze/unfreeze, controls
  /// or limits update) the cubit settles on e.g. AccountFrozen /
  /// SecuritySettingsUpdated, which still hold the fresh details. Reading only
  /// AccountDetailsLoaded left the tab with `null` details, disabling its
  /// switches until the sheet was closed and reopened (the reported bug).
  AccountDetailsEntity? _detailsFromState(AccountActionsState state) {
    return switch (state) {
      AccountDetailsLoaded(:final accountDetails) => accountDetails,
      AccountFrozen(:final accountDetails) => accountDetails,
      AccountUnfrozen(:final accountDetails) => accountDetails,
      SecuritySettingsUpdated(:final accountDetails) => accountDetails,
      SpendingLimitsUpdated(:final accountDetails) => accountDetails,
      PINRevealed(:final accountDetails) => accountDetails,
      CardDetailsRevealed(:final accountDetails) => accountDetails,
      AccountFreezing(:final currentDetails) => currentDetails,
      SecuritySettingsUpdating(:final currentDetails) => currentDetails,
      SpendingLimitsUpdating(:final currentDetails) => currentDetails,
      PINRevealing(:final currentDetails) => currentDetails,
      CardDetailsRevealing(:final currentDetails) => currentDetails,
      _ => null,
    };
  }

  Widget _buildTabContent(AccountActionsState state) {
    final details = _detailsFromState(state);

    // Show loading overlay only on the very first fetch (no details yet).
    if (details == null && state is AccountActionsLoading) {
      return const Center(
        child: LazerVaultLoader.small(),
      );
    }

    switch (_selectedTab) {
      case AccountActionTab.manageCard:
        return ManageCardTab(
          accountArgs: widget.accountArgs,
          accountDetails: details,
          isLoading: state is AccountActionsLoading || state is AccountFreezing,
        );
      case AccountActionTab.controls:
        return AccountControlsTab(
          accountArgs: widget.accountArgs,
          accountDetails: details,
          isLoading: state is SecuritySettingsUpdating || state is AccountFreezing,
        );
      case AccountActionTab.limits:
        return SpendingLimitsTab(
          accountArgs: widget.accountArgs,
          accountDetails: details,
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
        'Account frozen',
        _cardsFeatureEnabled
            ? state.message
            : 'Outgoing transfers and payments are now blocked',
        backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.1),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (state is AccountUnfrozen) {
      Get.snackbar(
        'Account unfrozen',
        _cardsFeatureEnabled
            ? state.message
            : 'This account can send money again',
        backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.1),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (state is SecuritySettingsUpdated) {
      Get.snackbar(
        'Controls updated',
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
      _openDownloadedDocument(state.document);
    }
  }

  /// Opens the backend-rendered document in the device's browser/PDF viewer.
  /// Mirrors StatementExportScreen._openDocument so behaviour is consistent.
  Future<void> _openDownloadedDocument(DocumentEntity doc) async {
    final url = doc.downloadUrl;
    final uri = (url == null || url.isEmpty) ? null : Uri.tryParse(url);
    if (uri == null) {
      Get.snackbar(
        'Document unavailable',
        'We couldn\'t open ${doc.title}. Please try again.',
        backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.1),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok) {
      Get.snackbar(
        'Couldn\'t open document',
        'Your ${doc.title} is ready but couldn\'t be opened automatically.',
        backgroundColor: const Color(0xFFF59E0B).withValues(alpha: 0.1),
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
          side: const BorderSide(color: Color(0xFF2A2A2D)),
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
                  color: const Color(0xFF4E03D0).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: const Color(0xFF4E03D0).withValues(alpha: 0.3),
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
                color: const Color(0xFF4E03D0),
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
          side: const BorderSide(color: Color(0xFF2A2A2D)),
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
            SizedBox(height: 10.h),
            _buildDetailRow('Expiry Date', state.expiryDate),
            SizedBox(height: 10.h),
            _buildDetailRow('CVV', state.cvv),
            SizedBox(height: 14.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: const Color(0xFFD97706).withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                    color: const Color(0xFFD97706).withValues(alpha: 0.30)),
              ),
              child: Row(
                children: [
                  Icon(Icons.lock_outline,
                      size: 14.sp, color: const Color(0xFFD97706)),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Keep this information secure. Never share it with anyone.',
                      style: TextStyle(
                          color: const Color(0xFFE0A23C),
                          fontSize: 11.sp,
                          height: 1.4),
                    ),
                  ),
                ],
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
                color: const Color(0xFF4E03D0),
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
    // Finer dark "card" surface per item: subtle elevated fill + hairline
    // border + brand-accent label, so card details read as distinct chips
    // rather than bare text.
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF161618),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2A2A2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: const Color(0xFF8B8B93),
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.6.w,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5.w,
            ),
          ),
        ],
      ),
    );
  }
}
