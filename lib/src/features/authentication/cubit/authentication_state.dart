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

// State indicating user is authenticated (alias for AuthenticationSuccess)
class AuthenticationAuthenticated extends AuthenticationState {
  final ProfileEntity profile;

  const AuthenticationAuthenticated(this.profile);

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

class UserCreated extends AuthenticationState {
  const UserCreated();
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

// Enum to track identity verification type per country
enum IdentityType {
  // Nigeria
  bvn,  // Bank Verification Number (11 digits)
  nin,  // National Identification Number (11 digits)

  // UK
  passport,        // UK Passport
  drivingLicence,  // UK Driving Licence

  // US
  ssn,            // Social Security Number (last 4 or full)
  stateId,        // State-issued ID
  usPassport,     // US Passport

  // Ghana
  ghanaCard,      // Ghana Card (National ID)
  ghanaVoterId,   // Ghana Voter ID
  ghanaPassport,  // Ghana Passport

  // Kenya
  kenyaNationalId, // Kenya National ID
  kenyaPassport,   // Kenya Passport

  // South Africa
  saId,           // South African ID Number
  saPassport,     // South African Passport
}

/// Helper extension to get display name and validation info for identity types
extension IdentityTypeExtension on IdentityType {
  String get displayName {
    switch (this) {
      case IdentityType.bvn:
        return 'BVN';
      case IdentityType.nin:
        return 'NIN';
      case IdentityType.passport:
        return 'Passport';
      case IdentityType.drivingLicence:
        return 'Driving Licence';
      case IdentityType.ssn:
        return 'Social Security Number';
      case IdentityType.stateId:
        return 'State ID';
      case IdentityType.usPassport:
        return 'US Passport';
      case IdentityType.ghanaCard:
        return 'Ghana Card';
      case IdentityType.ghanaVoterId:
        return 'Voter ID';
      case IdentityType.ghanaPassport:
        return 'Ghana Passport';
      case IdentityType.kenyaNationalId:
        return 'National ID';
      case IdentityType.kenyaPassport:
        return 'Kenya Passport';
      case IdentityType.saId:
        return 'SA ID Number';
      case IdentityType.saPassport:
        return 'SA Passport';
    }
  }

  String get placeholder {
    switch (this) {
      case IdentityType.bvn:
        return 'Enter your 11-digit BVN';
      case IdentityType.nin:
        return 'Enter your 11-digit NIN';
      case IdentityType.passport:
      case IdentityType.usPassport:
      case IdentityType.ghanaPassport:
      case IdentityType.kenyaPassport:
      case IdentityType.saPassport:
        return 'Enter your passport number';
      case IdentityType.drivingLicence:
        return 'Enter your driving licence number';
      case IdentityType.ssn:
        return 'Enter your SSN (last 4 digits)';
      case IdentityType.stateId:
        return 'Enter your state ID number';
      case IdentityType.ghanaCard:
        return 'Enter your Ghana Card number';
      case IdentityType.ghanaVoterId:
        return 'Enter your Voter ID number';
      case IdentityType.kenyaNationalId:
        return 'Enter your National ID number';
      case IdentityType.saId:
        return 'Enter your 13-digit SA ID number';
    }
  }

  String get description {
    switch (this) {
      case IdentityType.bvn:
        return '';
      case IdentityType.nin:
        return '';
      case IdentityType.passport:
        return 'Your UK passport number is 9 characters.';
      case IdentityType.drivingLicence:
        return 'Your UK driving licence number from your photocard licence.';
      case IdentityType.ssn:
        return 'Your Social Security Number (we only need the last 4 digits for verification).';
      case IdentityType.stateId:
        return 'The ID number from your state-issued identification card.';
      case IdentityType.usPassport:
        return 'Your US passport number (9 digits).';
      case IdentityType.ghanaCard:
        return 'Your Ghana Card number (GHA-XXXXXXXXX-X format).';
      case IdentityType.ghanaVoterId:
        return 'Your Ghana Voter ID number from your voter registration card.';
      case IdentityType.ghanaPassport:
        return 'Your Ghana passport number.';
      case IdentityType.kenyaNationalId:
        return 'Your Kenya National ID number (8 digits).';
      case IdentityType.kenyaPassport:
        return 'Your Kenya passport number.';
      case IdentityType.saId:
        return 'Your 13-digit South African ID number.';
      case IdentityType.saPassport:
        return 'Your South African passport number.';
    }
  }

  int? get maxLength {
    switch (this) {
      case IdentityType.bvn:
      case IdentityType.nin:
        return 11;
      case IdentityType.ssn:
        return 4; // Last 4 only
      case IdentityType.saId:
        return 13;
      case IdentityType.kenyaNationalId:
        return 8;
      case IdentityType.passport:
        return 9;
      case IdentityType.usPassport:
        return 9;
      default:
        return null;
    }
  }

  /// Get available identity types for a country
  static List<IdentityType> forCountry(String countryCode) {
    switch (countryCode) {
      case 'NG':
        return [IdentityType.bvn, IdentityType.nin];
      case 'GB':
        return [IdentityType.passport, IdentityType.drivingLicence];
      case 'US':
        return [IdentityType.ssn, IdentityType.stateId, IdentityType.usPassport];
      case 'GH':
        return [IdentityType.ghanaCard, IdentityType.ghanaVoterId, IdentityType.ghanaPassport];
      case 'KE':
        return [IdentityType.kenyaNationalId, IdentityType.kenyaPassport];
      case 'ZA':
        return [IdentityType.saId, IdentityType.saPassport];
      default:
        return [];
    }
  }

  /// Get the default identity type for a country
  static IdentityType defaultForCountry(String countryCode) {
    switch (countryCode) {
      case 'NG':
        return IdentityType.bvn;
      case 'GB':
        return IdentityType.passport;
      case 'US':
        return IdentityType.ssn;
      case 'GH':
        return IdentityType.ghanaCard;
      case 'KE':
        return IdentityType.kenyaNationalId;
      case 'ZA':
        return IdentityType.saId;
      default:
        return IdentityType.bvn;
    }
  }
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
    // Identity verification (multi-country)
    this.identityType = IdentityType.bvn,
    this.bvn = '',
    this.nin = '',
    this.identityValue = '', // Generic field for any ID type
    this.bvnVerified = false,
    this.verifiedFirstName,
    this.verifiedLastName,
    this.verifiedDateOfBirth,
    // Progressive KYC
    this.kycSkipped = false,
    // Account creation status
    this.accountCreated = false,
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

  // Identity verification (multi-country)
  final IdentityType identityType;
  final String bvn;
  final String nin;
  final String identityValue; // Generic field for any ID type
  final bool bvnVerified;
  final String? verifiedFirstName;
  final String? verifiedLastName;
  final String? verifiedDateOfBirth;

  // Progressive KYC
  final bool kycSkipped;

  // Account creation status
  final bool accountCreated;

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
    String? identityValue,
    bool? bvnVerified,
    String? verifiedFirstName,
    String? verifiedLastName,
    String? verifiedDateOfBirth,
    bool? kycSkipped,
    bool? accountCreated,
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
      identityValue: identityValue ?? this.identityValue,
      bvnVerified: bvnVerified ?? this.bvnVerified,
      verifiedFirstName: verifiedFirstName ?? this.verifiedFirstName,
      verifiedLastName: verifiedLastName ?? this.verifiedLastName,
      verifiedDateOfBirth: verifiedDateOfBirth ?? this.verifiedDateOfBirth,
      kycSkipped: kycSkipped ?? this.kycSkipped,
      accountCreated: accountCreated ?? this.accountCreated,
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
        identityValue,
        bvnVerified,
        verifiedFirstName,
        verifiedLastName,
        verifiedDateOfBirth,
        kycSkipped,
        accountCreated,
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

class AuthenticationFailure extends AuthenticationState {
  final String message;
  final int? statusCode;

  const AuthenticationFailure(this.message, {this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
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
