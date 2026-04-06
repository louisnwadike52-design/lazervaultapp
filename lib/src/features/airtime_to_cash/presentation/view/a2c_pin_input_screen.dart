import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../widgets/a2c_step_indicator.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';
import '../../../../../../core/types/app_routes.dart';

class A2CPinInputScreen extends StatefulWidget {
  const A2CPinInputScreen({super.key});

  @override
  State<A2CPinInputScreen> createState() => _A2CPinInputScreenState();
}

class _A2CPinInputScreenState extends State<A2CPinInputScreen>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  final _pinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _skipOTP = false; // Flag to indicate if OTP was skipped

  @override
  void initState() {
    super.initState();
    // Check if OTP was skipped
    final args = Get.arguments as Map<String, dynamic>?;
    _skipOTP = args?['skipOTP'] == true;
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _handleSubmit() async {
    if (_isLoading) {
      return; // Prevent multiple submissions
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final pin = _pinController.text.trim();
    if (pin.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your SIM transfer PIN',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    final args = Get.arguments as Map<String, dynamic>?;
    final phoneNumber = args?['phoneNumber'] as String?;
    final network = args?['network'] as String?;
    final amount = args?['amount'] as double?;
    final sessionToken = args?['sessionToken'] as String?;
    final sessionId = args?['sessionId'] as String?;
    final rate = args?['rate'];
    final estimatedCash = args?['estimatedCash'] as double?;
    final sourceAccountId = args?['sourceAccountId'] as String?;

    // Validate all required fields with detailed error messages
    if (phoneNumber == null || phoneNumber.isEmpty) {
      Get.snackbar(
        'Error',
        'Phone number is missing. Please start over.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      Get.back(); // Go back to previous screen
      return;
    }

    if (network == null || network.isEmpty) {
      Get.snackbar(
        'Error',
        'Network provider is missing. Please start over.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      Get.back();
      return;
    }

    if (amount == null || amount <= 0) {
      Get.snackbar(
        'Error',
        'Invalid amount. Please start over.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      Get.back();
      return;
    }

    if (sessionToken == null || sessionToken.isEmpty) {
      Get.snackbar(
        'Session Expired',
        'Your session has expired. Please start over.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      Get.until((route) => route.settings.name == AppRoutes.airtimeToCash);
      return;
    }

    if (sessionId == null || sessionId.isEmpty) {
      Get.snackbar(
        'Session Expired',
        'Your session has expired. Please start over.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      Get.until((route) => route.settings.name == AppRoutes.airtimeToCash);
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Generate transaction ID
      final transactionId =
          'a2c_${DateTime.now().millisecondsSinceEpoch}_${phoneNumber.replaceAll(RegExp(r'[^\d]'), '')}';

      // Validate transaction PIN before proceeding
      String? verificationToken;

      final success = await validateTransactionPin(
        context: context,
        transactionId: transactionId,
        transactionType: 'airtime_to_cash',
        amount: amount,
        currency: 'NGN',
        title: 'Confirm Airtime to Cash',
        message: 'Confirm airtime to cash conversion of ₦${amount.toStringAsFixed(2)}',
        onPinValidated: (token) async {
          verificationToken = token;
        },
      );

      if (!success || verificationToken == null) {
        if (mounted) {
          setState(() => _isLoading = false);
        }
        // User cancelled transaction PIN validation
        return;
      }

      if (!mounted) return;

      // Navigate to processing screen with all required parameters
      // including the SIM Transfer PIN for Automation API
      Get.offNamed(AppRoutes.airtimeToCashProcessing, arguments: {
        'phoneNumber': phoneNumber,
        'network': network,
        'amount': amount,
        'rate': rate,
        'estimatedCash': estimatedCash,
        'sessionToken': sessionToken,
        'sessionId': sessionId,
        'pin': pin, // SIM Transfer PIN for Automation API
        'transactionId': transactionId,
        'verificationToken': verificationToken,
        'sourceAccountId': sourceAccountId,
      });
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        Get.snackbar(
          'Error',
          'An error occurred: ${e.toString()}',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 4),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF1A1A3E),
                Color(0xFF0A0E27),
                Color(0xFF0F0F23),
              ],
            ),
          ),
          child: Column(
            children: [
              _buildHeader(),
              const A2CStepIndicator(
                currentStep: 4,
                totalSteps: 5,
                stepLabels: ['Network', 'Details', 'Review', 'Verify', 'PIN'],
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40.h),
                        _buildTitle(),
                        SizedBox(height: 16.h),
                        _buildDescription(),
                        SizedBox(height: 40.h),
                        _buildPinInput(),
                        SizedBox(height: 24.h),
                        _buildSecurityNote(),
                        SizedBox(height: 40.h),
                        _buildSubmitButton(),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          const SizedBox(width: 8),
          const Text(
            'Airtime to Cash',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Enter SIM Transfer PIN',
      style: TextStyle(
        color: Colors.white,
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDescription() {
    final description = _skipOTP
        ? 'Enter your SIM transfer PIN to complete the airtime conversion. This is the PIN you use to transfer airtime from your phone.'
        : 'Enter your SIM transfer PIN to authorize the airtime conversion. This is the PIN you use to transfer airtime from your phone.';

    return Text(
      description,
      style: TextStyle(
        color: Colors.white70,
        fontSize: 14.sp,
        height: 1.5,
      ),
    );
  }

  Widget _buildPinInput() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      padding: EdgeInsets.all(16.w),
      child: TextFormField(
        controller: _pinController,
        keyboardType: TextInputType.number,
        obscureText: true,
        maxLength: 4,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.sp,
          letterSpacing: 8,
        ),
        decoration: const InputDecoration(
          hintText: 'Enter 4-digit PIN',
          hintStyle: TextStyle(color: Colors.white60),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: Colors.white60,
          ),
          border: InputBorder.none,
          counterStyle: TextStyle(color: Colors.white60),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'PIN is required';
          }
          if (value.length != 4) {
            return 'PIN must be 4 digits';
          }
          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
            return 'PIN must contain only numbers';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildSecurityNote() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.orange.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.security,
            color: Colors.orange,
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Your SIM transfer PIN is required by your mobile network operator to authorize airtime transfers. This is the same PIN you use when transferring airtime to another phone.',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 12.sp,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleSubmit,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF10B981),
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.white24,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: _isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                'Continue',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
