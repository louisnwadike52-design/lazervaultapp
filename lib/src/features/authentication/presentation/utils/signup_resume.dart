import 'package:lazervault/core/types/app_routes.dart';

/// Backend-authoritative onboarding resume routing.
///
/// Given the backend's `users.current_signup_step` + `users.signup_status`
/// (both returned in the login response), resolve the route a returning,
/// freshly-authenticated user should land on so they pick up exactly where they
/// left off — even if they quit at an unexpected point or reinstalled (local
/// signup-draft state is NOT consulted; the backend is the source of truth).
///
/// Returns `null` when signup is complete (or for legacy users predating the
/// tracking table), so the caller falls through to its normal
/// dashboard-or-passcode-setup branch.
///
/// Used by BOTH login surfaces — the email/password sign-in and the passcode
/// lock screen — so resumption is identical regardless of how the user logs in.
({String name, Map<String, dynamic> args})? signupResumeRoute(
  String? step,
  String? status, {
  required String email,
  String? phone,
  bool hasTransactionPin = false,
}) {
  // Backend treats "complete" as the terminal status; anything else is either
  // explicit-incomplete or null (legacy users predating the tracking table —
  // fall through to default routing).
  if (status == null || status.isEmpty) return null;
  if (status == 'complete') return null;
  if (step == null || step.isEmpty) return null;

  return _stepRoute(step, email: email, phone: phone, hasTransactionPin: hasTransactionPin);
}

({String name, Map<String, dynamic> args})? _stepRoute(
  String step, {
  required String email,
  String? phone,
  bool hasTransactionPin = false,
}) {
  switch (step) {
    case 'email_verify':
      return (
        name: AppRoutes.emailVerification,
        args: <String, dynamic>{
          'email': email,
          'codeSent': false,
          'isRequired': true,
          'secondaryPhone': phone,
        },
      );
    case 'phone_verify':
      if (phone == null || phone.isEmpty) {
        // No phone on file but backend expects phone verify — defensive
        // fallback to passcode setup; user can add phone in Settings.
        return (
          name: AppRoutes.passcodeSetup,
          args: <String, dynamic>{
            'fromLoginFlow': true,
            'hasTransactionPin': hasTransactionPin,
          },
        );
      }
      return (
        name: AppRoutes.phoneVerification,
        args: <String, dynamic>{
          'phoneNumber': phone,
          'codeSent': false,
          'isRequired': false,
          'expiresIn': 600,
        },
      );
    case 'identity_verify':
      // BVN/NIN flow — KYC entry point.
      return (
        name: AppRoutes.kycBVNVerification,
        args: <String, dynamic>{'fromSignup': true},
      );
    case 'passcode_setup':
    case 'account_created': // user signed up but bailed before any verify
      return (
        name: AppRoutes.passcodeSetup,
        args: <String, dynamic>{
          'fromLoginFlow': true,
          'hasTransactionPin': hasTransactionPin,
        },
      );
  }
  return null;
}

/// Full post-login destination used by EVERY successful-auth surface — the
/// email/password sign-in, the passcode lock screen, AND the 2FA verification
/// screen — so a 2FA login lands in exactly the same place a non-2FA login
/// would: resume onboarding when the backend says signup is incomplete, else
/// the passcode / transaction-PIN setup gates, else the dashboard. This closes
/// the gap where 2FA success jumped straight to the dashboard past an
/// incomplete signup or a not-yet-set passcode/PIN.
({String name, Map<String, dynamic>? args}) resolvePostLoginRoute({
  required String? step,
  required String? status,
  required String email,
  String? phone,
  required bool hasPasscode,
  required bool hasTransactionPin,
  bool fromForgotPasscode = false,
}) {
  if (fromForgotPasscode) {
    return (
      name: AppRoutes.passcodeSetup,
      args: <String, dynamic>{
        'fromLoginFlow': true,
        'hasTransactionPin': hasTransactionPin,
        'fromForgotPasscode': true,
      },
    );
  }
  final resume = signupResumeRoute(step, status,
      email: email, phone: phone, hasTransactionPin: hasTransactionPin);
  if (resume != null) return (name: resume.name, args: resume.args);
  if (hasPasscode) {
    if (!hasTransactionPin) {
      return (
        name: AppRoutes.transactionPinSetup,
        args: <String, dynamic>{'fromLoginFlow': true},
      );
    }
    return (name: AppRoutes.dashboard, args: null);
  }
  return (
    name: AppRoutes.passcodeSetup,
    args: <String, dynamic>{
      'fromLoginFlow': true,
      'hasTransactionPin': hasTransactionPin,
    },
  );
}
