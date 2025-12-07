import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../domain/usecases/login_usecase.dart';
import '../domain/usecases/login_with_passcode_usecase.dart';
import '../domain/usecases/register_passcode_usecase.dart';
import '../domain/usecases/sign_up_usecase.dart';
import '../domain/usecases/sign_in_with_google_usecase.dart';
import '../domain/usecases/sign_in_with_apple_usecase.dart';
import '../domain/usecases/forgot_password_usecase.dart';
import '../domain/usecases/reset_password_usecase.dart';
import '../domain/usecases/verify_email_usecase.dart';
import '../domain/usecases/resend_verification_usecase.dart';
import '../domain/usecases/check_email_availability_usecase.dart';
import '../domain/entities/profile_entity.dart';
import 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final LoginUseCase _loginUseCase;
  final LoginWithPasscodeUseCase _loginWithPasscodeUseCase;
  final RegisterPasscodeUseCase _registerPasscodeUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final SignInWithAppleUseCase _signInWithAppleUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final VerifyEmailUseCase _verifyEmailUseCase;
  final ResendVerificationUseCase _resendVerificationUseCase;
  final CheckEmailAvailabilityUseCase _checkEmailAvailabilityUseCase;
  final FlutterSecureStorage _storage;

  ProfileEntity? _currentProfile;

  AuthenticationCubit({
    required LoginUseCase login,
    required LoginWithPasscodeUseCase loginWithPasscode,
    required RegisterPasscodeUseCase registerPasscode,
    required SignUpUseCase signUp,
    required SignInWithGoogleUseCase signInWithGoogle,
    required SignInWithAppleUseCase signInWithApple,
    required ForgotPasswordUseCase forgotPassword,
    required ResetPasswordUseCase resetPassword,
    required VerifyEmailUseCase verifyEmail,
    required ResendVerificationUseCase resendVerification,
    required CheckEmailAvailabilityUseCase checkEmailAvailability,
    FlutterSecureStorage? storage,
  })  : _loginUseCase = login,
        _loginWithPasscodeUseCase = loginWithPasscode,
        _registerPasscodeUseCase = registerPasscode,
        _signUpUseCase = signUp,
        _signInWithGoogleUseCase = signInWithGoogle,
        _signInWithAppleUseCase = signInWithApple,
        _forgotPasswordUseCase = forgotPassword,
        _resetPasswordUseCase = resetPassword,
        _verifyEmailUseCase = verifyEmail,
        _resendVerificationUseCase = resendVerification,
        _checkEmailAvailabilityUseCase = checkEmailAvailability,
        _storage = storage ?? const FlutterSecureStorage(),
        super(AuthenticationInitial());

  // Getters
  ProfileEntity? get currentProfile => _currentProfile;
  bool get isAuthenticated => _currentProfile != null;
  bool get isEmailVerified => _currentProfile?.user.isEmailVerified ?? false;

  // Storage keys
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userIdKey = 'user_id';
  static const String _userEmailKey = 'user_email';

  // --- Session Management ---
  Future<void> tryAutoLogin() async {
    try {
      final accessToken = await _storage.read(key: _accessTokenKey);
      final userId = await _storage.read(key: _userIdKey);

      if (accessToken != null && userId != null) {
        // Token exists, validate it
        // For now, assume valid. Later add token validation
        emit(AuthenticationCheckingSession());

        // TODO: Add API call to validate token and get user profile
        // For now, just emit initial state
        await Future.delayed(const Duration(milliseconds: 500));
        emit(AuthenticationInitial());
      }
    } catch (e) {
      print('Auto login failed: $e');
      emit(AuthenticationInitial());
    }
  }

  Future<void> _saveSession(ProfileEntity profile) async {
    try {
      await _storage.write(
        key: _accessTokenKey,
        value: profile.session.accessToken,
      );
      await _storage.write(
        key: _refreshTokenKey,
        value: profile.session.refreshToken,
      );
      await _storage.write(
        key: _userIdKey,
        value: profile.user.id,
      );
      await _storage.write(
        key: _userEmailKey,
        value: profile.user.email,
      );
      // Store user profile data for passcode screen
      await _storage.write(
        key: 'user_first_name',
        value: profile.user.firstName,
      );
      await _storage.write(
        key: 'user_last_name',
        value: profile.user.lastName,
      );
      _currentProfile = profile;
    } catch (e) {
      print('Error saving session: $e');
    }
  }

  Future<void> _clearSession() async {
    try {
      await _storage.delete(key: _accessTokenKey);
      await _storage.delete(key: _refreshTokenKey);
      await _storage.delete(key: _userIdKey);
      await _storage.delete(key: _userEmailKey);
      await _storage.delete(key: 'user_first_name');
      await _storage.delete(key: 'user_last_name');
      await _storage.delete(key: 'user_avatar_url');
      _currentProfile = null;
    } catch (e) {
      print('Error clearing session: $e');
    }
  }

  // --- Main Auth Methods ---
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(AuthenticationLoading());

    final result = await _loginUseCase(email: email, password: password);

    result.fold(
      (failure) {
        // Show generic error message for security
        const genericError = 'Invalid email or password';
        emit(AuthenticationFailure(
          genericError,
          statusCode: failure.statusCode,
        ));
      },
      (profile) async {
        await _saveSession(profile);
        emit(AuthenticationSuccess(profile));
      },
    );
  }

  Future<void> loginWithPasscode({
    required String email,
    required String passcode,
  }) async {
    emit(const AuthenticationLoading());

    final result = await _loginWithPasscodeUseCase(
      email: email,
      passcode: passcode,
    );

    result.fold(
      (failure) {
        emit(AuthenticationError(failure.message));
      },
      (profile) async {
        await _saveSession(profile);
        // Store login method preference
        await _storage.write(key: 'login_method', value: 'passcode');
        await _storage.write(key: 'stored_email', value: email);
        _showSuccessSnackbar('Welcome back!', '${profile.user.firstName} ${profile.user.lastName}');
        emit(AuthenticationSuccess(profile));
      },
    );
  }

  Future<void> registerPasscode({
    required String passcode,
  }) async {
    emit(const AuthenticationLoading());

    final result = await _registerPasscodeUseCase(passcode: passcode);

    result.fold(
      (failure) {
        _showErrorSnackbar('Passcode Registration Failed', failure.message);
        emit(AuthenticationError(failure.message));
      },
      (_) async {
        // Store login method preference after successful registration
        await _storage.write(key: 'login_method', value: 'passcode');
        if (_currentProfile != null) {
          await _storage.write(key: 'stored_email', value: _currentProfile!.user.email);
        }
        _showSuccessSnackbar('Success!', 'Passcode registered successfully');
        // Return to the current authenticated state
        if (_currentProfile != null) {
          emit(AuthenticationSuccess(_currentProfile!));
        } else {
          emit(AuthenticationInitial());
        }
      },
    );
  }

  Future<void> signUpUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phoneNumber,
  }) async {
    emit(AuthenticationLoading());

    final result = await _signUpUseCase(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
    );

    result.fold(
      (failure) {
        _showErrorSnackbar('Sign Up Failed', failure.message);
        emit(AuthenticationFailure(
          failure.message,
          statusCode: failure.statusCode,
        ));
      },
      (profile) async {
        await _saveSession(profile);

        if (!profile.user.isEmailVerified) {
          _showInfoSnackbar(
            'Account Created!',
            'Please check your email to verify your account.',
          );
        } else {
          _showSuccessSnackbar(
            'Welcome!',
            'Your account has been created successfully.',
          );
        }

        emit(AuthenticationSuccess(profile));
      },
    );
  }

  Future<void> signInWithGoogle() async {
    emit(AuthenticationLoading());

    final result = await _signInWithGoogleUseCase();

    result.fold(
      (failure) {
        _showErrorSnackbar('Google Sign-In Failed', failure.message);
        emit(AuthenticationFailure(
          failure.message,
          statusCode: failure.statusCode,
        ));
      },
      (profile) async {
        await _saveSession(profile);
        _showSuccessSnackbar('Welcome!', 'Signed in with Google');
        emit(AuthenticationSuccess(profile));
      },
    );
  }

  Future<void> signInWithApple() async {
    emit(AuthenticationLoading());

    final result = await _signInWithAppleUseCase();

    result.fold(
      (failure) {
        _showErrorSnackbar('Apple Sign-In Failed', failure.message);
        emit(AuthenticationFailure(
          failure.message,
          statusCode: failure.statusCode,
        ));
      },
      (profile) async {
        await _saveSession(profile);
        _showSuccessSnackbar('Welcome!', 'Signed in with Apple');
        emit(AuthenticationSuccess(profile));
      },
    );
  }

  // --- Password Recovery Flow---
  void startForgotPassword() {
    emit(const ForgotPasswordInProgress());
  }

  void forgotPasswordEmailChanged(String email) {
    if (state is ForgotPasswordInProgress) {
      final currentState = state as ForgotPasswordInProgress;
      emit(currentState.copyWith(email: email, clearError: true));
    }
  }

  Future<void> submitForgotPassword() async {
    if (state is! ForgotPasswordInProgress) return;

    final currentState = state as ForgotPasswordInProgress;

    // Validate email
    if (currentState.email.isEmpty) {
      emit(currentState.copyWith(errorMessage: 'Email is required'));
      return;
    }

    if (!_isValidEmail(currentState.email)) {
      emit(currentState.copyWith(errorMessage: 'Please enter a valid email address'));
      return;
    }

    emit(currentState.copyWith(isLoading: true, clearError: true));

    final result = await _forgotPasswordUseCase(currentState.email);

    result.fold(
      (failure) {
        _showErrorSnackbar('Password Reset Failed', failure.message);
        if (state is ForgotPasswordInProgress) {
          emit((state as ForgotPasswordInProgress).copyWith(
            isLoading: false,
            errorMessage: failure.message,
          ));
        }
      },
      (_) {
        _showSuccessSnackbar(
          'Email Sent!',
          'Check your email for password reset instructions.',
        );
        emit(PasswordResetEmailSent());
      },
    );
  }

  // Legacy method for backward compatibility
  Future<void> forgotPassword(String email) async {
    emit(AuthenticationLoading());

    final result = await _forgotPasswordUseCase(email);

    result.fold(
      (failure) {
        _showErrorSnackbar('Password Reset Failed', failure.message);
        emit(AuthenticationFailure(
          failure.message,
          statusCode: failure.statusCode,
        ));
      },
      (_) {
        _showSuccessSnackbar(
          'Email Sent!',
          'Check your email for password reset instructions.',
        );
        emit(PasswordResetEmailSent());
      },
    );
  }

  // --- Reset Password Flow ---
  void startResetPassword({required String email, required String token}) {
    emit(ResetPasswordInProgress(email: email, token: token));
  }

  void resetPasswordNewPasswordChanged(String password) {
    if (state is ResetPasswordInProgress) {
      final currentState = state as ResetPasswordInProgress;
      emit(currentState.copyWith(newPassword: password, clearError: true));
    }
  }

  void resetPasswordConfirmPasswordChanged(String password) {
    if (state is ResetPasswordInProgress) {
      final currentState = state as ResetPasswordInProgress;
      emit(currentState.copyWith(confirmPassword: password, clearError: true));
    }
  }

  Future<void> submitResetPassword() async {
    if (state is! ResetPasswordInProgress) return;

    final currentState = state as ResetPasswordInProgress;

    // Validate passwords
    final passwordError = _validatePassword(currentState.newPassword);
    if (passwordError != null) {
      _showErrorSnackbar('Invalid Password', passwordError);
      emit(currentState.copyWith(errorMessage: passwordError));
      return;
    }

    if (currentState.newPassword != currentState.confirmPassword) {
      const error = 'Passwords do not match';
      _showErrorSnackbar('Error', error);
      emit(currentState.copyWith(errorMessage: error));
      return;
    }

    emit(currentState.copyWith(isLoading: true, clearError: true));

    final result = await _resetPasswordUseCase(
      email: currentState.email,
      token: currentState.token,
      newPassword: currentState.newPassword,
    );

    result.fold(
      (failure) {
        _showErrorSnackbar('Password Reset Failed', failure.message);
        if (state is ResetPasswordInProgress) {
          emit((state as ResetPasswordInProgress).copyWith(
            isLoading: false,
            errorMessage: failure.message,
          ));
        }
      },
      (_) {
        _showSuccessSnackbar(
          'Password Reset!',
          'Your password has been successfully reset. You can now log in.',
        );
        emit(const PasswordResetSuccess());
      },
    );
  }

  // --- Email Verification ---
  Future<void> verifyEmail(String token) async {
    emit(AuthenticationLoading());

    final result = await _verifyEmailUseCase(token);

    result.fold(
      (failure) {
        _showErrorSnackbar('Verification Failed', failure.message);
        emit(AuthenticationFailure(
          failure.message,
          statusCode: failure.statusCode,
        ));
      },
      (profile) async {
        await _saveSession(profile);
        _showSuccessSnackbar(
          'Email Verified!',
          'Your email has been successfully verified.',
        );
        emit(EmailVerified(profile));
      },
    );
  }

  Future<void> resendVerificationEmail() async {
    if (_currentProfile == null) {
      _showErrorSnackbar('Error', 'Please sign in first');
      return;
    }

    emit(AuthenticationLoading());

    final result = await _resendVerificationUseCase();

    result.fold(
      (failure) {
        _showErrorSnackbar('Failed to Send Email', failure.message);
        emit(AuthenticationFailure(
          failure.message,
          statusCode: failure.statusCode,
        ));
      },
      (_) {
        _showSuccessSnackbar(
          'Email Sent!',
          'Verification email has been resent.',
        );
        // Return to previous success state
        if (_currentProfile != null) {
          emit(AuthenticationSuccess(_currentProfile!));
        } else {
          emit(AuthenticationInitial());
        }
      },
    );
  }

  // --- Logout ---
  Future<void> logout() async {
    await _clearSession();
    _showInfoSnackbar('Logged Out', 'Come back soon!');
    emit(AuthenticationInitial());
  }

  // --- Sign Up Flow Methods ---
  void startSignUp() {
    emit(const SignUpInProgress());
  }

  void cancelSignUp() {
    emit(const AuthenticationInitial());
  }

  void signUpEmailChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(email: value, clearErrorMessage: true, isLoading: false));
    }
  }

  void signUpPasswordChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(password: value, clearErrorMessage: true, isLoading: false));
    }
  }

  void signUpConfirmPasswordChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(confirmPassword: value, clearErrorMessage: true, isLoading: false));
    }
  }

  void signUpFirstNameChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(firstName: value, clearErrorMessage: true, isLoading: false));
    }
  }

  void signUpLastNameChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(lastName: value, clearErrorMessage: true, isLoading: false));
    }
  }

  void signUpDateOfBirthChanged(DateTime? value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(selectedDate: value, clearErrorMessage: true, isLoading: false));
    }
  }

  void signUpPhoneNumberChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      // Format phone number to remove spaces and special characters
      final formattedPhone = _formatPhoneNumber(value);
      emit(currentState.copyWith(phoneNumber: formattedPhone, clearErrorMessage: true, isLoading: false));
    }
  }

  Future<void> signUpNextPage() async {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;

      if (currentState.currentPage == 0) {
        // Validation for page 0: Email and Password
        if (currentState.email.isEmpty) {
          final errorMsg = 'Email is required';
          _showErrorSnackbar('Validation Error', errorMsg);
          emit(currentState.copyWith(errorMessage: errorMsg));
          return;
        }

        if (!_isValidEmail(currentState.email)) {
          final errorMsg = 'Please enter a valid email address';
          _showErrorSnackbar('Validation Error', errorMsg);
          emit(currentState.copyWith(errorMessage: errorMsg));
          return;
        }

        if (currentState.password.isEmpty) {
          final errorMsg = 'Password is required';
          _showErrorSnackbar('Validation Error', errorMsg);
          emit(currentState.copyWith(errorMessage: errorMsg));
          return;
        }

        final passwordError = _validatePassword(currentState.password);
        if (passwordError != null) {
          _showErrorSnackbar('Password Requirements', passwordError);
          emit(currentState.copyWith(errorMessage: passwordError));
          return;
        }

        if (currentState.confirmPassword.isEmpty) {
          final errorMsg = 'Please confirm your password';
          _showErrorSnackbar('Validation Error', errorMsg);
          emit(currentState.copyWith(errorMessage: errorMsg));
          return;
        }

        if (currentState.password != currentState.confirmPassword) {
          final errorMsg = 'Passwords do not match';
          _showErrorSnackbar('Validation Error', errorMsg);
          emit(currentState.copyWith(errorMessage: errorMsg));
          return;
        }

        // Check email availability before proceeding
        emit(currentState.copyWith(isLoading: true, clearErrorMessage: true));

        final result = await _checkEmailAvailabilityUseCase(email: currentState.email);

        result.fold(
          (failure) {
            final errorMsg = 'Failed to verify email availability. Please try again.';
            _showErrorSnackbar('Connection Error', errorMsg);
            emit(currentState.copyWith(errorMessage: errorMsg, isLoading: false));
            return;
          },
          (isAvailable) {
            if (!isAvailable) {
              final errorMsg = 'This email is already registered. Please use a different email or sign in.';
              _showErrorSnackbar('Email Already Exists', errorMsg);
              emit(currentState.copyWith(errorMessage: errorMsg, isLoading: false));
              return;
            }
            // Email is available, proceed to next page
            emit(currentState.copyWith(currentPage: currentState.currentPage + 1, clearErrorMessage: true, isLoading: false));
          },
        );
        return; // Return early as we handled page transition in the fold
      } else if (currentState.currentPage == 1) {
        // Validation for page 1: Personal Info
        final firstNameError = _validateName(currentState.firstName, 'First name');
        if (firstNameError != null) {
          _showErrorSnackbar('Validation Error', firstNameError);
          emit(currentState.copyWith(errorMessage: firstNameError));
          return;
        }

        final lastNameError = _validateName(currentState.lastName, 'Last name');
        if (lastNameError != null) {
          _showErrorSnackbar('Validation Error', lastNameError);
          emit(currentState.copyWith(errorMessage: lastNameError));
          return;
        }

        final dobError = _validateDateOfBirth(currentState.selectedDate);
        if (dobError != null) {
          _showErrorSnackbar('Validation Error', dobError);
          emit(currentState.copyWith(errorMessage: dobError));
          return;
        }

        final phoneError = _validatePhoneNumber(currentState.phoneNumber);
        if (phoneError != null) {
          _showErrorSnackbar('Validation Error', phoneError);
          emit(currentState.copyWith(errorMessage: phoneError));
          return;
        }
      }

      if (currentState.currentPage < 1) {
        emit(currentState.copyWith(currentPage: currentState.currentPage + 1, clearErrorMessage: true));
      }
    }
  }

  void signUpPreviousPage() {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      if (currentState.currentPage > 0) {
        emit(currentState.copyWith(currentPage: currentState.currentPage - 1, clearErrorMessage: true));
      }
    }
  }

  Future<void> signUpSubmitted() async {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;

      // Comprehensive validation before submission
      if (!_isValidEmail(currentState.email)) {
        final errorMsg = 'Please enter a valid email address';
        _showErrorSnackbar('Validation Error', errorMsg);
        emit(currentState.copyWith(errorMessage: errorMsg, isLoading: false));
        return;
      }

      final passwordError = _validatePassword(currentState.password);
      if (passwordError != null) {
        _showErrorSnackbar('Password Requirements', passwordError);
        emit(currentState.copyWith(errorMessage: passwordError, isLoading: false));
        return;
      }

      if (currentState.password != currentState.confirmPassword) {
        final errorMsg = 'Passwords do not match';
        _showErrorSnackbar('Validation Error', errorMsg);
        emit(currentState.copyWith(errorMessage: errorMsg, isLoading: false));
        return;
      }

      final firstNameError = _validateName(currentState.firstName, 'First name');
      if (firstNameError != null) {
        _showErrorSnackbar('Validation Error', firstNameError);
        emit(currentState.copyWith(errorMessage: firstNameError, isLoading: false));
        return;
      }

      final lastNameError = _validateName(currentState.lastName, 'Last name');
      if (lastNameError != null) {
        _showErrorSnackbar('Validation Error', lastNameError);
        emit(currentState.copyWith(errorMessage: lastNameError, isLoading: false));
        return;
      }

      final dobError = _validateDateOfBirth(currentState.selectedDate);
      if (dobError != null) {
        _showErrorSnackbar('Validation Error', dobError);
        emit(currentState.copyWith(errorMessage: dobError, isLoading: false));
        return;
      }

      final phoneError = _validatePhoneNumber(currentState.phoneNumber);
      if (phoneError != null) {
        _showErrorSnackbar('Validation Error', phoneError);
        emit(currentState.copyWith(errorMessage: phoneError, isLoading: false));
        return;
      }

      if (currentState.isLoading) return;
      emit(currentState.copyWith(isLoading: true, clearErrorMessage: true));

      // Call the sign up use case
      final result = await _signUpUseCase(
        firstName: currentState.firstName,
        lastName: currentState.lastName,
        email: currentState.email,
        password: currentState.password,
        phoneNumber: currentState.phoneNumber,
      );

      result.fold(
        (failure) {
          print('Error signing up: ${failure.message}');
          _showErrorSnackbar('Sign Up Failed', failure.message);
          emit(currentState.copyWith(
            isLoading: false,
            errorMessage: failure.message,
          ));
        },
        (profile) async {
          await _saveSession(profile);

          if (!profile.user.isEmailVerified) {
            _showInfoSnackbar(
              'Account Created!',
              'Please check your email to verify your account.',
            );
          } else {
            _showSuccessSnackbar(
              'Welcome!',
              'Your account has been created successfully.',
            );
          }

          emit(AuthenticationSuccess(profile));
        },
      );
    } else {
      print('Cannot submit sign up from current state: $state');
      emit(AuthenticationFailure("Cannot submit sign up from current state.", statusCode: 400));
    }
  }

  // --- Helper Methods ---
  bool _isValidEmail(String email) {
    // Enhanced email validation with more comprehensive regex
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$',
    );
    return email.isNotEmpty && emailRegex.hasMatch(email) && email.length <= 254;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) return 'Password is required';
    if (password.length < 8) return 'Password must be at least 8 characters';
    if (password.length > 128) return 'Password is too long (max 128 characters)';

    // Check for uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check for digit
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Password must contain at least one number';
    }

    // Check for special character
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=\[\]\\\/;`~]').hasMatch(password)) {
      return 'Password must contain at least one special character';
    }

    return null; // Password is valid
  }

  String? _validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) return 'Phone number is required';

    // IntlPhoneField already validates and formats phone numbers
    // Just ensure it starts with + and has reasonable length
    if (!phoneNumber.startsWith('+')) {
      return 'Please select a country code for your phone number';
    }

    if (phoneNumber.length < 8) {
      return 'Please enter a complete phone number';
    }

    return null; // Phone number is valid
  }

  String _formatPhoneNumber(String phoneNumber) {
    // Remove all non-digit characters except +
    return phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
  }

  String? _validateName(String name, String fieldName) {
    if (name.isEmpty) return '$fieldName is required';
    if (name.length < 2) return '$fieldName must be at least 2 characters';
    if (name.length > 255) return '$fieldName is too long (max 255 characters)';

    // Allow letters, spaces, hyphens, and apostrophes
    final nameRegex = RegExp(r"^[a-zA-Z\s\-']+$");
    if (!nameRegex.hasMatch(name)) {
      return '$fieldName can only contain letters, spaces, hyphens, and apostrophes';
    }

    return null; // Name is valid
  }

  String? _validateDateOfBirth(DateTime? dob) {
    if (dob == null) return 'Date of birth is required';

    final now = DateTime.now();
    final age = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1);

    if (age < 13) {
      return 'You must be at least 13 years old to sign up';
    }

    if (age > 150) {
      return 'Please enter a valid date of birth';
    }

    return null; // Date of birth is valid
  }

  void _showSuccessSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.withOpacity(0.9),
      colorText: Colors.white,
      margin: const EdgeInsets.all(15),
      borderRadius: 10,
      icon: const Icon(Icons.check_circle, color: Colors.white),
      duration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }

  void _showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red.withOpacity(0.9),
      colorText: Colors.white,
      margin: const EdgeInsets.all(15),
      borderRadius: 10,
      icon: const Icon(Icons.error, color: Colors.white),
      duration: const Duration(seconds: 4),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }

  void _showInfoSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue.withOpacity(0.9),
      colorText: Colors.white,
      margin: const EdgeInsets.all(15),
      borderRadius: 10,
      icon: const Icon(Icons.info, color: Colors.white),
      duration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }

  // --- Passcode Setup Flow Methods ---
  void startPasscodeSetup() {
    emit(const PasscodeSetupInProgress());
  }

  void passcodeSetupDigitEntered(String digit) {
    if (state is PasscodeSetupInProgress) {
      final currentState = state as PasscodeSetupInProgress;
      if (currentState.enteredPasscode.length < 6) {
        final newPasscode = currentState.enteredPasscode + digit;
        emit(currentState.copyWith(enteredPasscode: newPasscode, clearError: true));

        // Auto-submit when 6 digits entered
        if (newPasscode.length == 6) {
          _handlePasscodeSetupComplete(newPasscode);
        }
      }
    }
  }

  void passcodeSetupBackspace() {
    if (state is PasscodeSetupInProgress) {
      final currentState = state as PasscodeSetupInProgress;
      if (currentState.enteredPasscode.isNotEmpty) {
        final newPasscode = currentState.enteredPasscode.substring(
          0,
          currentState.enteredPasscode.length - 1,
        );
        emit(currentState.copyWith(enteredPasscode: newPasscode, clearError: true));
      }
    }
  }

  void _handlePasscodeSetupComplete(String passcode) {
    if (state is PasscodeSetupInProgress) {
      final currentState = state as PasscodeSetupInProgress;

      if (!currentState.isConfirmMode) {
        // First entry - ask for confirmation
        emit(PasscodeSetupInProgress(
          isConfirmMode: true,
          initialPasscode: passcode,
          enteredPasscode: '',
        ));
      } else {
        // Confirmation mode - check if they match
        if (passcode == currentState.initialPasscode) {
          _registerPasscodeFromSetup(passcode);
        } else {
          _showErrorSnackbar('Error', 'Passcodes do not match. Please try again.');
          emit(const PasscodeSetupInProgress()); // Reset to initial mode
        }
      }
    }
  }

  Future<void> _registerPasscodeFromSetup(String passcode) async {
    if (state is! PasscodeSetupInProgress) return;

    final currentState = state as PasscodeSetupInProgress;
    emit(currentState.copyWith(isRegistering: true, clearError: true));

    // Store passcode locally
    try {
      await _storage.write(key: 'user_passcode', value: passcode);
    } catch (e) {
      print('Error storing passcode locally: $e');
    }

    // Call backend API
    final result = await _registerPasscodeUseCase(passcode: passcode);

    result.fold(
      (failure) {
        _showErrorSnackbar('Passcode Registration Failed', failure.message);
        emit(PasscodeSetupInProgress(
          errorMessage: failure.message,
          isRegistering: false,
        ));
      },
      (_) async {
        // Store login method preference
        await _storage.write(key: 'login_method', value: 'passcode');
        if (_currentProfile != null) {
          await _storage.write(key: 'stored_email', value: _currentProfile!.user.email);
        }
        _showSuccessSnackbar('Success!', 'Passcode registered successfully');

        // Navigate to dashboard by emitting success
        if (_currentProfile != null) {
          emit(AuthenticationSuccess(_currentProfile!));
        } else {
          emit(AuthenticationInitial());
        }
      },
    );
  }

  void skipPasscodeSetup() {
    // Just emit success to navigate to dashboard
    if (_currentProfile != null) {
      emit(AuthenticationSuccess(_currentProfile!));
    } else {
      emit(AuthenticationInitial());
    }
  }

  // --- Passcode Login Flow Methods ---
  void startPasscodeLogin() {
    emit(const PasscodeLoginInProgress());
  }

  void passcodeLoginDigitEntered(String digit) {
    if (state is PasscodeLoginInProgress) {
      final currentState = state as PasscodeLoginInProgress;
      if (currentState.enteredPasscode.length < 6 && !currentState.isAuthenticating) {
        final newPasscode = currentState.enteredPasscode + digit;
        emit(currentState.copyWith(enteredPasscode: newPasscode, clearError: true));

        // Auto-submit when 6 digits entered
        if (newPasscode.length == 6) {
          _attemptPasscodeLogin(newPasscode);
        }
      }
    }
  }

  void passcodeLoginBackspace() {
    if (state is PasscodeLoginInProgress) {
      final currentState = state as PasscodeLoginInProgress;
      if (currentState.enteredPasscode.isNotEmpty && !currentState.isAuthenticating) {
        final newPasscode = currentState.enteredPasscode.substring(
          0,
          currentState.enteredPasscode.length - 1,
        );
        emit(currentState.copyWith(enteredPasscode: newPasscode, clearError: true));
      }
    }
  }

  Future<void> _attemptPasscodeLogin(String passcode) async {
    if (state is! PasscodeLoginInProgress) return;

    final currentState = state as PasscodeLoginInProgress;

    // Get stored email
    final email = await _storage.read(key: 'user_email');
    if (email == null || email.isEmpty) {
      _showErrorSnackbar('Error', 'No stored email found. Please use email/password login.');
      emit(currentState.copyWith(enteredPasscode: '', clearError: true));
      return;
    }

    emit(currentState.copyWith(isAuthenticating: true, clearError: true));

    final result = await _loginWithPasscodeUseCase(
      email: email,
      passcode: passcode,
    );

    result.fold(
      (failure) {
        _showErrorSnackbar('Login Failed', failure.message);
        emit(PasscodeLoginInProgress(
          enteredPasscode: '',
          isAuthenticating: false,
          errorMessage: failure.message,
        ));
      },
      (profile) async {
        await _saveSession(profile);
        await _storage.write(key: 'login_method', value: 'passcode');
        await _storage.write(key: 'stored_email', value: email);
        _showSuccessSnackbar('Welcome back!', '${profile.user.firstName} ${profile.user.lastName}');
        emit(AuthenticationSuccess(profile));
      },
    );
  }
}
