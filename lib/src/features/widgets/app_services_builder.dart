import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/dashboard_state_manager.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/widgets/app_service_builder.dart';
import 'package:lazervault/src/features/widgets/all_services_bottom_sheet.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_cubit.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_state.dart';
import 'package:get/get.dart';

// Quick Services carousel - 3 rows with reduced indicator spacing
// Context-aware: switches between personal and business services based on active account
class AppServicesBuilder extends StatefulWidget {
  const AppServicesBuilder({super.key});

  @override
  State<AppServicesBuilder> createState() => _AppServicesBuilderState();
}

class _AppServicesBuilderState extends State<AppServicesBuilder> {
  late int _currentIndex;
  final DashboardStateManager _stateManager = serviceLocator<DashboardStateManager>();
  final AccountManager _accountManager = serviceLocator<AccountManager>();
  StreamSubscription<String?>? _accountSubscription;
  bool _isBusinessAccount = false;
  bool _isFamilyAccount = false;
  bool _isFamilyPendingSetup = false;
  String? _activeFamilyAccountId;
  bool _isResolvingFamilyId = false;

  static const int _itemsPerRow = 4;
  static const int _maxRows = 3;
  static const int _itemsPerPage = _itemsPerRow * _maxRows; // 12 items per page

  // Personal services (existing 19 services)
  static const List<AppService> _personalServices = [
    AppService(
        serviceName: AppServiceName.sendFunds,
        serviceImg: AppServiceImg.sendFunds),
    AppService(
        serviceName: AppServiceName.batchTransfer,
        serviceImg: AppServiceImg.batchTransfer),
    AppService(
        serviceName: AppServiceName.tagPay,
        serviceImg: AppServiceImg.tagPay),
    AppService(
        serviceName: AppServiceName.invoice,
        serviceImg: AppServiceImg.invoice),
    AppService(
        serviceName: AppServiceName.payBills,
        serviceImg: AppServiceImg.payBills),
    AppService(
        serviceName: AppServiceName.invest,
        serviceImg: AppServiceImg.invest),
    AppService(
        serviceName: AppServiceName.exchange,
        serviceImg: AppServiceImg.exchange),
    AppService(
        serviceName: AppServiceName.crypto,
        serviceImg: AppServiceImg.crypto),
    AppService(
        serviceName: AppServiceName.giftCards,
        serviceImg: AppServiceImg.giftCards),
    AppService(
        serviceName: AppServiceName.aiScanToPay,
        serviceImg: AppServiceImg.aiScanToPay),
    AppService(
        serviceName: AppServiceName.qrPay,
        serviceImg: AppServiceImg.qrPay),
    AppService(
        serviceName: AppServiceName.contactlessPay,
        serviceImg: AppServiceImg.contactlessPay),
    AppService(
        serviceName: AppServiceName.groupAccount,
        serviceImg: AppServiceImg.groupAccount),
    AppService(
        serviceName: AppServiceName.insurance,
        serviceImg: AppServiceImg.insurance),
    AppService(
        serviceName: AppServiceName.airtime,
        serviceImg: AppServiceImg.airtime),
    AppService(
        serviceName: AppServiceName.autoSave,
        serviceImg: AppServiceImg.autoSave),
    AppService(
        serviceName: AppServiceName.crowdfund,
        serviceImg: AppServiceImg.crowdfund),
    AppService(
        serviceName: AppServiceName.lockFunds,
        serviceImg: AppServiceImg.lockFunds),
    AppService(
        serviceName: AppServiceName.whatsappIntegration,
        serviceImg: AppServiceImg.whatsappIntegration),
    AppService(
        serviceName: AppServiceName.idPay,
        serviceImg: AppServiceImg.idPay),
  ];

  // Business services (shown when Business card is active)
  static const List<AppService> _businessServices = [
    AppService(
        serviceName: AppServiceName.businessDashboard,
        serviceImg: AppServiceImg.businessDashboard),
    AppService(
        serviceName: AppServiceName.businessAnalytics,
        serviceImg: AppServiceImg.businessAnalytics),
    AppService(
        serviceName: AppServiceName.payroll,
        serviceImg: AppServiceImg.payroll),
    AppService(
        serviceName: AppServiceName.invoice,
        serviceImg: AppServiceImg.invoice),
    AppService(
        serviceName: AppServiceName.customers,
        serviceImg: AppServiceImg.customers),
    AppService(
        serviceName: AppServiceName.expenses,
        serviceImg: AppServiceImg.expenses),
    AppService(
        serviceName: AppServiceName.batchTransfer,
        serviceImg: AppServiceImg.batchTransfer),
    AppService(
        serviceName: AppServiceName.sendFunds,
        serviceImg: AppServiceImg.sendFunds),
  ];

  List<AppService> get _activeServices {
    if (_isBusinessAccount) return _businessServices;
    return _personalServices;
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = _stateManager.servicesCarouselIndex;
    _checkActiveAccountType();
    _accountSubscription = _accountManager.accountIdStream.listen((_) {
      _checkActiveAccountType();
    });
  }

  @override
  void dispose() {
    _accountSubscription?.cancel();
    super.dispose();
  }

  void _checkActiveAccountType() {
    final activeId = _accountManager.activeAccountId;
    if (activeId == null) return;

    // Look up the account type from the AccountCardsSummaryCubit state
    try {
      final cubitState = context.read<AccountCardsSummaryCubit>().state;
      if (cubitState is AccountCardsSummaryLoaded) {
        final activeAccount = cubitState.accountSummaries.firstWhere(
          (a) => a.id == activeId,
          orElse: () => cubitState.accountSummaries.first,
        );
        final isBusiness =
            activeAccount.accountTypeEnum == VirtualAccountType.business;
        final isFamily =
            activeAccount.accountTypeEnum == VirtualAccountType.family;
        final isFamilyPending = isFamily &&
            (activeAccount.isFamilyPendingSetup || !activeAccount.isFamilyAccount);
        final familyId = isFamily ? activeAccount.familyAccountId : null;

        if (isBusiness != _isBusinessAccount ||
            isFamily != _isFamilyAccount ||
            isFamilyPending != _isFamilyPendingSetup) {
          setState(() {
            _isBusinessAccount = isBusiness;
            _isFamilyAccount = isFamily;
            _isFamilyPendingSetup = isFamilyPending;
            _activeFamilyAccountId = familyId;
            _currentIndex = 0; // Reset carousel position on account type switch
          });
        }
      }
    } catch (_) {
      // BlocProvider not available yet, keep current state
    }
  }

  // Split services into pages
  List<List<AppService>> _getServicePages() {
    final services = _activeServices;
    List<List<AppService>> pages = [];
    for (int i = 0; i < services.length; i += _itemsPerPage) {
      int end = (i + _itemsPerPage < services.length)
          ? i + _itemsPerPage
          : services.length;
      pages.add(services.sublist(i, end));
    }
    return pages;
  }

  // Calculate carousel height based on grid content
  double _calculateCarouselHeight(BuildContext context) {
    final services = _activeServices;
    final screenWidth = MediaQuery.of(context).size.width;
    final containerHorizontalPadding = 16.w * 2;
    final availableWidth = screenWidth - containerHorizontalPadding;

    const crossAxisSpacing = 8.0;
    const mainAxisSpacing = 8.0;
    const childAspectRatio = 0.85;

    final itemWidth = (availableWidth - (crossAxisSpacing.w * (_itemsPerRow - 1))) / _itemsPerRow;
    final itemHeight = itemWidth / childAspectRatio;

    // Calculate actual rows needed (may be less than _maxRows for business services)
    final itemsOnFirstPage = services.length > _itemsPerPage ? _itemsPerPage : services.length;
    final actualRows = (itemsOnFirstPage / _itemsPerRow).ceil().clamp(1, _maxRows);

    final totalHeight = (itemHeight * actualRows) + (mainAxisSpacing.h * (actualRows - 1));
    return totalHeight;
  }

  @override
  Widget build(BuildContext context) {
    // Show family setup CTA when active account is a pending family account
    if (_isFamilyAccount && _isFamilyPendingSetup) {
      return _buildFamilySetupCTA();
    }

    final servicePages = _getServicePages();
    final carouselHeight = _calculateCarouselHeight(context);
    final activeServices = _activeServices;
    final accentColor = _isBusinessAccount
        ? const Color(0xFF3B82F6) // Blue for business
        : (_isFamilyAccount
            ? const Color(0xFF2D6B6B) // Teal for family
            : const Color.fromARGB(255, 78, 3, 208)); // Purple for personal

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    _isBusinessAccount
                        ? "Business Services"
                        : (_isFamilyAccount ? "Family Services" : "Quick Services"),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: accentColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                  if (_isBusinessAccount) ...[
                    SizedBox(width: 6.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        'PRO',
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w800,
                          color: accentColor,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              if (!_isBusinessAccount)
                GestureDetector(
                  onTap: () => showAllServicesBottomSheet(context, activeServices),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: accentColor,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 14.sp,
                          color: accentColor,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),

          // Services Carousel
          CarouselSlider.builder(
            itemCount: servicePages.length,
            options: CarouselOptions(
              height: carouselHeight, // Dynamic height based on content
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              enableInfiniteScroll: false,
              initialPage: _currentIndex,
              onPageChanged: (index, reason) {
                setState(() => _currentIndex = index);
                // Persist carousel position for navigation restoration
                _stateManager.setServicesCarouselIndex(index);
              },
            ),
            itemBuilder: (context, pageIndex, realIndex) {
              final servicesOnPage = servicePages[pageIndex];

              return GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _itemsPerRow,
                  crossAxisSpacing: 8.w,
                  mainAxisSpacing: 8.h,
                  childAspectRatio: 0.85,
                ),
                itemCount: servicesOnPage.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return AppServiceBuilder(appService: servicesOnPage[index]);
                },
              );
            },
          ),

          // Carousel Indicators (only show if more than 1 page)
          if (servicePages.length > 1) ...[
            SizedBox(height: 3.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                servicePages.length,
                (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: _currentIndex == index ? 24.w : 8.w,
                  height: 8.h,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? accentColor
                        : accentColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFamilySetupCTA() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A4747), Color(0xFF2D6B6B)],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A4747).withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.family_restroom,
            color: Colors.white.withValues(alpha: 0.9),
            size: 48.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'Complete Your Family Account Setup',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'Add members and configure how funds are distributed among your family.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 13.sp,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: _isResolvingFamilyId ? null : () async {
                if (_activeFamilyAccountId != null) {
                  Get.toNamed(AppRoutes.familyActivationSetup,
                      arguments: {'familyId': _activeFamilyAccountId});
                } else {
                  // familyAccountId unknown — resolve via GetFamilyAccounts
                  setState(() => _isResolvingFamilyId = true);
                  try {
                    final familyCubit = serviceLocator<FamilyAccountCubit>();
                    await familyCubit.loadFamilyAccounts();
                    final state = familyCubit.state;
                    if (state is FamilyAccountsLoaded && state.familyAccounts.isNotEmpty) {
                      final target = state.familyAccounts.firstWhere(
                        (a) => a.isPendingSetup,
                        orElse: () => state.familyAccounts.first,
                      );
                      Get.toNamed(AppRoutes.familyActivationSetup,
                          arguments: {'familyId': target.id});
                    } else {
                      Get.snackbar(
                        'Error',
                        'Could not find your family account. Please try again.',
                        backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                      );
                    }
                  } catch (_) {
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
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF1A4747),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
                elevation: 0,
              ),
              child: _isResolvingFamilyId
                  ? SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color(0xFF1A4747),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings_rounded, size: 18.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'Setup Now',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
