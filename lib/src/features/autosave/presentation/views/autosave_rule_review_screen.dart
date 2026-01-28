import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';

class AutoSaveRuleReviewScreen extends StatefulWidget {
  const AutoSaveRuleReviewScreen({super.key});

  @override
  State<AutoSaveRuleReviewScreen> createState() => _AutoSaveRuleReviewScreenState();
}

class _AutoSaveRuleReviewScreenState extends State<AutoSaveRuleReviewScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  Map<String, dynamic> ruleData = {};

  @override
  void initState() {
    super.initState();
    ruleData = Get.arguments as Map<String, dynamic>? ?? {};
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _confirmRule() {
    // Navigate to processing screen with rule data
    Get.toNamed(
      AppRoutes.autoSaveRuleProcessing,
      arguments: ruleData,
    );
  }

  String _getTriggerDescription() {
    final triggerType = ruleData['triggerType'] as TriggerType;
    switch (triggerType) {
      case TriggerType.onDeposit:
        return 'Automatically save when deposits are made';
      case TriggerType.scheduled:
        final frequency = ruleData['frequency'] as ScheduleFrequency?;
        final time = ruleData['scheduleTime'] as String?;
        String freqText = '';
        switch (frequency) {
          case ScheduleFrequency.daily:
            freqText = 'Daily';
            break;
          case ScheduleFrequency.weekly:
            freqText = 'Weekly';
            break;
          case ScheduleFrequency.biweekly:
            freqText = 'Bi-Weekly';
            break;
          case ScheduleFrequency.monthly:
            freqText = 'Monthly';
            break;
          default:
            freqText = 'Scheduled';
        }
        return '$freqText${time != null ? ' at $time' : ''}';
      case TriggerType.roundUp:
        final roundUpTo = ruleData['roundUpTo'] as int?;
        return 'Round up to nearest \$${roundUpTo ?? 10}';
      default:
        return 'Unknown trigger';
    }
  }

  String _getAmountDescription() {
    final amountType = ruleData['amountType'] as AmountType;
    final amountValue = ruleData['amountValue'] as double;

    if (amountType == AmountType.fixed) {
      return '\$${amountValue.toStringAsFixed(2)}';
    } else {
      return '${amountValue.toStringAsFixed(0)}% of transaction';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1F1F1F),
              const Color(0xFF0A0A0A),
              const Color(0xFF000000),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: _buildReviewContent(),
                  ),
                ),
              ),
              _buildConfirmButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Review Auto-Save Rule',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Please confirm your auto-save rule details',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rule Name Section
          _buildSectionCard(
            title: 'Rule Name',
            icon: Icons.label_outline,
            children: [
              _buildDetailRow('Name', ruleData['name'] as String? ?? ''),
              SizedBox(height: 12.h),
              _buildDetailRow('Description', ruleData['description'] as String? ?? ''),
            ],
          ),

          SizedBox(height: 16.h),

          // Trigger Settings Section
          _buildSectionCard(
            title: 'Trigger Settings',
            icon: Icons.alarm,
            children: [
              _buildDetailRow('Type', _getTriggerDescription()),
            ],
          ),

          SizedBox(height: 16.h),

          // Amount Settings Section
          _buildSectionCard(
            title: 'Amount Settings',
            icon: Icons.attach_money,
            children: [
              _buildDetailRow('Save Amount', _getAmountDescription()),
            ],
          ),

          SizedBox(height: 16.h),

          // Account Settings Section
          _buildSectionCard(
            title: 'Account Settings',
            icon: Icons.account_balance_wallet,
            children: [
              _buildDetailRow('Source Account', ruleData['sourceAccountName'] as String? ?? 'Not selected'),
              SizedBox(height: 12.h),
              _buildDetailRow('Destination Account', ruleData['destinationAccountName'] as String? ?? 'Not selected'),
            ],
          ),

          // Optional Limits Section (if any are set)
          if (_hasOptionalLimits()) ...[
            SizedBox(height: 16.h),
            _buildSectionCard(
              title: 'Optional Limits',
              icon: Icons.flag,
              children: [
                if (ruleData['targetAmount'] != null) ...[
                  _buildDetailRow('Target Amount', '\$${(ruleData['targetAmount'] as double).toStringAsFixed(2)}'),
                  SizedBox(height: 12.h),
                ],
                if (ruleData['minimumBalance'] != null) ...[
                  _buildDetailRow('Minimum Balance', '\$${(ruleData['minimumBalance'] as double).toStringAsFixed(2)}'),
                  SizedBox(height: 12.h),
                ],
                if (ruleData['maximumPerSave'] != null)
                  _buildDetailRow('Maximum Per Save', '\$${(ruleData['maximumPerSave'] as double).toStringAsFixed(2)}'),
              ],
            ),
          ],

          SizedBox(height: 120.h),
        ],
      ),
    );
  }

  bool _hasOptionalLimits() {
    return ruleData['targetAmount'] != null ||
        ruleData['minimumBalance'] != null ||
        ruleData['maximumPerSave'] != null;
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  icon,
                  color: const Color.fromARGB(255, 78, 3, 208),
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                title,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF0A0A0A).withValues(alpha: 0),
            const Color(0xFF0A0A0A),
          ],
        ),
      ),
      child: SafeArea(
        top: false,
        child: Container(
          width: double.infinity,
          height: 56.h,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 78, 3, 208),
                Color.fromARGB(255, 98, 33, 224),
              ],
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.4),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16.r),
              onTap: _confirmRule,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                      size: 24.sp,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Confirm & Create Rule',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
