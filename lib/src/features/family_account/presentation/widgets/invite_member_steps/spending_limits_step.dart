import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Step 3: Spending Limits Configuration
/// - "No Limits" toggle switch
/// - Daily limit input
/// - Monthly limit input
/// - Per-transaction limit input
/// - Allocation percentage cap slider (1-100%)
class SpendingLimitsStep extends StatefulWidget {
  final Map<String, dynamic> formData;
  final Function(Map<String, dynamic>) onNext;

  const SpendingLimitsStep({
    super.key,
    required this.formData,
    required this.onNext,
  });

  @override
  State<SpendingLimitsStep> createState() => _SpendingLimitsStepState();
}

class _SpendingLimitsStepState extends State<SpendingLimitsStep> {
  late bool _noLimits;
  late TextEditingController _dailyLimitController;
  late TextEditingController _monthlyLimitController;
  late TextEditingController _perTransactionLimitController;
  late double _allocationPercentageCap;

  @override
  void initState() {
    super.initState();
    _noLimits = widget.formData['noLimits'] as bool? ?? false;

    final dailyLimit = widget.formData['dailyLimit'] as double? ?? 0.0;
    final monthlyLimit = widget.formData['monthlyLimit'] as double? ?? 0.0;
    final perTxnLimit = widget.formData['perTransactionLimit'] as double? ?? 0.0;

    _dailyLimitController = TextEditingController(
      text: dailyLimit > 0 ? dailyLimit.toStringAsFixed(2) : '',
    );
    _monthlyLimitController = TextEditingController(
      text: monthlyLimit > 0 ? monthlyLimit.toStringAsFixed(2) : '',
    );
    _perTransactionLimitController = TextEditingController(
      text: perTxnLimit > 0 ? perTxnLimit.toStringAsFixed(2) : '',
    );
    _allocationPercentageCap =
        widget.formData['allocationPercentageCap'] as double? ?? 100.0;
  }

  @override
  void dispose() {
    _dailyLimitController.dispose();
    _monthlyLimitController.dispose();
    _perTransactionLimitController.dispose();
    super.dispose();
  }

  void _submitStep() {
    widget.onNext({
      'noLimits': _noLimits,
      'dailyLimit': _noLimits
          ? 0.0
          : (double.tryParse(_dailyLimitController.text) ?? 0.0),
      'monthlyLimit': _noLimits
          ? 0.0
          : (double.tryParse(_monthlyLimitController.text) ?? 0.0),
      'perTransactionLimit': _noLimits
          ? 0.0
          : (double.tryParse(_perTransactionLimitController.text) ?? 0.0),
      'allocationPercentageCap': _allocationPercentageCap,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Set spending limits',
            style: TextStyle(
              color: const Color(0xFF1E1E2E),
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Control how much this member can spend',
            style: TextStyle(
              color: const Color(0xFF666666),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 24.h),

          // No Limits Toggle
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: _noLimits
                  ? const Color(0xFF6C5CE7).withOpacity(0.08)
                  : const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color:
                    _noLimits ? const Color(0xFF6C5CE7) : const Color(0xFFE0E0E0),
                width: _noLimits ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: _noLimits
                        ? const Color(0xFF6C5CE7).withOpacity(0.15)
                        : const Color(0xFFE0E0E0).withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.all_inclusive,
                    color: _noLimits
                        ? const Color(0xFF6C5CE7)
                        : const Color(0xFF888888),
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'No Spending Limits',
                        style: TextStyle(
                          color: _noLimits
                              ? const Color(0xFF6C5CE7)
                              : const Color(0xFF1E1E2E),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Member can spend their full allocation',
                        style: TextStyle(
                          color: const Color(0xFF888888),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _noLimits,
                  onChanged: (value) {
                    setState(() {
                      _noLimits = value;
                    });
                  },
                  activeColor: const Color(0xFF6C5CE7),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Spending Limits Section (disabled when noLimits is true)
          AnimatedOpacity(
            opacity: _noLimits ? 0.4 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: IgnorePointer(
              ignoring: _noLimits,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Spending Limits',
                    style: TextStyle(
                      color: const Color(0xFF1E1E2E),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Set 0 for unlimited in each category',
                    style: TextStyle(
                      color: const Color(0xFF888888),
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Daily Limit
                  _buildLimitInput(
                    controller: _dailyLimitController,
                    icon: Icons.today_outlined,
                    label: 'Daily Limit',
                    hint: 'Maximum spending per day',
                  ),
                  SizedBox(height: 16.h),

                  // Monthly Limit
                  _buildLimitInput(
                    controller: _monthlyLimitController,
                    icon: Icons.calendar_month_outlined,
                    label: 'Monthly Limit',
                    hint: 'Maximum spending per month',
                  ),
                  SizedBox(height: 16.h),

                  // Per-Transaction Limit
                  _buildLimitInput(
                    controller: _perTransactionLimitController,
                    icon: Icons.payment_outlined,
                    label: 'Per-Transaction Limit',
                    hint: 'Maximum per single transaction',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 32.h),

          // Allocation Percentage Cap
          Text(
            'Allocation Percentage Cap',
            style: TextStyle(
              color: const Color(0xFF1E1E2E),
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Maximum percentage of total pool this member can have',
            style: TextStyle(
              color: const Color(0xFF888888),
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 16.h),

          // Percentage Display and Slider
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: const Color(0xFFE0E0E0),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${_allocationPercentageCap.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: const Color(0xFF6C5CE7),
                        fontSize: 48.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '%',
                      style: TextStyle(
                        color: const Color(0xFF6C5CE7),
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  'of total pool',
                  style: TextStyle(
                    color: const Color(0xFF888888),
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: const Color(0xFF6C5CE7),
                    inactiveTrackColor: const Color(0xFFE0E0E0),
                    thumbColor: const Color(0xFF6C5CE7),
                    overlayColor: const Color(0xFF6C5CE7).withOpacity(0.2),
                    trackHeight: 6.h,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.r),
                  ),
                  child: Slider(
                    value: _allocationPercentageCap,
                    min: 1,
                    max: 100,
                    divisions: 99,
                    onChanged: (value) {
                      setState(() {
                        _allocationPercentageCap = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '1%',
                      style: TextStyle(
                        color: const Color(0xFF888888),
                        fontSize: 12.sp,
                      ),
                    ),
                    Text(
                      '100%',
                      style: TextStyle(
                        color: const Color(0xFF888888),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 40.h),

          // Continue Button
          _buildContinueButton(),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildLimitInput({
    required TextEditingController controller,
    required IconData icon,
    required String label,
    required String hint,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFF6C5CE7),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                label,
                style: TextStyle(
                  color: const Color(0xFF1E1E2E),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          TextFormField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            style: TextStyle(
              color: const Color(0xFF1E1E2E),
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              prefixText: '\$ ',
              prefixStyle: TextStyle(
                color: const Color(0xFF6C5CE7),
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
              hintText: '0.00',
              hintStyle: TextStyle(
                color: const Color(0xFFCCCCCC),
                fontSize: 18.sp,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(
                  color: Color(0xFFE0E0E0),
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(
                  color: Color(0xFFE0E0E0),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(
                  color: Color(0xFF6C5CE7),
                  width: 2,
                ),
              ),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 12.h,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            hint,
            style: TextStyle(
              color: const Color(0xFF888888),
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
        ),
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C5CE7).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _submitStep,
          borderRadius: BorderRadius.circular(28.r),
          child: Center(
            child: Text(
              'Continue',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
