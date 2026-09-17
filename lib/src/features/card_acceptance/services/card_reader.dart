import 'dart:io';

/// Reading a customer's card with the merchant's phone.
///
/// WHY THIS IS AN INTERFACE AND NOT AN IMPLEMENTATION
/// --------------------------------------------------
/// Tapping an EMV card on a phone requires a PCI MPoC-certified kernel plus
/// device attestation. On Android that means a certified SoftPOS SDK (Nearpays
/// and the acquirers ship one); on iOS it is only possible through Apple's Tap
/// to Pay programme with an approved payment platform, which is not available
/// in every market.
///
/// None of that can be written here — it is certified, vendor-supplied code.
/// What CAN be built is everything around it, so this interface is the seam the
/// certified SDK drops into. Until one is integrated, [UnavailableCardReader]
/// reports the capability as absent and the UI says so plainly rather than
/// failing at the tap with a customer waiting.
///
/// The read returns an ENCRYPTED payload. It is forwarded to the provider
/// verbatim and never inspected — neither this app nor our backend ever holds a
/// PAN, which is what keeps both out of PCI scope.
abstract class CardReader {
  /// Whether this device can read a card right now: hardware present, OS
  /// permission granted, SDK attested.
  Future<CardReaderAvailability> availability();

  /// Wait for a card and return the encrypted payload for [amountMinor].
  ///
  /// Amount is passed in because EMV binds it into the cryptogram — a payload
  /// read for one amount cannot be replayed for another.
  Future<CardReadResult> readCard({
    required int amountMinor,
    required String currency,
    required String reference,
  });

  /// Stop waiting for a card. Called when the merchant cancels.
  Future<void> cancel();
}

/// Why card reading is or isn't possible on this device.
class CardReaderAvailability {
  const CardReaderAvailability({
    required this.available,
    this.reason = '',
    this.canBeFixedByUser = false,
  });

  final bool available;

  /// Merchant-facing. Says what to do next where the user can act, and what is
  /// true where they cannot.
  final String reason;

  /// True when turning NFC on, or granting a permission, would fix it — the UI
  /// offers an action instead of a dead end.
  final bool canBeFixedByUser;
}

/// The outcome of waiting for a card.
class CardReadResult {
  const CardReadResult({
    required this.success,
    this.encryptedPayload = '',
    this.cancelled = false,
    this.error = '',
  });

  final bool success;

  /// Opaque, encrypted, forwarded verbatim. Never parsed.
  final String encryptedPayload;

  /// The merchant backed out. Distinct from an error: nothing went wrong and
  /// the UI should not apologise.
  final bool cancelled;

  final String error;
}

/// The reader used until a certified SDK is integrated.
///
/// Deliberately explicit rather than a silent no-op: a stub that pretended to
/// read a card would produce a charge attempt with an empty payload, which the
/// provider would decline in front of a paying customer with no explanation.
class UnavailableCardReader implements CardReader {
  const UnavailableCardReader();

  @override
  Future<CardReaderAvailability> availability() async {
    // The platform distinction is real and worth stating: on iOS this needs
    // Apple's approval, not just a library.
    final reason = Platform.isIOS
        ? 'Tap to Pay on iPhone needs Apple approval for this account. '
            'Card payments will switch on once that is in place.'
        : 'Card reading needs the certified reader to be installed. '
            'Card payments will switch on once that is in place.';
    return CardReaderAvailability(available: false, reason: reason);
  }

  @override
  Future<CardReadResult> readCard({
    required int amountMinor,
    required String currency,
    required String reference,
  }) async =>
      const CardReadResult(
        success: false,
        error: 'No certified card reader is installed on this device.',
      );

  @override
  Future<void> cancel() async {}
}
