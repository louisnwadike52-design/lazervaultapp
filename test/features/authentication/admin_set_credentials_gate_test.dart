import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/kyc_completion.dart';
import 'package:lazervault/src/features/authentication/presentation/utils/signup_resume.dart';

/// AN ADMIN-SET CREDENTIAL IS ADMITTED EXACTLY ONCE.
///
/// An operator can set a login passcode or password so a customer can be
/// onboarded in person or recovered after losing access. That necessarily
/// means somebody who is not the account holder knows a working credential —
/// which this platform refuses to allow permanently (the transaction-PIN admin
/// action will only ever CLEAR a PIN, never choose one).
///
/// The post-login resolver is where that is enforced, and the ordering is the
/// whole point: anything allowed to run first would leave the admin's
/// credential live for the length of a flow the customer can abandon halfway,
/// and abandoning is the common case for the heavier ones.
void main() {
  ({String name, Map<String, dynamic>? args}) resolve({
    bool mustChange = true,
    bool hasPasscode = true,
    bool hasTransactionPin = true,
    bool isEmailVerified = true,
    bool phoneVerified = true,
    String? step,
    String? status,
    KycLoginGate? kyc,
  }) => resolvePostLoginRoute(
    step: step,
    status: status,
    email: 'customer@example.com',
    phone: '+2348030000000',
    hasPasscode: hasPasscode,
    hasTransactionPin: hasTransactionPin,
    kyc: kyc ?? KycLoginGate.none,
    isEmailVerified: isEmailVerified,
    emailVerificationRequired: true,
    phoneVerified: phoneVerified,
    phoneVerificationRequired: true,
    mustChangeCredentials: mustChange,
  );

  test('the holder is sent to choose their own passcode', () {
    final r = resolve();
    expect(r.name, AppRoutes.passcodeSetup);
    expect(
      r.args?['mustChangeCredentials'],
      isTrue,
      reason:
          'the screen must know this is a required replacement, '
          'so it cannot offer a skip',
    );
  });

  test('it outranks an unverified email', () {
    expect(resolve(isEmailVerified: false).name, AppRoutes.passcodeSetup);
  });

  test('it outranks an unverified phone', () {
    expect(resolve(phoneVerified: false).name, AppRoutes.passcodeSetup);
  });

  test('it outranks a missing transaction PIN', () {
    expect(resolve(hasTransactionPin: false).name, AppRoutes.passcodeSetup);
  });

  test('it outranks the KYC gate', () {
    final blocking = KycLoginGate(state: KycState.unverified, isRequired: true);
    expect(resolve(kyc: blocking).name, AppRoutes.passcodeSetup);
  });

  // A half-finished signup has its own resume branches; the credential
  // obligation still comes first, because the admin's value is live during
  // every one of those steps too.
  test('it outranks a parked signup', () {
    final r = resolve(step: 'email_verification', status: 'incomplete');
    expect(r.name, AppRoutes.passcodeSetup);
  });

  // THE DEFAULT MUST BE HARMLESS. An older server response carries no such
  // field, and a wrong default there would lock every customer out of their
  // own account behind a change they were never asked to make.
  test('without the flag nothing changes', () {
    final r = resolve(mustChange: false);
    expect(r.name, isNot(AppRoutes.passcodeSetup));
  });

  /// THE SCREEN HAS TO SAY WHY.
  ///
  /// The router passes `mustChangeCredentials: true`, and for a while nothing
  /// read it — enforcement came from `fromLoginFlow` disabling the skip, so
  /// the gate worked while the screen looked exactly like ordinary passcode
  /// setup. That is the wrong silence: somebody onboarded in a branch was
  /// handed six digits by another person and then shown a screen giving no
  /// reason to believe those digits mattered.
  test('the passcode screen explains an admin-set credential', () {
    final src = File(
      'lib/src/features/authentication/presentation/views/passcode_setup_screen.dart',
    ).readAsStringSync();
    expect(
      src.contains("['mustChangeCredentials'] =="),
      isTrue,
      reason: 'the screen must read the flag the router passes',
    );
    expect(
      src.contains('someone '),
      isTrue,
      reason:
          'the copy must name the actual fact — that another person '
          'knows the passcode just used',
    );
    expect(
      src.contains('Choose Your Own Passcode'),
      isTrue,
      reason: 'the heading must distinguish this from ordinary setup',
    );
  });

  /// Enforcement must NOT depend on the copy flag. A client that ignored it
  /// entirely still cannot skip, because the router also passes fromLoginFlow
  /// and _allowSkip is false for that.
  test('skip stays disabled independently of the explanatory flag', () {
    final src = File(
      'lib/src/features/authentication/presentation/views/passcode_setup_screen.dart',
    ).readAsStringSync();
    expect(
      src.contains('_allowSkip => !_fromLoginFlow'),
      isTrue,
      reason:
          'the skip gate must key off fromLoginFlow, not off the copy '
          'flag — enforcement and explanation are separate concerns',
    );
  });
}
