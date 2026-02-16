import 'package:equatable/equatable.dart';

class UserSearchResultEntity extends Equatable {
  final String userId;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String profilePicture;
  final String searchType; // 'username', 'name', 'phone', 'email', or '' for unified
  final String? primaryAccountId; // Primary account ID for transfers (from auth service)

  const UserSearchResultEntity({
    required this.userId,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    this.searchType = '', // Default to unified search
    this.primaryAccountId, // Optional primary account ID
  });

  String get fullName => '$firstName $lastName';

  String get displayName {
    if (username.isNotEmpty) {
      return '@$username';
    }
    return fullName;
  }

  /// Returns display info for search results showing what matched
  String get searchMatchInfo {
    final parts = <String>[];
    if (username.isNotEmpty) parts.add('@$username');
    if (email.isNotEmpty) parts.add(email);
    if (phoneNumber.isNotEmpty) parts.add(phoneNumber);
    return parts.join(' • ');
  }

  String get initials {
    final first = firstName.isNotEmpty ? firstName[0] : '';
    final last = lastName.isNotEmpty ? lastName[0] : '';
    return (first + last).toUpperCase();
  }

  /// Returns the identifier to use for fetching account number
  /// - For username searches: returns username without @
  /// - For email/phone/name searches: returns userId (UUID)
  /// - For unified search: uses searchType to determine
  String getAccountQueryIdentifier() {
    // If searchType is specified, use it to determine
    if (searchType.isNotEmpty) {
      switch (searchType) {
        case 'username':
          // Remove @ prefix for account lookup if it's a pure username search
          return username.startsWith('@') ? username.substring(1) : username;
        case 'email':
        case 'phone':
        case 'name':
          // For email/phone/name searches, use userId directly
          return userId;
        default:
          return userId;
      }
    }

    // Unified search without specific type: check if username looks like an email
    if (username.contains('@')) {
      // Has @ symbol - could be email format, use userId to be safe
      return userId;
    }
    // Looks like a username (no @), use it directly
    if (username.isNotEmpty && !username.contains('@')) {
      return username;
    }
    // Fallback: use userId
    return userId;
  }

  @override
  List<Object?> get props => [
        userId,
        username,
        firstName,
        lastName,
        email,
        phoneNumber,
        profilePicture,
        primaryAccountId,
      ];
}
