import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lazervault/core/services/currency_sync_service.dart';
import 'package:lazervault/core/services/signup_state_service.dart';
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
import '../domain/usecases/verify_identity_usecase.dart';
import '../domain/usecases/validate_token_usecase.dart';
import '../domain/entities/profile_entity.dart';
import '../domain/entities/user.dart';
import '../domain/entities/signup_draft.dart';
import '../domain/entities/two_factor_entity.dart';
import '../domain/usecases/enable_two_factor_usecase.dart';
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
  final VerifyIdentityUseCase _verifyIdentityUseCase;
  final ValidateTokenUseCase _validateTokenUseCase;
  final FlutterSecureStorage _storage;
  final CurrencySyncService _currencySyncService;
  final SignupStateService? _signupStateService;

  ProfileEntity? _currentProfile;
  Timer? _draftSaveTimer;

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
    required VerifyIdentityUseCase verifyIdentity,
    required ValidateTokenUseCase validateToken,
    FlutterSecureStorage? storage,
    required CurrencySyncService currencySyncService,
    SignupStateService? signupStateService,
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
        _verifyIdentityUseCase = verifyIdentity,
        _validateTokenUseCase = validateToken,
        _storage = storage ?? const FlutterSecureStorage(),
        _currencySyncService = currencySyncService,
        _signupStateService = signupStateService,
        super(AuthenticationInitial());

  // Getters
  ProfileEntity? get currentProfile => _currentProfile;
  bool get isAuthenticated => _currentProfile != null;
  bool get isEmailVerified => _currentProfile?.user.isEmailVerified ?? false;
  String? get userId => _currentProfile?.user.id;

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
        // Token exists, validate it with the backend
        if (isClosed) return;
        emit(AuthenticationCheckingSession());

        final result = await _validateTokenUseCase(accessToken: accessToken);

        if (isClosed) return;

        result.fold(
          (failure) {
            // Token is invalid or expired, clear session
            print('Auto login failed: ${failure.message}');
            _clearSession();
            emit(AuthenticationInitial());
          },
          (profile) {
            // Token is valid, restore session
            _currentProfile = profile;
            emit(AuthenticationAuthenticated(profile));
          },
        );
      }
    } catch (e) {
      print('Auto login failed: $e');
      if (isClosed) return;
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
      // Also store email in fallback key for passcode login consistency
      await _storage.write(
        key: 'stored_email',
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
      // Store profile picture if available
      if (profile.user.profilePicture != null && profile.user.profilePicture!.isNotEmpty) {
        await _storage.write(
          key: 'user_avatar_url',
          value: profile.user.profilePicture!,
        );
      }
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
      // Keep 'stored_email' for passcode login after logout
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
    print('🔐 Login attempt with email: $email (length: ${email.length})');
    if (isClosed) return;
    emit(AuthenticationLoading());

    final result = await _loginUseCase(email: email, password: password);

    if (isClosed) return;
    result.fold(
      (failure) {
        print('❌ Login failed for email: $email - ${failure.message}');
        // Show generic error message for security
        const genericError = 'Invalid email or password';
        emit(AuthenticationFailure(
          genericError,
          statusCode: failure.statusCode,
        ));
      },
      (profile) async {
        print('✅ Login successful for email: ${profile.user.email}');
        await _saveSession(profile);
        // Sync currency from server after successful login
        await _currencySyncService.syncFromServer();
        emit(AuthenticationSuccess(profile));
      },
    );
  }

  Future<void> loginWithPasscode({
    required String email,
    required String passcode,
  }) async {
    if (isClosed) return;
    emit(const AuthenticationLoading());

    final result = await _loginWithPasscodeUseCase(
      email: email,
      passcode: passcode,
    );

    if (isClosed) return;
    result.fold(
      (failure) {
        emit(AuthenticationError(failure.message));
      },
      (profile) async {
        await _saveSession(profile);
        // Store login method preference
        await _storage.write(key: 'login_method', value: 'passcode');
        await _storage.write(key: 'stored_email', value: email);
        // Sync currency from server after successful login
        await _currencySyncService.syncFromServer();
        _showSuccessSnackbar('Welcome back!', '${profile.user.firstName} ${profile.user.lastName}');
        emit(AuthenticationSuccess(profile));
      },
    );
  }

  Future<void> registerPasscode({
    required String passcode,
  }) async {
    if (isClosed) return;
    emit(const AuthenticationLoading());

    final result = await _registerPasscodeUseCase(passcode: passcode);

    if (isClosed) return;
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
    if (isClosed) return;
    emit(AuthenticationLoading());

    final result = await _signUpUseCase(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      primaryContact: SignupPrimaryContact.email,
      phoneNumber: phoneNumber,
    );

    if (isClosed) return;
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
        // Sync currency from server after successful registration
        await _currencySyncService.syncFromServer();

        // Clear the local signup draft as account is now created
        // Backend will track progress from here
        await clearSignupDraft();
        await _signupStateService?.markAccountCreated();

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

        // Emit UserCreated state instead of AuthenticationSuccess
        // to prevent conflict with login flow
        emit(UserCreated());
      },
    );
  }

  Future<void> signInWithGoogle() async {
    if (isClosed) return;
    emit(AuthenticationLoading());

    final result = await _signInWithGoogleUseCase();

    if (isClosed) return;
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
        // Sync currency from server after successful login
        await _currencySyncService.syncFromServer();
        _showSuccessSnackbar('Welcome!', 'Signed in with Google');
        emit(AuthenticationSuccess(profile));
      },
    );
  }

  Future<void> signInWithApple() async {
    if (isClosed) return;
    emit(AuthenticationLoading());

    final result = await _signInWithAppleUseCase();

    if (isClosed) return;
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
        // Sync currency from server after successful login
        await _currencySyncService.syncFromServer();
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
      if (isClosed) return;
      emit(currentState.copyWith(errorMessage: 'Email is required'));
      return;
    }

    if (!_isValidEmail(currentState.email)) {
      if (isClosed) return;
      emit(currentState.copyWith(errorMessage: 'Please enter a valid email address'));
      return;
    }

    if (isClosed) return;
    emit(currentState.copyWith(isLoading: true, clearError: true));

    final result = await _forgotPasswordUseCase(currentState.email);

    if (isClosed) return;
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
    if (isClosed) return;
    emit(AuthenticationLoading());

    final result = await _forgotPasswordUseCase(email);

    if (isClosed) return;
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
      if (isClosed) return;
      emit(currentState.copyWith(errorMessage: passwordError));
      return;
    }

    if (currentState.newPassword != currentState.confirmPassword) {
      const error = 'Passwords do not match';
      _showErrorSnackbar('Error', error);
      if (isClosed) return;
      emit(currentState.copyWith(errorMessage: error));
      return;
    }

    if (isClosed) return;
    emit(currentState.copyWith(isLoading: true, clearError: true));

    final result = await _resetPasswordUseCase(
      email: currentState.email,
      token: currentState.token,
      newPassword: currentState.newPassword,
    );

    if (isClosed) return;
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
    if (isClosed) return;
    emit(AuthenticationLoading());

    final result = await _verifyEmailUseCase(token);

    if (isClosed) return;
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

    final email = _currentProfile!.user.email;
    if (email.isEmpty) {
      _showErrorSnackbar('Error', 'No email address found');
      return;
    }

    if (isClosed) return;
    emit(AuthenticationLoading());

    final result = await _resendVerificationUseCase(email: email);

    if (isClosed) return;
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

  // --- Update User Profile ---
  void updateCurrentUser(User updatedUser) {
    if (_currentProfile != null) {
      _currentProfile = ProfileEntity(
        user: updatedUser,
        session: _currentProfile!.session,
      );
      emit(AuthenticationSuccess(_currentProfile!));
    }
  }

  // --- Logout ---
  Future<void> logout() async {
    await _clearSession();
    // Clear currency sync state on logout
    _currencySyncService.clear();
    _showInfoSnackbar('Logged Out', 'Come back soon!');
    // Emit PasscodeLoginInProgress instead of AuthenticationInitial
    // to prevent infinite loading spinner on passcode screen
    emit(const PasscodeLoginInProgress());
  }

  // --- Sign Up Flow Methods ---

  /// Start signup flow, loading any existing draft
  Future<void> startSignUp() async {
    // Try to load existing draft
    final draft = await _signupStateService?.loadDraft();

    if (draft != null && draft.hasData && !draft.isExpired) {
      // Restore from draft
      emit(SignUpInProgress(
        email: draft.email ?? '',
        firstName: draft.firstName ?? '',
        lastName: draft.lastName ?? '',
        username: draft.username ?? '',
        referralCode: draft.referralCode ?? '',
        selectedDate: draft.dateOfBirth,
        phoneNumber: draft.phone ?? '',
        currentPage: draft.currentPage,
        primaryContactType: _stringToPrimaryContactType(draft.primaryContactType),
      ));
    } else {
      emit(const SignUpInProgress());
    }
  }

  /// Start signup flow synchronously (for compatibility)
  void startSignUpSync() {
    emit(const SignUpInProgress());
  }

  void cancelSignUp() {
    _draftSaveTimer?.cancel();
    emit(const AuthenticationInitial());
  }

  /// Clear signup draft and state
  Future<void> clearSignupDraft() async {
    _draftSaveTimer?.cancel();
    await _signupStateService?.clearDraft();
  }

  /// Save current signup state to draft (debounced)
  void _scheduleDraftSave() {
    _draftSaveTimer?.cancel();
    _draftSaveTimer = Timer(const Duration(milliseconds: 500), () {
      _saveCurrentStateToDraft();
    });
  }

  /// Save current state to draft immediately
  Future<void> _saveCurrentStateToDraft() async {
    if (_signupStateService == null) return;

    final currentState = state;
    if (currentState is SignUpInProgress) {
      final draft = SignupDraft(
        email: currentState.email.isNotEmpty ? currentState.email : null,
        phone: currentState.phoneNumber.isNotEmpty ? currentState.phoneNumber : null,
        firstName: currentState.firstName.isNotEmpty ? currentState.firstName : null,
        lastName: currentState.lastName.isNotEmpty ? currentState.lastName : null,
        username: currentState.username.isNotEmpty ? currentState.username : null,
        referralCode: currentState.referralCode.isNotEmpty ? currentState.referralCode : null,
        dateOfBirth: currentState.selectedDate,
        primaryContactType: _primaryContactTypeToString(currentState.primaryContactType),
        currentPage: currentState.currentPage,
        currentStep: currentState.currentPage == 0
            ? SignupDraft.stepFormPage0
            : SignupDraft.stepFormPage1,
      );
      await _signupStateService!.saveDraft(draft);
    }
  }

  PrimaryContactType _stringToPrimaryContactType(String? type) {
    switch (type) {
      case 'email':
        return PrimaryContactType.email;
      case 'phone':
        return PrimaryContactType.phone;
      default:
        return PrimaryContactType.none;
    }
  }

  String? _primaryContactTypeToString(PrimaryContactType type) {
    switch (type) {
      case PrimaryContactType.email:
        return 'email';
      case PrimaryContactType.phone:
        return 'phone';
      case PrimaryContactType.none:
        return null;
    }
  }

  void signUpEmailChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(email: value, clearErrorMessage: true, isLoading: false));
      _scheduleDraftSave(); // Auto-save draft
    }
  }

  void signUpPasswordChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(password: value, clearErrorMessage: true, isLoading: false));
      // Note: We don't save password to draft for security
    }
  }

  void signUpConfirmPasswordChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(confirmPassword: value, clearErrorMessage: true, isLoading: false));
      // Note: We don't save password to draft for security
    }
  }

  void signUpFirstNameChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(firstName: value, clearErrorMessage: true, isLoading: false));
      _scheduleDraftSave(); // Auto-save draft
    }
  }

  void signUpLastNameChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(lastName: value, clearErrorMessage: true, isLoading: false));
      _scheduleDraftSave(); // Auto-save draft
    }
  }

  void signUpUsernameChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(username: value, clearErrorMessage: true, isLoading: false));
      _scheduleDraftSave(); // Auto-save draft
    }
  }

  void signUpReferralCodeChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(referralCode: value, clearErrorMessage: true, isLoading: false));
      _scheduleDraftSave(); // Auto-save draft
    }
  }

  void signUpDateOfBirthChanged(DateTime? value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(selectedDate: value, clearErrorMessage: true, isLoading: false));
      _scheduleDraftSave(); // Auto-save draft
    }
  }

  void signUpPhoneNumberChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      // Format phone number to remove spaces and special characters
      final formattedPhone = _formatPhoneNumber(value);
      emit(currentState.copyWith(phoneNumber: formattedPhone, clearErrorMessage: true, isLoading: false));
      _scheduleDraftSave(); // Auto-save draft
    }
  }

  // ========== COUNTRY & IDENTITY VERIFICATION METHODS ==========

  /// Change selected country (Nigeria only for now)
  void signUpCountryChanged(String countryCode, String countryName, String currencyCode) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(
        countryCode: countryCode,
        countryName: countryName,
        currencyCode: currencyCode,
        clearErrorMessage: true,
        isLoading: false,
      ));
      _scheduleDraftSave();
    }
  }

  /// Change identity verification type (BVN or NIN)
  void signUpIdentityTypeChanged(IdentityType type) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(
        identityType: type,
        // Clear both fields when switching types
        bvn: type == IdentityType.bvn ? currentState.bvn : '',
        nin: type == IdentityType.nin ? currentState.nin : '',
        bvnVerified: false,
        clearErrorMessage: true,
        isLoading: false,
      ));
    }
  }

  /// Change BVN value
  void signUpBvnChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      // Remove any non-digit characters
      final cleanedBvn = value.replaceAll(RegExp(r'[^0-9]'), '');
      emit(currentState.copyWith(
        bvn: cleanedBvn,
        bvnVerified: false, // Reset verification when BVN changes
        clearErrorMessage: true,
        isLoading: false,
      ));
    }
  }

  /// Change NIN value
  void signUpNinChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      // Remove any non-digit characters
      final cleanedNin = value.replaceAll(RegExp(r'[^0-9]'), '');
      emit(currentState.copyWith(
        nin: cleanedNin,
        bvnVerified: false, // Reset verification when NIN changes
        clearErrorMessage: true,
        isLoading: false,
      ));
    }
  }

  /// Change generic identity value (for non-NG countries)
  void signUpIdentityValueChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(
        identityValue: value,
        bvnVerified: false, // Reset verification when identity value changes
        clearErrorMessage: true,
        isLoading: false,
      ));
    }
  }

  /// Validate BVN format (must be exactly 11 digits)
  String? _validateBvn(String bvn) {
    if (bvn.isEmpty) return 'BVN is required';
    if (bvn.length != 11) return 'BVN must be exactly 11 digits';
    if (!RegExp(r'^\d{11}$').hasMatch(bvn)) return 'BVN must contain only numbers';
    return null;
  }

  /// Validate NIN format (must be exactly 11 digits)
  String? _validateNin(String nin) {
    if (nin.isEmpty) return 'NIN is required';
    if (nin.length != 11) return 'NIN must be exactly 11 digits';
    if (!RegExp(r'^\d{11}$').hasMatch(nin)) return 'NIN must contain only numbers';
    return null;
  }

  /// Get identity value based on identity type
  String _getIdentityValueForType(SignUpInProgress state) {
    switch (state.identityType) {
      case IdentityType.bvn:
        return state.bvn;
      case IdentityType.nin:
        return state.nin;
      default:
        return state.identityValue;
    }
  }

  /// Validate identity value based on country and type
  String? _validateIdentityValue(String countryCode, IdentityType identityType, String value) {
    if (value.isEmpty) {
      return '${identityType.displayName} is required';
    }

    switch (identityType) {
      case IdentityType.bvn:
        return _validateBvn(value);
      case IdentityType.nin:
        return _validateNin(value);
      case IdentityType.ssn:
        if (value.length != 4 || !RegExp(r'^\d{4}$').hasMatch(value)) {
          return 'SSN must be exactly 4 digits';
        }
        return null;
      case IdentityType.saId:
        if (value.length != 13 || !RegExp(r'^\d{13}$').hasMatch(value)) {
          return 'South African ID must be exactly 13 digits';
        }
        return null;
      case IdentityType.kenyaNationalId:
        if (value.length < 7 || value.length > 8 || !RegExp(r'^\d+$').hasMatch(value)) {
          return 'Kenya National ID must be 7-8 digits';
        }
        return null;
      case IdentityType.ghanaCard:
        // Ghana Card format: GHA-XXXXXXXXX-X
        if (!RegExp(r'^GHA-\d{9}-\d$').hasMatch(value) && value.length < 10) {
          return 'Please enter a valid Ghana Card number';
        }
        return null;
      case IdentityType.passport:
      case IdentityType.usPassport:
      case IdentityType.ghanaPassport:
      case IdentityType.kenyaPassport:
      case IdentityType.saPassport:
        if (value.length < 6) {
          return 'Passport number must be at least 6 characters';
        }
        return null;
      case IdentityType.drivingLicence:
        if (value.length < 8) {
          return 'Driving licence number must be at least 8 characters';
        }
        return null;
      case IdentityType.stateId:
      case IdentityType.ghanaVoterId:
        if (value.length < 6) {
          return 'ID number must be at least 6 characters';
        }
        return null;
    }
  }

  /// Map identity type enum to backend string format
  String _getIdentityTypeString(IdentityType type) {
    switch (type) {
      case IdentityType.bvn:
        return 'bvn';
      case IdentityType.nin:
        return 'nin';
      case IdentityType.ssn:
        return 'ssn';
      case IdentityType.passport:
        return 'uk_passport';
      case IdentityType.drivingLicence:
        return 'uk_driving_licence';
      case IdentityType.usPassport:
        return 'us_passport';
      case IdentityType.stateId:
        return 'us_state_id';
      case IdentityType.ghanaCard:
        return 'ghana_card';
      case IdentityType.ghanaVoterId:
        return 'ghana_voter_id';
      case IdentityType.ghanaPassport:
        return 'ghana_passport';
      case IdentityType.kenyaNationalId:
        return 'kenya_national_id';
      case IdentityType.kenyaPassport:
        return 'kenya_passport';
      case IdentityType.saId:
        return 'sa_id';
      case IdentityType.saPassport:
        return 'sa_passport';
    }
  }

  /// Verify identity with backend - supports multi-country verification
  /// This calls the auth service which connects to banking service to verify identity
  Future<void> verifyIdentity() async {
    if (state is! SignUpInProgress) return;

    final currentState = state as SignUpInProgress;

    // Get identity value based on identity type
    final identityNumber = _getIdentityValueForType(currentState);

    // Validate format based on country and identity type
    final error = _validateIdentityValue(currentState.countryCode, currentState.identityType, identityNumber);

    if (error != null) {
      _showErrorSnackbar('Validation Error', error);
      emit(currentState.copyWith(errorMessage: error));
      return;
    }

    // Validate date of birth is set (required for most verifications)
    if (currentState.selectedDate == null) {
      _showErrorSnackbar('Validation Error', 'Date of birth is required for verification');
      emit(currentState.copyWith(errorMessage: 'Date of birth is required'));
      return;
    }

    if (isClosed) return;
    emit(currentState.copyWith(isLoading: true, clearErrorMessage: true));

    try {
      // Format date as YYYY-MM-DD
      final dob = currentState.selectedDate!;
      final formattedDob = '${dob.year}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}';

      // Map identity type to backend format
      final identityTypeString = _getIdentityTypeString(currentState.identityType);

      // Call the actual backend endpoint via use case
      final result = await _verifyIdentityUseCase(
        identityType: identityTypeString,
        identityNumber: identityNumber,
        dateOfBirth: formattedDob,
        countryCode: currentState.countryCode,
      );

      if (isClosed) return;

      result.fold(
        (failure) {
          final errorMsg = failure.message ?? 'Failed to verify identity';
          _showErrorSnackbar('Verification Failed', errorMsg);
          emit(currentState.copyWith(
            isLoading: false,
            bvnVerified: false,
            errorMessage: errorMsg,
          ));
        },
        (verificationResult) {
          if (verificationResult.verified) {
            emit(currentState.copyWith(
              isLoading: false,
              bvnVerified: true,
              verifiedFirstName: verificationResult.firstName ?? currentState.firstName,
              verifiedLastName: verificationResult.lastName ?? currentState.lastName,
              verifiedDateOfBirth: verificationResult.dateOfBirth ?? formattedDob,
              clearErrorMessage: true,
            ));

            _showSuccessSnackbar(
              'Identity Verified!',
              'Your ${currentState.identityType.displayName} has been verified successfully.',
            );
          } else {
            _showErrorSnackbar('Verification Failed', 'Identity could not be verified');
            emit(currentState.copyWith(
              isLoading: false,
              bvnVerified: false,
              errorMessage: 'Identity could not be verified',
            ));
          }
        },
      );
    } catch (e) {
      if (isClosed) return;
      final errorMsg = 'Failed to verify identity: ${e.toString()}';
      _showErrorSnackbar('Verification Failed', errorMsg);
      emit(currentState.copyWith(
        isLoading: false,
        bvnVerified: false,
        errorMessage: errorMsg,
      ));
    }
  }

  /// Skip identity verification for progressive KYC onboarding
  /// Allows users to complete signup as Tier 1 and verify later
  void skipIdentityVerification() {
    if (state is! SignUpInProgress) return;

    final currentState = state as SignUpInProgress;

    // Show info that user will have limited access
    _showInfoSnackbar(
      'Account Created with Tier 1',
      'You can verify your identity anytime from Settings to unlock higher limits.',
    );

    // Mark as skipped and proceed with signup
    if (isClosed) return;
    emit(currentState.copyWith(
      kycSkipped: true,
      bvnVerified: false,
      clearErrorMessage: true,
    ));

    // Proceed directly to signup submission
    signUpSubmitted();
  }

  /// Unified method to handle email or phone number input
  /// Intelligently detects whether input is an email or phone number
  void signUpEmailOrPhoneChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      final trimmedValue = value.trim();

      // Detect if input looks like an email or phone number
      final isEmail = _looksLikeEmail(trimmedValue);
      final isPhone = _looksLikePhone(trimmedValue);

      if (isEmail) {
        // Store as email and set primary contact type
        emit(currentState.copyWith(
          email: trimmedValue,
          phoneNumber: '', // Clear phone
          primaryContactType: PrimaryContactType.email,
          clearErrorMessage: true,
          isLoading: false,
        ));
      } else if (isPhone) {
        // Store as phone and set primary contact type
        final formattedPhone = _formatPhoneNumber(trimmedValue);
        emit(currentState.copyWith(
          phoneNumber: formattedPhone,
          email: '', // Clear email
          primaryContactType: PrimaryContactType.phone,
          clearErrorMessage: true,
          isLoading: false,
        ));
      } else {
        // Input is ambiguous - store in both fields temporarily
        // and let validation determine the type later
        // If it contains @ it's likely email, otherwise treat as phone
        if (trimmedValue.contains('@')) {
          emit(currentState.copyWith(
            email: trimmedValue,
            phoneNumber: '',
            primaryContactType: PrimaryContactType.email,
            clearErrorMessage: true,
            isLoading: false,
          ));
        } else if (trimmedValue.isNotEmpty && RegExp(r'^[0-9+\-\s()]+$').hasMatch(trimmedValue)) {
          // Contains only phone-like characters
          emit(currentState.copyWith(
            phoneNumber: _formatPhoneNumber(trimmedValue),
            email: '',
            primaryContactType: PrimaryContactType.phone,
            clearErrorMessage: true,
            isLoading: false,
          ));
        } else {
          // Default to email field (most common)
          emit(currentState.copyWith(
            email: trimmedValue,
            primaryContactType: trimmedValue.isEmpty ? PrimaryContactType.none : PrimaryContactType.email,
            clearErrorMessage: true,
            isLoading: false,
          ));
        }
      }
      _scheduleDraftSave();
    }
  }

  /// Check if input looks like an email address
  bool _looksLikeEmail(String value) {
    if (value.isEmpty) return false;
    // Simple check: contains @ and has text before and after
    return value.contains('@') &&
           value.indexOf('@') > 0 &&
           value.indexOf('@') < value.length - 1;
  }

  /// Check if input looks like a phone number
  bool _looksLikePhone(String value) {
    if (value.isEmpty) return false;
    // Remove common phone formatting characters
    final cleaned = value.replaceAll(RegExp(r'[\s\-\(\)\+]'), '');
    // Check if remaining characters are mostly digits (allowing for some letters in some formats)
    final digitCount = cleaned.replaceAll(RegExp(r'[^0-9]'), '').length;
    return digitCount >= 7 && digitCount <= 15 && digitCount / cleaned.length > 0.8;
  }

  /// Get the current primary contact value (email or phone) for display
  String get currentPrimaryContactValue {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      if (currentState.primaryContactType == PrimaryContactType.phone) {
        return currentState.phoneNumber;
      }
      return currentState.email;
    }
    return '';
  }

  // New method to set primary contact type (email or phone)
  void signUpSetPrimaryContactType(PrimaryContactType type) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      // When switching types, clear the data for the previous type
      if (type == PrimaryContactType.email) {
        emit(currentState.copyWith(
          primaryContactType: type,
          phoneNumber: '', // Clear phone if switching to email
          clearErrorMessage: true,
        ));
      } else if (type == PrimaryContactType.phone) {
        emit(currentState.copyWith(
          primaryContactType: type,
          email: '', // Clear email if switching to phone
          clearErrorMessage: true,
        ));
      }
      _scheduleDraftSave(); // Auto-save draft
    }
  }

  /// Signup flow pages:
  /// Page 0: Country Selection (Nigeria only for now)
  /// Page 1: Email/Phone + Password
  /// Page 2: Personal Info (First Name, Last Name, DOB)
  /// Page 3: BVN/NIN Verification
  Future<void> signUpNextPage() async {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;

      if (currentState.currentPage == 0) {
        // ========== PAGE 0: Country Selection ==========
        // For now, only Nigeria is supported
        if (currentState.countryCode.isEmpty) {
          final errorMsg = 'Please select your country';
          _showErrorSnackbar('Validation Error', errorMsg);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: errorMsg));
          return;
        }

        // Validate country is in supported list
        final supportedCountries = ['NG', 'GB', 'US', 'GH', 'KE', 'ZA'];
        if (!supportedCountries.contains(currentState.countryCode)) {
          final errorMsg = 'Selected country is not currently supported. Please choose from: Nigeria, UK, USA, Ghana, Kenya, or South Africa.';
          _showErrorSnackbar('Country Not Supported', errorMsg);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: errorMsg));
          return;
        }

        // Proceed to page 1
        if (isClosed) return;
        emit(currentState.copyWith(currentPage: 1, clearErrorMessage: true));
        return;
      } else if (currentState.currentPage == 1) {
        // ========== PAGE 1: Email/Phone + Password ==========
        final hasEmail = currentState.email.isNotEmpty;
        final hasPhone = currentState.phoneNumber.isNotEmpty;

        if (!hasEmail && !hasPhone) {
          final errorMsg = 'Email or phone number is required';
          _showErrorSnackbar('Validation Error', errorMsg);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: errorMsg));
          return;
        }

        // Validate based on what was entered
        if (currentState.primaryContactType == PrimaryContactType.email ||
            (currentState.primaryContactType == PrimaryContactType.none && hasEmail)) {
          if (!_isValidEmail(currentState.email)) {
            final errorMsg = 'Please enter a valid email address';
            _showErrorSnackbar('Validation Error', errorMsg);
            if (isClosed) return;
            emit(currentState.copyWith(errorMessage: errorMsg));
            return;
          }
          if (currentState.primaryContactType == PrimaryContactType.none) {
            emit(currentState.copyWith(primaryContactType: PrimaryContactType.email));
          }
        } else if (currentState.primaryContactType == PrimaryContactType.phone ||
                   (currentState.primaryContactType == PrimaryContactType.none && hasPhone)) {
          if (!_isValidPhoneNumber(currentState.phoneNumber)) {
            final errorMsg = 'Please enter a valid phone number';
            _showErrorSnackbar('Validation Error', errorMsg);
            if (isClosed) return;
            emit(currentState.copyWith(errorMessage: errorMsg));
            return;
          }
          if (currentState.primaryContactType == PrimaryContactType.none) {
            emit(currentState.copyWith(primaryContactType: PrimaryContactType.phone));
          }
        }

        // Validate password
        if (currentState.password.isEmpty) {
          final errorMsg = 'Password is required';
          _showErrorSnackbar('Validation Error', errorMsg);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: errorMsg));
          return;
        }

        final passwordError = _validatePassword(currentState.password);
        if (passwordError != null) {
          _showErrorSnackbar('Password Requirements', passwordError);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: passwordError));
          return;
        }

        if (currentState.confirmPassword.isEmpty) {
          final errorMsg = 'Please confirm your password';
          _showErrorSnackbar('Validation Error', errorMsg);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: errorMsg));
          return;
        }

        if (currentState.password != currentState.confirmPassword) {
          final errorMsg = 'Passwords do not match';
          _showErrorSnackbar('Validation Error', errorMsg);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: errorMsg));
          return;
        }

        // Check email availability
        if (currentState.primaryContactType == PrimaryContactType.email ||
            currentState.primaryContactType == PrimaryContactType.none) {
          if (isClosed) return;
          emit(currentState.copyWith(isLoading: true, clearErrorMessage: true));

          final result = await _checkEmailAvailabilityUseCase(email: currentState.email);

          if (isClosed) return;

          final bool shouldProceed = result.fold(
            (failure) {
              final errorMsg = 'Failed to verify email availability. Please try again.';
              _showErrorSnackbar('Connection Error', errorMsg);
              emit(currentState.copyWith(errorMessage: errorMsg, isLoading: false));
              return false;
            },
            (isAvailable) {
              if (!isAvailable) {
                final errorMsg = 'This email is already registered. Please use a different email or sign in.';
                _showErrorSnackbar('Email Already Exists', errorMsg);
                emit(currentState.copyWith(errorMessage: errorMsg, isLoading: false));
                return false;
              }
              return true;
            },
          );

          if (!shouldProceed) return;

          emit(currentState.copyWith(currentPage: 2, clearErrorMessage: true, isLoading: false));
          return;
        } else {
          emit(currentState.copyWith(currentPage: 2, clearErrorMessage: true, isLoading: false));
          return;
        }
      } else if (currentState.currentPage == 2) {
        // ========== PAGE 2: Personal Info ==========
        final firstNameError = _validateName(currentState.firstName, 'First name');
        if (firstNameError != null) {
          _showErrorSnackbar('Validation Error', firstNameError);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: firstNameError));
          return;
        }

        final lastNameError = _validateName(currentState.lastName, 'Last name');
        if (lastNameError != null) {
          _showErrorSnackbar('Validation Error', lastNameError);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: lastNameError));
          return;
        }

        final dobError = _validateDateOfBirth(currentState.selectedDate);
        if (dobError != null) {
          _showErrorSnackbar('Validation Error', dobError);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: dobError));
          return;
        }

        // Secondary contact validation (optional)
        if (currentState.primaryContactType == PrimaryContactType.phone) {
          if (currentState.email.isNotEmpty && !_isValidEmail(currentState.email)) {
            final errorMsg = 'Please enter a valid email address';
            _showErrorSnackbar('Validation Error', errorMsg);
            if (isClosed) return;
            emit(currentState.copyWith(errorMessage: errorMsg));
            return;
          }
        } else {
          final phoneError = _validateOptionalPhoneNumber(currentState.phoneNumber);
          if (phoneError != null) {
            _showErrorSnackbar('Validation Error', phoneError);
            if (isClosed) return;
            emit(currentState.copyWith(errorMessage: phoneError));
            return;
          }
        }

        // Proceed to BVN/NIN verification page
        if (isClosed) return;
        emit(currentState.copyWith(currentPage: 3, clearErrorMessage: true));
        return;
      } else if (currentState.currentPage == 3) {
        // ========== PAGE 3: BVN/NIN Verification ==========
        final identityNumber = currentState.identityType == IdentityType.bvn
            ? currentState.bvn
            : currentState.nin;

        final error = currentState.identityType == IdentityType.bvn
            ? _validateBvn(identityNumber)
            : _validateNin(identityNumber);

        if (error != null) {
          _showErrorSnackbar('Validation Error', error);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: error));
          return;
        }

        // Check if already verified
        if (!currentState.bvnVerified) {
          final errorMsg = 'Please verify your ${currentState.identityType == IdentityType.bvn ? 'BVN' : 'NIN'} before proceeding';
          _showInfoSnackbar('Verification Required', errorMsg);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: errorMsg));
          return;
        }

        // BVN is verified, can proceed with signup submission
        // The actual submission happens in signUpSubmitted()
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
      // Email validation - required only if email is primary contact
      if (currentState.primaryContactType == PrimaryContactType.email ||
          currentState.primaryContactType == PrimaryContactType.none) {
        // Email is primary - must be valid
        if (!_isValidEmail(currentState.email)) {
          final errorMsg = 'Please enter a valid email address';
          _showErrorSnackbar('Validation Error', errorMsg);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: errorMsg, isLoading: false));
          return;
        }
      } else {
        // Phone is primary - email is optional, only validate format if provided
        if (currentState.email.isNotEmpty && !_isValidEmail(currentState.email)) {
          final errorMsg = 'Please enter a valid email address';
          _showErrorSnackbar('Validation Error', errorMsg);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: errorMsg, isLoading: false));
          return;
        }
      }

      final passwordError = _validatePassword(currentState.password);
      if (passwordError != null) {
        _showErrorSnackbar('Password Requirements', passwordError);
        if (isClosed) return;
        emit(currentState.copyWith(errorMessage: passwordError, isLoading: false));
        return;
      }

      if (currentState.password != currentState.confirmPassword) {
        final errorMsg = 'Passwords do not match';
        _showErrorSnackbar('Validation Error', errorMsg);
        if (isClosed) return;
        emit(currentState.copyWith(errorMessage: errorMsg, isLoading: false));
        return;
      }

      final firstNameError = _validateName(currentState.firstName, 'First name');
      if (firstNameError != null) {
        _showErrorSnackbar('Validation Error', firstNameError);
        if (isClosed) return;
        emit(currentState.copyWith(errorMessage: firstNameError, isLoading: false));
        return;
      }

      final lastNameError = _validateName(currentState.lastName, 'Last name');
      if (lastNameError != null) {
        _showErrorSnackbar('Validation Error', lastNameError);
        if (isClosed) return;
        emit(currentState.copyWith(errorMessage: lastNameError, isLoading: false));
        return;
      }

      final dobError = _validateDateOfBirth(currentState.selectedDate);
      if (dobError != null) {
        _showErrorSnackbar('Validation Error', dobError);
        if (isClosed) return;
        emit(currentState.copyWith(errorMessage: dobError, isLoading: false));
        return;
      }

      // Phone validation - required only if phone is primary contact
      if (currentState.primaryContactType == PrimaryContactType.phone) {
        // Phone is primary - must be valid
        final phoneError = _validatePhoneNumber(currentState.phoneNumber);
        if (phoneError != null) {
          _showErrorSnackbar('Validation Error', phoneError);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: phoneError, isLoading: false));
          return;
        }
      } else {
        // Email is primary - phone is optional, only validate format if provided
        final phoneError = _validateOptionalPhoneNumber(currentState.phoneNumber);
        if (phoneError != null) {
          _showErrorSnackbar('Validation Error', phoneError);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: phoneError, isLoading: false));
          return;
        }
      }

      // BVN/NIN verification is required for Nigerian users UNLESS user explicitly skips (progressive KYC)
      // With progressive KYC, users can skip and get Tier 1 limits
      if (currentState.countryCode == 'NG' && !currentState.bvnVerified && !currentState.kycSkipped) {
        final errorMsg = 'Please verify your BVN/NIN before completing signup, or skip to continue with Tier 1 limits';
        _showInfoSnackbar('Verification Optional', errorMsg);
        if (isClosed) return;
        // Don't return - allow user to see the error on the page
        // The actual blocking happens on page 3 navigation
        emit(currentState.copyWith(errorMessage: errorMsg, isLoading: false));
        // If we're here from skipIdentityVerification, proceed anyway
        if (!currentState.kycSkipped) {
          return;
        }
      }

      if (currentState.isLoading) return;
      if (isClosed) return;
      emit(currentState.copyWith(isLoading: true, clearErrorMessage: true));

      // Determine primary contact for backend
      final primaryContact = currentState.primaryContactType == PrimaryContactType.phone
          ? SignupPrimaryContact.phone
          : SignupPrimaryContact.email;

      // Call the sign up use case with country and BVN info
      final result = await _signUpUseCase(
        firstName: currentState.firstName,
        lastName: currentState.lastName,
        email: currentState.email,
        password: currentState.password,
        primaryContact: primaryContact,
        phoneNumber: currentState.phoneNumber.isEmpty ? null : currentState.phoneNumber,
        username: currentState.username.isEmpty ? null : currentState.username,
        referralCode: currentState.referralCode.isEmpty ? null : currentState.referralCode,
        countryCode: currentState.countryCode,
        currencyCode: currentState.currencyCode,
        bvn: currentState.bvn.isEmpty ? null : currentState.bvn,
        nin: currentState.nin.isEmpty ? null : currentState.nin,
      );

      if (isClosed) return;
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

          // Emit UserCreated state instead of AuthenticationSuccess
          // to prevent conflict with login flow
          emit(UserCreated());
        },
      );
    } else {
      print('Cannot submit sign up from current state: $state');
      if (isClosed) return;
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

  bool _isValidPhoneNumber(String phone) {
    // Validate phone number - expects E.164 format from IntlPhoneField
    // E.164 format: +[country code][number] (e.g., +12345678901)
    if (phone.isEmpty) return false;

    // Remove any whitespace
    final cleanPhone = phone.replaceAll(RegExp(r'\s+'), '');

    // Check if it starts with + and has 7-15 digits (E.164 standard)
    final phoneRegex = RegExp(r'^\+[1-9]\d{6,14}$');
    return phoneRegex.hasMatch(cleanPhone);
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

  // Validates phone number only if provided (for optional secondary contact)
  String? _validateOptionalPhoneNumber(String phoneNumber) {
    // If empty, it's valid (optional field)
    if (phoneNumber.isEmpty) return null;

    // If provided, validate the format
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
    if (isClosed) return;
    emit(currentState.copyWith(isRegistering: true, clearError: true));

    // Store passcode locally
    try {
      await _storage.write(key: 'user_passcode', value: passcode);
    } catch (e) {
      print('Error storing passcode locally: $e');
    }

    // Call backend API
    final result = await _registerPasscodeUseCase(passcode: passcode);

    if (isClosed) return;
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

        // Mark signup as complete (passcode is the final step)
        await _signupStateService?.markSignupComplete();

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

  Future<void> skipPasscodeSetup() async {
    // Mark signup as complete even when skipping passcode
    await _signupStateService?.markSignupComplete();

    // Emit success to navigate to dashboard
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

    // Try multiple keys for email (for backwards compatibility)
    String? email = await _storage.read(key: _userEmailKey);
    if (email == null || email.isEmpty) {
      email = await _storage.read(key: 'stored_email');
    }

    print('🔐 Passcode login attempt - Email from storage: $email');

    if (email == null || email.isEmpty) {
      _showErrorSnackbar('Error', 'No stored email found. Please use email/password login.');
      if (isClosed) return;
      emit(currentState.copyWith(enteredPasscode: '', clearError: true));
      return;
    }

    if (isClosed) return;
    emit(currentState.copyWith(isAuthenticating: true, clearError: true));

    print('🔐 Calling loginWithPasscode for email: $email');

    final result = await _loginWithPasscodeUseCase(
      email: email,
      passcode: passcode,
    );

    if (isClosed) return;
    result.fold(
      (failure) {
        print('🔐 Passcode login failed: ${failure.message}');
        _showErrorSnackbar('Login Failed', failure.message);
        emit(PasscodeLoginInProgress(
          enteredPasscode: '',
          isAuthenticating: false,
          errorMessage: failure.message,
        ));
      },
      (profile) async {
        print('🔐 Passcode login successful for: ${profile.user.email}');
        await _saveSession(profile);
        await _storage.write(key: 'login_method', value: 'passcode');
        await _storage.write(key: 'stored_email', value: email);
        _showSuccessSnackbar('Welcome back!', '${profile.user.firstName} ${profile.user.lastName}');
        emit(AuthenticationSuccess(profile));
      },
    );
  }

  // ========== Password Recovery Verification Methods ==========
  // TODO: Implement with proper use cases

  Future<void> verifyPasswordResetCode(String email, String code) async {
    // Placeholder - needs use case implementation
    emit(const PasswordRecoveryVerificationInProgress());
    await Future.delayed(const Duration(seconds: 1));
    emit(AuthenticationFailure('Password reset code verification not yet implemented'));
  }

  Future<void> resendPasswordResetCode(String email, String deliveryMethod) async {
    // Placeholder - needs use case implementation
    emit(const PasswordRecoveryResendInProgress());
    await Future.delayed(const Duration(seconds: 1));
    emit(AuthenticationFailure('Resend code not yet implemented'));
  }

  // ========== Facial Recognition Methods ==========
  // TODO: Implement with proper use cases

  Future<void> loginWithFace(String email, List<int> imageData) async {
    // Placeholder - needs use case implementation
    emit(const FacialRecognitionLoginInProgress());
    await Future.delayed(const Duration(seconds: 1));
    emit(AuthenticationFailure('Facial recognition login not yet implemented'));
  }

  Future<bool> checkFaceRegistration() async {
    // Placeholder - needs use case implementation
    // DON'T emit states here as it interferes with passcode login flow
    await Future.delayed(const Duration(milliseconds: 100));
    return false;
  }

  // ========== Two-Factor Authentication Methods ==========

  /// Get the current 2FA status for the authenticated user
  Future<TwoFactorStatus> getTwoFactorStatus() async {
    // This will call the use case which communicates with the backend
    // For now, return a default disabled status
    return const TwoFactorStatus.disabled();
  }

  /// Enable two-factor authentication for the user
  /// Returns the setup data including QR code and backup codes
  Future<TwoFactorSetup> enableTwoFactor(TwoFactorMethod method) async {
    if (isClosed) throw Exception('Cubit is closed');

    // This will call the use case to initiate 2FA setup
    // The use case returns secret, QR code, and backup codes
    // For now, return empty data
    return const TwoFactorSetup.empty();
  }

  /// Complete two-factor authentication setup by verifying the code
  Future<bool> completeTwoFactorSetup(String userId, String code) async {
    if (isClosed) return false;

    // This will call the use case to verify and enable 2FA
    // Returns true if successful
    _showSuccessSnackbar(
      '2FA Enabled',
      'Two-factor authentication has been enabled on your account.',
    );
    return true;
  }

  /// Verify two-factor authentication code during login
  Future<bool> verifyTwoFactor(String twoFactorToken, String code) async {
    if (isClosed) return false;

    // This will call the use case to verify the 2FA code
    // Returns true if verification successful
    return true;
  }

  /// Disable two-factor authentication
  Future<bool> disableTwoFactor(String code) async {
    if (isClosed) return false;

    // This will call the use case to disable 2FA
    // Returns true if successful
    _showSuccessSnackbar(
      '2FA Disabled',
      'Two-factor authentication has been disabled from your account.',
    );
    return true;
  }

  /// Regenerate backup codes for 2FA
  Future<List<String>> regenerateBackupCodes(String code) async {
    if (isClosed) throw Exception('Cubit is closed');

    // This will call the use case to regenerate backup codes
    // Returns new list of backup codes
    _showSuccessSnackbar(
      'Backup Codes Regenerated',
      'Your new backup codes have been generated. Please save them securely.',
    );
    return [];
  }

  /// Send a new 2FA code (for SMS/Email methods)
  Future<bool> sendTwoFactorCode() async {
    if (isClosed) return false;

    // This will call the use case to send a new code
    _showSuccessSnackbar(
      'Code Sent',
      'A new verification code has been sent.',
    );
    return true;
  }
}
