part of 'contact_picker_bottom_sheet.dart';

enum ContactIdentifierType { email, phone }

/// Info about a platform user matched from contacts
class PlatformUserInfo {
  final String userId;
  final String userName;
  final String? profileImage;

  const PlatformUserInfo({
    required this.userId,
    required this.userName,
    this.profileImage,
  });
}
