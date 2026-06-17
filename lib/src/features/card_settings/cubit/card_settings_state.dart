import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/card_settings/domain/entities/account_details_entity.dart';

abstract class CardSettingsState extends Equatable {
  const CardSettingsState();

  @override
  List<Object?> get props => [];
}

class CardSettingsInitial extends CardSettingsState {}

class CardSettingsLoading extends CardSettingsState {}

class CardSettingsLoaded extends CardSettingsState {
  final Map<String, AccountDetailsEntity> accountDetailsMap;

  const CardSettingsLoaded(this.accountDetailsMap);

  @override
  List<Object?> get props => [accountDetailsMap];

  // Helper to get details for a specific account
  AccountDetailsEntity? getAccountDetails(String accountId) {
    return accountDetailsMap[accountId];
  }

  // Helper to check if we have details for a specific account
  bool hasAccountDetails(String accountId) {
    return accountDetailsMap.containsKey(accountId);
  }
}

class CardSettingsUpdating extends CardSettingsState {
  final String accountId;
  final String updateType; // 'security' or 'status'

  const CardSettingsUpdating(this.accountId, this.updateType);

  @override
  List<Object?> get props => [accountId, updateType];
}

class CardSettingsUpdateSuccess extends CardSettingsState {
  final AccountDetailsEntity accountDetails;
  final String message;

  const CardSettingsUpdateSuccess(this.accountDetails, this.message);

  @override
  List<Object?> get props => [accountDetails, message];
}

class CardSettingsError extends CardSettingsState {
  final String message;
  final int? statusCode;

  const CardSettingsError(this.message, {this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}
