import 'package:equatable/equatable.dart';

/// Represents a user entity in the application.
class User extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
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

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
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
  });

  /// An empty user which represents an unauthenticated user.
  static final User empty = User(
    id: '',
    firstName: '',
    lastName: '',
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
  );

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  /// Build a copy with one or more fields replaced. Pass [Object()] in
  /// the [profilePicture] slot to KEEP the existing value; pass `null`
  /// explicitly to clear it (used by Settings → Remove profile picture).
  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
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
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
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
    );
  }

  @override
  List<Object?> get props => [
        id,
        firstName,
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
      ];
}

/// Marker used by [User.copyWith] to distinguish "explicit null"
/// (clear the value) from "no value passed" (keep the existing value)
/// on nullable fields like `profilePicture`.
const Object _sentinel = Object();
