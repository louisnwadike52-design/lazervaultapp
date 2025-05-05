import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/electricity_bill_details.dart';
import 'package:lazervault/core/types/recipient.dart';
import 'package:lazervault/core/types/transaction.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/authentication/presentation/views/email_sign_in_screen.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/transfer_proof.dart';
import 'package:lazervault/src/features/presentation/views/cb_currency_exchange/cb_currency_exchange_screen.dart';
import 'package:lazervault/src/features/presentation/views/change_pin_screen.dart';
import 'package:lazervault/src/features/presentation/views/create_new_password_screen.dart';
import 'package:lazervault/src/features/presentation/views/crypto/crypto_screen.dart';
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
import 'package:lazervault/src/features/presentation/views/set_fingerprint_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/passcode_sign_in_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/sign_up_screen.dart';
import 'package:lazervault/src/features/presentation/views/stocks/stocks_screen.dart';
import 'package:lazervault/src/features/presentation/views/transfer_funds_screen.dart';
import 'package:lazervault/src/features/presentation/views/upload_image_scren.dart';
import '../../../core/services/injection_container.dart';
import 'views/onboarding_screen.dart';
import 'package:lazervault/src/features/funds/cubit/withdrawal_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/deposit_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_cubit.dart';

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
      page: () => serviceLocator<CryptoScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.stocks,
      page: () => serviceLocator<StocksScreen>(),
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
  ];
}
