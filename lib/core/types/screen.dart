import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/types/electricity_bill_details.dart';
import 'package:lazervault/core/types/transaction.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/presentation/views/change_pin_screen.dart';
import 'package:lazervault/src/features/presentation/views/cb_currency_exchange/cb_currency_exchange_screen.dart';
import 'package:lazervault/src/features/presentation/views/dashboard/transaction_history_screen.dart';
import 'package:lazervault/src/features/presentation/views/languages_screen.dart';
import 'package:lazervault/src/features/presentation/views/lifestyle/lifestyle_screen.dart';
import 'package:lazervault/src/features/presentation/views/my_account_screen.dart';
import 'package:lazervault/src/features/presentation/views/otp_verification_screen.dart';
import 'package:lazervault/src/features/presentation/views/profile_settings_screen.dart';
import 'package:lazervault/src/features/presentation/views/review_electricity_bills_screen.dart';
import 'package:lazervault/src/features/presentation/views/input_pin_screen.dart';
import 'package:lazervault/src/features/presentation/views/new_card_screen.dart';
import 'package:lazervault/src/features/presentation/views/notification_screen.dart';
import 'package:lazervault/src/features/presentation/views/pay_electricity_bill_screen.dart';
import 'package:lazervault/src/features/presentation/views/review_funds_transfer_screen.dart';
import 'package:lazervault/src/features/presentation/views/review_transfer_funds_screen.dart';
import 'package:lazervault/src/features/recipients/presentation/view/add_recipient_screen.dart';
import 'package:lazervault/src/features/recipients/presentation/view/select_recipient_screen.dart';
import 'package:lazervault/src/features/presentation/views/send_fund_receipt_screen.dart';
import 'package:lazervault/src/features/presentation/views/send_fund_screen.dart';
import 'package:lazervault/src/features/presentation/views/set_fingerprint_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/passcode_sign_in_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/sign_up_screen.dart';
import 'package:lazervault/src/features/presentation/views/transfer_funds_screen.dart';
import 'package:lazervault/src/features/ai_chats/presentation/view/ai_chats_screen.dart';
import 'package:lazervault/src/features/crowdfund/presentation/views/crowdfund_list_screen.dart';
import 'package:lazervault/src/features/crowdfund/presentation/cubit/crowdfund_cubit.dart';

import 'package:lazervault/src/features/widgets/dashboard/dashboard.dart';
import 'package:lazervault/src/features/widgets/my_cards.dart';
import 'package:lazervault/src/features/widgets/statistics.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_cubit.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/core/services/injection_container.dart';

class Screen {
  final ScreenName name;
  final dynamic param1;
  final dynamic param2;

  const Screen({required this.name, this.param1, this.param2});

  Widget get widget {
    switch (name) {
      case ScreenName.dashboard:
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => serviceLocator<ProfileCubit>()..getUserProfile(),
            ),
            BlocProvider(
              create: (context) => serviceLocator<StatisticsCubit>(),
            ),
          ],
          child: const Dashboard(),
        );
      case ScreenName.statistics:
        return BlocProvider(
          create: (context) => serviceLocator<StatisticsCubit>(),
          child: const Statistics(),
        );
      case ScreenName.myCards:
        return const MyCards();
      case ScreenName.notifications:
        return const NotificationScreen();
      case ScreenName.newCard:
        return const NewCardScreen();
      case ScreenName.selectRecipient:
        return const SelectRecipientScreen();
      case ScreenName.addRecipient:
        return const AddRecipientScreen();
      case ScreenName.inputPin:
        return InputPinScreen(recipient: param1 as User);
      case ScreenName.payElectricityBill:
        return const PayElectricityBillScreen();
      case ScreenName.profileSettings:
        return const ProfileSettingsScreen();
      case ScreenName.myAccount:  
        return const MyAccountScreen();
      case ScreenName.languages:
        return const LanguagesScreen();
      case ScreenName.setFingerPrint:
        return const SetFingerPrintScreen();
      case ScreenName.changePin:
        return const ChangePinScreen();
      case ScreenName.signUP:
        return const SignUpScreen();
      case ScreenName.signIn:
        return const PasscodeSignInScreen();
      case ScreenName.otpVerification:
        return const OTPVerificationScreen();
      case ScreenName.reviewFundsTransfer:
        return ReviewFundsTransferScreen(
          recipient: param1,
        );
      case ScreenName.sendFunds:
        return SendFundScreen(
          recipient: param1,
        );
      case ScreenName.requestFunds:
        return SendFundScreen(
          recipient: param1,
        );
      case ScreenName.sendFundReceipt:
        return SendFundReceiptScreen(
          transaction: param1 as Transaction,
        );
      case ScreenName.reviewElectricityBills:
        return ReviewElectricityBillsScreen(
          electricityBillDetails: param1 as ElectricityBillDetails,
        );
      case ScreenName.transferFunds:
        return TransferFundsScreen(
          user: param1 as User,
          transaction: param2 as TransferTransaction,
        );
      case ScreenName.reviewTransferFunds:
        return ReviewTransferFundsScreen(
          user: param1 as User,
          transaction: param2 as TransferTransaction,
        );
      case ScreenName.transactionHistory:
        return const TransactionHistoryScreen();
      case ScreenName.aiChat:
          return const AiChats();
      case ScreenName.currencyExchange:
        return const CBCurrencyExchangeScreen();
      case ScreenName.lifeStyle:
        return const LifeStyleScreen();
      case ScreenName.crowdfund:
        return BlocProvider(
          create: (context) => serviceLocator<CrowdfundCubit>()..loadCrowdfunds(),
          child: const CrowdfundListScreen(),
        );
    }
  }
}

enum ScreenName {
  dashboard('Dashboard'),
  statistics('Statistics'),
  myCards('My Cards'),
  notifications('Notifications'),
  newCard('Add New Card'),
  selectRecipient('Select Recipient'),
  addRecipient('Add New Recipient'),
  inputPin('Confirm Pin'),
  sendFunds('Send Money'),
  sendFundReceipt('Receipt'),
  reviewFundsTransfer('Review your transfer'),
  requestFunds('Request Payment'),
  payElectricityBill('Electricity Bill'),
  reviewElectricityBills('Information'),
  transferFunds('Transfer'),
  reviewTransferFunds('Confirmation'),
  profileSettings('Settings'),
  languages('Languages'),
  setFingerPrint('Set Fingerprint'),
  myAccount('My Account'),
  changePin('Change Pin'),
  signUP('Sign Up'),
  signIn('Sign In'),
  otpVerification('Verify OTP'),
  transactionHistory('Transaction History'),
  aiChat('AI Chat'),
  currencyExchange('Currency Exchange'),
  lifeStyle('Life Style'),
  crowdfund('Crowdfunding');

  final String displayName;

  const ScreenName(this.displayName);
}

List<Screen> screens = [
  Screen(name: ScreenName.dashboard),
  Screen(name: ScreenName.statistics),
  Screen(name: ScreenName.myCards),
  Screen(name: ScreenName.notifications),
  Screen(name: ScreenName.newCard),
  Screen(name: ScreenName.sendFunds),
  Screen(name: ScreenName.inputPin),
  Screen(name: ScreenName.sendFundReceipt),
  Screen(name: ScreenName.payElectricityBill),
  Screen(name: ScreenName.reviewElectricityBills),
  Screen(name: ScreenName.otpVerification),
  Screen(name: ScreenName.transactionHistory),
  Screen(name: ScreenName.aiChat),
  Screen(name: ScreenName.currencyExchange),
  Screen(name: ScreenName.lifeStyle),
    ];

class TransactionCard {
  final Color titleColor;
  final Color subTitleColor;
  final Color backgroundColor;
  final String image;
  final Transaction transaction;

  const TransactionCard({
    required this.titleColor,
    required this.subTitleColor,
    required this.backgroundColor,
    required this.image,
    required this.transaction,
  });
}
