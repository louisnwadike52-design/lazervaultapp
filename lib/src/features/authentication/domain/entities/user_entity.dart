import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String? name; // Optional name
  final String? username; // Optional username (tag pay)
  // Add other relevant user properties here (e.g., profile picture URL, roles)

  const User({
    required this.id,
    required this.email,
    this.name,
    this.username,
    // Initialize other properties
  });

  // Empty user which represents an unauthenticated user.
  static const empty = User(id: '', email: '');

  // Convenience getter to determine if the current user is empty.
  bool get isEmpty => this == User.empty;

  // Convenience getter to determine if the current user is not empty.
  bool get isNotEmpty => this != User.empty;


  @override
  List<Object?> get props => [id, email, name, username]; // Include other properties in props
} 