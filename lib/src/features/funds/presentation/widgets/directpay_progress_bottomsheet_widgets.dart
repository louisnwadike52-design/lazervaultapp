part of 'directpay_progress_bottomsheet.dart';

/// DirectPay Progress Stage
enum DirectPayStage {
  linking,
  initiating,
  authorizing,
  processing,
  success,
  failed,
}

/// Which user journey the dark progress sheet narrates. The step rail and the
/// stage copy adapt to it:
/// - [linkAndDeposit]: fresh bank via Mono Connect → 4 steps starting at
///   "Linking Account".
/// - [redeposit]: an ALREADY-LINKED bank ("Deposit again" card / post-mandate
///   resume) → 3 steps, never shows "Linking Account".
/// - [mandateSetup]: recurring toggle ON → 4 steps with Direct Debit wording
///   for the setup/authorization stages.
enum DirectPayProgressFlow {
  linkAndDeposit,
  redeposit,
  mandateSetup,
}

extension DirectPayProgressFlowSteps on DirectPayProgressFlow {
  /// The non-terminal stages shown on the step rail, in order.
  List<DirectPayStage> get steps {
    switch (this) {
      case DirectPayProgressFlow.linkAndDeposit:
      case DirectPayProgressFlow.mandateSetup:
        return const [
          DirectPayStage.linking,
          DirectPayStage.initiating,
          DirectPayStage.authorizing,
          DirectPayStage.processing,
        ];
      case DirectPayProgressFlow.redeposit:
        return const [
          DirectPayStage.initiating,
          DirectPayStage.authorizing,
          DirectPayStage.processing,
        ];
    }
  }

  /// Rail position of [stage] for this flow. Terminal stages (success/failed)
  /// rank past the end so every step renders completed; a stage that isn't on
  /// this flow's rail (defensive) clamps to 0.
  int indexOf(DirectPayStage stage) {
    if (stage == DirectPayStage.success || stage == DirectPayStage.failed) {
      return steps.length;
    }
    final i = steps.indexOf(stage);
    return i < 0 ? 0 : i;
  }
}

/// Extension to get stage details
extension DirectPayStageExtension on DirectPayStage {
  String get title => titleFor(DirectPayProgressFlow.linkAndDeposit);

  /// Flow-aware stage title. The same stage reads differently depending on the
  /// journey: a redeposit never links, and a mandate setup authorizes a Direct
  /// Debit rather than a single payment.
  String titleFor(DirectPayProgressFlow flow) {
    switch (this) {
      case DirectPayStage.linking:
        return 'Linking Account';
      case DirectPayStage.initiating:
        return flow == DirectPayProgressFlow.mandateSetup
            ? 'Setting Up Direct Debit'
            : (flow == DirectPayProgressFlow.redeposit
                ? 'Preparing Deposit'
                : 'Initiating Payment');
      case DirectPayStage.authorizing:
        return flow == DirectPayProgressFlow.mandateSetup
            ? 'Authorize Direct Debit'
            : 'Authorizing Payment';
      case DirectPayStage.processing:
        return 'Processing Deposit';
      case DirectPayStage.success:
        return 'Deposit Successful';
      case DirectPayStage.failed:
        return 'Deposit Failed';
    }
  }

  String get description =>
      descriptionFor(DirectPayProgressFlow.linkAndDeposit);

  /// Flow-aware stage description (see [titleFor]).
  String descriptionFor(DirectPayProgressFlow flow) {
    switch (this) {
      case DirectPayStage.linking:
        return 'Securely connecting to your bank...';
      case DirectPayStage.initiating:
        return flow == DirectPayProgressFlow.mandateSetup
            ? 'Creating your Direct Debit mandate...'
            : 'Setting up your deposit...';
      case DirectPayStage.authorizing:
        return flow == DirectPayProgressFlow.mandateSetup
            ? 'Approve the Direct Debit at your bank...'
            : 'Please complete authorization...';
      case DirectPayStage.processing:
        return 'Your deposit is being processed...';
      case DirectPayStage.success:
        return 'Your funds have been deposited!';
      case DirectPayStage.failed:
        return 'Something went wrong';
    }
  }

  IconData get icon {
    switch (this) {
      case DirectPayStage.linking:
        return Icons.link;
      case DirectPayStage.initiating:
        return Icons.receipt_long;
      case DirectPayStage.authorizing:
        return Icons.security;
      case DirectPayStage.processing:
        return Icons.sync;
      case DirectPayStage.success:
        return Icons.check_circle;
      case DirectPayStage.failed:
        return Icons.error;
    }
  }

  Color get color {
    switch (this) {
      case DirectPayStage.linking:
      case DirectPayStage.initiating:
      case DirectPayStage.authorizing:
      case DirectPayStage.processing:
        return const Color.fromARGB(255, 78, 3, 208);
      case DirectPayStage.success:
        return const Color(0xFF10B981);
      case DirectPayStage.failed:
        return Colors.red;
    }
  }

  int get stageIndex {
    switch (this) {
      case DirectPayStage.linking:
        return 0;
      case DirectPayStage.initiating:
        return 1;
      case DirectPayStage.authorizing:
        return 2;
      case DirectPayStage.processing:
        return 3;
      case DirectPayStage.success:
      case DirectPayStage.failed:
        return 4;
    }
  }
}

/// Controller for managing DirectPay progress
class DirectPayProgressController extends ChangeNotifier {
  DirectPayStage _stage = DirectPayStage.linking;
  DirectPayProgressFlow _flow = DirectPayProgressFlow.linkAndDeposit;
  // The in-rail stage we were on when a failure occurred, so the rail can show
  // the red X at the step that actually failed (not all-green-then-nothing).
  DirectPayStage? _failedAtStage;
  String? _errorMessage;
  String? _errorTitle;
  bool _retryable = true;
  // Optional label for the primary recovery button. Null → the default
  // "Try Again". A re-link recovery (unverified bank details) sets "Re-link bank"
  // so the action reads as what it actually does.
  String? _retryLabel;
  // A failure that the user can only clear by completing identity verification
  // (BVN). Distinct from a normal retryable failure: instead of "Try Again" we
  // show a "Verify Now" CTA that routes into KYC. Never set alongside a normal
  // retry — these are mutually-exclusive terminal failure shapes.
  bool _kycRequired = false;
  String? _bankName;
  double? _amount;
  String? _currency;
  bool _isVisible = false;

  DirectPayStage get stage => _stage;
  DirectPayStage? get failedAtStage => _failedAtStage;
  DirectPayProgressFlow get flow => _flow;
  String? get errorMessage => _errorMessage;
  String? get errorTitle => _errorTitle;
  bool get retryable => _retryable;
  String? get retryLabel => _retryLabel;
  bool get kycRequired => _kycRequired;
  String? get bankName => _bankName;
  double? get amount => _amount;
  String? get currency => _currency;
  bool get isVisible => _isVisible;

  void show({
    required String bankName,
    required double amount,
    required String currency,
    DirectPayProgressFlow flow = DirectPayProgressFlow.linkAndDeposit,
  }) {
    _bankName = bankName;
    _amount = amount;
    _currency = currency;
    _flow = flow;
    // Start at the first stage of THIS journey — a redeposit on an
    // already-linked bank must never open on "Linking Account".
    _stage = flow.steps.first;
    _failedAtStage = null;
    _errorMessage = null;
    _errorTitle = null;
    _retryable = true;
    _retryLabel = null;
    _kycRequired = false;
    _isVisible = true;
    notifyListeners();
  }

  void updateStage(
    DirectPayStage stage, {
    String? errorMessage,
    String? errorTitle,
    bool retryable = true,
    String? retryLabel,
  }) {
    if (stage == DirectPayStage.failed) {
      // Remember the step we failed AT (only if we were on a real rail step),
      // so the indicator can mark that step red and leave later steps inactive.
      if (_stage != DirectPayStage.failed && _stage != DirectPayStage.success) {
        _failedAtStage = _stage;
      }
    } else {
      _failedAtStage = null;
    }
    _stage = stage;
    _errorMessage = errorMessage;
    _errorTitle = errorTitle;
    _retryable = retryable;
    _retryLabel = retryLabel;
    // A plain stage update is never a KYC gate — clear any prior KYC flag so a
    // later retryable/transient failure renders the normal Retry CTA.
    _kycRequired = false;
    notifyListeners();
  }

  /// Drive the sheet into the KYC-required terminal state. Renders a "Verify
  /// Now" primary CTA (routes into BVN) instead of "Try Again", so the user is
  /// never left staring at a stuck spinner when the backend gates on identity.
  void failKyc({
    String? title,
    String? message,
  }) {
    if (_stage != DirectPayStage.failed && _stage != DirectPayStage.success) {
      _failedAtStage = _stage;
    }
    _stage = DirectPayStage.failed;
    _errorTitle = title ?? 'Verification required';
    _errorMessage = message ??
        'Complete a quick BVN verification to set up Direct Debit / deposit from your bank.';
    // KYC failures are not retryable in-place — the user must verify first.
    _retryable = false;
    _kycRequired = true;
    notifyListeners();
  }

  void hide() {
    _isVisible = false;
    notifyListeners();
  }

  void reset() {
    _stage = DirectPayStage.linking;
    _flow = DirectPayProgressFlow.linkAndDeposit;
    _failedAtStage = null;
    _errorMessage = null;
    _errorTitle = null;
    _retryable = true;
    _kycRequired = false;
    _bankName = null;
    _amount = null;
    _currency = null;
    _isVisible = false;
    notifyListeners();
  }
}
