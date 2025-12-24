import 'package:equatable/equatable.dart';

class UserSearchResultEntity extends Equatable {
  final String userId;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String profilePicture;

  const UserSearchResultEntity({
    required this.userId,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePicture,
  });

  String get fullName => '$firstName $lastName';

  String get displayName {
    if (username.isNotEmpty) {
      return '@$username';
    }
    return fullName;
  }

  String get initials {
    final first = firstName.isNotEmpty ? firstName[0] : '';
    final last = lastName.isNotEmpty ? lastName[0] : '';
    return (first + last).toUpperCase();
  }

  @override
  List<Object?> get props => [
        userId,
        username,
        firstName,
        lastName,
        email,
        profilePicture,
      ];
}
