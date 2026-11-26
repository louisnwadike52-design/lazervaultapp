/// Vendor Campaigns — the shapes the UI works in.
///
/// MONEY IS KOBO (int) EVERYWHERE IN THIS FILE, matching the wire and the
/// backend. There is no naira field: conversion happens once, at render time,
/// through CurrencySymbols. A `double amountNaira` here is exactly how a 100x
/// error gets into a screen.
library;

/// Whether the signed-in user may scan, and what they are owed.
class VendorStatus {
  const VendorStatus({
    this.isVendor = false,
    this.isActive = false,
    this.vendorId = '',
    this.displayName = '',
    this.businessName = '',
    this.status = '',
    this.activeCampaigns = 0,
    this.outstandingKobo = 0,
    this.answered = false,
  });

  final bool isVendor;
  final bool isActive;
  final String vendorId;
  final String displayName;
  final String businessName;
  final String status;
  final int activeCampaigns;
  final int outstandingKobo;

  /// Whether the SERVER actually answered.
  ///
  /// WITHOUT THIS, A FAILURE AND A "NO" ARE THE SAME VALUE — and they must not
  /// be, because they call for opposite behaviour. "You are not a vendor" is
  /// settled and worth remembering for the session; "the call did not get
  /// through" is not an answer at all and has to be asked again.
  ///
  /// Conflating them hid the tile from a freshly enrolled vendor for an entire
  /// session: one failed status call at launch — a cold gateway, a token not
  /// yet refreshed, a moment of no signal — latched the refresher as though it
  /// had been told "no", and nothing asked again until the app was killed and
  /// reopened.
  final bool answered;

  /// The default is "not a vendor" AND "nobody answered". A failed call lands
  /// here, so the tile hides rather than opening a scanner that every attempt
  /// would be refused — while `answered: false` keeps the question open.
  static const VendorStatus unknown = VendorStatus();
}

/// One promotion at one venue.
class VendorCampaign {
  const VendorCampaign({
    required this.id,
    required this.name,
    required this.currency,
    required this.unitAmountKobo,
    required this.maxRedemptions,
    required this.redeemedCount,
    required this.remainingRedemptions,
    required this.accruedAmountKobo,
    required this.paidOutKobo,
    required this.outstandingKobo,
    required this.status,
    required this.startsAt,
    required this.endsAt,
    // Defaulted, not required: a server that predates the field sends nothing
    // and the campaign reads as the narrow rule — which is what it is.
    this.uniquenessScope = 'campaign',
    this.closeReason = '',
  });

  final String id;
  final String name;
  final String currency;
  final int unitAmountKobo;
  final int maxRedemptions;
  final int redeemedCount;
  final int remainingRedemptions;
  final int accruedAmountKobo;
  final int paidOutKobo;
  final int outstandingKobo;
  final String status;
  final DateTime startsAt;
  final DateTime endsAt;

  /// WHO a customer must be unique to: "campaign" (once per this campaign) or
  /// "vendor" (once per vendor, across every campaign they run).
  ///
  /// Carried so the scan sheet can say WHICH rule refused someone. "Already
  /// served" means two different things, and a door attendant who tells a
  /// customer the wrong one is in an argument neither can settle — the
  /// customer knows they were not here tonight, and the attendant is looking
  /// at a screen that says they were served.
  final String uniquenessScope;

  /// Whether this campaign counts a customer against the VENDOR.
  ///
  /// Only the exact "vendor" widens it — the same fallback direction the
  /// server takes, so the two cannot disagree about which rule is in force.
  bool get isVendorScoped => uniquenessScope == 'vendor';
  final String closeReason;

  /// Whether the SERVER would currently accept a scan.
  ///
  /// The client's view is advisory only — every scan is re-checked against the
  /// server's clock. This exists to decide whether to offer the button, never
  /// to decide whether a scan counts.
  bool get looksScannable {
    if (status != 'active' && status != 'scheduled') return false;
    final now = DateTime.now();
    return !now.isBefore(startsAt) &&
        now.isBefore(endsAt) &&
        redeemedCount < maxRedemptions;
  }

  bool get isScheduled =>
      status == 'scheduled' && DateTime.now().isBefore(startsAt);

  /// Whether earnings can be withdrawn.
  ///
  /// MIRRORS THE SERVER'S WHOLE RULE, not just its status list.
  ///
  /// WithdrawCampaignEarnings accepts a campaign whose WINDOW HAS ENDED even
  /// when the status still reads `active`: it relabels it on the spot rather
  /// than making the vendor wait on a tick. This used to check the status
  /// alone, and there is no worker that closes an expired campaign — so a
  /// session that ran out at 11pm stayed `active`, the Withdraw control stayed
  /// hidden, and the vendor had no way to ask for money the server would
  /// happily have paid. The one screen that could start the payout was the one
  /// deciding it was not allowed.
  ///
  /// `endsAt` is the server's own timestamp, so this compares the same two
  /// things the server compares.
  bool get isPayable =>
      status == 'closed' ||
      status == 'exhausted' ||
      status == 'cancelled' ||
      !DateTime.now().isBefore(endsAt);
}

/// One customer served.
class VendorRedemption {
  const VendorRedemption({
    required this.id,
    required this.customerUserId,
    required this.customerName,
    required this.customerUsername,
    required this.amountKobo,
    required this.currency,
    required this.scannedAt,
  });

  final String id;
  final String customerUserId;
  final String customerName;
  final String customerUsername;
  final int amountKobo;
  final String currency;
  final DateTime scannedAt;
}

/// The result of a scan.
class RedeemOutcome {
  const RedeemOutcome({
    required this.redemptionId,
    required this.alreadyServed,
    required this.servedAt,
    required this.customerName,
    required this.customerUsername,
    required this.amountKobo,
    required this.currency,
    required this.redeemedCount,
    required this.maxRedemptions,
    required this.remainingRedemptions,
    required this.campaignStatus,
  });

  final String redemptionId;

  /// TRUE when this customer was already served on this campaign.
  ///
  /// A NORMAL OUTCOME, not an error. Two tills scanning one customer within
  /// seconds of each other is ordinary at a busy door, and the UI says
  /// "already served at 19:42" rather than showing a failure.
  final bool alreadyServed;

  final DateTime? servedAt;
  final String customerName;
  final String customerUsername;
  final int amountKobo;
  final String currency;
  final int redeemedCount;
  final int maxRedemptions;
  final int remainingRedemptions;
  final String campaignStatus;
}

/// The result of a withdrawal.
class VendorPayout {
  const VendorPayout({
    required this.payoutId,
    required this.amountKobo,
    required this.currency,
    required this.reference,
    required this.status,
    required this.alreadyPaid,
    this.paidAt,
  });

  final String payoutId;
  final int amountKobo;
  final String currency;
  final String reference;
  final String status;
  final bool alreadyPaid;
  final DateTime? paidAt;
}
