import 'package:lazervault/src/features/contacts/data/repositories/contact_sync_repository.dart';

/// Use case for getting synced contacts from the backend
class GetSyncedContactsUseCase {
  final ContactSyncRepository _repository;

  GetSyncedContactsUseCase(this._repository);

  /// Executes the use case
  ///
  /// [page] - Page number (0-indexed)
  /// [pageSize] - Number of contacts per page
  /// [searchQuery] - Optional search filter
  /// [onlyLazervaultUsers] - If true, only returns contacts that are LazerVault users
  Future<SyncedContactsResult> call({
    int page = 0,
    int pageSize = 50,
    String? searchQuery,
    bool onlyLazervaultUsers = false,
  }) async {
    return await _repository.getSyncedContacts(
      page: page,
      pageSize: pageSize,
      searchQuery: searchQuery,
      onlyLazervaultUsers: onlyLazervaultUsers,
    );
  }
}
