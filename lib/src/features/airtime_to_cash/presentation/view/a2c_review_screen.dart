import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import '../../domain/entities/network_rate.dart';
import '../cubit/airtime_to_cash_cubit.dart';
import '../cubit/airtime_to_cash_state.dart';
import '../widgets/a2c_step_indicator.dart';

class A2CReviewScreen extends StatefulWidget {
  const A2CReviewScreen({super.key});

  @override
  State<A2CReviewScreen> createState() => _A2CReviewScreenState();
}

class _A2CReviewScreenState extends State<A2CReviewScreen>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  String? phoneNumber;
  String? network;
  double? amount;
  NetworkRate? rate;
  double? estimatedCash;
  String? _selectedAccountId;
  bool _isProcessing = false;
  bool _autoSelectedAccount = false;
  bool _isOTPRequestInProgress = false;
  bool _hasValidArguments = false;

  @override
  void initState() {
    super.initState();
    _loadArguments();
    if (_hasValidArguments) {
      _loadAccounts();
    }
  }

  void _loadArguments() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args == null) {
      _hasValidArguments = false;
      return;
    }

    phoneNumber = args['phoneNumber'] as String?;
    network = args['network'] as String?;
    amount = args['amount'] as double?;
    rate = args['rate'] as NetworkRate?;
    estimatedCash = args['estimatedCash'] as double?;

    // All required fields must be present
    _hasValidArguments = phoneNumber != null &&
        phoneNumber!.isNotEmpty &&
        network != null &&
        network!.isNotEmpty &&
        amount != null &&
        rate != null;
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
    final matchingAccounts = state.accountSummaries
        .where((a) => a.currency.toUpperCase() == 'NGN')
        .toList();

    for (final account in matchingAccounts) {
      _selectedAccountId = account.id.toString();
      _autoSelectedAccount = true;
      break;
    }
    if (_selectedAccountId == null && matchingAccounts.isNotEmpty) {
      _selectedAccountId = matchingAccounts.first.id.toString();
      _autoSelectedAccount = true;
    }
  }

  void _onProceed() {
    // Double-tap prevention: block if already processing or OTP request in flight
    if (_isProcessing || _isOTPRequestInProgress) return;
    if (_selectedAccountId == null) {
      _showError('Please select an account to receive funds');
      return;
    }
    if (phoneNumber == null || network == null || amount == null) return;

    setState(() {
      _isProcessing = true;
      _isOTPRequestInProgress = true;
    });
    context.read<AirtimeToCashCubit>().requestOTP(phoneNumber!, network!);
  }

  void _handleOTPSent(AirtimeToCashOTPSent state) {
    if (!mounted) return;
    setState(() => _isOTPRequestInProgress = false);

    if (state.sessionId.isEmpty) {
      _showError('Failed to initiate verification. Please try again.');
      setState(() => _isProcessing = false);
      return;
    }

    if (state.otpRequired) {
      // Navigate to OTP screen
      Get.toNamed(AppRoutes.airtimeToCashOTP, arguments: {
        'phoneNumber': phoneNumber,
        'network': network,
        'amount': amount,
        'rate': rate,
        'estimatedCash': estimatedCash,
        'sessionId': state.sessionId,
        'sourceAccountId': _selectedAccountId,
      });
      setState(() => _isProcessing = false);
    } else {
      // OTP not required — go straight to PIN validation
      _proceedWithPinValidation(state.sessionId, '');
    }
  }

  Future<void> _proceedWithPinValidation(
      String sessionId, String sessionToken) async {
    final transactionId =
        'a2c_${DateTime.now().millisecondsSinceEpoch}_${phoneNumber!.replaceAll(RegExp(r'[^\d]'), '')}';

    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'airtime_to_cash',
      amount: amount!,
      currency: 'NGN',
      title: 'Confirm Conversion',
      message:
          'Convert \u20A6${amount!.toStringAsFixed(0)} $network airtime to cash?',
      onPinValidated: (verificationToken) async {
        final cubit = context.read<AirtimeToCashCubit>();
        final completer = Completer<void>();
        StreamSubscription<AirtimeToCashState>? subscription;

        subscription = cubit.stream.listen((s) {
          if (s is AirtimeToCashSuccess) {
            subscription?.cancel();
            pinModalKey.currentState?.setSuccess();
            Future.delayed(const Duration(milliseconds: 1500), () {
              if (mounted) {
                Navigator.of(context).pop(); // Close PIN modal
                Get.offNamed(AppRoutes.airtimeToCashProcessing, arguments: {
                  'phoneNumber': phoneNumber,
                  'network': network,
                  'amount': amount,
                  'rate': rate,
                  'estimatedCash': estimatedCash,
                  'sessionToken': sessionToken,
                  'transactionId': transactionId,
                  'verificationToken': verificationToken,
                  'sourceAccountId': _selectedAccountId,
                  'isAlreadyProcessed': true,
                  'conversion': s.conversion,
                  'newBalance': s.newBalance,
                });
              }
            });
            if (!completer.isCompleted) completer.complete();
          } else if (s is AirtimeToCashProcessingPending) {
            subscription?.cancel();
            pinModalKey.currentState?.setSuccess();
            Future.delayed(const Duration(milliseconds: 1500), () {
              if (mounted) {
                Navigator.of(context).pop(); // Close PIN modal
                Get.offNamed(AppRoutes.airtimeToCashProcessing, arguments: {
                  'phoneNumber': phoneNumber,
                  'network': network,
                  'amount': amount,
                  'rate': rate,
                  'estimatedCash': estimatedCash,
                  'sessionToken': sessionToken,
                  'transactionId': transactionId,
                  'verificationToken': verificationToken,
                  'sourceAccountId': _selectedAccountId,
                  'isAlreadyProcessed': true,
                  'isProcessingPending': true,
                  'conversion': s.conversion,
                  'message': s.message,
                });
              }
            });
            if (!completer.isCompleted) completer.complete();
          } else if (s is AirtimeToCashFailed) {
            subscription?.cancel();
            pinModalKey.currentState?.setFailed(s.message);
            if (!completer.isCompleted) {
              completer.completeError(Exception(s.message));
            }
          }
        });

        cubit.processConversion(
          phoneNumber: phoneNumber!,
          network: network!,
          amount: amount!,
          sessionToken: sessionToken,
          transactionId: transactionId,
          verificationToken: verificationToken,
          sourceAccountId: _selectedAccountId,
        );

        await completer.future.timeout(
          const Duration(seconds: 90),
          onTimeout: () {
            subscription?.cancel();
            if (!completer.isCompleted) {
              pinModalKey.currentState?.setFailed('Request timed out. Check your conversion history.');
            }
          },
        );
      },
    );

    if (!success && mounted) {
      setState(() {
        _isProcessing = false;
        _isOTPRequestInProgress = false;
      });
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
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is! AccountCardsSummaryLoaded) return;

    final matchingAccounts = accountState.accountSummaries
        .where((a) => a.currency.toUpperCase() == 'NGN')
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

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedAccountId = account.id.toString();
                  });
                  Navigator.pop(sheetContext);
                },
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF3B82F6).withValues(alpha: 0.1)
                        : const Color(0xFF0A0A0A),
                    border: Border.all(
                      color: isSelected
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
                          color:
                              const Color(0xFF3B82F6).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Icon(
                          Icons.account_balance_wallet,
                          color: const Color(0xFF3B82F6),
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
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'NGN ${account.availableBalance.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
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
    // Null safety: if required arguments are missing, show error and allow pop back
    if (!_hasValidArguments) {
      return Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: const Color(0xFFEF4444),
                    size: 48.sp,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Invalid conversion data',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Required conversion details are missing. Please go back and try again.',
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Prevent back navigation during OTP request
    return PopScope(
      canPop: !_isOTPRequestInProgress,
      child: BlocListener<AirtimeToCashCubit, AirtimeToCashState>(
        listener: (context, state) {
          if (state is AirtimeToCashOTPSent) {
            _handleOTPSent(state);
          } else if (state is AirtimeToCashError) {
            setState(() {
              _isProcessing = false;
              _isOTPRequestInProgress = false;
            });
            _showError(state.message);
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFF0A0A0A),
          body: SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                const A2CStepIndicator(currentStep: 2),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        _buildConversionSummaryCard(),
                        SizedBox(height: 24.h),
                        _buildConversionDetailsCard(),
                        SizedBox(height: 24.h),
                        _buildAccountSelector(),
                        SizedBox(height: 40.h),
                      ],
                    ),
                  ),
                ),
                _buildProceedButton(),
              ],
            ),
          ),
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
            onTap: _isOTPRequestInProgress ? null : () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: _isOTPRequestInProgress
                    ? const Color(0xFF9CA3AF)
                    : Colors.white,
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
                  'Review Conversion',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Please confirm your airtime-to-cash conversion',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
          if (!_isOTPRequestInProgress)
            GestureDetector(
              onTap: () => Get.until((route) => route.settings.name == AppRoutes.airtimeToCash || route.isFirst),
              child: Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.close,
                  color: const Color(0xFF9CA3AF),
                  size: 20.sp,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildConversionSummaryCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
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
                  color: const Color(0xFF3B82F6),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.swap_horiz,
                    color: Colors.white,
                    size: 28.sp,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Airtime to Cash',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '$network Network',
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
                  'Estimated Cash',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '\u20A6${estimatedCash?.toStringAsFixed(2) ?? '0.00'}',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF10B981),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConversionDetailsCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Conversion Details',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          _buildDetailRow('Network', network ?? ''),
          SizedBox(height: 12.h),
          _buildDetailRow('Phone Number', phoneNumber ?? ''),
          SizedBox(height: 12.h),
          _buildDetailRow(
              'Airtime Amount', '\u20A6${amount?.toStringAsFixed(2) ?? '0.00'}'),
          SizedBox(height: 12.h),
          _buildDetailRow('Conversion Rate', rate?.ratePercentage ?? ''),
          SizedBox(height: 12.h),
          _buildDetailRow('Automation Fee', rate?.formattedFee ?? ''),
          SizedBox(height: 12.h),
          Divider(color: Colors.white.withValues(alpha: 0.1)),
          SizedBox(height: 12.h),
          _buildDetailRow(
            'Estimated Cash to Receive',
            '\u20A6${estimatedCash?.toStringAsFixed(2) ?? '0.00'}',
            isHighlighted: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value,
      {bool isHighlighted = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isHighlighted ? 15.sp : 14.sp,
            color: isHighlighted
                ? Colors.white
                : Colors.white.withValues(alpha: 0.6),
            fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isHighlighted ? 15.sp : 14.sp,
            color: isHighlighted ? const Color(0xFF10B981) : Colors.white,
            fontWeight: isHighlighted ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
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
          if (!_autoSelectedAccount) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() => _autoSelectAccount(state));
              }
            });
          }

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

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Credit To',
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
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                  border: Border.all(
                    color: const Color(0xFF3B82F6),
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
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Icon(
                        Icons.account_balance_wallet,
                        color: const Color(0xFF3B82F6),
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
                            'NGN ${selectedAccount.availableBalance.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
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

  Widget _buildProceedButton() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: SizedBox(
        width: double.infinity,
        height: 56.h,
        child: ElevatedButton(
          onPressed: _isProcessing ? null : _onProceed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3B82F6),
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
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Requesting OTP...',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              : Text(
                  'Proceed',
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
