import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_passcode_cubit.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/phone_flow_scaffold.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/legal_consent_text.dart';
import 'package:lazervault/src/features/widgets/build_form_field.dart';

/// Step 4 of 5: collect the user's name, date of birth and optional
/// username/referral. Email moved to its OWN step (step 5,
/// [PhoneEmailVerificationScreen]) where it is entered AND verified. These
/// details are just stashed on the cubit here; the account is created on the
/// email step once the email is supplied. After step 5 the flow continues to
/// transaction-PIN setup → KYC → dashboard.
class PhonePersonalDetailsScreen extends StatefulWidget {
  const PhonePersonalDetailsScreen({super.key});

  @override
  State<PhonePersonalDetailsScreen> createState() =>
      _PhonePersonalDetailsScreenState();
}

class _PhonePersonalDetailsScreenState
    extends State<PhonePersonalDetailsScreen> {
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _username = TextEditingController();
  final _referral = TextEditingController();
  final _dobController = TextEditingController();
  DateTime? _dob;
  String? _error;

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _username.dispose();
    _referral.dispose();
    _dobController.dispose();
    super.dispose();
  }

  /// ISO 8601 date (YYYY-MM-DD) for the backend `date_of_birth` field.
  String _isoDate(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  Future<void> _pickDob() async {
    final now = DateTime.now();
    // Must be at least 13 to open an account; cap the calendar accordingly.
    final maxDate = DateTime(now.year - 13, now.month, now.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: _dob ?? DateTime(now.year - 20, 1, 1),
      firstDate: DateTime(1900),
      lastDate: maxDate,
      helpText: 'Select your date of birth',
    );
    if (picked != null) {
      setState(() {
        _dob = picked;
        _dobController.text = _isoDate(picked);
        if (_error != null) _error = null;
      });
    }
  }

  void _onContinue() {
    final first = _firstName.text.trim();
    final last = _lastName.text.trim();
    if (first.isEmpty || last.isEmpty) {
      setState(() => _error = 'Please enter your first and last name.');
      return;
    }
    if (_dob == null) {
      setState(() => _error = 'Please select your date of birth.');
      return;
    }
    final referral = _referral.text.trim();
    final username = _username.text.trim();
    // Stash the details and continue to the dedicated email + verification
    // step, which creates the account once the user supplies (and, when
    // required, verifies) the email.
    context.read<PhonePasscodeCubit>().stashDetails(
          firstName: first,
          lastName: last,
          dateOfBirth: _isoDate(_dob!),
          username: username.isEmpty ? null : username,
          referralCode: referral.isEmpty ? null : referral,
        );
    Get.toNamed(AppRoutes.phoneEmailVerification);
  }

  @override
  Widget build(BuildContext context) {
    // Plain form — the account is NOT created here. We stash these details and
    // the next step (email + verification) creates the account. (No BlocConsumer:
    // this screen stays mounted beneath the pushed email step, so it must not
    // react to the cubit's signup states — the email step owns those.)
    return PhoneFlowScaffold(
      title: 'Your details',
      subtitle: 'We use these to personalise and secure your account.',
      step: 4,
      totalSteps: 5,
      primaryLabel: 'Continue',
      onPrimary: _onContinue,
      children: [
        SizedBox(height: 8.h),
        BuildFormField(
          name: 'firstName',
          placeholder: 'First Name',
          controller: _firstName,
          textCapitalization: TextCapitalization.words,
          prefixIcon: const Icon(Icons.person_outline, color: Colors.black45),
          onChanged: (_) {
            if (_error != null) setState(() => _error = null);
          },
        ),
        SizedBox(height: 12.h),
        BuildFormField(
          name: 'lastName',
          placeholder: 'Last Name',
          controller: _lastName,
          textCapitalization: TextCapitalization.words,
          prefixIcon: const Icon(Icons.person_outline, color: Colors.black45),
          onChanged: (_) {
            if (_error != null) setState(() => _error = null);
          },
        ),
        SizedBox(height: 12.h),
        // Tappable date field: AbsorbPointer lets the outer GestureDetector
        // own the tap (BuildFormField only wires onTap when `disabled`).
        GestureDetector(
          onTap: _pickDob,
          child: AbsorbPointer(
            child: BuildFormField(
              name: 'dateOfBirth',
              placeholder: 'Date of Birth',
              controller: _dobController,
              readOnly: true,
              prefixIcon:
                  const Icon(Icons.cake_outlined, color: Colors.black45),
              suffixIcon:
                  const Icon(Icons.calendar_today, color: Colors.black45),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        BuildFormField(
          name: 'username',
          placeholder: 'Username / Lazertag (optional)',
          controller: _username,
          autocorrect: false,
          enableSuggestions: false,
          prefixIcon: const Icon(Icons.alternate_email, color: Colors.black45),
          onChanged: (_) {
            if (_error != null) setState(() => _error = null);
          },
        ),
        SizedBox(height: 12.h),
        BuildFormField(
          name: 'referralCode',
          placeholder: 'Referral Code (optional)',
          controller: _referral,
          prefixIcon: const Icon(Icons.card_giftcard, color: Colors.black45),
          textCapitalization: TextCapitalization.characters,
        ),
        if (_error != null) ...[
          SizedBox(height: 12.h),
          Text(
            _error!,
            style: TextStyle(
              color: const Color(0xFFEF4444),
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
        SizedBox(height: 16.h),
        // Implicit legal consent — "Continue" here leads directly to account
        // creation (email verification step). Store-review requirement;
        // links open the admin-configured Terms/Privacy in the themed
        // webview.
        const LegalConsentText(action: 'Continue'),
      ],
    );
  }
}
