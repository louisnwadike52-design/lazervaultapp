import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/funds/domain/entities/transfer_success_prediction.dart';

/// Sealed states for the informational, READ-ONLY transfer success prediction.
/// This is never blocking: the absence of a prediction (Initial / Unavailable)
/// must let the transfer proceed normally.
sealed class TransferPredictionState extends Equatable {
  const TransferPredictionState();

  @override
  List<Object?> get props => [];
}

class TransferPredictionInitial extends TransferPredictionState {
  const TransferPredictionInitial();
}

class TransferPredictionLoading extends TransferPredictionState {
  const TransferPredictionLoading();
}

class TransferPredictionLoaded extends TransferPredictionState {
  final TransferSuccessPrediction prediction;

  const TransferPredictionLoaded(this.prediction);

  @override
  List<Object?> get props => [prediction];
}

/// No data to display (cold-start, error, or genuinely unknown). The UI shows a
/// neutral placeholder or nothing at all. Never an error to the user.
class TransferPredictionUnavailable extends TransferPredictionState {
  const TransferPredictionUnavailable();
}
