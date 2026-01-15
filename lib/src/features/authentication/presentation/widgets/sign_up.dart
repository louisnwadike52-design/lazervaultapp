import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart'; // Import intl for date formatting
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utilities/responsive_controller.dart';
import 'package:lazervault/src/features/widgets/build_form_field.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lazervault/core/data/app_data.dart';
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
            // Signup successful, navigate to verification screen based on primary contact type
            final signupState = context.read<AuthenticationCubit>().state;
            if (signupState is SignUpInProgress) {
              final primaryType = signupState.primaryContactType;
              if (primaryType == PrimaryContactType.phone) {
                Get.snackbar(
                  'Account Created!',
                  'Please verify your phone number to continue.',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  margin: EdgeInsets.all(15.w),
                  borderRadius: 10.r,
                );
                Get.offAllNamed(AppRoutes.phoneVerification, arguments: signupState.phoneNumber);
              } else {
                Get.snackbar(
                  'Account Created!',
                  'Please verify your email to continue.',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  margin: EdgeInsets.all(15.w),
                  borderRadius: 10.r,
                );
                Get.offAllNamed(AppRoutes.emailVerification, arguments: signupState.email);
              }
            } else {
              // Fallback to email verification
              Get.offAllNamed(AppRoutes.emailVerification);
            }
            break;
          case UserCreated(): // Handle successful user creation
            // Determine primary contact type from previous signup state to route correctly
            final cubit = context.read<AuthenticationCubit>();
            final profile = cubit.currentProfile;

            // Try to get the primary contact type from the stored user data
            String? phoneNumber;
            String? email;
            bool usePhoneVerification = false;

            if (profile != null) {
              phoneNumber = profile.user.phoneNumber;
              email = profile.user.email;
              // If phone exists and email is empty, assume phone signup
              usePhoneVerification = phoneNumber != null && phoneNumber.isNotEmpty;
            }

            if (usePhoneVerification) {
              Get.snackbar(
                'Success',
                'Sign up successful! Please verify your phone number.',
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.green,
                colorText: Colors.white,
                margin: EdgeInsets.all(15.w),
                borderRadius: 10.r,
              );
              Get.offAllNamed(AppRoutes.phoneVerification, arguments: phoneNumber);
            } else {
              Get.snackbar(
                'Success',
                'Sign up successful! Please verify your email.',
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.green,
                colorText: Colors.white,
                margin: EdgeInsets.all(15.w),
                borderRadius: 10.r,
              );
              Get.offAllNamed(AppRoutes.emailVerification, arguments: email);
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
           // Linter Fix: Destructure firstName, lastName instead of fullName
           final (:currentPage, :isLoading, :initialEmail, :firstName, :lastName, :selectedDate, :phoneNumber) = switch (state) {
              SignUpInProgress p => (
                  currentPage: p.currentPage,
                  isLoading: p.isLoading,
                  initialEmail: p.email,
                  firstName: p.firstName,
                  lastName: p.lastName,
                  selectedDate: p.selectedDate,
                  phoneNumber: p.phoneNumber 
              ),
              _ => (
                  currentPage: 0,
                  isLoading: false,
                  initialEmail: null,
                  firstName: null,
                  lastName: null,
                  selectedDate: null,
                  phoneNumber: null 
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
                        // Page content based on currentPage
                        if (currentPage == 0)
                          _buildPageOne(context, initialEmail: initialEmail, isLoading: displayLoading)
                        else
                          _buildPageTwo(context, initialFirstName: firstName, initialLastName: lastName, selectedDate: selectedDate, initialPhoneNumber: phoneNumber, isLoading: displayLoading),
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

  // Helper method for Page 1 content
  Widget _buildPageOne(BuildContext context, {String? initialEmail, required bool isLoading}) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        final password = state is SignUpInProgress ? state.password : '';
        final confirmPassword = state is SignUpInProgress ? state.confirmPassword : '';
        final primaryContactType = state is SignUpInProgress ? state.primaryContactType : PrimaryContactType.none;
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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Toggle between Email and Phone Number
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => context.read<AuthenticationCubit>().signUpSetPrimaryContactType(PrimaryContactType.email),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: primaryContactType == PrimaryContactType.email || primaryContactType == PrimaryContactType.none
                              ? Colors.blue
                              : Colors.grey[300],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24.r),
                            bottomLeft: Radius.circular(24.r),
                          ),
                        ),
                        child: Text(
                          'Email',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: primaryContactType == PrimaryContactType.email || primaryContactType == PrimaryContactType.none
                                ? Colors.white
                                : Colors.black54,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => context.read<AuthenticationCubit>().signUpSetPrimaryContactType(PrimaryContactType.phone),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: primaryContactType == PrimaryContactType.phone
                              ? Colors.blue
                              : Colors.grey[300],
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(24.r),
                            bottomRight: Radius.circular(24.r),
                          ),
                        ),
                        child: Text(
                          'Phone Number',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: primaryContactType == PrimaryContactType.phone
                                ? Colors.white
                                : Colors.black54,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0.h),

            // Show Email OR Phone Number field based on selection
            if (primaryContactType == PrimaryContactType.email || primaryContactType == PrimaryContactType.none)
              BuildFormField(
                name: "email",
                placeholder: "Email",
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email, color: Colors.black45),
                initialValue: initialEmail,
                onChanged: (value) => context.read<AuthenticationCubit>().signUpEmailChanged(value),
              )
            else
              IntlPhoneField(
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  hintStyle: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey.shade600,
                  ),
                  fillColor: const Color(0xFFF0F0F0),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0.r),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0.r),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.0.w,
                    vertical: 12.0.h,
                  ),
                ),
                style: TextStyle(fontSize: 16.sp),
                dropdownTextStyle: TextStyle(fontSize: 16.sp),
                initialCountryCode: 'US',
                onChanged: (phone) {
                  context.read<AuthenticationCubit>().signUpPhoneNumberChanged(phone.completeNumber);
                },
              ),
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

  // Helper method for Page 2 content
  // Linter Fix: Accept firstName, lastName instead of fullName
  Widget _buildPageTwo(BuildContext context, {String? initialFirstName, String? initialLastName, DateTime? selectedDate, String? initialPhoneNumber, required bool isLoading}) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        final primaryContactType = state is SignUpInProgress ? state.primaryContactType : PrimaryContactType.none;
        final email = state is SignUpInProgress ? state.email : '';

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
              IntlPhoneField(
                decoration: InputDecoration(
                  hintText: 'Phone Number (Optional)',
                  hintStyle: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey.shade600,
                  ),
                  fillColor: const Color(0xFFF0F0F0),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0.r),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0.r),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.0.w,
                    vertical: 12.0.h,
                  ),
                ),
                style: TextStyle(fontSize: 16.sp),
                dropdownTextStyle: TextStyle(fontSize: 16.sp),
                initialCountryCode: 'US',
                onChanged: (phone) {
                  context.read<AuthenticationCubit>().signUpPhoneNumberChanged(phone.completeNumber);
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
              IntlPhoneField(
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  hintStyle: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey.shade600,
                  ),
                  fillColor: const Color(0xFFF0F0F0),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0.r),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0.r),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.0.w,
                    vertical: 12.0.h,
                  ),
                ),
                style: TextStyle(fontSize: 16.sp),
                dropdownTextStyle: TextStyle(fontSize: 16.sp),
                initialCountryCode: 'US',
                onChanged: (phone) {
                  context.read<AuthenticationCubit>().signUpPhoneNumberChanged(phone.completeNumber);
                },
              ),
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
                        context.read<AuthenticationCubit>().signUpSubmitted();
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
          ],
        );
      },
    );
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
}
