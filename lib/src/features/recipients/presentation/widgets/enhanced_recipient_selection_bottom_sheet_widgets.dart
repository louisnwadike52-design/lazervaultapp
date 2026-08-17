part of 'enhanced_recipient_selection_bottom_sheet.dart';

// Model for lazertag user search results
class LazertagUser {
  final String id;
  final String username;
  final String name;
  final String? email;
  final String? phoneNumber;
  final String? avatar;
  final bool isOnline;
  final bool isVerified;
  final String? currency;  // User's account currency for internal transfers
  final String searchType; // 'username', 'name', 'phone', 'email', or '' for unified

  const LazertagUser({
    required this.id,
    required this.username,
    required this.name,
    this.email,
    this.phoneNumber,
    this.avatar,
    this.isOnline = false,
    this.isVerified = false,
    this.currency,  // Default to null (will be fetched or default to NGN)
    this.searchType = '', // Default to unified search
  });

  /// Returns display info for search results showing what matched
  String get searchMatchInfo {
    final parts = <String>[];
    if (username.isNotEmpty) parts.add('@$username');
    if (email != null && email!.isNotEmpty) parts.add(email!);
    if (phoneNumber != null && phoneNumber!.isNotEmpty) parts.add(phoneNumber!);
    return parts.join(' • ');
  }

  /// Returns display username with @ prefix for username searches
  String get displayUsername => '@$username';
}

enum RecipientSelectionTab { saved, lazertag, contacts }
