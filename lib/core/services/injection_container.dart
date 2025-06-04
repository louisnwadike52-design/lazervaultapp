import 'package:get_it/get_it.dart';
import 'package:grpc/grpc.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/types/electricity_bill_details.dart';
import 'package:lazervault/core/types/recipient.dart' as core_recipient;
import 'package:lazervault/core/types/transaction.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/data/repositories/auth_repository.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/login_usecase.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/sign_in_with_apple_usecase.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/sign_up_usecase.dart';
import 'package:lazervault/src/features/authentication/presentation/views/email_sign_in_screen.dart';
import 'package:lazervault/src/features/funds/cubit/withdrawal_cubit.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/add_recipient_usecase.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/get_recipients_usecase.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/toggle_favorite_usecase.dart';
import 'package:lazervault/src/features/funds/cubit/deposit_cubit.dart';
import 'package:lazervault/src/features/funds/data/repositories/withdrawal_repository_impl.dart';
import 'package:lazervault/src/features/funds/domain/repositories/i_withdrawal_repository.dart';
import 'package:lazervault/src/features/funds/presentation/view/withdraw_funds_screen.dart';
import 'package:lazervault/src/features/recipients/data/repositories/recipient_repository_impl.dart';
import 'package:lazervault/src/features/recipients/domain/repositories/i_recipient_repository.dart';
import 'package:lazervault/src/features/recipients/presentation/view/add_recipient_screen.dart';
import 'package:lazervault/src/features/voice_session/cubit/voice_session_cubit.dart';
import 'package:lazervault/src/generated/recipient.pbgrpc.dart';
import 'package:lazervault/src/generated/transfer.pbgrpc.dart' hide TransferTransaction;
import 'package:lazervault/src/generated/user.pbgrpc.dart';
import 'package:lazervault/src/generated/auth.pbgrpc.dart';
import 'package:lazervault/src/generated/deposit.pbgrpc.dart';
import 'package:lazervault/src/features/presentation/views/cb_currency_exchange/cb_currency_exchange_screen.dart';
import 'package:lazervault/src/features/presentation/views/cb_currency_exchange/currency_deposit_screen.dart';
import 'package:lazervault/src/features/presentation/views/change_pin_screen.dart';
import 'package:lazervault/src/features/presentation/views/create_new_password_screen.dart';
import 'package:lazervault/src/features/presentation/views/enable_biometric_access_screen.dart';
import 'package:lazervault/src/features/presentation/views/face_scan_screen.dart';
import 'package:lazervault/src/features/presentation/views/facial_biometric_verification_screen.dart';
import 'package:lazervault/src/features/presentation/views/flights/flights_screen.dart';
import 'package:lazervault/src/features/funds/presentation/view/deposit_funds_screen.dart';
import 'package:lazervault/src/features/funds/presentation/view/send_funds/initiate_send_funds_screen.dart';
import 'package:lazervault/src/features/presentation/views/languages_screen.dart';
import 'package:lazervault/src/features/presentation/views/my_account_screen.dart';
import 'package:lazervault/src/features/presentation/views/otp_verification_screen.dart';
import 'package:lazervault/src/features/presentation/views/password_recovery_screen.dart';
import 'package:lazervault/src/features/presentation/views/profile_settings_screen.dart';
import 'package:lazervault/src/features/presentation/views/review_electricity_bills_screen.dart';
import 'package:lazervault/src/features/presentation/views/camera_scan_screen.dart';
import 'package:lazervault/src/features/presentation/views/dashboard/dashboard_screen.dart';
import 'package:lazervault/src/features/presentation/views/dashboard/transaction_history_screen.dart';
import 'package:lazervault/src/features/presentation/views/input_pin_screen.dart';
import 'package:lazervault/src/features/presentation/views/new_card_screen.dart';
import 'package:lazervault/src/features/presentation/views/pay_electricity_bill_screen.dart';
import 'package:lazervault/src/features/presentation/views/review_funds_transfer_screen.dart';
import 'package:lazervault/src/features/presentation/views/select_country_screen.dart';
import 'package:lazervault/src/features/recipients/presentation/view/select_recipient_screen.dart';
import 'package:lazervault/src/features/presentation/views/send_fund_receipt_screen.dart';
import 'package:lazervault/src/features/presentation/views/send_fund_screen.dart';
import 'package:lazervault/src/features/funds/presentation/view/send_funds/transfer_proof_screen.dart';
import 'package:lazervault/src/features/presentation/views/set_fingerprint_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/passcode_sign_in_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/sign_up_screen.dart';
import 'package:lazervault/src/features/presentation/views/stocks/stocks_screen.dart';
import 'package:lazervault/src/features/presentation/views/upload_image_scren.dart';
import 'package:lazervault/src/generated/withdraw.pbgrpc.dart';

import 'package:lazervault/src/features/funds/data/datasources/transfer_remote_data_source.dart';
import 'package:lazervault/src/features/funds/data/repositories/transfer_repository_impl.dart';
import 'package:lazervault/src/features/funds/domain/repositories/i_transfer_repository.dart';
import 'package:lazervault/src/features/funds/domain/usecases/initiate_transfer_usecase.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_cubit.dart';

import '../../src/features/authentication/data/datasources/authentication_remote_data_source.dart';
import '../../src/features/presentation/views/onboarding_screen.dart';
import '../../src/features/presentation/views/splash_screen.dart';
import 'package:lazervault/src/features/funds/data/repositories/deposit_repository_impl.dart';
import 'package:lazervault/src/features/funds/domain/repositories/i_deposit_repository.dart';
import 'package:lazervault/src/features/funds/domain/usecases/initiate_deposit_usecase.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/data/repositories/account_summary_repository_impl.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/repositories/i_account_summary_repository.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/usecases/get_account_summaries_usecase.dart';
import 'package:lazervault/src/generated/account.pbgrpc.dart';
import 'package:lazervault/src/features/funds/domain/usecases/initiate_withdrawal_usecase.dart';

// AI Chat Imports
import 'package:lazervault/src/generated/ai_chat.pbgrpc.dart';
import 'package:lazervault/src/features/ai_chats/data/datasources/grpc_ai_chat_service.dart';
import 'package:lazervault/src/features/ai_chats/data/repository/ai_chat_repository_impl.dart';
import 'package:lazervault/src/features/ai_chats/domain/repositories/i_ai_chat_repository.dart';
import 'package:lazervault/src/features/ai_chats/domain/usecases/process_ai_chat_usecase.dart';
import 'package:lazervault/src/features/ai_chats/cubit/ai_chat_cubit.dart';
import 'package:lazervault/src/features/ai_chats/domain/usecases/get_ai_chat_history_usecase.dart';
// End AI Chat Imports

import 'package:flutter_dotenv/flutter_dotenv.dart';

// Gift Cards Imports
import 'package:lazervault/src/features/gift_cards/data/datasources/gift_card_remote_data_source.dart';
import 'package:lazervault/src/features/gift_cards/data/repositories/gift_card_repository_impl.dart';
import 'package:lazervault/src/features/gift_cards/domain/repositories/i_gift_card_repository.dart';
import 'package:lazervault/src/features/gift_cards/domain/usecases/get_gift_card_brands_usecase.dart';
import 'package:lazervault/src/features/gift_cards/domain/usecases/purchase_gift_card_usecase.dart';
import 'package:lazervault/src/features/gift_cards/domain/usecases/get_user_gift_cards_usecase.dart';
import 'package:lazervault/src/features/gift_cards/cubit/gift_card_cubit.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/gift_cards_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/my_gift_cards_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/sell_to_contact_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/saved_recipients_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/quick_sell_screen.dart';
// End Gift Cards Imports

// Stocks Imports
import 'package:lazervault/src/features/stocks/data/datasources/stock_remote_data_source.dart';
import 'package:lazervault/src/features/stocks/data/repositories/stock_repository_impl.dart';
import 'package:lazervault/src/features/stocks/domain/repositories/i_stock_repository.dart';
import 'package:lazervault/src/features/stocks/domain/usecases/get_stocks_usecase.dart';
import 'package:lazervault/src/features/stocks/domain/usecases/get_portfolio_usecase.dart';
import 'package:lazervault/src/features/stocks/domain/usecases/place_order_usecase.dart';
import 'package:lazervault/src/features/stocks/domain/usecases/get_watchlists_usecase.dart';
import 'package:lazervault/src/features/stocks/cubit/stock_cubit.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stocks_screen.dart' as StockFeature;
import 'package:lazervault/src/features/stocks/presentation/view/stock_details_screen.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stock_trade_amount_screen.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stock_trade_payment_screen.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stock_trade_review_screen.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stock_trade_receipt_screen.dart';
import 'package:lazervault/src/features/stocks/domain/entities/stock_entity.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stock_chart_details_screen.dart';
// End Stocks Imports

// Crypto Imports
import 'package:lazervault/src/features/crypto/data/datasources/crypto_remote_data_source.dart';
import 'package:lazervault/src/features/crypto/data/repositories/crypto_repository_impl.dart';
import 'package:lazervault/src/features/crypto/domain/repositories/crypto_repository.dart';
import 'package:lazervault/src/features/crypto/domain/entities/crypto_entity.dart';
import 'package:lazervault/src/features/crypto/cubit/crypto_cubit.dart';
import 'package:lazervault/src/features/crypto/presentation/view/crypto_screen.dart' as CryptoFeature;
import 'package:lazervault/src/features/crypto/presentation/view/crypto_chart_details_screen.dart';
import 'package:lazervault/src/features/crypto/presentation/view/crypto_detail_screen.dart';
// End Crypto Imports

// Invoice Imports
import 'package:lazervault/src/features/invoice/data/datasources/invoice_local_datasource.dart';
import 'package:lazervault/src/features/invoice/data/repositories/invoice_repository_impl.dart';
import 'package:lazervault/src/features/invoice/domain/repositories/invoice_repository.dart';
import 'package:lazervault/src/features/invoice/presentation/cubit/invoice_cubit.dart';
import 'package:lazervault/src/features/invoice/presentation/view/invoice_list_screen.dart';
import 'package:lazervault/src/features/invoice/presentation/view/create_invoice_screen.dart';
import 'package:lazervault/src/features/invoice/presentation/view/invoice_details_screen.dart';
import 'package:lazervault/src/features/pay_invoice/presentation/view/pay_invoice_screen.dart';
import 'package:lazervault/src/features/pay_invoice/presentation/cubit/pay_invoice_cubit.dart';
import 'package:lazervault/src/features/pay_invoice/data/repositories/pay_invoice_repository_impl.dart';
import 'package:lazervault/src/features/pay_invoice/data/datasources/pay_invoice_local_datasource.dart';
import 'package:lazervault/src/features/pay_invoice/domain/repositories/pay_invoice_repository.dart';
// End Invoice Imports

import 'package:lazervault/src/features/investments/presentation/view/investments_screen.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  // Load environment variables
  await dotenv.load();

  // ================== External / gRPC / HTTP ==================
  serviceLocator.registerLazySingleton(http.Client.new);

  serviceLocator.registerLazySingleton<ClientChannel>(() {
    final host = dotenv.env['GRPC_API_HOST'] ?? (throw Exception('GRPC_API_HOST environment variable is not set. For Android emulator, use http://10.0.2.2:7878')); 
    final port = int.parse(dotenv.env['GRPC_API_PORT'] ?? (throw Exception('GRPC_API_PORT environment variable is not set')));
    
    // Extract host without protocol
    final uri = Uri.parse(host);
    final cleanHost = uri.host;
    
    print("Creating gRPC Channel to $cleanHost:$port");
    return ClientChannel(
      cleanHost,
      port: port,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(), // Use insecure credentials for localhost
      ),
    );
  });

  // Register gRPC Clients
  serviceLocator.registerLazySingleton<UserServiceClient>(
    () => UserServiceClient(serviceLocator<ClientChannel>()),
  );
  serviceLocator.registerLazySingleton<AuthServiceClient>(
    () => AuthServiceClient(serviceLocator<ClientChannel>()),
  );
  serviceLocator.registerLazySingleton<DepositServiceClient>(
    () => DepositServiceClient(serviceLocator<ClientChannel>()),
  );
  serviceLocator.registerLazySingleton<AccountServiceClient>(
    () => AccountServiceClient(serviceLocator<ClientChannel>()),
  );
  serviceLocator.registerLazySingleton<RecipientServiceClient>(
    () => RecipientServiceClient(serviceLocator<ClientChannel>()),
  );
  serviceLocator.registerLazySingleton<WithdrawServiceClient>(
    () => WithdrawServiceClient(serviceLocator<ClientChannel>()),
  );
  serviceLocator.registerLazySingleton<TransferServiceClient>(
    () => TransferServiceClient(serviceLocator<ClientChannel>()),
  );
  serviceLocator.registerLazySingleton<AIChatServiceClient>(
    () => AIChatServiceClient(serviceLocator<ClientChannel>()),
  );


  // ================== Feature: Authentication ==================

  // Data Sources
  serviceLocator.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(serviceLocator<http.Client>()));

  // Repositories
  serviceLocator.registerLazySingleton<IAuthRepository>(
      () => AuthRepositoryImpl(
          userServiceClient: serviceLocator<UserServiceClient>(),
          authServiceClient: serviceLocator<AuthServiceClient>(),
        ));

  // Use Cases
  serviceLocator.registerLazySingleton(() => SignUpUseCase(serviceLocator<IAuthRepository>()));
  serviceLocator.registerLazySingleton(() => LoginUseCase(serviceLocator<IAuthRepository>()));
  serviceLocator.registerLazySingleton(() => SignInWithGoogleUseCase(serviceLocator<IAuthRepository>()));
  serviceLocator.registerLazySingleton(() => SignInWithAppleUseCase(serviceLocator<IAuthRepository>()));

  // Blocs/Cubits
  serviceLocator.registerFactory(() => AuthenticationCubit(
        login: serviceLocator<LoginUseCase>(),
        signUp: serviceLocator<SignUpUseCase>(),
        signInWithGoogle: serviceLocator<SignInWithGoogleUseCase>(),
        signInWithApple: serviceLocator<SignInWithAppleUseCase>(),
      ));


  // ================== Feature: Account Cards Summary ==================

  // Repositories
  serviceLocator.registerLazySingleton<IAccountSummaryRepository>(
      () => AccountSummaryRepositoryImpl(serviceLocator<AccountServiceClient>()));

  // Use Cases
  serviceLocator.registerLazySingleton(() => GetAccountSummariesUseCase(serviceLocator<IAccountSummaryRepository>()));

  // Blocs/Cubits
  serviceLocator.registerLazySingleton(() => AccountCardsSummaryCubit(serviceLocator<GetAccountSummariesUseCase>()));


  // ================== Feature: Recipients ==================

  // Repositories
  serviceLocator.registerLazySingleton<IRecipientRepository>(
    () => RecipientRepositoryImpl(serviceLocator<RecipientServiceClient>()),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(() => GetRecipientsUseCase(serviceLocator<IRecipientRepository>()));
  serviceLocator.registerLazySingleton(() => AddRecipientUseCase(serviceLocator<IRecipientRepository>()));
  serviceLocator.registerLazySingleton(() => ToggleFavoriteUseCase(serviceLocator<IRecipientRepository>()));

  // Blocs/Cubits
  serviceLocator.registerFactory(() => RecipientCubit(
    getRecipientsUseCase: serviceLocator<GetRecipientsUseCase>(),
    addRecipientUseCase: serviceLocator<AddRecipientUseCase>(),
    toggleFavoriteUseCase: serviceLocator<ToggleFavoriteUseCase>(),
  ));


  // ================== Feature: Funds (Deposit) ==================

  // Repositories
  serviceLocator.registerLazySingleton<IDepositRepository>(
      () => DepositRepositoryImpl(serviceLocator<DepositServiceClient>()));

  // Use Cases
  serviceLocator.registerLazySingleton(() => InitiateDepositUseCase(serviceLocator<IDepositRepository>()));

  // Blocs/Cubits
  serviceLocator.registerFactory(() => DepositCubit(serviceLocator<InitiateDepositUseCase>()));


  // ================== Feature: Funds (Withdrawal) ==================

  // Repositories
  serviceLocator.registerLazySingleton<IWithdrawalRepository>(
      () => WithdrawalRepositoryImpl(serviceLocator<WithdrawServiceClient>()));

  // Use Cases
  serviceLocator.registerLazySingleton(() => InitiateWithdrawalUseCase(serviceLocator<IWithdrawalRepository>()));

  // Blocs/Cubits
   serviceLocator.registerFactory(() => WithdrawalCubit(serviceLocator<InitiateWithdrawalUseCase>()));


  // ================== Feature: Funds (Transfer) ==================

  // Data Sources
  serviceLocator.registerLazySingleton<ITransferRemoteDataSource>(
    () => TransferRemoteDataSourceImpl(serviceLocator<TransferServiceClient>()),
  );

  // Repositories
  serviceLocator.registerLazySingleton<ITransferRepository>(
    () => TransferRepositoryImpl(remoteDataSource: serviceLocator<ITransferRemoteDataSource>()),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(() => InitiateTransferUseCase(serviceLocator<ITransferRepository>()));

  // Blocs/Cubits
  serviceLocator.registerFactory(() => TransferCubit(
    initiateTransferUseCase: serviceLocator<InitiateTransferUseCase>(),
  ));


  // ================== Feature: AI Chat ==================

  // Data Sources
  serviceLocator.registerLazySingleton<IAiChatDataSource>(
    () => GrpcAiChatDataSource(client: serviceLocator<AIChatServiceClient>()),
  );

  // Repositories
  serviceLocator.registerLazySingleton<IAiChatRepository>(
    () => AiChatRepositoryImpl(dataSource: serviceLocator<IAiChatDataSource>()),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(() => ProcessChatUseCase(serviceLocator<IAiChatRepository>()));
  serviceLocator.registerLazySingleton(() => GetAIChatHistoryUseCase(serviceLocator<IAiChatRepository>()));

  // Blocs/Cubits
  // Register as Factory because it depends on another Cubit (Auth)
  serviceLocator.registerFactory(() => AIChatCubit(
        processChatUseCase: serviceLocator<ProcessChatUseCase>(),
        getAIChatHistoryUseCase: serviceLocator<GetAIChatHistoryUseCase>(),
      ));


  // ================== Feature: Gift Cards ==================

  // Data Sources
  serviceLocator.registerLazySingleton<IGiftCardRemoteDataSource>(
    () => GiftCardRemoteDataSourceImpl(),
  );

  // Repositories
  serviceLocator.registerLazySingleton<IGiftCardRepository>(
    () => GiftCardRepositoryImpl(remoteDataSource: serviceLocator<IGiftCardRemoteDataSource>()),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(() => GetGiftCardBrandsUseCase(serviceLocator<IGiftCardRepository>()));
  serviceLocator.registerLazySingleton(() => PurchaseGiftCardUseCase(serviceLocator<IGiftCardRepository>()));
  serviceLocator.registerLazySingleton(() => GetUserGiftCardsUseCase(serviceLocator<IGiftCardRepository>()));

  // Blocs/Cubits
  serviceLocator.registerFactory(() => GiftCardCubit());


  // ================== Feature: Stocks ==================

  // Data Sources
  serviceLocator.registerLazySingleton<IStockRemoteDataSource>(
    () => StockRemoteDataSourceImpl(),
  );

  // Repositories
  serviceLocator.registerLazySingleton<IStockRepository>(
    () => StockRepositoryImpl(remoteDataSource: serviceLocator<IStockRemoteDataSource>()),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(() => GetStocksUseCase(serviceLocator<IStockRepository>()));
  serviceLocator.registerLazySingleton(() => GetPortfolioUseCase(serviceLocator<IStockRepository>()));
  serviceLocator.registerLazySingleton(() => PlaceOrderUseCase(serviceLocator<IStockRepository>()));
  serviceLocator.registerLazySingleton(() => GetWatchlistsUseCase(serviceLocator<IStockRepository>()));

  // Blocs/Cubits
  serviceLocator.registerFactory(() => StockCubit(
    getStocksUseCase: serviceLocator<GetStocksUseCase>(),
    getPortfolioUseCase: serviceLocator<GetPortfolioUseCase>(),
    placeOrderUseCase: serviceLocator<PlaceOrderUseCase>(),
    getWatchlistsUseCase: serviceLocator<GetWatchlistsUseCase>(),
    repository: serviceLocator<IStockRepository>(),
      ));


  // ================== Feature: Crypto ==================

  // Data Sources
  serviceLocator.registerLazySingleton<CryptoRemoteDataSource>(
    () => CryptoRemoteDataSourceImpl(),
  );

  // Repositories
  serviceLocator.registerLazySingleton<CryptoRepository>(
    () => CryptoRepositoryImpl(remoteDataSource: serviceLocator<CryptoRemoteDataSource>()),
  );

  // Blocs/Cubits
  serviceLocator.registerFactory(() => CryptoCubit(
    repository: serviceLocator<CryptoRepository>(),
  ));


  // ================== Feature: Invoice ==================

  // Data Sources
  serviceLocator.registerLazySingleton<InvoiceLocalDataSource>(
    () {
      final dataSource = InvoiceLocalDataSourceImpl();
      // Initialize Hive when the data source is created
      dataSource.initializeHive();
      return dataSource;
    },
  );

  // Repositories
  serviceLocator.registerLazySingleton<InvoiceRepository>(
    () => InvoiceRepositoryImpl(localDataSource: serviceLocator<InvoiceLocalDataSource>()),
  );

  // Blocs/Cubits
  serviceLocator.registerFactory(() => InvoiceCubit(
    repository: serviceLocator<InvoiceRepository>(),
    currentUserId: 'current_user_id', // This should be injected based on authenticated user
  ));


  // ================== Screens / Presentation ==================
  serviceLocator
      ..registerFactory(() => OnboardingScreen())
      ..registerFactory(() => SplashScreen())
      ..registerFactory(() => DashboardScreen())
      ..registerFactory(() => NewCardScreen())
      ..registerFactory(() => CameraScanScreen())
      ..registerFactory(() => UploadImageScreen())
      ..registerFactory(() => SelectRecipientScreen())
      ..registerFactory(() => AddRecipientScreen())
      ..registerFactory(() => InvoiceListScreen())
      ..registerFactory(() => CreateInvoiceScreen())
      ..registerFactory(() => PayInvoiceScreen())
      ..registerFactoryParam<InvoiceDetailsScreen, String, void>(
          (invoiceId, _) => InvoiceDetailsScreen(invoiceId: invoiceId))
      ..registerFactoryParam<InputPinScreen, User, void>(
          (recipient, _) => InputPinScreen(recipient: recipient))
      ..registerFactory(() => PayElectricityBillScreen())
      ..registerFactory(() => ProfileSettingsScreen())
      ..registerFactory(() => LanguagesScreen())
      ..registerFactory(() => MyAccountScreen())
      ..registerFactory(() => SetFingerPrintScreen())
      ..registerFactory(() => ChangePinScreen())
      ..registerFactory(() => SignUpScreen())
      ..registerFactory(() => EmailSignInScreen())
      ..registerFactory(() => PasscodeSignInScreen())
      ..registerFactory(() => OTPVerificationScreen())
      ..registerFactory(() => EnableBiometricAccessScreen())
      ..registerFactory(() => PasswordRecoveryScreen())
      ..registerFactory(() => CreateNewPasswordScreen())
      ..registerFactory(() => SelectCountryScreen())
      ..registerFactory(() => FacialBiometricVerificationScreen())
      ..registerFactory(() => FaceScanScreen())
      ..registerFactory(() => TransactionHistoryScreen())
      ..registerFactory(() => FlightsScreen())
      ..registerFactory(() => StocksScreen())
      ..registerFactory(() => CBCurrencyExchangeScreen())
      ..registerFactory(() => CryptoFeature.CryptoScreen())
      ..registerFactoryParam<CryptoDetailScreen, Crypto, void>(
          (crypto, _) => CryptoDetailScreen(crypto: crypto))
      ..registerFactoryParam<CryptoChartDetailsScreen, Crypto, void>(
          (crypto, _) => CryptoChartDetailsScreen(crypto: crypto))
      ..registerFactoryParam<CurrencyDepositScreen, String, void>(
          (currencyCode, _) => CurrencyDepositScreen(currencyCode: currencyCode))
      ..registerFactory(() => GiftCardsScreen())
      ..registerFactory(() => MyGiftCardsScreen())
      ..registerFactory(() => SellToContactScreen())
      ..registerFactory(() => SavedRecipientsScreen())
      ..registerFactory(() => QuickSellScreen())
      ..registerFactory(() => StockFeature.StocksScreen())
      ..registerFactoryParam<StockDetailsScreen, Stock, void>(
          (stock, _) => StockDetailsScreen(stock: stock))
      ..registerFactory(() => StockTradeAmountScreen())
      ..registerFactory(() => StockTradePaymentScreen())
      ..registerFactory(() => StockTradeReviewScreen())
      ..registerFactory(() => StockTradeReceiptScreen())
      ..registerFactoryParam<ReviewFundsTransferScreen, core_recipient.Recipient, void>(
          (recipient, _) => ReviewFundsTransferScreen(recipient: recipient))
      ..registerFactoryParam<InitiateSendFundsScreen, RecipientModel, void>(
          (recipient, _) => InitiateSendFundsScreen(recipient:  recipient))
      ..registerFactoryParam<SendFundScreen, User, void>(
          (recipient, _) => SendFundScreen(recipient: recipient))
      ..registerFactoryParam<TransferProofScreen, Map<String, dynamic>, void>(
          (transferDetails, _) => TransferProofScreen(transferDetails: transferDetails))
      ..registerFactoryParam<SendFundReceiptScreen, Transaction, void>(
          (transaction, _) => SendFundReceiptScreen(transaction: transaction))
      ..registerFactoryParam<ReviewElectricityBillsScreen, ElectricityBillDetails,
              void>(
          (electricityBillDetails, _) => ReviewElectricityBillsScreen(
              electricityBillDetails: electricityBillDetails))
      ..registerFactoryParam<DepositFundsScreen, Map<String, dynamic>, void>(
        (selectedCard, _) => DepositFundsScreen(selectedCard: selectedCard),
      )
      ..registerFactoryParam<WithdrawFundsScreen, Map<String, dynamic>, void>(
        (selectedCard, _) => WithdrawFundsScreen(selectedCard: selectedCard),
      )
      ..registerFactoryParam<StockChartDetailsScreen, Stock, void>(
          (stock, _) => StockChartDetailsScreen(stock: stock))
      ..registerFactory(() => InvestmentsScreen());

  // Make sure AuthenticationCubit is registered first, e.g.:
  // serviceLocator.registerLazySingleton(() => AuthenticationCubit(...));

  // Then, register VoiceSessionCubit and inject AuthenticationCubit:
  serviceLocator.registerLazySingleton<VoiceSessionCubit>(
    () => VoiceSessionCubit(),
  );

  // ================== Feature: Pay Invoice ==================

  // Data Sources
  serviceLocator.registerLazySingleton<PayInvoiceLocalDataSource>(
    () => PayInvoiceLocalDataSourceImpl(),
  );

  // Repositories
  serviceLocator.registerLazySingleton<PayInvoiceRepository>(
    () => PayInvoiceRepositoryImpl(localDataSource: serviceLocator<PayInvoiceLocalDataSource>()),
  );

  // Blocs/Cubits
  serviceLocator.registerFactory<PayInvoiceCubit>(
    () => PayInvoiceCubit(repository: serviceLocator<PayInvoiceRepository>()),
  );

  print("Dependency Injection Initialized with Hierarchical Order");
}
