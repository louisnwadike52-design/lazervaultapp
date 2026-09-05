import 'dart:async';
import 'package:lazervault/core/services/endpoint_registry.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/models/device_contact.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/core/services/analytics_service.dart';
import 'package:lazervault/core/utilities/banks_data.dart';
import 'package:lazervault/core/config/country_config.dart';
import 'package:lazervault/core/widgets/bank_logo.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/services/pending_chat_transfers.dart';
import 'package:lazervault/core/utilities/bank_sort.dart';
import 'package:lazervault/src/features/recipients/data/repositories/bank_repository.dart';
import 'package:lazervault/src/features/card_settings/domain/entities/account_details_entity.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_state.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_state.dart';
import 'package:lazervault/src/features/recipients/domain/entities/account_verification_result.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/recipient_chips_builder.dart';
import 'package:lazervault/src/features/funds/cubit/recurring_transfer_cubit.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/recurring_transfer_config.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/budget_warning_sheet.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_cubit.dart';
import 'package:lazervault/src/features/widgets/budget_override_dialog.dart';
import 'package:lazervault/src/features/funds/cubit/recurring_transfer_state.dart';
import 'package:lazervault/src/features/funds/domain/entities/recurring_transfer_entity.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/recipient_filter_chip_card.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/enhanced_recipient_selection_bottom_sheet.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/p2p_chat/domain/repositories/p2p_chat_repository.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/widgets/p2p_chat_icon.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/cubit/p2p_conversations_cubit.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/cubit/p2p_conversations_state.dart';
import 'package:lazervault/src/features/split_bills/presentation/cubit/split_bill_count_cubit.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_transaction_history_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/recipient_transaction_history_modal.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/tag_pay/domain/entities/user_search_result_entity.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/unified_user_search_sheet.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/qr_scan_confirmation_sheet.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/username_recipient_confirmation_sheet.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/transfer_history_bottom_sheet.dart';
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_cubit.dart';
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_state.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/shared_widgets/service_entrance_animation.dart';
// Short-flow (admin-gated) send-funds: reuse this screen + the AddRecipient
// widget inline, and run amount → PIN → receipt on the same screen.
import 'package:uuid/uuid.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/src/features/recipients/presentation/mixins/bank_scan_flow_mixin.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/add_recipient.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_state.dart';
import 'package:lazervault/src/features/funds/domain/entities/transfer_entity.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/send_funds_amount_sheet.dart';
import 'package:lazervault/src/features/widgets/category_selection.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';

class SelectRecipients extends StatefulWidget {
  /// When true, render the short send-funds flow: the AddRecipient widget is
  /// shown inline as a section under the filters, and selecting/adding a
  /// recipient continues with amount → PIN → receipt on this screen (no
  /// separate add page or initiate-send-funds screen).
  final bool shortFlow;
  /// When set with [autoContinue], the screen immediately runs the send flow for
  /// this recipient (used when entering send-funds from a known peer, e.g. the
  /// P2P chat "send money" action) — reusing the same short/long routing + all
  /// edge-case handling instead of duplicating it.
  final RecipientModel? preselectedRecipient;
  final bool autoContinue;

  /// Amount (in minor units) to pre-fill the amount step with when
  /// [autoContinue] runs — used by "Repeat" from a transaction's history so the
  /// prior amount is prefilled in whichever send flow is active.
  final int? prefillAmountMinor;

  /// When true (the transparent quick-send host), the [autoContinue] placeholder
  /// is rendered TRANSPARENT instead of the opaque dark loader, so the caller
  /// (chat/QR) shows through and the amount sheet appears to open directly over
  /// it — no opaque intermediate screen flashing on open/close.
  final bool transparentHost;
  const SelectRecipients({
    super.key,
    this.shortFlow = false,
    this.preselectedRecipient,
    this.autoContinue = false,
    this.prefillAmountMinor,
    this.transparentHost = false,
  });

  @override
  State<SelectRecipients> createState() => _SelectRecipientsState();
}

class _SelectRecipientsState extends State<SelectRecipients>
    with TransactionPinMixin, BankScanFlowMixin<SelectRecipients> {
  // ── Short-flow (send-funds) state ─────────────────────────────────────────
  @override
  ITransactionPinService get transactionPinService =>
      serviceLocator<ITransactionPinService>();

  // ── Bank-scan flow (shared mixin) ─────────────────────────────────────────
  // The scan pipeline lives in BankScanFlowMixin so the long-flow
  // Add-Recipient screen can run the identical flow. Here it routes through
  // the existing _continueWithRecipient (short-inline send vs long navigate).
  @override
  String get scanCountry => _currentCountry;
  @override
  void onScanRecipientResolved(RecipientModel recipient,
          {Map<String, dynamic>? sendFundsArgs}) =>
      _continueWithRecipient(recipient, longFlowArguments: sendFundsArgs);
  // Re-entry guard so a fast double-tap can't fire two transfers.
  bool _shortBusy = false;
  Map<String, dynamic>? _shortPendingReceipt;
  // Max automatic-retry offers when recurring setup fails after a successful
  // transfer (parity with the long flow's _maxRecurringRetries).
  static const int _maxShortRecurringRetries = 2;
  // Active method tab inside the embedded AddRecipient — drives which saved
  // recipients show (Bank → external only, Lazervault user → internal only).
  AddRecipientMethod _shortMethod = AddRecipientMethod.bankDetails;

  // Extra saved-recipient filter applied via the filter-icon sheet (on top of
  // the bank/Lazervault tab): favourites-only.
  bool _savedFavoritesOnly = false;

  // Routing decision — see RecipientModel.canSendAsInternal. `type` alone was
  // trusted here, and it is defaulted to 'internal' whenever no bank was
  // captured, so an ordinary external recipient could be routed as a LazerVault
  // transfer and rejected with "check the account number".
  bool _isInternalRecipient(RecipientModel r) => r.canSendAsInternal;

  // Contact bank verification state
  List<Map<String, String>> _banksList = [];
  bool _isLoadingBanks = false;
  String? _banksError;
  // Most-recently-used bank codes (newest first) for the picker's "Recent" sort.
  static const String _kRecentBanksKey = 'recent_bank_codes';
  List<String> _recentBankCodes = [];
  // Most-USED bank codes (by transfer frequency) for the default "Most used"
  // sort — shared with the other picker via [MostUsedBanks] (bank_sort.dart).
  List<String> _mostUsedBankCodes = [];
  String? _contactSelectedBankCode;
  String? _contactSelectedBankName;
  AccountVerificationResult? _contactVerificationResult;

  // Current country for bank selection (from locale)
  String _currentCountry = 'NG';

  // Filter state for recipients list
  RecipientFilterType _currentFilter = RecipientFilterType.all;

  // Scroll controller for recipients list
  final ScrollController _recipientsScrollController = ScrollController();

  // Recurring-transfers cubit. Held as a field rather than read from the
  // tree because this screen is the only consumer and we want a fresh
  // instance per screen lifecycle (factory-registered in serviceLocator).
  // Created lazily on first tap of the "Recurring" pill.
  RecurringTransferCubit? _recurringTransferCubit;

  // Transaction-history cubit backing the "History" filter (factory-registered,
  // so one fresh instance per screen). Created lazily on first tap of the
  // "History" pill so users who never open it don't pay for the gRPC setup.
  TransactionHistoryCubit? _historyCubit;
  // Re-entry guard for the History list's scroll-triggered pagination.
  bool _historyLoadingMore = false;

  String? _getAccessTokenFromState(AuthenticationState authState) {
    if (authState is AuthenticationSuccess) {
      return authState.profile.session.accessToken;
    }
    return null;
  }

  /// Get initials from name - capitalize first letter of each word
  String _getInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.length >= 2) {
      return '${parts[0][0].toUpperCase()}${parts[1][0].toUpperCase()}';
    } else if (parts.isNotEmpty) {
      return parts[0][0].toUpperCase();
    }
    return '??';
  }

  /// Convert raw gRPC/network error messages to user-friendly text
  String _friendlyError(String raw) {
    final lower = raw.toLowerCase();
    if (lower.contains('unavailable') || lower.contains('connection')) {
      return 'Service temporarily unavailable. Pull down to retry.';
    }
    if (lower.contains('deadline_exceeded') || lower.contains('timeout')) {
      return 'Request timed out. Please try again.';
    }
    if (lower.contains('unauthenticated') || lower.contains('token')) {
      return 'Session expired. Please log in again.';
    }
    if (lower.contains('permission') || lower.contains('denied')) {
      return 'You don\'t have permission for this action.';
    }
    return 'Something went wrong. Pull down to retry.';
  }

  /// Convert to title case (only capitalize first letter of each word)
  String _toTitleCase(String text) {
    return text.trim().split(' ').map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  StreamSubscription<AccountDetailsEntity?>? _accountSubscription;
  StreamSubscription<String>? _localeSubscription;

  /// Effective country + currency for the recipient list. Composed from the
  /// dashboard's two centralized state managers:
  ///   - country  ← LocaleManager.currentCountry      (where the user is)
  ///   - currency ← active account's currency if set, else LocaleManager
  ///                .currentCurrency                  (what they can send in)
  ///
  /// The active account "wins" for currency because a user on en-NG could have
  /// a USD account selected — we want to list recipients reachable in USD, not
  /// the locale-default NGN. Country stays locale-driven because the active
  /// account entity doesn't carry one.
  ({String countryCode, String currency}) _activeFilter() {
    final lm = serviceLocator<LocaleManager>();
    final am = serviceLocator<AccountManager>();
    final acctCurrency = am.activeAccountDetails?.currency;
    return (
      countryCode: lm.currentCountry,
      currency: (acctCurrency != null && acctCurrency.isNotEmpty)
          ? acctCurrency
          : lm.currentCurrency,
    );
  }

  /// Refresh the recipient list using the latest active filter. No-op when
  /// the user isn't authenticated yet. Used by the AccountManager + LocaleManager
  /// stream subscriptions below so switching account or locale on the dashboard
  /// re-loads the list automatically.
  void _refreshRecipientsFromActiveFilter() {
    if (!mounted) return;
    final authState = context.read<AuthenticationCubit>().state;
    final accessToken = _getAccessTokenFromState(authState);
    if (accessToken == null) return;
    final f = _activeFilter();
    context.read<RecipientCubit>().getRecipients(
      accessToken: accessToken,
      countryCode: f.countryCode,
      currency: f.currency,
    );
  }

  /// Pull-to-refresh handler — reloads the recipient list for the active
  /// account/locale filter. Returns a Future (unlike
  /// [_refreshRecipientsFromActiveFilter]) so RefreshIndicator keeps the
  /// spinner up until the fetch completes. Shared by the short-flow body.
  Future<void> _pullToRefresh() async {
    if (!mounted) return;
    final authState = context.read<AuthenticationCubit>().state;
    final accessToken = _getAccessTokenFromState(authState);
    if (accessToken == null) return;
    final f = _activeFilter();
    await context.read<RecipientCubit>().getRecipients(
      accessToken: accessToken,
      countryCode: f.countryCode,
      currency: f.currency,
      // Keep the current list visible while reloading (no blank flicker).
      forceRefresh: true,
    );
  }

  @override
  void initState() {
    super.initState();
    // Freeze the short/long flow decision while the user is inside the send
    // journey (this is the recipient step for both flows). Released in dispose
    // when they leave / land back on the dashboard. Reference-counted in
    // FeatureFlags, so the long flow's picker → amount hand-off doesn't unfreeze.
    FeatureFlags.beginSendFlow();
    // Check initial authentication state
    final authState = context.read<AuthenticationCubit>().state;
    final accessToken = _getAccessTokenFromState(authState);
    if (accessToken != null) {
      // If already authenticated, fetch recipients immediately scoped to the
      // dashboard's active account + locale.
      final f = _activeFilter();
      context.read<RecipientCubit>().getRecipients(
        accessToken: accessToken,
        countryCode: f.countryCode,
        currency: f.currency,
      );
    }
    // The listener below will handle cases where auth happens later.

    // Re-fetch whenever the dashboard switches account or locale — keeps this
    // screen in lockstep without requiring a pop-and-reopen.
    _accountSubscription = serviceLocator<AccountManager>()
        .accountDetailsStream
        .listen((_) => _refreshRecipientsFromActiveFilter());
    _localeSubscription = serviceLocator<LocaleManager>()
        .localeStream
        .listen((_) => _refreshRecipientsFromActiveFilter());

    // Add scroll listener for pagination
    _recipientsScrollController.addListener(_onRecipientsScroll);

    // Load P2P conversations so the badge shows unread count
    serviceLocator<P2PConversationsCubit>().loadConversations();

    // Load pending co-payer count so the Split Bills badge shows
    serviceLocator<SplitBillCountCubit>().refresh();

    // Entered with a known recipient (e.g. from the P2P chat "send money"
    // action) → run the same send flow used everywhere else, after the first
    // frame so cubits/context are ready. We show a loader instead of the full
    // recipient list while this runs, and pop back to the caller (chat) if the
    // user cancels — so this screen never strands them.
    if (widget.autoContinue && widget.preselectedRecipient != null) {
      _autoContinuing = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _runAutoContinue());
    }
  }

  bool _autoContinuing = false;

  Future<void> _runAutoContinue() async {
    if (!mounted) return;
    final r = widget.preselectedRecipient!;
    if (widget.shortFlow) {
      // Short flow owns the amount sheet → PIN → receipt here. On SUCCESS it
      // navigates away via Get.offAllNamed(transferProof) and sets
      // `_shortPendingReceipt`; on cancel/failure it returns without navigating
      // and `_shortPendingReceipt` stays null. Gate the back-pop on that
      // explicit signal — NOT on `mounted`: the host route isn't torn down until
      // a later frame, so we're still mounted here during the success teardown,
      // and an unconditional Get.back() would risk popping the fresh receipt.
      await _startShortSend(r,
          saveRecipient: false, prefillAmountMinor: widget.prefillAmountMinor);
      if (mounted && _shortPendingReceipt == null) Get.back();
    } else {
      // Long flow: replace this screen with the amount-entry screen so the
      // select screen isn't left in the back stack.
      Get.offNamed(AppRoutes.initiateSendFunds, arguments: {
        'recipient': r,
        if (widget.prefillAmountMinor != null)
          'prefillAmount': widget.prefillAmountMinor,
        if (widget.prefillAmountMinor != null) 'autoShowConfirm': true,
      });
    }
  }

  @override
  void dispose() {
    _accountSubscription?.cancel();
    _localeSubscription?.cancel();
    _recipientsScrollController.dispose();
    _recurringTransferCubit?.close();
    _historyCubit?.close();
    // Release the flow-pin freeze taken in initState.
    FeatureFlags.endSendFlow();
    super.dispose();
  }

  void _onRecipientsScroll() {
    // Recurring + History tabs use different cubits with their own scroll
    // handling — skip the recipients load-more on those filters.
    if (_currentFilter == RecipientFilterType.recurring ||
        _currentFilter == RecipientFilterType.history) {
      return;
    }

    if (_recipientsScrollController.position.pixels >=
        _recipientsScrollController.position.maxScrollExtent * 0.8) {
      // Load more when scrolled to 80% of the list
      final recipientState = context.read<RecipientCubit>().state;
      if (recipientState is RecipientLoaded && recipientState.hasMore) {
        final authState = context.read<AuthenticationCubit>().state;
        final accessToken = _getAccessTokenFromState(authState);
        if (accessToken != null) {
          context.read<RecipientCubit>().loadMoreRecipients(accessToken: accessToken);
        }
      }
    }
  }

  /// Handle filter changes from the filter chips
  void _onFilterChanged(RecipientFilterType filterType) {
    setState(() {
      _currentFilter = filterType;
    });

    final authState = context.read<AuthenticationCubit>().state;
    final accessToken = _getAccessTokenFromState(authState);
    if (accessToken == null) return;

    final f = _activeFilter();
    final countryCode = f.countryCode;
    final currency = f.currency;

    // Apply filter based on selected type.
    //
    // `recurring` is the only filter that uses a different cubit + data
    // source (active recurring transfers, not saved recipients). The other
    // three all call RecipientCubit.getRecipients with parameters; backend
    // returns recent-first by default so 'recent' is the same call as 'all'
    // — kept distinct so the chip selection remains visible.
    switch (filterType) {
      case RecipientFilterType.all:
      case RecipientFilterType.recent:
        context.read<RecipientCubit>().getRecipients(
          accessToken: accessToken,
          countryCode: countryCode,
          currency: currency,
        );
        break;
      case RecipientFilterType.favorites:
        context.read<RecipientCubit>().getRecipients(
          accessToken: accessToken,
          countryCode: countryCode,
          currency: currency,
          favoritesOnly: true,
        );
        break;
      case RecipientFilterType.recurring:
        // Lazy-create the cubit on first tap so users who never visit the
        // Recurring tab don't pay for a wasted gRPC client setup.
        _recurringTransferCubit ??= serviceLocator<RecurringTransferCubit>();
        _recurringTransferCubit!.loadRecurringTransfers(status: 'active');
        break;
      case RecipientFilterType.history:
        // Lazy-create the transaction-history cubit on first tap. Loads ALL
        // transactions; the list view filters down to transfers locally.
        _historyCubit ??= GetIt.I<TransactionHistoryCubit>();
        _historyCubit!.loadAllTransactions();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // When launched to send to a known recipient (e.g. from chat), don't flash
    // the full recipient list. In the transparent quick-send host we render
    // NOTHING opaque so the caller shows through and the amount sheet appears to
    // open directly over it (no dark screen flashing on open/close). Otherwise
    // (standalone route) show a clean loader while the sheet runs over it.
    if (_autoContinuing) {
      if (widget.transparentHost) {
        // Transparent, but ABSORB pointers so a tap in the brief window before
        // the amount sheet appears (or after it's dismissed, before Get.back)
        // can't fall through to the caller (chat/QR) beneath this opaque:false
        // host route.
        return const AbsorbPointer(child: SizedBox.expand());
      }
      return const ColoredBox(
        color: Color(0xFF070111),
        child: Center(child: LazerVaultLoader()),
      );
    }
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, authState) {
        // Handle side-effects based on Authentication state.
        // No snackbar on sign-out: when the session ends (manual logout or
        // automatic sign-out) the user is navigated away anyway, so an
        // "Authentication Error" toast here is just noise.
        final accessToken = _getAccessTokenFromState(authState);
        if (accessToken != null) {
          // authState is AuthenticationSuccess
          // Trigger fetch if needed (handles auth happening while screen is visible)
          final recipientState = context.read<RecipientCubit>().state;
          if (recipientState is RecipientInitial) {
            final f = _activeFilter();
            context.read<RecipientCubit>().getRecipients(
              accessToken: accessToken,
              countryCode: f.countryCode,
              currency: f.currency,
            );
          }
        }
      },
      builder: (context, authState) {
        // Build UI based on Authentication state
        // Check if token exists in builder as well for robustness
        final currentToken = _getAccessTokenFromState(authState);
        if (currentToken != null) {
          // User is authenticated, show the recipient UI
          return BlocConsumer<RecipientCubit, RecipientState>(
            listener: (context, recipientState) {
              // Add listener for RecipientState changes if needed
            },
            builder: (context, recipientState) {
              // Build UI based on Recipient state
              // Position the white content sheet right beneath the search bar
              // instead of a fixed `Get.height` fraction. The fraction left a
              // tall empty purple band above the content on taller devices;
              // deriving the offset from the real header content (status bar +
              // paddings + back row + gap + search field) keeps the sheet flush
              // under the search bar on every screen size, pulling everything
              // below it upward.
              final double topInset = MediaQuery.of(context).padding.top;
              // Long flow: 16 top pad + 40 back row + 24 gap + 48 search bar = 128,
              // plus an 8px peek so the rounded sheet tucks just under the search
              // field → 136. Short flow hides the search bar, so there's no field
              // to tuck under — give the header clear breathing room before the
              // white sheet begins (16 top + 44 back row + ~30 gap = 90).
              final double sheetTop =
                  topInset + (widget.shortFlow ? 90.h : 136.h);
              return Stack(children: [
                // Top Purple Section with Gradient.
                // Height carries extra slack below `sheetTop` so the inner
                // header Column (back row + gap + search bar) always has room
                // — the gap beyond sheetTop sits behind the white content
                // sheet (next Stack child) so it's never visible. Prevents the
                // "BOTTOM OVERFLOWED" RenderFlex warning on shorter devices
                // where .w-scaled header icons exceed the .h-scaled budget.
                Container(
                  height: sheetTop + 48.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 78, 3, 208),
                        Color.fromARGB(255, 95, 20, 225),
                      ],
                    ),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  // bottom:false — this is the TOP header; reserving the bottom
                  // safe-area (home-indicator) inset here would steal ~34px from
                  // the column's height budget and overflow the back row +
                  // search bar ("BOTTOM OVERFLOWED"). Only the top inset matters.
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with Back Button
                        Row(
                          children: [
                            GestureDetector(
                              // Opaque hit-test so taps anywhere in the padded
                              // box register, not only on the icon glyph.
                              behavior: HitTestBehavior.opaque,
                              onTap: () => Get.offAllNamed(AppRoutes.dashboard),
                              child: Container(
                                width: 46.w,
                                height: 46.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 22.sp,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Select Recipient',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            // Financial Connections (P2P Chat) icon with unread badge
                            BlocBuilder<P2PConversationsCubit, P2PConversationsState>(
                              bloc: serviceLocator<P2PConversationsCubit>(),
                              builder: (context, p2pState) {
                                final unreadCount = p2pState is P2PConversationsLoaded
                                    ? p2pState.totalUnread + p2pState.requestCount
                                    : 0;
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.financialConnections)?.then((_) {
                                      // Refresh unread count after returning from connections
                                      serviceLocator<P2PConversationsCubit>().loadConversations();
                                    });
                                  },
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        width: 38.w,
                                        height: 38.w,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(alpha: 0.15),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white.withValues(alpha: 0.3),
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.chat_outlined,
                                          color: Colors.white,
                                          size: 18.sp,
                                        ),
                                      ),
                                      if (unreadCount > 0)
                                        Positioned(
                                          right: -4,
                                          top: -4,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: unreadCount > 9 ? 4.w : 0,
                                            ),
                                            constraints: BoxConstraints(
                                              minWidth: 18.w,
                                              minHeight: 18.w,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFEF4444),
                                              borderRadius: BorderRadius.circular(9.r),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              unreadCount > 99 ? '99+' : '$unreadCount',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            SizedBox(width: 8.w),
                            const MicroserviceChatIcon(
                              serviceName: 'Send Funds',
                              sourceContext: 'transfers',
                              iconColor: Colors.white,
                              chatAccentColor: Color.fromARGB(255, 78, 3, 208),
                              isDirect: true,
                              agentDescription: 'I can help you send money, set up recurring transfers, check transfer history, view fees, and more.',
                              size: 38,
                              iconSize: 18,
                              useDarkInner: true,
                            ),
                            SizedBox(width: 8.w),
                            ServiceVoiceButton(
                              serviceName: 'transfers',
                              iconColor: Colors.white,
                              buttonSize: 34.w,
                              iconSize: 16.sp,
                            ),
                          ],
                        ),
                        // Search Bar — LONG FLOW ONLY. Searches PREVIOUS (saved)
                        // recipients only, NOT the whole user directory. The short
                        // flow hides this entirely; there the user picks from the
                        // inline saved list or the quick actions (scan / add user).
                        if (!widget.shortFlow) ...[
                        SizedBox(height: 24.h),
                        GestureDetector(
                          onTap: () => _openSavedRecipientsSheet(savedOnly: true),
                          child: Container(
                            height: 48.h,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.08),
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.white.withValues(alpha: 0.7),
                                  size: 20,
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Text(
                                    'Search saved recipients',
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.7),
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ],
                      ],
                    ),
                  ),
                ),

                // Main Content Section — entrance-animated: the white sheet
                // (Scan-QR quick-actions strip → filter chips → recipients list)
                // rises + fades in on load, while the purple header + search bar
                // above stay static.
                ServiceEntranceAnimation(
                  child: Container(
                  margin: EdgeInsets.only(top: sheetTop),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  child: Column(
                    children: [
                      // Short flow hides the search bar, so the white sheet sits
                      // higher — add a little breathing room below its rounded
                      // top so the content isn't crammed against the header.
                      if (widget.shortFlow) SizedBox(height: 12.h),
                      // Quick Actions Strip (Scan QR / Add User / Scan Bank
                      // Details / Scan History / Split Bills) — shown in BOTH
                      // flows. In short flow the scans feed the inline send.
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[100]!,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Padding(
                          // Page padding (16.w) on both edges; the actions are
                          // distributed with spaceBetween so the last tile
                          // (Split Bills) no longer overflows off the right edge
                          // as it did inside the old horizontal scroller.
                          // Transfer "History" moved to a filter chip beside
                          // "Recurring" below.
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildQuickAction(
                                icon: Icons.qr_code_scanner_outlined,
                                label: 'Scan QR',
                                onTap: _launchQRScanner,
                              ),
                              // "Add User" — long flow only. The short flow adds
                              // recipients inline, so it's replaced by "History"
                              // at the end of the strip.
                              if (!widget.shortFlow)
                                _buildQuickAction(
                                  icon: Icons.person_add_outlined,
                                  label: 'Add User',
                                  onTap: () =>
                                      Get.toNamed(AppRoutes.addRecipient),
                                ),
                              // "Scan Account" moved to a scan button at the
                              // right edge of the account-number box (see the
                              // embedded AddRecipient below / the long-flow
                              // Add-Recipient screen) — cleaner top strip.
                              if (FeatureFlags.scanAccountDetailsIsEnabled)
                                _buildQuickAction(
                                  icon: Icons.manage_search_outlined,
                                  label: 'Scan History',
                                  onTap: showScanHistory,
                                ),
                              // Split Bills quick action with pending co-payer
                              // badge. Admin-hideable: when
                              // splitbill_sendfunds_entry_visible is off the
                              // tile is omitted here and Split Bills is reached
                              // from quick services instead. Nothing else is
                              // disabled — routes, deep links and existing bills
                              // keep working, so a co-payer who was sent a link
                              // can still pay.
                              if (endpointRegistry.splitBillSendFundsEntryVisible)
                                BlocBuilder<SplitBillCountCubit, int>(
                                  bloc: serviceLocator<SplitBillCountCubit>(),
                                  builder: (context, pendingCount) {
                                    return _buildQuickAction(
                                      icon: Icons.group_outlined,
                                      label: 'Split Bills',
                                      onTap: _launchSplitBills,
                                      badgeCount: pendingCount,
                                    );
                                  },
                                ),
                              // Scheduled / recurring transfers — surfaced here so
                              // users can find their upcoming & repeating payments
                              // at a glance (shown in both flows).
                              _buildQuickAction(
                                icon: Icons.event_repeat_outlined,
                                label: 'Scheduled',
                                onTap: () =>
                                    Get.toNamed(AppRoutes.recurringTransfers),
                              ),
                              // Transfer History — short flow only (replaces the
                              // removed "Add User"); long flow uses the History
                              // filter chip below.
                              if (widget.shortFlow)
                                _buildQuickAction(
                                  icon: Icons.history,
                                  label: 'History',
                                  onTap: _showTransferHistory,
                                ),
                            ],
                          ),
                        ),
                      ),

                      // Filter chips (All / Favorites / Recurring / History) —
                      // long flow only. The short flow shows just the inline add
                      // + a simple saved list, so these are hidden to declutter.
                      if (!widget.shortFlow)
                      Padding(
                        padding: EdgeInsets.all(16.w),
                        child: RecipientChipsBuilder(
                          onFilterChanged: _onFilterChanged,
                          selectedFilter: _currentFilter,
                        ),
                      ),

                      // Recipients List Section. Short flow inlines the
                      // AddRecipient widget (as a section under the filters)
                      // above the saved list, all in one scroll.
                      Expanded(
                        child: widget.shortFlow
                            ? _buildShortFlowBody(recipientState)
                            : _buildRecipientsList(recipientState),
                      ),
                    ],
                  ),
                ),
                ),
              ]);
            },
          );
        } else {
          // User is not authenticated, show placeholder/loading
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LazerVaultLoader.small(),
                SizedBox(height: 16),
                Text("Waiting for authentication..."),
              ],
            ),
          );
        }
      },
    );
  }

  // ── Short send-funds flow (admin-gated) ───────────────────────────────────
  // Reuses this screen's theme + the AddRecipient widget (embedded), and the
  // same money path as the long flow (TransferCubit.sendFunds). The long flow
  // is unchanged.

  void _onRecipientTapped(RecipientModel recipient) {
    // Tapping a saved recipient opens a choice sheet: transfer again OR view
    // the last receipt. Works for both bank + Lazervault-user recipients and
    // both flows (the "Transfer again" action routes flow-appropriately).
    _showSavedRecipientSheet(recipient);
  }

  /// Bottom sheet shown when a saved recipient is tapped — "Transfer again" or
  /// "View last receipt". Styled to match the other action sheets on this
  /// screen (white, rounded top, grab handle, purple accent).
  void _showSavedRecipientSheet(RecipientModel recipient) {
    const brand = Color.fromARGB(255, 78, 3, 208);
    final isInternal = _isInternalRecipient(recipient);
    final subtitle = isInternal
        ? '@${recipient.accountNumber.replaceAll('@', '')}'
        : '${recipient.displayBankName}${recipient.maskedAccount.isNotEmpty ? ' • ${recipient.maskedAccount}' : ''}';
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        Widget action({
          required IconData icon,
          required String label,
          required String sub,
          required VoidCallback onTap,
        }) {
          return InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
              child: Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: brand.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(icon, color: brand, size: 20.sp),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(label,
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87)),
                        SizedBox(height: 2.h),
                        Text(sub,
                            style: TextStyle(
                                fontSize: 12.sp, color: Colors.grey[600])),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Colors.grey[400], size: 20.sp),
                ],
              ),
            ),
          );
        }

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 12.h),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22.r,
                      backgroundColor: brand.withValues(alpha: 0.12),
                      child: Text(
                        recipient.name.isNotEmpty
                            ? recipient.name[0].toUpperCase()
                            : '?',
                        style: TextStyle(
                            color: brand,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(recipient.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87)),
                          SizedBox(height: 2.h),
                          Text(subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.grey[600])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.grey[200], height: 1),
              action(
                icon: Icons.send_rounded,
                label: 'Transfer again',
                sub: 'Send money to ${recipient.name}',
                onTap: () {
                  Navigator.pop(ctx);
                  _continueWithRecipient(recipient);
                },
              ),
              action(
                icon: Icons.receipt_long_outlined,
                label: 'View recent transactions',
                sub: 'See your transfers to ${recipient.name}',
                onTap: () {
                  Navigator.pop(ctx);
                  _openRecipientTransactionsSheet(recipient);
                },
              ),
              SizedBox(height: MediaQuery.of(ctx).padding.bottom + 12.h),
            ],
          ),
        );
      },
    );
  }

  /// Transfer history bottom sheet (short-flow "History" quick action). Reuses
  /// the lazy TransactionHistoryCubit and provides it to the sheet (the sheet's
  /// overlay context is above the route provider).
  void _showTransferHistory() {
    _historyCubit ??= GetIt.I<TransactionHistoryCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: _historyCubit!,
        child: TransferHistoryBottomSheet(onSend: _runInlineSend),
      ),
    );
  }

  /// Single router for "recipient acquired → go pay". Used by every entry point
  /// (scan bank details, QR, contact, etc.) so they all honour the active flow:
  /// short → amount → PIN → receipt on this screen; long → initiate-send-funds.
  /// [longFlowArguments] preserves any extra args (e.g. QR prefill) for the long
  /// flow; the short flow just needs the recipient.
  void _continueWithRecipient(RecipientModel recipient,
      {Object? longFlowArguments, int? prefillAmountMinor}) {
    if (widget.shortFlow) {
      // Thread a scanned amount-QR prefill into the short flow too — otherwise
      // the requested amount was silently dropped in classic mode.
      _startShortSend(recipient,
          saveRecipient: recipient.isSaved,
          prefillAmountMinor: prefillAmountMinor);
    } else {
      Get.toNamed(AppRoutes.initiateSendFunds,
          arguments: longFlowArguments ?? recipient);
    }
  }

  List<AccountSummaryEntity> get _shortSummaries {
    final s = context.read<AccountCardsSummaryCubit>().state;
    return switch (s) {
      AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
      AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
      _ => const <AccountSummaryEntity>[],
    };
  }

  AccountSummaryEntity? get _shortActiveSummary {
    final list = _shortSummaries;
    if (list.isEmpty) return null;
    final activeId = serviceLocator<AccountManager>().activeAccountId;
    if (activeId != null) {
      for (final a in list) {
        if (a.spendingAccountId == activeId || a.id == activeId) return a;
      }
    }
    return list.first;
  }

  String? get _shortUserId =>
      context.read<AuthenticationCubit>().currentProfile?.user.id;

  /// Inline AddRecipient handed back a chosen recipient → run the short tail.
  void _onShortRecipientPicked(RecipientModel recipient) {
    _startShortSend(recipient, saveRecipient: recipient.isSaved);
  }

  Future<void> _startShortSend(RecipientModel r,
      {required bool saveRecipient, int? prefillAmountMinor}) async {
    if (_shortBusy) return;
    // Telemetry: short-flow send-funds entry.
    AnalyticsService.instance.trackSendFundsScreen('select_recipients', 'short');
    final active = _shortActiveSummary;
    if (active == null) {
      Get.snackbar('Please wait', 'Your account is still loading.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    final isInternal = r.canSendAsInternal;
    if (isInternal && r.internalUserId != null && r.internalUserId == _shortUserId) {
      Get.snackbar('Not allowed', 'You can’t send funds to yourself.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Pre-warm the PIN status (slow gRPC check) while the user types the amount,
    // so the PIN sheet appears instantly after the amount sheet instead of
    // after a few-second round-trip. Result is cached in the service.
    if (FeatureFlags.sendFundsPinIsRequired) {
      // ignore: discarded_futures
      transactionPinService.checkUserHasPin().catchError((_) => false);
    }

    AnalyticsService.instance.trackSendFundsScreen('amount', 'short');
    final result = await showModalBottomSheet<SendFundsAmountResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      // Close only via the X (e.g. so an insufficient-balance state isn't
      // dismissed by an accidental tap outside).
      isDismissible: false,
      builder: (_) => SendFundsAmountSheet(
        recipientName: r.name,
        // Resolve a raw bank code (e.g. "057") to its display name ("Zenith
        // Bank"); displayBankName is a no-op when it's already a real name.
        bankName: r.displayBankName,
        currency: active.currency,
        transferType: isInternal ? 'internal' : 'external',
        destinationBankCode: isInternal ? null : r.sortCode,
        availableBalanceMajor: active.availableBalance,
        // Clean, compact source label — just the account name/type (no number or
        // mask); the header shows it beside the recipient with the balance below.
        sourceAccountLabel: (active.accountName != null &&
                active.accountName!.isNotEmpty)
            ? active.accountName!
            : active.accountType,
        transferCubit: context.read<TransferCubit>(),
        initialAmountMinor: prefillAmountMinor,
      ),
    );
    if (result == null || result.amountMinor <= 0 || !mounted) return;
    final minor = result.amountMinor;
    final scheduledAt = result.scheduledAt;
    final category = result.category;
    final expenseCategory = category?.budgetCategory;
    final recurring = result.recurring;
    final note = result.note;

    // Budget enforcement (parity with the long flow) — strict budgets BLOCK via
    // the override dialog, flexible budgets WARN via the warning sheet. Runs
    // BEFORE the PIN so a cancel cleanly aborts without a dangling busy flag.
    if (expenseCategory != null) {
      final proceed = await _shortBudgetGate(
          expenseCategory, minor, minor / 100.0, active.currency);
      if (!proceed || !mounted) return;
    }

    _shortBusy = true;
    final transactionId = 'transfer_${const Uuid().v4()}';
    final amountMajor = minor / 100.0;
    // Narration reused for the (optional) recurring rule's description.
    final shortSenderProfile = context.read<AuthenticationCubit>().currentProfile;
    final shortSenderName = shortSenderProfile != null
        ? '${shortSenderProfile.user.firstName} ${shortSenderProfile.user.lastName}'.trim()
        : '';
    final shortDefaultNarration = shortSenderName.isNotEmpty
        ? 'Transfer from $shortSenderName'
        : 'Transfer from Lazervault';
    // Category-aware narration for the (optional) recurring rule's description —
    // same builder as the immediate send, so recurring executions are attributed
    // to the right subcategory (short flow has no note field → detail defaults).
    final shortNarration = ServiceCategory.buildTransferNarration(
      category: category,
      note: note,
      defaultNarration: shortDefaultNarration,
    );
    try {
      if (FeatureFlags.sendFundsPinIsRequired) {
        AnalyticsService.instance.trackSendFundsScreen('pin', 'short');
        var usedToken = '';
        // Revalidate the fee against the CONFIRMED amount so the PIN sheet always
        // shows the aggregated custom+provider fee for THIS amount. Fees are
        // amount-dependent, so the amount-sheet's cached quote is only reused
        // when it was quoted for the same amount+type; otherwise this re-quotes.
        // (Previously we read lastFeeLoaded raw, which could be stale for a
        // different amount, still in-flight, or absent → the fee row vanished.)
        final shortFeeQuote =
            await context.read<TransferCubit>().ensureFeeForAmount(
                  amountMinorUnits: minor,
                  currency: active.currency,
                  transferType: isInternal ? 'internal' : 'domestic',
                  destinationBankCode: isInternal ? null : r.sortCode,
                );
        if (!mounted) return;
        final shortFeeMajor = (shortFeeQuote?.fee ?? 0) / 100.0;
        final ok = await validateTransactionPin(
          context: context,
          transactionId: transactionId,
          transactionType: 'transfer',
          amount: amountMajor,
          currency: active.currency,
          fee: shortFeeMajor > 0 ? shortFeeMajor : null,
          title: 'Confirm Transfer',
          message:
              'Confirm transfer of ${active.currency} ${amountMajor.toStringAsFixed(2)}',
          // The real outcome is confirmed on the receipt (external transfers
          // return `pending`), so the sheet says "Initiated", not "Successful".
          successMessage: 'Transfer Initiated',
          onPinValidated: (verificationToken) async {
            usedToken = verificationToken;
            await _dispatchShortAndAwait(
                r, minor, active, transactionId, verificationToken,
                saveRecipient: saveRecipient,
                scheduledAt: scheduledAt,
                category: category,
                note: note,
                expenseCategory: expenseCategory);
          },
        );
        if (!ok) return;
        // PIN sheet is closed now — safe to surface the recurring retry dialog
        // (parity with the long flow) before navigating to the receipt.
        if (recurring != null && mounted) {
          await _setupRecurringShortWithRetry(
              r, active, minor, shortNarration, recurring, transactionId, usedToken);
        }
        _navShortReceipt();
      } else {
        await _dispatchShortAndAwait(r, minor, active, transactionId, '',
            saveRecipient: saveRecipient,
            scheduledAt: scheduledAt,
            category: category,
            note: note,
            expenseCategory: expenseCategory);
        if (!mounted) return;
        if (recurring != null) {
          await _setupRecurringShortWithRetry(
              r, active, minor, shortNarration, recurring, transactionId, '');
        }
        _navShortReceipt();
      }
    } catch (e) {
      Get.snackbar('Transfer failed',
          e.toString().replaceAll('Exception:', '').trim(),
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      _shortBusy = false;
    }
  }

  /// Budget enforcement for the short flow (parity with the long flow). Strict
  /// budgets BLOCK via [BudgetOverrideDialog]; flexible budgets WARN via
  /// [showBudgetWarningSheet]. Returns true to proceed, false to abort.
  /// Fail-open: a null result (budget service down) allows the transfer.
  Future<bool> _shortBudgetGate(int budgetCategory, int amountMinor,
      double amountMajor, String currency) async {
    final budgetCubit = serviceLocator<BudgetCubit>();
    final result = await budgetCubit.validateCategoryBudget(
      budgetCategory: budgetCategory,
      amountMinor: amountMinor,
      currency: currency,
    );
    if (!mounted) return false;
    if (result == null) return true; // fail-open — never block on a down service

    if (result.shouldBlockTransaction) {
      // STRICT / fixed budget — block with an override choice.
      final budgetName = result.matchingBudgets.isNotEmpty
          ? result.matchingBudgets.first.budgetName
          : 'Budget';
      final budgetId = result.matchingBudgets.isNotEmpty
          ? result.matchingBudgets.first.budgetId
          : '';
      final action = await BudgetOverrideDialog.show(
        context,
        budgetName: budgetName,
        currentSpent: result.currentSpent,
        budgetLimit: result.budgetLimit,
        transactionAmount: amountMajor,
        percentageUsed: result.percentageUsed,
        currency: currency,
        budgetId: budgetId,
      );
      if (action == null || action == BudgetOverrideAction.cancel) return false;
      if (action == BudgetOverrideAction.increaseBudget && budgetId.isNotEmpty) {
        final overage = result.currentSpent + amountMajor - result.budgetLimit;
        final increase = overage > 0 ? overage * 1.2 : amountMajor; // 20% buffer
        await budgetCubit.updateBudget(
            budgetId: budgetId, amount: result.budgetLimit + increase);
        final retry = await budgetCubit.validateCategoryBudget(
          budgetCategory: budgetCategory,
          amountMinor: amountMinor,
          currency: currency,
        );
        if (!mounted) return false;
        if (retry != null && retry.shouldBlockTransaction) {
          Get.snackbar('Still Exceeds Budget',
              'The increased budget is still not enough.',
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
          return false;
        }
      }
      // overrideOnce → proceed.
      return true;
    } else if (result.shouldShowWarning) {
      // FLEXIBLE / near-limit — non-blocking warning; user confirms.
      final proceed = await showBudgetWarningSheet(
        context,
        result: result,
        transactionAmount: amountMajor,
        currency: currency,
      );
      if (!mounted) return false;
      return proceed == true;
    }
    return true;
  }

  Future<void> _dispatchShortAndAwait(
    RecipientModel r,
    int amountMinor,
    AccountSummaryEntity active,
    String transactionId,
    String verificationToken, {
    required bool saveRecipient,
    DateTime? scheduledAt,
    ServiceCategory? category,
    String? note,
    int? expenseCategory,
  }) async {
    final transferCubit = context.read<TransferCubit>();
    final recipientCubit = context.read<RecipientCubit>();
    final token =
        context.read<AuthenticationCubit>().currentProfile?.session.accessToken;
    final isInternal = r.canSendAsInternal;
    final senderProfile = context.read<AuthenticationCubit>().currentProfile;
    final senderName = senderProfile != null
        ? '${senderProfile.user.firstName} ${senderProfile.user.lastName}'.trim()
        : '';
    final defaultNarration = senderName.isNotEmpty
        ? 'Transfer from $senderName'
        : 'Transfer from Lazervault';
    // Same builder the long flow uses: stamps the "Category: …" prefix so
    // subcategory analytics attribute the spend identically across flows, plus
    // the optional user note from the amount sheet.
    final narration = ServiceCategory.buildTransferNarration(
      category: category,
      note: note,
      defaultNarration: defaultNarration,
    );

    transferCubit.sendFunds(
      fromAccountId: active.spendingAccountId,
      toAccountNumber: r.accountNumber,
      toAccountId: isInternal ? (r.internalUserId ?? r.accountNumber) : null,
      type: isInternal ? 'internal' : 'external',
      amount: amountMinor / 100.0,
      description: narration,
      transactionId: transactionId,
      verificationToken: verificationToken,
      destinationBankCode: isInternal ? null : r.sortCode,
      beneficiaryName: isInternal ? null : r.name,
      scheduledAt: scheduledAt,
      expenseCategory: expenseCategory,
      flow: 'short',
    );

    final terminal = await transferCubit.stream
        .firstWhere((s) =>
            s is TransferSuccess ||
            s is TransferFailure ||
            s is TransferPinFailure)
        .timeout(const Duration(seconds: 30),
            onTimeout: () => transferCubit.state);

    if (terminal is TransferFailure) throw Exception(terminal.message);
    if (terminal is TransferPinFailure) throw Exception('Invalid PIN');
    if (terminal is! TransferSuccess) {
      throw Exception(
          'Transfer is taking longer than expected. Check your transaction history before retrying.');
    }
    _shortPendingReceipt = _buildShortReceipt(terminal.response, r, active);
    // From-name on the receipt = the sender's REAL name (not the account-type
    // label like "personal").
    if (senderName.isNotEmpty) {
      _shortPendingReceipt!['sourceAccountName'] = senderName;
    }

    // Seed the P2P financial connection with BOTH real names (parity with the
    // long flow's _ensureFinancialConnection). Without this the short flow's
    // connection is created only by the transfer-event consumer, whose names are
    // account-type labels ("Personal", …) that the p2p service rejects — leaving
    // the connection as "Unknown User". `my_name` seeds the RECEIVER's view of us
    // too. Fire-and-forget: never blocks the receipt.
    if (isInternal && (r.internalUserId?.isNotEmpty ?? false)) {
      final otherUserId = r.internalUserId!;
      final recipientName = r.name;
      // ignore: discarded_futures
      Future(() async {
        try {
          await serviceLocator<P2PChatRepository>().getOrCreateConversation(
            otherUserId,
            otherUserName: recipientName,
            myName: senderName.isNotEmpty ? senderName : null,
          );
        } catch (e) {
          debugPrint('[P2P] short-flow connection seed failed: $e');
        }
      });
    }
    // Persist only newly-added recipients the user chose to save — never one
    // tapped from the already-persisted saved list. Honour their explicit
    // favourite + alias choice from the confirmation/add sheet; don't
    // force-favourite, or a "save without favourite" (and the alias) would be
    // silently overridden.
    if (saveRecipient && token != null) {
      recipientCubit.addRecipient(
        recipient: r.copyWith(id: '0', isSaved: true),
        accessToken: token,
        // Silent: the receipt is already on screen; no "Recipient added" toast.
        silent: true,
      );
    }
    // NOTE: recurring setup is intentionally NOT done here. It runs in
    // _startShortSend AFTER the PIN sheet has closed, via
    // _setupRecurringShortWithRetry, so a failure can surface a retry dialog
    // (parity with the long flow) without racing the PIN sheet dismissal.
  }

  /// Deferred recurring setup for the short flow, AWAITED with a retry dialog —
  /// parity with the long flow's _fireRecurringSetup + _showRecurringRetryDialog.
  /// The transfer already succeeded; this only sets up the recurring rule,
  /// reusing the same transactionId + verificationToken. Returns when the user
  /// either succeeds or chooses to continue without recurring.
  Future<void> _setupRecurringShortWithRetry(
    RecipientModel r,
    AccountSummaryEntity active,
    int amountMinor,
    String narration,
    RecurringTransferConfig recurring,
    String transactionId,
    String verificationToken,
  ) async {
    final cubit = _recurringTransferCubit ??= serviceLocator<RecurringTransferCubit>();
    var attempt = 0;
    while (true) {
      cubit.createRecurringTransfer(
        // Match the immediate transfer's source (spendingAccountId) for
        // consistency. NOTE: the backend CreateRecurringTransfer resolves the
        // account from the x-account-id metadata header and ignores this body
        // field, so this has no runtime effect today — kept aligned so the two
        // calls never diverge if the backend ever starts reading the body.
        fromAccountId: active.spendingAccountId,
        toAccountNumber: r.accountNumber,
        recipientName: r.name,
        recipientBankCode: r.sortCode,
        recipientBankName: r.displayBankName,
        amount: amountMinor / 100.0,
        description: narration,
        frequency: recurring.frequency,
        scheduleDay: recurring.scheduleDay,
        scheduleTime: recurring.scheduleTimeString,
        endDate: recurring.endDate?.toIso8601String(),
        transactionId: transactionId,
        verificationToken: verificationToken,
      );

      final state = await cubit.stream
          .firstWhere((s) =>
              s is RecurringTransferCreated || s is RecurringTransferError)
          .timeout(const Duration(seconds: 20), onTimeout: () => cubit.state);

      if (state is RecurringTransferCreated) return; // done — recurring set up

      final message = state is RecurringTransferError
          ? state.message
          : 'Recurring setup timed out. You can set it up later from transfer history.';
      attempt++;
      if (!mounted) return;
      final retry = await _showShortRecurringRetryDialog(
        message,
        canRetry: attempt <= _maxShortRecurringRetries,
      );
      if (retry != true) return; // "Continue Without Recurring"
    }
  }

  /// Retry dialog shown when short-flow recurring setup fails but the transfer
  /// succeeded. Returns true to retry, false/null to continue without recurring.
  /// Mirrors the long flow's _showRecurringRetryDialog.
  Future<bool?> _showShortRecurringRetryDialog(String errorMessage,
      {required bool canRetry}) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        icon: Icon(Icons.warning_amber_rounded,
            color: const Color(0xFFFB923C), size: 48.sp),
        title: Text(
          'Recurring Setup Failed',
          style: TextStyle(
              color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Your transfer was successful, but the recurring payment could not be set up.',
              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                errorMessage,
                style:
                    TextStyle(color: const Color(0xFFEF4444), fontSize: 12.sp),
              ),
            ),
            if (!canRetry)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  'You can set up recurring payments later from the transfer history.',
                  style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                      fontStyle: FontStyle.italic),
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(
              'Continue Without Recurring',
              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
            ),
          ),
          if (canRetry)
            ElevatedButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                'Retry Setup',
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
            ),
        ],
      ),
    );
  }

  /// The logged-in user's REAL name (the actual sender). Used for the receipt's
  /// "From" so it never falls back to a placeholder.
  String _senderRealName() {
    final p = context.read<AuthenticationCubit>().currentProfile;
    if (p == null) return '';
    return '${p.user.firstName} ${p.user.lastName}'.trim();
  }

  Map<String, dynamic> _buildShortReceipt(
      TransferEntity res, RecipientModel r, AccountSummaryEntity active) {
    final isInternal = r.canSendAsInternal;
    // Internal (Lazervault→Lazervault) send: hand the completed transfer to the
    // P2P chat with this user so the money bubble renders the moment they open
    // the chat (the receipt wipes the stack, so the chat can't reload on return).
    if (isInternal) {
      final peerId = r.internalUserId?.trim().isNotEmpty == true
          ? r.internalUserId!.trim()
          : r.id;
      PendingChatTransfers.instance.record(
        peerUserId: peerId,
        amountMinor: res.amount.toInt(),
        currency: active.currency,
        reference: res.internalReference,
        // Carry the real status so a scheduled (not-yet-fired) send renders the
        // chat bubble as "Money Scheduled" instead of "Money Sent".
        status: res.status,
        scheduledAt: res.scheduledAt,
      );
    }
    // Empty for internal user recipients (no real account number) → the receipt
    // hides the Account row instead of masking the user-id UUID.
    final masked = r.maskedAccount;
    return {
      'amount': res.amount.toDouble() / 100.0,
      'fee': res.fee.toDouble() / 100.0,
      'totalAmount': res.totalAmount.toDouble() / 100.0,
      'recipientName': r.name,
      'recipientAccountMasked': masked,
      'recipientBankName': r.displayBankName,
      'recipientBankCode': r.sortCode,
      'sourceAccountInfo':
          '${active.accountType} •••• ${active.accountNumberLast4}',
      // From = the ACTUAL sender. Prefer the logged-in user's real name; fall
      // back to the source account holder name. NEVER a placeholder.
      'sourceAccountName': _senderRealName().isNotEmpty
          ? _senderRealName()
          : (active.accountName ?? ''),
      'currency': active.currency,
      'transferId': res.transferId.toString(),
      'timestamp': res.createdAt,
      // Carry the send-funds flow (long|short) so the processing & receipt
      // screens emit real telemetry instead of 'unknown'.
      'flow': AnalyticsService.instance.currentSendFlow,
      'reference': null,
      'providerReference': res.providerReference,
      'internalReference': res.internalReference,
      'status': res.status,
      // Present only for future-dated sends → drives the receipt's
      // "Transfer Scheduled" header (mirrors the long flow).
      if (res.scheduledAt != null) 'scheduledAt': res.scheduledAt,
      'network':
          isInternal ? 'Lazervault Internal Transfer' : 'External Bank Transfer',
      'transferType': isInternal ? 'Internal Transfer' : 'Domestic Transfer',
    };
  }

  void _navShortReceipt() {
    if (_shortPendingReceipt != null) {
      Get.offAllNamed(AppRoutes.transferProof, arguments: _shortPendingReceipt);
    }
  }

  Widget _buildShortFlowBody(RecipientState state) {
    final saved = _orderedSaved(state);
    // Swipe-down to reload the recipient data (matches the long-flow list).
    // AlwaysScrollableScrollPhysics lets the pull trigger even when the
    // content is short enough not to scroll on its own.
    return RefreshIndicator(
      color: const Color.fromARGB(255, 78, 3, 208),
      onRefresh: _pullToRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        // 24.w side padding matches the full Add-Recipient page; 24.h top so the
        // Bank/User/Contacts selector clears the sheet's rounded top corner.
        padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          // Inline "add recipient" — the AddRecipient widget embedded as a
          // section right under the header (reuses its forms + confirm sheets).
          AddRecipient(
            embedded: true,
            onRecipientSelected: _onShortRecipientPicked,
            onMethodChanged: (m) => setState(() => _shortMethod = m),
            // Scan Account now lives at the right edge of the account-number
            // box; tapping it runs the shared bank-scan → send pipeline.
            onScanAccount: FeatureFlags.scanAccountDetailsIsEnabled
                ? launchBankDetailsScan
                : null,
          ),
          // Clear separation between the add-recipient / "Verify recipient" area
          // above and the saved-recipients list below, so the two read as
          // distinct sections and the saved list sits at the bottom.
          SizedBox(height: 28.h),
          Divider(color: Colors.grey[200], height: 1, thickness: 1),
          SizedBox(height: 20.h),
          // Header row: "Saved recipients" with the "View all" CTA on the RIGHT
          // (opens the full list + search sheet). Only shown when there are any.
          Row(
            children: [
              Text(
                'Saved recipients',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 6.w),
              // Filter icon → bottom sheet (Bank / Lazervault user / Favorites /
              // Recurring). Shows a dot when a non-default filter is active.
              InkWell(
                borderRadius: BorderRadius.circular(20.r),
                onTap: _showSavedFilterSheet,
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Icon(
                    _savedFavoritesOnly
                        ? Icons.filter_alt
                        : Icons.filter_alt_outlined,
                    size: 18.sp,
                    color: _savedFavoritesOnly
                        ? const Color.fromARGB(255, 78, 3, 208)
                        : Colors.grey[600],
                  ),
                ),
              ),
              const Spacer(),
              if (saved.isNotEmpty)
                InkWell(
                  borderRadius: BorderRadius.circular(8.r),
                  onTap: () => _openSavedRecipientsSheet(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                    child: Row(
                      children: [
                        Text(
                          'View all',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 78, 3, 208),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Icon(Icons.chevron_right,
                            size: 16.sp,
                            color: const Color.fromARGB(255, 78, 3, 208)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
          _buildShortSavedList(state),
          ],
        ),
      ),
    );
  }

  /// Favorites-first ordering of the saved recipients in [state] (empty for
  /// loading/error). Shared by the header CTA, the inline preview, and the sheet.
  List<RecipientModel> _orderedSaved(RecipientState state) {
    final recipients = switch (state) {
      RecipientLoaded(:final recipients) => recipients,
      RecipientLoadingMore(:final currentRecipients) => currentRecipients,
      _ => const <RecipientModel>[],
    };
    return [
      ...recipients.where((r) => r.isFavorite),
      ...recipients.where((r) => !r.isFavorite),
    ];
  }

  /// Filter sheet opened from the icon beside "Saved recipients" — filter the
  /// saved list by Lazervault user / Bank / Favourites, or jump to Recurring.
  void _showSavedFilterSheet() {
    const brand = Color.fromARGB(255, 78, 3, 208);
    Widget tile({
      required IconData icon,
      required String label,
      required String sub,
      required bool active,
      required VoidCallback onTap,
    }) {
      return InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: active
                      ? brand.withValues(alpha: 0.10)
                      : Colors.grey[100],
                  shape: BoxShape.circle,
                ),
                child: Icon(icon,
                    size: 20.sp, color: active ? brand : Colors.grey[600]),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87)),
                    SizedBox(height: 2.h),
                    Text(sub,
                        style: TextStyle(
                            fontSize: 12.sp, color: Colors.grey[500])),
                  ],
                ),
              ),
              if (active) Icon(Icons.check_circle, size: 20.sp, color: brand),
            ],
          ),
        ),
      );
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 8.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Filter recipients',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87)),
              ),
            ),
            tile(
              icon: Icons.person_outline,
              label: 'Lazervault users',
              sub: 'Your saved Lazervault contacts',
              active: _shortMethod == AddRecipientMethod.lazervaultUser &&
                  !_savedFavoritesOnly,
              onTap: () {
                Navigator.pop(ctx);
                setState(() {
                  _shortMethod = AddRecipientMethod.lazervaultUser;
                  _savedFavoritesOnly = false;
                });
              },
            ),
            tile(
              icon: Icons.account_balance_outlined,
              label: 'Bank accounts',
              sub: 'Your saved bank recipients',
              active: _shortMethod == AddRecipientMethod.bankDetails &&
                  !_savedFavoritesOnly,
              onTap: () {
                Navigator.pop(ctx);
                setState(() {
                  _shortMethod = AddRecipientMethod.bankDetails;
                  _savedFavoritesOnly = false;
                });
              },
            ),
            tile(
              icon: _savedFavoritesOnly ? Icons.star : Icons.star_outline,
              label: 'Favourites',
              sub: 'Only your favourite recipients',
              active: _savedFavoritesOnly,
              onTap: () {
                Navigator.pop(ctx);
                setState(() => _savedFavoritesOnly = !_savedFavoritesOnly);
              },
            ),
            tile(
              icon: Icons.repeat,
              label: 'Recurring transfers',
              sub: 'View and manage scheduled transfers',
              active: false,
              onTap: () {
                Navigator.pop(ctx);
                Get.toNamed(AppRoutes.recurringTransfers);
              },
            ),
            SizedBox(height: MediaQuery.of(ctx).padding.bottom + 12.h),
          ],
        ),
      ),
    );
  }

  Widget _buildShortSavedList(RecipientState state) {
    if (state is RecipientLoading || state is RecipientInitial) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: const Center(child: LazerVaultLoader.small()),
      );
    }
    // Filter to the active tab: Bank → external only, Lazervault user →
    // internal only.
    final wantInternal = _shortMethod == AddRecipientMethod.lazervaultUser;
    final ordered = _orderedSaved(state)
        .where((r) => _isInternalRecipient(r) == wantInternal)
        .where((r) => !_savedFavoritesOnly || r.isFavorite)
        .toList();
    if (ordered.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                // Both tabs use the same people icon (bank tab previously used
                // a bank/house icon — unified per design).
                Icons.people_outline,
                size: 40.sp,
                color: Colors.grey[400],
              ),
              SizedBox(height: 10.h),
              Text(
                wantInternal
                    ? 'No saved Lazervault recipients yet'
                    : 'No saved bank recipients yet',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700]),
              ),
              SizedBox(height: 4.h),
              Text(
                wantInternal
                    ? 'Add a Lazervault user to send to them in one tap next time.'
                    : 'Add a bank account to reuse it for future transfers.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12.sp, color: Colors.grey[500], height: 1.4),
              ),
            ],
          ),
        ),
      );
    }
    // Both tabs show the first 3 saved recipients inline; the rest live behind
    // the header "View all" sheet (and the filter icon narrows them).
    const previewCount = 3;
    return Padding(
      // Lazervault-user tab sits a little lower for breathing room under the
      // tab toggle above.
      padding: EdgeInsets.only(top: wantInternal ? 14.h : 0),
      child: Column(
        children: [
          for (final r in ordered.take(previewCount)) _buildRecipientItem(r),
        ],
      ),
    );
  }

  /// Saved-recipients picker: an 85%-height bottom sheet with search over the
  /// caller's saved recipients only. Reuses [_buildRecipientItem]; selecting one
  /// closes the sheet and continues the active flow (short → amount/PIN/receipt;
  /// long → initiate-send-funds).
  ///
  /// [savedOnly] hides the "Search all Lazervault users" directory escape — used
  /// by the long-flow top search, which must search PREVIOUS recipients only.
  void _openSavedRecipientsSheet({bool savedOnly = false}) {
    // Capture the cubit from the screen context (the sheet's overlay context is
    // above the route provider). BlocBuilder makes the list + favorite stars
    // update live when a star is toggled inside the sheet.
    final recipientCubit = context.read<RecipientCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) {
        String query = '';
        String pill = 'all'; // all | bank | lazervault
        const purple = Color.fromARGB(255, 78, 3, 208);
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return BlocBuilder<RecipientCubit, RecipientState>(
              bloc: recipientCubit,
              builder: (blocCtx, state) {
                final all = _orderedSaved(state);
                final q = query.trim().toLowerCase();
            final byPill = switch (pill) {
              'bank' => all.where((r) => !_isInternalRecipient(r)),
              'lazervault' => all.where((r) => _isInternalRecipient(r)),
              _ => all,
            };
            final filtered = (q.isEmpty
                    ? byPill
                    : byPill.where((r) {
                        return r.name.toLowerCase().contains(q) ||
                            r.accountNumber.toLowerCase().contains(q) ||
                            r.bankName.toLowerCase().contains(q) ||
                            (r.alias ?? '').toLowerCase().contains(q);
                      }))
                .toList();
            Widget pillChip(String value, String label, {VoidCallback? onSelect}) {
              final selected = pill == value;
              return GestureDetector(
                onTap: () {
                  onSelect?.call();
                  setSheetState(() => pill = value);
                },
                child: Container(
                  margin: EdgeInsets.only(right: 8.w),
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
                  decoration: BoxDecoration(
                    color: selected ? purple : Colors.grey[100],
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                        color: selected ? purple : Colors.grey[300]!),
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      color: selected ? Colors.white : Colors.grey[700],
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }
            return Container(
              height: 0.85.sh,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Saved recipients',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  // Search field
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey[500], size: 20.sp),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: TextField(
                            autofocus: false,
                            onChanged: (v) => setSheetState(() => query = v),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search recipients...',
                              hintStyle: TextStyle(
                                  color: Colors.grey[500], fontSize: 14.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  // Filter pills: All / Bank / Lazervault user / Recurring.
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          pillChip('all', 'All'),
                          pillChip('bank', 'Bank'),
                          pillChip('lazervault', 'Lazervault user'),
                          // Recurring shows the user's active recurring
                          // transfers instead of saved recipients. Load the
                          // cubit lazily on first selection.
                          pillChip('recurring', 'Recurring', onSelect: () {
                            _recurringTransferCubit ??=
                                serviceLocator<RecurringTransferCubit>();
                            _recurringTransferCubit!
                                .loadRecurringTransfers(status: 'active');
                          }),
                        ],
                      ),
                    ),
                  ),
                  // "Search all Lazervault users" belongs to the Lazervault
                  // users tab only — it escalates beyond saved recipients into
                  // the full directory. Hidden on All/Bank/Recurring and for the
                  // long-flow saved-only search.
                  if (!savedOnly && pill == 'lazervault') ...[
                    SizedBox(height: 12.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(sheetCtx);
                        _openUnifiedRecipientSearch();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 14.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4E03D0).withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color: const Color(0xFF4E03D0)
                                  .withValues(alpha: 0.25)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.person_search,
                                color: const Color(0xFF4E03D0), size: 20.sp),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                'Search all Lazervault users',
                                style: TextStyle(
                                  color: const Color(0xFF4E03D0),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Icon(Icons.chevron_right,
                                color: const Color(0xFF4E03D0), size: 18.sp),
                          ],
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: 8.h),
                  Expanded(
                    child: pill == 'recurring'
                        ? _buildRecurringList()
                        : filtered.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      q.isEmpty
                                          ? 'No saved recipients yet'
                                          : 'No saved recipients match "$query"',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 13.sp),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                itemCount: filtered.length,
                                itemBuilder: (_, i) {
                                  final r = filtered[i];
                                  return _buildRecipientItem(
                                    r,
                                    onTapOverride: () {
                                      Navigator.pop(sheetCtx);
                                      _onRecipientTapped(r);
                                    },
                                  );
                                },
                              ),
                  ),
                ],
              ),
            );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildRecipientsList(RecipientState state) {
    // Recurring tab swaps the list contents for the user's active
    // recurring transfers. Different cubit, different entity, different
    // empty-state copy — easiest to fork at the top.
    if (_currentFilter == RecipientFilterType.recurring) {
      return _buildRecurringList();
    }

    // History tab swaps the list for the user's transfer transaction history
    // (rendered with bank logos for external-bank transfers).
    if (_currentFilter == RecipientFilterType.history) {
      return _buildHistoryList();
    }

    // Handle Initial State explicitly - show centered loader while initializing
    if (state is RecipientInitial) {
      return _buildLoadingWidget();
    }

    if (state is RecipientLoading) {
      return _buildLoadingWidget();
    }

    if (state is RecipientLoadingMore) {
      // Show loading indicator at bottom while keeping current list visible
      final allRecipients = state.currentRecipients.toList();

      if (allRecipients.isEmpty) {
        return _buildLoadingWidget();
      }

      return RefreshIndicator(
        color: const Color.fromARGB(255, 78, 3, 208),
        onRefresh: () async {
          final authState = context.read<AuthenticationCubit>().state;
          if (authState is AuthenticationSuccess) {
            final f = _activeFilter();
            await context.read<RecipientCubit>().getRecipients(
              accessToken: authState.profile.session.accessToken,
              countryCode: f.countryCode,
              currency: f.currency,
              forceRefresh: true,
            );
          }
        },
        child: CustomScrollView(
          controller: _recipientsScrollController,
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            // All Recipients Section using SliverList
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == allRecipients.length) {
                      // Show loading more indicator at the end
                      return Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Center(
                          child: LazerVaultLoader.small(),
                        ),
                      );
                    }
                    final recipient = allRecipients[index];
                    return _buildRecipientItem(recipient);
                  },
                  childCount: allRecipients.length + 1, // +1 for loading indicator
                ),
              ),
            ),
            // Bottom spacing
            SliverToBoxAdapter(
              child: SizedBox(height: 32.h),
            ),
          ],
        ),
      );
    }

    if (state is RecipientError) {
      // Handle specific auth error from RecipientCubit
      if (state.message == 'User not authenticated') {
        return Center(
          child: Text(
            'Authentication error. Please login again.',
            style: TextStyle(color: Colors.red, fontSize: 16.sp),
          ),
        );
      } else {
        // Display user-friendly error instead of raw gRPC errors
        final friendlyMessage = _friendlyError(state.message);
        return RefreshIndicator(
          color: const Color.fromARGB(255, 78, 3, 208),
          onRefresh: () async {
            final authState = context.read<AuthenticationCubit>().state;
            if (authState is AuthenticationSuccess) {
              final f = _activeFilter();
              await context.read<RecipientCubit>().getRecipients(
                accessToken: authState.profile.session.accessToken,
                countryCode: f.countryCode,
                currency: f.currency,
                forceRefresh: true,
              );
            }
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: 300.h,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_off_rounded,
                        color: Colors.grey[400],
                        size: 48.sp,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        friendlyMessage,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }

    if (state is RecipientLoaded) {
      // Show all recipients
      final allRecipients = state.recipients.toList();
      // Handle case where there are no recipients at all
      if (allRecipients.isEmpty) {
        return RefreshIndicator(
          color: const Color.fromARGB(255, 78, 3, 208),
          onRefresh: () async {
            final authState = context.read<AuthenticationCubit>().state;
            if (authState is AuthenticationSuccess) {
              final f = _activeFilter();
              await context.read<RecipientCubit>().getRecipients(
                accessToken: authState.profile.session.accessToken,
                countryCode: f.countryCode,
                currency: f.currency,
                forceRefresh: true,
              );
            }
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'No Saved Recipients',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Add recipients to see them here',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 32.h),
                      SizedBox(
                        width: 200.w,
                        height: 48.h,
                        child: ElevatedButton.icon(
                          onPressed: () => Get.toNamed(AppRoutes.addRecipient),
                          icon: Icon(Icons.person_add, size: 20.sp),
                          label: Text(
                            'Add User',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 78, 3, 208),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }

      // Build the UI displaying all recipients (favorites first)
      return RefreshIndicator(
        color: const Color.fromARGB(255, 78, 3, 208),
        onRefresh: () async {
          final authState = context.read<AuthenticationCubit>().state;
          if (authState is AuthenticationSuccess) {
            final f = _activeFilter();
            await context.read<RecipientCubit>().getRecipients(
              accessToken: authState.profile.session.accessToken,
              countryCode: f.countryCode,
              currency: f.currency,
              forceRefresh: true,
            );
          }
        },
        child: CustomScrollView(
          controller: _recipientsScrollController,
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            // All Recipients Section using SliverList
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == allRecipients.length) {
                      // Show "Load More" indicator at the end
                      return _buildLoadMoreIndicator(state);
                    }
                    final recipient = allRecipients[index];
                    return _buildRecipientItem(recipient);
                  },
                  childCount: allRecipients.length + (state.hasMore ? 1 : 0),
                ),
              ),
            ),
            // Bottom spacing
            SliverToBoxAdapter(
              child: SizedBox(height: 32.h),
            ),
          ],
        ),
      );
    }

    // Fallback for any other unhandled state (should ideally not be reached)
    return const Center(child: Text('An unexpected error occurred.'));
  }

  /// Build individual recipient item for the list. [onTapOverride] lets the
  /// short-flow "View all" sheet pop itself before continuing.
  Widget _buildRecipientItem(RecipientModel recipient,
      {VoidCallback? onTapOverride}) {
    return Container(
      // Short flow: no side margin so the card edge lines up with the form
      // fields above (which sit at the body's 24.w padding). Long flow keeps
      // the small 4.w inset it always had.
      margin: EdgeInsets.symmetric(
          vertical: 5.h, horizontal: widget.shortFlow ? 0 : 4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: onTapOverride ?? () => _onRecipientTapped(recipient),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
            child: Row(
              children: [
                // Profile Image
                Container(
                  width: 42.w,
                  height: 42.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      _getInitials(recipient.name),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 14.w),

                // Name, Alias, and Account Number - Expanded to take available space
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Name (favourite star removed — toggle it from the
                      // 3-dots menu instead).
                      Text(
                        _toTitleCase(recipient.name),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          letterSpacing: 0.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // Alias row if exists
                      if (recipient.alias != null && recipient.alias!.isNotEmpty) ...[
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Icon(
                              Icons.label,
                              size: 14,
                              color: const Color(0xFF4E03D0),
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Text(
                                recipient.alias!,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: const Color(0xFF4E03D0),
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                      // Account + bank line. Bank recipients LEAD with the
                      // resolved BANK NAME (not the sort code), then the account
                      // number; Lazervault recipients show just the account.
                      SizedBox(height: 4.h),
                      if (recipient.bankName.toLowerCase() != 'lazervault')
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                recipient.displayBankName,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (recipient.accountNumber.isNotEmpty) ...[
                              SizedBox(width: 6.w),
                              Text(
                                '• ${recipient.accountNumber}',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ],
                        )
                      else
                        Text(
                          recipient.accountNumber,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),

                // Action icons - fixed position on the right. Favourite is now
                // toggled from the overflow (3-dots) menu in BOTH flows — the
                // inline star has been removed. Per-recipient transaction
                // history is reached via the recipient tap sheet
                // ("View recent transactions") and the overflow menu
                // ("Transaction History") — the redundant inline icon is gone.

                // P2P chat button (all recipients — dialog for external)
                P2PChatIcon(
                  otherUserId: recipient.internalUserId,
                  otherUserName: recipient.name,
                  isInternal: recipient.type == 'internal',
                  accountNumber: recipient.accountNumber,
                ),

                // More options button (three-dot menu)
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20.r),
                    onTap: () => _showRecipientOptionsSheet(recipient),
                    child: Padding(
                      padding: EdgeInsets.all(6.w),
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.grey[600],
                        size: 22.w,
                      ),
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

  /// Runs a "Repeat" / inline send OVER the current screen. This Select
  /// Recipient screen already owns the send flow (its route provides
  /// TransferCubit/RecipientCubit), so the amount sheet appears ABOVE the
  /// existing screens instead of the launcher pushing a fresh (blank) send
  /// screen. Short flow → the inline amount → PIN → send sheet here; long flow
  /// → the full amount/confirm screen with the amount pre-filled.
  void _runInlineSend(RecipientModel r, {int? amountMinor, String? currency}) {
    if (widget.shortFlow) {
      // Defer one frame so the just-closed history sheet finishes dismissing
      // before the amount sheet opens over this screen.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        // ignore: discarded_futures
        _startShortSend(r,
            saveRecipient: false, prefillAmountMinor: amountMinor);
      });
    } else {
      Get.toNamed(AppRoutes.initiateSendFunds, arguments: {
        'recipient': r,
        if (amountMinor != null) 'prefillAmount': amountMinor,
        if (currency != null) 'prefillCurrency': currency,
        if (amountMinor != null) 'autoShowConfirm': true,
        'checkRecurring': true,
      });
    }
  }

  /// Opens the recent-transactions bottom sheet for [recipient] — the list of
  /// prior transfers to them (internal AND external, including failed ones).
  /// Tapping a row lets the user re-send a past amount / view its receipt.
  void _openRecipientTransactionsSheet(RecipientModel recipient) {
    if (recipient.accountNumber.isEmpty) {
      Get.snackbar(
        'No Account Number',
        'This recipient has no account number to search transactions for.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
      return;
    }

    Get.bottomSheet(
      BlocProvider(
        create: (_) => GetIt.I<RecipientTransactionHistoryCubit>(),
        child: RecipientTransactionHistoryModal(
          recipient: recipient,
          onSend: _runInlineSend,
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  /// Show options bottom sheet for recipient
  void _showRecipientOptionsSheet(RecipientModel recipient) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Sheet Handle
            Container(
              margin: EdgeInsets.symmetric(vertical: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              child: Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        _getInitials(recipient.name),
                        style: TextStyle(
                          color: const Color(0xFF4E03D0),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _toTitleCase(recipient.name),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          recipient.accountNumber,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Divider(height: 24.h, color: Colors.grey[200]),

            // Options List
            _buildOptionTile(
              icon: Icons.receipt_long_outlined,
              title: 'Transaction History',
              color: const Color(0xFF4E03D0),
              onTap: () {
                Get.back();
                _openRecipientTransactionsSheet(recipient);
              },
            ),
            _buildOptionTile(
              icon: Icons.schedule,
              title: 'Recurring Payments',
              color: const Color(0xFF3B82F6),
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.recurringTransfers);
              },
            ),
            _buildOptionTile(
              icon: Icons.person_outline,
              title: 'View Details',
              color: Colors.grey[700]!,
              onTap: () {
                Get.back();
                _showRecipientDetailsSheet(recipient);
              },
            ),
            _buildOptionTile(
              icon: Icons.edit_outlined,
              title: 'Add Alias',
              color: Colors.grey[700]!,
              onTap: () {
                Get.back();
                _showUpdateAliasDialog(recipient);
              },
            ),
            _buildOptionTile(
              icon: Icons.share_outlined,
              title: 'Share Account',
              color: Colors.grey[700]!,
              onTap: () {
                Get.back();
                _shareRecipient(recipient);
              },
            ),
            _buildOptionTile(
              icon: Icons.favorite_border,
              title: recipient.isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
              color: recipient.isFavorite ? Colors.amber[700]! : Colors.grey[700]!,
              onTap: () {
                Get.back();
                _toggleFavorite(recipient);
              },
            ),
            _buildOptionTile(
              icon: Icons.delete_outline,
              title: 'Remove Recipient',
              color: Colors.red[400]!,
              onTap: () {
                Get.back();
                _showRemoveConfirmation(recipient);
              },
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  /// Build option tile for bottom sheet
  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.black87,
        ),
      ),
      onTap: onTap,
    );
  }

  /// Show recipient details bottom sheet
  void _showRecipientDetailsSheet(RecipientModel recipient) {
    Get.bottomSheet(
      Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag Handle
            Container(
              margin: EdgeInsets.symmetric(vertical: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      color: const Color(0xFF4E03D0),
                      size: 28.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recipient Details',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF111827),
                          ),
                        ),
                        Text(
                          'Saved recipient information',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: const Color(0xFF6B7280),
                      size: 24.sp,
                    ),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // Scrollable content
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 24.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Purple Gradient Card
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Container(
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFF4E03D0),
                              const Color(0xFF5F14E1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Bank name with icon
                            Row(
                              children: [
                                Container(
                                  width: 40.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Icon(
                                    Icons.account_balance,
                                    color: Colors.white,
                                    size: 20.sp,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Text(
                                    recipient.displayBankName,
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.9),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Container(
                              height: 1,
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                            SizedBox(height: 20.h),

                            // Account holder name
                            Text(
                              'Account Holder',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.7),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              _toTitleCase(recipient.name),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),

                            SizedBox(height: 20.h),

                            // Account number
                            Text(
                              'Account Number',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.7),
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              recipient.accountNumber,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ),

                            // Alias
                            if (recipient.alias != null && recipient.alias!.isNotEmpty) ...[
                              SizedBox(height: 12.h),
                              Row(
                                children: [
                                  Icon(
                                    Icons.label_outline,
                                    color: Colors.white.withValues(alpha: 0.9),
                                    size: 16.sp,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'Alias: ${recipient.alias}',
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.9),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Additional details below the card
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: const Color(0xFFE5E7EB),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            if (recipient.sortCode.isNotEmpty)
                              _detailRow('Sort Code', recipient.sortCode),
                            if (recipient.countryCode != null && recipient.countryCode!.isNotEmpty)
                              _detailRow('Country', recipient.countryCode!),
                            if (recipient.currency != null && recipient.currency!.isNotEmpty)
                              _detailRow('Currency', recipient.currency!),
                            if (recipient.type != null && recipient.type!.isNotEmpty)
                              _detailRow('Type', _formatRecipientType(recipient.type)),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Action Buttons
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Get.back();
                                _shareRecipient(recipient);
                              },
                              icon: Icon(Icons.share, size: 18.sp),
                              label: Text('Share'),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                side: BorderSide(color: const Color(0xFF4E03D0)),
                                foregroundColor: const Color(0xFF4E03D0),
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Get.back();
                                _continueWithRecipient(recipient);
                              },
                              icon: Icon(Icons.send, size: 18.sp),
                              label: Text('Send Money'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4E03D0),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Detail row widget
  String _formatRecipientType(String? type) {
    switch (type?.toLowerCase()) {
      case 'internal':
        return 'Internal (Lazervault)';
      case 'external':
        return 'External (Bank)';
      case 'domestic':
        return 'Domestic Transfer';
      case 'international':
        return 'International Transfer';
      default:
        return type ?? 'Unknown';
    }
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF6B7280),
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF111827),
            ),
          ),
        ],
      ),
    );
  }

  /// Show update alias dialog
  void _showUpdateAliasDialog(RecipientModel recipient) {
    final controller = TextEditingController(text: recipient.alias ?? '');
    final authState = context.read<AuthenticationCubit>().state;
    final accessToken = (authState is AuthenticationSuccess)
        ? authState.profile.session.accessToken
        : null;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Add Alias'),
          content: TextField(
            controller: controller,
            maxLength: 50,
            decoration: const InputDecoration(
              hintText: 'Enter alias (e.g., "Mum", "Work")',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                final trimmedValue = controller.text.trim();
                if (accessToken != null) {
                  context.read<RecipientCubit>().updateAlias(
                    recipientId: recipient.id,
                    alias: trimmedValue.isEmpty ? null : trimmedValue,
                    accessToken: accessToken,
                  );
                  Get.snackbar(
                    'Success',
                    trimmedValue.isEmpty ? 'Alias removed' : 'Alias updated',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green.withValues(alpha: 0.8),
                    colorText: Colors.white,
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    ).whenComplete(() => controller.dispose());
  }

  /// Share recipient details
  void _shareRecipient(RecipientModel recipient) {
    var shareText =
        'Account details for:\nName: ${recipient.name}\nAccount Number: ${recipient.accountNumber}';
    shareText += '\nBank: ${recipient.displayBankName}';
    if (recipient.alias != null && recipient.alias!.isNotEmpty) {
      shareText += '\nAlias: ${recipient.alias}';
    }
    if (recipient.countryCode != null) {
      shareText += '\nCountry: ${recipient.countryCode}';
    }
    if (recipient.currency != null) {
      shareText += '\nCurrency: ${recipient.currency}';
    }
    shareText += '\n\n-Sent from Lazervault';
    SharePlus.instance.share(ShareParams(
        // iOS: a non-zero popover anchor is required — CGRectZero throws
        // PlatformException and the share silently fails on iPhone/iPad.
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1),text: shareText));
  }

  /// Toggle favorite status
  void _toggleFavorite(RecipientModel recipient) {
    final authState = context.read<AuthenticationCubit>().state;
    final accessToken = (authState is AuthenticationSuccess)
        ? authState.profile.session.accessToken
        : null;

    if (accessToken != null) {
      context.read<RecipientCubit>().toggleFavorite(
        recipientId: recipient.id,
        isFavorite: !recipient.isFavorite,
        accessToken: accessToken,
      );
      Get.snackbar(
        'Success',
        recipient.isFavorite ? 'Removed from favorites' : 'Added to favorites',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    }
  }

  /// Show remove confirmation dialog
  void _showRemoveConfirmation(RecipientModel recipient) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Remove Recipient'),
          content: Text('Are you sure you want to remove ${recipient.name}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                final authState = context.read<AuthenticationCubit>().state;
                final accessToken = (authState is AuthenticationSuccess)
                    ? authState.profile.session.accessToken
                    : null;
                if (accessToken != null) {
                  context.read<RecipientCubit>().deleteRecipient(
                    recipientId: recipient.id,
                    accessToken: accessToken,
                  );
                }
              },
              child: Text('Remove', style: TextStyle(color: Colors.red[400])),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLoadMoreIndicator(RecipientState state) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      alignment: Alignment.center,
      child: LazerVaultLoader.small(),
    );
  }

  /// Primary "find a person to send to" action — opens the shared unified
  /// search (your saved contacts incl. aliases like "Mum" first, then the
  /// global directory). Saved hits continue straight to send; global hits go
  /// through the existing Lazertag confirmation sheet.
  Future<void> _openUnifiedRecipientSearch() async {
    final result = await UnifiedUserSearchSheet.show(context, title: 'Send to');
    if (result == null || !mounted) return;
    if (result.isSavedHit) {
      final currency =
          CountryConfigs.getByCode(_currentCountry)?.currency ?? 'NGN';
      _continueWithRecipient(result.toRecipientModel(
        countryCode: _currentCountry,
        currency: currency,
      ));
    } else {
      _showLazertagUserConfirmation(result.toUserSearchResultEntity());
    }
  }

  // ignore: unused_element  (retained: device-contacts/bank picker, may be re-surfaced)
  void _showEnhancedRecipientSelection() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bottomSheetContext) => BlocProvider.value(
        value: context.read<RecipientCubit>(),
        child: EnhancedRecipientSelectionBottomSheet(
          onRecipientSelected: (recipient) {
            // Navigate to send funds with selected recipient
            Get.toNamed(AppRoutes.initiateSendFunds, arguments: recipient);
          },
          onLazertagUserSelected: (user) {
            // Convert LazertagUser to UserSearchResultEntity and show confirmation
            final searchResult = UserSearchResultEntity(
              userId: user.id,
              username: user.username,
              firstName: user.name.split(' ').first,
              lastName: user.name.split(' ').length > 1
                  ? user.name.split(' ').skip(1).join(' ')
                  : '',
              email: user.email ?? '',
              phoneNumber: user.phoneNumber ?? '',
              profilePicture: user.avatar ?? '',
              searchType: user.searchType,
            );
            // Show confirmation sheet after enhanced bottom sheet closes
            Future.delayed(const Duration(milliseconds: 350), () {
              if (!mounted) return;
              _showLazertagUserConfirmation(searchResult);
            });
          },
          onContactSelected: (contact) {
            // Show dialog to add contact as recipient, then navigate
            _showAddContactAsRecipientDialog(contact);
          },
        ),
      ),
    );
  }

  /// Show confirmation sheet for LazerTag user selected from enhanced bottom sheet.
  /// Lets the user choose save/favorite before proceeding to send funds.
  void _showLazertagUserConfirmation(UserSearchResultEntity user) async {
    bool confirmed = false;
    bool isSaved = false;
    bool isFavorite = false;
    String? alias;
    final sheetKey = GlobalKey<UsernameRecipientConfirmationSheetState>();

    await Get.bottomSheet(
      PopScope(
        canPop: true,
        child: UsernameRecipientConfirmationSheet(
          key: sheetKey,
          user: user,
          shortFlow: widget.shortFlow,
          onConfirm: () {
            confirmed = true;
            // Read save/favorite/alias state directly via GlobalKey
            final sheetState = sheetKey.currentState;
            if (sheetState != null) {
              isSaved = sheetState.isSaved;
              isFavorite = sheetState.isFavorite;
              alias = sheetState.alias;
            }
            Get.back();
          },
          onCancel: () {
            Get.back();
          },
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 200),
      backgroundColor: Colors.transparent,
    );

    if (!mounted) return;
    if (confirmed) {
      final currency = CountryConfigs.getByCode(_currentCountry)?.currency ?? 'NGN';
      final recipient = RecipientModel(
        id: user.userId,
        name: user.fullName,
        accountNumber: user.primaryAccountId ?? user.username,
        bankName: 'LazerVault',
        sortCode: '',
        isFavorite: isFavorite,
        isSaved: isSaved,
        alias: alias,
        countryCode: _currentCountry,
        currency: currency,
        email: user.email.isNotEmpty ? user.email : null,
        type: 'internal',
        internalUserId: user.userId,
      );
      // Honour the active flow: short → inline amount/PIN/receipt on this
      // screen; long → initiate-send-funds. Previously this always pushed the
      // long-flow route, so a user picked from "Search all Lazervault users" in
      // classic (short) flow was wrongly dumped into the long flow.
      _continueWithRecipient(recipient);
    }
  }

  /// The per-user MRU pref key. The MRU is a personal signal, so namespace it by
  /// the signed-in user id — a device-global key leaks one user's recent banks
  /// to the next user who signs in on the same device. Falls back to the plain
  /// key when no user id is resolvable.
  Future<String> _recentBanksKey() async {
    try {
      final userId = await serviceLocator<SecureStorageService>().getUserId();
      if (userId != null && userId.isNotEmpty) {
        return '${_kRecentBanksKey}_$userId';
      }
    } catch (_) {/* fall back to the plain key */}
    return _kRecentBanksKey;
  }

  /// Load the MRU bank codes (for the picker's "Recent" sort). Best-effort.
  Future<void> _loadRecentBanks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _recentBankCodes = prefs.getStringList(await _recentBanksKey()) ?? [];
    } catch (_) {/* no recents */}
  }

  /// Remember a just-selected bank as most-recent (newest first, deduped, cap 8).
  Future<void> _recordRecentBank(String? code) async {
    if (code == null || code.isEmpty) return;
    _recentBankCodes = [code, ..._recentBankCodes.where((c) => c != code)]
        .take(8)
        .toList();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(await _recentBanksKey(), _recentBankCodes);
    } catch (_) {/* best-effort */}
  }

  /// A single sort pill for the bank picker (Most popular / A–Z / Recent).
  Widget _bankSortPill(
      String label, BankSort value, BankSort selected, VoidCallback onTap) {
    final isSel = value == selected;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        decoration: BoxDecoration(
          color: isSel ? const Color(0xFF4E03D0) : Colors.grey[100],
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
              color: isSel ? const Color(0xFF4E03D0) : Colors.grey[300]!),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSel ? Colors.white : Colors.grey[700],
            fontSize: 13.sp,
            fontWeight: isSel ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void _loadBanksIfNeeded() {
    if (_banksList.isNotEmpty || _isLoadingBanks) return;
    _loadRecentBanks();
    MostUsedBanks.load().then((codes) {
      if (mounted) setState(() => _mostUsedBankCodes = codes);
    });
    // Server-authoritative refresh (cross-device), then reload. Best-effort.
    MostUsedBanks.syncFromBackend().then((_) {
      MostUsedBanks.load().then((codes) {
        if (mounted) setState(() => _mostUsedBankCodes = codes);
      });
    });

    // Get country from LocaleManager
    try {
      final localeManager = serviceLocator<LocaleManager>();
      _currentCountry = localeManager.currentCountry;
    } catch (e) {
      _currentCountry = 'NG'; // Default to Nigeria
    }

    // Static list for first paint, then refresh from the dynamic
    // (Flutterwave-backed) source so codes stay valid for transfers.
    setState(() {
      _banksList = BanksData.getBanksForCountry(_currentCountry);
      _isLoadingBanks = false;
      _banksError = null;
    });

    serviceLocator<BankRepository>().getBanks(_currentCountry).then((banks) {
      if (mounted && banks.isNotEmpty) {
        setState(() => _banksList = banks);
      }
    }).catchError((_) {/* keep static fallback */});
  }

  void _showAddContactAsRecipientDialog(DeviceContact contact) {
    // Reset contact verification state
    _contactSelectedBankCode = null;
    _contactSelectedBankName = null;
    _contactVerificationResult = null;

    // Load banks first
    _loadBanksIfNeeded();
    _showContactBankSelectionSheet(contact);
  }

  /// Step 1: Show bank selection for contact
  void _showContactBankSelectionSheet(DeviceContact contact) {
    // Hoist the controller + query OUTSIDE StatefulBuilder. Previously
    // they were declared inside StatefulBuilder.builder, so every
    // setSheetState rebuilt the text field with a fresh empty controller
    // and reset searchQuery — the typed character was wiped on the very
    // next frame, so the search appeared to do nothing.
    final searchController = TextEditingController();
    String searchQuery = '';
    // Bank list sort — defaults to most-popular (Nigerian ranking). Hoisted like
    // searchQuery so setSheetState mutations survive rebuilds.
    BankSort bankSort = BankSort.mostUsed;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
              ),
              child: Column(
                children: [
                  // Handle Bar
                  Container(
                    margin: EdgeInsets.only(top: 12.h),
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),

                  // Header Section
                  Container(
                    padding: EdgeInsets.all(24.w),
                    child: Row(
                      children: [
                        // Contact Avatar
                        Container(
                          width: 48.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 78, 3, 208),
                                Color.fromARGB(255, 95, 20, 225),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(
                            child: Text(
                              contact.name.isNotEmpty
                                  ? contact.name.substring(0, 1).toUpperCase()
                                  : '?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                contact.name,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Select their bank',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.grey[600],
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Search Bar
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24.w),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        setSheetState(() {
                          searchQuery = value.toLowerCase();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search banks...',
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14.sp,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey[500],
                          size: 20.sp,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Sort pills — default "Most used" (the user's own transfer
                  // history; falls back to popularity when there's none yet).
                  SizedBox(
                    height: 34.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _bankSortPill('Most used', BankSort.mostUsed, bankSort,
                            () => setSheetState(
                                () => bankSort = BankSort.mostUsed)),
                        SizedBox(width: 8.w),
                        _bankSortPill('Most popular', BankSort.popular, bankSort,
                            () => setSheetState(() => bankSort = BankSort.popular)),
                        SizedBox(width: 8.w),
                        _bankSortPill('A–Z', BankSort.alphabetical, bankSort,
                            () => setSheetState(
                                () => bankSort = BankSort.alphabetical)),
                        SizedBox(width: 8.w),
                        _bankSortPill('Recent', BankSort.recent, bankSort,
                            () => setSheetState(() => bankSort = BankSort.recent)),
                      ],
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Banks List
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        if (_isLoadingBanks) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LazerVaultLoader.small(),
                                SizedBox(height: 16.h),
                                Text(
                                  'Loading banks...',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        if (_banksError != null) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  size: 48.sp,
                                  color: Colors.red[400],
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  'Failed to load banks',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16.sp,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                TextButton(
                                  onPressed: () {
                                    _loadBanksIfNeeded();
                                    setSheetState(() {});
                                  },
                                  child: Text('Retry'),
                                ),
                              ],
                            ),
                          );
                        }

                        final matched = searchQuery.isEmpty
                            ? _banksList
                            : _banksList
                                .where((bank) => bank["name"]!
                                    .toLowerCase()
                                    .contains(searchQuery))
                                .toList();
                        final filteredBanks =
                            sortBanks(matched, bankSort, _recentBankCodes,
                                mostUsedCodes: _mostUsedBankCodes);

                        if (filteredBanks.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 48.sp,
                                  color: Colors.grey[400],
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  'No banks found',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          itemCount: filteredBanks.length,
                          itemBuilder: (context, index) {
                            final bank = filteredBanks[index];
                            return Container(
                              margin: EdgeInsets.only(bottom: 8.h),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(bottomSheetContext);
                                    _contactSelectedBankCode = bank["code"];
                                    _contactSelectedBankName = bank["name"];
                                    _recordRecentBank(bank["code"]);
                                    _showContactAccountNumberSheet(contact);
                                  },
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Container(
                                    padding: EdgeInsets.all(16.w),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12.r),
                                      border:
                                          Border.all(color: Colors.grey[200]!),
                                    ),
                                    child: Row(
                                      children: [
                                        BankLogo(
                                          bankName: bank["name"]!,
                                          bankCode: bank["code"],
                                          country: _currentCountry,
                                          size: 40,
                                          borderRadius: 10,
                                        ),
                                        SizedBox(width: 12.w),
                                        Expanded(
                                          child: Text(
                                            bank["name"]!,
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.grey[400],
                                          size: 16.sp,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).whenComplete(() => searchController.dispose());
  }

  /// Step 2: Show account number entry for contact
  void _showContactAccountNumberSheet(DeviceContact contact) {
    final accountController = TextEditingController();
    bool isVerifying = false;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return BlocListener<AccountVerificationCubit,
                AccountVerificationState>(
              listener: (context, verificationState) {
                if (verificationState is AccountVerificationLoading) {
                  setSheetState(() {
                    isVerifying = true;
                  });
                } else if (verificationState is AccountVerificationSuccess) {
                  setSheetState(() {
                    isVerifying = false;
                  });
                  _contactVerificationResult = AccountVerificationResult(
                    accountNumber: verificationState.accountNumber,
                    accountName: verificationState.accountName,
                    bankName: verificationState.bankName,
                    bankCode: verificationState.bankCode,
                    verificationStatus: verificationState.verificationStatus,
                  );
                  Navigator.pop(bottomSheetContext);
                  _showContactConfirmationSheet(contact);
                } else if (verificationState is AccountVerificationFailure) {
                  setSheetState(() {
                    isVerifying = false;
                  });
                  Get.snackbar(
                    'Verification Failed',
                    verificationState.userMessage,
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red.withValues(alpha: 0.8),
                    colorText: Colors.white,
                  );
                }
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Handle Bar
                      Center(
                        child: Container(
                          width: 40.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Header
                      Row(
                        children: [
                          BankLogo(
                            bankName: _contactSelectedBankName ?? '',
                            bankCode: _contactSelectedBankCode,
                            country: _currentCountry,
                            size: 48,
                            borderRadius: 12,
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  contact.name,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  _contactSelectedBankName ?? '',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                color: Colors.grey[600],
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32.h),

                      // Account Number Label
                      Text(
                        'Account Number',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      // Account Number Field
                      TextField(
                        controller: accountController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[50],
                          hintText: 'Enter 10-digit account number',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          prefixIcon: Icon(Icons.numbers_outlined,
                              color: Colors.grey[600]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(color: Colors.grey[200]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(color: Colors.grey[200]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 78, 3, 208),
                              width: 2,
                            ),
                          ),
                          counterText: '',
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) {
                          setSheetState(() {});
                        },
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Enter the 10-digit account number for ${contact.name}',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12.sp,
                        ),
                      ),

                      Spacer(),

                      // Verify Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isVerifying ||
                                  accountController.text.length != 10
                              ? null
                              : () {
                                  this
                                      .context
                                      .read<AccountVerificationCubit>()
                                      .verifyAccount(
                                        bankCode: _contactSelectedBankCode!,
                                        accountNumber: accountController.text,
                                        bankName: _contactSelectedBankName!,
                                      );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 78, 3, 208),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            disabledBackgroundColor: Colors.grey[300],
                          ),
                          child: isVerifying
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LazerVaultLoader.small(),
                                    SizedBox(width: 12.w),
                                    Text(
                                      'Verifying...',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )
                              : Text(
                                  'Verify Account',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).padding.bottom + 16.h),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() => accountController.dispose());
  }

  /// Step 3: Show confirmation with verified account name
  void _showContactConfirmationSheet(DeviceContact contact) {
    bool isFavorite = false;
    String? alias;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
              ),
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Handle Bar
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Success Icon
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 48.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    Center(
                      child: Text(
                        'Account Verified!',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Account Details Card
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Column(
                        children: [
                          _buildDetailRow(
                            'Account Name',
                            _contactVerificationResult?.accountName ?? '',
                            isHighlighted: true,
                          ),
                          Divider(height: 24.h, color: Colors.grey[200]),
                          _buildDetailRow(
                            'Account Number',
                            _contactVerificationResult?.accountNumber ?? '',
                          ),
                          Divider(height: 24.h, color: Colors.grey[200]),
                          _buildDetailRow(
                            'Bank',
                            _contactVerificationResult?.bankName ?? '',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Save as Favorite Toggle
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.amber.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isFavorite ? Icons.star : Icons.star_border,
                            color: Colors.amber[700],
                            size: 24.sp,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              'Save to favorites',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Switch(
                            value: isFavorite,
                            onChanged: (value) {
                              setSheetState(() {
                                isFavorite = value;
                              });
                            },
                            activeThumbColor: Color.fromARGB(255, 78, 3, 208),
                          ),
                        ],
                      ),
                    ),

                    // Alias Input (visible when favorite is toggled)
                    if (isFavorite) ...[
                      SizedBox(height: 12.h),
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: TextField(
                          maxLength: 50,
                          decoration: InputDecoration(
                            hintText: 'Set alias (optional)',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14.sp,
                            ),
                            border: InputBorder.none,
                            counterText: '',
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          onChanged: (value) {
                            setSheetState(() {
                              alias = value.isEmpty ? null : value;
                            });
                          },
                        ),
                      ),
                    ],

                    Spacer(),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(bottomSheetContext);
                              _contactVerificationResult = null;
                            },
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              side: BorderSide(color: Colors.grey[300]!),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(bottomSheetContext);
                              _proceedToPaymentWithContact(contact, isFavorite, alias);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 78, 3, 208),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: Text(
                              'Proceed to Payment',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).padding.bottom + 16.h),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value,
      {bool isHighlighted = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14.sp,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              color: isHighlighted ? Colors.green[700] : Colors.black87,
              fontSize: isHighlighted ? 16.sp : 14.sp,
              fontWeight: isHighlighted ? FontWeight.w700 : FontWeight.w600,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  void _proceedToPaymentWithContact(DeviceContact contact, bool isFavorite, String? alias) {
    if (_contactVerificationResult == null) return;

    final temporaryRecipient = RecipientModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _contactVerificationResult!.accountName,
      accountNumber: _contactVerificationResult!.accountNumber,
      bankName: _contactVerificationResult!.bankName,
      sortCode: _contactVerificationResult!.bankCode,
      isFavorite: isFavorite,
      isSaved: false,
      alias: alias,
      countryCode: 'NG',
      currency: 'NGN',
    );

    _continueWithRecipient(temporaryRecipient);
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    int badgeCount = 0,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Badge overlays the icon circle directly (anchored to the icon, NOT
          // the wider label box) so it sits snug at the icon's edge.
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: Color.fromARGB(255, 78, 3, 208),
                  size: 24,
                ),
              ),
              if (badgeCount > 0)
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: badgeCount > 9 ? 4.w : 0,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 18.w,
                      minHeight: 18.w,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444),
                      borderRadius: BorderRadius.circular(9.r),
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      badgeCount > 99 ? '99+' : '$badgeCount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
          // Fixed-width, centered, single-line label — smaller + tighter
          // letter-spacing so labels like "Scan Account"/"Scan History" fit on
          // one line instead of wrapping.
          SizedBox(
            width: 72.w,
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 9.5.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.2,
                height: 1.1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchQRScanner() async {
    try {
      // Step 1: Open QR scanner and wait for result
      final result = await Get.toNamed(AppRoutes.qrScanner);

      if (result == null || result is! Map<String, dynamic>) return;
      if (!mounted) return;

      final username = result['username'] as String? ?? '';
      final userId = result['recipientId'] as String? ?? '';

      // Validate we have enough data to verify
      if (username.isEmpty && userId.isEmpty) {
        _showQrScanErrorSheet(
          'Invalid QR Data',
          'The scanned QR code is missing recipient information. Please try scanning again.',
        );
        return;
      }

      // Step 2: Show verification loading sheet immediately
      _showQrVerificationLoadingSheet();
      // Allow the bottom sheet to render before starting network call
      await Future.delayed(const Duration(milliseconds: 100));

      // Step 3: Verify user exists on backend
      ProfileCubit? profileCubit;
      try {
        profileCubit = serviceLocator<ProfileCubit>();
        final searchQuery = username.isNotEmpty ? username : userId;
        final users = await profileCubit.searchUsers(searchQuery, limit: 5);

        // Dismiss loading sheet
        if (Get.isBottomSheetOpen ?? false) Get.back();
        if (!mounted) return;

        // Step 4: Match by userId or exact username
        UserSearchResultEntity? matchedUser;
        for (final u in users) {
          if ((userId.isNotEmpty && u.userId == userId) ||
              (username.isNotEmpty && u.username == username)) {
            matchedUser = u;
            break;
          }
        }

        if (matchedUser == null) {
          _showQrScanErrorSheet(
            'User Not Found',
            'The scanned QR code belongs to a user that could not be found. They may have deleted their account.',
          );
          return;
        }

        if (!mounted) return;

        // Step 5: Show confirmation bottom sheet with verified user details
        final qrCurrency = result['currency'] as String?;
        final currency = qrCurrency ??
            CountryConfigs.getByCode(_currentCountry)?.currency ??
            'NGN';
        final rawAmount = result['amount'];
        final qrAmount = rawAmount is int
            ? rawAmount
            : rawAmount is num
                ? rawAmount.toInt()
                : null;

        final action = await QrScanConfirmationSheet.show(
          context,
          user: matchedUser,
          requestedAmount: qrAmount,
          requestedCurrency: currency,
        );

        if (!mounted) return;

        if (action == QrScanAction.rescan) {
          // Re-launch scanner (loop)
          _launchQRScanner();
          return;
        }

        if (action == QrScanAction.confirm) {
          // Step 6: Create recipient from verified data and navigate
          final recipient = RecipientModel(
            id: matchedUser.userId,
            name: matchedUser.fullName,
            accountNumber: matchedUser.username,
            bankName: 'LazerVault',
            sortCode: '',
            isFavorite: false,
            isSaved: false,
            countryCode: _currentCountry,
            currency: currency,
            profileImageUrl: matchedUser.profilePicture,
            type: 'internal',
            internalUserId: matchedUser.userId,
          );

          final arguments = <String, dynamic>{'recipient': recipient};
          if (qrAmount != null) {
            arguments['prefillAmount'] = qrAmount;
            arguments['prefillCurrency'] = currency;
          }
          // qrAmount is in MINOR units — pass it to BOTH flows (long via
          // arguments, short via prefillAmountMinor) so classic mode prefills too.
          _continueWithRecipient(recipient,
              longFlowArguments: arguments, prefillAmountMinor: qrAmount);
        }
      } catch (e) {
        // Dismiss loading sheet if still open
        if (Get.isBottomSheetOpen ?? false) Get.back();
        if (!mounted) return;
        _showQrScanErrorSheet(
          'Verification Failed',
          'Could not verify the recipient. Please check your internet connection and try again.',
        );
      } finally {
        profileCubit?.close();
      }
    } catch (e) {
      Get.snackbar(
        'QR Scanner Error',
        'Failed to open QR scanner. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
    }
  }

  void _showQrVerificationLoadingSheet() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 32.h),
            Container(
              width: 72.w,
              height: 72.h,
              decoration: BoxDecoration(
                color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: LazerVaultLoader(size: 36),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Verifying Recipient',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF111827),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Checking user details...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF6B7280),
              ),
            ),
            SizedBox(height: 16.h),
            LinearProgressIndicator(
              backgroundColor: const Color(0xFFE5E7EB),
              valueColor: const AlwaysStoppedAnimation(Color(0xFF4E03D0)),
              minHeight: 3.h,
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
      isDismissible: false,
      enableDrag: false,
    );
  }

  void _showQrScanErrorSheet(String title, String message, {bool isWarning = false}) {
    final color = isWarning ? Colors.orange : Colors.red;
    final icon = isWarning ? Icons.warning_amber_rounded : Icons.error_outline;

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 32.h),
            Container(
              width: 72.w,
              height: 72.h,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 36.sp),
            ),
            SizedBox(height: 24.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF111827),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF6B7280),
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      side: const BorderSide(color: Color(0xFFE5E7EB)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      _launchQRScanner();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4E03D0),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Try Again',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Future<void> _launchSplitBills() async {
    Get.toNamed(AppRoutes.splitBills)?.then((_) {
      // Refresh pending co-payer count after returning (user may have paid/declined)
      serviceLocator<SplitBillCountCubit>().refresh();
    });
  }

  /// Builds the transfer-history panel shown when the user taps the "History"
  /// pill (beside "Recurring"). Shows the user's transfer transactions inline,
  /// rendered with bank logos for external-bank transfers via the shared
  /// [TransferHistoryItem]. Backed by the lazily-created [_historyCubit].
  Widget _buildHistoryList() {
    final cubit = _historyCubit;
    if (cubit == null) {
      return _buildLoadingWidget();
    }
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<TransactionHistoryCubit, TransactionHistoryState>(
        builder: (context, state) {
          if (state is TransactionHistoryInitial ||
              state is TransactionHistoryLoading) {
            return _buildLoadingWidget();
          }
          if (state is TransactionHistoryError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_off_rounded,
                        color: Colors.grey[400], size: 48.sp),
                    SizedBox(height: 16.h),
                    Text(
                      _friendlyError(state.message),
                      style: TextStyle(color: Colors.grey[400], fontSize: 14.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    TextButton(
                      onPressed: () => cubit.loadAllTransactions(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          // Pull the loaded transactions (Empty + Loaded both yield a list we
          // can filter to transfers; Empty simply has none).
          final List<UnifiedTransaction> all =
              state is TransactionHistoryLoaded ? state.transactions : const [];
          final bool hasMore =
              state is TransactionHistoryLoaded && state.hasMore;
          final transfers = all.where(isTransferTransaction).toList();

          if (transfers.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.swap_horiz,
                        color: Colors.grey[400], size: 48.sp),
                    SizedBox(height: 16.h),
                    Text(
                      'No transfer history yet',
                      style: TextStyle(color: Colors.grey[600], fontSize: 16.sp),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Your past transfers will show up here.',
                      style: TextStyle(color: Colors.grey[500], fontSize: 13.sp),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (n) {
              if (hasMore &&
                  !_historyLoadingMore &&
                  n.metrics.pixels >= n.metrics.maxScrollExtent - 200) {
                _historyLoadingMore = true;
                cubit.loadMoreTransactions().then((_) {
                  _historyLoadingMore = false;
                });
              }
              return false;
            },
            child: RefreshIndicator(
              color: const Color.fromARGB(255, 78, 3, 208),
              onRefresh: () => cubit.refreshTransactions(),
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                itemCount: transfers.length + (hasMore ? 1 : 0),
                separatorBuilder: (_, __) =>
                    Divider(color: Colors.grey[200], height: 1),
                itemBuilder: (context, index) {
                  if (index >= transfers.length) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: const Center(child: LazerVaultLoader.tiny()),
                    );
                  }
                  return TransferHistoryItem(transaction: transfers[index]);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  /// Builds the recurring-transfers panel shown when the user taps the
  /// "Recurring" pill. Uses the central `_buildLoadingWidget()` for the
  /// loading state (consistent with the recipients list) and reuses the
  /// same card layout via `_buildRecurringTransferItem`.
  Widget _buildRecurringList() {
    final cubit = _recurringTransferCubit;
    if (cubit == null) {
      return _buildLoadingWidget();
    }
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<RecurringTransferCubit, RecurringTransferState>(
        builder: (context, state) {
          if (state is RecurringTransferInitial ||
              state is RecurringTransferLoading) {
            return _buildLoadingWidget();
          }
          if (state is RecurringTransferError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_off_rounded,
                        color: Colors.grey[400], size: 48.sp),
                    SizedBox(height: 16.h),
                    Text(
                      _friendlyError(state.message),
                      style: TextStyle(
                          color: Colors.grey[400], fontSize: 14.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    TextButton(
                      onPressed: () => cubit.loadRecurringTransfers(status: 'active'),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is RecurringTransferListLoaded) {
            final transfers = state.transfers;
            if (transfers.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.repeat_rounded,
                          color: Colors.grey[400], size: 48.sp),
                      SizedBox(height: 16.h),
                      Text(
                        'No active recurring transfers',
                        style: TextStyle(
                            color: Colors.grey[600], fontSize: 16.sp),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Set one up from any transfer confirmation.',
                        style: TextStyle(
                            color: Colors.grey[500], fontSize: 13.sp),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }
            return RefreshIndicator(
              color: const Color.fromARGB(255, 78, 3, 208),
              onRefresh: () async {
                await cubit.loadRecurringTransfers(status: 'active');
              },
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                padding: EdgeInsets.symmetric(vertical: 8.h),
                itemCount: transfers.length,
                itemBuilder: (context, index) =>
                    _buildRecurringTransferItem(transfers[index]),
              ),
            );
          }
          // Any non-list terminal state (Created / Updated / Deleted /
          // DetailLoaded) — just show the loader briefly; the cubit will
          // be refreshed back to ListLoaded by the next user action.
          return _buildLoadingWidget();
        },
      ),
    );
  }

  /// Card for a single recurring transfer. Tap navigates to the detail
  /// screen (same surface as the standalone recurring transfers list).
  Widget _buildRecurringTransferItem(RecurringTransferEntity t) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          // Pass the full entity so the detail screen renders instantly (it
          // also accepts a bare id as a fallback). Passing `t.id` used to crash
          // with "String is not a subtype of RecurringTransferEntity".
          onTap: () => Get.toNamed(
            AppRoutes.recurringTransferDetail,
            arguments: t,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDE7FA),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.repeat_rounded,
                      color: const Color.fromARGB(255, 78, 3, 208),
                      size: 22.sp,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _toTitleCase(t.recipientName),
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        '${t.recipientBankName.isEmpty ? "Lazervault" : t.recipientBankName} • ${t.frequency.label}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${t.currency} ${t.amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: t.status == RecurringTransferStatus.active
                            ? const Color(0xFFE6F8EE)
                            : const Color(0xFFFDECEC),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        t.status.label,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: t.status == RecurringTransferStatus.active
                              ? const Color(0xFF1AA260)
                              : const Color(0xFFD64545),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LazerVaultLoader.small(),
          SizedBox(height: 16.h),
          Text(
            'Loading recipients...',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
