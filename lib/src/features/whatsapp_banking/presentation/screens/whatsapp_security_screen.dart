import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import '../../cubit/whatsapp_banking_cubit.dart';
import '../../cubit/whatsapp_banking_state.dart';

class WhatsAppSecurityScreen extends StatefulWidget {
  const WhatsAppSecurityScreen({super.key});

  @override
  State<WhatsAppSecurityScreen> createState() => _WhatsAppSecurityScreenState();
}

class _WhatsAppSecurityScreenState extends State<WhatsAppSecurityScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dailyLimitController = TextEditingController();
  final _perTransactionLimitController = TextEditingController();
  final _biometricThresholdController = TextEditingController();

  bool _requirePinForAll = true;
  bool _hasChanges = false;
  bool _settingsLoaded = false;

  @override
  void initState() {
    super.initState();
    context.read<WhatsAppBankingCubit>().loadSecuritySettings();

    _dailyLimitController.addListener(_markChanged);
    _perTransactionLimitController.addListener(_markChanged);
    _biometricThresholdController.addListener(_markChanged);
  }

  void _markChanged() {
    if (_settingsLoaded) {
      setState(() => _hasChanges = true);
    }
  }

  @override
  void dispose() {
    _dailyLimitController.dispose();
    _perTransactionLimitController.dispose();
    _biometricThresholdController.dispose();
    super.dispose();
  }

  void _populateSettings(WhatsAppBankingLoaded state) {
    if (!_settingsLoaded && state.settings != null) {
      final s = state.settings!;
      _dailyLimitController.text = s.dailyTransactionLimit.toStringAsFixed(2);
      _perTransactionLimitController.text = s.perTransactionLimit.toStringAsFixed(2);
      _biometricThresholdController.text = s.biometricThreshold.toStringAsFixed(2);
      _requirePinForAll = s.requirePinForAll;
      _settingsLoaded = true;
    }
  }

  void _saveSettings() {
    if (!_formKey.currentState!.validate()) return;

    final dailyLimit = double.tryParse(_dailyLimitController.text) ?? 0;
    final perTxLimit = double.tryParse(_perTransactionLimitController.text) ?? 0;

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
  }

  void _resetToDefaults() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Reset to Defaults?',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'This will reset all security settings to recommended defaults.',
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
              setState(() {
                _dailyLimitController.text = '5000.00';
                _perTransactionLimitController.text = '1000.00';
                _biometricThresholdController.text = '5000.00';
                _requirePinForAll = true;
                _hasChanges = true;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 78, 3, 208),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Reset',
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
          'Security Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _resetToDefaults,
            child: Text(
              'Reset',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<WhatsAppBankingCubit, WhatsAppBankingState>(
        listener: (context, state) {
          if (state is WhatsAppBankingSettingsUpdated) {
            setState(() => _hasChanges = false);
            Get.snackbar(
              'Settings Updated',
              'Your security settings have been saved successfully',
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

          if (state is WhatsAppBankingLoaded) {
            _populateSettings(state);
          }

          final isLoading = state is WhatsAppBankingLoading;

          return Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Header
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                                Color.fromARGB(255, 120, 40, 230).withValues(alpha: 0.05),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.shield_outlined,
                                color: Color.fromARGB(255, 78, 3, 208),
                                size: 24.sp,
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  'Configure limits and authentication for WhatsApp transactions',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.black87,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),

                        // Transaction Limits Section
                        Text(
                          'Transaction Limits',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 12.h),

                        _buildLimitCard(
                          icon: Icons.calendar_today,
                          label: 'Daily Transaction Limit',
                          description: 'Maximum amount you can transact per day',
                          controller: _dailyLimitController,
                          hint: '5000.00',
                        ),
                        SizedBox(height: 12.h),

                        _buildLimitCard(
                          icon: Icons.payment,
                          label: 'Per Transaction Limit',
                          description: 'Maximum amount per single transaction',
                          controller: _perTransactionLimitController,
                          hint: '1000.00',
                        ),
                        SizedBox(height: 24.h),

                        // Authentication Section
                        Text(
                          'Authentication',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 12.h),

                        _buildLimitCard(
                          icon: Icons.fingerprint,
                          label: 'Biometric Threshold',
                          description: 'Amounts above this require biometric confirmation in-app',
                          controller: _biometricThresholdController,
                          hint: '5000.00',
                        ),
                        SizedBox(height: 12.h),

                        // PIN Requirement Toggle
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 8,
                                offset: Offset(0, 2),
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
                                      color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.pin,
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
                                          'Require PIN for All Transactions',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          'Always require PIN verification',
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Switch(
                                    value: _requirePinForAll,
                                    onChanged: (value) {
                                      setState(() {
                                        _requirePinForAll = value;
                                        _hasChanges = true;
                                      });
                                    },
                                    activeThumbColor: Color.fromARGB(255, 78, 3, 208),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),

                        // Security Tips
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.blue.shade200),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.lightbulb_outline,
                                    color: Colors.blue.shade700,
                                    size: 20.sp,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'Security Tips',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.blue.shade700,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              _buildTip('Keep your daily limit reasonable for your needs'),
                              _buildTip('Enable biometric for large transactions'),
                              _buildTip('Always keep PIN requirement enabled'),
                              _buildTip('Monitor your transaction history regularly'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Save Button (Fixed at bottom)
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: Offset(0, -4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: (isLoading || !_hasChanges) ? null : _saveSettings,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 78, 3, 208),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade300,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 4,
                    ),
                    child: isLoading
                        ? SizedBox(
                            height: 20.h,
                            width: 20.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            'Save Changes',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLimitCard({
    required IconData icon,
    required String label,
    required String description,
    required TextEditingController controller,
    required String hint,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
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
                  color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
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
                      label,
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
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: InputDecoration(
              prefixText: '${CurrencySymbols.currentSymbol} ',
              prefixStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 78, 3, 208),
              ),
              hintText: hint,
              filled: true,
              fillColor: Color(0xFFF5F5F5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 12.h,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an amount';
              }
              final amount = double.tryParse(value);
              if (amount == null || amount <= 0) {
                return 'Please enter a valid amount';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTip(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.blue.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.blue.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
