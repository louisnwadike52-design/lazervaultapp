import 'package:lazervault/core/models/device_contact.dart';
import 'package:lazervault/src/features/contacts/data/repositories/contact_sync_repository.dart';

/// Use case for converting a device contact to a saved recipient
class ConvertContactToRecipientUseCase {
  final ContactSyncRepository _repository;

  ConvertContactToRecipientUseCase(this._repository);

  /// Executes the use case
  ///
  /// [contact] - The device contact to convert
  /// [accountNumber] - Optional bank account number
  /// [bankName] - Optional bank name
  /// [sortCode] - Optional sort code
  /// [autoDetectLazervault] - If true, tries to detect if this is a LazerVault user
  Future<ConvertResult> call({
    required DeviceContact contact,
    String? accountNumber,
    String? bankName,
    String? sortCode,
    bool autoDetectLazervault = true,
  }) async {
    return await _repository.convertContactToRecipient(
      contact: contact,
      accountNumber: accountNumber,
      bankName: bankName,
      sortCode: sortCode,
      autoDetectLazervault: autoDetectLazervault,
    );
  }
}
