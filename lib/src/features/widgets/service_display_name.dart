/// Human labels for the per-service routing slugs.
///
/// Every screen passes a ROUTING slug (`split_bills`, `p2p_chat`, `lockfunds`)
/// to the voice and chat entry points, because that slug is what pins the
/// session to a chat microservice. Anywhere one of those slugs is also *shown*
/// — a tooltip, a sheet title, a settings header — it has to be translated
/// first, or the user reads a database identifier.
///
/// The vocabulary is deliberately the same one the gateway uses for its
/// boundary copy (`DIRECT_ROUTE_NAMES` in `chat-agent-gateway/main.py`), so a
/// service is called the same thing whether the label is written by the app or
/// by the agent refusing an out-of-scope request.
///
/// Like the analytics category vocabulary, this is CLOSED at the point of use:
/// [serviceDisplayName] never returns a raw slug. An unmapped slug is
/// humanised rather than echoed, so the worst case is an imperfect label, not
/// a leaked identifier.
library;

const Map<String, String> _kServiceDisplayNames = {
  // Accounts
  'accounts': 'Accounts',
  'family_accounts': 'Family & Friends',
  'lockfunds': 'PiggyVault',
  'cards': 'Cards',
  'autosave': 'AutoSave',
  // Transfers
  'transfers': 'Transfers',
  'send_funds': 'Send Funds',
  'lazerbeam': 'LazerBeam',
  'exchange': 'Currency Exchange',
  'rmb': 'RMB Transfers',
  'ai-scan': 'Scan to Pay',
  'p2p_chat': 'Chat Assistant',
  // Banking
  'banking': 'Banking',
  'mandates': 'Direct Debits',
  'deposits': 'Deposits',
  // Investments
  'investments': 'Investments',
  'crypto': 'Crypto',
  'stocks': 'Stocks',
  'portfolio': 'Portfolio',
  // Commerce
  'tagpay': 'TagPay',
  'invoices': 'Invoices',
  'giftcards': 'Gift Cards',
  'qrpay': 'QR Pay',
  'idpay': 'IDPay',
  'split_bills': 'Split Bills',
  'escrow': 'Escrow',
  // Products
  'bills': 'Bills',
  'data': 'Data',
  'financial_products': 'Financial Products',
  'insurance': 'Insurance',
  'loans': 'Loans',
  // Groups
  'group_accounts': 'Joint Funds',
  'groups': 'Joint Funds',
  'crowdfund': 'Crowdfunding',
  'sprayme': 'LazerSpray',
  'lazerspray': 'LazerSpray',
  // Business
  'business': 'Business',
  'sales': 'Sales',
  'payroll': 'Payroll',
  'inventory': 'Inventory',
  'customers': 'Customer CRM',
  'tax': 'Tax Management',
  'expenses': 'Expense Tracking',
  // Other
  'statistics': 'Statistics',
  'analytics': 'Statistics',
  'notifications': 'Notifications',
  'planning': 'Plan My Day',
  'planmyday': 'Plan My Day',
  'lifestyle': 'Lifestyle',
};

/// The label to SHOW for a routing [slug]. Never returns the slug itself.
String serviceDisplayName(String slug) {
  final key = slug.trim();
  if (key.isEmpty) return 'Assistant';

  final mapped = _kServiceDisplayNames[key.toLowerCase()];
  if (mapped != null) return mapped;

  // Unmapped: humanise rather than echo. A new service that forgets to add
  // itself above still reads as words ("bill_pay" -> "Bill Pay").
  return key
      .split(RegExp(r'[_\-\s]+'))
      .where((w) => w.isNotEmpty)
      .map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase())
      .join(' ');
}
