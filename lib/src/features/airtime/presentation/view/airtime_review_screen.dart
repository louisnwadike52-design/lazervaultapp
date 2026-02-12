import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import '../../domain/entities/network_provider.dart';
import '../../domain/entities/country.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import '../widgets/airtime_step_indicator.dart';

class AirtimeReviewScreen extends StatefulWidget {
  const AirtimeReviewScreen({super.key});

  @override
  State<AirtimeReviewScreen> createState() => _AirtimeReviewScreenState();
}

class _AirtimeReviewScreenState extends State<AirtimeReviewScreen>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  Country? country;
  NetworkProvider? networkProvider;
  String? phoneNumber;
  String? recipientName;
  double? amount;
  double? fee;
  double? totalAmount;
  String? _selectedAccountId;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _loadArguments();
    _loadAccounts();
  }

  void _loadArguments() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      country = args['country'];
      networkProvider = args['provider'];
      phoneNumber = args['phoneNumber'];
      recipientName = args['recipientName'];
      amount = args['amount'];
      fee = args['fee'];
      totalAmount = args['totalAmount'];
    }
  }

  void _loadAccounts() {
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is! AccountCardsSummaryLoaded) {
      final userId = context.read<AuthenticationCubit>().userId ?? '';
      context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
        userId: userId,
      );
    }
  }

  bool _hasSufficientBalance(dynamic account) {
    final currency = country?.currency ?? 'NGN';
    if (account.currency.toUpperCase() != currency.toUpperCase()) {
      return false;
    }
    return account.balance >= (totalAmount ?? amount ?? 0);
  }

  /// Process payment with transaction PIN validation
  void _processPayment() async {
    if (_isProcessing) return;
    if (_selectedAccountId == null) {
      _showError('Please select an account to pay from');
      return;
    }

    if (networkProvider != null && phoneNumber != null && amount != null && country != null) {
      setState(() => _isProcessing = true);
      final transactionId = 'airtime_${DateTime.now().millisecondsSinceEpoch}_${phoneNumber!.replaceAll(RegExp(r'[^\d]'), '')}';

      final success = await validateTransactionPin(
        context: context,
        transactionId: transactionId,
        transactionType: 'airtime_purchase',
        amount: amount!,
        currency: country!.currency,
        title: 'Confirm Airtime Purchase',
        message: 'Confirm purchase of ${country!.currency} ${amount!.toStringAsFixed(2)} airtime for $phoneNumber?',
        onPinValidated: (verificationToken) async {
          _executePaymentWithToken(transactionId, verificationToken);
        },
      );

      if (!success && mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  /// Execute actual payment with verification token
  void _executePaymentWithToken(String transactionId, String verificationToken) {
    // Navigate to processing screen with all payment params
    Get.toNamed(AppRoutes.airtimePaymentProcessing, arguments: {
      'countryCode': country!.code,
      'networkProviderId': networkProvider!.id,
      'phoneNumber': phoneNumber!,
      'amount': amount!,
      'currency': country!.currency,
      'transactionId': transactionId,
      'verificationToken': verificationToken,
      'sourceAccountId': _selectedAccountId!,
      'providerName': networkProvider!.name,
      'providerType': networkProvider!.type,
      'recipientName': recipientName ?? '',
      'fee': fee ?? 0.0,
      'totalAmount': totalAmount ?? amount!,
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (networkProvider == null || phoneNumber == null || amount == null) {
      return Scaffold(
        backgroundColor: Color(0xFF0A0E27),
        body: Center(
          child: Text(
            'Invalid transaction data',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const AirtimeStepIndicator(currentStep: 3),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    _buildTransactionSummaryCard(),
                    SizedBox(height: 24.h),
                    _buildRecipientDetailsCard(),
                    SizedBox(height: 24.h),
                    _buildAccountSelector(),
                    SizedBox(height: 24.h),
                    _buildPaymentBreakdownCard(),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
            _buildConfirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Review Transaction',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Please confirm your airtime purchase',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionSummaryCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],

      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: networkProvider!.type.color,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: networkProvider!.type.color.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    networkProvider!.name.substring(0, 1),
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 16.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${networkProvider!.name} Airtime',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Airtime Purchase',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white.withValues(alpha: 0.6),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                Text(
                  'Amount',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '${country?.currencySymbol ?? '₦'}${amount!.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientDetailsCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recipient Details',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 16.h),

          _buildDetailRow('Phone Number', phoneNumber!),

          if (recipientName != null && recipientName!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            _buildDetailRow('Recipient Name', recipientName!),
          ],

          SizedBox(height: 12.h),
          _buildDetailRow('Network', networkProvider!.name),

          SizedBox(height: 12.h),
          _buildDetailRow('Country', country?.name ?? 'Nigeria'),
        ],
      ),
    );
  }

  Widget _buildAccountSelector() {
    final currency = country?.currency ?? 'NGN';

    return BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      builder: (context, state) {
        if (state is AccountCardsSummaryLoading) {
          return Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is AccountCardsSummaryLoaded) {
          final matchingCurrencyAccounts = state.accountSummaries
              .where((a) => a.currency.toUpperCase() == currency.toUpperCase())
              .toList();

          final otherCurrencyAccounts = state.accountSummaries
              .where((a) => a.currency.toUpperCase() != currency.toUpperCase())
              .toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Only $currency accounts with sufficient balance can be used',
                style: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 12.h),

              ...matchingCurrencyAccounts.map((account) {
                final isSelected = _selectedAccountId == account.id.toString();
                final hasSufficientBalance = _hasSufficientBalance(account);

                return GestureDetector(
                  onTap: hasSufficientBalance
                      ? () {
                          setState(() {
                            _selectedAccountId = account.id.toString();
                          });
                        }
                      : () {
                          Get.snackbar(
                            'Insufficient Balance',
                            'This account does not have enough funds. You need $currency ${(totalAmount ?? amount!).toStringAsFixed(2)}',
                            backgroundColor: const Color(0xFFFB923C),
                            colorText: Colors.white,
                            snackPosition: SnackPosition.TOP,
                          );
                        },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: !hasSufficientBalance
                          ? const Color(0xFF1F1F1F).withValues(alpha: 0.5)
                          : isSelected
                              ? const Color(0xFF3B82F6).withValues(alpha: 0.1)
                              : const Color(0xFF1F1F1F),
                      border: Border.all(
                        color: !hasSufficientBalance
                            ? const Color(0xFFEF4444).withValues(alpha: 0.3)
                            : isSelected
                                ? const Color(0xFF3B82F6)
                                : Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            color: !hasSufficientBalance
                                ? const Color(0xFFEF4444).withValues(alpha: 0.2)
                                : const Color(0xFF3B82F6).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Icon(
                            Icons.account_balance_wallet,
                            color: !hasSufficientBalance
                                ? const Color(0xFFEF4444)
                                : const Color(0xFF3B82F6),
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      account.accountType,
                                      style: TextStyle(
                                        color: !hasSufficientBalance
                                            ? Colors.white.withValues(alpha: 0.5)
                                            : Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  if (!hasSufficientBalance)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                        vertical: 2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEF4444).withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(4.r),
                                      ),
                                      child: Text(
                                        'Insufficient',
                                        style: TextStyle(
                                          color: const Color(0xFFEF4444),
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              Text(
                                '${account.currency} ${account.balance.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: !hasSufficientBalance
                                      ? const Color(0xFF9CA3AF).withValues(alpha: 0.5)
                                      : const Color(0xFF9CA3AF),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected && hasSufficientBalance)
                          Icon(
                            Icons.check_circle,
                            color: const Color(0xFF3B82F6),
                            size: 24.sp,
                          ),
                      ],
                    ),
                  ),
                );
              }),

              if (otherCurrencyAccounts.isNotEmpty) ...[
                SizedBox(height: 8.h),
                Text(
                  'Other Currencies (not available for this payment)',
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF).withValues(alpha: 0.6),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                ...otherCurrencyAccounts.map((account) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F).withValues(alpha: 0.3),
                      border: Border.all(
                        color: const Color(0xFF2D2D2D).withValues(alpha: 0.5),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2D2D2D).withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Icon(
                            Icons.account_balance_wallet,
                            color: const Color(0xFF9CA3AF).withValues(alpha: 0.5),
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                account.accountType,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.4),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${account.currency} ${account.balance.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: const Color(0xFF9CA3AF).withValues(alpha: 0.4),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildPaymentBreakdownCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Breakdown',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 16.h),

          _buildBreakdownRow('Airtime Amount', amount!),

          SizedBox(height: 8.h),
          _buildBreakdownRow('Service Fee', fee ?? 0.0),

          SizedBox(height: 12.h),
          Divider(color: Colors.white.withValues(alpha: 0.1)),
          SizedBox(height: 12.h),

          _buildBreakdownRow('Total Amount', totalAmount ?? amount!, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white.withValues(alpha: 0.6),
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBreakdownRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16.sp : 14.sp,
            color: isTotal ? Colors.white : Colors.white.withValues(alpha: 0.6),
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        Text(
          '${country?.currencySymbol ?? '₦'}${amount.toStringAsFixed(0)}',
          style: TextStyle(
            fontSize: isTotal ? 16.sp : 14.sp,
            color: Colors.white,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: SizedBox(
        width: double.infinity,
        height: 56.h,
        child: ElevatedButton(
          onPressed: _isProcessing ? null : _processPayment,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF3B82F6),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          child: Text(
            'Confirm Payment',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

}
