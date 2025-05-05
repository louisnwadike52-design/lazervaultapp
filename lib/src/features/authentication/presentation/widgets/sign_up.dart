import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart'; // Import intl for date formatting
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
    // Initialize the sign-up process in the cubit
    context.read<AuthenticationCubit>().startSignUp();
  }

  @override
  void dispose() {
    _pageController.dispose();
    // Optionally reset the cubit state if navigating away definitively
    // context.read<AuthenticationCubit>().cancelSignUp(); // Or handle in routing
    super.dispose();
  }

  /// **Date Picker Function**
  Future<void> _showDatePicker() async {
    final currentContext = context;
    // Read state only if it's SignUpInProgress
    DateTime initialPickerDate = DateTime(2000, 1, 1);
    final currentState = currentContext.read<AuthenticationCubit>().state;
    if (currentState is SignUpInProgress) {
       initialPickerDate = currentState.selectedDate ?? initialPickerDate;
    }

    DateTime? pickedDate = await showDatePicker(
      context: currentContext,
      initialDate: initialPickerDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

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
          case SignUpInProgress(errorMessage: final msg?): // Destructure and check non-null error
             Get.snackbar(
                  'Sign Up Error',
                  msg,
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                  margin: EdgeInsets.all(15.w),
                  borderRadius: 10.r,
              );
            break;
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
          case UserCreated(): // Handle successful user creation
            Get.snackbar(
              'Success',
              'Sign up successful! Please check your email to verify.',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white,
              margin: EdgeInsets.all(15.w),
              borderRadius: 10.r,
            );
            // Navigate after success - Fields should clear implicitly as state changes
            // Get.offAllNamed(AppRoutes.signIn);
            // Navigate to Dashboard and clear previous routes
            Get.offAllNamed(AppRoutes.dashboard); 
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
                        SizedBox(height: 42.0.h),
                        SizedBox(
                          // Adjusted height to potentially accommodate the new field
                          height: _responsiveController.isMobile ? 280.0.h : 450.0.h,
                          child: PageView(
                            controller: _pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              _buildPageOne(context, initialEmail: initialEmail),
                              _buildPageTwo(context, initialFirstName: firstName, initialLastName: lastName, selectedDate: selectedDate, initialPhoneNumber: phoneNumber), 
                            ],
                          ),
                        ),
                        SizedBox(height: 16.0.h),
                        // --- Navigation Button ---
                        displayLoading // Use combined loading state
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
                                     // Use destructured currentPage
                                    if (currentPage == 0) {
                                      context.read<AuthenticationCubit>().signUpNextPage();
                                    } else {
                                      // IMPORTANT: The AuthenticationCubit.signUpSubmitted method
                                      // should implicitly add 'role': 'user' to the data
                                      // before calling the createUser use case.
                                      context.read<AuthenticationCubit>().signUpSubmitted();
                                    }
                                  },
                                  child: Text(
                                     // Use destructured currentPage
                                    currentPage == 0 ? "Next" : "Sign Up",
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                        SizedBox(height: 24.0.h),
                        UniversalImageLoader(imagePath: AppData.orDivider),
                        SizedBox(height: 24.0.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _socialLoginButton(AppData.googleLogo),
                            SizedBox(width: 10.w),
                            _socialLoginButton(AppData.appleLogo),
                          ],
                        ),
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
  Widget _buildPageOne(BuildContext context, {String? initialEmail}) {
    return Column(
      children: [
        BuildFormField(
          name: "email",
          placeholder: "Email",
          keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(Icons.email, color: Colors.black45),
          initialValue: initialEmail, // Pass initial value if needed
          onChanged: (value) => context.read<AuthenticationCubit>().signUpEmailChanged(value),
        ),
        SizedBox(height: 8.0.h),
        BuildFormField(
          name: "password",
          placeholder: "Password",
          obscureText: true,
          prefixIcon: const Icon(Icons.lock, color: Colors.black45),
          // No initial value needed for password fields generally
          onChanged: (value) => context.read<AuthenticationCubit>().signUpPasswordChanged(value),
        ),
        SizedBox(height: 8.0.h),
        BuildFormField(
          name: "confirmPassword",
          placeholder: "Confirm password",
          obscureText: true,
          prefixIcon: const Icon(Icons.lock, color: Colors.black45),
          onChanged: (value) => context.read<AuthenticationCubit>().signUpConfirmPasswordChanged(value),
        ),
      ],
    );
  }

  // Helper method for Page 2 content
  // Linter Fix: Accept firstName, lastName instead of fullName
  Widget _buildPageTwo(BuildContext context, {String? initialFirstName, String? initialLastName, DateTime? selectedDate, String? initialPhoneNumber}) {
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
        // Phone Number Field
        BuildFormField(
          name: "phoneNumber",
          placeholder: "Phone Number (e.g., +1234567890)",
          keyboardType: TextInputType.phone,
          prefixIcon: const Icon(Icons.phone, color: Colors.black45),
          initialValue: initialPhoneNumber,
          onChanged: (value) {
            context.read<AuthenticationCubit>().signUpPhoneNumberChanged(value);
          },
        ),
      ],
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
