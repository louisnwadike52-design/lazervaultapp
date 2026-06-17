import 'package:lazervault/src/generated/contact_sync.pb.dart' as pb;

/// Model representing a LazerVault user matched from contacts
class LazerVaultUserMatchModel {
  final String contactId;
  final String userId;
  final String username;
  final String name;
  final String? profilePhotoUrl;
  final bool isVerified;
  final String matchedBy; // 'phone' or 'email'

  const LazerVaultUserMatchModel({
    required this.contactId,
    required this.userId,
    required this.username,
    required this.name,
    this.profilePhotoUrl,
    required this.isVerified,
    required this.matchedBy,
  });

  /// Creates model from proto message
  factory LazerVaultUserMatchModel.fromProto(pb.LazerVaultUserMatch proto) {
    return LazerVaultUserMatchModel(
      contactId: proto.contactId,
      userId: proto.userId,
      username: proto.username,
      name: proto.name,
      profilePhotoUrl: proto.profilePhotoUrl.isNotEmpty
          ? proto.profilePhotoUrl
          : null,
      isVerified: proto.isVerified,
      matchedBy: proto.matchedBy,
    );
  }

  /// Converts model to proto message
  pb.LazerVaultUserMatch toProto() {
    return pb.LazerVaultUserMatch()
      ..contactId = contactId
      ..userId = userId
      ..username = username
      ..name = name
      ..profilePhotoUrl = profilePhotoUrl ?? ''
      ..isVerified = isVerified
      ..matchedBy = matchedBy;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LazerVaultUserMatchModel && other.userId == userId;
  }

  @override
  int get hashCode => userId.hashCode;
}
