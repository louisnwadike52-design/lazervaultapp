import 'package:equatable/equatable.dart';

import '../../data/fcy_account_service.dart';
import '../../data/fcy_prefill.dart';

/// States for the FCY KYC wizard.
///
/// Modelled on CreateInvoiceCubit's states, including the one detail that is easy
/// to get wrong: [FcyKycFormUpdated] carries a monotonically increasing [revision]
/// because bloc de-duplicates equal states. The form's field values live in mutable
/// controllers, so without something changing in `props` a second keystroke emits an
/// identical state and the UI never rebuilds — the invoice states carry the same
/// warning in their own comments for the same reason.
sealed class FcyKycState extends Equatable {
  const FcyKycState();
  @override
  List<Object?> get props => const [];
}

class FcyKycInitial extends FcyKycState {
  const FcyKycInitial();
}

/// Loading the prefill. Brief, and deliberately a distinct state: rendering the
/// form before prefill arrives would show inputs we are about to remove, which
/// reads as the form glitching.
class FcyKycLoading extends FcyKycState {
  const FcyKycLoading();
}

class FcyKycFormUpdated extends FcyKycState {
  const FcyKycFormUpdated({required this.revision, required this.prefill});

  final int revision;
  final FcyPrefill prefill;

  @override
  List<Object?> get props => [revision];
}

/// A step failed validation. [message] is shown as-is, so it must be written for
/// the user, not for a log.
class FcyKycValidationError extends FcyKycState {
  const FcyKycValidationError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class FcyKycSubmitting extends FcyKycState {
  const FcyKycSubmitting();
}

/// Submitted and accepted, OR saved and queued.
///
/// [queued] is the case that matters: Fincra currently has foreign-account opening
/// disabled at the account level, so a correct package cannot be sent yet. The
/// backend saves it and retries automatically, and the user must be told that
/// rather than shown a failure — their details were fine.
class FcyKycSubmitted extends FcyKycState {
  const FcyKycSubmitted({required this.message, this.queued = false});
  final String message;
  final bool queued;
  @override
  List<Object?> get props => [message, queued];
}

class FcyKycError extends FcyKycState {
  const FcyKycError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

/// The account already exists — issued, or with the provider for review.
///
/// There is no form in this state. It exists because this screen is reachable from
/// the account card as well as the exchange gate, and only the gate pre-checks
/// status; without it a user with a live USD account would be asked to re-verify.
class FcyKycAccountState extends FcyKycState {
  const FcyKycAccountState({required this.status});
  final FCYStatus status;
  @override
  List<Object?> get props => [status.status, status.accountNumber];
}
