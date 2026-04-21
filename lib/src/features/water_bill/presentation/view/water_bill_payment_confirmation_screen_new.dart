import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_auto_recharge_create_sheet.dart';
import '../../data/datasources/water_beneficiary_remote_datasource.dart';
import '../../domain/entities/water_auto_recharge.dart';
import '../../domain/entities/water_beneficiary.dart';
import '../../domain/entities/water_provider_entity.dart';

/// Water Bill payment confirmation.
///
/// Mirrors the data / cable_tv / internet_bill / electricity confirm
/// screens: probe for existing beneficiary + auto-pay, hide matching
/// toggles, forward save/auto-pay flags into the processing screen so
/// the receipt can run its post-purchase actions on success.
class WaterBillPaymentConfirmationScreenNew extends StatefulWidget {
  const WaterBillPaymentConfirmationScreenNew({super.key});

  @override
  State<WaterBillPaymentConfirmationScreenNew> createState() =>
      _WaterBillPaymentConfirmationScreenNewState();
}

class _WaterBillPaymentConfirmationScreenNewState
    extends State<WaterBillPaymentConfirmationScreenNew> {
  // Save-as-beneficiary state
  bool _saveBeneficiary = false;
  String? _beneficiaryNickname;

  // Auto-pay state — captured from BillAutoRechargeCreateSheet
  bool _autoPayEnabled = false;
  double? _rolloverAmount;
  String? _rolloverFrequency;
  int? _rolloverDayOfWeek;
  int? _rolloverDayOfMonth;
  int? _rolloverExecutionHour;
  int? _rolloverExecutionMinute;

  // Probe state
  bool _probeLoading = true;
  WaterBeneficiary? _existingBeneficiary;
  WaterAutoRecharge? _existingAutoRecharge;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _probeExistingState());
  }

  Future<void> _probeExistingState() async {
    try {
      final args = Get.arguments as Map<String, dynamic>;
      final provider = args['provider'] as WaterProviderEntity;
      final customerNumber = args['customerNumber'] as String;
      final providerCode = provider.providerCode.toUpperCase();

      final ds = GetIt.I<WaterBeneficiaryRemoteDataSource>();
      final beneficiaries = await ds.getBeneficiaries();
      WaterBeneficiary? match;
      for (final b in beneficiaries) {
        if (b.accountNumber == customerNumber &&
            b.providerCode.toUpperCase() == providerCode) {
          match = b;
          break;
        }
      }

      WaterAutoRecharge? autoMatch;
      if (match != null) {
        try {
          final recharges = await ds.getAutoRecharges(status: 'active');
          for (final ar in recharges) {
            if (ar.beneficiaryId == match.id && ar.status == 'active') {
              autoMatch = ar;
              break;
            }
          }
        } catch (_) {
          // Soft-fail: beneficiary probe still useful on its own.
        }
      }

      if (!mounted) return;
      setState(() {
        _existingBeneficiary = match;
        _existingAutoRecharge = autoMatch;
        _probeLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _probeLoading = false);
    }
  }

  Future<String?> _promptForNickname() async {
    return showDialog<String>(
      context: context,
      builder: (ctx) => const _NicknameDialog(),
    );
  }

  Future<void> _onToggleSaveBeneficiary(bool newValue) async {
    if (!newValue) {
      setState(() {
        _saveBeneficiary = false;
        _beneficiaryNickname = null;
      });
      return;
    }
    final nickname = await _promptForNickname();
    if (nickname == null || nickname.isEmpty) return;
    if (!mounted) return;
    setState(() {
      _saveBeneficiary = true;
      _beneficiaryNickname = nickname;
    });
  }

  Future<void> _onToggleAutoPay(bool newValue) async {
    if (!newValue) {
      setState(() {
        _autoPayEnabled = false;
        _rolloverAmount = null;
        _rolloverFrequency = null;
      });
      return;
    }
    final args = Get.arguments as Map<String, dynamic>;
    final provider = args['provider'] as WaterProviderEntity;
    final customerNumber = args['customerNumber'] as String;
    final amount = args['amount'] as double;
    await BillAutoRechargeCreateSheet.show(
      context,
      subtitle: '${provider.providerName} · $customerNumber',
      initialAmount: amount,
      onSubmit: ({
        required double amount,
        required String frequency,
        required int dayOfWeek,
        required int dayOfMonth,
        required int executionHour,
        required int executionMinute,
      }) async {
        // Capture the prefs — actual auto-recharge create fires from
        // the receipt screen post-purchase, only if the payment
        // completes.
        if (!mounted) return;
        setState(() {
          _autoPayEnabled = true;
          _rolloverAmount = amount;
          _rolloverFrequency = frequency;
          _rolloverDayOfWeek = dayOfWeek;
          _rolloverDayOfMonth = dayOfMonth;
          _rolloverExecutionHour = executionHour;
          _rolloverExecutionMinute = executionMinute;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final provider = args['provider'] as WaterProviderEntity;
    final customerNumber = args['customerNumber'] as String;
    final customerName = args['customerName'] as String?;
    final amount = args['amount'] as double;
    final outstandingBalance = args['outstandingBalance'] as String?;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
        ),
        title: Text(
          'Confirm Payment',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Center(
                child: Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
                  ),
                  child: Icon(
                    Icons.receipt_long,
                    color: const Color(0xFF4E03D0),
                    size: 40.sp,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Center(
                child: Text(
                  'Payment Summary',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              _buildDetailCard(
                icon: Icons.water_drop,
                title: 'Provider',
                value: provider.providerName,
                color: const Color(0xFF4E03D0),
              ),
              SizedBox(height: 16.h),
              _buildDetailCard(
                icon: Icons.person_outline,
                title: 'Customer Number',
                value: customerNumber,
                color: const Color(0xFF10B981),
              ),
              if (customerName != null) ...[
                SizedBox(height: 16.h),
                _buildDetailCard(
                  icon: Icons.badge_outlined,
                  title: 'Customer Name',
                  value: customerName,
                  color: const Color(0xFF6B21E0),
                ),
              ],
              SizedBox(height: 16.h),
              _buildDetailCard(
                icon: Icons.payments_outlined,
                title: 'Amount',
                value: '₦${amount.toInt()}',
                color: const Color(0xFFFBBF24),
              ),
              if (outstandingBalance != null &&
                  outstandingBalance.isNotEmpty) ...[
                SizedBox(height: 16.h),
                _buildOutstandingTile(outstandingBalance),
              ],
              SizedBox(height: 16.h),
              _buildSaveBeneficiarySection(),
              SizedBox(height: 12.h),
              _buildAutoPaySection(),
              SizedBox(height: 24.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFF2D2D2D), width: 1),
                ),
                child: Column(
                  children: [
                    _buildFeeRow('Subtotal', '₦${amount.toInt()}'),
                    SizedBox(height: 12.h),
                    _buildFeeRow('Service Fee', '₦0'),
                    SizedBox(height: 12.h),
                    const Divider(color: Color(0xFF2D2D2D)),
                    SizedBox(height: 12.h),
                    _buildFeeRow('Total', '₦${amount.toInt()}', isTotal: true),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              _buildTermsCheckbox(),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: () => _navigateToPINEntry(context, args),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4E03D0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Confirm & Pay',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSaveBeneficiarySection() {
    if (_probeLoading) return _buildToggleSkeleton();
    if (_existingBeneficiary != null) {
      final nick = _existingBeneficiary!.nickname;
      final label = nick != null && nick.isNotEmpty
          ? 'Saved as "$nick"'
          : 'Saved in your contacts';
      return _buildInfoTile(
        icon: Icons.bookmark,
        title: 'Account Saved',
        subtitle: label,
      );
    }
    return _buildToggleTile(
      icon: Icons.bookmark_add_outlined,
      title: 'Save this account',
      subtitle: 'Quick repeat payments next time',
      value: _saveBeneficiary,
      onChanged: _onToggleSaveBeneficiary,
    );
  }

  Widget _buildAutoPaySection() {
    if (_probeLoading) return _buildToggleSkeleton();
    if (_existingAutoRecharge != null) {
      final freq = _existingAutoRecharge!.frequency;
      return _buildInfoTile(
        icon: Icons.autorenew,
        title: 'Auto-Pay Active',
        subtitle: 'Already on ${freq.toLowerCase()} schedule',
      );
    }
    final subtitle = _autoPayEnabled && _rolloverFrequency != null
        ? 'On ${_rolloverFrequency!.toLowerCase()} schedule'
        : 'Pay this bill automatically';
    return _buildToggleTile(
      icon: Icons.autorenew,
      title: 'Enable auto-pay',
      subtitle: subtitle,
      value: _autoPayEnabled,
      onChanged: _onToggleAutoPay,
    );
  }

  Widget _buildToggleTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D), width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF4E03D0), size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: const Color(0xFF4E03D0),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF10B981).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF10B981), size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.check_circle,
              color: const Color(0xFF10B981), size: 18.sp),
        ],
      ),
    );
  }

  Widget _buildToggleSkeleton() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F).withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D), width: 1),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 18.w,
            height: 18.w,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(Color(0xFF4E03D0)),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            'Checking saved state…',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutstandingTile(String outstandingBalance) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFFEE2E2).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline,
              color: const Color(0xFFFEE2E2), size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Outstanding Bill',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  outstandingBalance,
                  style: GoogleFonts.inter(
                    color: const Color(0xFFFEE2E2),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: color, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeeRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: isTotal ? Colors.white : const Color(0xFF9CA3AF),
            fontSize: isTotal ? 14.sp : 13.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            color: isTotal ? const Color(0xFF4E03D0) : Colors.white,
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 20.w,
          height: 20.w,
          child: Checkbox(
            value: true,
            onChanged: null,
            fillColor: WidgetStateProperty.all(const Color(0xFF4E03D0)),
            checkColor: Colors.white,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            'I confirm this payment is authorized and I agree to the terms and conditions',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 12.sp,
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToPINEntry(BuildContext context, Map<String, dynamic> args) {
    Get.toNamed(
      AppRoutes.inputPin,
      arguments: {
        'onPinVerified': (String verificationToken) {
          // Forward save-beneficiary + auto-pay flags through to the
          // processing screen → receipt screen so post-purchase
          // actions (save, create auto-recharge) can fire on success.
          Get.toNamed(
            AppRoutes.waterBillPaymentProcessing,
            arguments: {
              ...args,
              'verificationToken': verificationToken,
              'saveBeneficiary': _saveBeneficiary,
              'beneficiaryNickname': _beneficiaryNickname,
              'autoPayEnabled': _autoPayEnabled,
              'rolloverAmount': _rolloverAmount,
              'rolloverFrequency': _rolloverFrequency,
              'rolloverDayOfWeek': _rolloverDayOfWeek,
              'rolloverDayOfMonth': _rolloverDayOfMonth,
              'rolloverExecutionHour': _rolloverExecutionHour,
              'rolloverExecutionMinute': _rolloverExecutionMinute,
            },
          );
        },
        'amount': args['amount'],
        'transactionType': 'water_bill_payment',
      },
    );
  }
}

class _NicknameDialog extends StatefulWidget {
  const _NicknameDialog();

  @override
  State<_NicknameDialog> createState() => _NicknameDialogState();
}

class _NicknameDialogState extends State<_NicknameDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      title: Text(
        'Save as…',
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 17.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: TextField(
        controller: _controller,
        autofocus: true,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
        decoration: InputDecoration(
          hintText: 'e.g. Home LSWC',
          hintStyle: GoogleFonts.inter(
            color: const Color(0xFF6B7280),
            fontSize: 15.sp,
          ),
          filled: true,
          fillColor: const Color(0xFF0A0A0A),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Color(0xFF4E03D0)),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_controller.text.trim()),
          child: Text(
            'Save',
            style: GoogleFonts.inter(
              color: const Color(0xFF4E03D0),
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
