import 'package:grpc/grpc.dart';
import 'package:lazervault/core/models/device_contact.dart';
import 'package:lazervault/src/features/contacts/data/models/synced_contact_model.dart';
import 'package:lazervault/src/features/contacts/data/models/lazervault_user_match_model.dart';
import 'package:lazervault/src/features/contacts/data/models/sync_preferences_model.dart';
import 'package:lazervault/src/generated/contact_sync.pb.dart' as pb;
import 'package:lazervault/src/generated/contact_sync.pbgrpc.dart' as grpc;

/// Repository for contact sync operations
class ContactSyncRepository {
  final grpc.ContactSyncServiceClient _client;

  ContactSyncRepository(this._client);

  /// Syncs contacts to the backend
  ///
  /// [contacts] - List of device contacts to sync
  /// [replaceAll] - If true, replaces all existing synced contacts
  Future<SyncResult> syncContacts({
    required List<DeviceContact> contacts,
    bool replaceAll = false,
  }) async {
    try {
      final request = pb.SyncContactsRequest()
        ..replaceAll = replaceAll
        ..contacts.addAll(
          contacts.map((contact) => pb.ContactToSync()
            ..deviceContactId = contact.id
            ..name = contact.name
            ..phoneNumbers.addAll(contact.phoneNumbers)
            ..emails.addAll(contact.emails)),
        );

      final response = await _client.syncContacts(request);

      return SyncResult(
        syncedContacts: response.syncedContacts
            .map((c) => SyncedContactModel.fromProto(c))
            .toList(),
        totalSynced: response.totalSynced,
        totalMatchedUsers: response.totalMatchedUsers,
        matchedUsers: response.matchedUsers
            .map((m) => LazerVaultUserMatchModel.fromProto(m))
            .toList(),
      );
    } on GrpcError catch (e) {
      throw ContactSyncException(
        'Failed to sync contacts: ${e.message}',
        code: e.code,
      );
    } catch (e) {
      throw ContactSyncException('Failed to sync contacts: $e');
    }
  }

  /// Gets all synced contacts from the backend
  ///
  /// [page] - Page number (0-indexed)
  /// [pageSize] - Number of contacts per page
  /// [searchQuery] - Optional search filter
  /// [onlyLazervaultUsers] - If true, only returns contacts that are LazerVault users
  Future<SyncedContactsResult> getSyncedContacts({
    int page = 0,
    int pageSize = 50,
    String? searchQuery,
    bool onlyLazervaultUsers = false,
  }) async {
    try {
      final request = pb.GetSyncedContactsRequest()
        ..page = page
        ..pageSize = pageSize
        ..onlyLazervaultUsers = onlyLazervaultUsers;

      if (searchQuery != null && searchQuery.isNotEmpty) {
        request.searchQuery = searchQuery;
      }

      final response = await _client.getSyncedContacts(request);

      return SyncedContactsResult(
        contacts: response.contacts
            .map((c) => SyncedContactModel.fromProto(c))
            .toList(),
        totalCount: response.totalCount,
        page: response.page,
        pageSize: response.pageSize,
      );
    } on GrpcError catch (e) {
      throw ContactSyncException(
        'Failed to get synced contacts: ${e.message}',
        code: e.code,
      );
    } catch (e) {
      throw ContactSyncException('Failed to get synced contacts: $e');
    }
  }

  /// Deletes synced contacts from the backend
  ///
  /// [contactIds] - Specific contact IDs to delete (empty = delete all)
  /// [deleteAll] - If true, deletes all synced contacts
  Future<DeleteResult> deleteSyncedContacts({
    List<String>? contactIds,
    bool deleteAll = false,
  }) async {
    try {
      final request = pb.DeleteSyncedContactsRequest()
        ..deleteAll = deleteAll;

      if (contactIds != null && contactIds.isNotEmpty) {
        request.contactIds.addAll(contactIds);
      }

      final response = await _client.deleteSyncedContacts(request);

      return DeleteResult(
        deletedCount: response.deletedCount,
        success: response.success,
      );
    } on GrpcError catch (e) {
      throw ContactSyncException(
        'Failed to delete synced contacts: ${e.message}',
        code: e.code,
      );
    } catch (e) {
      throw ContactSyncException('Failed to delete synced contacts: $e');
    }
  }

  /// Converts a device contact to a saved recipient
  ///
  /// [contact] - The device contact to convert
  /// [accountNumber] - Optional bank account number
  /// [bankName] - Optional bank name
  /// [sortCode] - Optional sort code
  /// [autoDetectLazervault] - If true, tries to detect if this is a LazerVault user
  Future<ConvertResult> convertContactToRecipient({
    required DeviceContact contact,
    String? accountNumber,
    String? bankName,
    String? sortCode,
    bool autoDetectLazervault = true,
  }) async {
    try {
      final request = pb.ConvertContactToRecipientRequest()
        ..deviceContactId = contact.id
        ..name = contact.name
        ..autoDetectLazervault = autoDetectLazervault;

      if (contact.phoneNumber != null) {
        request.phoneNumber = contact.phoneNumber!;
      }
      if (contact.email != null) {
        request.email = contact.email!;
      }
      if (accountNumber != null) {
        request.accountNumber = accountNumber;
      }
      if (bankName != null) {
        request.bankName = bankName;
      }
      if (sortCode != null) {
        request.sortCode = sortCode;
      }

      final response = await _client.convertContactToRecipient(request);

      return ConvertResult(
        recipientId: response.recipientId,
        isLazervaultUser: response.isLazervaultUser,
        lazervaultUserId: response.lazervaultUserId.isNotEmpty
            ? response.lazervaultUserId
            : null,
        lazervaultUsername: response.lazervaultUsername.isNotEmpty
            ? response.lazervaultUsername
            : null,
      );
    } on GrpcError catch (e) {
      throw ContactSyncException(
        'Failed to convert contact to recipient: ${e.message}',
        code: e.code,
      );
    } catch (e) {
      throw ContactSyncException('Failed to convert contact to recipient: $e');
    }
  }

  /// Finds LazerVault users from contact information
  ///
  /// [phoneNumbers] - List of phone numbers to match
  /// [emails] - List of email addresses to match
  Future<List<LazerVaultUserMatchModel>> findLazervaultUsers({
    List<String>? phoneNumbers,
    List<String>? emails,
  }) async {
    try {
      final request = pb.FindLazerVaultUsersRequest();

      if (phoneNumbers != null && phoneNumbers.isNotEmpty) {
        request.phoneNumbers.addAll(phoneNumbers);
      }
      if (emails != null && emails.isNotEmpty) {
        request.emails.addAll(emails);
      }

      final response = await _client.findLazerVaultUsers(request);

      return response.matchedUsers
          .map((m) => LazerVaultUserMatchModel.fromProto(m))
          .toList();
    } on GrpcError catch (e) {
      throw ContactSyncException(
        'Failed to find LazerVault users: ${e.message}',
        code: e.code,
      );
    } catch (e) {
      throw ContactSyncException('Failed to find LazerVault users: $e');
    }
  }

  /// Updates contact sync preferences
  ///
  /// [autoSyncEnabled] - Enable/disable automatic syncing
  /// [syncFrequency] - How often to sync
  /// [matchWithUsers] - Whether to match contacts with LazerVault users
  /// [syncPhotos] - Whether to include contact photos in sync
  Future<SyncPreferencesModel> updateSyncPreferences({
    bool? autoSyncEnabled,
    SyncFrequency? syncFrequency,
    bool? matchWithUsers,
    bool? syncPhotos,
  }) async {
    try {
      final request = pb.UpdateSyncPreferencesRequest();

      if (autoSyncEnabled != null) {
        request.autoSyncEnabled = autoSyncEnabled;
      }
      if (syncFrequency != null) {
        request.syncFrequency = syncFrequency.toProto();
      }
      if (matchWithUsers != null) {
        request.matchWithUsers = matchWithUsers;
      }
      if (syncPhotos != null) {
        request.syncPhotos = syncPhotos;
      }

      final response = await _client.updateSyncPreferences(request);

      return SyncPreferencesModel.fromProto(response.preferences);
    } on GrpcError catch (e) {
      throw ContactSyncException(
        'Failed to update sync preferences: ${e.message}',
        code: e.code,
      );
    } catch (e) {
      throw ContactSyncException('Failed to update sync preferences: $e');
    }
  }
}

/// Result of syncing contacts
class SyncResult {
  final List<SyncedContactModel> syncedContacts;
  final int totalSynced;
  final int totalMatchedUsers;
  final List<LazerVaultUserMatchModel> matchedUsers;

  const SyncResult({
    required this.syncedContacts,
    required this.totalSynced,
    required this.totalMatchedUsers,
    required this.matchedUsers,
  });
}

/// Result of getting synced contacts
class SyncedContactsResult {
  final List<SyncedContactModel> contacts;
  final int totalCount;
  final int page;
  final int pageSize;

  const SyncedContactsResult({
    required this.contacts,
    required this.totalCount,
    required this.page,
    required this.pageSize,
  });

  bool get hasMore => (page + 1) * pageSize < totalCount;
  int get totalPages => (totalCount / pageSize).ceil();
}

/// Result of deleting contacts
class DeleteResult {
  final int deletedCount;
  final bool success;

  const DeleteResult({
    required this.deletedCount,
    required this.success,
  });
}

/// Result of converting contact to recipient
class ConvertResult {
  final String recipientId;
  final bool isLazervaultUser;
  final String? lazervaultUserId;
  final String? lazervaultUsername;

  const ConvertResult({
    required this.recipientId,
    required this.isLazervaultUser,
    this.lazervaultUserId,
    this.lazervaultUsername,
  });
}

/// Exception thrown by contact sync operations
class ContactSyncException implements Exception {
  final String message;
  final int? code;

  const ContactSyncException(this.message, {this.code});

  @override
  String toString() => 'ContactSyncException: $message${code != null ? ' (code: $code)' : ''}';
}
