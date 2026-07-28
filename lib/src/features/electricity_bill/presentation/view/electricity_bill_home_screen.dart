import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/provider_entity.dart';
import '../../domain/entities/beneficiary_entity.dart';
import '../../domain/entities/bill_payment_entity.dart';
import '../../../../../core/types/app_routes.dart';
import '../cubit/electricity_bill_cubit.dart';
import '../cubit/electricity_bill_state.dart';
import '../cubit/beneficiary_cubit.dart';
import '../cubit/beneficiary_state.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import '../../../../../core/widgets/bill_history_item.dart';
import '../widgets/electricity_history_actions_sheet.dart';
import '../widgets/electricity_quick_buy.dart';

class ElectricityBillHomeScreen extends StatefulWidget {
  const ElectricityBillHomeScreen({super.key});

  @override
  State<ElectricityBillHomeScreen> createState() =>
      _ElectricityHomeScreenState();
}

class _ElectricityHomeScreenState extends State<ElectricityBillHomeScreen> {
  final TextEditingController _meterNumberController = TextEditingController();
  ElectricityProviderEntity? _selectedProvider;
  bool _isValidating = false;
  bool _isSmartValidating = false;
  List<ElectricityProviderEntity> _providers = [];
  String? _beneficiaryPhoneNumber;
  List<BillPaymentEntity> _recentPayments = [];

  // "Pay Now" on a due reminder that's linked to a saved meter routes here
  // with `fromReminder`/`beneficiaryId` args (see RemindersScreen). Once the
  // beneficiary list loads, we resolve the matching meter number and hand it
  // to the quick-buy card so the user isn't left retyping it.
  String? _pendingReminderBeneficiaryId;
  String? _quickBuyInitialMeter;

  @override
  void initState() {
    super.initState();
    context.read<ElectricityBillCubit>().getProviders(country: serviceLocator<LocaleManager>().currentCountry);
    context.read<BeneficiaryCubit>().getBeneficiaries();
    _loadRecentPayments();

    final args = Get.arguments;
    if (args is Map<String, dynamic> && args['fromReminder'] == true) {
      final benId = args['beneficiaryId'] as String?;
      if (benId != null && benId.isNotEmpty) {
        _pendingReminderBeneficiaryId = benId;
      }
    }
  }

  void _loadRecentPayments() {
    context.read<ElectricityBillCubit>().getPaymentHistory(limit: 3, offset: 0);
  }

  @override
  void dispose() {
    _meterNumberController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    context.read<ElectricityBillCubit>().getProviders(country: serviceLocator<LocaleManager>().currentCountry);
    context.read<BeneficiaryCubit>().getBeneficiaries();
    _loadRecentPayments();
  }

  void _prefillFromBeneficiary(BillBeneficiaryEntity beneficiary) {
    final matchingProvider = _providers
        .where((p) => p.providerCode == beneficiary.providerCode)
        .firstOrNull;
    if (matchingProvider != null) {
      setState(() {
        _meterNumberController.text = beneficiary.meterNumber;
        _selectedProvider = matchingProvider;
        _beneficiaryPhoneNumber = beneficiary.phoneNumber;
      });
      context.read<ElectricityBillCubit>().validateMeter(
            providerCode: matchingProvider.providerCode,
            meterNumber: beneficiary.meterNumber,
            meterType: beneficiary.meterType,
          );
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A1A3E),
              Color(0xFF0A0E27),
              Color(0xFF0F0F23),
            ],
          ),
        ),
        child: SafeArea(
          child: BlocListener<BeneficiaryCubit, BeneficiaryState>(
            listener: (context, state) {
              final pendingId = _pendingReminderBeneficiaryId;
              if (pendingId != null && state is BeneficiariesLoaded) {
                _pendingReminderBeneficiaryId = null;
                final match =
                    state.beneficiaries.where((b) => b.id == pendingId).firstOrNull;
                if (match != null) {
                  setState(() => _quickBuyInitialMeter = match.meterNumber);
                }
              }
            },
            child: BlocConsumer<ElectricityBillCubit, ElectricityBillState>(
            listener: (context, state) {
              if (state is ProvidersLoaded) {
                setState(() {
                  _providers = state.providers;
                  if (_selectedProvider != null) {
                    final match = _providers
                        .where((p) =>
                            p.providerCode == _selectedProvider!.providerCode)
                        .firstOrNull;
                    _selectedProvider =
                        match ?? (_providers.isNotEmpty ? _providers.first : null);
                  }
                });
              }

              if (state is MeterValidating) {
                setState(() => _isValidating = true);
              } else if (_isValidating && state is! MeterValidating) {
                setState(() => _isValidating = false);
              }

              if (state is MeterValidated) {
                Get.toNamed(
                  AppRoutes.electricityBillConfirmation,
                  arguments: {
                    'provider': _selectedProvider,
                    'validationResult': state.validationResult,
                    'providerCode': state.providerCode,
                    'meterNumber': state.meterNumber,
                    'meterType': state.meterType,
                    'phoneNumber': _beneficiaryPhoneNumber ?? '',
                  },
                );
                _beneficiaryPhoneNumber = null;
              }

              if (state is MeterValidationFailed) {
                Get.snackbar(
                  'Validation Failed',
                  state.message,
                  backgroundColor: InvoiceThemeColors.errorRed,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                );
              }

              if (state is SmartMeterValidating) {
                setState(() => _isSmartValidating = true);
              } else if (_isSmartValidating && state is! SmartMeterValidating) {
                setState(() => _isSmartValidating = false);
              }

              // Smart-meter validation (SmartMeterValidated / …Failed) is now
              // owned by the inline ElectricityQuickBuy purchase widget, which
              // resolves the disco + customer and drives the payment in-place.
              // The old listener here used to pop a bottom sheet and route to
              // the standalone confirmation screen — removed so it can't hijack
              // the streamlined single-page flow.

              if (state is ElectricityBillError) {
                Get.snackbar(
                  'Error',
                  state.message,
                  backgroundColor: InvoiceThemeColors.errorRed,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                );
              }

              if (state is PaymentHistoryLoaded) {
                setState(() {
                  _recentPayments = state.payments.take(3).toList();
                });
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  _buildCompactHeader(),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _onRefresh,
                      color: InvoiceThemeColors.primaryPurple,
                      backgroundColor: const Color(0xFF1F1F1F),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 12.h),
                            _buildWelcomeCard(),
                            SizedBox(height: 20.h),
                            _buildQuickActions(),
                            SizedBox(height: 20.h),
                            // Streamlined single-page purchase: meter →
                            // auto-resolved disco+customer (smartValidateMeter,
                            // no manual provider picker) → amount → inline
                            // confirmation → TX-PIN sheet runs the payment →
                            // receipt. Replaces provider-dropdown + meter-input
                            // + confirm + processing screens.
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              // Keyed on the resolved meter so the widget
                              // re-mounts with the prefill applied once the
                              // reminder's linked beneficiary loads (see
                              // BlocListener<BeneficiaryCubit,...> above).
                              child: ElectricityQuickBuy(
                                key: ValueKey(
                                    _quickBuyInitialMeter ?? 'default'),
                                initialMeterNumber: _quickBuyInitialMeter,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            if (_recentPayments.isNotEmpty) ...[
                              SizedBox(height: 20.h),
                              _buildRecentPaymentsSection(),
                            ],
                            SizedBox(height: 32.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompactHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.offAllNamed(AppRoutes.billsHub),
            child: Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F).withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 16.sp,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Electricity',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Per-bill voice + chat icons removed — the unified utility
          // bills landing page is the single entry point for chat/mic
          // across all utility bill types.
        ],
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            InvoiceThemeColors.primaryPurple,
            Color.fromARGB(255, 62, 2, 166),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.3),
            blurRadius: 20.r,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.bolt,
                  color: Colors.white,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pay Electricity Bills',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Fast, secure, and reliable',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: _buildQuickActionCard(
              title: 'Saved Meters',
              icon: Icons.bookmark_border,
              color: InvoiceThemeColors.primaryPurple,
              onTap: () async {
                final result = await Get.toNamed(
                  AppRoutes.electricityBillBeneficiaries,
                  arguments: {'providers': _providers},
                );
                if (result is BillBeneficiaryEntity) {
                  _prefillFromBeneficiary(result);
                }
              },
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: _buildQuickActionCard(
              title: 'Auto-Recharge',
              icon: Icons.autorenew,
              color: const Color(0xFF10B981),
              onTap: () =>
                  Get.toNamed(AppRoutes.electricityBillAutoRecharge),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: _buildQuickActionCard(
              title: 'Reminders',
              icon: Icons.notifications_outlined,
              color: const Color(0xFFF59E0B),
              onTap: () =>
                  Get.toNamed(AppRoutes.electricityBillReminders),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F).withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: const Color(0xFF2D2D2D).withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                icon,
                color: color,
                size: 18.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }











  Widget _buildRecentPaymentsSection() {
    // Split display: header row with purple View-All, then each recent
    // payment gets its own standalone card — same visual treatment the
    // full history screen uses — with spacing between rows.
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Payments',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () =>
                    Get.toNamed(AppRoutes.electricityBillHistory),
                child: Text(
                  'View All',
                  style: GoogleFonts.inter(
                    color: InvoiceThemeColors.primaryPurple,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ..._recentPayments.take(3).map(
                (payment) => Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: InvoiceThemeColors.secondaryBackground,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: _buildPaymentCard(payment),
                  ),
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(BillPaymentEntity payment) {
    // Compact `BillHistoryItem` row — same shared widget the internet
    // recent-transactions strip uses, same tap-opens-actions-sheet UX.
    const accent = InvoiceThemeColors.primaryPurple;
    return BillHistoryItem(
      compact: true,
      leadingIcon: Container(
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Icon(Icons.electric_bolt, color: accent, size: 16.sp),
        ),
      ),
      title: payment.providerName,
      subtitle: [
        payment.meterNumber,
        if (payment.meterType.name.isNotEmpty) payment.meterType.name,
        _formatDate(payment.createdAt),
      ].where((s) => s.isNotEmpty).join(' \u00B7 '),
      amount: payment.amount,
      currencySymbol: '\u20A6',
      // `displayStatus` already collapses failed-but-refunded to
      // "Refunded" so the compact strip on the landing reads the same
      // as the receipt screen's hero — a plain "Failed" on a row where
      // the money came back would be worse than mildly misleading.
      status: payment.displayStatus,
      refundSource: payment.refundSource,
      onTap: () => ElectricityHistoryActionsSheet.show(context, payment),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        final mins = difference.inMinutes;
        if (mins == 0) return 'Just now';
        return '$mins min${mins > 1 ? 's' : ''} ago';
      }
      return '${difference.inHours} hr${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

}

/// Bottom sheet showing smart validation results for confirmation
