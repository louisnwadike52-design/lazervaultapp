import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/electricity_bill_details.dart';
import 'package:lazervault/core/types/recipient.dart';
import 'package:lazervault/core/types/transaction.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/authentication/presentation/views/email_sign_in_screen.dart';
import 'package:lazervault/src/features/crypto/presentation/view/crypto_screen.dart';
import 'package:lazervault/src/features/crypto/presentation/view/buy_crypto_screen.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/transfer_proof.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/gift_cards_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/purchase_gift_card_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/gift_card_details_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/redeem_gift_card_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/my_gift_cards_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/sell_to_contact_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/saved_recipients_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/quick_sell_screen.dart';
import 'package:lazervault/src/features/gift_cards/domain/entities/gift_card_entity.dart';
import 'package:lazervault/src/features/gift_cards/cubit/gift_card_cubit.dart';
import 'package:lazervault/src/features/presentation/views/cb_currency_exchange/cb_currency_exchange_screen.dart';
import 'package:lazervault/src/features/presentation/views/cb_currency_exchange/currency_deposit_screen.dart';
import 'package:lazervault/src/features/presentation/views/cb_currency_exchange/international_transfer_start_screen.dart';
import 'package:lazervault/src/features/presentation/views/cb_currency_exchange/international_transfer_amount_screen.dart';
import 'package:lazervault/src/features/presentation/views/cb_currency_exchange/international_transfer_recipient_screen.dart';
import 'package:lazervault/src/features/presentation/views/cb_currency_exchange/international_transfer_review_screen.dart';
import 'package:lazervault/src/features/presentation/views/deposit/deposit_method_selection_screen.dart';
import 'package:lazervault/src/features/presentation/views/deposit/deposit_amount_screen.dart';
import 'package:lazervault/src/features/presentation/views/deposit/deposit_review_screen.dart';
import 'package:lazervault/src/features/presentation/views/deposit/deposit_success_screen.dart';
import 'package:lazervault/src/features/presentation/views/change_pin_screen.dart';
import 'package:lazervault/src/features/presentation/views/create_new_password_screen.dart';
import 'package:lazervault/src/features/presentation/views/dashboard/transaction_history_screen.dart';
import 'package:lazervault/src/features/presentation/views/enable_biometric_access_screen.dart';
import 'package:lazervault/src/features/presentation/views/face_scan_screen.dart';
import 'package:lazervault/src/features/presentation/views/facial_biometric_verification_screen.dart';
import 'package:lazervault/src/features/presentation/views/flights/flights_screen.dart';
import 'package:lazervault/src/features/funds/presentation/view/deposit_funds_screen.dart';
import 'package:lazervault/src/features/funds/presentation/view/withdraw_funds_screen.dart';
import 'package:lazervault/src/features/funds/presentation/view/send_funds/initiate_send_funds_screen.dart';
import 'package:lazervault/src/features/presentation/views/languages_screen.dart';
import 'package:lazervault/src/features/presentation/views/my_account_screen.dart';
import 'package:lazervault/src/features/presentation/views/otp_verification_screen.dart';
import 'package:lazervault/src/features/presentation/views/password_recovery_screen.dart';
import 'package:lazervault/src/features/presentation/views/profile_settings_screen.dart';
import 'package:lazervault/src/features/presentation/views/review_electricity_bills_screen.dart';
import 'package:lazervault/src/features/presentation/views/camera_scan_screen.dart';
import 'package:lazervault/src/features/presentation/views/dashboard/dashboard_screen.dart';
import 'package:lazervault/src/features/presentation/views/input_pin_screen.dart';
import 'package:lazervault/src/features/presentation/views/new_card_screen.dart';
import 'package:lazervault/src/features/presentation/views/pay_electricity_bill_screen.dart';
import 'package:lazervault/src/features/presentation/views/request_funds_screen.dart';
import 'package:lazervault/src/features/presentation/views/review_funds_transfer_screen.dart';
import 'package:lazervault/src/features/presentation/views/review_transfer_funds_screen.dart';
import 'package:lazervault/src/features/presentation/views/select_country_screen.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/presentation/view/add_recipient_screen.dart';
import 'package:lazervault/src/features/recipients/presentation/view/select_recipient_screen.dart';
import 'package:lazervault/src/features/presentation/views/send_fund_receipt_screen.dart';
import 'package:lazervault/src/features/presentation/views/send_fund_screen.dart';
import 'package:lazervault/src/features/funds/presentation/view/send_funds/transfer_proof_screen.dart';
import 'package:lazervault/src/features/funds/presentation/view/send_funds/transfer_processing_screen.dart';
import 'package:lazervault/src/features/presentation/views/set_fingerprint_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/passcode_sign_in_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/sign_up_screen.dart';
import 'package:lazervault/src/features/presentation/views/stocks/stocks_screen.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stocks_screen.dart' as StockFeature;
import 'package:lazervault/src/features/stocks/presentation/view/stock_details_screen.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stock_trade_amount_screen.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stock_trade_payment_screen.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stock_trade_review_screen.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stock_trade_receipt_screen.dart';
import 'package:lazervault/src/features/stocks/cubit/stock_cubit.dart';
import 'package:lazervault/src/features/stocks/domain/entities/stock_entity.dart';
import 'package:lazervault/src/features/presentation/views/transfer_funds_screen.dart';
import 'package:lazervault/src/features/presentation/views/upload_image_scren.dart';
import '../../../core/services/injection_container.dart';
import 'views/onboarding_screen.dart';
import 'package:lazervault/src/features/funds/cubit/withdrawal_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/deposit_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_cubit.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stock_chart_details_screen.dart';
import '../investments/presentation/view/investments_screen.dart';
import 'package:lazervault/src/features/crypto/cubit/crypto_cubit.dart';
import 'package:lazervault/src/features/crypto/presentation/view/crypto_detail_screen.dart';
import 'package:lazervault/src/features/crypto/domain/entities/crypto_entity.dart';
import 'package:lazervault/src/features/crypto/presentation/view/crypto_chart_details_screen.dart';

class AppRouter {
  static final routes = [
    GetPage(
      name: AppRoutes.root,
      page: () => serviceLocator<OnboardingScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => serviceLocator<DashboardScreen>(),
      transition: Transition.upToDown,
    ),
    GetPage(
      name: AppRoutes.newCard,
      page: () => serviceLocator<NewCardScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.cameraScan,
      page: () => serviceLocator<CameraScanScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.uploadImage,
      page: () => serviceLocator<UploadImageScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.flights,
      page: () => serviceLocator<FlightsScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.crypto,
      page: () => BlocProvider(
        create: (context) => serviceLocator<CryptoCubit>(),
        child: serviceLocator<CryptoScreen>(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.cryptoDetails,
      page: () {
        final crypto = Get.arguments as Crypto;
        return BlocProvider(
          create: (context) => serviceLocator<CryptoCubit>(),
          child: serviceLocator<CryptoDetailScreen>(param1: crypto),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.buyCrypto,
      page: () {
        final selectedCrypto = Get.arguments as Crypto?;
        return BlocProvider(
          create: (context) => serviceLocator<CryptoCubit>(),
          child: BuyCryptoScreen(selectedCrypto: selectedCrypto),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.stocks,
      page: () => BlocProvider(
        create: (context) => serviceLocator<StockCubit>(),
        child: serviceLocator<StockFeature.StocksScreen>(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.investments,
      page: () => serviceLocator<InvestmentsScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.giftCards,
      page: () => BlocProvider(
        create: (_) => serviceLocator<GiftCardCubit>(),
        child: serviceLocator<GiftCardsScreen>(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.selectRecipient,
      page: () => BlocProvider(
        create: (_) => serviceLocator<RecipientCubit>(),
        child: serviceLocator<SelectRecipientScreen>(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.addRecipient,
      page: () => BlocProvider(
        create: (_) => serviceLocator<RecipientCubit>(),
        child: serviceLocator<AddRecipientScreen>(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.requestFunds,
      page: () => serviceLocator<RequestFundsScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.inputPin,
      page: () {
        final recipient = Get.arguments as User;
        return serviceLocator<InputPinScreen>(param1: recipient);
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.payElectricityBill,
      page: () => serviceLocator<PayElectricityBillScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.profileSettings,
      page: () => serviceLocator<ProfileSettingsScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.languages,
      page: () => serviceLocator<LanguagesScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.myAccount,
      page: () => serviceLocator<MyAccountScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.setFingerPrint,
      page: () => serviceLocator<SetFingerPrintScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.changePin,
      page: () => serviceLocator<ChangePinScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => serviceLocator<SignUpScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.emailSignIn,
      page: () => serviceLocator<EmailSignInScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.signIn,
      page: () => serviceLocator<PasscodeSignInScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.otpVerification,
      page: () => serviceLocator<OTPVerificationScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.enableBiometricAccess,
      page: () => serviceLocator<EnableBiometricAccessScreen>(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: AppRoutes.passwordRecovery,
      page: () => serviceLocator<PasswordRecoveryScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.createNewPassword,
      page: () => serviceLocator<CreateNewPasswordScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.selectCountry,
      page: () => serviceLocator<SelectCountryScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.facialBiometricVerification,
      page: () => serviceLocator<FacialBiometricVerificationScreen>(),
      transition: Transition.upToDown,
    ),
    GetPage(
      name: AppRoutes.faceScan,
      page: () => serviceLocator<FaceScanScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.reviewFundsTransfer,
      page: () {
        final recipient = Get.arguments as User;
        return serviceLocator<ReviewFundsTransferScreen>(param1: recipient);
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.reviewElectricityBillDetails,
      page: () {
        final electricityBillDetails = Get.arguments as ElectricityBillDetails;
        return serviceLocator<ReviewElectricityBillsScreen>(
          param1: electricityBillDetails,
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.sendFunds,
      page: () {
        final recipient = Get.arguments as User;
        return serviceLocator<SendFundScreen>(param1: recipient);
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.transferProcessing,
      page: () => const TransferProcessingScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.transferProof,
      page: () {
        final transferDetails = Get.arguments as Map<String, dynamic>? ?? {};
        return TransferProof(transferDetails: transferDetails);
      },
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: AppRoutes.initiateSendFunds,
      page: () {
        final recipient = Get.arguments as RecipientModel;
        return BlocProvider(
          create: (_) => serviceLocator<TransferCubit>(),
          child: serviceLocator<InitiateSendFundsScreen>(param1: recipient),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.sendFundReceipt,
      page: () {
        final transaction = Get.arguments as Transaction;
        return serviceLocator<SendFundReceiptScreen>(param1: transaction);
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.transferFunds,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        return serviceLocator<TransferFundsScreen>(
          param1: args['user'] as User,
          param2: args['transaction'] as TransferTransaction,
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.reviewTransferFunds,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        return serviceLocator<ReviewTransferFundsScreen>(
          param1: args['user'] as User,
          param2: args['transaction'] as TransferTransaction,
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.transactionHistory,
      page: () => serviceLocator<TransactionHistoryScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.depositFunds,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        return BlocProvider(
          create: (_) => serviceLocator<DepositCubit>(),
          child:
              serviceLocator<DepositFundsScreen>(param1: args['selectedCard']),
        );
      },
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: AppRoutes.withdrawFunds,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        return BlocProvider(
          create: (_) => serviceLocator<WithdrawalCubit>(),
          child:
              serviceLocator<WithdrawFundsScreen>(param1: args['selectedCard']),
        );
      },
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: AppRoutes.cbCurrencyExchange,
      page: () => serviceLocator<CBCurrencyExchangeScreen>(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: AppRoutes.currencyDeposit,
      page: () {
        final currencyCode = Get.arguments as String;
        return serviceLocator<CurrencyDepositScreen>(param1: currencyCode);
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.purchaseGiftCard,
      page: () {
        final brand = Get.arguments as GiftCardBrand;
        return BlocProvider(
          create: (_) => serviceLocator<GiftCardCubit>(),
          child: PurchaseGiftCardScreen(brand: brand),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.giftCardDetails,
      page: () {
        final giftCard = Get.arguments as GiftCard;
        return GiftCardDetailsScreen(giftCard: giftCard);
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.redeemGiftCard,
      page: () {
        final giftCard = Get.arguments as GiftCard?;
        return BlocProvider(
          create: (_) => serviceLocator<GiftCardCubit>(),
          child: RedeemGiftCardScreen(giftCard: giftCard),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.myGiftCards,
      page: () => BlocProvider(
        create: (_) => serviceLocator<GiftCardCubit>(),
        child: serviceLocator<MyGiftCardsScreen>(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.sellToContact,
      page: () => BlocProvider(
        create: (_) => serviceLocator<GiftCardCubit>(),
        child: serviceLocator<SellToContactScreen>(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.savedRecipients,
      page: () => BlocProvider(
        create: (_) => serviceLocator<GiftCardCubit>(),
        child: serviceLocator<SavedRecipientsScreen>(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.quickSell,
      page: () => BlocProvider(
        create: (_) => serviceLocator<GiftCardCubit>(),
        child: serviceLocator<QuickSellScreen>(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.internationalTransferStart,
      page: () => const InternationalTransferStartScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.internationalTransferAmount,
      page: () => const InternationalTransferAmountScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.internationalTransferRecipient,
      page: () => const InternationalTransferRecipientScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.internationalTransferReview,
      page: () => const InternationalTransferReviewScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.depositMethodSelection,
      page: () => const DepositMethodSelectionScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.depositAmount,
      page: () => const DepositAmountScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.depositReview,
      page: () => const DepositReviewScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.depositSuccess,
      page: () => const DepositSuccessScreen(),
      transition: Transition.rightToLeft,
    ),
    // Stock Exchange Routes
    GetPage(
      name: AppRoutes.stockDetails,
      page: () {
        final stock = Get.arguments as Stock;
        return BlocProvider(
          create: (_) => serviceLocator<StockCubit>()..loadStockDetails(stock.symbol),
          child: serviceLocator<StockDetailsScreen>(param1: stock),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.stockTrade,
      page: () => BlocProvider(
        create: (_) => serviceLocator<StockCubit>()..loadStocks(),
        child: serviceLocator<StockFeature.StocksScreen>(), // Will show trade dialog
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.stockTradeAmount,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<StockCubit>(),
          child: serviceLocator<StockTradeAmountScreen>(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.stockTradePayment,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<StockCubit>(),
          child: serviceLocator<StockTradePaymentScreen>(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.stockTradeReview,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<StockCubit>(),
          child: serviceLocator<StockTradeReviewScreen>(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.stockTradeReceipt,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<StockCubit>(),
          child: serviceLocator<StockTradeReceiptScreen>(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.stockPortfolio,
      page: () => BlocProvider(
        create: (_) => serviceLocator<StockCubit>()..loadPortfolio(),
        child: serviceLocator<StockFeature.StocksScreen>(), // Will show portfolio tab
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.stockWatchlist,
      page: () => BlocProvider(
        create: (_) => serviceLocator<StockCubit>()..loadWatchlists(),
        child: serviceLocator<StockFeature.StocksScreen>(), // Will show watchlist tab
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.stockOrders,
      page: () => BlocProvider(
        create: (_) => serviceLocator<StockCubit>()..loadOrders(),
        child: serviceLocator<StockFeature.StocksScreen>(), // Will show orders tab
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.stockNews,
      page: () => BlocProvider(
        create: (_) => serviceLocator<StockCubit>()..loadMarketNews(),
        child: serviceLocator<StockFeature.StocksScreen>(), // Will show news tab
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.stockChartDetails,
      page: () {
        final stock = Get.arguments as Stock;
        return BlocProvider(
          create: (_) => serviceLocator<StockCubit>()..loadStockDetails(stock.symbol),
          child: serviceLocator<StockChartDetailsScreen>(param1: stock),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.cryptoChartDetails,
      page: () {
        final crypto = Get.arguments as Crypto;
        return BlocProvider(
          create: (context) => serviceLocator<CryptoCubit>(),
          child: serviceLocator<CryptoChartDetailsScreen>(param1: crypto),
        );
      },
      transition: Transition.rightToLeft,
    ),
  ];
}
