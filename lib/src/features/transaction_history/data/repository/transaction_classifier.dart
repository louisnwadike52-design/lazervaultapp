import 'package:lazervault/core/types/unified_transaction.dart';

/// Pure classification logic for wallet transactions — extracted from
/// [TransactionHistoryRepositoryGrpc] so it can be unit-tested in isolation
/// (the repository itself needs gRPC/storage/account dependencies to construct).
///
/// The central problem these functions solve: accounts-service books MANY kinds
/// of charge as a hold + capture, and every captured row shares the SAME generic
/// ledger `category` of `hold_capture` (or `hold_capture_partial` /
/// `hold_capture_overage`). accounts-service also FORCES the capture reference to
/// `HOLD-CAP-…`, so the reference carries no domain signal. The only reliable
/// distinguisher is the capturing `service_name` (always stamped, required),
/// with the `description` as the secondary signal — and the ONLY signal for a
/// service that hosts more than one domain (exchange = currency-exchange vs
/// international-transfer; banking = refresh-fee vs withdrawal vs
/// deposit-reconciliation). Only `giftcards-service` legitimately maps to a
/// gift-card title; every other capture reading as "Gift Card Purchase" was a
/// bug.

/// Detects the true domain of a (possibly `hold_capture`) transaction.
///
/// Returns one of: 'crypto' | 'exchange' | 'transfer' | 'insurance' |
/// 'refresh_fee' | 'invoice' | 'rmb' | 'withdrawal' | 'giftcard' | ''.
/// Recovers the invoice UUID from a legacy fee ledger reference
/// (`IDEM-PW-unlock-<invoiceUUID>-<8hex>-FROM`) — the pre-reclassification
/// rows carry no metadata, but their idempotency key embeds the invoice id.
String? invoiceIdFromReference(String ref) => RegExp(
        r'^IDEM-PW-unlock-([0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})-')
    .firstMatch(ref)
    ?.group(1);

/// Recovers the gift-card reference (`GC-<uuid>`) from a ledger row. Gift-card
/// captures carry no metadata, but their description is
/// `Gift card purchase - GC-<uuid>` — enough to open the actual card (with its
/// code/PIN and shareable receipt) instead of a generic transfer receipt.
String? giftCardRefFromText(String description, String reference) {
  final re = RegExp(
      r'\b(GC-[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})\b');
  return re.firstMatch(description)?.group(1) ??
      re.firstMatch(reference)?.group(1);
}

String classifyDomain(String category, String description, String reference,
    [String serviceName = '']) {
  final svc = serviceName.toLowerCase();
  final s = '$category $description $reference'.toLowerCase();

  // Crypto REFUNDS (undeliverable buy auto-refund, send/swap reversals) are
  // fiat CREDITS from crypto-service — without this branch the generic
  // "credit ⇒ Crypto sell" heuristic mislabelled every refund as a sale.
  final looksCrypto = svc.contains('crypto') || s.contains('crypto');
  if (looksCrypto &&
      (s.contains('refund') || s.contains('revers') || s.contains('rollback'))) {
    return 'crypto_refund';
  }

  // Zero-amount crypto rows written EXPLICITLY into the unified history:
  // a crypto→crypto swap (category `crypto_convert`) and an outbound crypto
  // send (category `crypto_send`). Neither moves fiat, so the generic
  // credit⇒sell / debit⇒buy heuristic below mislabels them ("Crypto sell
  // +₦0.00" for a USDT→XRP swap). The category is authoritative.
  final cat = category.toLowerCase();
  if (cat.contains('crypto_convert')) return 'crypto_swap';
  if (cat.contains('crypto_send')) return 'crypto_send';

  // Invoice creation/unlock fee — a PLATFORM fee into the revenue ledger,
  // never a transfer. Must win before the core-payments⇒transfer branch:
  // legacy rows were stamped service_name=core-payments-service and category
  // service_fee, but their reference embeds the invoice UUID.
  if (cat == 'invoice_creation_fee' || cat == 'invoice_unlock_fee') {
    return 'invoice_fee';
  }
  if (cat == 'service_fee' &&
      (s.contains('invoice') || invoiceIdFromReference(reference) != null)) {
    return 'invoice_fee';
  }

  // 1) service_name is authoritative for the shared hold_capture bucket.
  if (svc.contains('giftcard')) return 'giftcard';
  if (svc.contains('crypto')) return 'crypto';
  if (svc.contains('rmb')) return 'rmb';
  if (svc.contains('invoice')) return 'invoice';
  if (svc.contains('core-payments')) return 'transfer';
  if (svc.contains('financial-products') || svc.contains('insurance')) {
    return 'insurance';
  }
  if (svc.contains('exchange')) {
    // exchange-service captures BOTH currency exchanges and international
    // transfers ("International transfer…"); the description separates them.
    return s.contains('transfer') ? 'transfer' : 'exchange';
  }
  if (svc.contains('banking')) {
    if (s.contains('balance refresh') || s.contains('refresh fee')) {
      return 'refresh_fee';
    }
    if (s.contains('withdraw')) return 'withdrawal';
    // Deposit reconciliation captures carry no strong signal — fall through.
  }

  // 2) Fallback to description/reference text when service_name is absent or
  // unrecognised (older rows, or a service not yet mapped above).
  if (s.contains('balance refresh') || s.contains('refresh fee')) {
    return 'refresh_fee';
  }
  if (s.contains('crypto') || s.contains('crypto-')) return 'crypto';
  if (s.contains('gift') || RegExp(r'\bgc-').hasMatch(s)) return 'giftcard';
  if (s.contains('insurance') || RegExp(r'\bins-').hasMatch(s)) return 'insurance';
  if (s.contains('rmb')) return 'rmb';
  if (s.contains('invoice')) return 'invoice';
  if (s.contains('exchange')) return 'exchange';
  // External bank transfers capture a hold too (category 'hold_capture',
  // description "Transfer to {name}", metadata.reference "TRF-…").
  if (s.contains('transfer') || s.contains('trf-') || s.contains('c2c-')) {
    return 'transfer';
  }
  return '';
}

/// User-facing title for a [classifyDomain] domain. Returns null when the domain
/// has no special title and the caller should fall back to category logic.
String? titleForDomain(String domain, String typeLower) {
  final credit = typeLower == 'credit';
  switch (domain) {
    case 'crypto':
      // Wallet history only shows the fiat legs: a debit is a BUY, a credit a
      // SELL (swap/send never touch the fiat wallet).
      return credit ? 'Crypto sell' : 'Crypto buy';
    case 'crypto_refund':
      return 'Crypto refund';
    case 'crypto_swap':
      return 'Crypto swap';
    case 'crypto_send':
      return 'Crypto send';
    case 'exchange':
      return 'Currency Exchange';
    case 'insurance':
      // A wallet credit on the insurance domain is a premium refund/reversal,
      // not a payment.
      return credit ? 'Insurance Refund' : 'Insurance Payment';
    case 'refresh_fee':
      return credit ? 'Balance Refresh Fee Refund' : 'Balance Refresh Fee';
    case 'invoice_fee':
      return credit ? 'Invoice Fee Refund' : 'Invoice Creation Fee';
    case 'invoice':
      return credit ? 'Invoice Received' : 'Invoice Payment';
    case 'rmb':
      return credit ? 'RMB Transfer Received' : 'RMB Transfer';
    case 'transfer':
      return credit ? 'Transfer Received' : 'Transfer Sent';
    case 'withdrawal':
      return 'Account Withdrawal';
    case 'giftcard':
      return credit ? 'Gift Card Refund' : 'Gift Card Purchase';
    default:
      return null;
  }
}

/// Maps a [classifyDomain] domain to its [TransactionServiceType]. Returns null
/// when the domain doesn't correspond to a concrete service type.
TransactionServiceType? serviceTypeForDomain(String domain) {
  switch (domain) {
    case 'crypto':
    case 'crypto_refund':
    case 'crypto_swap':
    case 'crypto_send':
      return TransactionServiceType.crypto;
    case 'exchange':
      return TransactionServiceType.exchange;
    case 'insurance':
      return TransactionServiceType.insurance;
    case 'refresh_fee':
      return TransactionServiceType.fee;
    case 'invoice_fee':
      // Reuse the EXISTING fee enum value — the history cache persists enum
      // indices, so inserting/reordering values corrupts cached rows.
      return TransactionServiceType.fee;
    case 'invoice':
      return TransactionServiceType.invoice;
    case 'rmb':
      return TransactionServiceType.rmb;
    case 'transfer':
      return TransactionServiceType.transfer;
    case 'withdrawal':
      return TransactionServiceType.withdrawal;
    case 'giftcard':
      return TransactionServiceType.giftCard;
    default:
      return null;
  }
}

/// Generate a user-friendly transaction title.
String generateTransactionTitle(
    String category, String type, String description, String reference,
    [String serviceName = '']) {
  final categoryLower = category.toLowerCase();
  final typeLower = type.toLowerCase();

  // Gift-card SALE (selling a card for cash — a credit) is a distinct flow
  // keyed by its own category. Resolve it before the 'giftcard' domain below,
  // which can't tell a sale from a purchase-refund and would call it a refund.
  if (categoryLower.contains('gift_card_sell') ||
      categoryLower.contains('sell_payout')) {
    return 'Gift Card Sale';
  }

  // Resolve the true domain FIRST. The shared `hold_capture` bucket is keyed
  // apart by service_name (see [classifyDomain]); any capture that isn't
  // giftcards previously fell through to the generic hold_capture→
  // "Gift Card Purchase" rule below.
  final domain = classifyDomain(category, description, reference, serviceName);
  final domainTitle = titleForDomain(domain, typeLower);
  if (domainTitle != null) return domainTitle;

  if (looksLikeEPinRef(reference) ||
      categoryLower.contains('epin') ||
      _textOf(description, category).contains('recharge card')) {
    return typeLower == 'credit'
        ? 'Recharge Card Refund'
        : 'Recharge Card Purchase';
  } else if (looksLikeBettingRef(reference) ||
      categoryLower.contains('betting') ||
      _textOf(description, category).contains('betting')) {
    return typeLower == 'credit' ? 'Betting Refund' : 'Betting Wallet Funding';
  } else if (categoryLower.contains('airtime')) {
    return typeLower == 'credit' ? 'Airtime Top-up' : 'Airtime Purchase';
  } else if (categoryLower.contains('transfer') ||
      classifyDomain(category, description, reference) == 'transfer') {
    return typeLower == 'credit' ? 'Transfer Received' : 'Transfer Sent';
  } else if (categoryLower.contains('hold_capture')) {
    // Reached only when the shared hold_capture bucket couldn't be resolved to
    // a domain above (unmapped/older row with no service_name and a bland
    // description, e.g. a deposit reconciliation). Giftcards are titled via the
    // 'giftcard' domain — DON'T assume giftcard here; use a neutral label.
    return typeLower == 'credit' ? 'Refund' : 'Payment';
  } else if (categoryLower.contains('gift')) {
    return typeLower == 'credit' ? 'Gift Card Refund' : 'Gift Card Purchase';
  } else if (categoryLower.contains('electricity')) {
    return 'Electricity Bill Payment';
  } else if (categoryLower.contains('deposit')) {
    return 'Account Deposit';
  } else if (categoryLower.contains('withdrawal')) {
    return 'Account Withdrawal';
  } else if (categoryLower.contains('invoice')) {
    return typeLower == 'credit' ? 'Invoice Received' : 'Invoice Payment';
  } else if (categoryLower.contains('crypto')) {
    return typeLower == 'credit' ? 'Crypto Sale' : 'Crypto Purchase';
  } else if (categoryLower.contains('stock')) {
    return typeLower == 'credit' ? 'Stock Sale' : 'Stock Purchase';
  } else if (categoryLower.contains('insurance')) {
    return 'Insurance Payment';
  } else if (categoryLower.contains('tag')) {
    return typeLower == 'credit' ? 'Tag Payment Received' : 'Tag Payment Sent';
  } else if (categoryLower.contains('barcode')) {
    return 'Barcode Payment';
  } else if (categoryLower.contains('crowdfund') ||
      categoryLower.contains('donation')) {
    return 'Donation';
  } else if (categoryLower.contains('autosave') ||
      categoryLower.contains('auto_save')) {
    return 'AutoSave Deposit';
  } else if (categoryLower.contains('water')) {
    return 'Water Bill Payment';
  } else if (categoryLower.contains('tv') ||
      categoryLower.contains('subscription')) {
    return 'TV Subscription';
  } else {
    return typeLower == 'credit' ? 'Credit' : 'Debit';
  }
}

/// Infer service type from category when service_name is empty (or unmapped).
TransactionServiceType inferServiceTypeFromCategory(
    String category, String type, String description, String reference,
    [String serviceName = '']) {
  final cat = category.toLowerCase();
  // Disambiguate the shared 'hold_capture' bucket by content FIRST (via
  // service_name + description) so a crypto/FX/insurance/invoice/RMB/fee/
  // transfer capture isn't misclassified as a giftcard.
  final domain = classifyDomain(category, description, reference, serviceName);
  final domainType = serviceTypeForDomain(domain);
  if (domainType != null) return domainType;

  // A real gift-card CATEGORY (not the shared hold_capture bucket, which is
  // handled by the 'giftcard' domain above) still maps to giftCard.
  if (cat.contains('gift_card') || cat.contains('giftcard')) {
    return TransactionServiceType.giftCard;
  } else if (looksLikeEPinRef(reference) ||
      cat.contains('epin') ||
      _textOf(description, category).contains('recharge card')) {
    return TransactionServiceType.epin;
  } else if (looksLikeBettingRef(reference) ||
      cat.contains('betting') ||
      _textOf(description, category).contains('betting')) {
    return TransactionServiceType.betting;
  } else if (cat.contains('airtime')) {
    return TransactionServiceType.airtime;
  } else if (cat.contains('electricity')) {
    return TransactionServiceType.electricity;
  } else if (cat.contains('deposit') || (type == 'credit' && cat.contains('fund'))) {
    return TransactionServiceType.deposit;
  } else if (cat.contains('withdrawal')) {
    return TransactionServiceType.withdrawal;
  } else if (cat.contains('tag')) {
    return TransactionServiceType.tagPay;
  } else if (cat.contains('invoice')) {
    return TransactionServiceType.invoice;
  } else if (cat.contains('crypto')) {
    return TransactionServiceType.crypto;
  } else if (cat.contains('insurance')) {
    return TransactionServiceType.insurance;
  }
  return TransactionServiceType.unknown;
}

String _textOf(String description, String category) =>
    '${description.toLowerCase()} ${category.toLowerCase()}';

/// ePIN references are minted as `EPIN-...` (holds as `HOLD-EPIN-...`,
/// reversals as `REV-EPIN-...`), so the prefix is authoritative.
bool looksLikeEPinRef(String reference) {
  final r = reference.toLowerCase();
  return r.startsWith('epin') ||
      r.startsWith('hold-epin') ||
      r.contains('-epin-') ||
      r.contains('epin');
}

/// Betting-wallet funding references are minted as `BET-...`.
bool looksLikeBettingRef(String reference) {
  final r = reference.toLowerCase();
  return r.startsWith('bet-') ||
      r.startsWith('hold-bet-') ||
      r.contains('-bet-');
}

/// True when a reference looks like it belongs to any utility-payments bill —
/// used to trigger disambiguation even if service_name wasn't stamped.
bool looksLikeUtilityRef(String reference) {
  return looksLikeEPinRef(reference) || looksLikeBettingRef(reference);
}

/// The utility-payments family (airtime/data/electricity/water/tv/internet/
/// education/epin/betting) shares ONE backend service name, so mapping by
/// service name alone collapses them all onto the first match (electricity).
/// Refine to the specific bill type using the reference prefix (authoritative)
/// then the description/category text. Only acts on utility/unknown inputs and
/// only when it finds a positive signal, so it never mislabels other services.
TransactionServiceType refineUtilityServiceType(
  TransactionServiceType current,
  String reference,
  String description,
  String category,
) {
  const utility = {
    TransactionServiceType.electricity,
    TransactionServiceType.airtime,
    TransactionServiceType.data,
    TransactionServiceType.water,
    TransactionServiceType.tvSubscription,
    TransactionServiceType.internet,
    TransactionServiceType.education,
    TransactionServiceType.betting,
    TransactionServiceType.epin,
    TransactionServiceType.unknown,
  };
  if (!utility.contains(current)) return current;

  final text = _textOf(description, category);
  bool has(String kw) => text.contains(kw);

  // Reference prefixes are authoritative.
  if (looksLikeEPinRef(reference) || has('recharge card') || has('epin')) {
    return TransactionServiceType.epin;
  }
  if (looksLikeBettingRef(reference) || has('betting')) {
    return TransactionServiceType.betting;
  }
  if (has('airtime')) return TransactionServiceType.airtime;
  if (has('data bundle') || has('data plan') || has('mobile data')) {
    return TransactionServiceType.data;
  }
  if (has('electricity') || has('meter') || has('prepaid') || has('postpaid')) {
    return TransactionServiceType.electricity;
  }
  if (has('water')) return TransactionServiceType.water;
  if (has('cable') ||
      has('dstv') ||
      has('gotv') ||
      has('startimes') ||
      has('tv subscription')) {
    return TransactionServiceType.tvSubscription;
  }
  if (has('internet') || has('broadband')) {
    return TransactionServiceType.internet;
  }
  if (has('education') || has('waec') || has('jamb')) {
    return TransactionServiceType.education;
  }
  return current;
}
