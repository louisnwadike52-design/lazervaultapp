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

class AirtimeTransferReviewScreen extends StatefulWidget {
  const AirtimeTransferReviewScreen({super.key});

  @override
  State<AirtimeTransferReviewScreen> createState() => _AirtimeTransferReviewScreenState();
}

class _AirtimeTransferReviewScreenState extends State<AirtimeTransferReviewScreen>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  NetworkProvider? provider;
  Country? country;
  String recipientPhone = '';
  String recipientName = '';
  String senderPhone = '';
  double amount = 0;
  double commission = 0;
  double totalCharged = 0;
  String transferNote = '';
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
      provider = args['provider'];
      country = args['country'];
      recipientPhone = args['recipientPhone'] ?? '';
      recipientName = args['recipientName'] ?? '';
      senderPhone = args['senderPhone'] ?? '';
      amount = args['amount'] ?? 0;
      commission = args['commission'] ?? 0;
      totalCharged = args['totalCharged'] ?? 0;
      transferNote = args['transferNote'] ?? '';
    }
  }

  void _loadAccounts() {
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is AccountCardsSummaryLoaded) {
      _autoSelectAccount(accountState);
    } else {
      final userId = context.read<AuthenticationCubit>().userId ?? '';
      context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(userId: userId);
    }
  }

  void _autoSelectAccount(AccountCardsSummaryLoaded state) {
    if (_autoSelectedAccount) return;
    final currency = country?.currency ?? 'NGN';
    final matchingAccounts = state.accountSummaries
        .where((a) => a.currency.toUpperCase() == currency.toUpperCase())
        .toList();

    for (final account in matchingAccounts) {
      if (account.availableBalance >= totalCharged) {
        _selectedAccountId = account.id.toString();
        _autoSelectedAccount = true;
        break;
      }
    }
    if (_selectedAccountId == null && matchingAccounts.isNotEmpty) {
      _selectedAccountId = matchingAccounts.first.id.toString();
      _autoSelectedAccount = true;
    }
  }

  void _processTransfer() async {
    if (_isProcessing) return;
    if (_selectedAccountId == null) {
      Get.snackbar('Error', 'Please select an account to pay from',
          backgroundColor: const Color(0xFFEF4444), colorText: Colors.white,
          snackPosition: SnackPosition.TOP);
      return;
    }

    // Check balance
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is AccountCardsSummaryLoaded) {
      final selectedAccount = accountState.accountSummaries
          .where((a) => a.id.toString() == _selectedAccountId)
          .firstOrNull;
      if (selectedAccount != null && selectedAccount.availableBalance < totalCharged) {
        Get.snackbar(
          'Insufficient Balance',
          'You need \u20A6${totalCharged.toStringAsFixed(2)} but have \u20A6${selectedAccount.availableBalance.toStringAsFixed(2)}',
          backgroundColor: const Color(0xFFEF4444), colorText: Colors.white,
          snackPosition: SnackPosition.TOP, duration: const Duration(seconds: 4),
        );
        return;
      }
    }

    setState(() => _isProcessing = true);
    final transactionId = 'atx_${DateTime.now().millisecondsSinceEpoch}_${recipientPhone.replaceAll(RegExp(r'[^\d]'), '')}';

    String? verificationToken;

    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'airtime_transfer',
      amount: totalCharged,
      currency: country?.currency ?? 'NGN',
      title: 'Confirm Airtime Transfer',
      message: 'Transfer \u20A6${amount.toStringAsFixed(0)} airtime to $recipientPhone\nCommission: \u20A6${commission.toStringAsFixed(2)}',
      onPinValidated: (token) async {
        verificationToken = token;
      },
    );

    if (!success || verificationToken == null) {
      if (mounted) setState(() => _isProcessing = false);
      return;
    }
    if (!mounted) return;

    final cubit = context.read<AirtimeCubit>();
    final completer = Completer<void>();
    StreamSubscription<AirtimeState>? subscription;

    subscription = cubit.stream.listen((state) {
      if (state is AirtimeTransferSuccess) {
        subscription?.cancel();
        if (mounted) {
          Get.offNamed(AppRoutes.airtimePaymentConfirmation, arguments: {
            'transaction': state.transaction,
            'isSuccess': true,
            'isTransfer': true,
            'commission': commission,
          });
        }
        if (!completer.isCompleted) completer.complete();
      } else if (state is AirtimeTransferFailed) {
        subscription?.cancel();
        if (mounted) {
          Get.snackbar('Transfer Failed', state.message,
              backgroundColor: const Color(0xFFEF4444), colorText: Colors.white,
              snackPosition: SnackPosition.TOP);
          setState(() => _isProcessing = false);
        }
        if (!completer.isCompleted) completer.completeError(Exception(state.message));
      }
    });

    cubit.processTransfer(
      countryCode: country?.code ?? 'NG',
      recipientPhone: recipientPhone,
      recipientName: recipientName,
      senderPhone: senderPhone,
      network: provider?.type.name.toUpperCase() ?? 'MTN',
      amount: amount,
      currency: country?.currency ?? 'NGN',
      transactionId: transactionId,
      verificationToken: verificationToken!,
      sourceAccountId: _selectedAccountId!,
      operatorId: provider?.operatorId ?? '',
      transferNote: transferNote,
    );

    try {
      await completer.future.timeout(
        const Duration(seconds: 90),
        onTimeout: () {
          subscription?.cancel();
          if (mounted) {
            Get.snackbar('Timeout', 'Request timed out. Check your transaction history.',
                backgroundColor: const Color(0xFFFB923C), colorText: Colors.white,
                snackPosition: SnackPosition.TOP);
            setState(() => _isProcessing = false);
          }
        },
      );
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: BlocListener<AccountCardsSummaryCubit, AccountCardsSummaryState>(
                listener: (context, state) {
                  if (state is AccountCardsSummaryLoaded) {
                    _autoSelectAccount(state);
                    if (mounted) setState(() {});
                  }
                },
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      _buildTransferSummaryCard(),
                      SizedBox(height: 20.h),
                      _buildDetailsCard(),
                      SizedBox(height: 20.h),
                      _buildFeeBreakdownCard(),
                      SizedBox(height: 20.h),
                      _buildSecurityInfo(),
                      SizedBox(height: 24.h),
                      _buildConfirmButton(),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20.sp),
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            'Review Transfer',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransferSummaryCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFB923C), Color(0xFFEA580C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              if (provider != null)
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(
                      provider!.name.substring(0, 1),
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ),
                ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Airtime Transfer',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    Text(
                      '${provider?.name ?? ''} \u2022 $recipientPhone',
                      style: TextStyle(fontSize: 13.sp, color: Colors.white.withValues(alpha: 0.85)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            '\u20A6${amount.toStringAsFixed(0)}',
            style: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          Text(
            'Airtime to deliver',
            style: TextStyle(fontSize: 13.sp, color: Colors.white.withValues(alpha: 0.8)),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Transfer Details',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white)),
          SizedBox(height: 14.h),
          _detailRow('Recipient', recipientPhone),
          if (recipientName.isNotEmpty) ...[
            _divider(),
            _detailRow('Name', recipientName),
          ],
          _divider(),
          _detailRow('Network', provider?.name ?? ''),
          if (transferNote.isNotEmpty) ...[
            _divider(),
            _detailRow('Note', transferNote),
          ],
        ],
      ),
    );
  }

  Widget _buildFeeBreakdownCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Payment Breakdown',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white)),
          SizedBox(height: 14.h),
          _detailRow('Airtime Amount', '\u20A6${amount.toStringAsFixed(0)}'),
          _divider(),
          _detailRow('Commission', '\u20A6${commission.toStringAsFixed(2)}',
              valueColor: const Color(0xFFFB923C)),
          SizedBox(height: 10.h),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.15)),
          SizedBox(height: 10.h),
          _detailRow('Total Charge', '\u20A6${totalCharged.toStringAsFixed(2)}', isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSecurityInfo() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.shield_outlined, color: const Color(0xFF10B981), size: 20.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'Protected by fund hold. If transfer fails, your funds are automatically refunded.',
              style: TextStyle(fontSize: 12.sp, color: const Color(0xFF10B981)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isProcessing ? null : _processTransfer,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFB923C),
          disabledBackgroundColor: const Color(0xFF2D2D2D),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
          elevation: 0,
        ),
        child: _isProcessing
            ? SizedBox(
                width: 24.w, height: 24.w,
                child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
            : Text(
                'Confirm & Transfer',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }

  Widget _detailRow(String label, String value, {Color? valueColor, bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                fontSize: isTotal ? 15.sp : 13.sp,
                fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
                color: isTotal ? Colors.white : const Color(0xFF9CA3AF),
              )),
          Flexible(
            child: Text(value,
                style: TextStyle(
                  fontSize: isTotal ? 15.sp : 13.sp,
                  fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
                  color: valueColor ?? (isTotal ? Colors.white : Colors.white.withValues(alpha: 0.8)),
                ),
                textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      height: 1,
      color: Colors.white.withValues(alpha: 0.08),
    );
  }
}
