import 'package:equatable/equatable.dart';
import '../../domain/entities/epin_entities.dart';

export '../../domain/entities/epin_entities.dart';

abstract class EPinState extends Equatable {
  const EPinState();

  @override
  List<Object?> get props => [];
}

class EPinInitial extends EPinState {
  const EPinInitial();
}

// ── Networks ─────────────────────────────────────────────────────────
class EPinNetworksLoading extends EPinState {
  const EPinNetworksLoading();
}

class EPinNetworksLoaded extends EPinState {
  final List<EPinNetwork> networks;
  const EPinNetworksLoaded({required this.networks});

  @override
  List<Object?> get props => [networks];
}

class EPinNetworksError extends EPinState {
  final String message;
  const EPinNetworksError({required this.message});

  @override
  List<Object?> get props => [message];
}

// ── Purchase ─────────────────────────────────────────────────────────
class EPinPurchaseProcessing extends EPinState {
  final double progress; // 0.0 – 1.0
  final String currentStep;
  const EPinPurchaseProcessing({
    this.progress = 0.1,
    this.currentStep = 'Payment Initiated',
  });

  @override
  List<Object?> get props => [progress, currentStep];
}

class EPinPurchaseSuccess extends EPinState {
  final EPinOrder order;
  final String message;
  const EPinPurchaseSuccess({required this.order, required this.message});

  @override
  List<Object?> get props => [order, message];
}

class EPinPurchaseFailed extends EPinState {
  final String message;
  const EPinPurchaseFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

// ── Orders history ───────────────────────────────────────────────────
class EPinOrdersLoading extends EPinState {
  const EPinOrdersLoading();
}

class EPinOrdersLoaded extends EPinState {
  final List<EPinOrder> orders;
  const EPinOrdersLoaded({required this.orders});

  @override
  List<Object?> get props => [orders];
}

class EPinOrdersError extends EPinState {
  final String message;
  const EPinOrdersError({required this.message});

  @override
  List<Object?> get props => [message];
}

// ── Single order (re-open to view PINs) ──────────────────────────────
class EPinOrderLoading extends EPinState {
  const EPinOrderLoading();
}

class EPinOrderLoaded extends EPinState {
  final EPinOrder order;
  const EPinOrderLoaded({required this.order});

  @override
  List<Object?> get props => [order];
}

class EPinOrderError extends EPinState {
  final String message;
  const EPinOrderError({required this.message});

  @override
  List<Object?> get props => [message];
}
