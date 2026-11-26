import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/statements/data/services/statement_file_service.dart';
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
import 'package:lazervault/core/shared_widgets/lv_snackbar.dart';
import 'package:lazervault/core/config/locale_gating.dart';
import 'package:lazervault/core/widgets/app_bottom_sheet.dart';
part 'account_actions_bottom_sheet_widgets.dart';

/// Account Actions Bottom Sheet - Clean, tabbed interface for card management
class AccountActionsBottomSheet extends StatefulWidget {
  final Map<String, dynamic> accountArgs;

  const AccountActionsBottomSheet({
    super.key,
    required this.accountArgs,
  });

  @override
  State<AccountActionsBottomSheet> createState() =>
      _AccountActionsBottomSheetState();
}

class _AccountActionsBottomSheetState extends State<AccountActionsBottomSheet>
    with SingleTickerProviderStateMixin {
  /// Downloads, verifies and opens generated documents. Same service the
  /// statements screen uses, deliberately — one implementation, one set of
  /// fixes.
  final StatementFileService _documentFiles = StatementFileService();

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
        // Outside NGN the set is admin-tunable, so a tab that stops making
        // sense in a region can be withdrawn without a release. Everything is
        // shown by default — a foreign wallet can hold a balance (currency
        // exchange funds it even with no deposit rail), so freezing it,
        // bounding it, and pulling a statement all remain real.
        if (LocaleGating.accountTabAllowed('controls'))
          AccountActionTab.controls,
        if (LocaleGating.accountTabAllowed('limits')) AccountActionTab.limits,
        if (LocaleGating.accountTabAllowed('documents'))
          AccountActionTab.documents,
        if (LocaleGating.accountTabAllowed('help')) AccountActionTab.help,
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
      // Rebuild the preview on cubit state so a freeze/unfreeze (from the
      // Controls tab) flips the card live. Prefer the freshest status from the
      // loaded/mutated details; fall back to the status passed in accountArgs.
      child: BlocBuilder<AccountActionsCubit, AccountActionsState>(
        builder: (context, state) {
          final details = _detailsFromState(state);
          final isFrozen = details?.isFrozen ??
              _statusIsFrozen(
                  (widget.accountArgs['status'] as String?) ?? 'active');
          return AccountPreviewCard(
            accountArgs: widget.accountArgs,
            currencySymbol: _getCurrencySymbol(),
            isFrozen: isFrozen,
          );
        },
      ),
    );
  }

  static bool _statusIsFrozen(String status) {
    switch (status.toLowerCase()) {
      case 'frozen':
      case 'blocked_temporary':
      case 'blocked_permanent':
      case 'blocked_stolen':
        return true;
      default:
        return false;
    }
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
          isLoading:
              state is SecuritySettingsUpdating || state is AccountFreezing,
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
    } else if (state is DocumentDownloaded) {
      _openDownloadedDocument(state.document);
    }
  }

  /// Saves the backend-rendered document to the device, then offers the same
  /// Open / Print / Share actions a statement gets.
  ///
  /// IT USED TO `launchUrl` THE STORAGE URL STRAIGHT INTO THE BROWSER.
  ///
  /// That "worked" in the sense that a PDF appeared, and was wrong in four
  /// ways for a document somebody submits to an embassy or a landlord:
  ///
  ///  * nothing was saved — leaving the browser lost the document, and
  ///    regenerating it costs a fresh render and a new reference number;
  ///  * the digest the backend computes was never checked, so a truncated
  ///    object would have been displayed as a valid letter;
  ///  * there was no print and no share, which is what these documents are
  ///    FOR. The browser's own menu is not an answer on either platform;
  ///  * the URL went into browser history and sync. A proof-of-funds URL is
  ///    a bearer link to the holder's balance.
  ///
  /// `statements` already solved this properly, so this uses that service
  /// rather than growing a second implementation — the same mistake the
  /// removed `downloadAccountStatement` made (see account_actions_cubit.dart).
  Future<void> _openDownloadedDocument(DocumentEntity doc) async {
    final url = doc.downloadUrl;
    if (url == null || url.isEmpty) {
      LVSnackbar.showError(
        title: 'Document unavailable',
        message: "We couldn't prepare your ${doc.title}. Please try again.",
      );
      return;
    }

    try {
      final path = await _documentFiles.downloadToFile(
        url,
        _documentFilename(doc),
        // Null for the letter types: accounts-service computes a digest and
        // writes it to the document audit trail, but does not return it on
        // GenerateAccountConfirmation / GenerateProofOfFunds. Statements do
        // return one and it IS checked. Verification is skipped, never faked.
        expectedSha256: doc.sha256,
      );
      if (!mounted) return;
      await _showDocumentActions(path, doc);
    } catch (e) {
      if (!mounted) return;
      LVSnackbar.showErrorFor(e, context: 'prepare your ${doc.title}');
    }
  }

  /// `Lazervault-Account-confirmation-LV-240118-7F3A.pdf` — the reference
  /// number is on the face of the letter, so a recipient can match the file to
  /// the document and the holder can find it again months later.
  String _documentFilename(DocumentEntity doc) {
    final title = doc.title.trim().isEmpty ? 'Document' : doc.title.trim();
    final parts = <String>[
      'Lazervault',
      title.replaceAll(RegExp(r'[^A-Za-z0-9]+'), '-'),
    ];
    final ref = doc.reference?.trim();
    if (ref != null && ref.isNotEmpty) {
      parts.add(ref.replaceAll(RegExp(r'[^A-Za-z0-9]+'), '-'));
    }
    return '${parts.join('-').replaceAll(RegExp(r'-+'), '-')}.pdf';
  }

  Future<void> _showDocumentActions(String path, DocumentEntity doc) async {
    if (!mounted) return;
    await showAppBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetCtx) => SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2D),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 16.h),
              Text('${doc.title} ready',
                  style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              if (doc.validUntil != null) ...[
                SizedBox(height: 4.h),
                Text(
                  'Valid until ${_formatDocumentDate(doc.validUntil!)}',
                  style: GoogleFonts.inter(
                      fontSize: 12.sp, color: const Color(0xFF9CA3AF)),
                ),
              ],
              SizedBox(height: 8.h),
              ListTile(
                leading: const Icon(Icons.open_in_new, color: Color(0xFF4E03D0)),
                title: Text('Open',
                    style: GoogleFonts.inter(color: Colors.white)),
                onTap: () {
                  Navigator.pop(sheetCtx);
                  _runDocumentAction(
                      () => _documentFiles.openFile(path), 'open', doc);
                },
              ),
              ListTile(
                leading: const Icon(Icons.print, color: Color(0xFF4E03D0)),
                title: Text('Print',
                    style: GoogleFonts.inter(color: Colors.white)),
                onTap: () {
                  Navigator.pop(sheetCtx);
                  _runDocumentAction(
                      () => _documentFiles.printPdf(path), 'print', doc);
                },
              ),
              ListTile(
                leading: const Icon(Icons.ios_share, color: Color(0xFF4E03D0)),
                title: Text('Share',
                    style: GoogleFonts.inter(color: Colors.white)),
                onTap: () {
                  Navigator.pop(sheetCtx);
                  _runDocumentAction(
                      () => _documentFiles.shareFile(path), 'share', doc);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _runDocumentAction(
      Future<void> Function() action, String verb, DocumentEntity doc) async {
    try {
      await action();
    } on StatementOpenFallback catch (e) {
      // The file is saved and the share sheet is up — information, not failure.
      if (mounted) {
        LVSnackbar.showInfo(
            title: 'Opened the share sheet', message: e.message);
      }
    } catch (e) {
      if (mounted) {
        LVSnackbar.showErrorFor(e, context: '$verb your ${doc.title}');
      }
    }
  }

  static String _formatDocumentDate(DateTime d) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
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
}
