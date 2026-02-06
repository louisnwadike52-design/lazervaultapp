import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../cubit/create_lock_cubit.dart';
import '../../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import '../../../../account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

/// Payment method selection screen - Step 5 of 5
///
/// Shows real user accounts and allows selection for funding the lock.
/// Follows the same pattern as TagPay payment confirmation.
class PaymentMethodSelector extends StatefulWidget {
  const PaymentMethodSelector({super.key});

  @override
  State<PaymentMethodSelector> createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State<PaymentMethodSelector> {
  String? _selectedAccountId;

  @override
  void initState() {
    super.initState();
    // Ensure accounts are loaded
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is! AccountCardsSummaryLoaded) {
      context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
            userId: 'current_user',
          );
    }

    // Restore previously selected account if any
    final cubit = context.read<CreateLockCubit>();
    if (cubit.selectedAccountId != null) {
      _selectedAccountId = cubit.selectedAccountId;
    }
  }

  /// Check if an account has sufficient balance for the lock amount
  bool _hasSufficientBalance(AccountSummaryEntity account, double amount) {
    return account.balance >= amount;
  }

  /// Check if account currency matches lock currency
  bool _currencyMatches(AccountSummaryEntity account, String lockCurrency) {
    return account.currency.toUpperCase() == lockCurrency.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateLockCubit, CreateLockState>(
      builder: (context, state) {
        final cubit = context.read<CreateLockCubit>();
        final amount = cubit.amount ?? 0.0;
        final currency = cubit.currency;

        return SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payment Method',
                style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Select the account to fund your lock',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(height: 24.h),

              // Amount to Lock Card
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6366F1).withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Amount to Lock',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '${CurrencySymbols.getSymbol(currency)}${amount.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),

              // Account Selector
              _buildAccountSelector(amount, currency, cubit),

              SizedBox(height: 24.h),

              // Security Notice
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.security_rounded,
                      color: const Color(0xFF10B981),
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'Your funds are secured and will earn interest during the lock period',
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF10B981),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAccountSelector(
      double amount, String currency, CreateLockCubit cubit) {
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
          // Filter to only show accounts with matching currency
          final matchingCurrencyAccounts = state.accountSummaries
              .where((a) => _currencyMatches(a, currency))
              .toList();

          final otherCurrencyAccounts = state.accountSummaries
              .where((a) => !_currencyMatches(a, currency))
              .toList();

          if (state.accountSummaries.isEmpty) {
            return _buildNoAccountsMessage();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Account',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Only $currency accounts with sufficient balance can be used',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 12.h),

              // Show matching currency accounts first
              ...matchingCurrencyAccounts.map((account) {
                // account.id is already a String in AccountSummaryEntity
                final isSelected = _selectedAccountId == account.id;
                final hasSufficientBalance =
                    _hasSufficientBalance(account, amount);

                return _buildAccountCard(
                  account: account,
                  isSelected: isSelected,
                  hasSufficientBalance: hasSufficientBalance,
                  amount: amount,
                  currency: currency,
                  cubit: cubit,
                );
              }),

              // Show other currency accounts as disabled
              if (otherCurrencyAccounts.isNotEmpty) ...[
                SizedBox(height: 16.h),
                Text(
                  'Other Currencies (not available for this lock)',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF).withValues(alpha: 0.6),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                ...otherCurrencyAccounts.map((account) {
                  return _buildDisabledAccountCard(account);
                }),
              ],
            ],
          );
        }

        if (state is AccountCardsSummaryError) {
          return _buildErrorMessage(state.message);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildAccountCard({
    required AccountSummaryEntity account,
    required bool isSelected,
    required bool hasSufficientBalance,
    required double amount,
    required String currency,
    required CreateLockCubit cubit,
  }) {
    // Account ID is already a String in AccountSummaryEntity
    final accountId = account.id;

    return GestureDetector(
      onTap: hasSufficientBalance
          ? () {
              // Validate account ID before setting
              if (accountId.isEmpty) {
                Get.snackbar(
                  'Error',
                  'Invalid account selected. Please try again.',
                  backgroundColor: const Color(0xFFEF4444),
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                );
                return;
              }

              setState(() {
                _selectedAccountId = accountId;
              });
              // Update the cubit with selected account
              cubit.updateSelectedAccount(accountId);
              // Also mark payment method as 'wallet' for validation
              cubit.updatePaymentMethod('wallet');
            }
          : () {
              Get.snackbar(
                'Insufficient Balance',
                'This account does not have enough funds. You need $currency ${amount.toStringAsFixed(2)}',
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
                  ? const Color(0xFF6366F1).withValues(alpha: 0.1)
                  : const Color(0xFF1F1F1F),
          border: Border.all(
            color: !hasSufficientBalance
                ? const Color(0xFFEF4444).withValues(alpha: 0.3)
                : isSelected
                    ? const Color(0xFF6366F1)
                    : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: !hasSufficientBalance
                    ? const Color(0xFFEF4444).withValues(alpha: 0.2)
                    : const Color(0xFF6366F1).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Icon(
                Icons.account_balance_wallet,
                color: !hasSufficientBalance
                    ? const Color(0xFFEF4444)
                    : const Color(0xFF6366F1),
                size: 24.sp,
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
                          style: GoogleFonts.inter(
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
                            style: GoogleFonts.inter(
                              color: const Color(0xFFEF4444),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    CurrencySymbols.formatAmountWithCurrency(account.balance, account.currency),
                    style: GoogleFonts.inter(
                      color: !hasSufficientBalance
                          ? const Color(0xFF9CA3AF).withValues(alpha: 0.5)
                          : const Color(0xFF9CA3AF),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected && hasSufficientBalance)
              Icon(
                Icons.check_circle,
                color: const Color(0xFF6366F1),
                size: 24.sp,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisabledAccountCard(AccountSummaryEntity account) {
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
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D2D).withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Icon(
              Icons.account_balance_wallet,
              color: const Color(0xFF9CA3AF).withValues(alpha: 0.5),
              size: 24.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  account.accountType,
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.4),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  CurrencySymbols.formatAmountWithCurrency(account.balance, account.currency),
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF).withValues(alpha: 0.4),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
              vertical: 2.h,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D2D),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              'Wrong Currency',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoAccountsMessage() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            color: const Color(0xFF9CA3AF),
            size: 48.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'No Accounts Found',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'You need an account to create a lock fund. Please create an account first.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorMessage(String message) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFEF4444).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            color: const Color(0xFFEF4444),
            size: 48.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'Error Loading Accounts',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: () {
              context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
                    userId: 'current_user',
                  );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                'Retry',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
