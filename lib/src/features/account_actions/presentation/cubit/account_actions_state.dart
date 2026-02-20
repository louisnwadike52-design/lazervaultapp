import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/account_actions/domain/entities/account_details_entity.dart';
import 'package:lazervault/src/features/account_actions/domain/entities/document_entity.dart';

/// Base state for account actions
sealed class AccountActionsState extends Equatable {
  const AccountActionsState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class AccountActionsInitial extends AccountActionsState {}

/// Loading state
class AccountActionsLoading extends AccountActionsState {}

/// Account details loaded
class AccountDetailsLoaded extends AccountActionsState {
  final AccountDetailsEntity accountDetails;

  const AccountDetailsLoaded(this.accountDetails);

  @override
  List<Object?> get props => [accountDetails];
}

/// Account freezing in progress
class AccountFreezing extends AccountActionsState {
  final AccountDetailsEntity currentDetails;

  const AccountFreezing(this.currentDetails);

  @override
  List<Object?> get props => [currentDetails];
}

/// Account frozen successfully
class AccountFrozen extends AccountActionsState {
  final AccountDetailsEntity accountDetails;
  final String message;

  const AccountFrozen(this.accountDetails, {this.message = 'Card frozen successfully'});

  @override
  List<Object?> get props => [accountDetails, message];
}

/// Account unfrozen successfully
class AccountUnfrozen extends AccountActionsState {
  final AccountDetailsEntity accountDetails;
  final String message;

  const AccountUnfrozen(this.accountDetails, {this.message = 'Card unfrozen successfully'});

  @override
  List<Object?> get props => [accountDetails, message];
}

/// Security settings updating
class SecuritySettingsUpdating extends AccountActionsState {
  final AccountDetailsEntity currentDetails;

  const SecuritySettingsUpdating(this.currentDetails);

  @override
  List<Object?> get props => [currentDetails];
}

/// Security settings updated successfully
class SecuritySettingsUpdated extends AccountActionsState {
  final AccountDetailsEntity accountDetails;
  final String message;

  const SecuritySettingsUpdated(this.accountDetails, {
    this.message = 'Security settings updated',
  });

  @override
  List<Object?> get props => [accountDetails, message];
}

/// Spending limits updating
class SpendingLimitsUpdating extends AccountActionsState {
  final AccountDetailsEntity currentDetails;

  const SpendingLimitsUpdating(this.currentDetails);

  @override
  List<Object?> get props => [currentDetails];
}

/// Spending limits updated successfully
class SpendingLimitsUpdated extends AccountActionsState {
  final AccountDetailsEntity accountDetails;
  final String message;

  const SpendingLimitsUpdated(this.accountDetails, {
    this.message = 'Spending limits updated',
  });

  @override
  List<Object?> get props => [accountDetails, message];
}

/// PIN revealing
class PINRevealing extends AccountActionsState {
  final AccountDetailsEntity currentDetails;

  const PINRevealing(this.currentDetails);

  @override
  List<Object?> get props => [currentDetails];
}

/// PIN revealed successfully
class PINRevealed extends AccountActionsState {
  final AccountDetailsEntity accountDetails;
  final String pin;
  final DateTime? expiresAt;

  const PINRevealed(this.accountDetails, this.pin, {this.expiresAt});

  @override
  List<Object?> get props => [accountDetails, pin, expiresAt];
}

/// Card details revealing
class CardDetailsRevealing extends AccountActionsState {
  final AccountDetailsEntity currentDetails;

  const CardDetailsRevealing(this.currentDetails);

  @override
  List<Object?> get props => [currentDetails];
}

/// Card details revealed successfully
class CardDetailsRevealed extends AccountActionsState {
  final AccountDetailsEntity accountDetails;
  final String cardNumber;
  final String expiryDate;
  final String cvv;

  const CardDetailsRevealed({
    required this.accountDetails,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
  });

  @override
  List<Object?> get props => [accountDetails, cardNumber, expiryDate, cvv];
}

/// Document downloading
class DocumentDownloading extends AccountActionsState {
  final String documentTitle;

  const DocumentDownloading(this.documentTitle);

  @override
  List<Object?> get props => [documentTitle];
}

/// Document downloaded successfully
class DocumentDownloaded extends AccountActionsState {
  final DocumentEntity document;
  final String? localPath;

  const DocumentDownloaded(this.document, {this.localPath});

  @override
  List<Object?> get props => [document, localPath];
}

/// Error state
class AccountActionsError extends AccountActionsState {
  final String message;
  final int? statusCode;

  const AccountActionsError(this.message, {this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}
