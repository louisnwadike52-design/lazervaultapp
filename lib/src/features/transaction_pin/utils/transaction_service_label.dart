/// Central `transactionType → friendly service noun` mapper for the shared
/// transaction-PIN bottom sheet.
///
/// Bill-payment and other non-transfer flows all pass a [transactionType] into
/// `validateTransactionPin` (e.g. `airtime_purchase`, `cable_tv_purchase`).
/// The tx-PIN sheet used to hardcode a transfer-shaped "Your transfer is being
/// processed" subtitle for EVERY flow — wrong for a bill. This mapper turns the
/// type into a service-appropriate noun so the sheet can render
/// "Your {noun} is being processed" / "Your {noun} was successful".
///
/// Mirrors `linkedBalanceRefreshFailureMessage` (one shared function so every
/// surface reads consistently).
///
/// Returns `null` for the transfer family and any type we deliberately leave on
/// the sheet's existing transfer copy, so those flows are byte-for-byte
/// unchanged. Genuinely-unknown types fall through to the generic
/// [kGenericServiceNoun] ("payment") so a new/unmapped service still reads
/// sensibly rather than mislabelling itself a "transfer".
library;

/// Generic fallback noun for a recognised-but-unmapped non-transfer charge.
const String kGenericServiceNoun = 'payment';

/// Transfer-family transaction types that must keep the sheet's ORIGINAL
/// transfer copy ("Your transfer is being processed"). Returning `null` for
/// these leaves the modal on its existing default — nothing changes for money
/// transfers, batch transfers, cross-border, P2P/QR/tag, etc.
const Set<String> _transferFamilyTypes = {
  'transfer',
  'batch_transfer',
  'move_money_transfer',
  'fund transfer',
  'international_transfer',
  'rmb_transfer',
  'airtime_transfer',
  'tag_payment',
  'qr_payment',
  'contactless_payment',
  'crypto_send',
  'crypto transaction',
  'id_pay_payment',
  'PayID payment request',
  // Deposit / withdrawal are money-in/out flows; leave their copy untouched.
  'deposit',
  'withdrawal',
};

/// Explicit bill/service → friendly noun map. Reads naturally in the sentence
/// "Your {noun} is being processed" / "Your {noun} was successful".
const Map<String, String> _serviceNouns = {
  // Airtime & data
  'airtime_purchase': 'airtime purchase',
  'data_purchase': 'data purchase',
  'intl_airtime_purchase': 'international airtime purchase',
  'intl_data_purchase': 'international data purchase',
  'airtime_to_cash': 'airtime-to-cash',
  // Power
  'electricity_purchase': 'electricity payment',
  // TV / cable
  'cable_tv_purchase': 'cable subscription',
  'cable_subscription': 'cable subscription',
  // Internet
  'internet_purchase': 'internet subscription',
  'internet_bill': 'internet subscription',
  // Water
  'water_purchase': 'water bill payment',
  'water_bill_payment': 'water bill payment',
  // Education
  'education_purchase': 'education payment',
  // ePIN / betting
  'epin_purchase': 'ePIN purchase',
  'betting_funding': 'betting wallet funding',
  // Generic bill hub entries
  'bill_payment': 'bill payment',
  'purchase': 'purchase',
};

/// Map a [transactionType] to a friendly service noun for the tx-PIN sheet.
///
/// - Known bill/service type → its specific noun (e.g. "airtime purchase").
/// - Transfer-family type → `null` (sheet keeps its existing transfer copy).
/// - Anything else (incl. `null`/empty) → `null` so the modal decides whether
///   to fall back; use [transactionServiceNounOrGeneric] when you want the
///   "payment" fallback applied.
String? transactionServiceNoun(String? transactionType) {
  if (transactionType == null || transactionType.trim().isEmpty) return null;
  return _serviceNouns[transactionType];
}

/// True when [transactionType] is part of the transfer family and must retain
/// the sheet's original transfer copy.
bool isTransferFamilyType(String? transactionType) =>
    transactionType != null && _transferFamilyTypes.contains(transactionType);
