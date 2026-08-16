import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_passcode_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_passcode_state.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/phone_flow_scaffold.dart';
import 'package:lazervault/src/features/widgets/build_form_field.dart';

/// Step 5 (final): optionally add an email (for account recovery + receipts),
/// then create the account. Email is fully skippable. On success we follow the
/// same post-signup continuation as the email flow: transaction PIN setup →
/// KYC → dashboard (the transaction-PIN screen drives KYC + dashboard itself).
class PhoneOptionalEmailScreen extends StatefulWidget {
  const PhoneOptionalEmailScreen({super.key});

  @override
  State<PhoneOptionalEmailScreen> createState() =>
      _PhoneOptionalEmailScreenState();
}

class _PhoneOptionalEmailScreenState extends State<PhoneOptionalEmailScreen> {
  final _email = TextEditingController();
  String? _error;
  // Tracks whether the account was created WITH an email, so on success we can
  // offer the optional email-verification step before continuing to PIN setup.
  bool _submittedWithEmail = false;

  late final String _firstName;
  late final String _lastName;
  late final String _referralCode;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    final map = args is Map ? Map<String, dynamic>.from(args) : const {};
    _firstName = (map['firstName'] as String?)?.trim() ?? '';
    _lastName = (map['lastName'] as String?)?.trim() ?? '';
    _referralCode = (map['referralCode'] as String?)?.trim() ?? '';
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$').hasMatch(email);
  }

  void _submit({required bool withEmail}) {
    final email = _email.text.trim();
    if (withEmail) {
      if (email.isEmpty || !_isValidEmail(email)) {
        setState(() => _error = 'Please enter a valid email, or skip this step.');
        return;
      }
    }
    _submittedWithEmail = withEmail && email.isNotEmpty;
    context.read<PhonePasscodeCubit>().submitSignup(
          firstName: _firstName,
          lastName: _lastName,
          email: withEmail ? email : null,
          referralCode: _referralCode.isEmpty ? null : _referralCode,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhonePasscodeCubit, PhonePasscodeState>(
      listener: (context, state) {
        if (state is PhoneSignupSuccess) {
          if (_submittedWithEmail) {
            // Optional email verification (backend already sent the code at
            // signup). Skippable; on verify OR skip it continues to the same
            // next step via nextRoute. The user is already authenticated, so
            // the authenticated verifyEmail call succeeds.
            Get.offAllNamed(AppRoutes.emailVerification, arguments: {
              'email': _email.text.trim(),
              'codeSent': true,
              'isRequired': false,
              'nextRoute': AppRoutes.transactionPinSetup,
            });
          } else {
            // No email — continue straight to the same post-signup chain as the
            // email flow. The transaction-PIN screen advances to KYC + dashboard.
            Get.offAllNamed(AppRoutes.transactionPinSetup);
          }
        } else if (state is PhonePasscodeFailure) {
          Get.snackbar('Error', state.message,
              snackPosition: SnackPosition.TOP);
        }
      },
      builder: (context, state) {
        final isLoading = state is PhonePasscodeLoading;
        return PhoneFlowScaffold(
          title: 'Add an email',
          subtitle:
              'Optional — used for account recovery and receipts. You can add it later.',
          step: 5,
          totalSteps: 5,
          primaryLabel: 'Create account',
          isLoading: isLoading,
          onPrimary: isLoading ? null : () => _submit(withEmail: true),
          secondaryAction: TextButton(
            onPressed: isLoading ? null : () => _submit(withEmail: false),
            child: Text(
              'Skip for now',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
          ),
          children: [
            SizedBox(height: 8.h),
            BuildFormField(
              name: 'email',
              placeholder: 'Email (optional)',
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.email_outlined, color: Colors.black45),
              onChanged: (_) {
                if (_error != null) setState(() => _error = null);
              },
            ),
            if (_error != null) ...[
              SizedBox(height: 12.h),
              Text(
                _error!,
                style: TextStyle(
                  color: Colors.red.shade300,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
