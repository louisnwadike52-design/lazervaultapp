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
  final bool verified;
  final bool isEmailVerified;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? language;
  final String? currency;
  final String? country;
  final String? profilePicture;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber,
    this.username,
    this.role,
    required this.verified,
    required this.isEmailVerified,
    required this.createdAt,
    required this.updatedAt,
    this.language,
    this.currency,
    this.country,
    this.profilePicture,
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
    verified: false,
    isEmailVerified: false,
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
    updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
    language: null,
    currency: null,
    country: null,
    profilePicture: null,
  );

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        phoneNumber,
        username,
        role,
        verified,
        isEmailVerified,
        createdAt,
        updatedAt,
        language,
        currency,
        country,
        profilePicture,
      ];
}
