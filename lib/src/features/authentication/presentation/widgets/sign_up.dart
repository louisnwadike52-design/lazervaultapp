import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart'; // Import intl for date formatting
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utilities/responsive_controller.dart';
import 'package:lazervault/src/features/widgets/build_form_field.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';
import 'package:lazervault/src/features/widgets/locked_country_phone_input.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/core/config/country_config.dart';
import 'package:get/get.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  final LocalAuthentication auth = LocalAuthentication();
  late PageController _pageController;
  bool isPasswordObscured = true;
  DateTime? _selectedDate; // Store selected date - managed by cubit state now
  late ResponsiveController _responsiveController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _responsiveController = ResponsiveController(context);
    // Initialize the sign-up process in the cubit after the frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<AuthenticationCubit>().startSignUp();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    // Optionally reset the cubit state if navigating away definitively
    // context.read<AuthenticationCubit>().cancelSignUp(); // Or handle in routing
    super.dispose();
  }

  /// **Date Picker Function - Uses native date picker for each platform**
  Future<void> _showDatePicker() async {
    final currentContext = context;
    // Read state only if it's SignUpInProgress
    DateTime initialPickerDate = DateTime(2000, 1, 1);
    final currentState = currentContext.read<AuthenticationCubit>().state;
    if (currentState is SignUpInProgress) {
       initialPickerDate = currentState.selectedDate ?? initialPickerDate;
    }

    DateTime? pickedDate;

    // Use platform-specific date picker
    if (Theme.of(currentContext).platform == TargetPlatform.iOS) {
      // iOS native picker
      await showCupertinoModalPopup<void>(
        context: currentContext,
        builder: (BuildContext context) {
          DateTime tempPickedDate = initialPickerDate;
          return Container(
            height: 250.h,
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        pickedDate = tempPickedDate;
                        Navigator.of(context).pop();
                      },
                      child: const Text('Done'),
                    ),
                  ],
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: initialPickerDate,
                    minimumDate: DateTime(1900),
                    maximumDate: DateTime.now(),
                    onDateTimeChanged: (DateTime newDate) {
                      tempPickedDate = newDate;
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      // Android/Material native picker
      pickedDate = await showDatePicker(
        context: currentContext,
        initialDate: initialPickerDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );
    }

    if (pickedDate != null && currentContext.mounted) {
      // Call the cubit method to update the date
      currentContext.read<AuthenticationCubit>().signUpDateOfBirthChanged(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    // AuthenticationCubit should be provided higher up the tree
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        // Use object destructuring within the listener
        switch (state) {
          // Removed duplicate error snackbar - cubit already shows errors via _showErrorSnackbar
           case SignUpInProgress(currentPage: final pageNum): // Destructure page number
             // Handle page changes triggered by cubit state update
             if (_pageController.hasClients && _pageController.page?.round() != pageNum) {
                  _pageController.animateToPage(
                      pageNum,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                  );
             }
             break;
          case AuthenticationError(message: final msg): // Destructure error message
            Get.snackbar(
              'Error',
              msg,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.redAccent,
              colorText: Colors.white,
              margin: EdgeInsets.all(15.w),
              borderRadius: 10.r,
            );
            // IMPORTANT: Ensure the Cubit emits SignUpInProgress state with previous
            // fullName, selectedDate, and phoneNumber after this error to prevent fields clearing.
            break;
          case AuthenticationSuccess():
            // This case is typically for login, not signup
            // Signup uses UserCreated state
            break;
          case UserCreated(): // Handle successful user creation
            // Navigate to PRIMARY credential OTP screen only
            // Secondary verification will be shown after primary is complete
            final cubit = context.read<AuthenticationCubit>();
            final signupState = cubit.state;

            String? phoneNumber;
            String? email;
            PrimaryContactType primaryType = PrimaryContactType.email;

            // Get data from SignUpInProgress state if available
            if (signupState is SignUpInProgress) {
              phoneNumber = signupState.phoneNumber;
              email = signupState.email;
              primaryType = signupState.primaryContactType;
            } else if (cubit.currentProfile != null) {
              // Fallback to profile data
              phoneNumber = cubit.currentProfile!.user.phoneNumber;
              email = cubit.currentProfile!.user.email;
            }

            // Determine if secondary verification is needed
            final hasSecondaryPhone = phoneNumber != null && phoneNumber.isNotEmpty;
            final hasSecondaryEmail = email != null && email.isNotEmpty;

            // Navigate based on PRIMARY contact type
            // Note: No "Account Created" snackbar here since email is sent after ID verification
            if (primaryType == PrimaryContactType.phone) {
              // Navigate to phone OTP (required) - pass secondary email info
              Get.offAllNamed(AppRoutes.phoneVerification, arguments: {
                'phoneNumber': phoneNumber,
                'codeSent': true,
                'expiresIn': 600,
                'isRequired': true,
                'secondaryEmail': hasSecondaryEmail ? email : null,
              });
            } else {
              // Default to email verification (email is primary)
              // Navigate to email OTP (required) - pass secondary phone info
              Get.offAllNamed(AppRoutes.emailVerification, arguments: {
                'email': email,
                'codeSent': true,
                'isRequired': true,
                'secondaryPhone': hasSecondaryPhone ? phoneNumber : null,
              });
            }
            break;
          default:
             // Handle other states or do nothing
             break;
        }
      },
      // Use BlocBuilder to react to state changes for UI rendering
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
           // Destructure state values for UI
           final (
             :currentPage,
             :isLoading,
             :initialEmail,
             :firstName,
             :lastName,
             :selectedDate,
             :phoneNumber,
             :countryCode,
             :countryName,
             :bvn,
             :nin,
             :identityType,
             :bvnVerified,
           ) = switch (state) {
              SignUpInProgress p => (
                  currentPage: p.currentPage,
                  isLoading: p.isLoading,
                  initialEmail: p.email,
                  firstName: p.firstName,
                  lastName: p.lastName,
                  selectedDate: p.selectedDate,
                  phoneNumber: p.phoneNumber,
                  countryCode: p.countryCode,
                  countryName: p.countryName,
                  bvn: p.bvn,
                  nin: p.nin,
                  identityType: p.identityType,
                  bvnVerified: p.bvnVerified,
              ),
              _ => (
                  currentPage: 0,
                  isLoading: false,
                  initialEmail: null,
                  firstName: null,
                  lastName: null,
                  selectedDate: null,
                  phoneNumber: null,
                  countryCode: 'NG',
                  countryName: 'Nigeria',
                  bvn: '',
                  nin: '',
                  identityType: IdentityType.bvn,
                  bvnVerified: false,
              )
           };

          // Handle other loading states if necessary
          final bool showGlobalLoading = state is CreatingUser || state is GettingUsers; // Example
          final bool displayLoading = isLoading || showGlobalLoading;

          return Column(
            children: [
              // --- Back Button ---
              Visibility(
                visible: currentPage > 0, // Use destructured value
                child: Padding(
                  padding: EdgeInsets.only(top: 50.0.h),
                  child: Row(children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      // Ensure cubit handles going back correctly
                      onPressed: () => context.read<AuthenticationCubit>().signUpPreviousPage(),
                    ),
                  ]),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: _responsiveController.screenHeight * (currentPage > 0 ? 0.04 : 0.15)), // Use destructured value
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: UniversalImageLoader(
                              imagePath: AppData.appLogo,
                              height: 70.0.h,
                              width: 70.0.w),
                        ),
                        // Hide "Hi there" text on page 3 (ID verification) since it has its own heading
                        if (currentPage != 3) ...[
                          Text("Hi there 👋",
                              style: TextStyle(
                                  fontSize: 18.0.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black)),
                          SizedBox(height: 8.0.h),
                          Text("Welcome to Lazervault, let's get started!",
                              style: TextStyle(
                                  fontSize: 16.0.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54)),
                          SizedBox(height: 20.0.h),
                        ],
                        // Page content based on currentPage
                        // Page 0: Country Selection
                        // Page 1: Email/Phone + Password
                        // Page 2: Personal Info
                        // Page 3: BVN/NIN Verification
                        if (currentPage == 0)
                          _buildCountrySelectionPage(context, countryCode: countryCode, countryName: countryName, isLoading: displayLoading)
                        else if (currentPage == 1)
                          _buildEmailPasswordPage(context, initialEmail: initialEmail, isLoading: displayLoading)
                        else if (currentPage == 2)
                          _buildPersonalInfoPage(context, initialFirstName: firstName, initialLastName: lastName, selectedDate: selectedDate, initialPhoneNumber: phoneNumber, isLoading: displayLoading)
                        else if (currentPage == 3)
                          _buildBvnVerificationPage(context, bvn: bvn, nin: nin, identityType: identityType, bvnVerified: bvnVerified, isLoading: displayLoading),
                        SizedBox(height: 24.0.h),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: 20.0.h),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                        SizedBox(width: 8.w),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () => Get.toNamed(AppRoutes.emailSignIn),
                        )
                      ])),
            ],
          );
        },
      ),
    );
  }

  // Helper method for Country Selection Page (Page 0)
  Widget _buildCountrySelectionPage(BuildContext context, {required String countryCode, required String countryName, required bool isLoading}) {
    // Get active countries from CountryConfigs
    final activeCountries = CountryConfigs.activeCountries;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Your Country",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "We'll customize your experience based on your location.",
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: 24.h),

        // Supported Countries from CountryConfigs
        ...activeCountries.map((config) {
          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: _buildCountryOption(
              context,
              countryCode: config.code,
              countryName: config.name,
              currencyCode: config.currency,
              flag: config.flag,
              isSelected: countryCode == config.code,
              isSupported: config.isAvailableForSignup,
              isBeta: config.isBeta,
            ),
          );
        }),

        SizedBox(height: 32.h),

        // Continue Button
        SizedBox(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: countryCode.isNotEmpty ? Colors.blue : Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            onPressed: isLoading || countryCode.isEmpty
                ? null
                : () => context.read<AuthenticationCubit>().signUpNextPage(),
            child: isLoading
                ? SizedBox(
                    height: 24.h,
                    width: 24.h,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  // Helper to build country option card
  Widget _buildCountryOption(
    BuildContext context, {
    required String countryCode,
    required String countryName,
    required String currencyCode,
    required String flag,
    required bool isSelected,
    required bool isSupported,
    bool isBeta = false,
  }) {
    return GestureDetector(
      onTap: isSupported
          ? () => context.read<AuthenticationCubit>().signUpCountryChanged(countryCode, countryName, currencyCode)
          : null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? Colors.blue : (isSupported ? Colors.grey.shade300 : Colors.grey.shade200),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(flag, style: TextStyle(fontSize: 28.sp)),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    countryName,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: isSupported ? Colors.black87 : Colors.grey,
                    ),
                  ),
                  Text(
                    currencyCode,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: isSupported ? Colors.black54 : Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: Colors.blue, size: 24.sp)
            else if (isBeta)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  "Beta",
                  style: TextStyle(fontSize: 12.sp, color: Colors.purple.shade700),
                ),
              )
            else if (!isSupported)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  "Soon",
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Helper method for Email/Password Page (Page 1)
  Widget _buildEmailPasswordPage(BuildContext context, {String? initialEmail, required bool isLoading}) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        final password = state is SignUpInProgress ? state.password : '';
        final confirmPassword = state is SignUpInProgress ? state.confirmPassword : '';
        final primaryContactType = state is SignUpInProgress ? state.primaryContactType : PrimaryContactType.none;
        final email = state is SignUpInProgress ? state.email : '';
        final phoneNumber = state is SignUpInProgress ? state.phoneNumber : '';

        // Password validation checks
        final hasMinLength = password.length >= 8;
        final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
        final hasLowercase = RegExp(r'[a-z]').hasMatch(password);
        final hasDigit = RegExp(r'[0-9]').hasMatch(password);
        final hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=\[\]\\\/;`~]').hasMatch(password);
        final passwordsMatch = password.isNotEmpty && confirmPassword.isNotEmpty && password == confirmPassword;

        // Show indicators only if user has started typing
        final showPasswordIndicators = password.isNotEmpty;
        final showConfirmPasswordIndicator = confirmPassword.isNotEmpty;

        // All password requirements met
        final allPasswordRequirementsMet = hasMinLength && hasUppercase && hasLowercase && hasDigit && hasSpecialChar;

        // Get current value for unified field (email or phone)
        final currentContactValue = primaryContactType == PrimaryContactType.phone
            ? phoneNumber
            : (email.isNotEmpty ? email : initialEmail ?? '');

        // Determine icon based on detected type
        final contactIcon = primaryContactType == PrimaryContactType.phone
            ? Icons.phone
            : (primaryContactType == PrimaryContactType.email ? Icons.email : Icons.person_outline);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Unified Email or Phone Number field
            BuildFormField(
              name: "emailOrPhone",
              placeholder: "Email or Phone Number",
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icon(contactIcon, color: Colors.black45),
              initialValue: currentContactValue,
              onChanged: (value) => context.read<AuthenticationCubit>().signUpEmailOrPhoneChanged(value),
            ),
            // Show hint about detected type
            if (primaryContactType != PrimaryContactType.none) ...[
              SizedBox(height: 4.0.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                child: Text(
                  primaryContactType == PrimaryContactType.phone
                      ? 'Detected: Phone number'
                      : 'Detected: Email address',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
            SizedBox(height: 8.0.h),
            BuildFormField(
              name: "password",
              placeholder: "Password",
              obscureText: true,
              prefixIcon: const Icon(Icons.lock, color: Colors.black45),
              onChanged: (value) => context.read<AuthenticationCubit>().signUpPasswordChanged(value),
            ),
            // Password validation indicators
            if (showPasswordIndicators && !allPasswordRequirementsMet) ...[
              SizedBox(height: 8.0.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPasswordRequirement('At least 8 characters', hasMinLength),
                    _buildPasswordRequirement('One uppercase letter', hasUppercase),
                    _buildPasswordRequirement('One lowercase letter', hasLowercase),
                    _buildPasswordRequirement('One number', hasDigit),
                    _buildPasswordRequirement('One special character', hasSpecialChar),
                  ],
                ),
              ),
            ],
            SizedBox(height: 8.0.h),
            BuildFormField(
              name: "confirmPassword",
              placeholder: "Confirm password",
              obscureText: true,
              prefixIcon: const Icon(Icons.lock, color: Colors.black45),
              onChanged: (value) => context.read<AuthenticationCubit>().signUpConfirmPasswordChanged(value),
            ),
            // Confirm password match indicator
            if (showConfirmPasswordIndicator && !passwordsMatch) ...[
              SizedBox(height: 4.0.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0.w),
                child: Row(
                  children: [
                    Icon(Icons.close, size: 14.sp, color: Colors.red),
                    SizedBox(width: 4.w),
                    Text(
                      'Passwords do not match',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: 32.0.h),
            // --- Navigation Button ---
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: _responsiveController.screenWidth * 0.4),
                      ),
                      onPressed: () {
                        context.read<AuthenticationCubit>().signUpNextPage();
                      },
                      child: const Text(
                        "Next",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
            SizedBox(height: 16.0.h),
            UniversalImageLoader(imagePath: AppData.orDivider),
            SizedBox(height: 16.0.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialLoginButton(AppData.googleLogo),
                SizedBox(width: 10.w),
                _socialLoginButton(AppData.appleLogo),
              ],
            ),
          ],
        );
      },
    );
  }

  // Helper widget for password requirement indicator
  Widget _buildPasswordRequirement(String text, bool isMet) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0.h),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.cancel,
            size: 14.sp,
            color: isMet ? Colors.green : Colors.red,
          ),
          SizedBox(width: 6.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              color: isMet ? Colors.green : Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for Personal Info Page (Page 2)
  Widget _buildPersonalInfoPage(BuildContext context, {String? initialFirstName, String? initialLastName, DateTime? selectedDate, String? initialPhoneNumber, required bool isLoading}) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        final primaryContactType = state is SignUpInProgress ? state.primaryContactType : PrimaryContactType.none;
        final email = state is SignUpInProgress ? state.email : '';
        final countryCode = state is SignUpInProgress ? state.countryCode : 'NG';

        return Column(
          children: [
            // Linter Fix: Separate First Name field
            BuildFormField(
              name: "firstname",
              placeholder: "First Name",
              prefixIcon: const Icon(Icons.person_outline, color: Colors.black45),
              initialValue: initialFirstName,
              onChanged: (value) => context.read<AuthenticationCubit>().signUpFirstNameChanged(value),
            ),
            SizedBox(height: 8.0.h),
            // Linter Fix: Separate Last Name field
            BuildFormField(
              name: "lastname",
              placeholder: "Last Name",
              prefixIcon: const Icon(Icons.person_outline, color: Colors.black45),
              initialValue: initialLastName,
              onChanged: (value) => context.read<AuthenticationCubit>().signUpLastNameChanged(value),
            ),
            SizedBox(height: 8.0.h),
            // Username field
            BuildFormField(
              name: "username",
              placeholder: "Username (optional)",
              prefixIcon: const Icon(Icons.alternate_email, color: Colors.black45),
              onChanged: (value) => context.read<AuthenticationCubit>().signUpUsernameChanged(value),
            ),
            SizedBox(height: 8.0.h),
            // Referral code field
            BuildFormField(
              name: "referralCode",
              placeholder: "Referral Code (optional)",
              prefixIcon: const Icon(Icons.card_giftcard, color: Colors.black45),
              textCapitalization: TextCapitalization.characters,
              onChanged: (value) => context.read<AuthenticationCubit>().signUpReferralCodeChanged(value.toUpperCase()),
            ),
            SizedBox(height: 8.0.h),
            // DOB field
            GestureDetector(
              onTap: _showDatePicker,
              child: AbsorbPointer(
                child: BuildFormField(
                  name: "dob",
                  initialValue: selectedDate == null
                      ? null
                      : DateFormat('dd MMM yyyy').format(selectedDate),
                  placeholder: "Select Date of Birth",
                  prefixIcon:
                      const Icon(Icons.calendar_today, color: Colors.black45),
                  readOnly: true,
                ),
              ),
            ),
            SizedBox(height: 8.0.h),

            // Show opposite field based on what was entered on page 1
            // If user entered email on page 1, show phone field (optional)
            // If user entered phone on page 1, show email field (optional)
            if (primaryContactType == PrimaryContactType.email)
              LockedCountryPhoneInput(
                countryCode: countryCode,
                initialValue: initialPhoneNumber,
                hintText: 'Phone Number (Optional)',
                isRequired: false,
                onChanged: (value) {
                  context.read<AuthenticationCubit>().signUpPhoneNumberChanged(value);
                },
              )
            else if (primaryContactType == PrimaryContactType.phone)
              BuildFormField(
                name: "email",
                placeholder: "Email (Optional)",
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email, color: Colors.black45),
                initialValue: email,
                onChanged: (value) => context.read<AuthenticationCubit>().signUpEmailChanged(value),
              )
            else
              // Fallback: Show phone if primaryContactType is none (shouldn't happen if page 1 validation works)
              // Use LockedCountryPhoneInput with pre-filled country code
              LockedCountryPhoneInput(
                countryCode: countryCode,
                initialValue: initialPhoneNumber,
                hintText: 'Phone Number',
                onChanged: (value) {
                  context.read<AuthenticationCubit>().signUpPhoneNumberChanged(value);
                },
              ),
            SizedBox(height: 32.0.h),
            // --- Navigation Button (Continue to BVN verification) ---
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: isLoading
                    ? null
                    : () => context.read<AuthenticationCubit>().signUpNextPage(),
                child: isLoading
                    ? SizedBox(
                        height: 24.h,
                        width: 24.h,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Helper method for Identity Verification Page (Page 3) - Multi-country support
  Widget _buildBvnVerificationPage(
    BuildContext context, {
    required String bvn,
    required String nin,
    required IdentityType identityType,
    required bool bvnVerified,
    required bool isLoading,
  }) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        final countryCode = state is SignUpInProgress ? state.countryCode : 'NG';
        final identityValue = state is SignUpInProgress ? state.identityValue : '';
        final availableIdTypes = IdentityTypeExtension.forCountry(countryCode);

        // Get description text based on country
        String getCountryVerificationDescription() {
          switch (countryCode) {
            case 'NG':
              return "For security and compliance, we need to verify your identity using your BVN or NIN.";
            case 'GB':
              return "For security and compliance, we need to verify your identity using your passport or driving licence.";
            case 'US':
              return "For security and compliance, we need to verify your identity. We only need the last 4 digits of your SSN.";
            case 'GH':
              return "For security and compliance, we need to verify your identity using your Ghana Card or other government ID.";
            case 'KE':
              return "For security and compliance, we need to verify your identity using your National ID or passport.";
            case 'ZA':
              return "For security and compliance, we need to verify your identity using your South African ID number.";
            default:
              return "For security and compliance, we need to verify your identity.";
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Verify Your Identity",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              getCountryVerificationDescription(),
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 24.h),

            // Identity Type Selector - Dynamic based on country
            if (availableIdTypes.length > 1)
              Row(
                children: availableIdTypes.map((idType) {
                  final isSelected = identityType == idType;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: idType != availableIdTypes.last ? 12.w : 0,
                      ),
                      child: GestureDetector(
                        onTap: () => context.read<AuthenticationCubit>().signUpIdentityTypeChanged(idType),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.blue : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            idType.displayName,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            SizedBox(height: 20.h),

            // Identity Input Field - Dynamic based on identity type
            BuildFormField(
              name: "identityValue",
              placeholder: identityType.placeholder,
              keyboardType: _getKeyboardType(identityType),
              prefixIcon: Icon(Icons.badge_outlined, color: Colors.black45),
              initialValue: _getInitialValue(identityType, bvn, nin, identityValue),
              maxLength: identityType.maxLength,
              onChanged: (value) {
                // Update the appropriate field based on identity type
                if (identityType == IdentityType.bvn) {
                  context.read<AuthenticationCubit>().signUpBvnChanged(value);
                } else if (identityType == IdentityType.nin) {
                  context.read<AuthenticationCubit>().signUpNinChanged(value);
                } else {
                  context.read<AuthenticationCubit>().signUpIdentityValueChanged(value);
                }
              },
            ),
            SizedBox(height: 8.h),

            // Info text about the selected identity type
            if (identityType.description.isNotEmpty)
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue.shade400, size: 20.sp),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        identityType.description,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (identityType.description.isNotEmpty) SizedBox(height: 20.h),

            // Verification Status
            if (bvnVerified)
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.green.shade300),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 24.sp),
                    SizedBox(width: 12.w),
                    Text(
                      "Identity verified successfully!",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 24.h),

            // Progressive KYC info card - explains why verification matters
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.amber.shade700, size: 20.sp),
                      SizedBox(width: 8.w),
                      Text(
                        'Why verify now?',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.amber.shade700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    countryCode == 'NG'
                        ? 'Verification unlocks ₦500,000 daily limit. Without it, you\'ll be limited to ₦50,000/day.'
                        : 'Verification unlocks higher transaction limits and full access to all features.',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.brown.shade700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // Verify Button
            if (!bvnVerified)
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: isLoading
                      ? null
                      : () => context.read<AuthenticationCubit>().verifyIdentity(),
                  child: isLoading
                      ? SizedBox(
                          height: 24.h,
                          width: 24.h,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.verified, color: Colors.white, size: 20.sp),
                            SizedBox(width: 8.w),
                            Text(
                              "Verify ${identityType.displayName}",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            SizedBox(height: 12.h),

            // Skip for now button (only shown if not verified)
            if (!bvnVerified)
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey.shade700,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  onPressed: isLoading ? null : () => _showSkipDialog(context, countryCode),
                  child: Text(
                    'Skip for now',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            SizedBox(height: 8.h),

            // Small info text
            if (!bvnVerified)
              Center(
                child: Text(
                  'You can complete verification anytime from Settings',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            SizedBox(height: bvnVerified ? 24.h : 0.h),

            // Complete Signup Button (only shown after verification)
            if (bvnVerified) ...[
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: isLoading
                      ? null
                      : () => context.read<AuthenticationCubit>().signUpSubmitted(),
                  child: isLoading
                      ? SizedBox(
                          height: 24.h,
                          width: 24.h,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          "Continue",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  // Helper to get keyboard type based on identity type
  TextInputType _getKeyboardType(IdentityType identityType) {
    switch (identityType) {
      case IdentityType.bvn:
      case IdentityType.nin:
      case IdentityType.ssn:
      case IdentityType.kenyaNationalId:
      case IdentityType.saId:
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }

  // Helper to get initial value based on identity type
  String _getInitialValue(IdentityType identityType, String bvn, String nin, String identityValue) {
    switch (identityType) {
      case IdentityType.bvn:
        return bvn;
      case IdentityType.nin:
        return nin;
      default:
        return identityValue;
    }
  }

  Widget _socialLoginButton(String imagePath) {
    return InkWell(
      onTap: () {
        print("Social login tapped for: $imagePath");
        Get.snackbar(
          'Social Login',
          'Social login not yet implemented.',
          snackPosition: SnackPosition.TOP,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 50.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.0),
          border: Border.all(color: Colors.black, width: 1.2),
        ),
        child: UniversalImageLoader(
          imagePath: imagePath,
          height: 24.0.h,
          width: 24.0.w,
        ),
      ),
    );
  }

  /// Shows skip confirmation dialog for progressive KYC
  void _showSkipDialog(BuildContext context, String countryCode) {
    final tier1Limit = countryCode == 'NG' ? '₦50,000' : 'limited amount';

    Get.defaultDialog(
      title: 'Skip Identity Verification?',
      titleStyle: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      middleText: 'You\'ll have a Tier 1 account with a daily limit of $tier1Limit. You can complete verification later from Settings to unlock higher limits.',
      middleTextStyle: TextStyle(
        fontSize: 14.sp,
        color: Colors.black54,
        height: 1.5,
      ),
      textConfirm: 'Skip & Continue',
      textCancel: 'Verify Now',
      confirmTextColor: Colors.white,
      buttonColor: Colors.grey.shade600,
      cancelTextColor: Colors.blue,
      radius: 16.r,
      onConfirm: () {
        Get.back(); // Close dialog
        // Skip verification and proceed with signup as Tier 1
        context.read<AuthenticationCubit>().skipIdentityVerification();
      },
      onCancel: () {
        Get.back(); // Close dialog
        // User stays on verification page
      },
      barrierDismissible: true,
    );
  }
}
