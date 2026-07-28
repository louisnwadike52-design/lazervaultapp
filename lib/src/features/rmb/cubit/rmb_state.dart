part of 'rmb_cubit.dart';

sealed class RmbState extends Equatable {
  const RmbState();
  @override
  List<Object?> get props => [];
}

class RmbInitial extends RmbState {
  const RmbInitial();
}

class RmbLoading extends RmbState {
  const RmbLoading();
}

class RmbLoaded extends RmbState {
  final ProviderConfigResponse config;
  final List<Transfer> transfers;
  final bool transfersLoading;

  /// True when the recent-transfers fetch failed (distinct from "no transfers
  /// yet") so the landing can show a retry affordance instead of an empty state.
  final bool transfersError;

  const RmbLoaded({
    required this.config,
    this.transfers = const [],
    this.transfersLoading = false,
    this.transfersError = false,
  });

  RmbLoaded copyWith({
    ProviderConfigResponse? config,
    List<Transfer>? transfers,
    bool? transfersLoading,
    bool? transfersError,
  }) =>
      RmbLoaded(
        config: config ?? this.config,
        transfers: transfers ?? this.transfers,
        transfersLoading: transfersLoading ?? this.transfersLoading,
        transfersError: transfersError ?? this.transfersError,
      );

  @override
  List<Object?> get props =>
      [config, transfers, transfersLoading, transfersError];
}

class RmbError extends RmbState {
  final String message;
  const RmbError(this.message);
  @override
  List<Object?> get props => [message];
}
