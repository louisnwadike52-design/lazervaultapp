import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/src/features/authentication/domain/entities/signup_draft.dart';

/// Service for managing signup state persistence
/// Handles local storage of signup drafts (pre-account creation)
/// and coordination with backend signup progress (post-account creation)
class SignupStateService {
  // Local storage keys
  static const String _signupDraftKey = 'signup_draft';
  static const String _signupStepKey = 'current_signup_step';
  static const String _hasIncompleteSignupKey = 'has_incomplete_signup';

  // Pins the auth mode for an IN-PROGRESS onboarding journey. Written when a
  // phone (or email) signup starts so that an admin flipping the platform
  // auth_mode mid-onboarding does NOT switch a user who is already partway
  // through one flow into the other. Boot routing reads this to resume the
  // correct flow. Values mirror the User.authType enum: 'PHONE_PASSCODE' |
  // 'EMAIL_PASSWORD'.
  static const String _onboardingAuthTypeKey = 'onboarding_auth_type';
  static const String authTypePhonePasscode = 'PHONE_PASSCODE';
  static const String authTypeEmailPassword = 'EMAIL_PASSWORD';

  // Phone+passcode onboarding step markers (parallel to SignupDraft.step*).
  // Persisted via [markPhoneStep] so a kill/restart resumes at the right
  // phone screen.
  static const String stepPhoneOtp = 'phone_otp';
  static const String stepPhonePasscodeCreate = 'phone_passcode_create';
  static const String stepPhonePersonalDetails = 'phone_personal_details';
  static const String stepPhoneOptionalEmail = 'phone_optional_email';

  final FlutterSecureStorage _storage;

  SignupStateService(this._storage);

  // ==================== Onboarding Auth Type (mode pinning) ====================

  /// Pin the auth mode for the in-progress onboarding journey.
  Future<void> saveOnboardingAuthType(String authType) async {
    try {
      await _storage.write(key: _onboardingAuthTypeKey, value: authType);
    } catch (e) {
      print('Error saving onboarding auth type: $e');
    }
  }

  /// Read the pinned onboarding auth type (null if none).
  Future<String?> getOnboardingAuthType() async {
    try {
      return await _storage.read(key: _onboardingAuthTypeKey);
    } catch (e) {
      return null;
    }
  }

  /// Mark the current phone-onboarding step and flag the signup incomplete so
  /// boot routing resumes the phone flow at this step.
  Future<void> markPhoneStep(String step) async {
    try {
      await _storage.write(key: _signupStepKey, value: step);
      await _storage.write(key: _hasIncompleteSignupKey, value: 'true');
      await _storage.write(
          key: _onboardingAuthTypeKey, value: authTypePhonePasscode);
    } catch (e) {
      print('Error saving phone step: $e');
    }
  }

  // ==================== Draft Operations (Pre-Account Creation) ====================

  /// Save signup draft to local storage
  /// Called during signup form completion before account is created
  Future<void> saveDraft(SignupDraft draft) async {
    try {
      final jsonString = draft.toJsonString();
      await _storage.write(key: _signupDraftKey, value: jsonString);
      await _storage.write(key: _signupStepKey, value: draft.currentStep);
      await _storage.write(key: _hasIncompleteSignupKey, value: 'true');
    } catch (e) {
      // Silently fail - draft saving is best effort
      print('Error saving signup draft: $e');
    }
  }

  /// Load signup draft from local storage
  /// Returns null if no draft exists or draft is expired
  Future<SignupDraft?> loadDraft() async {
    try {
      final jsonString = await _storage.read(key: _signupDraftKey);
      if (jsonString == null || jsonString.isEmpty) return null;

      final draft = SignupDraft.fromJsonString(jsonString);
      if (draft == null) return null;

      // Check if draft is expired (7 days)
      if (draft.isExpired) {
        await clearDraft();
        return null;
      }

      return draft;
    } catch (e) {
      print('Error loading signup draft: $e');
      return null;
    }
  }

  /// Clear signup draft from local storage
  /// Called on successful signup completion or when user abandons signup
  Future<void> clearDraft() async {
    try {
      await _storage.delete(key: _signupDraftKey);
      await _storage.delete(key: _signupStepKey);
      await _storage.delete(key: _hasIncompleteSignupKey);
      await _storage.delete(key: _onboardingAuthTypeKey);
    } catch (e) {
      print('Error clearing signup draft: $e');
    }
  }

  /// Update the current signup step
  Future<void> saveCurrentStep(String step) async {
    try {
      await _storage.write(key: _signupStepKey, value: step);
    } catch (e) {
      print('Error saving current step: $e');
    }
  }

  /// Get the current signup step
  Future<String?> getCurrentStep() async {
    try {
      return await _storage.read(key: _signupStepKey);
    } catch (e) {
      print('Error getting current step: $e');
      return null;
    }
  }

  /// Check if there's an incomplete signup in progress
  Future<bool> hasIncompleteSignup() async {
    try {
      final value = await _storage.read(key: _hasIncompleteSignupKey);
      return value == 'true';
    } catch (e) {
      return false;
    }
  }

  // ==================== Draft Update Helpers ====================

  /// Update draft with email
  Future<void> updateDraftEmail(String email) async {
    final draft = await loadDraft();
    if (draft != null) {
      await saveDraft(draft.copyWith(email: email));
    } else {
      await saveDraft(SignupDraft(email: email));
    }
  }

  /// Update draft with phone
  Future<void> updateDraftPhone(String phone) async {
    final draft = await loadDraft();
    if (draft != null) {
      await saveDraft(draft.copyWith(phone: phone));
    } else {
      await saveDraft(SignupDraft(phone: phone));
    }
  }

  /// Update draft with personal info (first name, last name, DOB)
  Future<void> updateDraftPersonalInfo({
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? username,
    String? referralCode,
  }) async {
    final draft = await loadDraft() ?? SignupDraft();
    await saveDraft(draft.copyWith(
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      username: username,
      referralCode: referralCode,
    ));
  }

  /// Update draft with current page
  Future<void> updateDraftPage(int page) async {
    final draft = await loadDraft();
    if (draft != null) {
      final step = page == 0 ? SignupDraft.stepFormPage0 : SignupDraft.stepFormPage1;
      await saveDraft(draft.copyWith(currentPage: page, currentStep: step));
    }
  }

  /// Update draft with primary contact type
  Future<void> updateDraftPrimaryContactType(String type) async {
    final draft = await loadDraft();
    if (draft != null) {
      await saveDraft(draft.copyWith(primaryContactType: type));
    }
  }

  /// Update draft with locale
  Future<void> updateDraftLocale(String? locale) async {
    final draft = await loadDraft();
    if (draft != null) {
      await saveDraft(draft.copyWith(locale: locale));
    } else {
      await saveDraft(SignupDraft(locale: locale));
    }
  }

  // ==================== Post-Account Creation State ====================

  /// Persist an EMAIL-flow onboarding step so a kill/restart resumes at the right
  /// screen — the email-flow analogue of [markPhoneStep]. Writes the step, flags
  /// the signup incomplete, and pins the auth type to EMAIL_PASSWORD (so an admin
  /// flipping the platform auth_mode mid-onboarding can't switch flows).
  Future<void> _markEmailStep(String step) async {
    try {
      await _storage.write(key: _signupStepKey, value: step);
      await _storage.write(key: _hasIncompleteSignupKey, value: 'true');
      await _storage.write(
          key: _onboardingAuthTypeKey, value: authTypeEmailPassword);
    } catch (e) {
      print('Error saving email step: $e');
    }
  }

  /// Mark that the account has been created (move from local draft to step
  /// tracking). Clears the pre-account draft blob (backend now owns progress) but
  /// KEEPS the incomplete-signup flag + step so a quit here resumes at email
  /// verification.
  Future<void> markAccountCreated() async {
    await _markEmailStep(SignupDraft.stepAccountCreate);
    await _storage.delete(key: _signupDraftKey);
  }

  /// Mark email verification step (resume → email verification screen).
  Future<void> markEmailVerificationStep() async {
    await _markEmailStep(SignupDraft.stepEmailVerify);
  }

  /// Mark phone verification step (email-flow with phone-primary contact).
  Future<void> markPhoneVerificationStep() async {
    await _markEmailStep(SignupDraft.stepPhoneVerify);
  }

  /// Mark passcode setup step (resume → passcode setup screen).
  Future<void> markPasscodeSetupStep() async {
    await _markEmailStep(SignupDraft.stepPasscodeSetup);
  }

  /// Mark signup as complete and clear all local state
  Future<void> markSignupComplete() async {
    await clearDraft();
  }

  // ==================== Route Resolution ====================

  /// Determine the route to navigate to based on signup state
  /// This is used during app startup to resume signup
  String? getRouteForStep(String? step) {
    if (step == null) return null;

    switch (step) {
      case SignupDraft.stepFormPage0:
        return '/signup'; // Navigate to signup with page 0
      case SignupDraft.stepFormPage1:
        return '/signup'; // Navigate to signup with page 1 (cubit will restore)
      case SignupDraft.stepEmailVerify:
        return '/email-verification';
      case SignupDraft.stepPhoneVerify:
        return '/phone-verification';
      case SignupDraft.stepPasscodeSetup:
        return '/passcode-setup';
      case SignupDraft.stepComplete:
        return '/dashboard';
      default:
        return null;
    }
  }

  /// Get the appropriate route based on current local state
  Future<String?> getResumeRoute() async {
    final draft = await loadDraft();
    if (draft != null && draft.hasData && !draft.isExpired) {
      return getRouteForStep(draft.currentStep);
    }

    final currentStep = await getCurrentStep();
    return getRouteForStep(currentStep);
  }
}
