abstract class AppRoutes {
  static const String root = '/';
  static const String onboarding = '/onboarding';
  static const String dashboard = '/dashboard';
  static const String home = '/home';
  static const String newCard = '/new-card';
  static const String cameraScan = '/camera-scan';
  static const String uploadImage = '/upload-image';
  static const String selectRecipient = '/select-recipient';
  static const String addRecipient = '/add-recipient';
  static const String invoice = '/invoice';
  static const String createInvoice = '/invoice/create';
  static const String invoiceDetails = '/invoice/details';
  static const String invoicePreview = '/invoice/preview';
  static const String invoicePayment = '/invoice/payment';
  static const String sendFunds = '/send-funds';
  static const String initiateSendFunds = '/initiate-send-funds';
  static const String transferProcessing = '/transfer-processing';
  static const String transferProof = '/transfer-proof';
  static const String inputPin = '/input-pin';
  static const String sendFundReceipt = '/send-funds-receipts';
  static const String reviewFundsTransfer = '/review-funds-transfer';
  static const String payElectricityBill = '/pay-electricity-bill';
  static const String flights = '/flights';
  static const String reviewElectricityBillDetails =
      '/validate-electricity-bill-details';
  static const String transferFunds = '/transfer-funds';
  static const String crypto = '/crypto';
  static const String stocks = '/stocks';
  static const String transactionHistory = '/transaction-history';
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
  static const String otpVerification = '/auth/otp-verification';
  static const String enableBiometricAccess = '/auth/enable-biometric-access';
  static const String passwordRecovery = '/auth/password-recovery';
  static const String createNewPassword = '/auth/create-new-password';
  static const String selectCountry = '/auth/select-country';
  static const String facialBiometricVerification =
      '/auth/facial-biometric-verification';
  static const String faceScan = '/auth/face-scan';
  static const String proofOfResidence = '/auth/proof-of-residence';
  static const String giftCards = '/gift-cards';
  static const String purchaseGiftCard = '/gift-cards/purchase';
  static const String giftCardDetails = '/gift-card-details';
  static const String redeemGiftCard = '/gift-cards/redeem';
  static const String myGiftCards = '/gift-cards/my-cards';
  static const String sellToContact = '/gift-cards/sell/contact';
  static const String savedRecipients = '/gift-cards/sell/recipients';
  static const String quickSell = '/gift-cards/sell/quick';
  
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
  
  static const String investments = '/investments';
}
