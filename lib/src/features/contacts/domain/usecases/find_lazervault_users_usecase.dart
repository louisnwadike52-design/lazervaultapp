import 'package:lazervault/src/features/contacts/data/models/lazervault_user_match_model.dart';
import 'package:lazervault/src/features/contacts/data/repositories/contact_sync_repository.dart';

/// Use case for finding LazerVault users from contacts
class FindLazerVaultUsersUseCase {
  final ContactSyncRepository _repository;

  FindLazerVaultUsersUseCase(this._repository);

  /// Executes the use case
  ///
  /// [phoneNumbers] - List of phone numbers to match
  /// [emails] - List of email addresses to match
  Future<List<LazerVaultUserMatchModel>> call({
    List<String>? phoneNumbers,
    List<String>? emails,
  }) async {
    return await _repository.findLazervaultUsers(
      phoneNumbers: phoneNumbers,
      emails: emails,
    );
  }
}
