import 'package:equatable/equatable.dart';
import '../domain/entities/profile_entity.dart';
part 'authentication_state_widgets.dart';


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
    // Referral code validation
    this.isReferralCodeValid,
    this.isReferralCodeValidating = false,
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

  // Referral code validation
  final bool? isReferralCodeValid;
  final bool isReferralCodeValidating;

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
    bool? isReferralCodeValid,
    bool? isReferralCodeValidating,
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
      isReferralCodeValid: isReferralCodeValid ?? this.isReferralCodeValid,
      isReferralCodeValidating: isReferralCodeValidating ?? this.isReferralCodeValidating,
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
        isReferralCodeValid,
        isReferralCodeValidating,
      ];
}
