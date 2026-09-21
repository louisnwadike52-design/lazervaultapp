/// The one place the app turns a raw ledger category or service name into a
/// label a person reads.
///
/// WHY THIS EXISTS
/// ---------------
/// The backend already resolves categories through a closed vocabulary
/// (accounts-service `transaction_categories.go`), but several screens received
/// raw values on other paths (failed-transaction rows, proto enum names) and
/// each had its OWN normaliser. Those normalisers ended in a title-case
/// fallback:
///
/// ```dart
/// _ => raw.replaceAll('_', ' ').split(' ').map(capitalise).join(' ')
/// ```
///
/// which does not remove the leak, it only dresses it up: `hold_capture`
/// became "Hold Capture", `crypto-service` became "Crypto Service" and
/// `e2e-harness` became "E2e Harness". Users saw internal jargon, and the same
/// strings were sent to the AI as their spending profile.
///
/// THE RULE
/// --------
/// The vocabulary is CLOSED and matches the backend's. Anything unrecognised
/// resolves to 'Other' rather than being echoed back in prettier clothing. A
/// settlement rail (`hold_capture`, `lock_funds`) describes how money settled,
/// never what the user did, so it resolves to the real activity.
///
/// Keep this list in step with `displayCategoryExpr` in
/// accounts-service/internal/repository/transaction_categories.go.
class TransactionCategoryLabels {
  const TransactionCategoryLabels._();

  /// Labels the backend can legitimately produce. A value already in this set
  /// passes through untouched.
  static const Set<String> known = {
    'Transfers',
    'International Transfers',
    'Deposits',
    'Withdrawals',
    'Payments',
    'Bills & Utilities',
    'Banking',
    'Crypto',
    'Gift Cards',
    'Escrow',
    'Currency Exchange',
    'Group Funds',
    'Family & Friends',
    'TagPay',
    'Invoices',
    'Savings & Products',
    'Investments',
    'Payroll',
    'Crowdfunding',
    'Service Fees',
    'Reversals',
    'Refunds',
    'Interest Earned',
    'Adjustments',
    'Food & Drinks',
    'Shopping',
    'Transportation',
    'Entertainment',
    'Healthcare',
    'Education',
    'Travel',
    'Groceries',
    'Rent & Mortgage',
    'Insurance',
    'Gifts & Donations',
    'Personal Care',
    'Subscriptions',
    'Other',

    // Sub-category labels (the drill-down inside a category). Listed here so a
    // value the backend already resolved passes through untouched instead of
    // collapsing to 'Other'. Mirrors subCategoryExpr.
    'P2P Transfers',
    'Bank Transfers',
    'Batch Transfers',
    'Money Sent',
    'Money Received',
    'Bank Withdrawals',
    'Bank Deposits',
    'Card Deposits',
    'Airtime',
    'Data',
    'Electricity',
    'Cable TV',
    'Water',
    'Internet',
    'International Top-ups',
    'Other Bills',
    'Bill Refunds',
    'Crypto Sales',
    'Crypto Purchases',
    'Crypto Swaps',
    'Crypto Sent',
    'Crypto Received',
    'Crypto Refunds',
    'Gift Card Sales',
    'Gift Card Purchases',
    'Escrow Funding',
    'Escrow Released',
    'Exchange Proceeds',
    'AutoSave',
    'AutoSave Fees',
    'PiggyVault Locks',
    'Matured Savings',
    'Savings',
    'Crowdfund Refunds',
    'Contactless Payments',
    'PayID Payments',
    'PayID Fees',
    'Tag Payments',
    'Salary Payments',
    'Invoice Fees',
    'Batch Transfer Fees',
    'Bank Refresh Fees',
    'Stocks',
    'Mutual Funds',
  };

  static const Map<String, String> _byRawValue = {
    // Settlement rails and internal lock states resolve to the real activity.
    'hold_capture': 'Other',
    'hold_capture_overage': 'Other',
    'lock_funds': 'Savings & Products',
    'lock_funds_autosave': 'Savings & Products',
    'auto_save': 'Savings & Products',
    'autosave': 'Savings & Products',
    'force_mature': 'Savings & Products',
    'piggyvault': 'Savings & Products',
    'piggy vault': 'Savings & Products',
    'lock funds': 'Savings & Products',
    'upfront_interest': 'Interest Earned',
    'interest': 'Interest Earned',

    // Activity categories.
    'transfer': 'Transfers',
    'transfer_in': 'Transfers',
    'transfer_out': 'Transfers',
    'c2c_transfer': 'Transfers',
    'domestic_transfer': 'Transfers',
    'international_transfer': 'International Transfers',
    'batch_transfer_service_fee': 'Service Fees',
    'deposit': 'Deposits',
    'card_deposit': 'Deposits',
    'withdrawal': 'Withdrawals',
    'payment': 'Payments',
    'purchase': 'Payments',
    'invoice_payment': 'Payments',
    'invoice_creation_fee': 'Service Fees',
    'autosave_fee': 'Service Fees',
    'id_pay_fee': 'Service Fees',
    'fee': 'Service Fees',
    'reversal': 'Reversals',
    'refund': 'Refunds',
    'crypto_buy_refund': 'Refunds',
    'bill_payment_refund': 'Refunds',
    'crowdfund_refund': 'Refunds',
    'adjustment': 'Adjustments',
    'airtime': 'Bills & Utilities',
    'data': 'Bills & Utilities',
    'electricity': 'Bills & Utilities',
    'cable_tv': 'Bills & Utilities',
    'bill_payment': 'Bills & Utilities',
    'crypto_sell_proceeds': 'Crypto',
    'crypto_send': 'Crypto',
    'crypto_receive': 'Crypto',
    'crypto_convert': 'Crypto',
    'escrow_fund': 'Escrow',
    'escrow_release': 'Escrow',
    'crowdfund_contribution': 'Crowdfunding',
    'giftcard_sale_payout': 'Gift Cards',
    'test_seed': 'Other',

    // Service identifiers. A deployment detail is never a spending category.
    'core-payments-service': 'Transfers',
    'core-payments': 'Transfers',
    'core-payments-batch-transfer': 'Transfers',
    'banking-service': 'Banking',
    'invoice-service': 'Invoices',
    'giftcards-service': 'Gift Cards',
    'gift-cards': 'Gift Cards',
    'gift_card': 'Gift Cards',
    'giftcards': 'Gift Cards',
    'utility-payments-service': 'Bills & Utilities',
    'tag-pay-service': 'TagPay',
    'tag-pay': 'TagPay',
    'financial-products-service': 'Savings & Products',
    'investments-service': 'Investments',
    'investment': 'Investments',
    'investments': 'Investments',
    'payroll-service': 'Payroll',
    'crowdfund-service': 'Crowdfunding',
    'crypto-service': 'Crypto',
    'escrow-service': 'Escrow',
    'exchange-service': 'Currency Exchange',
    'contactless-payment-service': 'Payments',
    'id-pay-service': 'Payments',
    'group-accounts-service': 'Group Funds',
    'family-accounts-service': 'Family & Friends',
    'accounts-service': 'Other',
    'e2e-harness': 'Other',
  };

  /// Resolves any raw category or service string to a label a person reads.
  ///
  /// Unrecognised input becomes 'Other'. It is never title-cased and echoed
  /// back: "Hold Capture" is no more meaningful to a user than `hold_capture`,
  /// and passing either to the AI describes the plumbing rather than the
  /// person's spending.
  static String displayLabel(String? raw) {
    final value = (raw ?? '').trim();
    if (value.isEmpty) return 'Other';
    if (known.contains(value)) return value;

    final lower = value.toLowerCase();
    final mapped = _byRawValue[lower];
    if (mapped != null) return mapped;

    // Case-insensitive match against the known vocabulary, so 'transfers' and
    // 'Transfers' agree.
    for (final label in known) {
      if (label.toLowerCase() == lower) return label;
    }
    return 'Other';
  }

  /// True when [raw] carries real meaning for a person. Internal rails and
  /// unmapped identifiers do not, so callers can drop them from AI context
  /// rather than describing the plumbing.
  static bool isMeaningful(String? raw) => displayLabel(raw) != 'Other';

  /// Turns a protobuf enum name into readable words.
  ///
  /// Unlike a raw ledger category, a proto enum NAMES a concept the user
  /// recognises, so it should be read out rather than dropped:
  /// `GOAL_TYPE_EMERGENCY_FUND` is "Emergency Fund" and
  /// `ALERT_TYPE_BUDGET_EXCEEDED` is "Budget Exceeded". Sending the raw form to
  /// the AI, as these call sites used to, describes the schema instead.
  ///
  /// `*_UNSPECIFIED` carries no information and returns an empty string so
  /// callers can omit the field rather than tell the model "Unspecified".
  static String humaniseEnumName(String? raw) {
    var value = (raw ?? '').trim();
    if (value.isEmpty) return '';

    // Drop the generated type prefix: GOAL_TYPE_X, ALERT_TYPE_X,
    // BUDGET_CATEGORY_X all keep only the part that names the thing.
    for (final prefix in const [
      'GOAL_TYPE_',
      'ALERT_TYPE_',
      'BUDGET_CATEGORY_',
      'CATEGORY_',
      'TYPE_',
      'STATUS_',
    ]) {
      if (value.toUpperCase().startsWith(prefix)) {
        value = value.substring(prefix.length);
        break;
      }
    }
    if (value.toUpperCase() == 'UNSPECIFIED' || value.isEmpty) return '';

    final words = value
        .replaceAll('-', ' ')
        .replaceAll('_', ' ')
        .split(' ')
        .where((w) => w.isNotEmpty)
        .map((w) => '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}')
        .join(' ');

    // A humanised enum may still name a spending category, in which case the
    // closed vocabulary wins so the AI sees one spelling of each concept.
    final mapped = displayLabel(words);
    return mapped == 'Other' ? words : mapped;
  }
}
