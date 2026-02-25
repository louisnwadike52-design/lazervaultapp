import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/balance_websocket_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/services/balance_websocket_service.dart';
import 'package:lazervault/src/features/account_cards_summary/presentation/widgets/animated_balance_counter.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_cubit.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_state.dart';

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

  // Store cubit reference early to avoid context.read() in delayed callbacks
  // (accessing context after Element is defunct causes crashes)
  late final AccountCardsSummaryCubit _cubit;

  // Track real-time balance updates per account
  final Map<String, double> _realtimeBalances = {};

  // Pending balance updates to apply when dashboard becomes visible (from→to for two-phase animation)
  final Map<String, ({double from, double to})> _pendingBalanceUpdates = {};

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
          }
        });

        // After animation completes (~3s duration), consume the update so entities reflect reality
        Future.delayed(const Duration(seconds: 3), () {
          if (!mounted) return;
          _cubit.markBalanceUpdateConsumed();
        });
      });
    });
  }

  /// Initialize carousel position to show the currently active account
  void _initializeCarouselPosition() {
    if (_accountManager.hasActiveAccount && widget.accountSummaries.isNotEmpty) {
      final activeId = _accountManager.activeAccountId;
      final index = widget.accountSummaries.indexWhere((a) => a.id == activeId);
      if (index >= 0) {
        _currentIndex = index;
      }
    }
  }

  Future<void> _initializeActiveAccount() async {
    if (!_accountManager.hasActiveAccount && widget.accountSummaries.isNotEmpty) {
      // Set the first account as active by default
      _accountManager.setActiveAccount(widget.accountSummaries.first.id);
    }
  }

  /// Called when user swipes the carousel - automatically sets active account
  void _onPageChanged(int index, CarouselPageChangedReason reason) {
    setState(() {
      _currentIndex = index;
    });

    // Automatically set the visible account as active
    if (widget.accountSummaries.isNotEmpty && index < widget.accountSummaries.length) {
      final newAccountId = widget.accountSummaries[index].id;
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
          child: const Center(
              child: Text('No accounts found.', style: TextStyle(color: Colors.white))),
        );
     }

    // Wrap with BlocListener to handle real-time balance updates
    return BlocListener<BalanceWebSocketCubit, BalanceWebSocketState>(
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
              height: 200.h,
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

    // Check if dashboard is the current visible route
    final isVisible = ModalRoute.of(context)?.isCurrent ?? false;

    if (isVisible) {
      // Dashboard is visible — apply balance update immediately (triggers animation)
      setState(() {
        _realtimeBalances[accountId] = newBalance;
      });

      // After animation completes (~3s), consume so entities reflect the new balance
      Future.delayed(const Duration(seconds: 3), () {
        if (!mounted) return;
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
        }
      });

      // After animation completes, consume so entities reflect reality
      Future.delayed(const Duration(seconds: 3), () {
        if (!mounted) return;
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

  /// Resolves the family account ID by calling GetFamilyAccounts, then navigates to setup.
  /// If no family account record exists yet, auto-creates one first.
  Future<void> _resolveFamilyIdAndNavigate(AccountSummaryEntity account) async {
    setState(() => _isResolvingFamilyId = true);
    try {
      final familyCubit = serviceLocator<FamilyAccountCubit>();
      await familyCubit.loadFamilyAccounts();
      final state = familyCubit.state;
      if (state is FamilyAccountsLoaded && state.familyAccounts.isNotEmpty) {
        // Find the first pending_setup account (or first account)
        final target = state.familyAccounts.firstWhere(
          (a) => a.isPendingSetup,
          orElse: () => state.familyAccounts.first,
        );
        Get.toNamed(AppRoutes.familyActivationSetup,
            arguments: {'familyId': target.id});
      } else {
        // No family_accounts record exists — auto-create one for the user.
        // The virtual NUBAN account (type "family") already exists from signup,
        // but the family_accounts table record was never created.
        await familyCubit.createAccount(
          name: 'Family & Friends',
          initialCurrency: account.currency,
          initialFunding: 0.0,
          allowMemberContributions: true,
        );
        final createState = familyCubit.state;
        if (createState is FamilyAccountCreated) {
          Get.toNamed(AppRoutes.familyActivationSetup,
              arguments: {'familyId': createState.familyAccount.id});
        } else if (createState is FamilyAccountError) {
          Get.snackbar(
            'Error',
            createState.message,
            backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
        }
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

    final cardArguments = {
      'id': account.id,
      'accountType': account.accountType,
      'currency': account.currency,
      'balance': currentBalance,
      'accountNumber': account.accountNumber ?? '•••• ${account.accountNumberLast4}', // Full NUBAN for deposits
      'accountNumberMasked': '•••• ${account.accountNumberLast4}',
      'bankName': account.bankName ?? 'Wema Bank', // Partner bank name
      'accountName': account.accountName ?? 'LazerVault Account', // Account holder name
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
                Color(0xFF6C5CE7),
                Color(0xFF4834D4),
              ],
            ),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6C5CE7).withValues(alpha: 0.3),
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
                            child: Text(
                              "${account.accountType} Account",
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        Container(
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
                          child: Text(
                            cardArguments['trend'] as String,
                            style: TextStyle(
                              color: isUp ? Colors.green[300] : Colors.red[300],
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                        GestureDetector(
                          onTap: () => widget.onShowDetails(cardArguments),
                          child: Container(
                            width: 28.w,
                            height: 28.h,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.info_outline,
                              color: Colors.white,
                              size: 16.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    // Animated balance counter for smooth transitions
                    CompactAnimatedBalance(
                      balance: _getAccountBalance(account),
                      currencySymbol: currencySymbol,
                      fontSize: 28,
                      color: Colors.white,
                      duration: const Duration(seconds: 3),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          cardArguments['accountNumber'] as String,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 14.sp,
                          ),
                        ),
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
                Color(0xFF1A4747),
                Color(0xFF2D6B6B),
              ],
            ),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1A4747).withValues(alpha: 0.3),
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
                                account.accountLabel ?? 'Family & Friends',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: isPendingSetup
                                  ? const Color(0xFFFB923C).withValues(alpha: 0.3)
                                  : const Color(0xFF10B981).withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              isPendingSetup
                                  ? 'SETUP'
                                  : '${account.memberCount ?? 0} members',
                              style: TextStyle(
                                color: isPendingSetup
                                    ? const Color(0xFFFB923C)
                                    : const Color(0xFF10B981),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w800,
                                letterSpacing: isPendingSetup ? 1.2 : 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      if (isPendingSetup) ...[
                        Text(
                          'Tap to complete setup',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Configure how funds are distributed',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 12.sp,
                          ),
                        ),
                      ] else ...[
                        CompactAnimatedBalance(
                          balance: _getAccountBalance(account),
                          currencySymbol: currencySymbol,
                          fontSize: 26,
                          color: Colors.white,
                          duration: const Duration(seconds: 3),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Family Balance',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                      const Spacer(),
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
                            _isResolvingFamilyId
                                ? "Loading..."
                                : (isPendingSetup ? "Setup" : "Details"),
                            isPendingSetup ? Icons.settings_rounded : Icons.arrow_forward_rounded,
                            onTap: _isResolvingFamilyId
                                ? () {}
                                : () {
                                    if (isPendingSetup && account.familyAccountId == null) {
                                      // familyAccountId is null (fallback path) — resolve via GetFamilyAccounts
                                      // or auto-create if no family account record exists
                                      _resolveFamilyIdAndNavigate(account);
                                    } else {
                                      final familyId = account.familyAccountId ?? account.id;
                                      if (isPendingSetup) {
                                        Get.toNamed(AppRoutes.familyActivationSetup,
                                            arguments: {'familyId': familyId});
                                      } else {
                                        Get.toNamed(AppRoutes.familyDetails,
                                            arguments: {'familyId': familyId});
                                      }
                                    }
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
                Color(0xFF0F2647),
                Color(0xFF1B3A6B),
              ],
            ),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0F2647).withValues(alpha: 0.3),
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
                                Icons.business_center,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                'LazerVault Business',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
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
                        ],
                      ),
                      SizedBox(height: 12.h),
                      // Animated balance counter for business accounts
                      CompactAnimatedBalance(
                        balance: _getAccountBalance(account),
                        currencySymbol: currencySymbol,
                        fontSize: 26,
                        color: Colors.white,
                        duration: const Duration(seconds: 3),
                      ),
                      SizedBox(height: 2.h),
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
                            "Dashboard",
                            Icons.dashboard_rounded,
                            onTap: () {
                              Get.toNamed(AppRoutes.businessDashboard);
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

}