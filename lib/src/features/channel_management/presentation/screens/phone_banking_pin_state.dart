/// What the Phone Banking screen knows about the user's transaction PIN.
///
/// A call is authorised by the PROFILE transaction PIN — there is no
/// phone-specific secret — so the question is only ever "does this user have a
/// transaction PIN?", and there are three answers, not two.
///
/// The screen used to read `registration?.hasPin ?? false`. A user who has
/// never switched phone banking on HAS NO REGISTRATION, so that expression
/// returned false and the screen told someone who had been banking with that
/// PIN for months to go and set one. Absence of a record is not absence of a
/// PIN.
enum PhoneBankingPinState {
  /// The user has a transaction PIN. Nothing to do here.
  present,

  /// The user genuinely has no transaction PIN — offer the REAL setup route.
  absent,

  /// Not answered yet, or the lookup failed. State the rule, offer nothing.
  unknown;

  /// [fromService] is the transaction-PIN service's answer and always wins;
  /// [fromRegistration] is the channel row's copy, used only until the
  /// service answers. Both null → [unknown].
  static PhoneBankingPinState resolve({
    bool? fromService,
    bool? fromRegistration,
  }) {
    final answer = fromService ?? fromRegistration;
    if (answer == null) return unknown;
    return answer ? present : absent;
  }

  bool get showsSetupAction => this == absent;
  bool get claimsPinIsSet => this == present;
}
