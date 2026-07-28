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
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/widgets/app_service_builder.dart';
import 'package:lazervault/src/features/widgets/all_services_bottom_sheet.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_cubit.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_state.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

// Quick Services carousel - 3 rows with reduced indicator spacing
// Context-aware: switches between personal and business services based on active account
class AppServicesBuilder extends StatefulWidget {
  const AppServicesBuilder({super.key});

  /// Every platform service across all account types (deduped) — the corpus the
  /// dashboard swipe-down search filters over. Public forwarder to the State's
  /// static list (same library).
  static List<AppService> getAllServices() =>
      _AppServicesBuilderState.getAllServices();

  @override
  State<AppServicesBuilder> createState() => _AppServicesBuilderState();
}

class _AppServicesBuilderState extends State<AppServicesBuilder> {
  late int _currentIndex;
  final DashboardStateManager _stateManager = serviceLocator<DashboardStateManager>();
  final AccountManager _accountManager = serviceLocator<AccountManager>();
  StreamSubscription<String?>? _accountSubscription;
  VirtualAccountType? _activeAccountType;
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
        serviceName: AppServiceName.escrow,
        serviceImg: AppServiceImg.escrow),
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
        serviceName: AppServiceName.rmb,
        serviceImg: AppServiceImg.rmb),
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
        serviceName: AppServiceName.uplift,
        serviceImg: AppServiceImg.uplift),
    AppService(
        serviceName: AppServiceName.lockFunds,
        serviceImg: AppServiceImg.lockFunds),
    AppService(
        serviceName: AppServiceName.whatsappIntegration,
        serviceImg: AppServiceImg.whatsappIntegration),
    AppService(
        serviceName: AppServiceName.phoneBanking,
        serviceImg: AppServiceImg.phoneBanking),
    AppService(
        serviceName: AppServiceName.idPay,
        serviceImg: AppServiceImg.idPay),
  ];

  // Business services (shown when Business card is active).
  // NOTE: the "Dashboard" tile was removed — it duplicated services already on
  // this grid. The Business card's CTA now opens the account-details sheet.
  static const List<AppService> _businessServices = [
    AppService(
        serviceName: AppServiceName.businessAnalytics,
        serviceImg: AppServiceImg.businessAnalytics),
    // Sell — the revenue engine (record a sale → credits the business balance,
    // decrements stock, optionally links a customer + issues an invoice). Also
    // reachable from the business dashboard quick actions; surfaced here so the
    // core money-in action is one tap from the Business card.
    AppService(
        serviceName: AppServiceName.sales, serviceImg: AppServiceImg.sales),
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
        serviceName: AppServiceName.inventory,
        serviceImg: AppServiceImg.inventory),
    AppService(
        serviceName: AppServiceName.tax,
        serviceImg: AppServiceImg.tax),
    AppService(
        serviceName: AppServiceName.batchTransfer,
        serviceImg: AppServiceImg.batchTransfer),
    AppService(
        serviceName: AppServiceName.sendFunds,
        serviceImg: AppServiceImg.sendFunds),
  ];

  // Savings account services (8 services — 1 page)
  static const List<AppService> _savingsServices = [
    AppService(
        serviceName: AppServiceName.sendFunds,
        serviceImg: AppServiceImg.sendFunds),
    AppService(
        serviceName: AppServiceName.autoSave,
        serviceImg: AppServiceImg.autoSave),
    AppService(
        serviceName: AppServiceName.lockFunds,
        serviceImg: AppServiceImg.lockFunds),
    AppService(
        serviceName: AppServiceName.payBills,
        serviceImg: AppServiceImg.payBills),
    AppService(
        serviceName: AppServiceName.insurance,
        serviceImg: AppServiceImg.insurance),
    AppService(
        serviceName: AppServiceName.exchange,
        serviceImg: AppServiceImg.exchange),
    AppService(
        serviceName: AppServiceName.crowdfund,
        serviceImg: AppServiceImg.crowdfund),
    AppService(
        serviceName: AppServiceName.airtime,
        serviceImg: AppServiceImg.airtime),
  ];

  // Investment account services (7 services — 1 page)
  static const List<AppService> _investmentServices = [
    AppService(
        serviceName: AppServiceName.invest,
        serviceImg: AppServiceImg.invest),
    AppService(
        serviceName: AppServiceName.stocks,
        serviceImg: AppServiceImg.stocks),
    AppService(
        serviceName: AppServiceName.crypto,
        serviceImg: AppServiceImg.crypto),
    AppService(
        serviceName: AppServiceName.rmb,
        serviceImg: AppServiceImg.rmb),
    AppService(
        serviceName: AppServiceName.exchange,
        serviceImg: AppServiceImg.exchange),
    AppService(
        serviceName: AppServiceName.sendFunds,
        serviceImg: AppServiceImg.sendFunds),
    AppService(
        serviceName: AppServiceName.autoSave,
        serviceImg: AppServiceImg.autoSave),
    AppService(
        serviceName: AppServiceName.lockFunds,
        serviceImg: AppServiceImg.lockFunds),
  ];

  // Multi-currency wallet services — USD/GBP/EUR (8 services — 1 page)
  static const List<AppService> _multiCurrencyServices = [
    AppService(
        serviceName: AppServiceName.sendFunds,
        serviceImg: AppServiceImg.sendFunds),
    AppService(
        serviceName: AppServiceName.exchange,
        serviceImg: AppServiceImg.exchange),
    AppService(
        serviceName: AppServiceName.batchTransfer,
        serviceImg: AppServiceImg.batchTransfer),
    AppService(
        serviceName: AppServiceName.payBills,
        serviceImg: AppServiceImg.payBills),
    AppService(
        serviceName: AppServiceName.invoice,
        serviceImg: AppServiceImg.invoice),
    AppService(
        serviceName: AppServiceName.qrPay,
        serviceImg: AppServiceImg.qrPay),
    AppService(
        serviceName: AppServiceName.giftCards,
        serviceImg: AppServiceImg.giftCards),
    AppService(
        serviceName: AppServiceName.tagPay,
        serviceImg: AppServiceImg.tagPay),
  ];

  // Family account services — active, setup complete (8 services — 1 page)
  // Family accounts can only move money via the family-gated transfer path
  // (core-payments SendFunds enforces per-member limits + records the spend).
  // Non-transfer flows (bills, airtime, insurance, exchange, auto-save) are
  // blocked server-side for a family virtual account, so only surface the
  // transfer services that actually work from a family account.
  static const List<AppService> _familyServices = [
    AppService(
        serviceName: AppServiceName.sendFunds,
        serviceImg: AppServiceImg.sendFunds),
    AppService(
        serviceName: AppServiceName.tagPay,
        serviceImg: AppServiceImg.tagPay),
  ];

  // Service entries to HIDE from rendering. The list constants above
  // still carry the entry so routes/handlers + analytics keep resolving,
  // but the user-facing grid skips them. Add a name here to hide it from
  // both Quick Services AND the All Services bottom sheet (which reads
  // the same source list via getAllServices()).
  static const Set<AppServiceName> _hiddenServices = {
    AppServiceName.invest,
    // Airtime lives inside the Utilities hub now; the standalone Quick
    // Services tile is duplicate surface area.
    AppServiceName.airtime,
  };

  /// Every service across all account types, deduped by name — the corpus the
  /// dashboard swipe-down search filters over so the user can find ANY platform
  /// service (not just the current account's quick tiles).
  static List<AppService> getAllServices() {
    final seen = <AppServiceName>{};
    final out = <AppService>[];
    for (final s in [
      ..._personalServices,
      ..._businessServices,
      ..._savingsServices,
      ..._investmentServices,
      ..._multiCurrencyServices,
      ..._familyServices,
    ]) {
      if (seen.add(s.serviceName)) out.add(s);
    }
    return out;
  }

  List<AppService> get _activeServices {
    final raw = switch (_activeAccountType) {
      VirtualAccountType.business => _businessServices,
      VirtualAccountType.savings => _savingsServices,
      VirtualAccountType.investment => _investmentServices,
      VirtualAccountType.usd ||
      VirtualAccountType.gbp ||
      VirtualAccountType.eur =>
        _multiCurrencyServices,
      VirtualAccountType.family => _familyServices,
      _ => _personalServices,
    };
    return raw.where((s) => !_hiddenServices.contains(s.serviceName)).toList();
  }

  /// Default-account header — replaces the generic "Quick Services" with
  /// a personalised "Hi {firstname} 👋" greeting. The wave emoji is
  /// concatenated here (rather than as a separate widget) so the chip
  /// row layout doesn't change. Falls back to "Hi there 👋" when the
  /// auth cubit doesn't have a profile yet so the carousel never shows
  /// an empty header.
  String _personalGreeting() {
    try {
      final profile = context.read<AuthenticationCubit>().currentProfile;
      final first = profile?.user.firstName.trim() ?? '';
      if (first.isEmpty) return 'Hi there 👋';
      return 'Hi $first 👋';
    } catch (_) {
      return 'Hi there 👋';
    }
  }

  String get _headerTitle => switch (_activeAccountType) {
        VirtualAccountType.business => "Business Services",
        VirtualAccountType.savings => "Savings Services",
        VirtualAccountType.investment => "Investment Services",
        VirtualAccountType.usd ||
        VirtualAccountType.gbp ||
        VirtualAccountType.eur =>
          "Wallet Services",
        VirtualAccountType.family => "Family Services",
        _ => _personalGreeting(),
      };

  Color get _accentColor => switch (_activeAccountType) {
        VirtualAccountType.business => const Color(0xFF3B82F6),
        VirtualAccountType.savings => const Color(0xFF10B981),
        VirtualAccountType.investment => const Color(0xFFF59E0B),
        VirtualAccountType.usd ||
        VirtualAccountType.gbp ||
        VirtualAccountType.eur =>
          const Color(0xFF14B8A6),
        VirtualAccountType.family => const Color(0xFF2D2B6B),
        _ => const Color.fromARGB(255, 78, 3, 208),
      };

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

  /// Currency of the active family wallet, used when the canonical resolver has
  /// to CREATE the family_accounts record. Falls back to NGN (the currency of
  /// the auto-provisioned family wallet) if the summary isn't available.
  String _activeFamilyCurrency() {
    try {
      final st = context.read<AccountCardsSummaryCubit>().state;
      if (st is AccountCardsSummaryLoaded) {
        final activeId = _accountManager.activeAccountId;
        final acct = st.accountSummaries.firstWhere(
          (a) => a.spendingAccountId == activeId || a.id == activeId,
          orElse: () => st.accountSummaries.first,
        );
        return acct.currency;
      }
    } catch (_) {}
    return 'NGN';
  }

  void _checkActiveAccountType() {
    if (!mounted) return;
    final activeId = _accountManager.activeAccountId;
    if (activeId == null) return;

    // Look up the account type from the AccountCardsSummaryCubit state
    try {
      final cubitState = context.read<AccountCardsSummaryCubit>().state;
      if (cubitState is AccountCardsSummaryLoaded) {
        final summaries = cubitState.accountSummaries;
        if (summaries.isEmpty) return;

        // Match on spendingAccountId first: a Family & Friends card is
        // activated by its shared virtual-account id (spendingAccountId), not
        // its group id. For every other account type spendingAccountId == id,
        // so the id fallback keeps them working.
        final activeAccount = summaries.firstWhere(
          (a) => a.spendingAccountId == activeId,
          orElse: () => summaries.firstWhere(
            (a) => a.id == activeId,
            orElse: () => summaries.first,
          ),
        );
        final accountType = activeAccount.accountTypeEnum;
        final isFamily = accountType == VirtualAccountType.family;
        final isFamilyPending = isFamily &&
            (activeAccount.isFamilyPendingSetup || !activeAccount.isFamilyAccount);
        final familyId = isFamily ? activeAccount.familyAccountId : null;

        if (accountType != _activeAccountType ||
            isFamilyPending != _isFamilyPendingSetup) {
          // Reset the services carousel to the first page ONLY on a real
          // account-type SWITCH (one known type → a different one). On the
          // INITIAL resolution (_activeAccountType == null — e.g. this widget
          // was rebuilt when returning from a service's landing page such as
          // Joint Funds) we must PRESERVE the persisted carousel index so
          // "back" lands on the slide the user launched the service from,
          // instead of snapping to the first slide.
          final isInitialResolution = _activeAccountType == null;
          setState(() {
            _activeAccountType = accountType;
            _isFamilyPendingSetup = isFamilyPending;
            _activeFamilyAccountId = familyId;
            if (!isInitialResolution) {
              _currentIndex = 0; // Reset carousel position on account type switch
              _stateManager.setServicesCarouselIndex(0);
            }
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
    if (_activeAccountType == VirtualAccountType.family && _isFamilyPendingSetup) {
      return _buildFamilySetupCTA();
    }

    final servicePages = _getServicePages();
    final carouselHeight = _calculateCarouselHeight(context);
    final activeServices = _activeServices;
    final accentColor = _accentColor;

    // Clamp index to valid range in case page count changed
    final maxIndex = servicePages.length - 1;
    if (_currentIndex > maxIndex) {
      _currentIndex = maxIndex.clamp(0, maxIndex);
      _stateManager.setServicesCarouselIndex(_currentIndex);
    }

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
                    _headerTitle,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: accentColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                  if (_activeAccountType == VirtualAccountType.business) ...[
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
              if (_activeAccountType != VirtualAccountType.business)
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
          colors: [Color(0xFF1A1A3E), Color(0xFF2D2B6B)],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A1A3E).withValues(alpha: 0.3),
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
                  // familyAccountId unknown — resolve-or-create through the SAME
                  // canonical path the account-card "Get Started" uses, so this
                  // "Setup Now" card converges on the same activation-setup screen
                  // instead of dead-ending into the separate "create another"
                  // carousel (the flow/backend divergence this consolidates).
                  setState(() => _isResolvingFamilyId = true);
                  try {
                    final familyCubit = serviceLocator<FamilyAccountCubit>();
                    final familyId =
                        await familyCubit.resolveOrCreatePendingFamilyId(
                      currency: _activeFamilyCurrency(),
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
                            : 'Could not set up your family account. Please try again.',
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
                foregroundColor: const Color(0xFF1A1A3E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
                elevation: 0,
              ),
              child: _isResolvingFamilyId
                  ? LazerVaultLoader.small()
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
