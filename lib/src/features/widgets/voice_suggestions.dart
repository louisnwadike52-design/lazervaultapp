/// Service-specific voice command suggestions for all LazerVault services
///
/// This class provides predefined voice command suggestions for each of the 37 services
/// in the LazerVault platform, helping users discover what they can do with voice commands.
class VoiceSuggestions {
  /// Get voice command suggestions for a specific service
  static List<String> getSuggestions(String serviceName) {
    return _serviceSuggestions[serviceName] ?? _defaultSuggestions;
  }

  /// Default suggestions when service is not found
  static const List<String> _defaultSuggestions = [
    'What can I do here?',
    'Show my recent activity',
    'Help me get started',
  ];

  /// Service-specific voice command suggestions
  static const Map<String, List<String>> _serviceSuggestions = {
    // CATEGORY 1: CORE BANKING & TRANSFERS
    'auth': [
      'Login to my account',
      'Reset my password',
      'Enable two-factor authentication',
      'Update my profile',
      'Verify my email address',
    ],

    'accounts': [
      'Show all my accounts',
      'What is my account balance?',
      'Create a new savings account',
      'View my account transactions',
      'Freeze my account',
    ],

    'deposits': [
      'Make a deposit of 500 dollars',
      'Show my recent deposits',
      'Check deposit status',
      'View deposit history',
    ],

    'withdrawals': [
      'Withdraw 200 dollars',
      'Show my withdrawal history',
      'Check withdrawal status',
      'View pending withdrawals',
    ],

    'transfers': [
      'Send 50 dollars to John',
      'Transfer money to savings',
      'Show recent transfers',
      'Schedule a transfer for next week',
      'View transfer history',
    ],

    'recipients': [
      'Show my recipients',
      'Add a new recipient',
      'Find recipient named Sarah',
      'Delete a recipient',
      'Update recipient details',
    ],

    'facial': [
      'Enroll my face for recognition',
      'Verify my identity',
      'Login with face recognition',
      'Update my facial data',
    ],

    'user': [
      'Show my profile',
      'Update my email address',
      'Change my password',
      'Update my phone number',
      'View my settings',
    ],

    'cards': [
      'Show all my cards',
      'Block my card',
      'Request a new card',
      'Change my card PIN',
      'View card transactions',
      'Activate my card',
    ],

    // CATEGORY 2: INVESTMENTS
    'stocks': [
      'Show my stock portfolio',
      'Buy 10 shares of Apple',
      'What is the price of Tesla?',
      'Sell all my Microsoft shares',
      'Add Amazon to my watchlist',
      'Show my recent stock orders',
    ],

    'crypto': [
      'Buy 100 dollars worth of Bitcoin',
      'What is the price of Ethereum?',
      'Sell my Dogecoin',
      'Swap Bitcoin for Ethereum',
      'Show my crypto portfolio',
      'View my crypto wallets',
    ],

    'portfolio': [
      'Show my investment portfolio',
      'How is my portfolio performing?',
      'Show portfolio allocation',
      'View portfolio history',
    ],

    'analytics': [
      'Show investment performance analytics',
      'Analyze my investment risk',
      'Give me investment recommendations',
      'Show market trends',
    ],

    'exchange': [
      'What is the exchange rate for USD to NGN?',
      'Exchange 500 dollars to Naira',
      'Show exchange rates',
      'View exchange history',
    ],

    // CATEGORY 3: PAYMENTS & BILLING
    'invoices': [
      'Show all my invoices',
      'Create a new invoice',
      'Send invoice to client',
      'View paid invoices',
      'Delete an invoice',
    ],

    'invoice-payment': [
      'Pay my invoice',
      'Show invoice payment status',
      'View payment history',
    ],

    'tagpay': [
      'Pay using my tag',
      'Show my payment tags',
      'Create a new tag',
    ],

    'barcode': [
      'Pay with barcode',
      'Scan barcode for payment',
      'Show barcode payment history',
    ],

    'electricity': [
      'Buy 5000 Naira electricity',
      'Purchase prepaid meter token',
      'Show my meter number',
      'View electricity purchase history',
    ],

    'airtime': [
      'Buy 500 Naira airtime',
      'Purchase 2000 Naira data',
      'Buy airtime for 08012345678',
      'Show airtime purchase history',
    ],

    'bills': [
      'Show all my bills',
      'Pay my electricity bill',
      'Set up auto-pay for bills',
      'View unpaid bills',
      'Show bill payment history',
    ],

    'expenses': [
      'Show my expenses',
      'Add a new expense of 50 dollars',
      'Categorize my expenses',
      'View monthly expenses',
      'Show expense report',
    ],

    // CATEGORY 4: FINANCIAL PRODUCTS & SAVINGS
    'autosave': [
      'Set up automatic savings',
      'Save 100 dollars every week',
      'Show my savings rules',
      'Stop auto-save',
      'View savings history',
    ],

    'lockfunds': [
      'Lock 1000 dollars for 6 months',
      'Show my locked funds',
      'Check interest rate',
      'View locked funds maturity date',
    ],

    'crowdfund': [
      'Create a crowdfunding campaign',
      'Show active campaigns',
      'Contribute to a campaign',
      'View my contributions',
    ],

    'groups': [
      'Show my savings groups',
      'Create a new savings group',
      'Join a savings group',
      'Make group contribution',
      'View group balance',
    ],

    'insurance': [
      'Show available insurance products',
      'Get a quote for health insurance',
      'Purchase travel insurance',
      'File an insurance claim',
      'View my insurance policies',
    ],

    'loans': [
      'Apply for a loan',
      'Check my loan eligibility',
      'Show loan offers',
      'View repayment schedule',
      'Make a loan payment',
    ],

    'referrals': [
      'Get my referral code',
      'Refer a friend',
      'Show my referral earnings',
      'View referral history',
    ],

    'giftcards': [
      'Buy an Amazon gift card',
      'Show available gift cards',
      'Purchase 50 dollar iTunes card',
      'View gift card history',
    ],

    // CATEGORY 5: USER SERVICES & AI
    'support': [
      'Contact customer support',
      'Create a support ticket',
      'Show my support tickets',
      'View ticket status',
      'Chat with support',
    ],

    'contact-sync': [
      'Sync my contacts',
      'Show synced contacts',
      'Import contacts',
    ],

    'ai-chat': [
      'Chat with AI assistant',
      'Ask about my transactions',
      'Get financial advice',
    ],

    'ai-scan': [
      'Scan a receipt',
      'Extract text from document',
      'Scan invoice for payment',
    ],

    'statistics': [
      'Show my spending statistics',
      'View monthly income',
      'Show expense breakdown',
      'Display financial trends',
    ],

    'voice-session': [
      'Start voice session',
      'View active voice sessions',
      'End voice session',
    ],

    'statements': [
      'Download my bank statement',
      'Show account statement',
      'Get statement for last month',
      'Email my statement',
    ],
  };

  /// Get all available services
  static List<String> getAllServices() {
    return _serviceSuggestions.keys.toList();
  }

  /// Check if a service has custom suggestions
  static bool hasCustomSuggestions(String serviceName) {
    return _serviceSuggestions.containsKey(serviceName);
  }

  /// Get category-specific services
  static Map<String, List<String>> getServicesByCategory() {
    return {
      'Core Banking & Transfers': [
        'auth',
        'accounts',
        'deposits',
        'withdrawals',
        'transfers',
        'recipients',
        'facial',
        'user',
        'cards',
      ],
      'Investment & Trading': [
        'stocks',
        'crypto',
        'portfolio',
        'analytics',
        'exchange',
      ],
      'Payments & Billing': [
        'invoices',
        'invoice-payment',
        'tagpay',
        'barcode',
        'electricity',
        'airtime',
        'bills',
        'expenses',
      ],
      'Financial Products & Savings': [
        'autosave',
        'lockfunds',
        'crowdfund',
        'groups',
        'insurance',
        'loans',
        'referrals',
        'giftcards',
      ],
      'User Services & AI': [
        'support',
        'contact-sync',
        'ai-chat',
        'ai-scan',
        'statistics',
        'voice-session',
        'statements',
      ],
    };
  }
}
