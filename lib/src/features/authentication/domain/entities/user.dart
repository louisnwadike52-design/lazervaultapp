import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/authentication/domain/entities/postal_address.dart';

/// Represents a user entity in the application.
class User extends Equatable {
  final String id;
  final String firstName;
  final String lastName;

  /// OPTIONAL, and usually empty. After verification this holds the
  /// REGISTRY's middle name, adopted alongside first and last — so an
  /// editor showing it is showing what the government record says.
  final String middleName;
  final String email;
  final String? phoneNumber;
  final String? username; // Tag pay username
  final String? role;
  final List<String>? roles;
  final bool verified;
  final bool isEmailVerified;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? language;
  final String? currency;
  final String? country;
  final String? profilePicture;
  final String? signupStatus;

  /// Server-tracked next step in the signup flow. Mirrors
  /// `users.current_signup_step` on the backend. Non-null + non-empty
  /// when the signup is INCOMPLETE — used by the post-login router to
  /// resume the user at the right screen (verify email / verify phone
  /// / setup passcode / etc.) instead of dropping them on the dashboard
  /// with a half-finished account.
  final String? currentSignupStep;
  final bool hasPasscode;
  final bool hasTransactionPin;

  /// An ADMIN set this account's login credential and the holder has not
  /// replaced it yet (auth: `users.must_change_credentials`).
  ///
  /// An operator can set a passcode or password so a customer can be onboarded
  /// in person or recovered after losing access — which necessarily means
  /// someone who is not the account holder knows a working credential. The
  /// platform does not allow that permanently, so the value is admitted ONCE
  /// and the post-login router then sends the holder to choose their own.
  ///
  /// Carried on the USER rather than only in the login response, because most
  /// of the ways a session begins are not a login: biometric unlock, a warm
  /// start from a stored token, a refresh. A login-only flag would be bypassed
  /// by all of them.
  final bool mustChangeCredentials;

  /// Whether the user has a password set (mirrors password_hash != "" on the
  /// backend). Drives the "set password" gate before switching to the
  /// email+password login method, and the visibility of "Change password".
  final bool hasPassword;

  /// User-selectable login-method preference: "email_password" |
  /// "phone_passcode" | "" (empty = follow platform default). Overrides the
  /// platform default on subsequent logins when set.
  final String? preferredLoginMethod;

  /// HOW THIS ACCOUNT WAS CREATED, in the backend's own words (`auth_type` on
  /// the user proto): `EMAIL_PASSWORD` | `PHONE_PASSCODE` | `SOCIAL` | null
  /// when the response predates the field.
  ///
  /// It matters to exactly one question, and that question is a gate: whether
  /// the account HAS a credential of its own. A `SOCIAL` account has neither a
  /// password nor a passcode — the Google/Apple link is the credential — so a
  /// passcode is an offer to it, where for everyone else it is the thing the
  /// lock screen and every quick login assume. Read it through
  /// [isSocialAccount], never by string compare at a call site.
  final String? authType;

  /// The CBN KYC tier this holder has earned: 1 basic, 2 BVN-verified,
  /// 3 BVN+NIN+liveness. Mirrors `users.kyc_tier`, the authoritative value
  /// (see `microservices/shared/kyctiers`). 0 means the field was absent.
  final int kycTier;

  /// Has this holder's BVN/NIN been matched against the government record?
  /// Mirrors `users.identity_verified`, and it is the flag auth-service's
  /// `UpdateDateOfBirth` gates on: once it is true the stored date agreed with
  /// NIBSS or NIMC and is no longer the holder's to edit.
  ///
  /// CARRIED SO THE APP CAN ASK BEFORE IT OFFERS. The date-of-birth editor
  /// used to open the picker regardless and let the server refuse at the end
  /// — and in the first two days of logs it was refused 36 times out of 36,
  /// every one of them "locked because your identity has been verified". Each
  /// of those customers picked a date, confirmed it spelled out, and was then
  /// told they could not: a dead end dressed as an action, which is the loop
  /// kyc_profile_fix.dart exists to remove.
  ///
  /// SAFE TO READ FROM A CACHED PROFILE, in this one direction. The flag only
  /// ever goes false → true, so a stale session copy can be BEHIND the server
  /// but never ahead of it. A false here therefore still has to be checked by
  /// the server (and is); a true is trustworthy enough to route on.
  final bool identityVerified;

  /// State of the holder's verification ATTEMPT — `not_started`,
  /// `pending_review`, `approved`, `rejected`. Mirrors `users.kyc_status`.
  ///
  /// Carried ALONGSIDE [kycTier] rather than collapsed into one value because
  /// they answer different questions and the gates need both: the tier says
  /// what the holder may do, the status says whether they are waiting on us.
  /// Resolve the pair with `resolveKycState` in core/utils/kyc_completion.dart
  /// — never read either field directly in a gate.
  final String? kycStatus;

  /// Two-factor authentication state (mirrors users.two_factor_enabled /
  /// two_factor_method on the backend). Surfaced so Settings reflects the
  /// current 2FA state without an extra round-trip.
  final bool twoFactorEnabled;
  final String? twoFactorMethod;

  /// Date of birth as ISO `YYYY-MM-DD` (mirrors `users.date_of_birth` on the
  /// backend). Nullable when not yet captured. Used to surface the birthday
  /// celebration on the Settings page.
  final String? dateOfBirth;

  /// The holder's postal address (mirrors the `address_*` columns on the
  /// backend). Defaults to [PostalAddress.empty] rather than null so callers
  /// never have to null-check before reading a line — "not set" and "set to
  /// nothing" are the same thing for an address.
  final PostalAddress address;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.middleName = '',
    required this.email,
    this.phoneNumber,
    this.username,
    this.role,
    this.roles,
    required this.verified,
    required this.isEmailVerified,
    required this.createdAt,
    required this.updatedAt,
    this.language,
    this.currency,
    this.country,
    this.profilePicture,
    this.signupStatus,
    this.currentSignupStep,
    this.hasPasscode = false,
    this.hasTransactionPin = false,
    // Defaults FALSE so an older server response, which carries no such field,
    // can never accidentally lock a customer into a credential change.
    this.mustChangeCredentials = false,
    this.hasPassword = false,
    this.preferredLoginMethod,
    this.authType,
    this.twoFactorEnabled = false,
    this.twoFactorMethod,
    this.kycTier = 0,
    this.identityVerified = false,
    this.kycStatus,
    this.dateOfBirth,
    this.address = PostalAddress.empty,
  });

  /// An empty user which represents an unauthenticated user.
  static final User empty = User(
    id: '',
    firstName: '',
    lastName: '',
    middleName: '',
    email: '',
    phoneNumber: null,
    username: null,
    role: null,
    roles: null,
    verified: false,
    isEmailVerified: false,
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
    updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
    language: null,
    currency: null,
    country: null,
    profilePicture: null,
    signupStatus: null,
    currentSignupStep: null,
    hasPasscode: false,
    hasTransactionPin: false,
    mustChangeCredentials: false,
    hasPassword: false,
    preferredLoginMethod: null,
    authType: null,
    twoFactorEnabled: false,
    twoFactorMethod: null,
    kycTier: 0,
    kycStatus: null,
    dateOfBirth: null,
    address: PostalAddress.empty,
  );

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  /// A PROVIDER-LINKED account (Google / Apple): the link is the credential,
  /// so the account has no password and — until it chooses one — no passcode.
  ///
  /// Two sources, because they arrive from different places and either is
  /// enough: [authType] is the backend's own stamp (`auth_type == "SOCIAL"`),
  /// and [preferredLoginMethod] is the older mirror some responses still carry
  /// alone. Case-insensitive on both; a response that predates the field
  /// answers false, which is why `goAfterLogin` also accepts an override from
  /// a caller that read `login_method` from storage.
  bool get isSocialAccount {
    const social = 'social';
    if ((authType ?? '').toLowerCase().trim() == social) return true;
    return (preferredLoginMethod ?? '').toLowerCase().trim() == social;
  }

  /// Build a copy with one or more fields replaced. Pass [Object()] in
  /// the [profilePicture] slot to KEEP the existing value; pass `null`
  /// explicitly to clear it (used by Settings → Remove profile picture).
  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? middleName,
    String? email,
    String? phoneNumber,
    String? username,
    String? role,
    List<String>? roles,
    bool? verified,
    bool? isEmailVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? language,
    String? currency,
    String? country,
    Object? profilePicture = _sentinel,
    String? signupStatus,
    String? currentSignupStep,
    bool? hasPasscode,
    bool? hasTransactionPin,
    bool? mustChangeCredentials,
    bool? hasPassword,
    String? preferredLoginMethod,
    String? authType,
    bool? twoFactorEnabled,
    String? twoFactorMethod,
    int? kycTier,
    bool? identityVerified,
    String? kycStatus,
    String? dateOfBirth,
    PostalAddress? address,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      middleName: middleName ?? this.middleName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      username: username ?? this.username,
      role: role ?? this.role,
      roles: roles ?? this.roles,
      verified: verified ?? this.verified,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      language: language ?? this.language,
      currency: currency ?? this.currency,
      country: country ?? this.country,
      profilePicture: identical(profilePicture, _sentinel)
          ? this.profilePicture
          : profilePicture as String?,
      signupStatus: signupStatus ?? this.signupStatus,
      currentSignupStep: currentSignupStep ?? this.currentSignupStep,
      hasPasscode: hasPasscode ?? this.hasPasscode,
      hasTransactionPin: hasTransactionPin ?? this.hasTransactionPin,
      mustChangeCredentials:
          mustChangeCredentials ?? this.mustChangeCredentials,
      hasPassword: hasPassword ?? this.hasPassword,
      preferredLoginMethod: preferredLoginMethod ?? this.preferredLoginMethod,
      authType: authType ?? this.authType,
      twoFactorEnabled: twoFactorEnabled ?? this.twoFactorEnabled,
      twoFactorMethod: twoFactorMethod ?? this.twoFactorMethod,
      kycTier: kycTier ?? this.kycTier,
      identityVerified: identityVerified ?? this.identityVerified,
      kycStatus: kycStatus ?? this.kycStatus,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      address: address ?? this.address,
    );
  }

  @override
  List<Object?> get props => [
    id,
    firstName,
    middleName,
    lastName,
    email,
    phoneNumber,
    username,
    role,
    roles,
    verified,
    isEmailVerified,
    createdAt,
    updatedAt,
    language,
    currency,
    country,
    profilePicture,
    signupStatus,
    currentSignupStep,
    hasPasscode,
    hasTransactionPin,
    mustChangeCredentials,
    hasPassword,
    preferredLoginMethod,
    authType,
    twoFactorEnabled,
    twoFactorMethod,
    kycTier,
    identityVerified,
    kycStatus,
    dateOfBirth,
    address,
  ];
}

/// Marker used by [User.copyWith] to distinguish "explicit null"
/// (clear the value) from "no value passed" (keep the existing value)
/// on nullable fields like `profilePicture`.
const Object _sentinel = Object();
