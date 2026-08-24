import 'package:equatable/equatable.dart';
import '../domain/entities/account_summary_entity.dart';

abstract class AccountCardsSummaryState extends Equatable {
  const AccountCardsSummaryState();

  @override
  List<Object?> get props => [];
}

class AccountCardsSummaryInitial extends AccountCardsSummaryState {}

class AccountCardsSummaryLoading extends AccountCardsSummaryState {}

class AccountCardsSummaryLoaded extends AccountCardsSummaryState {
  final List<AccountSummaryEntity> accountSummaries;

  /// True while an EXPLICIT, user-initiated refresh (swipe-down → "Refresh
  /// accounts") is in flight. The cards stay on screen (we don't drop back to
  /// the full-area spinner), but the card shows a small refreshing indicator so
  /// the user gets feedback even when the balance comes back unchanged. Only set
  /// for manual refreshes — silent/background refetches keep this false so they
  /// never flash a loader.
  final bool isRefreshing;

  const AccountCardsSummaryLoaded(
    this.accountSummaries, {
    this.isRefreshing = false,
  });

  @override
  List<Object?> get props => [accountSummaries, isRefreshing];
}

class AccountCardsSummaryError extends AccountCardsSummaryState {
  final String message;
  final int? statusCode;

  const AccountCardsSummaryError(this.message, {this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

/// State emitted when a balance update is received via WebSocket
/// This allows the UI to animate the balance change
class AccountBalanceUpdated extends AccountCardsSummaryState {
  final List<AccountSummaryEntity> accountSummaries;
  final String updatedAccountId;
  final double previousBalance;
  final double newBalance;
  final double amount;
  final String eventType; // "deposit", "withdrawal", "transfer_in", "transfer_out"
  final String status;
  final String? reference;

  const AccountBalanceUpdated({
    required this.accountSummaries,
    required this.updatedAccountId,
    required this.previousBalance,
    required this.newBalance,
    required this.amount,
    required this.eventType,
    required this.status,
    this.reference,
  });

  @override
  List<Object?> get props => [
        accountSummaries,
        updatedAccountId,
        previousBalance,
        newBalance,
        amount,
        eventType,
        status,
        reference,
      ];
} 