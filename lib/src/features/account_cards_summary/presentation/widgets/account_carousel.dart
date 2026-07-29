import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/panic_balance_service.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/balance_websocket_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/services/balance_websocket_service.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/account_cards_summary/presentation/widgets/animated_balance_counter.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_cubit.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_state.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

// Type definition for the callback when a card's details are requested
typedef OnShowDetailsCallback = void Function(Map<String, dynamic> accountArgs);

class AccountCarousel extends StatefulWidget {
  final List<AccountSummaryEntity> accountSummaries;
  final OnShowDetailsCallback onShowDetails; // Callback to show bottom sheet

  const AccountCarousel({
    super.key,
    required this.accountSummaries,
    required this.onShowDetails,
  });

  @override
  State<AccountCarousel> createState() => _AccountCarouselState();
}

class _AccountCarouselState extends State<AccountCarousel> {
  int _currentIndex = 0;
  final AccountManager _accountManager = serviceLocator<AccountManager>();
  // Panic Balance — when its decoy is active, the DISPLAYED balance is replaced
  // with the decoy amount. Real values (_getAvailableBalance) are untouched.
  final PanicBalanceService _panic = serviceLocator<PanicBalanceService>();

  // Panic toggle plays a SNAPPY roll (both directions) — distinct from the slow
  // 3s dashboard/credit reveal AND from the instant snap used on login. It is
  // armed ONLY by the user gesture (_onPanicChanged), so a login-time decoy
  // load or a real credit/debit is unaffected. Disarmed once the roll finishes.
  static const Duration _kPanicRollDuration = Duration(milliseconds: 900);
  bool _panicRolling = false;
  Timer? _panicRollTimer;

  // Store cubit reference early to avoid context.read() in delayed callbacks
  // (accessing context after Element is defunct causes crashes)
  late final AccountCardsSummaryCubit _cubit;

  // Track real-time balance updates per account
  final Map<String, double> _realtimeBalances = {};

  // Pending balance updates to apply when dashboard becomes visible (from→to for two-phase animation)
  final Map<String, ({double from, double to})> _pendingBalanceUpdates = {};

  // Track which accounts are currently animating a balance update (for "Updating..." indicator)
  final Set<String> _animatingAccounts = {};

  // Last WebSocket event this carousel already animated. Used to de-dupe
  // so a single money-in event animates exactly once even though the
  // BlocListener can be invoked again on unrelated rebuilds. Replaces the
  // old shared BalanceWebSocketCubit.clearLastUpdate() consumption, which
  // raced with the dashboard listener and could swallow the event before
  // the carousel ever saw it.
  BalanceUpdateEvent? _lastAnimatedEvent;

  // Per-account trend period — controls the rolling window the
  // dashboard percentage chip is computed against (day / week / month /
  // year). Stored client-side because the API returns the trend itself
  // already; this state just tells the UI which window the user
  // picked, so subsequent fetches request the matching window.
  // Defaults to month (matches the existing API default).
  final Map<String, _TrendPeriod> _trendPeriodByAccount = {};

  // Whether we're currently resolving a family account ID for setup navigation
  bool _isResolvingFamilyId = false;
  // Helper to convert currency code to symbol
  String _getCurrencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'USD':
        return '\$';
      case 'GBP':
        return '£';
      case 'EUR':
        return '€';
      case 'NGN':
        return '₦';
      case 'ZAR':
        return 'R';
      case 'CAD':
        return 'C\$';
      case 'AUD':
        return 'A\$';
      case 'KES':
        return 'KSh';
      case 'GHS':
        return 'GH₵';
      default:
        return '\$';
    }
  }

  /// Format balance with comma separators and 2 decimal places
  /// Returns a clearing time estimate string for pending deposits.
  /// Uses the backend-provided [clearingEstimate] when available,
  /// otherwise falls back to a generic "Clearing in progress" message.
  String _getClearingTimeEstimate(AccountSummaryEntity account) {
    if (account.clearingEstimate != null &&
        account.clearingEstimate!.isNotEmpty) {
      return account.clearingEstimate!;
    }
    return 'Clearing in progress';
  }

  /// Render an account number as masked display: keep the last 4 digits
  /// visible, replace everything else with a single bullet run (no
  /// 4-4-4 card-PIN spacing — this is an account number, not a card).
  /// Falls back to the raw value if it's already ≤4 chars.
  String _maskAccountNumber(String raw) {
    if (raw.isEmpty) return raw;
    if (raw.length <= 4) return raw;
    final hiddenCount = raw.length - 4;
    final visibleTail = raw.substring(raw.length - 4);
    return '${'•' * hiddenCount}$visibleTail';
  }

  String _formatBalance(double amount) {
    final isNegative = amount < 0;
    final parts = amount.abs().toStringAsFixed(2).split('.');
    final intPart = parts[0];
    final decPart = parts[1];
    final buffer = StringBuffer();
    for (var i = 0; i < intPart.length; i++) {
      if (i > 0 && (intPart.length - i) % 3 == 0) buffer.write(',');
      buffer.write(intPart[i]);
    }
    return '${isNegative ? '-' : ''}${buffer.toString()}.$decPart';
  }

  @override
  void initState() {
    super.initState();
    // Capture cubit reference now while context is guaranteed valid.
    // This avoids context.read() in Future.delayed callbacks where the
    // Element may already be defunct.
    _cubit = context.read<AccountCardsSummaryCubit>();
    // Initialize carousel to show the active account if one is selected
    _initializeCarouselPosition();
    // Set the first account as active if none is selected
    _initializeActiveAccount();
    // Check if the cubit has pending WebSocket animations to play
    // (e.g., when dashboard is rebuilt via Get.offAllNamed after a transfer)
    _checkForPendingAnimation();
    // Re-render when the panic decoy is toggled (shake / long-press) or edited.
    _panic.addListener(_onPanicChanged);
  }

  void _onPanicChanged() {
    if (!mounted) return;
    // Arm the snappy roll so the balance ANIMATES on BOTH main→panic and
    // panic→main (a plain toggle used to snap straight into the decoy). Disarm
    // shortly after the roll completes so the next real credit/debit falls back
    // to the normal 3s reveal.
    setState(() => _panicRolling = true);
    _panicRollTimer?.cancel();
    _panicRollTimer = Timer(
      _kPanicRollDuration + const Duration(milliseconds: 150),
      () {
        if (mounted) setState(() => _panicRolling = false);
      },
    );
  }

  @override
  void dispose() {
    _panicRollTimer?.cancel();
    _panic.removeListener(_onPanicChanged);
    super.dispose();
  }

  /// Balance to DISPLAY: the decoy amount when the panic camouflage is on, else
  /// the real available balance. Display-only — never used for transactions.
  double _displayBalance(AccountSummaryEntity account) {
    if (_panic.isCamouflageOn) return _panic.decoyAmount;
    return _getAvailableBalance(account);
  }

  @override
  void didUpdateWidget(AccountCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Clamp _currentIndex when item count shrinks (e.g., an account is removed).
    if (_currentIndex >= _totalItemCount && _totalItemCount > 0) {
      _currentIndex = _totalItemCount - 1;
    }
  }

  /// Reads cubit tracking maps for unconsumed WebSocket updates and plays
  /// a two-phase animation: show old balance → animate to new balance.
  void _checkForPendingAnimation() {
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      final animations = _cubit.getPendingAnimations();
      if (animations.isEmpty) return;

      // Phase 1: Set _realtimeBalances to "from" values (shows old balance)
      setState(() {
        for (final entry in animations.entries) {
          _realtimeBalances[entry.key] = entry.value.from;
        }
      });

      // Phase 2: After a short delay, set "to" values (triggers CompactAnimatedBalance animation)
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!mounted) return;
        setState(() {
          for (final entry in animations.entries) {
            _realtimeBalances[entry.key] = entry.value.to;
            _animatingAccounts.add(entry.key);
          }
        });

        // After animation completes (~3s duration), consume the update so entities reflect reality
        Future.delayed(const Duration(seconds: 3), () {
          if (!mounted) return;
          setState(() {
            _animatingAccounts.removeAll(animations.keys);
          });
          _cubit.markBalanceUpdateConsumed();
        });
      });
    });
  }

  /// Initialize carousel position to show the currently active account
  void _initializeCarouselPosition() {
    if (_accountManager.hasActiveAccount && widget.accountSummaries.isNotEmpty) {
      final activeId = _accountManager.activeAccountId;
      final index = widget.accountSummaries
          .indexWhere((a) => a.id == activeId || a.spendingAccountId == activeId);
      if (index >= 0) {
        _currentIndex = index;
      }
    }
  }

  Future<void> _initializeActiveAccount() async {
    if (!_accountManager.hasActiveAccount && widget.accountSummaries.isNotEmpty) {
      // Set the first account as active by default (spending id so a family
      // card resolves to its real-money virtual account).
      _accountManager.setActiveAccount(widget.accountSummaries.first.spendingAccountId);
    }
  }

  /// Called when user swipes the carousel - automatically sets active account
  void _onPageChanged(int index, CarouselPageChangedReason reason) {
    setState(() {
      _currentIndex = index;
    });

    // Skip setting active account when on the "+" add card (last index).
    // Use spendingAccountId so a family card activates its real-money virtual
    // account (the pool) — that's the source the payments path debits + limits.
    if (widget.accountSummaries.isNotEmpty && index < widget.accountSummaries.length) {
      final newAccountId = widget.accountSummaries[index].spendingAccountId;
      _accountManager.setActiveAccount(newAccountId);
    }
  }

  int get _totalItemCount => widget.accountSummaries.length;

  @override
  Widget build(BuildContext context) {
     // Apply any buffered balance updates now that we're building (visible)
     if (_pendingBalanceUpdates.isNotEmpty) {
       WidgetsBinding.instance.addPostFrameCallback((_) {
         _applyPendingUpdates();
       });
     }

     if (widget.accountSummaries.isEmpty) {
        return SizedBox(
          height: 228.h,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.6),
                  const Color(0xFF4834D4).withValues(alpha: 0.6),
                ],
              ),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.15),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_balance_wallet_outlined,
                  color: Colors.white.withValues(alpha: 0.7),
                  size: 36.sp,
                ),
                SizedBox(height: 12.h),
                Text(
                  'No accounts found',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'Pull down to refresh or check your connection.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        );
     }

    // Wrap with BlocListener to handle real-time balance updates.
    //
    // listenWhen ensures we react to every DISTINCT money event exactly
    // once: only when lastUpdate is non-null AND differs from the previous
    // state's lastUpdate. _handleBalanceUpdate additionally guards against
    // re-processing the same event instance (_lastAnimatedEvent) so the
    // card animates reliably on EVERY credit and never double-animates.
    return BlocListener<BalanceWebSocketCubit, BalanceWebSocketState>(
      listenWhen: (previous, current) =>
          current.lastUpdate != null &&
          current.lastUpdate != previous.lastUpdate,
      listener: (context, state) {
        if (state.lastUpdate != null) {
          _handleBalanceUpdate(state.lastUpdate!);
        }
      },
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: _totalItemCount,
            options: CarouselOptions(
              // Slightly trimmed so the Referral Bonus gift icon + label
              // peeks above the fold (without exposing the body copy
              // below it). With the balance still wrapped between two
              // Spacers, the amount stays vertically centered in the
              // shorter card — no top-heavy lean.
              height: 190.h,
              viewportFraction: 0.95, // Wider cards
              enlargeCenterPage: true,
              initialPage: _currentIndex, // Start at active account position
              onPageChanged: _onPageChanged, // Automatically sets active account on swipe
            ),
            itemBuilder: (context, index, realIndex) {
              final account = widget.accountSummaries[index];
              return _buildAccountCard(context, account);
            },
          ),
          SizedBox(height: 20.h),
          _buildCarouselIndicators(_totalItemCount),
        ],
      ),
    );
  }

  /// Handle real-time balance updates from WebSocket
  void _handleBalanceUpdate(BalanceUpdateEvent event) {
    final accountId = event.accountId;
    final newBalance = event.newBalance;

    if (!mounted) return;

    // De-dupe: never animate the same event instance twice (the listener
    // can fire again on unrelated rebuilds). This replaces the old shared
    // clearLastUpdate() and makes each money-in event animate exactly once.
    if (identical(_lastAnimatedEvent, event)) return;
    _lastAnimatedEvent = event;

    // Lifecycle/non-balance events (insurance renewals, TagPay & similar
    // notification events, etc.) carry NO account balance snapshot —
    // BalanceUpdateEvent defaults new_balance/available_balance to 0 for those
    // (see its fromJson). Applying such an event would overwrite the card's real
    // balance with 0, and the panic shake-reveal would then show ₦0 even though
    // the balance is intact (the reported bug: after TagPay → dashboard → shake).
    // Skip anything that isn't a real snapshot.
    if (accountId.isEmpty) return;
    if (newBalance <= 0 && event.availableBalance <= 0) return;

    // Check if dashboard is the current visible route
    final isVisible = ModalRoute.of(context)?.isCurrent ?? false;

    if (isVisible) {
      // Dashboard is visible — apply balance update immediately (triggers animation)
      setState(() {
        _realtimeBalances[accountId] = newBalance;
        _animatingAccounts.add(accountId);
      });

      // After animation completes (~3s), consume so entities reflect the new balance
      Future.delayed(const Duration(seconds: 3), () {
        if (!mounted) return;
        setState(() {
          _animatingAccounts.remove(accountId);
        });
        _cubit.markBalanceUpdateConsumed();
      });
    } else {
      // Dashboard is not visible — buffer with from→to for two-phase animation on return.
      // "from" is the currently displayed balance (use putIfAbsent to keep earliest value).
      final currentDisplayed = _realtimeBalances[accountId]
          ?? widget.accountSummaries.where((a) => a.id == accountId).firstOrNull?.balance;
      if (currentDisplayed != null) {
        _pendingBalanceUpdates.putIfAbsent(accountId, () => (from: currentDisplayed, to: newBalance));
        // Always update "to" in case multiple events arrive while away
        _pendingBalanceUpdates[accountId] = (from: _pendingBalanceUpdates[accountId]!.from, to: newBalance);
      }
      debugPrint('AccountCarousel: Buffered balance update for account $accountId (dashboard not visible)');
    }

    debugPrint('AccountCarousel: Real-time balance update for account $accountId: $newBalance (${event.eventType})');
  }

  /// Apply any pending balance updates when dashboard becomes visible.
  /// Uses two-phase animation: show old balance first, then animate to new balance.
  void _applyPendingUpdates() {
    if (_pendingBalanceUpdates.isEmpty || !mounted) return;

    final updates = Map<String, ({double from, double to})>.from(_pendingBalanceUpdates);
    _pendingBalanceUpdates.clear();

    // Phase 1: Set to "from" values (shows old balance)
    setState(() {
      for (final entry in updates.entries) {
        _realtimeBalances[entry.key] = entry.value.from;
      }
    });

    // Phase 2: After short delay, set "to" values (triggers animation)
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() {
        for (final entry in updates.entries) {
          _realtimeBalances[entry.key] = entry.value.to;
          _animatingAccounts.add(entry.key);
        }
      });

      // After animation completes, consume so entities reflect reality
      Future.delayed(const Duration(seconds: 3), () {
        if (!mounted) return;
        setState(() {
          _animatingAccounts.removeAll(updates.keys);
        });
        _cubit.markBalanceUpdateConsumed();
      });

      debugPrint('AccountCarousel: Applied pending balance updates (two-phase animation)');
    });
  }

  /// Get the current balance for an account (real-time if available, otherwise from entity)
  double _getAccountBalance(AccountSummaryEntity account) {
    // Check if we have a real-time balance update for this account
    if (_realtimeBalances.containsKey(account.id)) {
      return _realtimeBalances[account.id]!;
    }
    // Fall back to the balance from the account entity
    return account.balance;
  }

  /// Returns the available balance for display on the dashboard.
  /// Available balance = balance - reserved - clearing holds.
  /// When real-time updates arrive, they update total balance; if no holds,
  /// available == total (the common case).
  double _getAvailableBalance(AccountSummaryEntity account) {
    if (_realtimeBalances.containsKey(account.id)) {
      // Real-time update: if account has holds, subtract pending from new balance
      final realtimeTotal = _realtimeBalances[account.id]!;
      if (account.hasPendingBalance) {
        return (realtimeTotal - account.reservedBalance).clamp(0.0, realtimeTotal);
      }
      return realtimeTotal;
    }
    return account.availableBalance > 0 ? account.availableBalance : account.balance;
  }

  /// Resolves the family account ID for a legacy NUBAN (familyAccountId == null),
  /// then navigates to setup. Auto-creates a family_accounts record if needed.
  Future<void> _resolveFamilyIdAndNavigate(AccountSummaryEntity account) async {
    setState(() => _isResolvingFamilyId = true);
    try {
      // Single canonical resolver (shared with the services "Setup Now" card) so
      // both setup entry points resolve-or-create the SAME family_accounts record
      // and land on the SAME activation-setup screen — no divergent flows.
      final familyCubit = serviceLocator<FamilyAccountCubit>();
      final familyId = await familyCubit.resolveOrCreatePendingFamilyId(
        currency: account.currency,
      );
      if (familyId != null) {
        Get.toNamed(AppRoutes.familyActivationSetup,
            arguments: {'familyId': familyId});
      } else {
        final s = familyCubit.state;
        Get.snackbar(
          'Error',
          s is FamilyAccountError
              ? s.message
              : 'Failed to set up your Family & Friends account. Please try again.',
          backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load family account. Please try again.',
        backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      if (mounted) {
        setState(() => _isResolvingFamilyId = false);
      }
    }
  }

  Widget _buildAccountCard(BuildContext context, AccountSummaryEntity account) {
    // Check if this is a family account
    if (account.accountTypeEnum == VirtualAccountType.family) {
      return _buildFamilyAccountCard(context, account);
    }

    // Check if this is a business account
    if (account.accountTypeEnum == VirtualAccountType.business) {
      return _buildBusinessAccountCard(context, account);
    }

    // Standard account card
    final bool isUp = account.isUp;
    // Use real-time balance if available
    final currentBalance = _getAccountBalance(account);

    final availableBalance = _getAvailableBalance(account);

    final cardArguments = {
      'id': account.id,
      'accountType': account.accountType,
      'currency': account.currency,
      'balance': currentBalance,
      'availableBalance': availableBalance,
      'reservedBalance': account.reservedBalance,
      'accountNumber': account.accountNumber ?? '•••• ${account.accountNumberLast4}', // Full NUBAN for deposits
      'accountNumberMasked': '•••• ${account.accountNumberLast4}',
      'bankName': account.bankName ?? 'Wema Bank', // Partner bank name
      'accountName': account.accountName ?? 'Lazervault Account', // Account holder name
      'trend': '${account.trendPercentage > 0 ? '+' : ''}${account.trendPercentage.toStringAsFixed(1)}%',
      'isUp': isUp,
    };

    // Wrap with StreamBuilder to reactively show active account indicator
    return StreamBuilder<String?>(
      stream: _accountManager.accountIdStream,
      initialData: _accountManager.activeAccountId,
      builder: (context, snapshot) {
        final currencySymbol = _getCurrencySymbol(account.currency);

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 78, 3, 208),
                Color(0xFF4834D4),
              ],
            ),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Stack(
              children: [
                // Background decorative circles
                Positioned(
                  right: -30,
                  top: -30,
                  child: Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                ),
                Positioned(
                  right: 40,
                  bottom: -40,
                  child: Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.05),
                    ),
                  ),
                ),
                // Main content
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    "${account.accountType} Account",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.9),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                // (Frozen badge moved to the right end of the
                                // balance amount below.)
                              ],
                            ),
                          ),
                        // Trend chip — tap to open the period picker so
                        // the user can choose whether the percentage
                        // tracks against the last day, week or month.
                        GestureDetector(
                          onTap: () => _openTrendPeriodPicker(account),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: isUp
                                  ? Colors.green.withValues(alpha: 0.2)
                                  : Colors.red.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  cardArguments['trend'] as String,
                                  style: TextStyle(
                                    color: isUp
                                        ? Colors.green[300]
                                        : Colors.red[300],
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Icon(
                                  Icons.expand_more,
                                  color: isUp
                                      ? Colors.green[300]
                                      : Colors.red[300],
                                  size: 12.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        // "Details" chip — replaces the bare info-icon
                        // circle. Same tap target (28dp+ height) but
                        // self-labelled so the affordance is obvious.
                        GestureDetector(
                          onTap: () => widget.onShowDetails(cardArguments),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: Colors.white,
                                  size: 14.sp,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  'Details',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Balance sits in the optical center of the card.
                    // Spacer above + the existing Spacer between balance
                    // and the bottom row pushes the amount to roughly
                    // 40% from the top — feels visually centered while
                    // leaving room for the bottom "account no + buttons"
                    // strip and the top "label + chips" row.
                    const Spacer(),
                    // Animated balance counter — shows AVAILABLE balance on dashboard
                    // Long-press the balance to toggle the panic decoy (one of the
                    // two triggers; shake is the other). No-op until configured.
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onLongPress: _panic.longPressTriggerEnabled
                                ? () => _panic.toggle()
                                : null,
                            child: CompactAnimatedBalance(
                              balance: _displayBalance(account),
                              currencySymbol: currencySymbol,
                              fontSize: 28,
                              color: Colors.white,
                              duration: _panicRolling ? _kPanicRollDuration : const Duration(seconds: 3),
                              startDelay: _panicRolling ? Duration.zero : const Duration(milliseconds: 500),
                              enableSound: _panic.soundEnabled,
                              enableVibration: _panic.vibrationEnabled,
                              // Panic decoy shows instantly (no roll/countdown).
                              animate: _panicRolling || !_panic.isCamouflageOn,
                            ),
                          ),
                        ),
                        // Frozen badge — at the right end of the balance amount.
                        // Mirrors the accounts-service block (no outgoing
                        // transfers/payments) so the state is visible on the card.
                        if (account.isFrozen) ...[
                          SizedBox(width: 10.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 3.h),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.22),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.ac_unit,
                                    color: Colors.white, size: 11.sp),
                                SizedBox(width: 3.w),
                                Text(
                                  'Frozen',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                    // Stale balance indicator — shown while WebSocket update is animating
                    if (_animatingAccounts.contains(account.id))
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: Row(
                          children: [
                            // Tiny inline indicator — the WebSocket
                            // "Updating…" microspinner sits next to
                            // 10sp body text, so the loader is sized
                            // to read as a subtle dot rather than a
                            // dominant visual element on the card.
                            LazerVaultLoader(size: 4),
                            SizedBox(width: 4.w),
                            Text(
                              'Updating...',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.6),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    // Pending balance is intentionally NOT surfaced on
                    // the dashboard card anymore — held/clearing funds
                    // show up in the Pending tab inside the account
                    // details bottom sheet (opened via the "Details"
                    // chip at the top-right). Keeps the card compact
                    // for the common case where pending is zero.
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Masked account number — only the last 4 digits
                        // are visible on the dashboard. Full NUBAN is
                        // still in cardArguments['accountNumber'] for
                        // the Deposit / Withdraw flows where the
                        // unmasked value is required.
                        Text(
                          _maskAccountNumber(
                            cardArguments['accountNumber'] as String,
                          ),
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 14.sp,
                            // No letter-spacing — this is an account
                            // number, not a card PIN, so we want the
                            // bullets to read as one tight run.
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Row(
                          children: [
                            _buildActionButton(
                              "Deposit",
                              Icons.add_rounded,
                              onTap: () {
                                Get.toNamed(AppRoutes.depositFunds,
                                    arguments: {'selectedCard': cardArguments});
                              },
                            ),
                            SizedBox(width: 12.w),
                            _buildActionButton(
                              "Withdraw",
                              Icons.remove_rounded,
                              onTap: () => Get.toNamed(AppRoutes.withdrawFunds,
                                  arguments: {'selectedCard': cardArguments}),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton(String label, IconData icon,
      {required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 16.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarouselIndicators(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: _currentIndex == index ? 24.w : 8.w,
          height: 8.h,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            color: _currentIndex == index
                ? Colors.white
                : Colors.white.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ),
    );
  }

  Widget _buildFamilyAccountCard(BuildContext context, AccountSummaryEntity account) {
    final currencySymbol = _getCurrencySymbol(account.currency);
    // If it's a proper family entity, check its status. If it's a generic family
    // account (from regular accounts, isFamilyAccount==false), treat as pending setup.
    final isPendingSetup = account.isFamilyPendingSetup || !account.isFamilyAccount;

    return StreamBuilder<String?>(
      stream: _accountManager.accountIdStream,
      initialData: _accountManager.activeAccountId,
      builder: (context, snapshot) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1A1A3E),
                Color(0xFF2D2B6B),
              ],
            ),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1A1A3E).withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Stack(
              children: [
                // Background decorative circles
                Positioned(
                  right: -30,
                  top: -30,
                  child: Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.06),
                    ),
                  ),
                ),
                Positioned(
                  left: -20,
                  bottom: -40,
                  child: Container(
                    width: 100.w,
                    height: 100.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.04),
                    ),
                  ),
                ),
                // Main content
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.family_restroom,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                // Category label — the specific account name is
                                // shown as the subtitle below the balance.
                                'Family & Friends',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          if (!isPendingSetup)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFF7C6BF0).withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                '${account.memberCount ?? 0} members',
                                style: TextStyle(
                                  color: const Color(0xFFB8ABFF),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            )
                          else
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFF7C6BF0).withValues(alpha: 0.25),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                'NEW',
                                style: TextStyle(
                                  color: const Color(0xFFB8ABFF),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      if (isPendingSetup) ...[
                        Text(
                          'Share & Manage',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Money Together',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ] else ...[
                        // Group/family balance — shows the decoy when panic
                        // camouflage is on (long-press toggles), matching the
                        // standard card so no wallet leaks the real balance.
                        GestureDetector(
                          onLongPress: _panic.longPressTriggerEnabled
                              ? () => _panic.toggle()
                              : null,
                          child: CompactAnimatedBalance(
                            balance: _displayBalance(account),
                            currencySymbol: currencySymbol,
                            fontSize: 26,
                            color: Colors.white,
                            duration: _panicRolling ? _kPanicRollDuration : const Duration(seconds: 3),
                            startDelay: _panicRolling ? Duration.zero : const Duration(milliseconds: 500),
                            enableSound: _panic.soundEnabled,
                            enableVibration: _panic.vibrationEnabled,
                            // Panic decoy shows instantly (no roll/countdown).
                            animate: _panicRolling || !_panic.isCamouflageOn,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        if (_animatingAccounts.contains(account.id))
                          Row(
                            children: [
                              // Tiny inline indicator — the WebSocket
                            // "Updating…" microspinner sits next to
                            // 10sp body text, so the loader is sized
                            // to read as a subtle dot rather than a
                            // dominant visual element on the card.
                            LazerVaultLoader(size: 4),
                              SizedBox(width: 4.w),
                              Text(
                                'Updating...',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.6),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )
                        else
                          Text(
                            // The account's actual name (falls back to the
                            // generic label only when the account is unnamed).
                            (account.accountLabel?.trim().isNotEmpty ?? false)
                                ? account.accountLabel!.trim()
                                : 'Family Balance',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                      ],
                      const Spacer(),
                      if (isPendingSetup)
                        GestureDetector(
                          onTap: _isResolvingFamilyId
                              ? null
                              : () {
                                  if (account.familyAccountId == null) {
                                    _resolveFamilyIdAndNavigate(account);
                                  } else {
                                    final familyId = account.familyAccountId ?? account.id;
                                    Get.toNamed(AppRoutes.familyActivationSetup,
                                        arguments: {'familyId': familyId});
                                  }
                                },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _isResolvingFamilyId ? 'Loading...' : 'Get Started',
                                  style: TextStyle(
                                    color: const Color(0xFF1A1A3E),
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (!_isResolvingFamilyId) ...[
                                  SizedBox(width: 4.w),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    color: const Color(0xFF1A1A3E),
                                    size: 16.sp,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        )
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '•••• ${account.accountNumberLast4}',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.7),
                                fontSize: 12.sp,
                              ),
                            ),
                            _buildActionButton(
                              "Details",
                              Icons.arrow_forward_rounded,
                              onTap: () {
                                final familyId = account.familyAccountId ?? account.id;
                                Get.toNamed(AppRoutes.familyDetails,
                                    arguments: {'familyId': familyId});
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBusinessAccountCard(BuildContext context, AccountSummaryEntity account) {
    final currencySymbol = _getCurrencySymbol(account.currency);

    // selectedCard payload for the Deposit / Withdraw flows so they target the
    // BUSINESS account (mirrors the personal card's cardArguments). The full
    // NUBAN is required for deposits.
    final businessCard = {
      'id': account.id,
      'accountType': account.accountType,
      'currency': account.currency,
      'balance': _getAccountBalance(account),
      'availableBalance': _getAvailableBalance(account),
      'reservedBalance': account.reservedBalance,
      'accountNumber':
          account.accountNumber ?? '•••• ${account.accountNumberLast4}',
      'accountNumberMasked': '•••• ${account.accountNumberLast4}',
      'bankName': account.bankName ?? 'Wema Bank',
      'accountName': account.accountName ?? 'Lazervault Business',
    };

    return StreamBuilder<String?>(
      stream: _accountManager.accountIdStream,
      initialData: _accountManager.activeAccountId,
      builder: (context, snapshot) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            // Business identity uses a violet/purple gradient (like the referral
            // bonus card) — on-brand, distinct from the personal card, not blue
            // and not orange.
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF6D28D9), // violet-700
                Color(0xFF3B0764), // violet-950 (near-black)
              ],
            ),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6D28D9).withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Stack(
              children: [
                // Background decorative circles
                Positioned(
                  right: -30,
                  top: -30,
                  child: Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.06),
                    ),
                  ),
                ),
                Positioned(
                  left: -20,
                  bottom: -40,
                  child: Container(
                    width: 100.w,
                    height: 100.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.04),
                    ),
                  ),
                ),
                // Main content
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Identity — top-left; ellipsised so it never overflows.
                          Icon(Icons.business_center,
                              color: Colors.white.withValues(alpha: 0.9), size: 18.sp),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Text(
                              'Business',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          // PRO badge + Manage CTA — top-right.
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              'PRO',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          _buildActionButton(
                            "Manage",
                            Icons.dashboard_customize_rounded,
                            onTap: () => Get.toNamed(
                              AppRoutes.businessDashboard,
                              arguments: account,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      // Animated balance counter for business accounts — shows
                      // the decoy when panic camouflage is on (long-press toggles).
                      GestureDetector(
                        onLongPress: () => _panic.toggle(),
                        child: CompactAnimatedBalance(
                          balance: _displayBalance(account),
                          currencySymbol: currencySymbol,
                          fontSize: 26,
                          color: Colors.white,
                          duration: _panicRolling ? _kPanicRollDuration : const Duration(seconds: 3),
                          startDelay: _panicRolling ? Duration.zero : const Duration(milliseconds: 500),
                          // Panic decoy shows instantly (no roll/countdown).
                          animate: _panicRolling || !_panic.isCamouflageOn,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      if (_animatingAccounts.contains(account.id))
                        Row(
                          children: [
                            // Tiny inline indicator — the WebSocket
                            // "Updating…" microspinner sits next to
                            // 10sp body text, so the loader is sized
                            // to read as a subtle dot rather than a
                            // dominant visual element on the card.
                            LazerVaultLoader(size: 4),
                            SizedBox(width: 4.w),
                            Text(
                              'Updating...',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.6),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        )
                      else
                        Text(
                          'Business Balance',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            '•••• ${account.accountNumberLast4}',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 12.sp,
                            ),
                          ),
                          const Spacer(),
                          // Deposit / Withdraw target the BUSINESS account (like
                          // the personal card). Manage moved to the top-left.
                          _buildActionButton(
                            "Deposit",
                            Icons.add_rounded,
                            onTap: () => Get.toNamed(AppRoutes.depositFunds,
                                arguments: {'selectedCard': businessCard}),
                          ),
                          SizedBox(width: 8.w),
                          _buildActionButton(
                            "Withdraw",
                            Icons.remove_rounded,
                            onTap: () => Get.toNamed(AppRoutes.withdrawFunds,
                                arguments: {'selectedCard': businessCard}),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ── Trend-period picker ──────────────────────────────────────────────
  //
  // Opened by tapping the % chip at the top-right of any account card.
  // Lets the user pick the rolling window the percentage is calculated
  // against. Selection is persisted per-account in `_trendPeriodByAccount`
  // and triggers a fresh fetch of the trend so the new window's number
  // shows up immediately. The bottom sheet is dark + brand-purple to
  // match the rest of the app shell.
  void _openTrendPeriodPicker(AccountSummaryEntity account) {
    // Source of truth is the cubit's persisted period, so reopening the sheet
    // always reflects the currently-active selection.
    final current = _TrendPeriod.fromApi(_cubit.trendPeriod);
    showModalBottomSheet<_TrendPeriod>(
      context: context,
      // Match the dashboard account-card gradient so the sheet reads as
      // a natural extension of the chip the user tapped, not a generic
      // dark sheet (the previous #1F1F1F felt detached from the card).
      backgroundColor: const Color(0xFF3D2F8B),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Icon(Icons.trending_up,
                          color: Colors.white, size: 18.sp),
                      SizedBox(width: 10.w),
                      Text(
                        'Track change over…',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6.h),
                for (final option in _TrendPeriod.values)
                  ListTile(
                    onTap: () => Navigator.of(sheetContext).pop(option),
                    leading: Icon(
                      option == current
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: option == current
                          ? const Color(0xFF8B7BFF)
                          : Colors.white.withValues(alpha: 0.5),
                      size: 20.sp,
                    ),
                    title: Text(
                      option.label,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: option == current
                            ? FontWeight.w600
                            : FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      option.subtitle,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.55),
                        fontSize: 11.5.sp,
                      ),
                    ),
                  ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        );
      },
    ).then((picked) {
      if (picked == null || !mounted) return;
      setState(() {
        _trendPeriodByAccount[account.id] = picked;
      });
      // Refresh trends against the newly-chosen window. The period is passed to
      // the backend (GetUserAccounts.period) and persisted in the cubit so it
      // applies to every card and survives reopening the sheet.
      final authState = context.read<AuthenticationCubit>().state;
      if (authState is AuthenticationSuccess) {
        final userId = authState.profile.user.id;
        final accessToken = authState.profile.session.accessToken;
        _cubit.fetchAccountSummaries(
          userId: userId,
          accessToken: accessToken,
          period: picked.api,
        );
      }
    });
  }
}

/// Time windows offered in the trend-period picker. Order matters — the
/// bottom sheet renders them in declaration order.
enum _TrendPeriod {
  day('Last 24 hours', 'Day-on-day change', 'day'),
  week('Last 7 days', 'Week-on-week change', 'week'),
  month('Last 30 days', 'Month-on-month change', 'month'),
  year('Last 12 months', 'Year-on-year change', 'year');

  final String label;
  final String subtitle;
  // Backend period token sent to GetUserAccounts / persisted in the cubit.
  final String api;
  const _TrendPeriod(this.label, this.subtitle, this.api);

  static _TrendPeriod fromApi(String api) => _TrendPeriod.values
      .firstWhere((p) => p.api == api, orElse: () => _TrendPeriod.month);
}