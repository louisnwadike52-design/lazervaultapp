import 'dart:convert';
import 'package:lazervault/core/config/country_config.dart' show CountryConfigs, CountryConfig;

/// Represents a saved signup draft for resumption
/// This is stored locally (not synced to backend) for pre-account creation state
class SignupDraft {
  final String? email;
  final String? phone;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? referralCode;
  final DateTime? dateOfBirth;
  final String? primaryContactType; // 'email' or 'phone'
  final int currentPage;
  final String currentStep; // 'form_page_0', 'form_page_1', 'email_verify', etc.
  final DateTime savedAt;
  final String? deviceId;
  final String? locale; // Locale string (e.g., 'en-NG', 'en-GH', 'en-KE')

  // Note: Passwords are NEVER persisted for security reasons

  SignupDraft({
    this.email,
    this.phone,
    this.firstName,
    this.lastName,
    this.username,
    this.referralCode,
    this.dateOfBirth,
    this.primaryContactType,
    this.currentPage = 0,
    this.currentStep = 'form_page_0',
    DateTime? savedAt,
    this.deviceId,
    this.locale,
  }) : savedAt = savedAt ?? DateTime.now();

  /// Draft expiry duration (7 days as per plan)
  static const Duration draftExpiryDuration = Duration(days: 7);

  /// Step name constants
  static const String stepFormPage0 = 'form_page_0';
  static const String stepFormPage1 = 'form_page_1';
  static const String stepAccountCreate = 'account_created';
  static const String stepEmailVerify = 'email_verify';
  static const String stepPhoneVerify = 'phone_verify';
  static const String stepPasscodeSetup = 'passcode_setup';
  static const String stepComplete = 'complete';

  /// Check if the draft has expired
  bool get isExpired {
    final expiryDate = savedAt.add(draftExpiryDuration);
    return DateTime.now().isAfter(expiryDate);
  }

  /// Check if there's any meaningful data to restore
  bool get hasData {
    return (email != null && email!.isNotEmpty) ||
        (phone != null && phone!.isNotEmpty) ||
        (firstName != null && firstName!.isNotEmpty) ||
        (lastName != null && lastName!.isNotEmpty) ||
        (username != null && username!.isNotEmpty);
  }

  /// Check if form page 0 data is complete (email/phone and password would be needed)
  bool get isFormPage0Complete {
    if (primaryContactType == 'email') {
      return email != null && email!.isNotEmpty;
    } else if (primaryContactType == 'phone') {
      return phone != null && phone!.isNotEmpty;
    }
    return false;
  }

  /// Check if form page 1 data is complete
  bool get isFormPage1Complete {
    return firstName != null &&
        firstName!.isNotEmpty &&
        lastName != null &&
        lastName!.isNotEmpty &&
        dateOfBirth != null;
  }

  /// Create a copy with updated values
  SignupDraft copyWith({
    String? email,
    String? phone,
    String? firstName,
    String? lastName,
    String? username,
    String? referralCode,
    DateTime? dateOfBirth,
    String? primaryContactType,
    int? currentPage,
    String? currentStep,
    DateTime? savedAt,
    String? deviceId,
    String? locale,
  }) {
    return SignupDraft(
      email: email ?? this.email,
      phone: phone ?? this.phone,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      referralCode: referralCode ?? this.referralCode,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      primaryContactType: primaryContactType ?? this.primaryContactType,
      currentPage: currentPage ?? this.currentPage,
      currentStep: currentStep ?? this.currentStep,
      savedAt: savedAt ?? this.savedAt,
      deviceId: deviceId ?? this.deviceId,
      locale: locale ?? this.locale,
    );
  }

  /// Get the country code from locale (e.g., 'en-NG' -> 'NG')
  String? get countryCode {
    final localeValue = locale;
    if (localeValue == null || localeValue.isEmpty) return null;
    final parts = localeValue.split('-');
    if (parts.length >= 2) {
      return parts.last.toUpperCase();
    }
    return null;
  }

  /// Get the country name from locale
  String? get countryName {
    final config = _countryConfig;
    return config?.name;
  }

  /// Get the currency code from locale
  String? get currencyCode {
    final config = _countryConfig;
    return config?.currency;
  }

  /// Get the CountryConfig from locale
  CountryConfig? get _countryConfig {
    final code = countryCode;
    if (code == null) return null;
    // Import CountryConfigs to use getByCode
    return _getCountryConfigByCode(code);
  }

  /// External getter for country config (uses CountryConfigs)
  CountryConfig? get countryConfig {
    return _getCountryConfigByCode(countryCode ?? '');
  }

  /// Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'referralCode': referralCode,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'primaryContactType': primaryContactType,
      'currentPage': currentPage,
      'currentStep': currentStep,
      'savedAt': savedAt.toIso8601String(),
      'deviceId': deviceId,
      'locale': locale,
    };
  }

  /// Create from JSON
  factory SignupDraft.fromJson(Map<String, dynamic> json) {
    return SignupDraft(
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      username: json['username'] as String?,
      referralCode: json['referralCode'] as String?,
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.tryParse(json['dateOfBirth'] as String)
          : null,
      primaryContactType: json['primaryContactType'] as String?,
      currentPage: json['currentPage'] as int? ?? 0,
      currentStep: json['currentStep'] as String? ?? 'form_page_0',
      savedAt: json['savedAt'] != null
          ? DateTime.tryParse(json['savedAt'] as String) ?? DateTime.now()
          : DateTime.now(),
      deviceId: json['deviceId'] as String?,
      locale: json['locale'] as String?,
    );
  }

  /// Serialize to JSON string
  String toJsonString() => jsonEncode(toJson());

  /// Deserialize from JSON string
  static SignupDraft? fromJsonString(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) return null;
    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return SignupDraft.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  @override
  String toString() {
    return 'SignupDraft(email: $email, phone: $phone, firstName: $firstName, '
        'lastName: $lastName, currentPage: $currentPage, currentStep: $currentStep, '
        'locale: $locale, savedAt: $savedAt, isExpired: $isExpired)';
  }

  /// Helper to get country config by code (uses CountryConfigs)
  static CountryConfig? _getCountryConfigByCode(String countryCode) {
    return CountryConfigs.getByCode(countryCode);
  }
}

/// Represents the signup progress fetched from the backend (post-account creation)
class SignupProgress {
  final String userId;
  final SignupStatus status;
  final String? currentStep;
  final List<SignupStepProgress> steps;
  final DateTime? signupCompletedAt;
  final String? nextStep;
  final bool isComplete;

  SignupProgress({
    required this.userId,
    required this.status,
    this.currentStep,
    this.steps = const [],
    this.signupCompletedAt,
    this.nextStep,
    this.isComplete = false,
  });

  factory SignupProgress.fromJson(Map<String, dynamic> json) {
    return SignupProgress(
      userId: json['userId'] as String? ?? '',
      status: SignupStatus.fromString(json['status'] as String?),
      currentStep: json['currentStep'] as String?,
      steps: (json['steps'] as List<dynamic>?)
              ?.map((s) => SignupStepProgress.fromJson(s as Map<String, dynamic>))
              .toList() ??
          [],
      signupCompletedAt: json['signupCompletedAt'] != null
          ? DateTime.tryParse(json['signupCompletedAt'] as String)
          : null,
      nextStep: json['nextStep'] as String?,
      isComplete: json['isComplete'] as bool? ?? false,
    );
  }
}

/// Signup status enum matching backend values
enum SignupStatus {
  unspecified,
  created,
  emailVerified,
  phoneVerified,
  passcodeSet,
  complete;

  static SignupStatus fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'created':
        return SignupStatus.created;
      case 'email_verified':
        return SignupStatus.emailVerified;
      case 'phone_verified':
        return SignupStatus.phoneVerified;
      case 'passcode_set':
        return SignupStatus.passcodeSet;
      case 'complete':
        return SignupStatus.complete;
      default:
        return SignupStatus.unspecified;
    }
  }
}

/// Step status enum matching backend values
enum StepStatus {
  unspecified,
  pending,
  inProgress,
  completed,
  skipped;

  static StepStatus fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'pending':
        return StepStatus.pending;
      case 'in_progress':
        return StepStatus.inProgress;
      case 'completed':
        return StepStatus.completed;
      case 'skipped':
        return StepStatus.skipped;
      default:
        return StepStatus.unspecified;
    }
  }
}

/// Individual step progress
class SignupStepProgress {
  final String stepName;
  final StepStatus status;
  final String? stepData;
  final DateTime? completedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SignupStepProgress({
    required this.stepName,
    required this.status,
    this.stepData,
    this.completedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory SignupStepProgress.fromJson(Map<String, dynamic> json) {
    return SignupStepProgress(
      stepName: json['stepName'] as String? ?? '',
      status: StepStatus.fromString(json['status'] as String?),
      stepData: json['stepData'] as String?,
      completedAt: json['completedAt'] != null
          ? DateTime.tryParse(json['completedAt'] as String)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
    );
  }
}
