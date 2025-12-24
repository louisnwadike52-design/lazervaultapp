import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/contacts/data/models/synced_contact_model.dart';
import 'package:lazervault/src/features/contacts/data/models/lazervault_user_match_model.dart';
import 'package:lazervault/src/features/contacts/data/models/sync_preferences_model.dart';

/// Base state for contact sync
abstract class ContactSyncState extends Equatable {
  const ContactSyncState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class ContactSyncInitial extends ContactSyncState {
  const ContactSyncInitial();
}

/// Syncing contacts
class ContactSyncSyncing extends ContactSyncState {
  final int totalContacts;
  final int syncedCount;

  const ContactSyncSyncing({
    required this.totalContacts,
    this.syncedCount = 0,
  });

  @override
  List<Object?> get props => [totalContacts, syncedCount];

  double get progress => totalContacts > 0 ? syncedCount / totalContacts : 0.0;
}

/// Sync completed successfully
class ContactSyncSuccess extends ContactSyncState {
  final List<SyncedContactModel> syncedContacts;
  final int totalSynced;
  final int totalMatchedUsers;
  final List<LazerVaultUserMatchModel> matchedUsers;

  const ContactSyncSuccess({
    required this.syncedContacts,
    required this.totalSynced,
    required this.totalMatchedUsers,
    required this.matchedUsers,
  });

  @override
  List<Object?> get props => [
        syncedContacts,
        totalSynced,
        totalMatchedUsers,
        matchedUsers,
      ];
}

/// Sync failed
class ContactSyncError extends ContactSyncState {
  final String message;
  final int? errorCode;

  const ContactSyncError(this.message, {this.errorCode});

  @override
  List<Object?> get props => [message, errorCode];
}

/// Loading synced contacts
class ContactSyncLoading extends ContactSyncState {
  const ContactSyncLoading();
}

/// Synced contacts loaded
class ContactSyncLoaded extends ContactSyncState {
  final List<SyncedContactModel> contacts;
  final int totalCount;
  final int currentPage;
  final int pageSize;
  final bool hasMore;

  const ContactSyncLoaded({
    required this.contacts,
    required this.totalCount,
    required this.currentPage,
    required this.pageSize,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [
        contacts,
        totalCount,
        currentPage,
        pageSize,
        hasMore,
      ];
}

/// Finding LazerVault users
class ContactSyncFindingUsers extends ContactSyncState {
  const ContactSyncFindingUsers();
}

/// LazerVault users found
class ContactSyncUsersFound extends ContactSyncState {
  final List<LazerVaultUserMatchModel> matchedUsers;

  const ContactSyncUsersFound(this.matchedUsers);

  @override
  List<Object?> get props => [matchedUsers];
}

/// Converting contact to recipient
class ContactSyncConverting extends ContactSyncState {
  const ContactSyncConverting();
}

/// Contact converted to recipient
class ContactSyncConverted extends ContactSyncState {
  final String recipientId;
  final bool isLazervaultUser;
  final String? lazervaultUserId;
  final String? lazervaultUsername;

  const ContactSyncConverted({
    required this.recipientId,
    required this.isLazervaultUser,
    this.lazervaultUserId,
    this.lazervaultUsername,
  });

  @override
  List<Object?> get props => [
        recipientId,
        isLazervaultUser,
        lazervaultUserId,
        lazervaultUsername,
      ];
}

/// Deleting synced contacts
class ContactSyncDeleting extends ContactSyncState {
  const ContactSyncDeleting();
}

/// Contacts deleted
class ContactSyncDeleted extends ContactSyncState {
  final int deletedCount;

  const ContactSyncDeleted(this.deletedCount);

  @override
  List<Object?> get props => [deletedCount];
}

/// Updating sync preferences
class ContactSyncUpdatingPreferences extends ContactSyncState {
  const ContactSyncUpdatingPreferences();
}

/// Sync preferences updated
class ContactSyncPreferencesUpdated extends ContactSyncState {
  final SyncPreferencesModel preferences;

  const ContactSyncPreferencesUpdated(this.preferences);

  @override
  List<Object?> get props => [preferences];
}
