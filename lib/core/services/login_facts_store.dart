import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:lazervault/src/features/authentication/domain/entities/user.dart';

/// THE LAST ANSWER THE BACKEND GAVE ABOUT WHERE THIS ACCOUNT STANDS.
///
/// The post-login router decides between the dashboard and five onboarding
/// screens from a handful of facts: passcode set, transaction PIN set, phone
/// and email verified, identity tier and status, signup status and step. A
/// credential login carries all of them on its response. A biometric or voice
/// unlock does not, and on that path the app previously had to ask the auth
/// service and the PIN service — two round trips, up to eight seconds on a
/// slow uplink — BEFORE it could show anything, while the person stood there
/// having already proved who they were.
///
/// So the facts are written down here on every login that has them, and the
/// unlock paths read them back FIRST. The screen opens on the cached answer;
/// the backend is asked in the background and the record is replaced with
/// whatever it says. The cost of that order is one stale decision in the rare
/// case the facts changed on another device since the last login — a
/// passcode removed, a PIN cleared by support — and the next credential login,
/// or the next unlock after the background refresh, corrects it. The cost of
/// the old order was every unlock, for everyone, every day.
///
/// # What is NOT here
///
/// Nothing a gate could be fooled by in a way that matters: no tokens, no
/// balances, no identifiers beyond the user id used to stamp the record. A
/// record for a different user is never applied (see [read]), and the whole
/// thing is deleted on a user switch alongside the other per-user keys.
class LoginFacts {
  const LoginFacts({
    required this.userId,
    required this.hasPasscode,
    required this.hasPassword,
    required this.hasTransactionPin,
    required this.phoneVerified,
    required this.isEmailVerified,
    required this.kycTier,
    required this.recordedAt,
    this.phoneNumber,
    this.signupStatus,
    this.currentSignupStep,
    this.kycStatus,
    this.preferredLoginMethod,
  });

  final String userId;
  final bool hasPasscode;
  final bool hasPassword;
  final bool hasTransactionPin;
  final bool phoneVerified;
  final bool isEmailVerified;
  final int kycTier;
  final DateTime recordedAt;
  final String? phoneNumber;
  final String? signupStatus;
  final String? currentSignupStep;
  final String? kycStatus;
  final String? preferredLoginMethod;

  /// Facts as a login response described them. [hasTransactionPin] is taken
  /// from the user unless the caller knows better (the PIN service's answer).
  factory LoginFacts.fromUser(User u, {bool? hasTransactionPin}) => LoginFacts(
        userId: u.id,
        hasPasscode: u.hasPasscode,
        hasPassword: u.hasPassword,
        hasTransactionPin: hasTransactionPin ?? u.hasTransactionPin,
        phoneVerified: u.verified,
        isEmailVerified: u.isEmailVerified,
        kycTier: u.kycTier,
        recordedAt: DateTime.now(),
        phoneNumber: u.phoneNumber,
        signupStatus: u.signupStatus,
        currentSignupStep: u.currentSignupStep,
        kycStatus: u.kycStatus,
        preferredLoginMethod: u.preferredLoginMethod,
      );

  /// Lay these facts over a user that lacks them (the profile-proto user a
  /// biometric unlock builds). Profile fields the facts do not cover survive.
  User applyTo(User base) => base.copyWith(
        hasPasscode: hasPasscode,
        hasPassword: hasPassword,
        hasTransactionPin: hasTransactionPin,
        verified: phoneVerified,
        isEmailVerified: isEmailVerified,
        phoneNumber: phoneNumber ?? base.phoneNumber,
        signupStatus: signupStatus,
        currentSignupStep: currentSignupStep,
        kycTier: kycTier,
        kycStatus: kycStatus,
        preferredLoginMethod: preferredLoginMethod,
      );

  Map<String, dynamic> toJson() => {
        'v': 1,
        'userId': userId,
        'hasPasscode': hasPasscode,
        'hasPassword': hasPassword,
        'hasTransactionPin': hasTransactionPin,
        'phoneVerified': phoneVerified,
        'isEmailVerified': isEmailVerified,
        'kycTier': kycTier,
        'recordedAt': recordedAt.toIso8601String(),
        'phoneNumber': phoneNumber,
        'signupStatus': signupStatus,
        'currentSignupStep': currentSignupStep,
        'kycStatus': kycStatus,
        'preferredLoginMethod': preferredLoginMethod,
      };

  static LoginFacts? fromJson(Map<String, dynamic> j) {
    final id = j['userId']?.toString() ?? '';
    final at = DateTime.tryParse(j['recordedAt']?.toString() ?? '');
    if (id.isEmpty || at == null) return null;
    return LoginFacts(
      userId: id,
      hasPasscode: j['hasPasscode'] == true,
      hasPassword: j['hasPassword'] == true,
      hasTransactionPin: j['hasTransactionPin'] == true,
      phoneVerified: j['phoneVerified'] == true,
      isEmailVerified: j['isEmailVerified'] == true,
      kycTier: (j['kycTier'] as num?)?.toInt() ?? 0,
      recordedAt: at,
      phoneNumber: j['phoneNumber'] as String?,
      signupStatus: j['signupStatus'] as String?,
      currentSignupStep: j['currentSignupStep'] as String?,
      kycStatus: j['kycStatus'] as String?,
      preferredLoginMethod: j['preferredLoginMethod'] as String?,
    );
  }
}

/// Where [LoginFacts] live. Secure storage, one record, the current user's.
class LoginFactsStore {
  LoginFactsStore._();

  /// Listed in `kPerUserStorageKeys` so a user switch deletes it.
  static const String storageKey = 'login_facts_v1';

  /// Older than this is not trusted for the FOREGROUND decision — the unlock
  /// waits for the backend instead, as it did before the store existed.
  static const Duration maxAge = Duration(days: 30);

  static FlutterSecureStorage? _storage;

  /// Inject for tests; production resolves the app's real secure storage.
  static set storage(FlutterSecureStorage? s) => _storage = s;

  static FlutterSecureStorage get _s =>
      _storage ??
      const FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
          resetOnError: true,
        ),
      );

  /// Write the facts a login just saw. Best-effort; a failed write costs one
  /// slower unlock, never a login.
  static Future<void> record(User user, {bool? hasTransactionPin}) async {
    if (user.id.isEmpty) return;
    try {
      await _s.write(
        key: storageKey,
        value: jsonEncode(
          LoginFacts.fromUser(user, hasTransactionPin: hasTransactionPin)
              .toJson(),
        ),
      );
    } catch (_) {/* best effort */}
  }

  /// The record, if it is THIS user's and not too old. Anything else is null —
  /// a record never speaks for a different account.
  static Future<LoginFacts?> read(String userId) async {
    if (userId.isEmpty) return null;
    try {
      final raw = await _s.read(key: storageKey);
      if (raw == null || raw.isEmpty) return null;
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return null;
      final facts = LoginFacts.fromJson(Map<String, dynamic>.from(decoded));
      if (facts == null || facts.userId != userId) return null;
      if (DateTime.now().difference(facts.recordedAt) > maxAge) return null;
      return facts;
    } catch (_) {
      return null;
    }
  }

  static Future<void> clear() async {
    try {
      await _s.delete(key: storageKey);
    } catch (_) {/* best effort */}
  }
}
