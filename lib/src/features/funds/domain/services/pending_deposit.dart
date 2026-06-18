/// Holds the in-flight deposit context across a KYC detour.
///
/// When a no-KYC user starts a "Link & Deposit" (or a mandate setup) and the
/// backend returns KYC_REQUIRED, we send them to the identity-verification
/// screen. That navigation REPLACES the deposit screen, so its in-memory
/// context (amount, currency, recurring toggle, selected wallet card, and any
/// already-linked account) would otherwise be lost. We stash it here right
/// before navigating to KYC, then the deposit screen restores it on resume
/// (after KYC succeeds) and continues the deposit from where it left off.
///
/// Registered as a GetIt singleton so the value survives the
/// deposit-screen -> KYC -> deposit-screen route churn (the deposit State is
/// disposed and re-created across that detour).
class PendingDeposit {
  /// Whether there is a deposit waiting to resume after a KYC detour.
  bool pending = false;

  /// The selected wallet card the deposit was funding. The deposit route's
  /// factory needs this to rebuild the screen, so we carry it back through
  /// navigation arguments AND keep a copy here.
  Map<String, dynamic>? selectedCard;

  /// Deposit amount the user entered (major units, e.g. naira).
  double amount = 0;

  /// Destination wallet currency (e.g. "NGN").
  String currency = 'NGN';

  /// Whether the user opted into recurring access (Direct Debit mandate).
  bool useRecurringAccess = true;

  /// The bank account the user had ALREADY linked before the KYC gate fired
  /// (if any). When set, the resume re-deposits from this account instead of
  /// re-opening Mono Connect to re-link.
  String? linkedAccountId;

  /// Bank display name for the linked account (narration / progress sheet).
  String? linkedBankName;

  /// Save the in-flight deposit context just before navigating to KYC.
  void save({
    required Map<String, dynamic> selectedCard,
    required double amount,
    required String currency,
    required bool useRecurringAccess,
    String? linkedAccountId,
    String? linkedBankName,
  }) {
    pending = true;
    this.selectedCard = selectedCard;
    this.amount = amount;
    this.currency = currency;
    this.useRecurringAccess = useRecurringAccess;
    this.linkedAccountId = linkedAccountId;
    this.linkedBankName = linkedBankName;
  }

  /// Clear the saved context once it has been consumed (resumed) or abandoned
  /// (KYC cancelled and the user is back on the form).
  void clear() {
    pending = false;
    selectedCard = null;
    amount = 0;
    currency = 'NGN';
    useRecurringAccess = true;
    linkedAccountId = null;
    linkedBankName = null;
  }
}
