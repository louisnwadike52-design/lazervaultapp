import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:lazervault/core/utils/currency_formatter.dart' as currency_formatter;
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import '../../domain/entities/contactless_payment_entity.dart';
import '../../domain/repositories/contactless_payment_repository.dart';
import '../cubit/contactless_payment_cubit.dart';
import '../cubit/contactless_payment_state.dart';
import 'payment_success_screen.dart';

class PaymentConfirmationScreen extends StatelessWidget {
  final PaymentSessionEntity session;

  const PaymentConfirmationScreen({
    super.key,
    required this.session,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactlessPaymentCubit(
        repository: GetIt.instance<ContactlessPaymentRepository>(),
      )..acknowledgeSessionRead(session.id),
      child: _PaymentConfirmationView(session: session),
    );
  }
}

class _PaymentConfirmationView extends StatefulWidget {
  final PaymentSessionEntity session;

  const _PaymentConfirmationView({required this.session});

  @override
  State<_PaymentConfirmationView> createState() =>
      _PaymentConfirmationViewState();
}

class _PaymentConfirmationViewState extends State<_PaymentConfirmationView>
    with SingleTickerProviderStateMixin {
  final _pinController = TextEditingController();
  String? _selectedAccountId;
  bool _isProcessing = false;
  bool _hasPreSelectedAccount = false;
  final _uuid = const Uuid();

  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _preSelectAccountIfNeeded(List<dynamic> accounts) {
    if (_hasPreSelectedAccount || _selectedAccountId != null) return;

    for (final account in accounts) {
      if (account.balance >= widget.session.amount) {
        _selectedAccountId = account.id;
        _hasPreSelectedAccount = true;
        break;
      }
    }

    if (_selectedAccountId == null && accounts.isNotEmpty) {
      final sortedAccounts = List.from(accounts)
        ..sort((a, b) => b.balance.compareTo(a.balance));
      _selectedAccountId = sortedAccounts.first.id;
      _hasPreSelectedAccount = true;
    }
  }

  IconData _getCategoryIcon(String? category) {
    switch (category?.toLowerCase()) {
      case 'food':
        return Icons.restaurant_rounded;
      case 'transport':
        return Icons.directions_car_rounded;
      case 'shopping':
        return Icons.shopping_bag_rounded;
      case 'services':
        return Icons.build_rounded;
      case 'bills':
        return Icons.receipt_rounded;
      default:
        return Icons.contactless_rounded;
    }
  }

  void _processPayment() {
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

    if (_pinController.text.length != 4) {
      Get.snackbar(
        'Invalid PIN',
        'Please enter your 4-digit transaction PIN',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (widget.session.expiresAt.isBefore(DateTime.now())) {
      Get.snackbar(
        'Session Expired',
        'This payment request has expired. Please scan again.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      Navigator.of(context).pop();
      return;
    }

    setState(() => _isProcessing = true);

    context.read<ContactlessPaymentCubit>().processPayment(
          sessionId: widget.session.id,
          sourceAccountId: _selectedAccountId!,
          transactionId: _uuid.v4(),
          verificationToken: _pinController.text,
        );
  }

  void _handlePinError(
      String message, int attemptsRemaining, bool accountLocked) {
    _pinController.clear();

    if (accountLocked) {
      Get.snackbar(
        'Account Locked',
        'Too many failed PIN attempts. Please contact support.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5),
      );
    } else {
      Get.snackbar(
        'Invalid PIN',
        '$message ($attemptsRemaining attempts remaining)',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A1A3E),
              Color(0xFF0A0E27),
              Color(0xFF0F0F23),
            ],
          ),
        ),
        child: BlocListener<ContactlessPaymentCubit, ContactlessPaymentState>(
          listener: (context, state) {
            if (state is PaymentProcessed) {
              setState(() => _isProcessing = false);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentSuccessScreen(
                    amount: widget.session.amount,
                    currency: widget.session.currency,
                    payerName: state.transaction.payerName,
                    referenceNumber: state.transaction.referenceNumber,
                    isReceiver: false,
                    category: widget.session.category,
                    description: widget.session.description,
                    transactionDate: state.transaction.createdAt,
                    transaction: state.transaction,
                    receiverName: state.transaction.receiverName,
                    receiverUsername: state.transaction.receiverUsername,
                    payerUsername: state.transaction.payerUsername,
                    accountNumber: _selectedAccountId,
                  ),
                ),
              );
            } else if (state is PinValidationFailed) {
              setState(() => _isProcessing = false);
              _handlePinError(
                state.message,
                state.attemptsRemaining,
                state.accountLocked,
              );
            } else if (state is SessionExpired) {
              setState(() => _isProcessing = false);
              Get.snackbar(
                'Session Expired',
                state.message,
                backgroundColor: const Color(0xFFEF4444),
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
                duration: const Duration(seconds: 4),
              );
              Navigator.of(context).pop();
            } else if (state is InsufficientBalance) {
              setState(() => _isProcessing = false);
              Get.snackbar(
                'Insufficient Balance',
                'Your ${state.currency} account has ${state.available.toStringAsFixed(2)} but ${state.required.toStringAsFixed(2)} is required.',
                backgroundColor: const Color(0xFFEF4444),
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
                duration: const Duration(seconds: 4),
              );
            } else if (state is ContactlessPaymentError) {
              setState(() => _isProcessing = false);
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
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.h),
                          _buildPaymentDetails(),
                          SizedBox(height: 24.h),
                          _buildAccountSelector(),
                          SizedBox(height: 24.h),
                          _buildPinInput(),
                          SizedBox(height: 32.h),
                          _buildPayButton(),
                          SizedBox(height: 100.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(22.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
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
      ),
    );
  }

  Widget _buildPaymentDetails() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  width: 64.w,
                  height: 64.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Icon(
                    _getCategoryIcon(widget.session.category),
                    size: 32.sp,
                    color: const Color(0xFF6366F1),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  "You're Paying",
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  widget.session.formattedAmount,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.1),
          ),
          SizedBox(height: 24.h),
          _buildDetailRow('To', widget.session.receiverName),
          SizedBox(height: 16.h),
          _buildDetailRow('Username', '@${widget.session.receiverUsername}'),
          if (widget.session.category != null) ...[
            SizedBox(height: 16.h),
            _buildDetailRow('Category', widget.session.category!),
          ],
          if (widget.session.description != null) ...[
            SizedBox(height: 16.h),
            _buildDetailRow('Description', widget.session.description!),
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

  Widget _buildAccountSelector() {
    return BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      builder: (context, state) {
        if (state is AccountCardsSummaryLoading) {
          return Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF2A2A3E).withValues(alpha: 0.8),
                  const Color(0xFF1F1F35).withValues(alpha: 0.9),
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Center(
              child: CircularProgressIndicator(
                color: const Color(0xFF6366F1),
                strokeWidth: 2,
              ),
            ),
          );
        }

        if (state is AccountCardsSummaryLoaded) {
          final matchingAccounts = state.accountSummaries
              .where((a) => a.currency == widget.session.currency)
              .toList();

          _preSelectAccountIfNeeded(matchingAccounts);

          final hasValidAccount = matchingAccounts.any(
            (a) => a.balance >= widget.session.amount,
          );

          if (matchingAccounts.isEmpty) {
            return Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: const Color(0xFFEF4444),
                    size: 48.sp,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'No ${widget.session.currency} account found',
                    style: GoogleFonts.inter(
                      color: const Color(0xFFEF4444),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!hasValidAccount) ...[
                Container(
                  padding: EdgeInsets.all(12.w),
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: const Color(0xFFEF4444).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: const Color(0xFFEF4444),
                        size: 22.sp,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          'None of your accounts have sufficient balance.',
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
              ],
              Text(
                'Pay From',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h),
              ...matchingAccounts.map((account) {
                final isSelected = _selectedAccountId == account.id;
                final hasInsufficientBalance =
                    account.balance < widget.session.amount;

                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedAccountId = account.id);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? LinearGradient(
                              colors: [
                                const Color(0xFF6366F1)
                                    .withValues(alpha: 0.15),
                                const Color(0xFF8B5CF6)
                                    .withValues(alpha: 0.1),
                              ],
                            )
                          : null,
                      color: isSelected
                          ? null
                          : const Color(0xFF2A2A3E).withValues(alpha: 0.5),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF6366F1)
                            : hasInsufficientBalance
                                ? const Color(0xFFEF4444)
                                    .withValues(alpha: 0.4)
                                : Colors.white.withValues(alpha: 0.1),
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44.w,
                          height: 44.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFF6366F1)
                                .withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            Icons.account_balance_wallet_rounded,
                            color: const Color(0xFF6366F1),
                            size: 22.sp,
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
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Row(
                                children: [
                                  Text(
                                    currency_formatter.CurrencySymbols.formatAmountWithCurrency(account.balance, account.currency),
                                    style: GoogleFonts.inter(
                                      color: hasInsufficientBalance
                                          ? const Color(0xFFEF4444)
                                          : const Color(0xFF9CA3AF),
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  if (hasInsufficientBalance) ...[
                                    SizedBox(width: 8.w),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 6.w,
                                        vertical: 2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEF4444)
                                            .withValues(alpha: 0.15),
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                      ),
                                      child: Text(
                                        'Low',
                                        style: GoogleFonts.inter(
                                          color: const Color(0xFFEF4444),
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Container(
                            width: 28.w,
                            height: 28.w,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF6366F1),
                                  Color(0xFF8B5CF6)
                                ],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check_rounded,
                              color: Colors.white,
                              size: 16.sp,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildPinInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Transaction PIN',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: TextField(
            controller: _pinController,
            keyboardType: TextInputType.number,
            obscureText: true,
            maxLength: 4,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 24.sp,
              letterSpacing: 16,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: '    ',
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF).withValues(alpha: 0.3),
                fontSize: 24.sp,
                letterSpacing: 16,
              ),
              border: InputBorder.none,
              counterText: '',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPayButton() {
    return GestureDetector(
      onTap: _isProcessing ? null : _processPayment,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 18.h),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF10B981), Color(0xFF059669)],
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF10B981).withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: _isProcessing
              ? SizedBox(
                  height: 22.h,
                  width: 22.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  'Pay ${widget.session.formattedAmount}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
        ),
      ),
    );
  }
}
