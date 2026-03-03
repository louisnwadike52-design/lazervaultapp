import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/user_tag_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import '../../../account_cards_summary/domain/entities/account_summary_entity.dart';
import '../cubit/tag_pay_cubit.dart';
import '../cubit/tag_pay_state.dart';
import '../../../../../core/types/app_routes.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';

class TagPaymentConfirmationScreen extends StatefulWidget {
  final UserTagEntity tag;

  const TagPaymentConfirmationScreen({
    super.key,
    required this.tag,
  });

  @override
  State<TagPaymentConfirmationScreen> createState() =>
      _TagPaymentConfirmationScreenState();
}

class _TagPaymentConfirmationScreenState
    extends State<TagPaymentConfirmationScreen> with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  String? _selectedAccountId;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    // Ensure accounts are loaded (may not be if navigated directly)
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is! AccountCardsSummaryLoaded) {
      final userId = context.read<AuthenticationCubit>().userId ?? '';
      context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
        userId: userId,
      );
    }
  }

  void _processPayment() async {
    if (_selectedAccountId == null) {
      Get.snackbar(
        'No Account Selected',
        'Please select an account to pay from',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Validate account has sufficient balance (safety check)
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is AccountCardsSummaryLoaded) {
      final selectedAccount = accountState.accountSummaries.firstWhere(
        (a) => a.id.toString() == _selectedAccountId,
        orElse: () => throw Exception('Account not found'),
      );

      if (selectedAccount.currency.toUpperCase() != widget.tag.currency.toUpperCase()) {
        Get.snackbar(
          'Currency Mismatch',
          'Please select a ${widget.tag.currency} account',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      if (selectedAccount.balance < widget.tag.amount) {
        Get.snackbar(
          'Insufficient Balance',
          'Your account balance (${selectedAccount.currency} ${selectedAccount.balance.toStringAsFixed(2)}) is less than the payment amount (${widget.tag.formattedAmount})',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 4),
        );
        return;
      }
    }

    HapticFeedback.mediumImpact();

    final idPrefix = widget.tag.id.length >= 8
        ? widget.tag.id.substring(0, 8)
        : widget.tag.id;
    final transactionId = 'TAG-PAY-$idPrefix';

    final pinResult = await validatePinOnly(
      context: context,
      transactionId: transactionId,
      transactionType: 'tag_payment',
      amount: widget.tag.amount,
      currency: widget.tag.currency,
    );

    if (pinResult == null || !pinResult.success) return;

    setState(() {
      _isProcessing = true;
    });

    if (!mounted) return;
    context.read<TagPayCubit>().payTag(
          tagId: widget.tag.id,
          sourceAccountId: _selectedAccountId!,
          transactionPin: pinResult.verificationToken ?? '',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: BlocListener<TagPayCubit, TagPayState>(
        listener: (context, state) {
          if (state is TagPaidSuccess) {
            setState(() {
              _isProcessing = false;
            });
            Get.offAllNamed(
              AppRoutes.tagPaymentReceipt,
              arguments: {
                'transaction': state.transaction,
                'tag': widget.tag,
              },
            );
          } else if (state is TagPayError) {
            setState(() {
              _isProcessing = false;
            });
            Get.snackbar(
              'Payment Failed',
              state.message,
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              duration: const Duration(seconds: 4),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                SizedBox(height: 32.h),
                _buildPaymentDetails(),
                SizedBox(height: 24.h),
                _buildAccountSelector(),
                SizedBox(height: 32.h),
                _buildPayButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(22.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
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
                'Confirm Payment',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Review and confirm your payment',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentDetails() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  'You\'re Paying',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  widget.tag.formattedAmount,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Divider(color: const Color(0xFF2D2D2D), thickness: 1),
          SizedBox(height: 24.h),
          _buildDetailRow('To', widget.tag.taggerName.isNotEmpty ? widget.tag.taggerName : 'Unknown'),
          SizedBox(height: 16.h),
          if (widget.tag.taggerTagPay.isNotEmpty)
            _buildDetailRow('Tag', '@${widget.tag.taggerTagPay}'),
          if (widget.tag.description.isNotEmpty) ...[
            SizedBox(height: 16.h),
            _buildDetailRow('Description', widget.tag.description),
          ],
          SizedBox(height: 16.h),
          _buildDetailRow(
            'Date',
            '${widget.tag.createdAt.day}/${widget.tag.createdAt.month}/${widget.tag.createdAt.year}',
          ),
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
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  /// Check if an account type is eligible for TagPay
  bool _canPerformTagPay(AccountSummaryEntity account) {
    const eligibleTypes = {
      VirtualAccountType.personal,
      VirtualAccountType.usd,
      VirtualAccountType.gbp,
      VirtualAccountType.eur,
      VirtualAccountType.family,
      VirtualAccountType.main,
    };
    if (!eligibleTypes.contains(account.accountTypeEnum)) return false;
    // Must match the tag's currency
    return account.currency.toUpperCase() == widget.tag.currency.toUpperCase();
  }

  /// Get eligible accounts sorted: sufficient balance first, then by balance descending
  List<AccountSummaryEntity> _getEligibleAccounts(List<AccountSummaryEntity> all) {
    final eligible = all.where(_canPerformTagPay).toList();
    eligible.sort((a, b) {
      final aHas = a.balance >= widget.tag.amount ? 1 : 0;
      final bHas = b.balance >= widget.tag.amount ? 1 : 0;
      if (aHas != bHas) return bHas - aHas;
      return b.balance.compareTo(a.balance);
    });
    return eligible;
  }

  IconData _getAccountIcon(VirtualAccountType type) {
    return switch (type) {
      VirtualAccountType.personal => Icons.account_balance_wallet,
      VirtualAccountType.savings => Icons.savings,
      VirtualAccountType.investment => Icons.trending_up,
      VirtualAccountType.family => Icons.family_restroom,
      VirtualAccountType.business => Icons.business,
      VirtualAccountType.usd || VirtualAccountType.gbp || VirtualAccountType.eur => Icons.currency_exchange,
      VirtualAccountType.main => Icons.account_balance_wallet,
    };
  }

  Color _getAccountColor(VirtualAccountType type) {
    return switch (type) {
      VirtualAccountType.personal => const Color(0xFF3B82F6),
      VirtualAccountType.usd => const Color(0xFF10B981),
      VirtualAccountType.gbp => const Color(0xFF8B5CF6),
      VirtualAccountType.eur => const Color(0xFF06B6D4),
      VirtualAccountType.family => const Color(0xFFF59E0B),
      VirtualAccountType.main => const Color(0xFF3B82F6),
      _ => const Color(0xFF6B7280),
    };
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
          final eligibleAccounts = _getEligibleAccounts(state.accountSummaries);

          if (eligibleAccounts.isEmpty) {
            return Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  Icon(Icons.warning_amber_rounded, color: const Color(0xFFFB923C), size: 32.sp),
                  SizedBox(height: 12.h),
                  Text(
                    'No eligible ${widget.tag.currency} account found',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          // Auto-select first eligible account with sufficient balance
          if (_selectedAccountId == null) {
            final bestAccount = eligibleAccounts.firstWhere(
              (a) => a.balance >= widget.tag.amount,
              orElse: () => eligibleAccounts.first,
            );
            _selectedAccountId = bestAccount.id.toString();
          }

          final displayAccount = eligibleAccounts.firstWhere(
            (a) => a.id.toString() == _selectedAccountId,
            orElse: () => eligibleAccounts.first,
          );
          final hasEnough = displayAccount.balance >= widget.tag.amount;
          final accentColor = _getAccountColor(displayAccount.accountTypeEnum);

          return _buildPaymentCategoryCard(
            icon: _getAccountIcon(displayAccount.accountTypeEnum),
            iconColor: accentColor,
            title: 'Pay with ${displayAccount.accountType}',
            subtitle: '${displayAccount.currency} ${displayAccount.balance.toStringAsFixed(2)}',
            insufficientFunds: !hasEnough,
            isSelected: true,
            onTap: () {},
            onChangeTap: eligibleAccounts.length > 1
                ? () => _showWalletBottomSheet(eligibleAccounts)
                : null,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildPaymentCategoryCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    bool insufficientFunds = false,
    required bool isSelected,
    required VoidCallback onTap,
    VoidCallback? onChangeTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF3B82F6) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      color: iconColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(icon, color: iconColor, size: 22.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          subtitle,
                          style: GoogleFonts.inter(
                            color: insufficientFunds
                                ? const Color(0xFFEF4444)
                                : const Color(0xFF9CA3AF),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check_circle,
                      color: const Color(0xFF3B82F6),
                      size: 24.sp,
                    ),
                ],
              ),
            ),
            if (insufficientFunds)
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                  border: Border(
                    top: BorderSide(color: const Color(0xFFEF4444).withValues(alpha: 0.2)),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: const Color(0xFFEF4444), size: 16.sp),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        onChangeTap != null
                            ? 'Insufficient balance. Tap "Change" to select another wallet.'
                            : 'Insufficient balance for this payment.',
                        style: GoogleFonts.inter(
                          color: const Color(0xFFEF4444),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (onChangeTap != null)
              GestureDetector(
                onTap: onChangeTap,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: const Color(0xFF2D2D2D)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.swap_horiz, color: const Color(0xFF3B82F6), size: 18.sp),
                      SizedBox(width: 6.w),
                      Text(
                        'Change',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF3B82F6),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showWalletBottomSheet(List<AccountSummaryEntity> accounts) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return _buildBottomSheetContainer(
          title: 'Select Wallet',
          children: accounts.map((account) {
            final isSelected = _selectedAccountId == account.id.toString();
            final hasEnough = account.balance >= widget.tag.amount;
            final accentColor = _getAccountColor(account.accountTypeEnum);

            return _buildBottomSheetOption(
              icon: _getAccountIcon(account.accountTypeEnum),
              iconColor: accentColor,
              title: account.accountType,
              subtitle: '${account.currency} ${account.balance.toStringAsFixed(2)}',
              insufficientFunds: !hasEnough,
              isSelected: isSelected,
              onTap: () {
                setState(() {
                  _selectedAccountId = account.id.toString();
                });
                Navigator.pop(sheetContext);
              },
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildBottomSheetContainer({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12.h),
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xFF4B5563),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              children: children,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 16.h),
        ],
      ),
    );
  }

  Widget _buildBottomSheetOption({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    bool insufficientFunds = false,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF3B82F6).withValues(alpha: 0.12)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: isSelected
              ? Border.all(color: const Color(0xFF3B82F6), width: 1.5)
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: iconColor, size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      color: insufficientFunds
                          ? const Color(0xFFEF4444)
                          : const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            if (insufficientFunds)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
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
            if (isSelected)
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Icon(
                  Icons.check_circle,
                  color: const Color(0xFF3B82F6),
                  size: 22.sp,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPayButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isProcessing ? null : _processPayment,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF10B981),
          disabledBackgroundColor: const Color(0xFF10B981).withValues(alpha: 0.5),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: _isProcessing
            ? SizedBox(
                height: 20.h,
                width: 20.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                'Pay ${widget.tag.formattedAmount}',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }
}
