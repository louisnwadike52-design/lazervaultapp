import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import '../../cubit/whatsapp_banking_cubit.dart';
import '../../cubit/whatsapp_banking_state.dart';
import '../../domain/entities/security_settings.dart';

class WhatsAppMainScreen extends StatefulWidget {
  const WhatsAppMainScreen({super.key});

  @override
  State<WhatsAppMainScreen> createState() => _WhatsAppMainScreenState();
}

class _WhatsAppMainScreenState extends State<WhatsAppMainScreen> {
  // Inline security settings controllers
  final _dailyLimitController = TextEditingController();
  final _perTransactionLimitController = TextEditingController();
  final _biometricThresholdController = TextEditingController();
  bool _requirePinForAll = true;
  bool _securityExpanded = false;
  bool _settingsLoaded = false;
  bool _hasSettingsChanges = false;

  @override
  void initState() {
    super.initState();
    context.read<WhatsAppBankingCubit>().loadStatus();
  }

  @override
  void dispose() {
    _dailyLimitController.dispose();
    _perTransactionLimitController.dispose();
    _biometricThresholdController.dispose();
    super.dispose();
  }

  void _populateSettings(SecuritySettings settings) {
    if (!_settingsLoaded) {
      _dailyLimitController.text = settings.dailyTransactionLimit.toStringAsFixed(2);
      _perTransactionLimitController.text = settings.perTransactionLimit.toStringAsFixed(2);
      _biometricThresholdController.text = settings.biometricThreshold.toStringAsFixed(2);
      _requirePinForAll = settings.requirePinForAll;
      _settingsLoaded = true;
    }
  }

  void _saveInlineSettings() {
    final dailyLimit = double.tryParse(_dailyLimitController.text) ?? 0;
    final perTxLimit = double.tryParse(_perTransactionLimitController.text) ?? 0;

    if (dailyLimit <= 0 || perTxLimit <= 0) {
      Get.snackbar(
        'Invalid Amount',
        'Please enter valid amounts greater than zero',
        backgroundColor: Colors.orange.withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(16.w),
      );
      return;
    }

    if (dailyLimit < perTxLimit) {
      Get.snackbar(
        'Invalid Limits',
        'Daily limit must be greater than or equal to per-transaction limit',
        backgroundColor: Colors.orange.withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(16.w),
      );
      return;
    }

    context.read<WhatsAppBankingCubit>().updateSecuritySettings(
      dailyTransactionLimit: dailyLimit,
      perTransactionLimit: perTxLimit,
      requirePinForAll: _requirePinForAll,
      biometricThreshold: double.tryParse(_biometricThresholdController.text) ?? 0,
    );
    setState(() => _hasSettingsChanges = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 78, 3, 208),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'WhatsApp Banking',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<WhatsAppBankingCubit, WhatsAppBankingState>(
        listener: (context, state) {
          if (state is WhatsAppBankingUnlinkSuccess) {
            Get.snackbar(
              'Account Unlinked',
              'Your WhatsApp account has been unlinked successfully',
              backgroundColor: Colors.green.withValues(alpha: 0.9),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              duration: Duration(seconds: 3),
              margin: EdgeInsets.all(16.w),
            );
            setState(() {
              _settingsLoaded = false;
              _securityExpanded = false;
            });
            context.read<WhatsAppBankingCubit>().loadStatus();
          } else if (state is WhatsAppBankingSettingsUpdated) {
            Get.snackbar(
              'Settings Updated',
              'Your security settings have been saved',
              backgroundColor: Colors.green.withValues(alpha: 0.9),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              duration: Duration(seconds: 3),
              margin: EdgeInsets.all(16.w),
            );
          } else if (state is WhatsAppBankingError) {
            Get.snackbar(
              'Error',
              state.message,
              backgroundColor: Colors.red.withValues(alpha: 0.9),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              duration: Duration(seconds: 3),
              margin: EdgeInsets.all(16.w),
            );
          }
        },
        builder: (context, state) {
          if (state is WhatsAppBankingLoading && !_settingsLoaded) {
            return Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 78, 3, 208),
              ),
            );
          }
          if (state is WhatsAppBankingLoaded && state.isLinked) {
            return _buildLinkedView(state);
          }
          return _buildUnlinkedView();
        },
      ),
    );
  }

  Widget _buildUnlinkedView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Hero Section
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 78, 3, 208),
                  Color.fromARGB(255, 120, 40, 230),
                ],
              ),
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.chat_bubble_outline,
                  size: 64.sp,
                  color: Colors.white,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Bank via WhatsApp',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Access all LazerVault services directly from WhatsApp. Fast, secure, and convenient.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white.withValues(alpha: 0.9),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Link Account CTA
          ElevatedButton(
            onPressed: () => Get.toNamed(AppRoutes.whatsappLinking),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 78, 3, 208),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.link, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'Link WhatsApp Account',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),

          // Features Section
          Text(
            'What You Can Do',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16.h),

          _buildFeatureCard(
            icon: Icons.send,
            title: 'Send Money',
            description: 'Transfer funds to anyone, anytime via simple WhatsApp messages',
          ),
          SizedBox(height: 12.h),

          _buildFeatureCard(
            icon: Icons.receipt_long,
            title: 'Pay Bills',
            description: 'Settle electricity bills, buy airtime, and more in seconds',
          ),
          SizedBox(height: 12.h),

          _buildFeatureCard(
            icon: Icons.account_balance_wallet,
            title: 'Check Balance',
            description: 'View your account balance and transaction history instantly',
          ),
          SizedBox(height: 12.h),

          _buildFeatureCard(
            icon: Icons.trending_up,
            title: 'Investments',
            description: 'Buy stocks, crypto, gift cards, and manage investments',
          ),
          SizedBox(height: 12.h),

          _buildFeatureCard(
            icon: Icons.receipt,
            title: 'Invoices',
            description: 'Create, send, and track invoices directly from WhatsApp',
          ),
          SizedBox(height: 12.h),

          _buildFeatureCard(
            icon: Icons.shield_outlined,
            title: 'Secure & Private',
            description: 'Banking-grade security with PIN, biometric, and transaction limits',
          ),
        ],
      ),
    );
  }

  Widget _buildLinkedView(WhatsAppBankingLoaded state) {
    final user = state.user!;

    // Populate settings if loaded
    if (state.settings != null) {
      _populateSettings(state.settings!);
    } else if (!_settingsLoaded) {
      // Load settings on first view
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<WhatsAppBankingCubit>().loadSecuritySettings();
      });
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Account Status Card
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 78, 3, 208),
                            Color.fromARGB(255, 120, 40, 230),
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Account Linked',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            user.phoneNumber,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Divider(color: Colors.grey.shade200),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Linked on',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      user.linkedAt != null
                          ? '${user.linkedAt!.day}/${user.linkedAt!.month}/${user.linkedAt!.year}'
                          : 'Today',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          // Inline Security Settings (expandable)
          _buildInlineSecuritySettings(),
          SizedBox(height: 20.h),

          // Quick Start Guide
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                  Color.fromARGB(255, 120, 40, 230).withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: Color.fromARGB(255, 78, 3, 208),
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Quick Start Guide',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 78, 3, 208),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                _buildGuideStep('1', 'Open WhatsApp and message your linked number'),
                SizedBox(height: 12.h),
                _buildGuideStep('2', 'Type "menu" to see all available services'),
                SizedBox(height: 12.h),
                _buildGuideStep('3', 'Send commands like "send \$50 to John"'),
                SizedBox(height: 12.h),
                _buildGuideStep('4', 'Confirm transactions with your PIN'),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          // Unlink Button
          OutlinedButton(
            onPressed: () => _showUnlinkDialog(),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: BorderSide(color: Colors.red, width: 1.5),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.link_off, size: 18.sp),
                SizedBox(width: 8.w),
                Text(
                  'Unlink WhatsApp Account',
                  style: TextStyle(
                    fontSize: 14.sp,
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

  Widget _buildInlineSecuritySettings() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header (tap to expand/collapse)
          GestureDetector(
            onTap: () => setState(() => _securityExpanded = !_securityExpanded),
            child: Container(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.security,
                      color: Color.fromARGB(255, 78, 3, 208),
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Security Settings',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Manage limits and PIN settings',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: _securityExpanded ? 0.25 : 0,
                    duration: Duration(milliseconds: 200),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 16.sp,
                      color: Colors.black38,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Expandable settings content
          AnimatedCrossFade(
            firstChild: SizedBox.shrink(),
            secondChild: _buildSecuritySettingsContent(),
            crossFadeState: _securityExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 250),
          ),
        ],
      ),
    );
  }

  Widget _buildSecuritySettingsContent() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Divider(color: Colors.grey.shade200),
          SizedBox(height: 16.h),

          // Daily Transaction Limit
          _buildInlineLimitField(
            icon: Icons.calendar_today,
            label: 'Daily Transaction Limit',
            controller: _dailyLimitController,
            hint: '5000.00',
          ),
          SizedBox(height: 12.h),

          // Per Transaction Limit
          _buildInlineLimitField(
            icon: Icons.payment,
            label: 'Per Transaction Limit',
            controller: _perTransactionLimitController,
            hint: '1000.00',
          ),
          SizedBox(height: 12.h),

          // Biometric Threshold
          _buildInlineLimitField(
            icon: Icons.fingerprint,
            label: 'Biometric Threshold',
            controller: _biometricThresholdController,
            hint: '5000.00',
          ),
          SizedBox(height: 12.h),

          // Require PIN Toggle
          Row(
            children: [
              Icon(
                Icons.pin,
                color: Color.fromARGB(255, 78, 3, 208),
                size: 20.sp,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  'Require PIN for All Transactions',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              Switch(
                value: _requirePinForAll,
                onChanged: (value) {
                  setState(() {
                    _requirePinForAll = value;
                    _hasSettingsChanges = true;
                  });
                },
                activeThumbColor: Color.fromARGB(255, 78, 3, 208),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Save Button
          if (_hasSettingsChanges)
            ElevatedButton(
              onPressed: _saveInlineSettings,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 78, 3, 208),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                elevation: 2,
              ),
              child: Text(
                'Save Changes',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

          // Advanced settings link
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.whatsappSecurity),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Advanced Security Settings',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Color.fromARGB(255, 78, 3, 208),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.open_in_new,
                  size: 14.sp,
                  color: Color.fromARGB(255, 78, 3, 208),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInlineLimitField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    required String hint,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: Color.fromARGB(255, 78, 3, 208),
          size: 20.sp,
        ),
        SizedBox(width: 10.w),
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          flex: 1,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            onChanged: (_) => setState(() => _hasSettingsChanges = true),
            decoration: InputDecoration(
              prefixText: '${CurrencySymbols.currentSymbol} ',
              prefixStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 78, 3, 208),
              ),
              hintText: hint,
              isDense: true,
              filled: true,
              fillColor: Color(0xFFF5F5F5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 10.h,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.15),
                  Color.fromARGB(255, 120, 40, 230).withValues(alpha: 0.1),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Color.fromARGB(255, 78, 3, 208),
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black54,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuideStep(String number, String text) {
    return Row(
      children: [
        Container(
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 78, 3, 208),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  void _showUnlinkDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Unlink WhatsApp Account?',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'You will no longer be able to access LazerVault services via WhatsApp. You can re-link anytime.',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black54,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<WhatsAppBankingCubit>().unlinkAccount();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Unlink',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
