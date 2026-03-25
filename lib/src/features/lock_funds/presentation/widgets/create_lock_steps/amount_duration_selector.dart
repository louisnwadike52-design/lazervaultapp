import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../cubit/create_lock_cubit.dart';
import '../../cubit/lock_funds_cubit.dart';
import '../../cubit/lock_funds_state.dart';
import '../../../../../../core/services/injection_container.dart';
import '../../../../../../core/services/locale_manager.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

/// Amount and duration selection screen - Step 2 of 5
///
/// Allows user to enter amount, select currency and duration
/// Shows live interest calculation preview
class AmountDurationSelector extends StatefulWidget {
  const AmountDurationSelector({super.key});

  @override
  State<AmountDurationSelector> createState() => _AmountDurationSelectorState();
}

class _AmountDurationSelectorState extends State<AmountDurationSelector> {
  final TextEditingController _amountController = TextEditingController();
  static const List<int> _allDurations = [7, 15, 30, 60, 90, 180, 365];

  /// Filter duration options based on backend config min/max for the selected lock type
  List<int> get _durations {
    final cubit = context.read<CreateLockCubit>();
    final lockType = cubit.lockType;
    if (lockType == null) return _allDurations;

    final minDays = cubit.getMinDuration(lockType);
    final maxDays = cubit.getMaxDuration(lockType);

    return _allDurations.where((d) {
      if (minDays > 0 && d < minDays) return false;
      if (maxDays > 0 && d > maxDays) return false;
      return true;
    }).toList();
  }
  late String _userCurrency;
  StreamSubscription<String>? _currencySubscription;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<CreateLockCubit>();

    // Initialize with user's active locale currency from global LocaleManager
    final localeManager = serviceLocator<LocaleManager>();
    _userCurrency = localeManager.currentCurrency;
    cubit.initializeWithUserCurrency(_userCurrency);

    // Listen for currency changes (reactive updates)
    _currencySubscription = localeManager.currencyStream.listen((newCurrency) {
      if (mounted && newCurrency != _userCurrency) {
        setState(() {
          _userCurrency = newCurrency;
        });
        cubit.initializeWithUserCurrency(newCurrency);
      }
    });

    if (cubit.amount != null) {
      _amountController.text = cubit.amount!.toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    _currencySubscription?.cancel();
    _amountController.dispose();
    super.dispose();
  }

  /// Returns currency-aware quick amounts for lock funds
  List<double> _quickAmounts() {
    switch (_userCurrency) {
      case 'NGN':
        return [5000, 10000, 50000, 100000, 500000];
      case 'GBP':
      case 'EUR':
      case 'USD':
        return [100, 500, 1000, 5000, 10000];
      case 'ZAR':
        return [500, 1000, 5000, 10000, 50000];
      default:
        return [100, 500, 1000, 5000, 10000];
    }
  }

  void _calculateInterest() {
    final createCubit = context.read<CreateLockCubit>();
    final lockFundsCubit = context.read<LockFundsCubit>();

    if (createCubit.lockType != null &&
        createCubit.amount != null &&
        createCubit.lockDurationDays != null) {
      lockFundsCubit.calculateInterest(
        lockType: createCubit.lockType!,
        amount: createCubit.amount!,
        lockDurationDays: createCubit.lockDurationDays!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateLockCubit, CreateLockState>(
      builder: (context, createState) {
        final cubit = context.read<CreateLockCubit>();
        final selectedDuration = cubit.lockDurationDays;

        return SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Amount & Duration',
                style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Enter the amount you want to lock and choose duration',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(height: 32.h),

              // Currency Display (user's active currency)
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF6366F1).withValues(alpha: 0.15),
                      const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.account_balance_wallet_outlined,
                        color: const Color(0xFF6366F1),
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Currency',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: const Color(0xFF9CA3AF),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            _userCurrency,
                            style: GoogleFonts.inter(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        'Your account currency',
                        style: GoogleFonts.inter(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF10B981),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Amount Input
              Text(
                'Amount',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 12.h),

              // Quick Amount Buttons (currency-aware)
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: _quickAmounts().map((quickAmount) {
                  return GestureDetector(
                    onTap: () {
                      _amountController.text = quickAmount.toStringAsFixed(0);
                      cubit.updateAmount(quickAmount);
                      _calculateInterest();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF2A2A3E).withValues(alpha: 0.6),
                            const Color(0xFF1F1F35).withValues(alpha: 0.6),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: const Color(0xFF6366F1).withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        quickAmount >= 1000
                            ? '${CurrencySymbols.getSymbol(_userCurrency)}${(quickAmount / 1000).toStringAsFixed(0)}k'
                            : '${CurrencySymbols.getSymbol(_userCurrency)}${quickAmount.toStringAsFixed(0)}',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2A2A3E), Color(0xFF1F1F35)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _amountController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  style: GoogleFonts.inter(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '0.00',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 8.w, right: 12.w, top: 14.h),
                      child: Text(
                        CurrencySymbols.getSymbol(_userCurrency),
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF9CA3AF),
                        ),
                      ),
                    ),
                    prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                  ),
                  onChanged: (value) {
                    final amount = double.tryParse(value);
                    if (amount != null && amount > 0) {
                      cubit.updateAmount(amount);
                      _calculateInterest();
                    }
                  },
                ),
              ),
              SizedBox(height: 24.h),

              // Duration Selector
              Text(
                'Lock Duration',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: _durations.map((days) {
                  final isSelected = selectedDuration == days;
                  return GestureDetector(
                    onTap: () {
                      cubit.updateLockDuration(days);
                      _calculateInterest();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isSelected
                              ? [const Color(0xFF6366F1), const Color.fromARGB(255, 78, 3, 208)]
                              : [const Color(0xFF2A2A3E), const Color(0xFF1F1F35)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: isSelected
                                ? const Color(0xFF6366F1).withValues(alpha: 0.3)
                                : Colors.black.withValues(alpha: 0.2),
                            blurRadius: isSelected ? 12 : 8,
                            offset: Offset(0, isSelected ? 6 : 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            '$days',
                            style: GoogleFonts.inter(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            days == 1 ? 'day' : 'days',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? Colors.white.withValues(alpha: 0.8)
                                  : const Color(0xFF9CA3AF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              // Config-driven rate info
              if (cubit.lockType != null && selectedDuration != null) ...[
                SizedBox(height: 12.h),
                Builder(builder: (context) {
                  final lt = cubit.lockType!;
                  final baseRate = cubit.getBaseRate(lt);
                  final maxRate = cubit.getMaxRate(lt);
                  final rateInfo = maxRate > baseRate
                      ? '${baseRate.toStringAsFixed(0)}% base rate (up to ${maxRate.toStringAsFixed(0)}% with longer duration)'
                      : '${baseRate.toStringAsFixed(0)}% p.a.';
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.info_outline, color: const Color(0xFF10B981), size: 14.sp),
                        SizedBox(width: 6.w),
                        Flexible(
                          child: Text(
                            rateInfo,
                            style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFF10B981)),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
              SizedBox(height: 32.h),

              // Interest Calculation Preview
              BlocBuilder<LockFundsCubit, LockFundsState>(
                builder: (context, lockState) {
                  // Show error if calculation failed
                  if (lockState is LockFundsError &&
                      cubit.lockType != null &&
                      cubit.amount != null &&
                      cubit.lockDurationDays != null) {
                    return Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFEF4444).withValues(alpha: 0.2),
                            const Color(0xFFEF4444).withValues(alpha: 0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            color: const Color(0xFFEF4444),
                            size: 20.sp,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              'Unable to calculate interest. Please try again.',
                              style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFFEF4444),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (lockState is InterestCalculated) {
                    final calc = lockState.calculation;
                    // Store interest calculation in cubit for use in review/receipt
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (context.mounted) {
                        cubit.updateInterestCalculation(calc);
                      }
                    });
                    return Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF10B981).withValues(alpha: 0.2),
                            const Color(0xFF10B981).withValues(alpha: 0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF10B981).withValues(alpha: 0.2),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.trending_up_rounded,
                                color: const Color(0xFF10B981),
                                size: 24.sp,
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                'Estimated Returns',
                                style: GoogleFonts.inter(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          _buildCalculationRow(
                            'Interest Rate',
                            '${(calc.interestRate * 100).toStringAsFixed(1)}% p.a.',
                          ),
                          SizedBox(height: 8.h),
                          _buildCalculationRow(
                            'Interest Earned',
                            '${CurrencySymbols.getSymbol(_userCurrency)}${calc.interestAmount.toStringAsFixed(2)}',
                          ),
                          SizedBox(height: 8.h),
                          Divider(color: Colors.white.withValues(alpha: 0.2)),
                          SizedBox(height: 8.h),
                          _buildCalculationRow(
                            'Total at Maturity',
                            '${CurrencySymbols.getSymbol(_userCurrency)}${calc.totalAmount.toStringAsFixed(2)}',
                            isTotal: true,
                          ),
                          if (calc.qualifiesForUpfrontInterest) ...[
                            SizedBox(height: 12.h),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6366F1).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.bolt_rounded,
                                    color: const Color(0xFF6366F1),
                                    size: 16.sp,
                                  ),
                                  SizedBox(width: 6.w),
                                  Expanded(
                                    child: Text(
                                      'Interest paid upfront to your account',
                                      style: GoogleFonts.inter(
                                        color: const Color(0xFF6366F1),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  }

                  // Show calculation prompt if fields are filled
                  if (cubit.lockType != null &&
                      cubit.amount != null &&
                      cubit.lockDurationDays != null) {
                    return Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF2A2A3E), Color(0xFF1F1F35)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Calculating your returns...',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF9CA3AF),
                          ),
                        ),
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCalculationRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: isTotal ? Colors.white : const Color(0xFF9CA3AF),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 18.sp : 14.sp,
            fontWeight: FontWeight.w700,
            color: isTotal ? const Color(0xFF10B981) : Colors.white,
          ),
        ),
      ],
    );
  }
}
