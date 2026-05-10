import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/lock_fund_entity.dart';
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

  /// Duration chips — admin dashboard ONLY. PiggyVaultConfig is
  /// the single source of truth: every chip the user sees comes
  /// from `piggyvault_configs.duration_options`, scoped per plan.
  /// Empty list = admin hasn't configured this plan; the wizard
  /// renders an explicit empty state instead of falling back to
  /// hardcoded values, so an unconfigured plan is visibly broken
  /// rather than silently using stale presets.
  List<int> get _durations {
    final cubit = context.read<CreateLockCubit>();
    final lockType = cubit.lockType;
    if (lockType == null) return const [];
    return cubit.getDurationOptions(lockType);
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

  /// Quick-amount pills — admin dashboard ONLY. Pulled from
  /// PiggyVaultConfig.quick_amount_options for the active plan.
  /// Empty list = no pills; the user types the amount free-form.
  /// No per-currency hardcoded fallback — plan + currency rows
  /// in the admin dashboard own this list.
  List<double> _quickAmounts() {
    final cubit = context.read<CreateLockCubit>();
    final lockType = cubit.lockType;
    if (lockType == null) return const [];
    return cubit.getQuickAmountOptions(lockType);
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

  /// Called when the user taps a duration chip. Pops a confirmation
  /// dialog showing the plan name + selected duration + computed
  /// maturity date + estimated interest at that duration. Only
  /// commits the choice (cubit + interest recalc) when the user
  /// taps Accept — Cancel restores the prior selection.
  ///
  /// Industry-standard pattern: never silently mutate critical
  /// state (lock duration drives the maturity payout) on a single
  /// chip tap. Two-step confirmation matches the donation /
  /// withdraw flows already in this app.
  Future<void> _onDurationTapped(int days) async {
    final cubit = context.read<CreateLockCubit>();
    final lockType = cubit.lockType;
    if (lockType == null) return;

    // Show the modal with the candidate days + a dry-run interest
    // estimate (computed inline so we don't have to push a stale
    // calculation into the parent cubit if the user cancels).
    final accepted = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (dialogCtx) => _DurationConfirmationDialog(
        lockType: lockType,
        days: days,
        amount: cubit.amount ?? 0,
        currency: cubit.currency,
        baseRatePercent: cubit.getBaseRate(lockType),
        maxRatePercent: cubit.getMaxRate(lockType),
        penaltyPercent: cubit.getPenaltyRate(lockType),
        allowsEarlyWithdrawal: cubit.getAllowsEarlyWithdrawal(lockType),
        planDisplayName: cubit.getDisplayName(lockType),
      ),
    );
    if (accepted != true) return;
    cubit.updateLockDuration(days);
    _calculateInterest();
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

              // Duration Selector — admin-driven only.
              //
              // Three render branches:
              //   1. Plan has no fixed term (admin-set min=max=0 +
              //      no chips supplied): hide the entire block. The
              //      cubit's validateStep2 treats min=0 AND max=0
              //      as "flex; no duration required".
              //   2. Plan has a fixed term but admin hasn't supplied
              //      a chip list: show an explicit empty state so
              //      the gap is visible to ops.
              //   3. Plan has chips: render them.
              if (() {
                final lt = cubit.lockType;
                if (lt == null) return false;
                final minD = cubit.getMinDuration(lt);
                final maxD = cubit.getMaxDuration(lt);
                return minD > 0 || maxD > 0;
              }()) ...[
                Text(
                  'Lock Duration',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12.h),
                if (_durations.isEmpty)
                  Container(
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                          color:
                              const Color(0xFFF59E0B).withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline_rounded,
                            color: const Color(0xFFF59E0B), size: 18.sp),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            'No durations are configured for this plan. Ask your admin to add duration options on the dashboard.',
                            style: GoogleFonts.inter(
                              color: const Color(0xFFFBBF24),
                              fontSize: 12.sp,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Wrap(
                    spacing: 12.w,
                    runSpacing: 12.h,
                    children: _durations.map((days) {
                  final isSelected = selectedDuration == days;
                  return GestureDetector(
                    onTap: () => _onDurationTapped(days),
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
              ],
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

/// Confirmation dialog shown when the user taps a duration chip.
///
/// Renders a compact summary of the candidate selection — plan
/// name, duration, computed maturity date, headline rate, and
/// optional estimated interest if an amount has been entered —
/// plus an Accept / Cancel pair. Pops with `true` when the user
/// confirms, `false` (or null on barrier-dismiss) on cancel. The
/// caller commits the cubit state only on `true`.
class _DurationConfirmationDialog extends StatelessWidget {
  final LockType lockType;
  final int days;
  final double amount;
  final String currency;
  final double baseRatePercent;
  final double maxRatePercent;
  final double penaltyPercent;
  final bool allowsEarlyWithdrawal;
  final String planDisplayName;

  const _DurationConfirmationDialog({
    required this.lockType,
    required this.days,
    required this.amount,
    required this.currency,
    required this.baseRatePercent,
    required this.maxRatePercent,
    required this.penaltyPercent,
    required this.allowsEarlyWithdrawal,
    required this.planDisplayName,
  });

  // Simple-interest projection — the actual settlement uses
  // server-side rules including duration bonuses, so the figure
  // here is an estimate. Surface it as such ("estimated").
  double get _estimatedInterest {
    if (amount <= 0 || days <= 0) return 0;
    final annual = baseRatePercent / 100;
    return amount * annual * (days / 365);
  }

  String _durationLabel() {
    if (days < 30) return '$days day${days == 1 ? '' : 's'}';
    if (days < 365) {
      final months = (days / 30).round();
      return '$months month${months == 1 ? '' : 's'}';
    }
    final years = (days / 365).round();
    return '$years year${years == 1 ? '' : 's'}';
  }

  @override
  Widget build(BuildContext context) {
    final maturity = DateTime.now().add(Duration(days: days));
    final maturityLabel =
        '${maturity.year}-${maturity.month.toString().padLeft(2, '0')}-${maturity.day.toString().padLeft(2, '0')}';
    final estimate = _estimatedInterest;
    final symbol = CurrencySymbols.getSymbol(currency);

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      backgroundColor: Colors.transparent,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: const Color(0xFF4E03D0).withValues(alpha: 0.35),
            width: 1,
          ),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 18.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4E03D0).withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(Icons.lock_clock_rounded,
                      color: const Color(0xFF8B5CF6), size: 20.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Confirm lock duration',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                          )),
                      SizedBox(height: 2.h),
                      Text(planDisplayName,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF8B5CF6),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: const Color(0xFF0A0A0A),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  _row('Duration', _durationLabel()),
                  SizedBox(height: 8.h),
                  _row('Matures on', maturityLabel),
                  SizedBox(height: 8.h),
                  _row(
                    'Rate',
                    maxRatePercent > baseRatePercent
                        ? '${baseRatePercent.toStringAsFixed(0)}% – ${maxRatePercent.toStringAsFixed(0)}% p.a.'
                        : '${baseRatePercent.toStringAsFixed(0)}% p.a.',
                  ),
                  if (estimate > 0) ...[
                    SizedBox(height: 8.h),
                    _row(
                      'Estimated interest',
                      '$symbol${estimate.toStringAsFixed(2)}',
                      valueColor: const Color(0xFF10B981),
                    ),
                  ],
                  SizedBox(height: 8.h),
                  _row(
                    'Early exit',
                    allowsEarlyWithdrawal
                        ? (penaltyPercent > 0
                            ? '${penaltyPercent.toStringAsFixed(0)}% penalty'
                            : 'Allowed, no penalty')
                        : 'Not permitted',
                    valueColor: allowsEarlyWithdrawal
                        ? Colors.white
                        : const Color(0xFFFB923C),
                  ),
                ],
              ),
            ),
            if (estimate > 0) ...[
              SizedBox(height: 8.h),
              Text(
                'Estimate uses the base rate and assumes the lock runs to maturity. Actual payout may include duration bonuses.',
                style: GoogleFonts.inter(
                  color: const Color(0xFF6B7280),
                  fontSize: 10.sp,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
              ),
            ],
            SizedBox(height: 18.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                          color: Color(0xFF3D3D3D), width: 1),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4E03D0),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Accept',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            )),
        Text(value,
            style: GoogleFonts.inter(
              color: valueColor ?? Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
            )),
      ],
    );
  }
}
