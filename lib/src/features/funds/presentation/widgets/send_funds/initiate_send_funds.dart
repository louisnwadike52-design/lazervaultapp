import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
// For serviceLocator
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/core/services/analytics_service.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/core/utils/kyc_error_handler.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_state.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_prediction_cubit.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/transfer_prediction_alert.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/add_recipient_usecase.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/services/pending_chat_transfers.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/features/funds/cubit/recurring_transfer_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/recurring_transfer_state.dart';
import 'package:lazervault/src/features/funds/domain/entities/recurring_transfer_entity.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/recurring_transfer_config.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/recurring_transfer_modal.dart';
import 'package:lazervault/src/features/funds/presentation/view/scheduled_transfers_list_screen.dart';
import 'package:lazervault/src/features/funds/presentation/view/recurring_transfers/recurring_transfers_list_screen.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/transfer_error_bottomsheet.dart';
import 'package:lazervault/src/features/widgets/category_selection.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/budget_warning_sheet.dart';
import 'package:lazervault/src/features/widgets/budget_warning_widget.dart';
import 'package:lazervault/src/features/widgets/budget_override_dialog.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_cubit.dart';
import 'package:lazervault/src/features/p2p_chat/domain/repositories/p2p_chat_repository.dart';
import 'package:uuid/uuid.dart';

class InitiateSendFunds extends StatefulWidget {
  final RecipientModel? recipient;

  const InitiateSendFunds({super.key, this.recipient});

  @override
  State<InitiateSendFunds> createState() => _InitiateSendFundsState();
}

class _InitiateSendFundsState extends State<InitiateSendFunds>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  // Recipient handling variables
  RecipientModel? _recipient;


  String amount =
      ''; // Stores amount as string of MINOR units (e.g., "2000" for £20.00)
  // final double maxAmount = 15358.00; // TODO: Get max from selected card/account later
  int selectedCardIndex = 0;
  // The source wallet is LOCKED to the account active on the dashboard (the
  // one the user swiped into). Other accounts render disabled — you send from
  // the account you're in. _didInitActiveSelection makes the one-time
  // pre-selection idempotent across rebuilds.
  bool _didInitActiveSelection = false;
  String? get _activeAccountId =>
      serviceLocator<AccountManager>().activeAccountId;
  ServiceCategory? selectedCategory;
  List<ServiceCategory> _availableCategories = ServiceCategory.commonTransferCategories;
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _isConfirmingTransfer = false; // State for dialog loading
  bool _autoShowConfirm = false;
  bool _autoConfirmTriggered = false;

  final List<int> quickAmounts = [50, 100, 200, 500]; // Major units for display

  // Categories loaded from backend via BudgetCubit.loadServiceCategories

  DateTime? scheduledDate;
  // TimeOfDay? scheduledTime; // Removed as DateTime handles both

  bool _isRecurringEnabled = false;
  RecurringTransferConfig? _recurringConfig;

  // Budget enforcement state
  BudgetValidationResult? _lastBudgetResult;

  // Tracks whether we're waiting for both transfer + recurring setup to complete
  // before navigating to receipt. Prevents recurring error being lost during navigation.
  bool _recurringSetupPending = false;
  bool _transferSucceeded = false;
  bool _hasNavigatedToReceipt = false;
  TransferSuccess? _pendingTransferSuccess;
  Map<String, dynamic>? _lastTransferDetails;

  // Stored for deferred recurring setup after transfer succeeds
  String? _pendingRecurringTransactionId;
  String? _pendingRecurringVerificationToken;

  // Guards against duplicate recurring setup and tracks created transfer for rollback
  bool _recurringSetupInitiated = false;
  String? _createdRecurringTransferId;
  int _recurringRetryCount = 0;
  static const _maxRecurringRetries = 2;

  // Tracks the pending recipient save so we can await it before navigation.
  // Prevents race condition where Get.offAllNamed disposes the tree before
  // the fire-and-forget save completes (especially when recurring is enabled).
  Future<void>? _pendingRecipientSave;

  // Informational, READ-ONLY transfer success prediction (non-blocking).
  // Owned by this screen so it survives the confirmation dialog's lifecycle.
  // Driven only for EXTERNAL transfers (recipient bank != 'LazerVault').
  final TransferPredictionCubit _predictionCubit =
      serviceLocator<TransferPredictionCubit>();

  // --- Fetch Accounts on Init ---
  @override
  void initState() {
    super.initState();

    // Freeze the short/long flow decision for the duration of this send journey
    // (released in dispose, when the user is back on the dashboard) so a login
    // revalidation / admin flip can never switch the flow mid-journey.
    FeatureFlags.beginSendFlow();

    // Telemetry: long-flow send-funds screen view.
    AnalyticsService.instance.trackSendFundsScreen('initiate', 'long');

    // Resolve recipient. Constructor param wins; otherwise fall back
    // to Get.arguments (RecipientModel or Map).
    if (widget.recipient != null) {
      _recipient = widget.recipient;
    } else {
      final args = Get.arguments;
      if (args is Map<String, dynamic>) {
        _recipient = args['recipient'] as RecipientModel?;
      } else if (args is RecipientModel) {
        _recipient = args;
      }
    }

    // Apply optional pre-fill keys regardless of whether the recipient
    // came from widget.recipient or Get.arguments. The route handler
    // passes the recipient via constructor param BUT preserves the
    // original Map in Get.arguments so callsites like
    // _launchBankDetailsScan can thread `prefillAmount` + memo +
    // autoShowConfirm + checkRecurring through. Without checking
    // Get.arguments here, those keys would be silently dropped when
    // the recipient came via constructor param.
    final routeArgs = Get.arguments;
    if (routeArgs is Map<String, dynamic>) {
      final prefillAmount = routeArgs['prefillAmount'] as int?;
      if (prefillAmount != null && prefillAmount > 0) {
        amount = prefillAmount.toString();
        _amountController.text = _formatAmount();
      }
      // OCR memo / scan description pre-fills the reference field so
      // the user only confirms instead of typing it.
      final prefillDescription = routeArgs['prefillDescription'] as String?;
      if (prefillDescription != null && prefillDescription.isNotEmpty) {
        _referenceController.text = prefillDescription;
      }
      _autoShowConfirm = routeArgs['autoShowConfirm'] == true;
      if (routeArgs['checkRecurring'] == true && _recipient != null) {
        _loadRecurringForRecipient(_recipient!.accountNumber);
      }
    }

    // Check the current state of the accounts cubit
    final accountCubit = context.read<AccountCardsSummaryCubit>();
    final currentState = accountCubit.state;

    // Only fetch if the data hasn't been loaded or isn't currently loading
    // Always trigger a balance refresh on screen entry — stale-while-
    // revalidate. The cached AccountCardsSummaryLoaded state stays
    // visible while the new fetch runs (BlocBuilder retains the last
    // payload), then swaps in the fresh balance the moment it arrives.
    //
    // This fixes a stale-amount bug: previously we only fetched when
    // the state was Initial/Error, so a successful deposit or external
    // top-up between visits would leave this screen rendering the
    // pre-deposit balance (often ₦0.00 for newly-funded accounts).
    // WebSocket BalanceUpdate covers live updates while the screen is
    // open; this initState refresh handles the cold-mount case.
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      final userId = authState.profile.user.id;
      final accessToken = authState.profile.session.accessToken;
      print(
          "InitiateSendFunds: refreshing account summaries on screen entry (state was $currentState).");
      accountCubit.fetchAccountSummaries(
        userId: userId,
        accessToken: accessToken,
      );
    } else {
      print(
          "InitiateSendFunds: User not authenticated, cannot fetch accounts.");
    }

    // Auto-show confirm if accounts already loaded and prefill is set —
    // independent of whether we re-triggered a fetch above (the cached
    // summaries are still in `currentState`, so the confirm sheet has
    // enough to render).
    if (_autoShowConfirm &&
        !_autoConfirmTriggered &&
        amount.isNotEmpty &&
        _recipient != null &&
        (currentState is AccountCardsSummaryLoaded ||
            currentState is AccountBalanceUpdated)) {
      _autoConfirmTriggered = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _showTransferConfirmation(currentState);
      });
    }

    // Load categories from backend
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final budgetCubit = context.read<BudgetCubit>();
      final categories = await budgetCubit.loadAllServiceCategories();
      if (mounted && categories.isNotEmpty) {
        setState(() {
          _availableCategories = categories;
        });
      }
    } on ProviderNotFoundException catch (_) {
      // BudgetCubit not in tree — keep fallback categories
    } catch (e) {
      debugPrint('Failed to load categories: $e');
      // Keep fallback categories
    }
  }

  /// Load any active recurring transfer for the given recipient account number.
  /// If found, auto-enable recurring with the existing config.
  void _loadRecurringForRecipient(String recipientAccountNumber) {
    try {
      final recurringCubit = context.read<RecurringTransferCubit>();
      recurringCubit.loadByRecipient(recipientAccountNumber);
      // The BlocListener for RecurringTransferCubit will handle the result —
      // we listen for RecurringTransferListLoaded in the existing listener.
      // Add a one-time stream listener here since we need to catch the state.
      late final void Function(RecurringTransferState) listener;
      listener = (state) {
        if (state is RecurringTransferListLoaded) {
          final activeTransfers = state.transfers.where((t) => t.isActive).toList();
          if (activeTransfers.isNotEmpty && mounted) {
            setState(() {
              _isRecurringEnabled = true;
              _recurringConfig = RecurringTransferConfig.fromEntity(activeTransfers.first);
            });
          }
        }
      };
      // Listen once via stream
      recurringCubit.stream.firstWhere(
        (s) => s is RecurringTransferListLoaded || s is RecurringTransferError,
      ).then((state) {
        if (state is RecurringTransferListLoaded) {
          listener(state);
        }
      }).catchError((_) {});
    } catch (_) {
      // RecurringTransferCubit not available — silently skip
    }
  }

  // --- Input and Formatting Logic (Updated for Minor Units) ---

  void _onNumberPress(String value) {
    // Dismiss keyboard if open (user switching from keyboard to pad)
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      if (value == '<') {
        if (amount.isNotEmpty) {
          amount = amount.substring(0, amount.length - 1);
        }
      } else {
        // Prevent leading zeros (e.g., "007" → just "7")
        if (amount == '0' && value == '0') return;
        // Prevent excessive length (e.g., 8 digits for £99999.99)
        if (amount.length < 8) {
          amount += value;
        }
      }
      // Update controller to show formatted value
      _amountController.text = _formatAmount();
      // Move cursor to end so next keyboard input appends correctly
      _amountController.selection = TextSelection.fromPosition(
        TextPosition(offset: _amountController.text.length),
      );
    });
  }

  /// Handle direct keyboard input in the amount field.
  /// User types in major units (e.g., "50" or "20.50"),
  /// which gets converted to minor units internally.
  void _onAmountFieldChanged(String text) {
    // Strip any formatting characters (commas, spaces)
    final cleaned = text.replaceAll(',', '').replaceAll(' ', '').trim();
    if (cleaned.isEmpty) {
      setState(() => amount = '');
      return;
    }

    // Reject multiple decimal points (e.g., "10.5.3")
    if ('.'.allMatches(cleaned).length > 1) return;

    // Limit to 2 decimal places
    final dotIndex = cleaned.indexOf('.');
    if (dotIndex != -1 && cleaned.length - dotIndex - 1 > 2) return;

    final majorValue = double.tryParse(cleaned);
    if (majorValue == null || majorValue < 0) return;

    // Use integer arithmetic to avoid floating-point rounding errors:
    // Split on decimal and compute minor units from whole + fractional parts.
    final int minorUnits;
    if (dotIndex == -1) {
      // No decimal — whole number of major units
      final whole = int.tryParse(cleaned);
      if (whole == null) return;
      minorUnits = whole * 100;
    } else {
      final wholePart = int.tryParse(cleaned.substring(0, dotIndex)) ?? 0;
      final fracStr = cleaned.substring(dotIndex + 1).padRight(2, '0');
      final fracPart = int.tryParse(fracStr) ?? 0;
      minorUnits = wholePart * 100 + fracPart;
    }

    // Cap at 8 digits of minor units (99999999 = 999,999.99)
    if (minorUnits > 99999999) return;

    setState(() {
      amount = minorUnits.toString();
    });
  }

  void _setQuickAmount(int value) {
    // Dismiss keyboard if open
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      // Convert major unit value to minor unit string (e.g., 20 -> "2000")
      amount = '${value}00';
      // Update controller to show formatted value
      _amountController.text = _formatAmount();
      _amountController.selection = TextSelection.fromPosition(
        TextPosition(offset: _amountController.text.length),
      );
    });
  }

  /// Get currency symbol from currency code
  String _getCurrencySymbol(String? currencyCode) {
    switch (currencyCode?.toUpperCase()) {
      case 'NGN':
        return '₦';
      case 'GBP':
        return '£';
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'CAD':
        return 'C\$';
      case 'AUD':
        return 'A\$';
      default:
        return '₦'; // Default to Naira since signup is Nigeria-only
    }
  }

  /// Format amount WITHOUT currency symbol (symbol is shown separately)
  String _formatAmount() {
    if (amount.isEmpty) return '0.00';
    try {
      // Parse the minor unit string and convert to major units for formatting
      double value = double.parse(amount) / 100.0;
      // Format without symbol - just the number with 2 decimal places
      return NumberFormat('#,##0.00', 'en_US').format(value);
    } catch (e) {
      print("Error formatting amount: $e");
      return '0.00'; // Handle parsing error gracefully
    }
  }

  // --- UI Building Methods --- (Largely unchanged, minor fixes)

  // Updated to use AccountSummaryEntity from AccountCardsSummaryCubit state
  Widget _buildCardSelector(AccountCardsSummaryState accountState) {
    if (accountState is AccountCardsSummaryLoading ||
        accountState is AccountCardsSummaryInitial) {
      return const Center(
          child: LazerVaultLoader.small());
    }
    if (accountState is AccountCardsSummaryError) {
      return Center(
          child: Text('Error loading accounts: ${accountState.message}',
              style: const TextStyle(color: Colors.red)));
    }
    // Handle both AccountCardsSummaryLoaded and AccountBalanceUpdated states
    // AccountBalanceUpdated is emitted when WebSocket receives a balance update
    final summaries = switch (accountState) {
      AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
      AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
      _ => <AccountSummaryEntity>[],
    };

    if (summaries.isEmpty) {
      return const Center(
          child: Text('No payment methods available.',
              style: TextStyle(color: Colors.white70)));
    }
    // Ensure selectedCardIndex is valid
    if (selectedCardIndex >= summaries.length) {
      // Use post-frame callback to avoid setState during build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          // Check if the widget is still mounted
          setState(() => selectedCardIndex = 0);
        }
      });
      // Show a loading state temporarily while index resets
      return const Center(
          child: LazerVaultLoader.small());
    }

    // LOCK the source to the active dashboard account: on the first build with
    // accounts available, pre-select the account the user swiped into so the
    // whole flow (fromAccountId at the review step) uses it, and disable every
    // other card below.
    final activeId = _activeAccountId;
    if (!_didInitActiveSelection && activeId != null && activeId.isNotEmpty) {
      // Match on spendingAccountId so a Family & Friends card (whose id is the
      // group id, but whose active/spendable id is the shared VA) is found.
      // For non-family accounts spendingAccountId == id, so this is unchanged.
      final activeIdx = summaries.indexWhere(
          (a) => a.spendingAccountId == activeId || a.id == activeId);
      if (activeIdx >= 0 && activeIdx != selectedCardIndex) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) setState(() => selectedCardIndex = activeIdx);
        });
      }
      _didInitActiveSelection = true;
    }

    // Display order: the active (locked) account always sits FIRST in the
    // Pay-with row so the user doesn't have to scroll to find the wallet they
    // selected on the dashboard. We only reorder the VISUAL list here — the
    // underlying `summaries` order (and therefore selectedCardIndex, which every
    // downstream step reads) is left untouched, so we map display position back
    // to the original index.
    final displayOrder = <int>[];
    final activeOrigIdx = (activeId != null && activeId.isNotEmpty)
        ? summaries.indexWhere(
            (a) => a.spendingAccountId == activeId || a.id == activeId)
        : -1;
    if (activeOrigIdx > 0) {
      displayOrder.add(activeOrigIdx);
      for (var i = 0; i < summaries.length; i++) {
        if (i != activeOrigIdx) displayOrder.add(i);
      }
    } else {
      for (var i = 0; i < summaries.length; i++) {
        displayOrder.add(i);
      }
    }

    // Height-intrinsic horizontal scroller: each card sizes to its own content
    // so the balance line at the bottom is never clipped. The old
    // `SizedBox(height: 78.h)` forced every card to one fixed height that, on
    // shorter phones (where `.h` scales the box down but the inner text/icon
    // sizes stay fixed pixels), fell below the content height and truncated the
    // bottom row. A plain horizontal Row stays just as compact — the numbers
    // pad below still has room — while letting the card grow to fit.
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final index in displayOrder)
            Builder(builder: (context) {
          final account = summaries[index];
            final isSelected = selectedCardIndex == index;
            // Disabled = not the active dashboard account. You send from the
            // wallet you're in; switch accounts on the dashboard to change it.
            final isLocked = activeId != null &&
                activeId.isNotEmpty &&
                account.spendingAccountId != activeId &&
                account.id != activeId;
            // A frozen/suspended account can't be a transfer source — reflect
            // it and refuse selection (accounts-service would reject the debit).
            final isFrozen = account.isFrozen;

            // Determine account type display
            String accountTypeDisplay = 'Personal';
            Color accountTypeColor = Colors.blue;
            IconData accountIcon = Icons.account_balance_wallet;

            final accountTypeLower = account.accountType.toLowerCase();
            if (accountTypeLower.contains('saving')) {
              accountTypeDisplay = 'Savings';
              accountTypeColor = Colors.green;
              accountIcon = Icons.savings;
            } else if (accountTypeLower.contains('investment')) {
              accountTypeDisplay = 'Investment';
              accountTypeColor = Colors.orange;
              accountIcon = Icons.trending_up;
            } else if (accountTypeLower.contains('family')) {
              accountTypeDisplay = 'Family & Friends';
              accountTypeColor = const Color(0xFF7C6BF0);
              accountIcon = Icons.family_restroom;
            } else if (accountTypeLower.contains('business')) {
              accountTypeDisplay = 'Business';
              accountTypeColor = const Color(0xFFFB923C);
              accountIcon = Icons.business_center;
            } else if (accountTypeLower.contains('personal')) {
              accountTypeDisplay = 'Personal';
              accountTypeColor = Colors.blue;
              accountIcon = Icons.account_balance_wallet;
            }

            String last4 = account.accountNumberLast4;

            return GestureDetector(
              onTap: isFrozen
                  ? () => Get.snackbar(
                        'Account frozen',
                        'This account is frozen. Unfreeze it in Account settings to send money.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: const Color(0xFFEF4444),
                        colorText: Colors.white,
                        margin: EdgeInsets.all(12.w),
                        duration: const Duration(seconds: 3),
                      )
                  : isLocked
                      ? () => Get.snackbar(
                            'Locked to current account',
                            'Switch accounts on the dashboard to send from a different wallet.',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.black87,
                            colorText: Colors.white,
                            margin: EdgeInsets.all(12.w),
                            duration: const Duration(seconds: 2),
                          )
                      : () => setState(() => selectedCardIndex = index),
              child: Opacity(
                opacity: (isLocked || isFrozen) ? 0.4 : 1.0,
                child: Container(
                margin: EdgeInsets.only(right: 12.w),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                width: 160.w,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.15)
                      : Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected
                      ? Border.all(color: accountTypeColor.withValues(alpha: 0.5), width: 1.5)
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // Size to content (no fixed parent height anymore), so the
                  // balance line is always laid out fully instead of clipped.
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          accountIcon,
                          color: accountTypeColor,
                          size: 20,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: isFrozen
                                ? const Color(0xFFEF4444).withValues(alpha: 0.2)
                                : accountTypeColor.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            isFrozen ? 'Frozen' : accountTypeDisplay,
                            style: TextStyle(
                              color: isFrozen
                                  ? const Color(0xFFEF4444)
                                  : accountTypeColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '•••• $last4',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                    Text(
                      NumberFormat.currency(
                              symbol: _getCurrencySymbol(account.currency), decimalDigits: 2)
                          .format(account.availableBalance),
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              ),
            );
            }),
        ],
      ),
    );
  }

  /// Inline banner shown when the selected/active source account is frozen, so
  /// the block is visible in-flow (the card is dimmed + pre-selected, and the
  /// Send action is refused). Renders nothing when the source is usable.
  Widget _buildFrozenSourceBanner(AccountCardsSummaryState accountState) {
    final summaries = switch (accountState) {
      AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
      AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
      _ => <AccountSummaryEntity>[],
    };
    if (selectedCardIndex < 0 || selectedCardIndex >= summaries.length) {
      return const SizedBox.shrink();
    }
    if (!summaries[selectedCardIndex].isFrozen) return const SizedBox.shrink();
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEF4444).withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          const Icon(Icons.ac_unit, color: Color(0xFFEF4444), size: 18),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'This account is frozen. Unfreeze it in Account settings to send money.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAmounts(AccountCardsSummaryState accountState) {
    // Get currency symbol from selected account
    String currencySymbol = '₦'; // Default to Naira
    final summaries = switch (accountState) {
      AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
      AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
      _ => <AccountSummaryEntity>[],
    };

    if (summaries.isNotEmpty && selectedCardIndex < summaries.length) {
      currencySymbol = _getCurrencySymbol(summaries[selectedCardIndex].currency);
    }

    return SizedBox(
      height: 40.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: quickAmounts
            .map((amountValue) => GestureDetector(
                  onTap: () => _setQuickAmount(amountValue),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      '$currencySymbol$amountValue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  void _showCategoryPicker() async {
    final result = await CategorySelectionBottomSheet.show(
      context,
      serviceName: 'transfer',
      categories: _availableCategories,
      selectedCategory: selectedCategory,
    );
    if (result != null && mounted) {
      setState(() => selectedCategory = result);
    }
  }

  /// Chooser for everything time-based on a transfer: schedule THIS one,
  /// make THIS one recurring, or jump to the management screens (upcoming
  /// scheduled transfers / recurring rules). Each tile navigates or opens the
  /// existing flow — the date picker and RecurringTransferModal are unchanged.
  void _showScheduleOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetCtx) => SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 10.h),
            ListTile(
              leading: const Icon(Icons.schedule, color: Color(0xFF2962FF)),
              title: Text(
                  scheduledDate == null
                      ? 'Schedule this transfer'
                      : 'Change schedule (${DateFormat('MMM d, HH:mm').format(scheduledDate!)})',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              subtitle: Text('Pick a future date and time — it sends itself',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12.sp)),
              onTap: () {
                Navigator.of(sheetCtx).pop();
                _showSchedulePicker();
              },
            ),
            ListTile(
              leading: const Icon(Icons.repeat, color: Color(0xFF3B82F6)),
              title: Text('Make this transfer recurring',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              subtitle: Text(
                  _recurringConfig != null
                      ? _recurringConfig!.summary
                      : 'Repeat automatically — daily, weekly or monthly',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12.sp)),
              onTap: () {
                Navigator.of(sheetCtx).pop();
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => RecurringTransferModal(
                    initialConfig: _recurringConfig,
                    onConfigured: (config) {
                      if (!mounted) return;
                      setState(() {
                        _recurringConfig = config;
                        // Mutual exclusivity with one-off scheduling.
                        scheduledDate = null;
                      });
                    },
                  ),
                );
              },
            ),
            Divider(color: Colors.white.withValues(alpha: 0.08), height: 8.h),
            ListTile(
              leading: Icon(Icons.pending_actions_rounded,
                  color: Colors.white.withValues(alpha: 0.8)),
              title: Text('Scheduled transfers',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              subtitle: Text('View or cancel upcoming one-time transfers',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12.sp)),
              onTap: () {
                Navigator.of(sheetCtx).pop();
                Get.to(() => const ScheduledTransfersListScreen());
              },
            ),
            ListTile(
              leading: Icon(Icons.event_repeat_rounded,
                  color: Colors.white.withValues(alpha: 0.8)),
              title: Text('Recurring transfers',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              subtitle: Text('Manage your repeating transfers',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12.sp)),
              onTap: () {
                Navigator.of(sheetCtx).pop();
                Get.to(() => const RecurringTransfersListScreen());
              },
            ),
            SizedBox(height: 14.h),
          ],
        ),
      ),
    );
  }

  void _showSchedulePicker() async {
    final now = DateTime.now();
    final initialSelectableDate =
        now.hour >= 23 && now.minute >= 55 // Edge case: near midnight
            ? now.add(const Duration(days: 1))
            : now;
    final initialDateTime = initialSelectableDate
        .add(const Duration(days: 1)); // Default to tomorrow

    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: initialDateTime,
      firstDate: initialDateTime, // Can't schedule earlier than tomorrow
      lastDate: now.add(const Duration(days: 90)), // Limit scheduling range
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: const Color(0xFF2962FF).withValues(alpha: 0.8),
              onPrimary: Colors.white,
              surface: Colors.black,
              onSurface: Colors.white,
            ),
            dialogTheme: DialogThemeData(
                backgroundColor: Colors.black.withValues(alpha: 0.95)),
          ),
          child: child!,
        );
      },
    );

    if (date != null && context.mounted) {
      // Check context before async gap
      final initialTime =
          TimeOfDay.fromDateTime(now.add(const Duration(minutes: 5)));
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: initialTime,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.dark(
                primary: const Color(0xFF2962FF).withValues(alpha: 0.8),
                onPrimary: Colors.white,
                surface: Colors.black,
                onSurface: Colors.white,
              ),
              dialogTheme: DialogThemeData(
                  backgroundColor: Colors.black.withValues(alpha: 0.95)),
            ),
            child: child!,
          );
        },
      );

      if (time != null) {
        final potentialDateTime = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );

        // Ensure scheduled time is strictly in the future relative to now
        if (potentialDateTime.isAfter(DateTime.now())) {
          setState(() {
            scheduledDate = potentialDateTime;
            // Mutual exclusivity: clear recurring config when scheduling
            _isRecurringEnabled = false;
            _recurringConfig = null;
          });
        } else {
          Get.snackbar('Invalid Time', 'Scheduled time must be in the future.',
              snackPosition: SnackPosition.BOTTOM);
        }
      }
    }
  }

  // Updated to use AccountSummaryEntity from AccountCardsSummaryCubit state
  Future<void> _showTransferConfirmation(AccountCardsSummaryState accountState) async {
    // COMPREHENSIVE EDGE CASE VALIDATION

    // 1. Validate amount is not empty and parseable
    if (amount.isEmpty || int.tryParse(amount) == null) {
      Get.snackbar(
        'Invalid Amount',
        'Please enter a valid amount.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
      return;
    }

    // 2. Validate account data is loaded
    // AccountBalanceUpdated also contains the updated account summaries from WebSocket
    final summaries = switch (accountState) {
      AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
      AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
      _ => <AccountSummaryEntity>[],
    };

    if (summaries.isEmpty) {
      Get.snackbar(
        'Account Error',
        'Account data not loaded. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
      return;
    }

    // 3. Validate selected card index
    if (selectedCardIndex >= summaries.length) {
      Get.snackbar(
        'Invalid Card',
        'Please select a valid payment method.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
      return;
    }

    final selectedAccount = summaries[selectedCardIndex];

    // 3b. Frozen source guard — a frozen/suspended account cannot send money
    // (accounts-service rejects the debit). Reflect it here BEFORE the user
    // reaches the PIN step, with a clear, actionable message.
    if (selectedAccount.isFrozen) {
      Get.snackbar(
        'Account frozen',
        'This account is frozen, so you can\'t send money from it. '
            'Unfreeze it in Account settings to continue.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        margin: EdgeInsets.all(12.w),
        duration: const Duration(seconds: 5),
      );
      return;
    }

    // 3c. Un-provisioned family wallet guard — a family card whose pool virtual
    // account is still processing has an empty virtualAccountId, so
    // spendingAccountId falls back to the non-spendable group id and the debit
    // would fail server-side. Block BEFORE the PIN step with a clear message.
    if (selectedAccount.isFamilyWalletProvisioning) {
      Get.snackbar(
        'Wallet still being set up',
        'This family account\'s wallet is still being set up. '
            'Please try again in a few minutes.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFFB923C),
        colorText: Colors.white,
        margin: EdgeInsets.all(12.w),
        duration: const Duration(seconds: 5),
      );
      return;
    }

    double transferAmountMajor = double.parse(amount) / 100.0;

    // 4. Validate minimum transfer amount (e.g., 0.01)
    if (transferAmountMajor < 0.01) {
      Get.snackbar(
        'Amount Too Small',
        'Minimum transfer amount is ${_getCurrencySymbol(selectedAccount.currency)}0.01',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
      return;
    }

    // Get currency symbol from selected account (needed for error messages)
    final accountCurrency = selectedAccount.currency;
    final currencySymbol = _getCurrencySymbol(accountCurrency);

    // 5. Per-transaction + daily limits are enforced by the BACKEND per the
    //    user's KYC tier (Tier 1/2/3). Do NOT hardcode a client cap here — the
    //    old `maxTransferAmount = 10000` placeholder wrongly blocked every
    //    transfer over ₦10,000 regardless of tier or balance (a Tier-3 user
    //    with ₦600k could only send ₦10k). Balance is still validated below;
    //    the saga rejects an over-limit transfer with a clear daily-limit error
    //    the UI surfaces (transfer_error_bottomsheet).

    // 6. CRITICAL: Validate sufficient balance
    // Note: Backend uses AvailableBalance for the CanDebit check.
    // Use availableBalance getter which accounts for held funds.
    double availableBalance = selectedAccount.availableBalance;

    // For external transfers, estimate fee for pre-validation
    // The exact fee will be fetched later, but we use a cached/estimated fee here
    final bool isExternalTransfer = _recipient != null && _recipient!.bankName != 'LazerVault';
    final transferCubitState = context.read<TransferCubit>().state;
    double estimatedFee = 0.0;
    if (isExternalTransfer && transferCubitState is TransferFeeLoaded) {
      estimatedFee = transferCubitState.fee / 100.0;
    }

    final double totalRequired = transferAmountMajor + (isExternalTransfer ? estimatedFee : 0.0);

    if (totalRequired > availableBalance) {
      final String message;
      if (isExternalTransfer && estimatedFee > 0) {
        message = 'Insufficient balance. Amount ($currencySymbol${NumberFormat('#,###.00').format(transferAmountMajor)}) + Fee ($currencySymbol${NumberFormat('#,###.00').format(estimatedFee)}) = $currencySymbol${NumberFormat('#,###.00').format(totalRequired)} exceeds your balance of $currencySymbol${NumberFormat('#,###.00').format(availableBalance)}';
      } else {
        message = 'Your balance ($currencySymbol${NumberFormat('#,###.00').format(availableBalance)}) is insufficient for this transfer of $currencySymbol${NumberFormat('#,###.00').format(transferAmountMajor)}. Please top up your account or use a different account.';
      }
      Get.snackbar(
        'Insufficient Funds',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
      return;
    }

    // 7. Validate recipient exists and has required information
    if (_recipient == null ||
        _recipient!.name.trim().isEmpty ||
        _recipient!.accountNumber.trim().isEmpty) {
      Get.snackbar(
        'Invalid Recipient',
        'Recipient information is missing or invalid. Please go back and select a recipient.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
      return;
    }

    // Additional validation for external transfers
    if (_recipient!.bankName != 'LazerVault' &&
        (_recipient!.sortCode.trim().isEmpty || _recipient!.bankName.trim().isEmpty)) {
      Get.snackbar(
        'Invalid Recipient',
        'Bank details are incomplete. Please verify the recipient\'s bank information.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
      return;
    }

    // 8. Validate scheduled date is in future (if set)
    if (scheduledDate != null && !scheduledDate!.isAfter(DateTime.now())) {
      Get.snackbar(
        'Invalid Schedule',
        'Scheduled time must be in the future.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
      return;
    }

    // 9. Budget enforcement check
    _lastBudgetResult = null;
    if (selectedCategory != null) {
      final budgetCubit = context.read<BudgetCubit>();
      final budgetResult = await budgetCubit.validateCategoryBudget(
        budgetCategory: selectedCategory!.budgetCategory,
        amountMinor: int.parse(amount),
        currency: accountCurrency,
      );

      if (budgetResult != null) {
        _lastBudgetResult = budgetResult;

        // STRICT mode: blocked — show override dialog
        if (budgetResult.shouldBlockTransaction) {
          if (!mounted) return;
          final budgetName = budgetResult.matchingBudgets.isNotEmpty
              ? budgetResult.matchingBudgets.first.budgetName
              : selectedCategory!.displayName;
          final budgetId = budgetResult.matchingBudgets.isNotEmpty
              ? budgetResult.matchingBudgets.first.budgetId
              : '';

          final action = await BudgetOverrideDialog.show(
            context,
            budgetName: budgetName,
            currentSpent: budgetResult.currentSpent,
            budgetLimit: budgetResult.budgetLimit,
            transactionAmount: transferAmountMajor,
            percentageUsed: budgetResult.percentageUsed,
            currency: accountCurrency,
            budgetId: budgetId,
          );

          if (action == null || action == BudgetOverrideAction.cancel) {
            return; // User cancelled
          }

          if (action == BudgetOverrideAction.increaseBudget && budgetId.isNotEmpty) {
            // Calculate suggested increase (amount that would cover the transaction)
            final overage = budgetResult.currentSpent + transferAmountMajor - budgetResult.budgetLimit;
            final increaseAmount = overage > 0 ? overage * 1.2 : transferAmountMajor; // 20% buffer
            final newLimit = budgetResult.budgetLimit + increaseAmount;
            await budgetCubit.updateBudget(
              budgetId: budgetId,
              amount: newLimit,
            );
            // Re-validate after increase
            final retryResult = await budgetCubit.validateCategoryBudget(
              budgetCategory: selectedCategory!.budgetCategory,
              amountMinor: int.parse(amount),
              currency: accountCurrency,
            );
            _lastBudgetResult = retryResult;
            if (retryResult != null && retryResult.shouldBlockTransaction) {
              if (!mounted) return;
              Get.snackbar(
                'Still Exceeds Budget',
                'The increased budget is still not enough.',
                backgroundColor: const Color(0xFFEF4444),
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );
              return;
            }
          }
          // BudgetOverrideAction.overrideOnce — proceed with transaction
        } else if (budgetResult.shouldShowWarning) {
          // FLEXIBLE mode (or near-limit): non-blocking warning. The budget
          // promised "allows transactions with a warning" — honour that here
          // so the user makes an informed choice before money moves.
          if (!mounted) return;
          final proceed = await showBudgetWarningSheet(
            context,
            result: budgetResult,
            transactionAmount: transferAmountMajor,
            currency: accountCurrency,
          );
          if (proceed != true) return; // user cancelled
        }
      }
    }

    // Determine transfer type based on recipient
    final bool isInternalTransfer = _recipient!.bankName == 'LazerVault';
    final String transferType = isInternalTransfer ? 'internal' : 'domestic';

    // Get source card details
    String sourceCardType = selectedAccount.accountType;
    String sourceLast4 = selectedAccount.accountNumberLast4;
    String sourceAccountInfo = '$sourceCardType •••• $sourceLast4';

    // Fetch real transfer fee before showing dialog
    final transferCubit = context.read<TransferCubit>();
    transferCubit.getTransferFee(
      amountMinorUnits: int.parse(amount),
      currency: accountCurrency,
      transferType: transferType,
      destinationBankCode: _recipient!.sortCode,
    );

    // Informational, READ-ONLY transfer success prediction (non-blocking).
    // Only for EXTERNAL transfers; internal LazerVault transfers stay neutral.
    if (isExternalTransfer) {
      _predictionCubit.fetch(
        bankCode: _recipient!.sortCode,
        accountNumber: _recipient!.accountNumber,
      );
    } else {
      _predictionCubit.reset();
    }

    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.85),
      builder: (dialogContext) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: transferCubit),
          BlocProvider<TransferPredictionCubit>.value(value: _predictionCubit),
        ],
        child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(dialogContext).size.height * 0.78,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.6),
                  blurRadius: 24,
                  spreadRadius: 3,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Column(
                    children: [
                      Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withValues(alpha: 0.2),
                              Colors.white.withValues(alpha: 0.05),
                            ],
                          ),
                          border:
                              Border.all(color: Colors.white.withValues(alpha: 0.2)),
                        ),
                        child: const Icon(Icons.send_rounded,
                            color: Colors.white, size: 22),
                      ),
                      SizedBox(height: 10.h),
                      const Text(
                        'Transfer Confirmation',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                          child: Column(
                            children: [
                              _buildConfirmationRow(
                                'From',
                                sourceAccountInfo, // Use fetched data
                                '',
                              ),
                              _buildConfirmationRow(
                                'To',
                                _recipient!.name,
                                // Empty for internal user recipients (no real
                                // account number → don't mask the user-id UUID).
                                _recipient!.maskedAccount,
                              ),
                              if (selectedCategory != null)
                                _buildConfirmationRow(
                                  'Category',
                                  selectedCategory!.displayName,
                                  '',
                                ),
                              _buildConfirmationRow(
                                'Amount',
                                '',
                                NumberFormat.currency(
                                        symbol: currencySymbol, decimalDigits: 2)
                                    .format(transferAmountMajor),
                              ),
                              // Fee row - uses BlocConsumer to show real fee
                              BlocConsumer<TransferCubit, TransferState>(
                                listener: (context, feeState) {
                                  // Check if amount + fee exceeds balance for external transfers
                                  if (feeState is TransferFeeLoaded && isExternalTransfer) {
                                    final feeMajor = feeState.fee / 100.0;
                                    final totalRequired = transferAmountMajor + feeMajor;
                                    if (totalRequired > availableBalance) {
                                      Get.snackbar(
                                        'Insufficient Funds',
                                        'Amount ($currencySymbol${NumberFormat('#,###.00').format(transferAmountMajor)}) + Fee ($currencySymbol${NumberFormat('#,###.00').format(feeMajor)}) = $currencySymbol${NumberFormat('#,###.00').format(totalRequired)} exceeds your balance of $currencySymbol${NumberFormat('#,###.00').format(availableBalance)}',
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.red.withValues(alpha: 0.7),
                                        colorText: Colors.white,
                                        duration: const Duration(seconds: 5),
                                      );
                                    }
                                  }
                                },
                                builder: (context, feeState) {
                                  if (feeState is TransferFeeLoading) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(vertical: 4.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Transfer Fee',
                                              style: TextStyle(color: Colors.white70, fontSize: 12.sp)),
                                          LazerVaultLoader.tiny(),
                                        ],
                                      ),
                                    );
                                  }
                                  final int feeMinor;
                                  final int totalMinor;
                                  if (feeState is TransferFeeLoaded) {
                                    feeMinor = feeState.fee;
                                    totalMinor = feeState.totalAmount;
                                  } else {
                                    // Fallback: 0 fee
                                    feeMinor = 0;
                                    totalMinor = int.tryParse(amount) ?? 0;
                                  }
                                  final feeMajor = feeMinor / 100.0;
                                  final totalMajor = totalMinor / 100.0;
                                  final bool isFree = feeMinor == 0;
                                  return Column(
                                    children: [
                                      _buildConfirmationRow(
                                        'Transfer Fee',
                                        '',
                                        isFree
                                            ? 'Free'
                                            : NumberFormat.currency(
                                                    symbol: currencySymbol, decimalDigits: 2)
                                                .format(feeMajor),
                                      ),
                                      _buildConfirmationRow(
                                        'Total',
                                        '',
                                        NumberFormat.currency(
                                                symbol: currencySymbol, decimalDigits: 2)
                                            .format(totalMajor),
                                        isTotal: true,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        // Informational, READ-ONLY transfer success prediction
                        // (bank network + recipient trust). Shown AFTER the
                        // recipient/amount/fee rows and BEFORE the PIN/Send
                        // action. EXTERNAL transfers only; never blocks money.
                        if (isExternalTransfer)
                          const TransferPredictionAlert(),
                        // Budget warning (flexible mode exceeded or near limit)
                        if (_lastBudgetResult != null && _lastBudgetResult!.shouldShowWarning)
                          Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: CompactBudgetWarning(
                              percentageUsed: _lastBudgetResult!.percentageUsed,
                              status: _lastBudgetResult!.status,
                              validationResult: _lastBudgetResult,
                            ),
                          ),
                        if (scheduledDate != null)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2962FF).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.schedule,
                                    color: Color(0xFF2962FF),
                                    size: 20,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'Scheduled for ${DateFormat('MMM d, HH:mm').format(scheduledDate!)}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        // Recurring payment toggle
                        if (scheduledDate == null)
                          StatefulBuilder(
                            builder: (context, setRecurringState) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.h),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.05),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.repeat,
                                        color: _isRecurringEnabled
                                            ? const Color(0xFF3B82F6)
                                            : const Color(0xFF9CA3AF),
                                        size: 20.sp,
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Make Recurring',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            if (_isRecurringEnabled && _recurringConfig != null)
                                              Text(
                                                _recurringConfig!.summary,
                                                style: TextStyle(
                                                  color: const Color(0xFF3B82F6),
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Switch(
                                        value: _isRecurringEnabled,
                                        activeColor: const Color(0xFF3B82F6),
                                        onChanged: (value) {
                                          if (value) {
                                            showModalBottomSheet(
                                              context: dialogContext,
                                              isScrollControlled: true,
                                              backgroundColor: Colors.transparent,
                                              builder: (_) => RecurringTransferModal(
                                                initialConfig: _recurringConfig,
                                                onConfigured: (config) {
                                                  setRecurringState(() {
                                                    _isRecurringEnabled = true;
                                                    _recurringConfig = config;
                                                  });
                                                },
                                              ),
                                            );
                                          } else {
                                            setRecurringState(() {
                                              _isRecurringEnabled = false;
                                              _recurringConfig = null;
                                            });
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        // Save Recipient is handled in the user confirmation bottom sheet
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
                  child: Column(
                    children: [
                      // Use StatefulBuilder to manage the button loading state locally
                      StatefulBuilder(
                        builder:
                            (BuildContext dialogCtx, StateSetter setDialogState) {
                          bool isDialogLoading =
                              _isConfirmingTransfer; // Use the main state or a local one if preferred

                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isDialogLoading
                                  ? null
                                  : () async {
                                      // Guard against double-tap: disable button immediately
                                      if (_isConfirmingTransfer) return;
                                      setState(() {
                                        _isConfirmingTransfer = true;
                                      });

                                      print("Dialog Button: Pressed!");
                                      // Generate unique transaction ID
                                      final transactionId = 'transfer_${const Uuid().v4()}';

                                      // Calculate amounts for PIN validation
                                      double transferAmountMajor = double.parse(amount) / 100.0;

                                      // Close the confirmation dialog before showing PIN modal
                                      // to avoid using the dialog's deactivated context
                                      Navigator.of(dialogCtx).pop();

                                      if (!mounted) return;

                                      // Validate PIN using the widget's context (not the dialog's)
                                      final summaries = switch (accountState) {
                                        AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
                                        AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
                                        _ => <AccountSummaryEntity>[],
                                      };
                                      final accountCurrency = summaries.isNotEmpty && selectedCardIndex < summaries.length
                                          ? summaries[selectedCardIndex].currency
                                          : 'NGN';

                                      if (FeatureFlags.sendFundsPinIsRequired) {
                                        AnalyticsService.instance.trackSendFundsScreen('pin', 'long');
                                        // Revalidate the fee against the CONFIRMED amount before
                                        // showing it on the PIN sheet. The quote fired when the
                                        // dialog opened is fire-and-forget, so it may be in-flight
                                        // or errored here; fees are amount-dependent, so we reuse
                                        // the cache only when it matches this amount+type and
                                        // otherwise re-quote. Internal transfers resolve to free.
                                        final bool longIsInternal =
                                            _recipient!.bankName == 'LazerVault';
                                        final longFeeQuote = await context
                                            .read<TransferCubit>()
                                            .ensureFeeForAmount(
                                              amountMinorUnits: int.parse(amount),
                                              currency: accountCurrency,
                                              transferType:
                                                  longIsInternal ? 'internal' : 'domestic',
                                              destinationBankCode: longIsInternal
                                                  ? null
                                                  : _recipient!.sortCode,
                                            );
                                        if (!mounted) return;
                                        final longFeeMajor = (longFeeQuote?.fee ?? 0) / 100.0;
                                        final pinSuccess = await validateTransactionPin(
                                          context: context,
                                          transactionId: transactionId,
                                          transactionType: 'transfer',
                                          amount: transferAmountMajor,
                                          currency: accountCurrency,
                                          fee: longFeeMajor > 0 ? longFeeMajor : null,
                                          title: 'Confirm Transfer',
                                          message: 'Confirm transfer of $accountCurrency ${transferAmountMajor.toStringAsFixed(2)}',
                                          // Outcome confirmed on the receipt (external transfers
                                          // return `pending`), so don't claim success here.
                                          successMessage: 'Transfer Initiated',
                                          onPinValidated: (verificationToken) async {
                                            // Execute transfer inside callback — PIN modal stays open
                                            // showing processing phase while backend works
                                            await _executeTransferWithPin(
                                              accountState: accountState,
                                              transactionId: transactionId,
                                              verificationToken: verificationToken,
                                            );

                                            // Wait for TransferSuccess state from cubit
                                            final transferCubit = context.read<TransferCubit>();
                                            await transferCubit.stream.firstWhere(
                                              (s) => s is TransferSuccess || s is TransferFailure || s is TransferPinFailure,
                                            ).timeout(
                                              const Duration(seconds: 30),
                                              onTimeout: () => transferCubit.state,
                                            );

                                            // If transfer failed, throw to show error in PIN modal
                                            final finalState = transferCubit.state;
                                            if (finalState is TransferFailure) {
                                              throw Exception(finalState.message);
                                            } else if (finalState is TransferPinFailure) {
                                              throw Exception('Invalid PIN');
                                            }
                                            // TransferSuccess — mixin will show success, then dismiss
                                          },
                                        );

                                        if (!pinSuccess) {
                                          if (mounted) {
                                            setState(() {
                                              _isConfirmingTransfer = false;
                                            });
                                          }
                                          return;
                                        }
                                      } else {
                                        // Transaction PIN disabled by admin
                                        // (send_funds_pin_required=false). Execute the
                                        // transfer directly with an empty token — the
                                        // backend independently enforces the same setting
                                        // and skips token validation; all other
                                        // money-safety (holds, idempotency, limits) still
                                        // applies.
                                        try {
                                          await _executeTransferWithPin(
                                            accountState: accountState,
                                            transactionId: transactionId,
                                            verificationToken: '',
                                          );
                                          final transferCubit = context.read<TransferCubit>();
                                          await transferCubit.stream.firstWhere(
                                            (s) => s is TransferSuccess || s is TransferFailure || s is TransferPinFailure,
                                          ).timeout(
                                            const Duration(seconds: 30),
                                            onTimeout: () => transferCubit.state,
                                          );
                                          final finalState = transferCubit.state;
                                          if (finalState is TransferFailure) {
                                            throw Exception(finalState.message);
                                          } else if (finalState is TransferPinFailure) {
                                            throw Exception('Transfer could not be completed');
                                          }
                                        } catch (e) {
                                          if (mounted) {
                                            setState(() {
                                              _isConfirmingTransfer = false;
                                            });
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text(e
                                                    .toString()
                                                    .replaceAll('Exception:', '')
                                                    .trim()),
                                              ),
                                            );
                                          }
                                          return;
                                        }
                                      }

                                      // Transfer completed and PIN modal dismissed — navigate to receipt
                                      if (_lastTransferDetails != null && mounted) {
                                        Get.offAllNamed(AppRoutes.transferProof,
                                            arguments: _lastTransferDetails);
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(0xFF2962FF).withValues(alpha: 0.9),
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                disabledBackgroundColor:
                                    Colors.grey.withValues(alpha: 0.5),
                                elevation: 8,
                              ),
                              child: isDialogLoading
                                  ? LazerVaultLoader.small()
                                  : Text(
                                      _isRecurringEnabled
                                          ? 'Set Up Recurring'
                                          : scheduledDate != null
                                              ? 'Schedule Transfer'
                                              : 'Send Now',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 12.h),
                      TextButton(
                        // Disable cancel button while confirming? Yes, currently disabled.
                        onPressed: _isConfirmingTransfer
                            ? null // Button is disabled if _isConfirmingTransfer is true
                            : () {
                                setState(() {
                                  _isConfirmingTransfer = false;
                                });
                                print("TextButton: Pressed!");
                                Navigator.pop(dialogContext);
                              }, // Closes the dialog if not confirming
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: _isConfirmingTransfer
                                ? Colors.grey // Greyed out when disabled
                                : Colors.white70,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
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

  // --- Cubit Interaction ---

  /// Execute transfer with verification token (for PIN-validated transactions)
  Future<void> _executeTransferWithPin({
    required AccountCardsSummaryState accountState,
    required String transactionId,
    required String verificationToken,
  }) async {
    print("_executeTransferWithPin: Entered function.");
    if (!mounted) {
      print("_executeTransferWithPin: Widget unmounted, aborting.");
      return;
    }
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      print("_executeTransferWithPin: Error - Not authenticated.");
      throw Exception('Authentication required.');
    }

    // Validate selected card and get source account ID from cubit state
    // AccountBalanceUpdated also contains the updated account summaries from WebSocket
    final summaries = switch (accountState) {
      AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
      AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
      _ => <AccountSummaryEntity>[],
    };

    if (summaries.isEmpty) {
      print("_executeTransferWithPin: Error - Account data not loaded.");
      throw Exception('Account data not available.');
    }
    if (selectedCardIndex >= summaries.length) {
      print("_executeTransferWithPin: Error - Invalid card index.");
      throw Exception('Invalid card selected.');
    }
    final selectedAccount = summaries[selectedCardIndex];
    // Source from spendingAccountId, not id: for a Family & Friends card the
    // card id is the family GROUP id while the real money lives in the shared
    // virtual account (spendingAccountId). For every other account type
    // spendingAccountId == id, so this is a no-op there.
    final fromAccountId = selectedAccount.spendingAccountId;

    // Parse amount string (minor units) and convert to major units for API
    int amountMinorUnits;
    try {
      if (amount.isEmpty) throw const FormatException('Amount is empty');
      amountMinorUnits = int.parse(amount);
      if (amountMinorUnits <= 0) {
        throw Exception('Amount must be greater than zero.');
      }
    } catch (e) {
      if (e is Exception && e.toString().contains('Amount must be greater than zero')) {
        rethrow;
      }
      throw Exception('Invalid amount entered.');
    }

    // Convert minor units to major units for SendFundsRequest (e.g., 10050 -> 100.50)
    double amountMajor = amountMinorUnits / 100.0;

    final userNarration = _referenceController.text.trim();
    // Build narration with category prefix for statistics subcategory tracking.
    // The accounts-service SQL subCategoryExpr matches "CategoryName:" prefix patterns.
    // Default fallback stamps the SENDER's full name onto the narration so the
    // receiver's transaction history / receipt shows "Transfer from {Name}"
    // instead of the vague "Transfer from LazerVault".
    final senderProfile = context.read<AuthenticationCubit>().currentProfile;
    final String senderFullName = senderProfile != null
        ? '${senderProfile.user.firstName} ${senderProfile.user.lastName}'.trim()
        : '';
    final String defaultNarration = senderFullName.isNotEmpty
        ? 'Transfer from $senderFullName'
        : 'Transfer from Lazervault';

    // Shared with the short flow (ServiceCategory.buildTransferNarration) so both
    // flows stamp the category prefix identically for subcategory analytics.
    final String narration = ServiceCategory.buildTransferNarration(
      category: selectedCategory,
      note: userNarration,
      defaultNarration: defaultNarration,
    );

    // Re-validate scheduled date hasn't become stale while user was in PIN flow
    if (scheduledDate != null && !scheduledDate!.isAfter(DateTime.now())) {
      throw Exception('Scheduled time has passed. Please select a new time.');
    }

    // Get recipient account number
    // For internal transfers: use accountNumber which contains LazerVault account number
    // For external transfers: use accountNumber which is the external bank account number
    final toAccountNumber = _recipient!.accountNumber;

    // Execute the immediate transfer first
    if (!mounted) {
      print("_executeTransferWithPin: Widget unmounted before transfer, aborting.");
      return;
    }
    print("_executeTransferWithPin: Calling TransferCubit.sendFunds...");
    print("_executeTransferWithPin: fromAccountId=$fromAccountId, toAccountNumber=$toAccountNumber, amount=$amountMajor");
    final transferType = (_recipient!.type == 'internal' || _recipient!.bankName.toLowerCase() == 'lazervault')
        ? 'internal'
        : 'external';
    context.read<TransferCubit>().sendFunds(
      fromAccountId: fromAccountId,
      toAccountNumber: toAccountNumber,
      toAccountId: transferType == 'internal'
          ? (_recipient!.internalUserId ?? toAccountNumber)
          : null,
      type: transferType,
      amount: amountMajor,
      description: narration,
      transactionId: transactionId,
      verificationToken: verificationToken,
      destinationBankCode: transferType == 'external' ? _recipient!.sortCode : null,
      beneficiaryName: transferType == 'external' ? _recipient!.name : null,
      scheduledAt: scheduledDate,
      expenseCategory: selectedCategory?.budgetCategory,
      flow: 'long',
    );
    print("_executeTransferWithPin: Transfer initiated.");

    // If recurring is enabled, store params for deferred setup after transfer succeeds
    // This prevents creating a recurring rule when the initial transfer fails
    if (_isRecurringEnabled && _recurringConfig != null) {
      _pendingRecurringTransactionId = transactionId;
      _pendingRecurringVerificationToken = verificationToken;
      _recurringSetupPending = true;
      _transferSucceeded = false;
      _pendingTransferSuccess = null;
      _recurringSetupInitiated = false;
      _createdRecurringTransferId = null;
      _recurringRetryCount = 0;
      print("_executeTransferWithPin: Recurring setup deferred until transfer succeeds.");
    }
  }

  /// Navigate to receipt screen after transfer success.
  /// Called immediately if no recurring setup, or deferred until recurring resolves.
  void _navigateToReceipt(BuildContext context, TransferSuccess transferState) {
    if (!mounted || _hasNavigatedToReceipt) return;
    _hasNavigatedToReceipt = true;

    final accountState = context.read<AccountCardsSummaryCubit>().state;
    final summaries = switch (accountState) {
      AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
      AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
      _ => <AccountSummaryEntity>[],
    };

    double transferAmount = 0.0;
    try {
      transferAmount = transferState.response.amount.toDouble() / 100.0;
    } catch (_) {}
    double transferFee = transferState.response.fee.toDouble() / 100.0;
    double totalAmount = transferState.response.totalAmount.toDouble() / 100.0;
    if (transferFee == 0.0) {
      final lastFeeState = context.read<TransferCubit>().lastFeeLoaded;
      if (lastFeeState != null) {
        transferFee = lastFeeState.fee / 100.0;
      }
    }
    if (totalAmount == 0 && transferAmount > 0) {
      totalAmount = transferAmount + transferFee;
    }

    String sourceAccountInfo = 'Unknown Card';
    String senderCurrency = 'NGN';
    // From-name on the receipt = the sender's REAL name (not the account-type
    // label like "personal").
    final senderProfile = context.read<AuthenticationCubit>().currentProfile;
    String sourceAccountName = senderProfile != null
        ? '${senderProfile.user.firstName} ${senderProfile.user.lastName}'.trim()
        : '';
    if (summaries.isNotEmpty && selectedCardIndex < summaries.length) {
      final selectedAccount = summaries[selectedCardIndex];
      sourceAccountInfo = '${selectedAccount.accountType} •••• ${selectedAccount.accountNumberLast4}';
      senderCurrency = selectedAccount.currency;
      if (sourceAccountName.isEmpty) {
        sourceAccountName = selectedAccount.accountName ?? '';
      }
    }

    // Empty for internal user recipients (no real account number) → the receipt
    // hides the Account row instead of masking the user-id UUID.
    String recipientAccountMasked = _recipient!.maskedAccount;

    final transferDetails = {
      'amount': transferAmount,
      'fee': transferFee,
      'totalAmount': totalAmount,
      'recipientName': _recipient!.name,
      'recipientAccountMasked': recipientAccountMasked,
      'recipientBankName': _recipient!.displayBankName,
      'recipientBankCode': _recipient!.sortCode,
      'sourceAccountInfo': sourceAccountInfo,
      'sourceAccountName': sourceAccountName,
      'currency': senderCurrency,
      'transferId': transferState.response.transferId.toString(),
      'timestamp': transferState.response.createdAt,
      'category': selectedCategory?.displayName,
      // Carry the send-funds flow (long|short) so the processing & receipt
      // screens emit real telemetry instead of 'unknown'.
      'flow': AnalyticsService.instance.currentSendFlow,
      'reference': _referenceController.text.trim().isNotEmpty
          ? _referenceController.text.trim()
          : null,
      'providerReference': transferState.response.providerReference,
      'internalReference': transferState.response.internalReference,
      'status': transferState.response.status,
      'network': _recipient!.bankName == 'LazerVault'
          ? 'Lazervault Internal Transfer'
          : 'External Bank Transfer',
      'transferType': _recipient!.bankName == 'LazerVault'
          ? 'Internal Transfer'
          : 'Domestic Transfer',
      if (scheduledDate != null) 'scheduledAt': scheduledDate,
      // Recurring payment context for receipt display
      if (_isRecurringEnabled && _recurringConfig != null) ...{
        'isRecurring': true,
        'recurringFrequency': _recurringConfig!.frequency.name,
        'recurringSchedule': _recurringConfig!.summary,
        if (_createdRecurringTransferId != null)
          'recurringTransferId': _createdRecurringTransferId,
      },
    };

    // Reset transfer cubit state to prevent stale success from re-firing
    // listeners when this screen is revisited
    context.read<TransferCubit>().resetState();

    // Internal (Lazervault→Lazervault) send: hand the completed transfer to the
    // P2P chat with this user so the money bubble renders the moment they open
    // the chat (the receipt wipes the stack, so the chat can't reload on return).
    final peerId = _recipient!.internalUserId?.trim().isNotEmpty == true
        ? _recipient!.internalUserId!.trim()
        : (_recipient!.type == 'internal' ? _recipient!.id : '');
    if (peerId.isNotEmpty) {
      PendingChatTransfers.instance.record(
        peerUserId: peerId,
        amountMinor: transferState.response.amount.toInt(),
        currency: senderCurrency,
        reference: transferState.response.internalReference,
        note: transferDetails['reference'] as String?,
        // Carry the real status so a scheduled (not-yet-fired) send renders the
        // chat bubble as "Money Scheduled" instead of "Money Sent".
        status: transferState.response.status,
        scheduledAt: scheduledDate,
      );
    }

    // Navigate directly to receipt
    Get.offAllNamed(AppRoutes.transferProof, arguments: transferDetails);
  }

  /// Non-blocking: ensure a P2P financial connection exists for internal recipients.
  /// Fire-and-forget — never blocks the transfer flow.
  void _ensureFinancialConnection({
    required String otherUserId,
    required String otherUserName,
    String? myName,
  }) {
    Future(() async {
      try {
        final repo = serviceLocator<P2PChatRepository>();
        await repo.getOrCreateConversation(
          otherUserId,
          otherUserName: otherUserName,
          myName: myName,
        );
        debugPrint('[P2P] Financial connection ensured for $otherUserName');
      } catch (e) {
        debugPrint('[P2P] Non-blocking connection creation failed: $e');
      }
    });
  }

  /// Fire deferred recurring setup. Extracted to allow retry on failure.
  void _fireRecurringSetup(BuildContext context) {
    if (_recurringConfig == null || _pendingRecurringTransactionId == null) {
      print("_fireRecurringSetup: Missing config or transaction ID, skipping.");
      return;
    }

    final accountState = context.read<AccountCardsSummaryCubit>().state;
    final recurringSummaries = switch (accountState) {
      AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
      AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
      _ => <AccountSummaryEntity>[],
    };

    if (recurringSummaries.isEmpty || selectedCardIndex >= recurringSummaries.length) {
      print("_fireRecurringSetup: No valid account data, skipping.");
      _recurringSetupPending = false;
      return;
    }

    final recurringAccount = recurringSummaries[selectedCardIndex];
    final recurringAmountMajor = int.tryParse(amount) != null ? int.parse(amount) / 100.0 : 0.0;
    final recurringReference = _referenceController.text.trim();
    // Same builder as the immediate send: stamps the analytics-label prefix (NOT
    // displayName) so the recurring rule's executions are attributed to the right
    // subcategory when the worker fires them.
    final recurringNarration = ServiceCategory.buildTransferNarration(
      category: selectedCategory,
      note: recurringReference,
      defaultNarration: 'Transfer',
    );

    _recurringSetupPending = true;
    _recurringSetupInitiated = true;

    context.read<RecurringTransferCubit>().createRecurringTransfer(
      fromAccountId: recurringAccount.id,
      toAccountNumber: _recipient!.accountNumber,
      recipientName: _recipient!.name,
      recipientBankCode: _recipient!.sortCode,
      recipientBankName: _recipient!.bankName,
      amount: recurringAmountMajor,
      description: recurringNarration,
      frequency: _recurringConfig!.frequency,
      scheduleDay: _recurringConfig!.scheduleDay,
      scheduleTime: _recurringConfig!.scheduleTimeString,
      endDate: _recurringConfig!.endDate?.toIso8601String(),
      transactionId: _pendingRecurringTransactionId!,
      verificationToken: _pendingRecurringVerificationToken!,
    );
    print("_fireRecurringSetup: Recurring transfer setup initiated (attempt ${_recurringRetryCount + 1}).");
  }

  /// Show retry dialog when recurring setup fails but transfer succeeded.
  void _showRecurringRetryDialog(BuildContext context, String errorMessage) {
    if (!mounted) {
      // Widget disposed — navigate via Get which works globally
      if (_pendingTransferSuccess != null) {
        _navigateToReceipt(context, _pendingTransferSuccess!);
      }
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        icon: Icon(Icons.warning_amber_rounded, color: const Color(0xFFFB923C), size: 48.sp),
        title: Text(
          'Recurring Setup Failed',
          style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600),
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
                style: TextStyle(color: const Color(0xFFEF4444), fontSize: 12.sp),
              ),
            ),
            if (_recurringRetryCount >= _maxRecurringRetries)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  'You can set up recurring payments later from the transfer history.',
                  style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp, fontStyle: FontStyle.italic),
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              if (_pendingTransferSuccess != null) {
                _navigateToReceipt(context, _pendingTransferSuccess!);
              }
            },
            child: Text(
              'Continue Without Recurring',
              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
            ),
          ),
          if (_recurringRetryCount < _maxRecurringRetries)
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _recurringRetryCount++;
                _recurringSetupInitiated = false;
                _fireRecurringSetup(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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

  /// Reset all recurring-related state. Called on failure, cancellation, and cleanup.
  void _resetRecurringState() {
    _recurringSetupPending = false;
    _transferSucceeded = false;
    _hasNavigatedToReceipt = false;
    _pendingTransferSuccess = null;
    _pendingRecurringTransactionId = null;
    _pendingRecurringVerificationToken = null;
    _recurringSetupInitiated = false;
    _createdRecurringTransferId = null;
    _recurringRetryCount = 0;
  }

  // Confirmation Row Helper (Minor Adjustments)
  Widget _buildConfirmationRow(String label, String name, String detail,
      {bool isTotal = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            if (name.isNotEmpty)
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTotal ? 15.sp : 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            if (name.isNotEmpty && detail.isNotEmpty)
              SizedBox(width: 8.w),
            if (detail.isNotEmpty)
              Expanded(
                flex:
                    name.isNotEmpty ? 1 : 2,
                child: Text(
                  detail,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTotal ? 15.sp : 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
          ],
        ),
        if (!isTotal)
          Divider(
            color: Colors.white.withValues(alpha: 0.1),
            height: 16.h,
            thickness: 1,
          ),
      ],
    );
  }

  @override
  void dispose() {
    _referenceController.dispose();
    _amountController.dispose();
    // Clean up recurring state — backend operations may still complete
    // but BlocListener is gone. Get.snackbar works without mounted context.
    if (_recurringSetupPending) {
      print("dispose: Recurring setup still pending — backend will complete independently.");
    }
    _resetRecurringState();
    _predictionCubit.close();
    // Release the flow-pin freeze taken in initState.
    FeatureFlags.endSendFlow();
    super.dispose();
  }

  // --- Main Build Method ---

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecurringTransferCubit, RecurringTransferState>(
      listener: (context, recurringState) {
        if (recurringState is RecurringTransferCreated) {
          _recurringSetupPending = false;
          _recurringSetupInitiated = false;
          _createdRecurringTransferId = recurringState.transfer.id;
          Get.snackbar('Recurring Payment Set', recurringState.message,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
              duration: const Duration(seconds: 4));
          // If transfer already succeeded and was waiting for recurring, navigate now
          if (_transferSucceeded && _pendingTransferSuccess != null) {
            _navigateToReceipt(context, _pendingTransferSuccess!);
          }
        } else if (recurringState is RecurringTransferError) {
          _recurringSetupPending = false;
          _recurringSetupInitiated = false;
          // Transfer succeeded but recurring failed — show retry dialog instead of navigating
          if (_transferSucceeded && _pendingTransferSuccess != null) {
            _showRecurringRetryDialog(context, recurringState.message);
          } else {
            // Transfer hasn't resolved yet — just show a snackbar
            Get.snackbar('Recurring Payment Failed', recurringState.message,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color(0xFFEF4444),
                colorText: Colors.white,
                duration: const Duration(seconds: 5));
          }
        }
      },
      child: BlocConsumer<TransferCubit, TransferState>(
      // Only fire listener on actual state transitions (prevents re-firing on rebuild)
      listenWhen: (previous, current) => previous != current,
      listener: (context, transferState) {
        // Access AccountCardsSummaryCubit state inside the listener
        // AccountCardsSummaryCubit is still provided higher up (likely main.dart or AppRouter itself)
        // or needs to be accessed differently if not.
        // Let's assume it's available via context.read for now.
        final accountState = context.read<AccountCardsSummaryCubit>().state;
        print("Listener: TransferState: $transferState");
        if (transferState is TransferSuccess) {
          print(
              'Listener: Transfer Success received. State: $transferState');
          if (_isConfirmingTransfer) {
            setState(() {
              _isConfirmingTransfer = false;
            });
          }

          // PIN modal handles success animation — don't call setSuccess here

          // --- Fire deferred recurring setup after transfer succeeds ---
          // Guard: only fire once, and only if recurring was enabled
          if (_isRecurringEnabled && _recurringConfig != null
              && _pendingRecurringTransactionId != null
              && !_recurringSetupInitiated) {
            print("TransferSuccess: Firing deferred recurring transfer setup...");
            _fireRecurringSetup(context);
          }

          // --- Save Recipient After Successful Transfer ---
          // Only save if the recipient is marked for saving (isSaved=true)
          // and is not already persisted in the backend.
          // Backend handles dedup via unique constraint on (user_id, account_number, bank_name),
          // so even if this fires for an existing recipient, it will update rather than duplicate.
          if (_recipient != null && _recipient!.isSaved) {
            final recipientId = _recipient!.id;
            final parsedId = int.tryParse(recipientId);
            // Backend IDs are small auto-increment integers.
            // Temporary IDs use DateTime.now().millisecondsSinceEpoch (very large).
            // UUIDs won't parse as int (parsedId == null).
            final isAlreadySaved = parsedId != null && parsedId < 1000000000;
            if (!isAlreadySaved) {
              print("Listener: Saving new recipient to database (id: $recipientId)...");
              final authStateForSave = context.read<AuthenticationCubit>().state;
              if (authStateForSave is AuthenticationSuccess) {
                final accessToken = authStateForSave.profile.session.accessToken;
                // Use selected account's currency, falling back to locale
                final activeAccountSummaries = switch (accountState) {
                  AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
                  AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
                  _ => <AccountSummaryEntity>[],
                };
                final activeAccountCurrency = activeAccountSummaries.isNotEmpty && selectedCardIndex < activeAccountSummaries.length
                    ? activeAccountSummaries[selectedCardIndex].currency
                    : serviceLocator<LocaleManager>().currentCurrency;
                final recipientToSave = _recipient!.copyWith(
                  id: '0',
                  isSaved: true,
                  countryCode: _recipient!.countryCode ?? serviceLocator<LocaleManager>().currentCountry,
                  currency: _recipient!.currency ?? activeAccountCurrency,
                );
                final addRecipientUseCase = serviceLocator<AddRecipientUseCase>();
                _pendingRecipientSave = addRecipientUseCase(
                  recipient: recipientToSave,
                  accessToken: accessToken,
                ).then((result) {
                  result.fold(
                    (failure) => print("Warning: Failed to save recipient: ${failure.message}"),
                    (saved) {
                      print("Listener: Recipient saved with id: ${saved.id}");
                      // Update local reference so subsequent transfers
                      // recognize this recipient as already saved.
                      _recipient = saved;

                      // Refresh recipient list so the new recipient shows up
                      // when navigating back to select recipients screen.
                      try {
                        final recipientCubit = context.read<RecipientCubit>();
                        recipientCubit.getRecipients(
                          accessToken: accessToken,
                          countryCode: serviceLocator<LocaleManager>().currentCountry,
                          currency: activeAccountCurrency,
                        );
                      } catch (_) {
                        // RecipientCubit may not be in tree — safe to ignore
                      }
                    },
                  );
                });
              }
            }
          }
          // --- End Save Recipient ---

          // --- Non-blocking: Ensure P2P financial connection for internal recipients ---
          if (_recipient != null &&
              _recipient!.internalUserId != null &&
              _recipient!.internalUserId!.isNotEmpty &&
              _recipient!.bankName == 'LazerVault') {
            // Sender's own real name seeds the RECEIVER's view of us so their
            // connection isn't left as "Unknown User" (same source the receipt
            // uses at line ~1815).
            final senderProfile =
                context.read<AuthenticationCubit>().currentProfile;
            final senderName = senderProfile != null
                ? '${senderProfile.user.firstName} ${senderProfile.user.lastName}'
                    .trim()
                : '';
            _ensureFinancialConnection(
              otherUserId: _recipient!.internalUserId!,
              otherUserName: _recipient!.name,
              myName: senderName.isNotEmpty ? senderName : null,
            );
          }
          // --- End P2P Connection ---

          // --- Refresh Account Summaries ---
          // Refresh immediately (no delay) since this widget will be disposed
          // when navigating to the receipt. The cubit persists across navigation.
          final refreshAuthState = context.read<AuthenticationCubit>().state;
          if (refreshAuthState is AuthenticationSuccess) {
            context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
              userId: refreshAuthState.profile.user.id,
              accessToken: refreshAuthState.profile.session.accessToken,
            );
            print("Balance refresh triggered after successful transfer");
          }
          // --- End Refresh ---

          try {
            // Prepare data for the proof screen
            double transferAmount = 0.0;
            try {
              transferAmount =
                  (transferState.response.amount)
                          .toDouble() /
                      100.0;
            } catch (_) {
              print("Warning: Could not parse amount for proof screen.");
            }
            double transferFee =
                (transferState.response.fee).toDouble() / 100.0;
            double totalAmount =
                (transferState.response.totalAmount).toDouble() /
                    100.0;
            if (transferFee == 0.0) {
              final lastFeeState = context.read<TransferCubit>().lastFeeLoaded;
              if (lastFeeState != null) {
                transferFee = lastFeeState.fee / 100.0;
              }
            }
            if (totalAmount == 0 && transferAmount > 0) {
              totalAmount = transferAmount + transferFee;
            }

            String sourceAccountInfo = 'Unknown Card';
            String senderCurrency = 'NGN';
            String sourceAccountName = '';
            final summaries = switch (accountState) {
              AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
              AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
              _ => <AccountSummaryEntity>[],
            };
            if (summaries.isNotEmpty &&
                selectedCardIndex < summaries.length) {
              final selectedAccount =
                  summaries[selectedCardIndex];
              String sourceCardType = selectedAccount.accountType;
              String sourceLast4 = selectedAccount.accountNumberLast4;
              sourceAccountInfo = '$sourceCardType •••• $sourceLast4';
              senderCurrency = selectedAccount.currency;
              sourceAccountName = selectedAccount.accountName ?? '';
            }

            // Empty for internal user recipients (no real account number) → the
            // receipt hides the Account row instead of masking the user-id UUID.
            String recipientAccountMasked = _recipient!.maskedAccount;

            final transferDetails = {
              'amount': transferAmount,
              'fee': transferFee,
              'totalAmount': totalAmount,
              'recipientName': _recipient!.name,
              'recipientAccountMasked': recipientAccountMasked,
              'recipientBankName': _recipient!.displayBankName,
              'recipientBankCode': _recipient!.sortCode,
              'sourceAccountInfo': sourceAccountInfo,
              'sourceAccountName': sourceAccountName,
              'currency': senderCurrency,
              'transferId':
                  transferState.response.transferId.toString(),
              'timestamp': transferState.response.createdAt,
              'category': selectedCategory?.displayName,
              // Carry the send-funds flow (long|short) so the processing &
              // receipt screens emit real telemetry instead of 'unknown'.
              'flow': AnalyticsService.instance.currentSendFlow,
              'reference': _referenceController.text.trim().isNotEmpty
                  ? _referenceController.text.trim()
                  : null,
              'providerReference': transferState.response.providerReference,
              'internalReference': transferState.response.internalReference,
              'status': transferState.response.status,
              'network': _recipient!.bankName == 'LazerVault'
                  ? 'Lazervault Internal Transfer'
                  : 'External Bank Transfer',
              'transferType': _recipient!.bankName == 'LazerVault'
                  ? 'Internal Transfer'
                  : 'Domestic Transfer',
              if (scheduledDate != null) 'scheduledAt': scheduledDate,
              // Recurring payment context for receipt display
              if (_isRecurringEnabled && _recurringConfig != null) ...{
                'isRecurring': true,
                'recurringFrequency': _recurringConfig!.frequency.name,
                'recurringSchedule': _recurringConfig!.summary,
                if (_createdRecurringTransferId != null)
                  'recurringTransferId': _createdRecurringTransferId,
              },
            };
            print(
                'Listener: Transfer details prepared: $transferDetails');

            // Store transfer details — navigation happens after PIN modal dismisses
            _lastTransferDetails = transferDetails;

            if (_recurringSetupPending) {
              _transferSucceeded = true;
              _pendingTransferSuccess = transferState;
            }
          } catch (e, stackTrace) {
            print("Error inside TransferSuccess listener: $e\n$stackTrace");
            if (_isConfirmingTransfer) {
              setState(() {
                _isConfirmingTransfer = false;
              });
            }
            // Close pin sheet if open
            if (mounted) {
              try { Navigator.of(context).pop(); } catch (_) {}
            }
            Get.snackbar(
              'Error',
              'An internal error occurred while processing the transfer success.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.orange.withValues(alpha: 0.8),
              colorText: Colors.white,
            );
          }
        } else if (transferState is TransferFailure) {
          print(
              'Listener: Transfer Failure received: ${transferState.message}');
          if (_isConfirmingTransfer) {
            setState(() {
              _isConfirmingTransfer = false;
            });
          }

          // Reset all recurring state to prevent stale flags
          _resetRecurringState();

          // Show failure in PIN modal if open, otherwise show snackbar
          final modalState = pinModalKey.currentState;
          if (modalState != null) {
            modalState.setFailed(transferState.message);
            // Auto-close after showing failure
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                try { Navigator.of(context).pop(); } catch (_) {}
              }
            });
          } else {
            // Fallback: close any open dialog
            if (Get.isDialogOpen ?? false) {
              Get.back();
            }
          }

          // KYC UPGRADE MODAL — show before generic error handling
          if (transferState.isKYCError && mounted) {
            handleKYCError(transferState.message, context, 'send money');
            return; // Don't show snackbar — modal is shown
          }

          // Show error bottom sheet for financial errors that need user attention,
          // fall back to snackbar for minor/informational errors.
          final lowerMessage = transferState.message.toLowerCase();
          final isFinancialError = lowerMessage.contains('insufficient') ||
              lowerMessage.contains('balance') ||
              lowerMessage.contains('daily') ||
              lowerMessage.contains('limit') ||
              lowerMessage.contains('exceeded') ||
              lowerMessage.contains('frozen') ||
              lowerMessage.contains('locked') ||
              lowerMessage.contains('suspended') ||
              lowerMessage.contains('restricted') ||
              lowerMessage.contains('another transfer') ||
              lowerMessage.contains('in progress') ||
              lowerMessage.contains('resource busy') ||
              lowerMessage.contains('rate limit') ||
              lowerMessage.contains('too many');

          if (isFinancialError && mounted) {
            showTransferErrorBottomSheet(
              context,
              transferState.message,
              onRetry: transferState.isRetryable ? () {
                // User can retry from the current screen
              } : null,
            );
          } else {
            // Lightweight snackbar for network, session, provider, and generic errors
            String errorTitle = 'Transfer Failed';
            String errorMessage = transferState.message;
            Color errorColor = Colors.red.withValues(alpha: 0.7);
            Duration errorDuration = const Duration(seconds: 4);

            if (lowerMessage.contains('network') || lowerMessage.contains('connection') || lowerMessage.contains('timeout')) {
              errorTitle = 'Network Error';
              errorMessage = 'Unable to connect to server. Please check your internet connection and try again.';
              errorColor = Colors.orange.withValues(alpha: 0.7);
              errorDuration = const Duration(seconds: 5);
            } else if ((lowerMessage.contains('auth') || lowerMessage.contains('token') || lowerMessage.contains('unauthorized')) && !lowerMessage.contains('authorization key') && !lowerMessage.contains('provider') && !lowerMessage.contains('flutterwave')) {
              errorTitle = 'Session Expired';
              errorMessage = 'Your session has expired. Please log in again.';
              errorDuration = const Duration(seconds: 6);
            } else if (lowerMessage.contains('authorization key') || lowerMessage.contains('provider') || lowerMessage.contains('flutterwave error')) {
              errorTitle = 'Transfer Failed';
              errorMessage = 'The payment provider encountered an error. Please try again later or contact support.';
              errorDuration = const Duration(seconds: 5);
            } else if (lowerMessage.contains('recipient') || lowerMessage.contains('not found')) {
              errorTitle = 'Recipient Not Found';
              errorMessage = 'The recipient could not be found. Please verify the recipient details.';
            } else if (lowerMessage.contains('account') && lowerMessage.contains('not found')) {
              errorTitle = 'Account Error';
              errorMessage = 'Source account not found or invalid. Please select another account.';
            } else if (lowerMessage.contains('invalid') && lowerMessage.contains('amount')) {
              errorTitle = 'Invalid Amount';
              errorMessage = 'The transfer amount is invalid. Please enter a valid amount.';
            } else if (lowerMessage.contains('grpc') || lowerMessage.contains('unavailable')) {
              errorTitle = 'Service Unavailable';
              errorMessage = 'The service is temporarily unavailable. Please try again in a few moments.';
              errorColor = Colors.orange.withValues(alpha: 0.7);
              errorDuration = const Duration(seconds: 5);
            }

            Get.snackbar(
              errorTitle,
              errorMessage,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: errorColor,
              colorText: Colors.white,
              duration: errorDuration,
              icon: Icon(
                Icons.error_outline,
                color: Colors.white,
              ),
            );
          }
        }
      },
      builder: (context, transferState) {
        final isTransferLoading = transferState is TransferLoading;
        if (transferState is TransferSuccess) {
          print("TransferSuccess: $transferState");
        }

        // Use BlocConsumer for AccountCardsSummaryCubit to rebuild UI parts when accounts load
        return BlocConsumer<AccountCardsSummaryCubit, AccountCardsSummaryState>(
          listener: (context, accountState) {
            // Add listener to observe state changes for AccountCardsSummaryCubit
            print(
                "InitiateSendFunds AccountSummary Listener: Received state -> $accountState");

            // Auto-show confirm when prefilled from transaction history
            if (_autoShowConfirm &&
                !_autoConfirmTriggered &&
                amount.isNotEmpty &&
                _recipient != null &&
                (accountState is AccountCardsSummaryLoaded ||
                    accountState is AccountBalanceUpdated)) {
              _autoConfirmTriggered = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) _showTransferConfirmation(accountState);
              });
            }
          },
          builder: (context, accountState) {
            final isAccountLoading =
                accountState is AccountCardsSummaryLoading ||
                    accountState is AccountCardsSummaryInitial;
            // AccountBalanceUpdated means we have data (from WebSocket), so don't treat as loading
            final isLoading =
                isTransferLoading || isAccountLoading; // Combined loading state

            // Determine max amount (example logic, adjust as needed)
            double maxAmount = 0.0;
            final summaries = switch (accountState) {
              AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
              AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
              _ => <AccountSummaryEntity>[],
            };
            if (summaries.isNotEmpty &&
                selectedCardIndex < summaries.length) {
              maxAmount =
                  summaries[selectedCardIndex].availableBalance; // Example: use available balance as max
            }

            return Scaffold(
              backgroundColor: const Color(0xFF121212),
              // Tap anywhere outside the inputs to dismiss the system keyboard.
              body: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  // AbsorbPointer disables interaction during loading
                  child: AbsorbPointer(
                    absorbing: isLoading,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            // Top Row (Recipient Info)
                            Row(
                              children: [
                                // Themed back button — a translucent-white
                                // surface (alpha 0.08) that reads as a tappable
                                // chip against the 0xFF121212 page background,
                                // matching the page's other cards/inputs. The
                                // padded InkWell gives a ~42px hit target (wider
                                // than the bare icon) plus a ripple on tap.
                                Material(
                                  color: Colors.white.withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(12),
                                  clipBehavior: Clip.antiAlias,
                                  child: InkWell(
                                    onTap: () => Get.back(),
                                    child: Padding(
                                      padding: EdgeInsets.all(12.w),
                                      child: const Icon(
                                        Icons.arrow_back_ios_new,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          _recipient!.name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4.h),
                                        // Show recipient account number and bank
                                        Text(
                                          _recipient!.accountNumber,
                                          style: TextStyle(
                                            color: Colors.white.withValues(alpha: 0.7),
                                            fontSize: 12,
                                          ),
                                        ),
                                        if (_recipient!.bankName.isNotEmpty)
                                          Padding(
                                            padding: EdgeInsets.only(top: 2.h),
                                            child: Text(
                                              _recipient!.bankName,
                                              style: TextStyle(
                                                color: Colors.white.withValues(alpha: 0.5),
                                                fontSize: 11,
                                              ),
                                            ),
                                          ),
                                      ],
                                  ),
                                )),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 40.w,
                                      height: 40.h,
                                      padding: const EdgeInsets.all(2.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(alpha: 0.08),
                                            blurRadius: 6,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.blueGrey[700],
                                        child: Text(
                                          _recipient!.name.isNotEmpty
                                              ? _recipient!.name[0].toUpperCase()
                                              : '?',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),

                            // Pay with Card Selector
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Pay with',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                _buildCardSelector(accountState),
                                _buildFrozenSourceBanner(accountState),
                              ],
                            ),
                            SizedBox(height: 16.h),

                            // Amount Entry Box
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Enter amount:',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  SizedBox(height: 4.0.h),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(alpha: 0.05),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        // Get currency from selected account or default
                                        child: Builder(
                                          builder: (context) {
                                            final summaries = switch (accountState) {
                                              AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
                                              AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
                                              _ => <AccountSummaryEntity>[],
                                            };
                                            final currency = summaries.isNotEmpty &&
                                                    selectedCardIndex < summaries.length
                                                ? summaries[selectedCardIndex].currency
                                                : 'NGN';
                                            return Text(
                                              currency,
                                              style: TextStyle(color: Colors.white),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      // Editable amount field — supports both keyboard and number pad input
                                      Expanded(
                                        child: TextField(
                                          controller: _amountController,
                                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                                          ],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '0.00',
                                            hintStyle: TextStyle(
                                              color: Colors.white.withValues(alpha: 0.5),
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            contentPadding: EdgeInsets.zero,
                                          ),
                                          onChanged: _onAmountFieldChanged,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Builder(
                                      builder: (context) {
                                        // Get currency symbol from selected account
                                        final summaries = switch (accountState) {
                                          AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
                                          AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
                                          _ => <AccountSummaryEntity>[],
                                        };
                                        String currencySymbol = '₦';
                                        if (summaries.isNotEmpty &&
                                            selectedCardIndex < summaries.length) {
                                          currencySymbol = _getCurrencySymbol(
                                              summaries[selectedCardIndex].currency);
                                        }
                                        return Text(
                                          'Max $currencySymbol${NumberFormat('#,##0.00', 'en_US').format(maxAmount)}',
                                          style: const TextStyle(color: Colors.white70),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  // Category Dropdown
                                  GestureDetector(
                                    onTap: _showCategoryPicker,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.05),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            selectedCategory?.iconData ?? Icons.category_outlined,
                                            color: selectedCategory != null
                                                ? selectedCategory!.color
                                                : Colors.white70,
                                            size: 20,
                                          ),
                                          SizedBox(width: 8.w),
                                          Expanded(
                                            child: Text(
                                              selectedCategory?.displayName ??
                                                  'Select Category',
                                              style: TextStyle(
                                                color: selectedCategory != null
                                                    ? Colors.white
                                                    : Colors.white70,
                                                fontSize: 14,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.white70,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  // Reference Field
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 0),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.05),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.note_outlined,
                                          color: Colors.white70,
                                          size: 20,
                                        ),
                                        SizedBox(width: 8.w),
                                        Expanded(
                                          child: TextField(
                                            controller: _referenceController,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText:
                                                  'Add narration (optional)',
                                              hintStyle: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 14,
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 14),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.h),

                            // Quick amounts section
                            _buildQuickAmounts(accountState),
                            SizedBox(height: 16.h),

                            // Send/Schedule Button Row
                            Row(
                              children: [
                                Expanded(
                                  child: Builder(
                                    builder: (context) {
                                      final summaries = switch (accountState) {
                                        AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
                                        AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
                                        _ => <AccountSummaryEntity>[],
                                      };
                                      final canProceed = !isLoading &&
                                          amount.isNotEmpty &&
                                          (int.tryParse(amount) ?? 0) != 0 &&
                                          summaries.isNotEmpty;
                                      return ElevatedButton(
                                        onPressed: canProceed
                                            ? () => _showTransferConfirmation(
                                                accountState)
                                            : null,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF2962FF)
                                              .withValues(alpha: 0.8),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          disabledBackgroundColor:
                                              Colors.grey.withValues(alpha: 0.3),
                                          disabledForegroundColor:
                                              Colors.white.withValues(alpha: 0.5),
                                        ),
                                        child: const Text(
                                          'Confirm Transfer',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                // Schedule Button
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.05),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                                  ),
                                  child: IconButton(
                                    tooltip: scheduledDate == null
                                        ? 'Schedule Transfer'
                                        : 'Scheduled: ${DateFormat('MMM d, HH:mm').format(scheduledDate!)}',
                                    onPressed:
                                        isLoading ? null : _showScheduleOptions,
                                    icon: Icon(
                                      Icons.schedule,
                                      color: scheduledDate != null
                                          ? const Color(0xFF2962FF)
                                              .withValues(alpha: 0.8)
                                          : Colors.white70,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),

                            // Number pad
                            Expanded(
                              child: GridView.count(
                                crossAxisCount: 3,
                                mainAxisSpacing: 12.h,
                                crossAxisSpacing: 16.w,
                                childAspectRatio:
                                    2.5, // Adjust aspect ratio for better spacing
                                // Extra bottom padding lifts the last row (0 / ⌫)
                                // clear of the device nav bar / home indicator so
                                // it isn't hidden below the screen edge.
                                padding: EdgeInsets.only(bottom: 32.h),
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  for (var i = 1; i <= 9; i++)
                                    _buildNumberButton(i.toString()),
                                  // Use Icon for clear/placeholder if needed
                                  Container(), // Placeholder
                                  _buildNumberButton('0'),
                                  _buildNumberButton('<'), // Backspace
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Loading Overlay
                        if (isLoading)
                          Positioned.fill(
                            child: Container(
                              color: Colors.black.withValues(alpha: 0.5),
                              child: const Center(
                                child: LazerVaultLoader.small(),
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
          },
        );
      },
    ),
    );
  }

  Widget _buildNumberButton(String number) {
    return TextButton(
      onPressed: () => _onNumberPress(number),
      style: TextButton.styleFrom(
        foregroundColor: Colors.white.withValues(alpha: 0.1), // Ripple color
        backgroundColor: Colors.white.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.zero, // Remove default padding
      ),
      child: Center(
        child: Text(
          number == '<' ? '⌫' : number, // Use backspace icon
          style: TextStyle(
            color: Colors.white,
            fontSize: number == '<' ? 20 : 24, // Smaller size for icon
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
