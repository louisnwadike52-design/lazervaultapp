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
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/profile/cubit/profile_state.dart';

// Type definition for the callback when a card's details are requested
typedef OnShowDetailsCallback = void Function(Map<String, dynamic> accountArgs);

class AccountCarousel extends StatefulWidget {
  final List<AccountSummaryEntity> accountSummaries;
  final OnShowDetailsCallback onShowDetails; // Callback to show bottom sheet
  final bool showFamilySetupCard; // Whether to show the family setup card in carousel

  const AccountCarousel({
    super.key,
    required this.accountSummaries,
    required this.onShowDetails,
    this.showFamilySetupCard = false,
  });

  @override
  State<AccountCarousel> createState() => _AccountCarouselState();
}

class _AccountCarouselState extends State<AccountCarousel> {
  int _currentIndex = 0;
  final AccountManager _accountManager = serviceLocator<AccountManager>();

  // Track real-time balance updates per account
  final Map<String, double> _realtimeBalances = {};

  // Pending balance updates to apply when dashboard becomes visible
  final Map<String, double> _pendingBalanceUpdates = {};
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
    // Initialize carousel to show the active account if one is selected
    _initializeCarouselPosition();
    // Set the first account as active if none is selected
    _initializeActiveAccount();
    // Check if there's a recent WebSocket balance update we missed
    // (e.g., when navigating back to dashboard via Get.offAllNamed after a transfer)
    // Only apply if the event is recent (within 30 seconds) to avoid stale updates
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      final wsState = context.read<BalanceWebSocketCubit>().state;
      if (wsState.lastUpdate != null) {
        final eventAge = DateTime.now().millisecondsSinceEpoch - wsState.lastUpdate!.timestamp;
        // Only apply if event occurred within last 30 seconds (30000ms)
        if (eventAge < 30000 && eventAge > 0) {
          _handleBalanceUpdate(wsState.lastUpdate!);
        } else {
          debugPrint('AccountCarousel: Skipping stale WebSocket event (age: ${eventAge}ms)');
        }
      }
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

  // Calculate total item count including optional family setup card
  int get _totalItemCount {
    int count = widget.accountSummaries.length;
    if (widget.showFamilySetupCard) count++;
    return count;
  }

  @override
  Widget build(BuildContext context) {
     // Apply any buffered balance updates now that we're building (visible)
     if (_pendingBalanceUpdates.isNotEmpty) {
       WidgetsBinding.instance.addPostFrameCallback((_) {
         _applyPendingUpdates();
       });
     }

     if (widget.accountSummaries.isEmpty && !widget.showFamilySetupCard) {
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
              // If showing family setup card and this is the last index
              if (widget.showFamilySetupCard && index == widget.accountSummaries.length) {
                return _buildFamilySetupCard(context);
              }
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
    // Find the account that matches this update
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
    } else {
      // Dashboard is not visible — buffer the update for later
      _pendingBalanceUpdates[accountId] = newBalance;
      debugPrint('AccountCarousel: Buffered balance update for account $accountId (dashboard not visible)');
    }

    // Log the update for debugging
    debugPrint('AccountCarousel: Real-time balance update for account $accountId: $newBalance (${event.eventType})');
  }

  /// Apply any pending balance updates when dashboard becomes visible
  void _applyPendingUpdates() {
    if (_pendingBalanceUpdates.isNotEmpty && mounted) {
      setState(() {
        _realtimeBalances.addAll(_pendingBalanceUpdates);
        _pendingBalanceUpdates.clear();
      });
      debugPrint('AccountCarousel: Applied pending balance updates');
    }
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

  Widget _buildAccountCard(BuildContext context, AccountSummaryEntity account) {
    // Check if this is a family account
    if (account.isFamilyAccount) {
      // For family accounts, we would need the full FamilyAccount and FamilyMember data
      // For now, show the standard card but indicate it's a family account
      // TODO: Integrate with FamilyAccountCubit to get full data
      return _buildFamilyAccountCard(context, account);
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

  void _refreshAccountSummaries(BuildContext context) {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      final userId = authState.profile.user.id;
      final accessToken = authState.profile.session.accessToken;

      // Get active country from ProfileCubit
      final profileState = context.read<ProfileCubit>().state;
      String? activeCountry;
      if (profileState is ProfileLoaded) {
        activeCountry = profileState.preferences.activeCountry.isNotEmpty
            ? profileState.preferences.activeCountry
            : null;
      }

      // Refresh account summaries
      context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
            userId: userId,
            accessToken: accessToken,
            country: activeCountry,
          );
    }
  }

  Widget _buildFamilySetupCard(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await Get.toNamed(AppRoutes.familySetup);
        // Refresh account summaries if family was created
        if (result == true && context.mounted) {
          _refreshAccountSummaries(context);
        }
      },
      child: Container(
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
                left: -20,
                bottom: -40,
                child: Container(
                  width: 100.w,
                  height: 100.w,
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
                        Row(
                          children: [
                            Icon(
                              Icons.family_restroom,
                              color: Colors.white,
                              size: 18.sp,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              'Family & Friends',
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
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          'NEW',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Share & Manage',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Money Together',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Get Started',
                          style: TextStyle(
                            color: const Color(0xFF6C5CE7),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Icon(
                          Icons.arrow_forward,
                          color: const Color(0xFF6C5CE7),
                          size: 14.sp,
                        ),
                      ],
                    ),
                  ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFamilyAccountCard(BuildContext context, AccountSummaryEntity account) {
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
                  left: -20,
                  bottom: -40,
                  child: Container(
                    width: 100.w,
                    height: 100.w,
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
                          Row(
                            children: [
                              Icon(
                                Icons.family_restroom,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                'Family & Friends',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        if (account.memberCount != null && account.memberCount! > 0)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.people,
                                  color: Colors.white,
                                  size: 14.sp,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  '${account.memberCount}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    // Animated balance counter for family accounts
                    CompactAnimatedBalance(
                      balance: account.familyTotalBalance ?? _getAccountBalance(account),
                      currencySymbol: currencySymbol,
                      fontSize: 26,
                      color: Colors.white,
                      duration: const Duration(seconds: 3),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Total Family Balance',
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
                          "Manage",
                          Icons.settings_rounded,
                          onTap: () {
                            Get.toNamed(AppRoutes.familyDetails, arguments: {'familyId': account.id});
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