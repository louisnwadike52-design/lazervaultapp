import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/internet_provider_entity.dart';
import '../../domain/entities/internet_account_validation_entity.dart';
import '../cubit/internet_bill_cubit.dart';
import '../cubit/internet_bill_state.dart';

/// Per-ISP account input rules are grounded in real VTpass `/merchant-verify`
/// behavior we probed against the sandbox on 2026-04-18 plus the public
/// VTpass API docs. Every rule is sourced, not guessed.
///
/// | ISP         | Input rule                                              | Verify?                |
/// |-------------|---------------------------------------------------------|------------------------|
/// | Smile       | Email OR 10–11 digit Smile number                       | yes, VTpass            |
/// | Spectranet  | 11-digit Nigerian phone (starts with 0)                 | no (PIN-voucher biller)|
/// | IPNX/Swift  | Disabled server-side until VTpass serviceIDs confirmed. | n/a                    |
class _IspInputRules {
  const _IspInputRules({
    required this.keyboardType,
    required this.formatters,
    required this.validator,
    required this.hint,
    required this.help,
    required this.requiresVerification,
  });

  final TextInputType keyboardType;
  final List<TextInputFormatter> formatters;
  final String? Function(String? value) validator;
  final String hint;
  final String help;
  final bool requiresVerification;

  /// Unknown serviceIDs fall back to a conservative digits-only rule and
  /// require verification — any new ISP gets an explicit entry here
  /// before we ship it live.
  static _IspInputRules forServiceId(String serviceId) {
    switch (serviceId.toLowerCase()) {
      case 'smile-direct':
      case 'smile':
        return _smile;
      case 'spectranet':
        return _spectranet;
      default:
        return _genericNumeric;
    }
  }

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
  );

  static final _IspInputRules _smile = _IspInputRules(
    keyboardType: TextInputType.emailAddress,
    formatters: const [],
    requiresVerification: true,
    hint: 'name@example.com or 10-digit Smile number',
    help: 'Enter your Smile email, Smile phone number, or 10-digit Smile '
        'account number.',
    // Two-path validator: if the user typed something with an `@`,
    // we treat it as an email attempt and enforce the RFC-ish
    // pattern. Otherwise we fall through to the numeric branch and
    // enforce Smile's 10/11-digit length rule. Specific error
    // messages on each path so the user knows exactly what to fix
    // instead of seeing a catch-all string.
    validator: (value) {
      final v = (value ?? '').trim();
      if (v.isEmpty) return 'Account is required';

      // Email attempt: anything containing "@". Don't fall back to
      // the digits path once they've committed to an email — it
      // would be confusing to reject "user@x" with "must be 10–11
      // digits".
      if (v.contains('@')) {
        if (!_emailRegex.hasMatch(v)) {
          return 'Enter a valid email address (e.g. name@example.com)';
        }
        return null;
      }

      // Numeric path: strip nothing — Smile accounts are plain digits.
      // Anything else (letters, spaces) is rejected.
      if (RegExp(r'^\d+$').hasMatch(v)) {
        if (v.length < 10) return 'Smile account must be at least 10 digits';
        if (v.length > 11) return 'Smile account can\'t be more than 11 digits';
        return null;
      }

      return 'Enter a valid email or 10–11 digit Smile number';
    },
  );

  static final _IspInputRules _spectranet = _IspInputRules(
    keyboardType: TextInputType.phone,
    formatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(11)],
    requiresVerification: false,
    hint: '0XXXXXXXXXX',
    help: 'Enter the 11-digit Nigerian phone number tied to your '
        'Spectranet PIN subscription. Spectranet does not support '
        'account verification, so this step is skipped.',
    validator: (value) {
      final v = (value ?? '').trim();
      if (v.isEmpty) return 'Phone number is required';
      if (v.length != 11) return 'Phone must be exactly 11 digits';
      if (!v.startsWith('0')) return 'Phone must start with 0';
      return null;
    },
  );

  static final _IspInputRules _genericNumeric = _IspInputRules(
    keyboardType: TextInputType.number,
    formatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(20)],
    requiresVerification: true,
    hint: 'Enter your account number',
    help: 'Enter the account number from your internet provider.',
    validator: (value) {
      final v = (value ?? '').trim();
      if (v.isEmpty) return 'Account number is required';
      if (v.length < 5) return 'Account number must be at least 5 characters';
      return null;
    },
  );
}

class InternetAccountInputScreen extends StatefulWidget {
  const InternetAccountInputScreen({super.key});

  @override
  State<InternetAccountInputScreen> createState() => _InternetAccountInputScreenState();
}

class _InternetAccountInputScreenState extends State<InternetAccountInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _accountController = TextEditingController();
  bool _isValidated = false;
  bool _prefilled = false;
  _IspInputRules? _rules;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = Get.arguments as Map<String, dynamic>;
    final provider = args['provider'] as InternetProviderEntity;
    _rules = _IspInputRules.forServiceId(provider.serviceId);
    // Repeat-purchase / saved-contact entry points pass a pre-filled
    // accountNumber — seed the field once so the user doesn't have to
    // retype the account/email they already used last time.
    if (!_prefilled) {
      final prefill = (args['accountNumber'] as String?)?.trim();
      if (prefill != null && prefill.isNotEmpty) {
        _accountController.text = prefill;
      }
      _prefilled = true;
    }
  }

  @override
  void dispose() {
    _accountController.dispose();
    super.dispose();
  }

  void _onValidate() {
    if (!_formKey.currentState!.validate()) return;
    final args = Get.arguments as Map<String, dynamic>;
    final provider = args['provider'] as InternetProviderEntity;

    context.read<InternetBillCubit>().validateAccount(
          providerId: provider.serviceId,
          accountNumber: _normalizeAccount(_accountController.text),
        );
  }

  /// Normalizes an account input for downstream use. For Smile emails we
  /// lowercase (RFC 5321 local-part is case-insensitive in practice for
  /// Smile's SSO; case-preserving would yield duplicate beneficiary rows
  /// like `User@x.com` vs `user@x.com`). Digits are trimmed only.
  String _normalizeAccount(String raw) {
    final v = raw.trim();
    if (v.contains('@')) return v.toLowerCase();
    return v;
  }

  /// Spectranet (and any future biller with no upstream verify) — we skip
  /// the round-trip and synthesize a locally-validated record so the user
  /// can proceed to package selection.
  void _onProceedWithoutVerify() {
    if (!_formKey.currentState!.validate()) return;
    final args = Get.arguments as Map<String, dynamic>;
    final provider = args['provider'] as InternetProviderEntity;
    final accountNumber = _normalizeAccount(_accountController.text);

    final validation = InternetAccountValidationEntity(
      isValid: true,
      customerName: '${provider.name} Subscriber',
      accountNumber: accountNumber,
      status: 'no_verify_required',
      dueAmount: 0,
    );

    Get.toNamed(
      AppRoutes.internetPackageSelection,
      arguments: {
        'provider': provider,
        'validation': validation,
        'accountNumber': accountNumber,
        if (args['preferRollover'] == true) 'preferRollover': true,
      },
    );
  }

  void _onContinue() {
    final args = Get.arguments as Map<String, dynamic>;
    final provider = args['provider'] as InternetProviderEntity;
    final cubitState = context.read<InternetBillCubit>().state;

    if (cubitState is InternetAccountValidated) {
      Get.toNamed(
        AppRoutes.internetPackageSelection,
        arguments: {
          'provider': provider,
          'validation': cubitState.validation,
          'accountNumber': cubitState.accountNumber,
          if (args['preferRollover'] == true) 'preferRollover': true,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final provider = args['provider'] as InternetProviderEntity;
    final rules = _rules ?? _IspInputRules.forServiceId(provider.serviceId);

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
          'Account Details',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocListener<InternetBillCubit, InternetBillState>(
          listener: (context, state) {
            if (state is InternetAccountValidated) {
              setState(() => _isValidated = true);
            } else if (state is InternetAccountValidationFailed) {
              setState(() => _isValidated = false);
              Get.snackbar(
                'Validation Failed',
                state.message,
                backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
                colorText: Colors.white,
                duration: const Duration(seconds: 3),
                snackPosition: SnackPosition.TOP,
                margin: EdgeInsets.all(16.w),
                borderRadius: 12,
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),

                // Provider info card
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFF2D2D2D), width: 1),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(Icons.wifi, color: const Color(0xFF4E03D0), size: 24.sp),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              provider.name,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              rules.requiresVerification
                                  ? 'Enter your account details below'
                                  : 'Enter your phone number below',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 28.h),

                // Account input form
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rules.requiresVerification
                            ? 'Account Number / Email'
                            : 'Phone Number',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextFormField(
                        controller: _accountController,
                        keyboardType: rules.keyboardType,
                        inputFormatters: rules.formatters,
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
                        decoration: InputDecoration(
                          hintText: rules.hint,
                          hintStyle: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF).withValues(alpha: 0.6),
                            fontSize: 16.sp,
                          ),
                          counterText: '',
                          filled: true,
                          fillColor: const Color(0xFF1F1F1F),
                          prefixIcon: Icon(
                            rules.keyboardType == TextInputType.emailAddress
                                ? Icons.alternate_email
                                : rules.keyboardType == TextInputType.phone
                                    ? Icons.phone_android
                                    : Icons.account_circle_outlined,
                            color: const Color(0xFF9CA3AF),
                            size: 20.sp,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(color: Color(0xFF4E03D0), width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(color: Color(0xFFEF4444), width: 2),
                          ),
                        ),
                        onChanged: (_) {
                          if (_isValidated) setState(() => _isValidated = false);
                        },
                        validator: rules.validator,
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        rules.help,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF).withValues(alpha: 0.8),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // Validation result (verify path only)
                if (rules.requiresVerification)
                  BlocBuilder<InternetBillCubit, InternetBillState>(
                    builder: (context, state) {
                      if (state is InternetAccountValidated && _isValidated) {
                        return _buildValidationResultCard(state);
                      }
                      return const SizedBox.shrink();
                    },
                  ),

                const Spacer(),

                // Action button (verify path vs skip-verify path)
                if (!rules.requiresVerification)
                  _buildButton(
                    label: 'Continue',
                    onPressed: _onProceedWithoutVerify,
                    isLoading: false,
                  )
                else
                  BlocBuilder<InternetBillCubit, InternetBillState>(
                    builder: (context, state) {
                      final isValidating = state is InternetAccountValidating;
                      if (_isValidated && state is InternetAccountValidated) {
                        return _buildButton(
                          label: 'Continue',
                          onPressed: _onContinue,
                          isLoading: false,
                        );
                      }
                      return _buildButton(
                        label: 'Validate Account',
                        onPressed: isValidating ? null : _onValidate,
                        isLoading: isValidating,
                      );
                    },
                  ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildValidationResultCard(InternetAccountValidated state) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.4), width: 1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check_circle, color: const Color(0xFF10B981), size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Text(
                'Account Verified',
                style: GoogleFonts.inter(
                  color: const Color(0xFF10B981),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildDetailRow('Customer Name', state.validation.customerName),
          SizedBox(height: 10.h),
          _buildDetailRow('Account', state.validation.accountNumber),
          if (state.validation.status.isNotEmpty) ...[
            SizedBox(height: 10.h),
            _buildDetailRow('Status', state.validation.status),
          ],
          if (state.validation.dueAmount > 0) ...[
            SizedBox(height: 10.h),
            _buildDetailRow(
              'Due Amount',
              '\u20A6${state.validation.dueAmount.toStringAsFixed(2)}',
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 13.sp),
        ),
        Flexible(
          child: Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required String label,
    required VoidCallback? onPressed,
    required bool isLoading,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4E03D0),
          disabledBackgroundColor: const Color(0xFF4E03D0).withValues(alpha: 0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 24.w,
                height: 24.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                label,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
