import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/data_plan_entity.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';
import '../widgets/rollover_preference_sheet.dart';

/// Consolidated confirmation page for a data bundle purchase.
///
/// Merges the old vertical stack of detail cards into a single review
/// panel so the page fits without scroll in 95%+ of viewport sizes, and
/// adds the two airtime-parity toggles:
///   * Save as Beneficiary — persists the recipient + nickname on
///     successful payment (mirrors [saveAirtimeBeneficiary]).
///   * Rollover — opens [RolloverPreferenceSheet] to pick between
///     renew-on-expiry (auto-renew) and a fixed recurring schedule
///     (DataAutoRecharge). Backend code for both already exists; the
///     receipt screen calls the appropriate endpoint on completion.
class DataPaymentConfirmationScreen extends StatefulWidget {
  const DataPaymentConfirmationScreen({super.key});

  @override
  State<DataPaymentConfirmationScreen> createState() =>
      _DataPaymentConfirmationScreenState();
}

class _DataPaymentConfirmationScreenState
    extends State<DataPaymentConfirmationScreen>
    with TransactionPinMixin {
  final _currencyFormat = NumberFormat('#,##0', 'en_NG');
  bool _isProcessing = false;
  bool _saveBeneficiary = false;
  RolloverPreference? _rolloverPref;

  // Cache route args at mount time. Reading Get.arguments in build() makes
  // the cast crash on rebuild — setState from a toggle, or returning from
  // a nested modal (PIN sheet, rollover sheet) that GetX tracks as a
  // separate route, can flip Get.arguments to null momentarily.
  late final DataPlanEntity _plan;
  late final String _network;
  late final String _networkName;
  late final int _networkColorValue;
  late final String _phoneNumber;

  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _textSecondary = Color(0xFF9CA3AF);
  static const _primary = Color(0xFF4E03D0);
  static const _green = Color(0xFF10B981);

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>;
    _plan = args['plan'] as DataPlanEntity;
    _network = args['network'] as String;
    _networkName = args['networkName'] as String;
    _networkColorValue = args['networkColor'] as int;
    _phoneNumber = args['phoneNumber'] as String;
  }

  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  Future<void> _openRolloverSheet() async {
    final pref = await RolloverPreferenceSheet.show(context);
    if (pref == null) return;
    setState(() => _rolloverPref = pref);
  }

  String _rolloverLabel() {
    final p = _rolloverPref;
    if (p == null) return 'Off';
    if (p.mode == RolloverMode.renewOnExpiry) return 'Auto-rollover on expiry';
    final freq = p.frequency[0].toUpperCase() + p.frequency.substring(1);
    return 'Recurring $freq';
  }

  Future<void> _onPay() async {
    if (_isProcessing) return;

    final plan = _plan;
    final network = _network;
    final networkName = _networkName;
    final networkColorValue = _networkColorValue;
    final phoneNumber = _phoneNumber;

    setState(() => _isProcessing = true);

    final transactionId = const Uuid().v4();
    final idempotencyKey = const Uuid().v4();

    String? verificationToken;
    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'data_purchase',
      amount: plan.price,
      currency: 'NGN',
      title: 'Confirm Payment',
      message:
          'Confirm data bundle purchase of \u20A6${plan.price.toStringAsFixed(0)}',
      showProcessingPhase: false,
      onPinValidated: (token) async {
        verificationToken = token;
      },
    );

    if (!success || verificationToken == null) {
      setState(() => _isProcessing = false);
      return;
    }
    if (!mounted) return;

    Get.offNamed(
      AppRoutes.dataBundlesPaymentProcessing,
      arguments: {
        'plan': plan,
        'network': network,
        'networkName': networkName,
        'networkColor': networkColorValue,
        'phoneNumber': phoneNumber,
        'transactionId': transactionId,
        'verificationToken': verificationToken!,
        'idempotencyKey': idempotencyKey,
        // Legacy flag: receipt still uses this to decide whether to call
        // enableAutoRenew. True when the user picked the renew-on-expiry
        // rollover mode. The richer pref is also forwarded for the
        // recurring-schedule path.
        'autoRenewEnabled':
            _rolloverPref?.mode == RolloverMode.renewOnExpiry,
        'rolloverPreference': _rolloverPref,
        'saveBeneficiary': _saveBeneficiary,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final plan = _plan;
    final networkName = _networkName;
    final networkColor = Color(_networkColorValue);
    final phoneNumber = _phoneNumber;

    return Scaffold(
      backgroundColor: _bg,
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.h),
                    _buildReviewCard(
                      plan: plan,
                      networkName: networkName,
                      networkColor: networkColor,
                      phoneNumber: phoneNumber,
                    ),
                    SizedBox(height: 14.h),
                    _buildSaveBeneficiaryToggle(),
                    SizedBox(height: 10.h),
                    _buildRolloverRow(),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
            _buildPayButton(plan.price),
          ],
        ),
      ),
    );
  }

  // =============================== Review card ============================

  Widget _buildReviewCard({
    required DataPlanEntity plan,
    required String networkName,
    required Color networkColor,
    required String phoneNumber,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: networkColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Icons.cell_tower,
                    color: networkColor, size: 22.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      networkName,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      phoneNumber,
                      style: GoogleFonts.inter(
                        color: _textSecondary,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '\u20A6${_currencyFormat.format(plan.price)}',
                style: GoogleFonts.inter(
                  color: _green,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          const Divider(color: _border, height: 1),
          SizedBox(height: 10.h),
          _kv('Plan', plan.name),
          if (plan.availability.isNotEmpty) ...[
            SizedBox(height: 6.h),
            _kv('Validity', plan.availability),
          ],
          SizedBox(height: 6.h),
          _kv('Service fee', '\u20A60.00'),
        ],
      ),
    );
  }

  Widget _kv(String k, String v) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          k,
          style: GoogleFonts.inter(color: _textSecondary, fontSize: 12.sp),
        ),
        Flexible(
          child: Text(
            v,
            textAlign: TextAlign.right,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // =============================== Toggles ================================

  /// Compact toggle row mirroring the airtime confirmation screen's
  /// "save contact" affordance. Persist happens on the receipt screen
  /// after a successful purchase.
  Widget _buildSaveBeneficiaryToggle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: _saveBeneficiary
              ? _primary.withValues(alpha: 0.4)
              : _border,
        ),
      ),
      child: Row(
        children: [
          Icon(
            _saveBeneficiary ? Icons.bookmark : Icons.bookmark_border,
            color: _saveBeneficiary ? _primary : _textSecondary,
            size: 20.sp,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'Save as Beneficiary',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Switch(
            value: _saveBeneficiary,
            onChanged: (v) => setState(() => _saveBeneficiary = v),
            activeThumbColor: _primary,
            inactiveThumbColor: _textSecondary,
            inactiveTrackColor: _border,
          ),
        ],
      ),
    );
  }

  /// Rollover affordance — tap opens [RolloverPreferenceSheet] which
  /// lets the user choose between renew-on-expiry and a fixed recurring
  /// schedule. Stored preference drives the post-payment hookup on the
  /// receipt screen.
  Widget _buildRolloverRow() {
    final active = _rolloverPref != null;
    return InkWell(
      onTap: _openRolloverSheet,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: active ? _green.withValues(alpha: 0.4) : _border,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.autorenew,
              color: active ? _green : _textSecondary,
              size: 20.sp,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rollover',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    _rolloverLabel(),
                    style: GoogleFonts.inter(
                      color: active ? _green : _textSecondary,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: _textSecondary,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  // =============================== Pay button =============================

  Widget _buildPayButton(double price) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 16.h),
      child: SizedBox(
        width: double.infinity,
        height: 54.h,
        child: ElevatedButton(
          onPressed: _isProcessing ? null : _onPay,
          style: ElevatedButton.styleFrom(
            backgroundColor: _primary,
            disabledBackgroundColor: _primary.withValues(alpha: 0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: _isProcessing
              ? SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  'Pay \u20A6${_currencyFormat.format(price)}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
