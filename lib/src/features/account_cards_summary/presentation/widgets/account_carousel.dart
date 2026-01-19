import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';

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

  @override
  void initState() {
    super.initState();
    // Set the first account as active if none is selected
    _initializeActiveAccount();
  }

  Future<void> _initializeActiveAccount() async {
    if (!_accountManager.hasActiveAccount && widget.accountSummaries.isNotEmpty) {
      // Set the first account as active by default
      await _accountManager.setActiveAccount(widget.accountSummaries.first.id);
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
      _accountManager.setActiveAccount(newAccountId).catchError((e) {
        // Silently fail - don't show snackbar on carousel swipe
        print('Failed to update active account: $e');
      });
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
     if (widget.accountSummaries.isEmpty && !widget.showFamilySetupCard) {
        return SizedBox(
          height: 228.h,
          child: const Center(
              child: Text('No accounts found.', style: TextStyle(color: Colors.white))),
        );
     }

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _totalItemCount,
          options: CarouselOptions(
            height: 200.h,
            viewportFraction: 0.9,
            enlargeCenterPage: true,
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
    );
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
    final cardArguments = {
      'id': account.id,
      'accountType': account.accountType,
      'currency': account.currency,
      'balance': account.balance,
      'accountNumber': '•••• ${account.accountNumberLast4}',
      'trend': '${account.trendPercentage > 0 ? '+' : ''}${account.trendPercentage.toStringAsFixed(1)}%',
      'isUp': isUp,
    };

    // Wrap with StreamBuilder to reactively show active account indicator
    return StreamBuilder<String?>(
      stream: _accountManager.accountIdStream,
      initialData: _accountManager.activeAccountId,
      builder: (context, snapshot) {
        final isActiveAccount = snapshot.data == account.id;

        return Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.15),
                    Colors.white.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
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
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: isUp
                              ? Colors.green.withOpacity(0.2)
                              : Colors.red.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          cardArguments['trend'] as String,
                          style: TextStyle(
                            color: isUp ? Colors.green[300] : Colors.red[300],
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        // Use the callback passed from the parent
                        onTap: () => widget.onShowDetails(cardArguments),
                        child: Container(
                          width: 32.w,
                          height: 32.h,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.info_outline,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 20.h),
                Text(
                    "${account.currency}${account.balance.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cardArguments['accountNumber'] as String,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
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
            color: Colors.white.withOpacity(0.1),
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
                : Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ),
    );
  }

  Widget _buildFamilySetupCard(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.familySetup),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF6C5CE7).withOpacity(0.2),
              const Color(0xFFA29BFE).withOpacity(0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: const Color(0xFF6C5CE7).withOpacity(0.5),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6C5CE7).withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
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
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Family & Friends',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C5CE7).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'NEW',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              'Share & Manage',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Money Together',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
                ),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 16.sp,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFamilyAccountCard(BuildContext context, AccountSummaryEntity account) {
    // Build a simplified family account card using AccountSummaryEntity data
    // TODO: Replace with full FamilyAccountCard widget when FamilyAccountCubit is integrated
    return StreamBuilder<String?>(
      stream: _accountManager.accountIdStream,
      initialData: _accountManager.activeAccountId,
      builder: (context, snapshot) {
        final isActiveAccount = snapshot.data == account.id;

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF6C5CE7).withOpacity(0.15),
                const Color(0xFFA29BFE).withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: const Color(0xFF6C5CE7).withOpacity(0.5),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6C5CE7).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.family_restroom,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Family & Friends',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          account.accountType,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  if (account.memberCount != null && account.memberCount! > 0)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.people,
                            color: Colors.purple[200],
                            size: 16.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${account.memberCount}',
                            style: TextStyle(
                              color: Colors.purple[200],
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                '\$${account.familyTotalBalance?.toStringAsFixed(2) ?? account.balance.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Total Family Balance',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              if (account.memberRemainingBalance != null) ...[
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Share',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Text(
                            '\$${account.memberAllocatedBalance?.toStringAsFixed(2) ?? "0.00"}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            '|',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            '\$${account.memberRemainingBalance?.toStringAsFixed(2) ?? "0.00"}',
                            style: TextStyle(
                              color: Colors.green[300],
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Remaining',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '•••• ${account.accountNumberLast4}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14.sp,
                    ),
                  ),
                  Row(
                    children: [
                      _buildActionButton(
                        "Manage",
                        Icons.settings_rounded,
                        onTap: () {
                          // Navigate to family account details
                          Get.toNamed(AppRoutes.familyDetails, arguments: {'familyId': account.id});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
} 