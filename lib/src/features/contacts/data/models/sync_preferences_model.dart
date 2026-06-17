import 'package:fixnum/fixnum.dart';
import 'package:lazervault/src/generated/contact_sync.pb.dart' as pb;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart' as timestamp_pb;

/// Model representing contact sync preferences
class SyncPreferencesModel {
  final String userId;
  final bool autoSyncEnabled;
  final SyncFrequency syncFrequency;
  final bool matchWithUsers;
  final bool syncPhotos;
  final DateTime? lastSyncAt;
  final int totalSyncedContacts;
  final int totalMatchedUsers;

  const SyncPreferencesModel({
    required this.userId,
    required this.autoSyncEnabled,
    required this.syncFrequency,
    required this.matchWithUsers,
    required this.syncPhotos,
    this.lastSyncAt,
    required this.totalSyncedContacts,
    required this.totalMatchedUsers,
  });

  /// Creates model from proto message
  factory SyncPreferencesModel.fromProto(pb.SyncPreferences proto) {
    return SyncPreferencesModel(
      userId: proto.userId,
      autoSyncEnabled: proto.autoSyncEnabled,
      syncFrequency: SyncFrequency.fromProto(proto.syncFrequency),
      matchWithUsers: proto.matchWithUsers,
      syncPhotos: proto.syncPhotos,
      lastSyncAt: proto.hasLastSyncAt()
          ? DateTime.fromMillisecondsSinceEpoch(
              proto.lastSyncAt.seconds.toInt() * 1000,
            )
          : null,
      totalSyncedContacts: proto.totalSyncedContacts,
      totalMatchedUsers: proto.totalMatchedUsers,
    );
  }

  /// Converts model to proto message
  pb.SyncPreferences toProto() {
    final prefs = pb.SyncPreferences()
      ..userId = userId
      ..autoSyncEnabled = autoSyncEnabled
      ..syncFrequency = syncFrequency.toProto()
      ..matchWithUsers = matchWithUsers
      ..syncPhotos = syncPhotos
      ..totalSyncedContacts = totalSyncedContacts
      ..totalMatchedUsers = totalMatchedUsers;

    if (lastSyncAt != null) {
      prefs.lastSyncAt = timestamp_pb.Timestamp()
        ..seconds = Int64(lastSyncAt!.millisecondsSinceEpoch ~/ 1000)
        ..nanos = 0;
    }

    return prefs;
  }

  SyncPreferencesModel copyWith({
    String? userId,
    bool? autoSyncEnabled,
    SyncFrequency? syncFrequency,
    bool? matchWithUsers,
    bool? syncPhotos,
    DateTime? lastSyncAt,
    int? totalSyncedContacts,
    int? totalMatchedUsers,
  }) {
    return SyncPreferencesModel(
      userId: userId ?? this.userId,
      autoSyncEnabled: autoSyncEnabled ?? this.autoSyncEnabled,
      syncFrequency: syncFrequency ?? this.syncFrequency,
      matchWithUsers: matchWithUsers ?? this.matchWithUsers,
      syncPhotos: syncPhotos ?? this.syncPhotos,
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
      totalSyncedContacts: totalSyncedContacts ?? this.totalSyncedContacts,
      totalMatchedUsers: totalMatchedUsers ?? this.totalMatchedUsers,
    );
  }
}

/// Sync frequency enumeration
enum SyncFrequency {
  unspecified,
  manual,
  daily,
  weekly,
  realTime;

  /// Creates from proto enum
  static SyncFrequency fromProto(pb.SyncFrequency proto) {
    switch (proto) {
      case pb.SyncFrequency.MANUAL:
        return SyncFrequency.manual;
      case pb.SyncFrequency.DAILY:
        return SyncFrequency.daily;
      case pb.SyncFrequency.WEEKLY:
        return SyncFrequency.weekly;
      case pb.SyncFrequency.REAL_TIME:
        return SyncFrequency.realTime;
      default:
        return SyncFrequency.unspecified;
    }
  }

  /// Converts to proto enum
  pb.SyncFrequency toProto() {
    switch (this) {
      case SyncFrequency.manual:
        return pb.SyncFrequency.MANUAL;
      case SyncFrequency.daily:
        return pb.SyncFrequency.DAILY;
      case SyncFrequency.weekly:
        return pb.SyncFrequency.WEEKLY;
      case SyncFrequency.realTime:
        return pb.SyncFrequency.REAL_TIME;
      default:
        return pb.SyncFrequency.SYNC_FREQUENCY_UNSPECIFIED;
    }
  }

  String get displayName {
    switch (this) {
      case SyncFrequency.manual:
        return 'Manual';
      case SyncFrequency.daily:
        return 'Daily';
      case SyncFrequency.weekly:
        return 'Weekly';
      case SyncFrequency.realTime:
        return 'Real-time';
      default:
        return 'Not set';
    }
  }
}
