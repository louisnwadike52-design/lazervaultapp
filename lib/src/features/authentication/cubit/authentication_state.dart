import 'package:equatable/equatable.dart';
import '../domain/entities/profile_entity.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

// Checking for existing session
class AuthenticationCheckingSession extends AuthenticationState {
  const AuthenticationCheckingSession();
}

// Generic Loading state (can be used for various auth operations)
class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading();
}

// State indicating successful authentication (login, signup, social)
class AuthenticationSuccess extends AuthenticationState {
  final ProfileEntity profile;

  const AuthenticationSuccess(this.profile);

  @override
  List<Object?> get props => [profile];
}

// Email verified state
class EmailVerified extends AuthenticationState {
  final ProfileEntity profile;

  const EmailVerified(this.profile);

  @override
  List<Object?> get props => [profile];
}

// Password reset email sent
class PasswordResetEmailSent extends AuthenticationState {
  const PasswordResetEmailSent();
}

// Password reset completed
class PasswordResetSuccess extends AuthenticationState {
  const PasswordResetSuccess();
}

// Forgot Password Flow State
class ForgotPasswordInProgress extends AuthenticationState {
  const ForgotPasswordInProgress({
    this.email = '',
    this.isLoading = false,
    this.errorMessage,
  });

  final String email;
  final bool isLoading;
  final String? errorMessage;

  ForgotPasswordInProgress copyWith({
    String? email,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ForgotPasswordInProgress(
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [email, isLoading, errorMessage];
}

// Reset Password Flow State
class ResetPasswordInProgress extends AuthenticationState {
  const ResetPasswordInProgress({
    this.email = '',
    this.token = '',
    this.newPassword = '',
    this.confirmPassword = '',
    this.isLoading = false,
    this.errorMessage,
  });

  final String email;
  final String token;
  final String newPassword;
  final String confirmPassword;
  final bool isLoading;
  final String? errorMessage;

  ResetPasswordInProgress copyWith({
    String? email,
    String? token,
    String? newPassword,
    String? confirmPassword,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ResetPasswordInProgress(
      email: email ?? this.email,
      token: token ?? this.token,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [email, token, newPassword, confirmPassword, isLoading, errorMessage];
}

class CreatingUser extends AuthenticationState {
  const CreatingUser();
}

class GettingUsers extends AuthenticationState {
  const GettingUsers();
}

class UserCreated extends AuthenticationState {
  const UserCreated();
}

class UsersLoaded extends AuthenticationState {
  const UsersLoaded(this.users);

  final List<ProfileEntity> users;

  @override
  List<Object?> get props => [users];
}

class AuthenticationError extends AuthenticationState {
  const AuthenticationError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

// Enum to track which contact type was entered on page 1
enum PrimaryContactType {
  email,
  phone,
  none, // Initial state before user chooses
}

// Enum to track identity verification type
enum IdentityType {
  bvn,  // Bank Verification Number (11 digits)
  nin,  // National Identification Number (11 digits)
}

class SignUpInProgress extends AuthenticationState {
  const SignUpInProgress({
    this.currentPage = 0,
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.firstName = '',
    this.lastName = '',
    this.username = '',
    this.referralCode = '',
    this.selectedDate,
    this.phoneNumber = '',
    this.isLoading = false,
    this.errorMessage,
    this.primaryContactType = PrimaryContactType.none,
    // Country selection (Nigeria only for now)
    this.countryCode = 'NG',
    this.countryName = 'Nigeria',
    this.currencyCode = 'NGN',
    // BVN/NIN verification
    this.identityType = IdentityType.bvn,
    this.bvn = '',
    this.nin = '',
    this.bvnVerified = false,
    this.verifiedFirstName,
    this.verifiedLastName,
    this.verifiedDateOfBirth,
  });

  final int currentPage;
  final String email;
  final String password;
  final String confirmPassword;
  final String firstName;
  final String lastName;
  final String username;
  final String referralCode;
  final DateTime? selectedDate;
  final String phoneNumber;
  final bool isLoading;
  final String? errorMessage;
  final PrimaryContactType primaryContactType;

  // Country selection
  final String countryCode;
  final String countryName;
  final String currencyCode;

  // BVN/NIN verification
  final IdentityType identityType;
  final String bvn;
  final String nin;
  final bool bvnVerified;
  final String? verifiedFirstName;
  final String? verifiedLastName;
  final String? verifiedDateOfBirth;

  SignUpInProgress copyWith({
    int? currentPage,
    String? email,
    String? password,
    String? confirmPassword,
    String? firstName,
    String? lastName,
    String? username,
    String? referralCode,
    DateTime? selectedDate,
    String? phoneNumber,
    bool? isLoading,
    String? errorMessage,
    bool clearErrorMessage = false,
    PrimaryContactType? primaryContactType,
    String? countryCode,
    String? countryName,
    String? currencyCode,
    IdentityType? identityType,
    String? bvn,
    String? nin,
    bool? bvnVerified,
    String? verifiedFirstName,
    String? verifiedLastName,
    String? verifiedDateOfBirth,
  }) {
    return SignUpInProgress(
      currentPage: currentPage ?? this.currentPage,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      referralCode: referralCode ?? this.referralCode,
      selectedDate: selectedDate ?? this.selectedDate,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearErrorMessage ? null : errorMessage ?? this.errorMessage,
      primaryContactType: primaryContactType ?? this.primaryContactType,
      countryCode: countryCode ?? this.countryCode,
      countryName: countryName ?? this.countryName,
      currencyCode: currencyCode ?? this.currencyCode,
      identityType: identityType ?? this.identityType,
      bvn: bvn ?? this.bvn,
      nin: nin ?? this.nin,
      bvnVerified: bvnVerified ?? this.bvnVerified,
      verifiedFirstName: verifiedFirstName ?? this.verifiedFirstName,
      verifiedLastName: verifiedLastName ?? this.verifiedLastName,
      verifiedDateOfBirth: verifiedDateOfBirth ?? this.verifiedDateOfBirth,
    );
  }

  @override
  List<Object?> get props => [
        currentPage,
        email,
        password,
        confirmPassword,
        firstName,
        lastName,
        username,
        referralCode,
        selectedDate,
        phoneNumber,
        isLoading,
        errorMessage,
        primaryContactType,
        countryCode,
        countryName,
        currencyCode,
        identityType,
        bvn,
        nin,
        bvnVerified,
        verifiedFirstName,
        verifiedLastName,
        verifiedDateOfBirth,
      ];
}

// Passcode Setup States
class PasscodeSetupInProgress extends AuthenticationState {
  const PasscodeSetupInProgress({
    this.enteredPasscode = '',
    this.isConfirmMode = false,
    this.initialPasscode = '',
    this.isRegistering = false,
    this.errorMessage,
  });

  final String enteredPasscode;
  final bool isConfirmMode;
  final String initialPasscode;
  final bool isRegistering;
  final String? errorMessage;

  PasscodeSetupInProgress copyWith({
    String? enteredPasscode,
    bool? isConfirmMode,
    String? initialPasscode,
    bool? isRegistering,
    String? errorMessage,
    bool clearError = false,
  }) {
    return PasscodeSetupInProgress(
      enteredPasscode: enteredPasscode ?? this.enteredPasscode,
      isConfirmMode: isConfirmMode ?? this.isConfirmMode,
      initialPasscode: initialPasscode ?? this.initialPasscode,
      isRegistering: isRegistering ?? this.isRegistering,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        enteredPasscode,
        isConfirmMode,
        initialPasscode,
        isRegistering,
        errorMessage,
      ];
}

// Passcode Login States
class PasscodeLoginInProgress extends AuthenticationState {
  const PasscodeLoginInProgress({
    this.enteredPasscode = '',
    this.isAuthenticating = false,
    this.errorMessage,
  });

  final String enteredPasscode;
  final bool isAuthenticating;
  final String? errorMessage;

  PasscodeLoginInProgress copyWith({
    String? enteredPasscode,
    bool? isAuthenticating,
    String? errorMessage,
    bool clearError = false,
  }) {
    return PasscodeLoginInProgress(
      enteredPasscode: enteredPasscode ?? this.enteredPasscode,
      isAuthenticating: isAuthenticating ?? this.isAuthenticating,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        enteredPasscode,
        isAuthenticating,
        errorMessage,
      ];
}

// General Authentication States (can be reused)
class Authenticating extends AuthenticationState {
  const Authenticating();
}

class AuthenticationFailure extends AuthenticationState {
  final String message;
  final int? statusCode;

  const AuthenticationFailure(this.message, {this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

// Password Recovery Verification States
class PasswordRecoveryVerificationInProgress extends AuthenticationState {
  const PasswordRecoveryVerificationInProgress();
}

class PasswordRecoveryCodeVerified extends AuthenticationState {
  final String resetToken;

  const PasswordRecoveryCodeVerified(this.resetToken);

  @override
  List<Object?> get props => [resetToken];
}

class PasswordRecoveryResendInProgress extends AuthenticationState {
  const PasswordRecoveryResendInProgress();
}

class PasswordRecoveryResendSuccess extends AuthenticationState {
  final String message;

  const PasswordRecoveryResendSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

// Facial Recognition States
class FacialRecognitionLoginInProgress extends AuthenticationState {
  const FacialRecognitionLoginInProgress();
}

class FacialRecognitionLoginSuccess extends AuthenticationState {
  final ProfileEntity profile;

  const FacialRecognitionLoginSuccess(this.profile);

  @override
  List<Object?> get props => [profile];
}

class FacialRecognitionCheckInProgress extends AuthenticationState {
  const FacialRecognitionCheckInProgress();
}

// BVN/NIN Verification States
class BVNVerificationInProgress extends AuthenticationState {
  const BVNVerificationInProgress();
}

class BVNVerificationSuccess extends AuthenticationState {
  final String verifiedFirstName;
  final String verifiedLastName;
  final String? verifiedDateOfBirth;
  final String? verifiedPhoneNumber;

  const BVNVerificationSuccess({
    required this.verifiedFirstName,
    required this.verifiedLastName,
    this.verifiedDateOfBirth,
    this.verifiedPhoneNumber,
  });

  @override
  List<Object?> get props => [
        verifiedFirstName,
        verifiedLastName,
        verifiedDateOfBirth,
        verifiedPhoneNumber,
      ];
}

class BVNVerificationFailure extends AuthenticationState {
  final String message;
  final String? errorCode;

  const BVNVerificationFailure(this.message, {this.errorCode});

  @override
  List<Object?> get props => [message, errorCode];
}

class FacialRecognitionEnabled extends AuthenticationState {
  final bool isEnabled;
  final String? registeredAt;

  const FacialRecognitionEnabled({
    required this.isEnabled,
    this.registeredAt,
  });

  @override
  List<Object?> get props => [isEnabled, registeredAt];
}
