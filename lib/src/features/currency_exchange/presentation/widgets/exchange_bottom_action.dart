import 'package:lazervault/src/features/currency_exchange/presentation/cubit/exchange_state.dart';

/// Which action the Currency Exchange screen pins at the bottom.
///
/// THE DISTINCTION THIS EXISTS TO MAKE
/// -----------------------------------
/// "You have more to do" and "we cannot do this" are different situations and
/// must not wear the same button.
///
///   * Additional KYC needed → a real Continue. The journey exists, the user
///     can finish it, and Continue leads to the form that unblocks it.
///   * The rail is OFF → no Continue. Nothing the user does on this screen can
///     make the transfer happen, so a Continue (enabled OR greyed) states
///     something untrue: enabled, it promises a journey that will fail;
///     greyed, it implies a precondition the user could go and satisfy.
///
/// The screen shipped with the first shape for both: the CTA's `canProceed`
/// only asked whether there was an amount and a rate — still true from the
/// Convert tab — so a page whose entire body read "Not available at the
/// moment" ended in a live purple "Continue".
///
/// When the rail is off the pinned control becomes the way out the card
/// already names: the Convert tab, which works.
enum ExchangeBottomAction {
  /// Convert between the user's own currencies. Never gated by the payout rail.
  convertNow,

  /// Start the send-abroad journey (KYC is checked on the way, with its own
  /// prompt and its own continue).
  continueSendAbroad,

  /// The send-abroad rail is off. Offer the tab that works instead.
  switchToConvert;

  static ExchangeBottomAction resolve({
    required ExchangeMode mode,
    required bool intlPayoutAvailable,
  }) {
    if (mode != ExchangeMode.sendAbroad) return convertNow;
    return intlPayoutAvailable ? continueSendAbroad : switchToConvert;
  }

  String get label => switch (this) {
        convertNow => 'Convert Now',
        continueSendAbroad => 'Continue',
        switchToConvert => 'Convert between my currencies',
      };

  /// True for the two actions that start a money journey. The third navigates
  /// between tabs, so it is never disabled for want of an amount or a rate.
  bool get isJourneyCta => this != switchToConvert;
}
