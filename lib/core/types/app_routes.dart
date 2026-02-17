abstract class AppRoutes {
  static const String root = '/';
  static const String authCheck = '/auth-check';
  static const String onboarding = '/onboarding';
  static const String dashboard = '/dashboard';
  static const String home = '/home';
  static const String newCard = '/new-card';
  static const String cameraScan = '/camera-scan';
  static const String uploadImage = '/upload-image';
  static const String selectRecipient = '/select-recipient';
  static const String addRecipient = '/add-recipient';
  static const String qrScanner = '/qr-scanner';
  static const String myQRCode = '/my-qr-code';
  static const String splitBills = '/split-bills';
  static const String invoice = '/invoice';
  static const String invoiceList = '/invoice/list';
  static const String createInvoice = '/invoice/create';
  static const String invoiceDetails = '/invoice/details';
  static const String invoicePreview = '/invoice/preview';
  static const String invoicePayment = '/invoice/payment';
  static const String invoiceProcessing = '/invoice/processing';
static const String incomingTaggedInvoices = '/invoice/incoming-tagged';
  static const String outgoingTaggedInvoices = '/invoice/outgoing-tagged';
  static const String invoiceItemPayment = '/invoice/item-payment';
  static const String invoicePaymentReceipt = '/invoice/payment-receipt';
  static const String sendFunds = '/send-funds';
  static const String initiateSendFunds = '/initiate-send-funds';
  static const String chatbotTransfer = '/chatbot-transfer';
  static const String transferProcessing = '/transfer-processing';
  static const String transferProof = '/transfer-proof';
  static const String inputPin = '/input-pin';
  static const String sendFundReceipt = '/send-funds-receipts';
  static const String reviewFundsTransfer = '/review-funds-transfer';
  // Bills Hub Route
  static const String billsHub = '/bills';

  // Electricity Bill Payment Routes
  static const String electricityBillHome = '/electricity-bill';
  static const String electricityBillMeterInput = '/electricity-bill/meter-input';
  static const String electricityBillConfirmation = '/electricity-bill/confirmation';
  static const String electricityBillProcessing = '/electricity-bill/processing';
  static const String electricityBillReceipt = '/electricity-bill/receipt';
  static const String electricityBillHistory = '/electricity-bill/history';
  static const String electricityBillBeneficiaries = '/electricity-bill/beneficiaries';
  static const String electricityBillAddBeneficiary = '/electricity-bill/beneficiaries/add';
  static const String electricityBillAutoRecharge = '/electricity-bill/auto-recharge';
  static const String electricityBillCreateAutoRecharge = '/electricity-bill/auto-recharge/create';
  static const String electricityBillEditAutoRecharge = '/electricity-bill/auto-recharge/edit';
  static const String electricityBillReminders = '/electricity-bill/reminders';
  static const String electricityBillCreateReminder = '/electricity-bill/reminders/create';

  // Cable TV Routes
  static const String cableTVHome = '/cable-tv';
  static const String cableTVSmartCardInput = '/cable-tv/smart-card-input';
  static const String cableTVPackageSelection = '/cable-tv/package-selection';
  static const String cableTVPaymentConfirmation = '/cable-tv/payment-confirmation';
  static const String cableTVPaymentProcessing = '/cable-tv/payment-processing';
  static const String cableTVPaymentReceipt = '/cable-tv/payment-receipt';

  // Internet Bill Routes
  static const String internetBillHome = '/internet-bill';
  static const String internetAccountInput = '/internet-bill/account-input';
  static const String internetPackageSelection = '/internet-bill/package-selection';
  static const String internetPaymentConfirmation = '/internet-bill/payment-confirmation';
  static const String internetPaymentProcessing = '/internet-bill/payment-processing';
  static const String internetPaymentReceipt = '/internet-bill/payment-receipt';

  // Education PIN Routes
  static const String educationHome = '/education';
  static const String educationPurchase = '/education/purchase';
  static const String educationPaymentConfirmation = '/education/payment-confirmation';
  static const String educationPaymentProcessing = '/education/payment-processing';
  static const String educationPinResult = '/education/pin-result';

  // Water Bill Routes
  static const String waterBillHome = '/water-bill';
  static const String waterBillCustomerInput = '/water-bill/customer-input';
  static const String waterBillPaymentConfirmation = '/water-bill/payment-confirmation';
  static const String waterBillPaymentProcessing = '/water-bill/payment-processing';
  static const String waterBillPaymentReceipt = '/water-bill/payment-receipt';
  static const String waterBillHistory = '/water-bill/history';

  // Data Bundles Routes
  static const String dataBundlesHome = '/data-bundles';
  static const String dataBundlesPlanSelection = '/data-bundles/plan-selection';
  static const String dataBundlesRecipientInput = '/data-bundles/recipient-input';
  static const String dataBundlesPaymentConfirmation = '/data-bundles/payment-confirmation';
  static const String dataBundlesPaymentProcessing = '/data-bundles/payment-processing';
  static const String dataBundlesPaymentReceipt = '/data-bundles/payment-receipt';

  static const String flights = '/flights';
  static const String payInvoice = '/pay-invoice';
  static const String crypto = '/crypto';
  static const String stocks = '/stocks';
  static const String transactionHistory = '/transaction-history';

  // New Transaction History Routes (Redesigned)
  static const String dashboardTransactionHistory = '/transactions/dashboard';
  static const String serviceTransactionHistory = '/transactions/service';

  // WhatsApp Integration Routes
  static const String whatsappBanking = '/whatsapp-banking';
  static const String whatsappLinking = '/whatsapp-banking/linking';
  static const String whatsappSecurity = '/whatsapp-banking/security';
  static const String whatsappConfirm = '/whatsapp-banking/confirm';
  static const String reviewTransferFunds = '/review-transfer-funds';
  static const String profileSettings = '/profile-settings';
  static const String languages = '/profile-settings/languages';
  static const String myAccount = '/profile-settings/my-account';
  static const String setFingerPrint = '/profile-settings/set-fingerprint';
  static const String changePin = '/profile-settings/change-pin';
  static const String depositFunds = '/profile-settings/deposit-funds';
  static const String withdrawFunds = '/profile-settings/withdraw-funds';
  static const String cbCurrencyExchange = '/profile-settings/cb-currency-exchange';
  static const String currencyDeposit = '/currency-deposit';
  static const String currencyExchange = '/currency-exchange';
  static const String addCurrencyRecipient = '/currency-exchange/add-recipient';
  static const String currencyRecipientList = '/currency-exchange/recipients';
  static const String currencyTransactionHistory = '/currency-exchange/history';
  static const String rateCalculator = '/currency-exchange/calculator';
  static const String contactSelection = '/currency-exchange/contacts';
  
  // International Transfer Flow Routes
  static const String internationalTransferStart = '/international-transfer/start';
  static const String internationalTransferAmount = '/international-transfer/amount';
  static const String internationalTransferRecipient = '/international-transfer/recipient';
  static const String internationalTransferReview = '/international-transfer/review';
  static const String internationalTransferConfirm = '/international-transfer/confirm';
  static const String internationalTransferSuccess = '/international-transfer/success';
  
  // Deposit Flow Routes
  static const String depositMethodSelection = '/deposit/method-selection';
  static const String depositAmount = '/deposit/amount';
  static const String depositReview = '/deposit/review';
  static const String depositSuccess = '/deposit/success';
  
  static const String signUp = '/auth/sign-up';
  static const String signIn = '/auth/sign-in';
  static const String emailSignIn = '/auth/email-sign-in';
  static const String passcodeLogin = '/auth/passcode-login';
  static const String passcodeSetup = '/auth/passcode-setup';
  static const String transactionPinSetup = '/auth/transaction-pin-setup';
  static const String pinManagement = '/settings/pin-management';
  static const String forgotPin = '/pin/forgot';
  static const String changePasscode = '/auth/change-passcode';
  static const String emailVerification = '/auth/email-verification';
  static const String phoneVerification = '/auth/phone-verification';
  static const String otpVerification = '/auth/otp-verification';
  static const String enableBiometricAccess = '/auth/enable-biometric-access';
  static const String passwordRecovery = '/auth/password-recovery';
  static const String passwordRecoveryVerification = '/auth/password-recovery-verification';
  static const String createNewPassword = '/auth/create-new-password';
  static const String selectCountry = '/auth/select-country';
  static const String facialBiometricVerification =
      '/auth/facial-biometric-verification';
  static const String faceScan = '/auth/face-scan';
  static const String facialLogin = '/auth/facial-login';
  static const String proofOfResidence = '/auth/proof-of-residence';

  // Referral Routes
  static const String referralDashboard = '/referral/dashboard';

  // Gift Card Routes
  static const String giftCards = '/gift-cards';
  static const String purchaseGiftCard = '/gift-cards/purchase';
  static const String giftCardPurchaseProcessing = '/gift-cards/purchase-processing';
  static const String giftCardDetails = '/gift-card-details';
  static const String myGiftCards = '/gift-cards/my-cards';
  static const String giftCardTransactions = '/gift-cards/transactions';
  static const String sellGiftCard = '/gift-cards/sell';
  static const String mySales = '/gift-cards/my-sales';

  // Stock Exchange Routes
  static const String stockDetails = '/stocks/details';
  static const String stockTrade = '/stocks/trade';
  static const String stockTradeAmount = '/stocks/trade/amount';
  static const String stockTradePayment = '/stocks/trade/payment';
  static const String stockTradeReview = '/stocks/trade/review';
  static const String stockTradeReceipt = '/stocks/trade/receipt';
  static const String stockPortfolio = '/stocks/portfolio';
  static const String stockWatchlist = '/stocks/watchlist';
  static const String stockOrders = '/stocks/orders';
  static const String stockNews = '/stocks/news';
  static const String stockChartDetails = '/stock-chart-details';

  // Portfolio Routes
  static const String portfolioDetails = '/portfolio/details';

  // Crypto Routes
  static const String cryptoDetails = '/crypto/details';
  static const String buyCrypto = '/crypto/buy';
  static const String cryptoTrade = '/crypto/trade';
  static const String cryptoTradeAmount = '/crypto/trade/amount';
  static const String cryptoTradePayment = '/crypto/trade/payment';
  static const String cryptoTradeReview = '/crypto/trade/review';
  static const String cryptoTradeReceipt = '/crypto/trade/receipt';
  static const String cryptoPortfolio = '/crypto/portfolio';
  static const String cryptoWatchlist = '/crypto/watchlist';
  static const String cryptoOrders = '/crypto/orders';
  static const String cryptoNews = '/crypto/news';
  static const String cryptoChartDetails = '/crypto-chart-details';
  
  // AI Scan to Pay Routes
  static const String aiScanToPay = '/ai-scan-to-pay';
  static const String aiScanSelection = '/ai-scan-to-pay/selection';
  static const String aiScanCamera = '/ai-scan-to-pay/camera';
  static const String aiScanChat = '/ai-scan-to-pay/chat';
  static const String aiScanPayment = '/ai-scan-to-pay/payment';
  static const String aiScanPaymentSuccess = '/ai-scan-to-pay/payment-success';
  
  // Group Account Routes
  static const String groupAccount = '/group-account';
  static const String groupDetails = '/group-account/details';
  static const String createGroup = '/group-account/create';
  static const String addGroupMember = '/group-account/add-member';
  static const String createContribution = '/group-account/create-contribution';
  static const String contributionDetails = '/group-account/contribution-details';
  static const String makePayment = '/group-account/make-payment';
  static const String paymentReceipt = '/group-account/payment-receipt';
  static const String contributionTranscript = '/group-account/contribution-transcript';
  
  // Insurance Routes
  static const String insurance = '/insurance';
  static const String insuranceDetails = '/insurance/details';
  static const String insuranceEdit = '/insurance/edit';
  static const String createInsurance = '/insurance/create';
  static const String insurancePayment = '/insurance/payment';
  static const String insurancePaymentProcessing = '/insurance/payment-processing';
  static const String insurancePaymentConfirmation = '/insurance/payment-confirmation';
  static const String insuranceClaims = '/insurance/claims';
  static const String createClaim = '/insurance/create-claim';
  static const String insuranceTerms = '/insurance/terms';
  static const String insuranceGuide = '/insurance/guide';
  static const String insuranceContact = '/insurance/contact';
  static const String insuranceFaq = '/insurance/faq';
  static const String insuranceDocuments = '/insurance/documents';
  static const String insuranceClaimTracking = '/insurance/claim-tracking';
  static const String insuranceHowItWorks = '/insurance/how-it-works';

  // Airtime Routes
  static const String airtime = '/airtime';
  static const String airtimeCountrySelection = '/airtime/country-selection';
  static const String airtimeNetworkSelection = '/airtime/network-selection';
  static const String airtimeRecipientInput = '/airtime/recipient-input';
  static const String airtimeAmountSelection = '/airtime/amount-selection';
  static const String airtimeReview = '/airtime/review';
  static const String airtimePaymentProcessing = '/airtime/payment-processing';
  static const String airtimePaymentConfirmation = '/airtime/payment-confirmation';
  static const String airtimeHistory = '/airtime/history';
  static const String airtimeDetails = '/airtime/details';

  // AutoSave Routes
  static const String autoSave = '/auto-save';
  static const String autoSaveDashboard = '/auto-save';
  static const String createAutoSaveRule = '/auto-save/create';
  static const String editAutoSaveRule = '/auto-save/edit';
  static const String autoSaveRuleReview = '/auto-save/review';
  static const String autoSaveRuleProcessing = '/auto-save/processing';
  static const String autoSaveRuleReceipt = '/auto-save/receipt';
  static const String autoSaveDetails = '/auto-save/details';
  static const String autoSaveTransactions = '/auto-save/transactions';

  // Crowdfund Routes
  static const String crowdfund = '/crowdfund';
  static const String crowdfundList = '/crowdfund/list';
  static const String crowdfundDetails = '/crowdfund/details';
  static const String createCrowdfund = '/crowdfund/create';
  static const String crowdfundReport = '/crowdfund/report';
  static const String crowdfundNotificationChannels = '/crowdfund/notification-channels';
  static const String donationPayment = '/crowdfund/donation-payment';
  static const String donationProcessing = '/crowdfund/donation-processing';
  static const String donationReceipt = '/crowdfund/donation-receipt';
  static const String crowdfundLeaderboard = '/crowdfund/leaderboard';

  // Public Group Discovery Routes
  static const String publicGroups = '/groups/public';
  static const String groupLeaderboard = '/groups/leaderboard';

  // Batch Transfer Routes
  static const String batchTransfer = '/batch-transfer';
  static const String batchTransferReview = '/batch-transfer-review';
static const String batchTransferProcessing = '/batch-transfer-processing';
  static const String batchTransferReceipt = '/batch-transfer-receipt';
  static const String batchTransferHistory = '/batch-transfer-history';
  static const String batchTransferDetail = '/batch-transfer-detail';

  static const String investments = '/investments';

  // Statistics Routes
  static const String statisticsSpendingDetail = '/statistics/spending-detail';
  static const String statisticsMonthlyTrends = '/statistics/monthly-trends';
  static const String statisticsCategoryAnalysis = '/statistics/category-analysis';
  static const String statisticsComparison = '/statistics/comparison';
  static const String categoryManagement = '/statistics/category-management';

  // Budget Routes
  static const String budgetList = '/statistics/budgets';
  static const String createBudget = '/statistics/budgets/create';
  static const String budgetDetail = '/statistics/budgets/detail';
  static const String budgetAIInsights = '/statistics/budgets/ai-insights';
  static const String budgetReminders = '/statistics/budgets/reminders';
  static const String createBudgetReminder = '/statistics/budgets/reminders/create';

  // Recurring Bills Routes
  static const String recurringBills = '/statistics/recurring-bills';
  static const String createRecurringBill = '/statistics/recurring-bills/create';
  static const String recurringBillDetail = '/statistics/recurring-bills/detail';
  static const String upcomingBills = '/statistics/upcoming-bills';

  // Financial Goals Routes
  static const String financialGoals = '/statistics/financial-goals';
  static const String createFinancialGoal = '/statistics/financial-goals/create';

  // Credit Score Routes
  static const String creditScore = '/credit-score';

  // Open Banking Routes
  static const String openBankingConnect = '/open-banking/connect';
  static const String openBankingCallback = '/open-banking/callback';
  static const String openBankingSync = '/open-banking/sync';

  // Social Linking Routes
  static const String linkedSocialAccounts = '/settings/linked-accounts';

  // Tag Pay Routes
  static const String tagPay = '/tag-pay';
  static const String searchUsers = '/tag-pay/search';
  static const String createTag = '/tag-pay/create-tag';
  static const String tagAmount = '/tag-pay/tag-amount';
  static const String tagPaymentConfirmation = '/tag-pay/payment-confirmation';
  static const String tagPaymentReceipt = '/tag-payment-receipt';
  static const String tagCreationProcessing = '/tag-creation-processing';
  static const String tagCreationReceipt = '/tag-creation-receipt';

  // QR Pay Routes
  static const String qrPayHome = '/qr-pay';
  static const String generateQR = '/qr-pay/generate';
  static const String qrDisplay = '/qr-pay/display';
  static const String scanQR = '/qr-pay/scan';
  static const String qrPaymentConfirmation = '/qr-pay/payment-confirmation';
  static const String qrPaymentProcessing = '/qr-pay/payment-processing';
  static const String qrPaymentReceipt = '/qr-pay/payment-receipt';
  static const String generatedQRHistory = '/qr-pay/generated-history';
  static const String qrPaymentsHistory = '/qr-pay/payments-history';

  // IDPay Routes
  static const String idPayHome = '/id-pay';
  static const String createIdPay = '/id-pay/create';
  static const String idPayCreated = '/id-pay/created';
  static const String idPayLookup = '/id-pay/lookup';
  static const String idPayPayment = '/id-pay/payment';
  static const String idPayReceipt = '/id-pay/receipt';
  static const String idPayDetails = '/id-pay/details';
  static const String idPayOrganizations = '/id-pay/organizations';
  static const String createIdPayOrganization = '/id-pay/organizations/create';
  static const String idPayOrganizationDetails = '/id-pay/organizations/details';

  // Contactless Payment Routes
  static const String contactlessPay = '/contactless-pay';
  static const String contactlessPayCreate = '/contactless-pay/create';
  static const String contactlessPayReader = '/contactless-pay/reader';
  static const String contactlessPayConfirmation = '/contactless-pay/confirmation';
  static const String contactlessPayHistory = '/contactless-pay/history';

  // Card Management Routes
  static const String cardCreationForm = '/cards/create';
  static const String cardCreationReceipt = '/cards/receipt';
  static const String cardsList = '/cards/list';
  static const String cardDetails = '/cards/details';

  // Lock Funds Routes
  static const String lockFunds = '/lock-funds';
  static const String createLockFund = '/lock-funds/create';
  static const String lockFundDetails = '/lock-funds/details';
  static const String lockFundReceipt = '/lock-funds/receipt';

  // Voice Enrollment Routes
  static const String voiceEnrollment = '/voice/enrollment';
  static const String voiceActivationPrompt = '/voice/activation-prompt';
  static const String voiceVerification = '/voice/verification';

  // Family Account Routes
  static const String familySetup = '/family/setup';
  static const String familyAddMember = '/family/add-member';
  static const String familyInviteMemberFlow = '/family/invite-member';
  static const String familyDetails = '/family/details';
  static const String familyEditMemberLimits = '/family/edit-limits';
  static const String familyInvitations = '/family/invitations';
  static const String familySettings = '/family/settings';

  // Microservice Chat Routes
  static const String microserviceChat = '/microservice-chat';
  static const String generalChat = '/general-chat';

  // Two-Factor Authentication Routes
  static const String twoFactorSetup = '/auth/2fa/setup';
  static const String twoFactorVerification = '/auth/2fa/verify';
  static const String twoFactorSettings = '/settings/2fa';

  // KYC Routes
  static const String kycProgressive = '/kyc/progressive';
  static const String kycVerifyId = '/kyc/verify-id';
  static const String kycStatus = '/kyc/status';
  static const String kycDocuments = '/kyc/documents';
  static const String kycSkip = '/kyc/skip';

  // Business Dashboard Routes
  static const String businessDashboard = '/business/dashboard';
  static const String businessAnalytics = '/business/analytics';

  // Payroll Routes (Business)
  static const String payroll = '/payroll';
  static const String payrollEmployees = '/payroll/employees';
  static const String addEmployee = '/payroll/employees/add';
  static const String employeeDetails = '/payroll/employees/details';
  static const String payRuns = '/payroll/pay-runs';
  static const String createPayRun = '/payroll/pay-runs/create';
  static const String payRunDetails = '/payroll/pay-runs/details';
  static const String paySlipDetails = '/payroll/payslip';

  // Debug Routes (Remove before production)
  static const String debugSettings = '/debug/settings';
}
