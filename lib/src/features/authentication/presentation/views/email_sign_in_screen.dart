import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utilities/responsive_controller.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/widgets/build_form_field.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';

class EmailSignInScreen extends StatefulWidget {
  const EmailSignInScreen({super.key});

  @override
  State<EmailSignInScreen> createState() => _EmailSignInScreenState();
}

class _EmailSignInScreenState extends State<EmailSignInScreen> {
  late ResponsiveController _responsiveController;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _responsiveController = ResponsiveController(context);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://images.unsplash.com/photo-1554755343-a81c0f837656?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80',
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.7),
              BlendMode.darken,
            ),
          ),
        ),
        child: BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
            switch (state) {
              case AuthenticationSuccess():
                Get.snackbar(
                  'Success',
                  'Login Successful!',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  margin: EdgeInsets.all(15.w),
                  borderRadius: 10.r,
                );
                Get.offAllNamed(AppRoutes.dashboard);
                break;
              case AuthenticationFailure(message: final msg):
                Get.snackbar(
                  'Login Error',
                  msg,
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                  margin: EdgeInsets.all(15.w),
                  borderRadius: 10.r,
                );
                break;
              default:
                break;
            }
          },
          child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
              final isLoading = state is AuthenticationLoading;

              return SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    vertical: 16.0.h,
                    horizontal: 16.0.w,
                  ),
                  child: Form(
                    key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: _responsiveController.screenHeight * 0.1),
                      Center(
                        child: UniversalImageLoader(
                          imagePath: AppData.appLogo,
                          height: 70.0.h,
                          width: 70.0.w,
                        ),
                      ),
                       SizedBox(height: 16.0.h),
                      Text(
                        "Welcome Back!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8.0.h),
                      Text(
                        "Sign in to continue",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w500,
                            color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 42.0.h),
                        _buildSignInForm(context),
                      SizedBox(height: 24.0.h),
                      isLoading
                          ? const Center(child: CircularProgressIndicator(color: Colors.black))
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.0.h,
                                  horizontal: _responsiveController.screenWidth * 0.35.w,
                                ),
                              ),
                              onPressed: () {
                                  context.read<AuthenticationCubit>().loginUser(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  );
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                              ),
                            ),
                      SizedBox(height: 24.0.h),
                      UniversalImageLoader(imagePath: AppData.orDivider),
                      SizedBox(height: 24.0.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _socialLoginButton(context, AppData.googleLogo, () {
                              context.read<AuthenticationCubit>().signInWithGoogle();
                          }),
                          SizedBox(width: 10.w),
                          _socialLoginButton(context, AppData.appleLogo, () {
                              context.read<AuthenticationCubit>().signInWithApple();
                          }),
                        ],
                      ),
                      SizedBox(height: 40.h),
                      _buildSignUpLink(context),
                      SizedBox(height: 20.h),
                    ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSignInForm(BuildContext context) {
      return Column(
        children: [
          BuildFormField(
            name: "email",
          placeholder: "Email",
            keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(Icons.email, color: Colors.black45),
          controller: _emailController,
          validator: (value) {
            if (value == null || value.isEmpty || !GetUtils.isEmail(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
          ),
        SizedBox(height: 8.0.h),
          BuildFormField(
            name: "password",
          placeholder: "Password",
            obscureText: true,
          prefixIcon: const Icon(Icons.lock, color: Colors.black45),
          controller: _passwordController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
          ),
        ],
      );
    }

   Widget _socialLoginButton(BuildContext context, String imagePath, VoidCallback onPressed) {
      return InkWell(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.0.h, horizontal: 50.0.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(32.0.r),
            border: Border.all(color: Colors.black54, width: 1),
          ),
          child: UniversalImageLoader(
            imagePath: imagePath,
            height: 24.0.h,
            width: 24.0.w,
          ),
        ),
      );
    }

  Widget _buildSignUpLink(BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account?",
            style: TextStyle(fontSize: 16.sp, color: Colors.black54),
          ),
          SizedBox(width: 8.w),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => Get.toNamed(AppRoutes.signUp),
          )
        ],
    );
  }
}
