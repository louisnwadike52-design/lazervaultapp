import 'package:equatable/equatable.dart';

import '../../domain/entities/exchange_prediction_entity.dart';

/// Sealed states for the informational, READ-ONLY exchange success prediction.
/// This is never blocking: the absence of a prediction (Initial / Unavailable)
/// must let the international transfer proceed normally.
sealed class ExchangePredictionState extends Equatable {
  const ExchangePredictionState();

  @override
  List<Object?> get props => [];
}

class ExchangePredictionInitial extends ExchangePredictionState {
  const ExchangePredictionInitial();
}

class ExchangePredictionLoading extends ExchangePredictionState {
  const ExchangePredictionLoading();
}

class ExchangePredictionLoaded extends ExchangePredictionState {
  final ExchangePredictionEntity prediction;

  const ExchangePredictionLoaded(this.prediction);

  @override
  List<Object?> get props => [prediction];
}

/// No data to display (cold-start, UNIMPLEMENTED backend, error, or genuinely
/// unknown). The UI shows a neutral placeholder or nothing at all. Never an
/// error to the user.
class ExchangePredictionUnavailable extends ExchangePredictionState {
  const ExchangePredictionUnavailable();
}

class ExchangePredictionFailure extends ExchangePredictionState {
  final String message;

  const ExchangePredictionFailure(this.message);

  @override
  List<Object?> get props => [message];
}
