import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/models/device_contact.dart';
import 'package:lazervault/core/services/contact_service.dart';
import 'package:lazervault/src/features/contacts/data/repositories/contact_sync_repository.dart';
import 'package:lazervault/src/features/contacts/data/models/sync_preferences_model.dart';
import 'package:lazervault/src/features/contacts/domain/usecases/sync_contacts_usecase.dart';
import 'package:lazervault/src/features/contacts/domain/usecases/get_synced_contacts_usecase.dart';
import 'package:lazervault/src/features/contacts/domain/usecases/find_lazervault_users_usecase.dart';
import 'package:lazervault/src/features/contacts/domain/usecases/convert_contact_to_recipient_usecase.dart';
import 'contact_sync_state.dart';

/// Cubit for managing contact sync state
class ContactSyncCubit extends Cubit<ContactSyncState> {
  final SyncContactsUseCase _syncContactsUseCase;
  final GetSyncedContactsUseCase _getSyncedContactsUseCase;
  final FindLazerVaultUsersUseCase _findLazerVaultUsersUseCase;
  final ConvertContactToRecipientUseCase _convertContactToRecipientUseCase;
  final ContactSyncRepository _repository;
  final ContactService _contactService;

  ContactSyncCubit({
    required SyncContactsUseCase syncContactsUseCase,
    required GetSyncedContactsUseCase getSyncedContactsUseCase,
    required FindLazerVaultUsersUseCase findLazerVaultUsersUseCase,
    required ConvertContactToRecipientUseCase convertContactToRecipientUseCase,
    required ContactSyncRepository repository,
    required ContactService contactService,
  })  : _syncContactsUseCase = syncContactsUseCase,
        _getSyncedContactsUseCase = getSyncedContactsUseCase,
        _findLazerVaultUsersUseCase = findLazerVaultUsersUseCase,
        _convertContactToRecipientUseCase = convertContactToRecipientUseCase,
        _repository = repository,
        _contactService = contactService,
        super(const ContactSyncInitial());

  /// Syncs all device contacts to the backend
  ///
  /// [replaceAll] - If true, replaces all existing synced contacts
  Future<void> syncAllContacts({bool replaceAll = false}) async {
    try {
      // Get contacts from device
      final contacts = await _contactService.getContacts();

      if (contacts.isEmpty) {
        emit(const ContactSyncError('No contacts found on device'));
        return;
      }

      // Emit syncing state
      emit(ContactSyncSyncing(totalContacts: contacts.length));

      // Sync to backend
      final result = await _syncContactsUseCase(
        contacts: contacts,
        replaceAll: replaceAll,
      );

      // Emit success state
      emit(ContactSyncSuccess(
        syncedContacts: result.syncedContacts,
        totalSynced: result.totalSynced,
        totalMatchedUsers: result.totalMatchedUsers,
        matchedUsers: result.matchedUsers,
      ));
    } on ContactSyncException catch (e) {
      emit(ContactSyncError(e.message, errorCode: e.code));
    } catch (e) {
      emit(ContactSyncError('Failed to sync contacts: $e'));
    }
  }

  /// Syncs specific contacts
  Future<void> syncContacts(List<DeviceContact> contacts,
      {bool replaceAll = false}) async {
    try {
      if (contacts.isEmpty) {
        emit(const ContactSyncError('No contacts provided'));
        return;
      }

      emit(ContactSyncSyncing(totalContacts: contacts.length));

      final result = await _syncContactsUseCase(
        contacts: contacts,
        replaceAll: replaceAll,
      );

      emit(ContactSyncSuccess(
        syncedContacts: result.syncedContacts,
        totalSynced: result.totalSynced,
        totalMatchedUsers: result.totalMatchedUsers,
        matchedUsers: result.matchedUsers,
      ));
    } on ContactSyncException catch (e) {
      emit(ContactSyncError(e.message, errorCode: e.code));
    } catch (e) {
      emit(ContactSyncError('Failed to sync contacts: $e'));
    }
  }

  /// Gets synced contacts from the backend
  ///
  /// [page] - Page number (0-indexed)
  /// [pageSize] - Number of contacts per page
  /// [searchQuery] - Optional search filter
  /// [onlyLazervaultUsers] - If true, only returns contacts that are LazerVault users
  Future<void> getSyncedContacts({
    int page = 0,
    int pageSize = 50,
    String? searchQuery,
    bool onlyLazervaultUsers = false,
  }) async {
    try {
      emit(const ContactSyncLoading());

      final result = await _getSyncedContactsUseCase(
        page: page,
        pageSize: pageSize,
        searchQuery: searchQuery,
        onlyLazervaultUsers: onlyLazervaultUsers,
      );

      emit(ContactSyncLoaded(
        contacts: result.contacts,
        totalCount: result.totalCount,
        currentPage: result.page,
        pageSize: result.pageSize,
        hasMore: result.hasMore,
      ));
    } on ContactSyncException catch (e) {
      emit(ContactSyncError(e.message, errorCode: e.code));
    } catch (e) {
      emit(ContactSyncError('Failed to get synced contacts: $e'));
    }
  }

  /// Finds LazerVault users from contacts
  ///
  /// [phoneNumbers] - List of phone numbers to match
  /// [emails] - List of email addresses to match
  Future<void> findLazerVaultUsers({
    List<String>? phoneNumbers,
    List<String>? emails,
  }) async {
    try {
      emit(const ContactSyncFindingUsers());

      final matchedUsers = await _findLazerVaultUsersUseCase(
        phoneNumbers: phoneNumbers,
        emails: emails,
      );

      emit(ContactSyncUsersFound(matchedUsers));
    } on ContactSyncException catch (e) {
      emit(ContactSyncError(e.message, errorCode: e.code));
    } catch (e) {
      emit(ContactSyncError('Failed to find LazerVault users: $e'));
    }
  }

  /// Finds LazerVault users from all device contacts
  Future<void> findLazerVaultUsersFromDeviceContacts() async {
    try {
      emit(const ContactSyncFindingUsers());

      // Get all contacts
      final contacts = await _contactService.getContacts();

      if (contacts.isEmpty) {
        emit(const ContactSyncUsersFound([]));
        return;
      }

      // Extract phone numbers and emails
      final phoneNumbers = <String>[];
      final emails = <String>[];

      for (final contact in contacts) {
        phoneNumbers.addAll(contact.phoneNumbers);
        emails.addAll(contact.emails);
      }

      // Find matches
      final matchedUsers = await _findLazerVaultUsersUseCase(
        phoneNumbers: phoneNumbers,
        emails: emails,
      );

      emit(ContactSyncUsersFound(matchedUsers));
    } on ContactSyncException catch (e) {
      emit(ContactSyncError(e.message, errorCode: e.code));
    } catch (e) {
      emit(ContactSyncError('Failed to find LazerVault users: $e'));
    }
  }

  /// Converts a device contact to a saved recipient
  Future<void> convertContactToRecipient({
    required DeviceContact contact,
    String? accountNumber,
    String? bankName,
    String? sortCode,
    bool autoDetectLazervault = true,
  }) async {
    try {
      emit(const ContactSyncConverting());

      final result = await _convertContactToRecipientUseCase(
        contact: contact,
        accountNumber: accountNumber,
        bankName: bankName,
        sortCode: sortCode,
        autoDetectLazervault: autoDetectLazervault,
      );

      emit(ContactSyncConverted(
        recipientId: result.recipientId,
        isLazervaultUser: result.isLazervaultUser,
        lazervaultUserId: result.lazervaultUserId,
        lazervaultUsername: result.lazervaultUsername,
      ));
    } on ContactSyncException catch (e) {
      emit(ContactSyncError(e.message, errorCode: e.code));
    } catch (e) {
      emit(ContactSyncError('Failed to convert contact: $e'));
    }
  }

  /// Deletes synced contacts from the backend
  Future<void> deleteSyncedContacts({
    List<String>? contactIds,
    bool deleteAll = false,
  }) async {
    try {
      emit(const ContactSyncDeleting());

      final result = await _repository.deleteSyncedContacts(
        contactIds: contactIds,
        deleteAll: deleteAll,
      );

      emit(ContactSyncDeleted(result.deletedCount));
    } on ContactSyncException catch (e) {
      emit(ContactSyncError(e.message, errorCode: e.code));
    } catch (e) {
      emit(ContactSyncError('Failed to delete synced contacts: $e'));
    }
  }

  /// Updates sync preferences
  Future<void> updateSyncPreferences({
    bool? autoSyncEnabled,
    SyncFrequency? syncFrequency,
    bool? matchWithUsers,
    bool? syncPhotos,
  }) async {
    try {
      emit(const ContactSyncUpdatingPreferences());

      final preferences = await _repository.updateSyncPreferences(
        autoSyncEnabled: autoSyncEnabled,
        syncFrequency: syncFrequency,
        matchWithUsers: matchWithUsers,
        syncPhotos: syncPhotos,
      );

      emit(ContactSyncPreferencesUpdated(preferences));
    } on ContactSyncException catch (e) {
      emit(ContactSyncError(e.message, errorCode: e.code));
    } catch (e) {
      emit(ContactSyncError('Failed to update sync preferences: $e'));
    }
  }

  /// Resets state to initial
  void reset() {
    emit(const ContactSyncInitial());
  }
}
