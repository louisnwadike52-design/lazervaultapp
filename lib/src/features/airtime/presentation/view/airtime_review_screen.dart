import 'dart:async';
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
import '../cubit/airtime_cubit.dart';
import '../cubit/airtime_state.dart';
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
  bool _autoSelectedAccount = false;

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
    if (accountState is AccountCardsSummaryLoaded) {
      _autoSelectAccount(accountState);
    } else {
      final userId = context.read<AuthenticationCubit>().userId ?? '';
      context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
        userId: userId,
      );
    }
  }

  void _autoSelectAccount(AccountCardsSummaryLoaded state) {
    if (_autoSelectedAccount) return;
    final currency = country?.currency ?? 'NGN';
    final matchingAccounts = state.accountSummaries
        .where((a) => a.currency.toUpperCase() == currency.toUpperCase())
        .toList();

    for (final account in matchingAccounts) {
      if (_hasSufficientBalance(account)) {
        _selectedAccountId = account.id.toString();
        _autoSelectedAccount = true;
        break;
      }
    }
    // If no account with sufficient balance, select the first matching account
    if (_selectedAccountId == null && matchingAccounts.isNotEmpty) {
      _selectedAccountId = matchingAccounts.first.id.toString();
      _autoSelectedAccount = true;
    }
  }

  bool _hasSufficientBalance(dynamic account) {
    final currency = country?.currency ?? 'NGN';
    if (account.currency.toUpperCase() != currency.toUpperCase()) {
      return false;
    }
    return account.balance >= (totalAmount ?? amount ?? 0);
  }

  /// Process payment with transaction PIN validation — payment runs inside PIN modal
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
          // Payment runs inside the PIN modal — modal stays open showing "Processing"
          final cubit = context.read<AirtimeCubit>();
          final completer = Completer<void>();
          StreamSubscription<AirtimeState>? subscription;

          subscription = cubit.stream.listen((state) {
            if (state is AirtimePaymentSuccess) {
              subscription?.cancel();
              // Show success in PIN modal
              pinModalKey.currentState?.setSuccess();
              // Wait for success animation, then close modal and navigate
              Future.delayed(const Duration(milliseconds: 1500), () {
                if (mounted) {
                  Navigator.of(context).pop(); // Close PIN modal
                  Get.offNamed(AppRoutes.airtimePaymentConfirmation, arguments: {
                    'transaction': state.transaction,
                    'isSuccess': true,
                  });
                }
              });
              completer.complete();
            } else if (state is AirtimePaymentFailed) {
              subscription?.cancel();
              pinModalKey.currentState?.setFailed(state.message);
              completer.completeError(Exception(state.message));
            }
          });

          // Trigger the actual payment via cubit
          cubit.processPaymentWithToken(
            countryCode: country!.code,
            networkProviderId: networkProvider!.id,
            phoneNumber: phoneNumber!,
            amount: amount!,
            currency: country!.currency,
            transactionId: transactionId,
            verificationToken: verificationToken,
            sourceAccountId: _selectedAccountId!,
            operatorId: networkProvider!.operatorId,
            reloadlyOperatorId: networkProvider!.reloadlyOperatorId,
          );

          await completer.future;
        },
      );

      if (!success && mounted) {
        setState(() => _isProcessing = false);
      }
    }
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

  void _showAccountChangeSheet() {
    final currency = country?.currency ?? 'NGN';
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is! AccountCardsSummaryLoaded) return;

    final matchingAccounts = accountState.accountSummaries
        .where((a) => a.currency.toUpperCase() == currency.toUpperCase())
        .toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Text(
                'Select Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ...matchingAccounts.map((account) {
              final isSelected = _selectedAccountId == account.id.toString();
              final hasSufficientBalance = _hasSufficientBalance(account);

              return GestureDetector(
                onTap: hasSufficientBalance
                    ? () {
                        setState(() {
                          _selectedAccountId = account.id.toString();
                        });
                        Navigator.pop(sheetContext);
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
                  margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: !hasSufficientBalance
                        ? const Color(0xFF0A0A0A).withValues(alpha: 0.5)
                        : isSelected
                            ? const Color(0xFF3B82F6).withValues(alpha: 0.1)
                            : const Color(0xFF0A0A0A),
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
                            Text(
                              account.accountType,
                              style: TextStyle(
                                color: !hasSufficientBalance
                                    ? Colors.white.withValues(alpha: 0.5)
                                    : Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
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
            SizedBox(height: 20.h),
          ],
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
            const AirtimeStepIndicator(currentStep: 2),
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
          // Auto-select on first load
          if (!_autoSelectedAccount) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() => _autoSelectAccount(state));
              }
            });
          }

          // Find the selected account
          final selectedAccount = _selectedAccountId != null
              ? state.accountSummaries
                  .where((a) => a.id.toString() == _selectedAccountId)
                  .firstOrNull
              : null;

          if (selectedAccount == null) {
            return GestureDetector(
              onTap: _showAccountChangeSheet,
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: const Color(0xFF2D2D2D),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.account_balance_wallet,
                      color: const Color(0xFF3B82F6),
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'Select Account',
                        style: TextStyle(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: const Color(0xFF9CA3AF),
                      size: 14.sp,
                    ),
                  ],
                ),
              ),
            );
          }

          final hasSufficientBalance = _hasSufficientBalance(selectedAccount);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pay From',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: _showAccountChangeSheet,
                    child: Text(
                      'Change',
                      style: TextStyle(
                        color: const Color(0xFF3B82F6),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: hasSufficientBalance
                      ? const Color(0xFF3B82F6).withValues(alpha: 0.1)
                      : const Color(0xFF1F1F1F).withValues(alpha: 0.5),
                  border: Border.all(
                    color: hasSufficientBalance
                        ? const Color(0xFF3B82F6)
                        : const Color(0xFFEF4444).withValues(alpha: 0.3),
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
                        color: hasSufficientBalance
                            ? const Color(0xFF3B82F6).withValues(alpha: 0.2)
                            : const Color(0xFFEF4444).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Icon(
                        Icons.account_balance_wallet,
                        color: hasSufficientBalance
                            ? const Color(0xFF3B82F6)
                            : const Color(0xFFEF4444),
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedAccount.accountType,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${selectedAccount.currency} ${selectedAccount.balance.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
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
                    if (hasSufficientBalance)
                      Icon(
                        Icons.check_circle,
                        color: const Color(0xFF3B82F6),
                        size: 24.sp,
                      ),
                  ],
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildPaymentBreakdownCard() {
    final hasFee = fee != null && fee! > 0;

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

          _buildBreakdownRow(hasFee ? 'Airtime Amount' : 'Amount', amount!, isTotal: !hasFee),

          if (hasFee) ...[
            SizedBox(height: 8.h),
            _buildBreakdownRow('Service Fee', fee!),

            SizedBox(height: 12.h),
            Divider(color: Colors.white.withValues(alpha: 0.1)),
            SizedBox(height: 12.h),

            _buildBreakdownRow('Total Amount', totalAmount ?? amount!, isTotal: true),
          ],
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
          child: _isProcessing
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Processing...',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              : Text(
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
