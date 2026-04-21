import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/water_provider_entity.dart';
import '../../domain/entities/water_payment_entity.dart';
import '../cubit/water_bill_cubit.dart';
import '../cubit/water_bill_state.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_history_item.dart';
import '../../../../../core/widgets/bill_history_actions_sheet.dart';

/// New Water Bill Home Screen
/// Auto-loads providers and shows payment options immediately
class WaterBillHomeScreenNew extends StatefulWidget {
  const WaterBillHomeScreenNew({super.key});

  @override
  State<WaterBillHomeScreenNew> createState() => _WaterBillHomeScreenNewState();
}

class _WaterBillHomeScreenNewState extends State<WaterBillHomeScreenNew> {
  static const Color _primary = Color(0xFF4E03D0);

  List<WaterProviderEntity> _providers = [];
  List<WaterPaymentEntity> _payments = [];
  bool _isLoadingProviders = true;
  bool _isLoadingPayments = true;

  @override
  void initState() {
    super.initState();
    // Auto-load providers on init
    context.read<WaterBillCubit>().getProviders();
    // Load payment history
    context.read<WaterBillCubit>().getPaymentHistory(limit: 5);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) Get.offAllNamed(AppRoutes.billsHub);
      },
      child: Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.offAllNamed(AppRoutes.billsHub),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 22.sp,
          ),
        ),
        title: Text(
          'Water Bills',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.waterBillHistory),
            icon: Icon(
              Icons.history,
              color: Colors.white,
              size: 22.sp,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<WaterBillCubit, WaterBillState>(
          listener: (context, state) {
            if (state is ProvidersLoaded) {
              setState(() {
                _providers = state.providers;
                _isLoadingProviders = false;
              });
            } else if (state is PaymentHistoryLoaded) {
              setState(() {
                _payments = state.payments;
                _isLoadingPayments = false;
              });
            } else if (state is WaterBillError && _providers.isEmpty) {
              setState(() {
                _isLoadingProviders = false;
              });
            }
          },
          builder: (context, state) {
            if (_isLoadingProviders && _providers.isEmpty) {
              return _buildLoading();
            }

            if (_providers.isEmpty) {
              if (state is WaterBillError) {
                return _buildError(state.message);
              }
              return _buildError('No water providers available');
            }

            return _buildProviderList(_providers);
          },
        ),
      ),
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 40.w,
            height: 40.w,
            child: const CircularProgressIndicator(
              color: _primary,
              strokeWidth: 3,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'Loading water providers...',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: const Color(0xFFEF4444),
            size: 48.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'Failed to load providers',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () => context.read<WaterBillCubit>().getProviders(),
            style: ElevatedButton.styleFrom(
              backgroundColor: _primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 32.w,
                vertical: 14.h,
              ),
            ),
            child: Text(
              'Retry',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProviderList(List<WaterProviderEntity> providers) {
    // Auto-select primary provider (first in list = Lagos Water)
    final primaryProvider = providers.isNotEmpty ? providers.first : null;

    if (primaryProvider == null) {
      return _buildError('No water providers available');
    }

    return RefreshIndicator(
      color: _primary,
      backgroundColor: const Color(0xFF1F1F1F),
      onRefresh: () async {
        await context.read<WaterBillCubit>().getProviders();
      },
      child: SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),

          // Header illustration
          Center(
            child: Container(
              width: 100.w,
              height: 100.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    _primary,
                    Color(0xFF4E03D0),
                  ],
                ),
              ),
              child: Icon(
                Icons.water_drop,
                color: Colors.white,
                size: 50.sp,
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Title
          Center(
            child: Text(
              'Pay Your Water Bill',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Center(
            child: Text(
              'Select your provider and pay instantly',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
            ),
          ),

          SizedBox(height: 24.h),

          // Quick Actions strip
          _buildQuickActions(),

          SizedBox(height: 24.h),

          // Primary Provider Card
          _buildPrimaryProviderCard(primaryProvider),

          // Additional providers (if any)
          if (providers.length > 1) ...[
            SizedBox(height: 20.h),
            Text(
              'Other Providers',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            ...providers.skip(1).map((provider) => _buildProviderCard(provider)),
          ],

          SizedBox(height: 32.h),

          // Quick Amounts
          Text(
            'Quick Amounts',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          _buildQuickAmounts(primaryProvider),

          SizedBox(height: 32.h),

          // Recent Transactions
          _buildRecentTransactionsSection(),

          SizedBox(height: 20.h),
        ],
      ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Quick Actions strip (Saved Accounts / Auto-Recharge / Reminders)
  // ---------------------------------------------------------------------------

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _buildQuickActionCard(
            title: 'Saved\nAccounts',
            icon: Icons.bookmark_border,
            onTap: () => Get.toNamed(AppRoutes.waterBillSavedAccounts),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _buildQuickActionCard(
            title: 'Auto-\nRecharge',
            icon: Icons.autorenew,
            onTap: () => Get.toNamed(AppRoutes.waterBillAutoRecharge),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _buildQuickActionCard(
            title: 'Reminders',
            icon: Icons.notifications_outlined,
            onTap: () => Get.toNamed(AppRoutes.waterBillReminders),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: _primary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: _primary.withValues(alpha: 0.25), width: 1),
        ),
        child: Column(
          children: [
            Icon(icon, color: _primary, size: 22.sp),
            SizedBox(height: 6.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrimaryProviderCard(WaterProviderEntity provider) {
    return GestureDetector(
      onTap: () => _navigateToPayment(provider),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _primary,
              Color(0xFF3B0FA5),
            ],
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: _primary.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 56.w,
                  height: 56.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.water_drop,
                    color: Colors.white,
                    size: 28.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            provider.providerName,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              'PRIMARY',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Fastest processing \u2022 Best rates',
                        style: GoogleFonts.inter(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Min: \u20A61,000',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  'Max: \u20A6200,000',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProviderCard(WaterProviderEntity provider) {
    return GestureDetector(
      onTap: () => _navigateToPayment(provider),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: const Color(0xFF2D2D2D),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: _primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.water_drop,
                color: _primary,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    provider.providerName,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '\u20A61,000 - \u20A6200,000',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: const Color(0xFF6B7280),
              size: 22.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAmounts(WaterProviderEntity provider) {
    final amounts = [1000.0, 2000.0, 5000.0, 10000.0, 20000.0];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.5,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
      ),
      itemCount: amounts.length,
      itemBuilder: (context, index) {
        final amount = amounts[index];
        return GestureDetector(
          onTap: () => _navigateToPaymentWithAmount(provider, amount),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: const Color(0xFF2D2D2D),
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                '\u20A6${amount.toInt()}',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecentTransactionsSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF2D2D2D),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Payments',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (_payments.isNotEmpty)
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.waterBillHistory),
                  child: Text(
                    'View All',
                    style: GoogleFonts.inter(
                      color: _primary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),

          // Loading state
          if (_isLoadingPayments)
            Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 24.w,
                    height: 24.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(_primary),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Loading payments...',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF6B7280),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),

          // Empty state
          if (!_isLoadingPayments && _payments.isEmpty)
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.receipt_long,
                    color: const Color(0xFF6B7280),
                    size: 32.sp,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'No recent payments',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF6B7280),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),

          // Show first 3 payments using BillHistoryItem
          if (!_isLoadingPayments && _payments.isNotEmpty) ...[
            ..._payments.take(3).map((payment) => Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: BillHistoryItem(
                    compact: true,
                    leadingIcon: Container(
                      decoration: BoxDecoration(
                        color: _primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(Icons.water_drop, color: _primary, size: 18.sp),
                    ),
                    title: payment.providerName,
                    subtitle: payment.customerNumber,
                    amount: payment.amount,
                    status: payment.status.name,
                    onTap: () => _showHistoryActions(payment),
                  ),
                )),
            if (_payments.length > 3) ...[
              SizedBox(height: 12.h),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.waterBillHistory),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: _primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Text(
                      'View All Payments (${_payments.length})',
                      style: GoogleFonts.inter(
                        color: _primary,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }

  void _showHistoryActions(WaterPaymentEntity payment) {
    BillHistoryActionsSheet.show(
      context,
      title: payment.providerName,
      subtitle:
          '\u20A6${payment.amount.toStringAsFixed(0)} \u2022 ${payment.status.name}',
      actions: [
        BillHistoryAction(
          icon: Icons.receipt_long,
          color: _primary,
          label: 'View Receipt',
          onTap: () {
            Get.back();
            Get.toNamed(
              AppRoutes.waterBillPaymentReceipt,
              arguments: {'payment': payment},
            );
          },
        ),
        BillHistoryAction(
          icon: Icons.replay,
          color: const Color(0xFF10B981),
          label: 'Repeat Purchase',
          onTap: () {
            Get.back();
            // Navigate to water payment with pre-filled provider + account number
            Get.toNamed(
              AppRoutes.waterBillCustomerInput,
              arguments: {
                'provider': _providers.firstWhere(
                  (p) => p.providerName == payment.providerName,
                  orElse: () => _providers.first,
                ),
                'prefillCustomerNumber': payment.customerNumber,
              },
            );
          },
        ),
        BillHistoryAction(
          icon: Icons.notifications_outlined,
          color: const Color(0xFFFB923C),
          label: 'Set Reminder',
          onTap: () {
            Get.back();
            Get.toNamed(AppRoutes.waterBillReminders);
          },
        ),
        BillHistoryAction(
          icon: Icons.bookmark_border,
          color: _primary,
          label: 'Save Account',
          onTap: () {
            Get.back();
            Get.toNamed(AppRoutes.waterBillSavedAccounts);
          },
        ),
      ],
    );
  }

  void _navigateToPayment(WaterProviderEntity provider) {
    Get.toNamed(
      AppRoutes.waterBillCustomerInput,
      arguments: {
        'provider': provider,
      },
    );
  }

  void _navigateToPaymentWithAmount(WaterProviderEntity provider, double amount) {
    Get.toNamed(
      AppRoutes.waterBillCustomerInput,
      arguments: {
        'provider': provider,
        'preselectedAmount': amount,
      },
    );
  }
}
