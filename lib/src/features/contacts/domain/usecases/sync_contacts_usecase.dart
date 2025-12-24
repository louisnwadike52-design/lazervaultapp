import 'package:lazervault/core/models/device_contact.dart';
import 'package:lazervault/src/features/contacts/data/repositories/contact_sync_repository.dart';

/// Use case for syncing device contacts to the backend
class SyncContactsUseCase {
  final ContactSyncRepository _repository;

  SyncContactsUseCase(this._repository);

  /// Executes the use case
  ///
  /// [contacts] - List of device contacts to sync
  /// [replaceAll] - If true, replaces all existing synced contacts
  Future<SyncResult> call({
    required List<DeviceContact> contacts,
    bool replaceAll = false,
  }) async {
    return await _repository.syncContacts(
      contacts: contacts,
      replaceAll: replaceAll,
    );
  }
}
