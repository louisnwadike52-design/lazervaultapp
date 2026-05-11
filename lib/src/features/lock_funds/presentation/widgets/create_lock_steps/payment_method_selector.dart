import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';

import '../../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import '../../../../account_cards_summary/domain/entities/account_summary_entity.dart';
import '../../cubit/create_lock_cubit.dart';

/// Payment slide — step 5 of 5.
///
///   - Shows the dashboard's primary same-currency account as a
///     static row. No picker; the resolver handles fallback for
///     missing-currency / insufficient-balance cases inline.
///   - Upfront-interest destination is a separate dropdown picker
///     (_InterestDestinationPickerSheet) — only renders when the
///     admin enabled `supports_upfront_interest` for the plan.
///   - Folds the Auto-Renew toggle and admin-driven Confirmation
///     Notes panel in here so "what's about to happen" copy sits
///     right next to the confirm action.
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
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is! AccountCardsSummaryLoaded) {
      final userId = context.read<AuthenticationCubit>().userId ?? '';
      context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
            userId: userId,
          );
    }
    final cubit = context.read<CreateLockCubit>();
    if (cubit.selectedAccountId != null) {
      _selectedAccountId = cubit.selectedAccountId;
    }
  }

  bool _hasSufficientBalance(AccountSummaryEntity a, double amount) =>
      a.availableBalance >= amount;

  bool _currencyMatches(AccountSummaryEntity a, String currency) =>
      a.currency.toUpperCase() == currency.toUpperCase();

  /// Pick the row to render as the headline "active account":
  ///   1. Whatever the user already selected on this slide (if it
  ///      still exists in the loaded list).
  ///   2. Otherwise the first matching-currency account with
  ///      sufficient balance.
  ///   3. Otherwise the first matching-currency account regardless
  ///      of balance, so the user sees a real account + the
  ///      "Insufficient" badge instead of a disabled placeholder.
  ///   4. Otherwise null — caller renders [_buildNoAccountsMessage].
  AccountSummaryEntity? _resolveActiveAccount(
    List<AccountSummaryEntity> accounts,
    double amount,
    String currency,
  ) {
    if (accounts.isEmpty) return null;
    if (_selectedAccountId != null) {
      for (final a in accounts) {
        if (a.id == _selectedAccountId) return a;
      }
    }
    final matching = accounts.where((a) => _currencyMatches(a, currency)).toList();
    if (matching.isEmpty) return accounts.first;
    final eligible = matching
        .where((a) => _hasSufficientBalance(a, amount))
        .toList();
    return eligible.isNotEmpty ? eligible.first : matching.first;
  }

  void _selectAccount(AccountSummaryEntity account, double amount) {
    final cubit = context.read<CreateLockCubit>();
    if (account.id.isEmpty) {
      Get.snackbar(
        'Error',
        'Invalid account selected. Please try again.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }
    setState(() => _selectedAccountId = account.id);
    cubit.updateSelectedAccount(account.id);
    cubit.updatePaymentMethod('wallet');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateLockCubit, CreateLockState>(
      builder: (context, _) {
        final cubit = context.read<CreateLockCubit>();
        final amount = cubit.amount ?? 0.0;
        final currency = cubit.currency;

        return SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pay & confirm',
                style: GoogleFonts.inter(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'Choose the account to fund this lock',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(height: 20.h),
              _buildAmountChip(amount, currency),
              SizedBox(height: 18.h),
              _buildAccountSelector(amount, currency),
              if (cubit.qualifiesForUpfrontInterest) ...[
                SizedBox(height: 16.h),
                _buildInterestDestinationSelector(currency, cubit),
              ],
              SizedBox(height: 16.h),
              _buildAutoRenewRow(cubit),
              SizedBox(height: 16.h),
              _buildImportantNotes(cubit),
            ],
          ),
        );
      },
    );
  }

  // Headline amount chip ───────────────────────────────────────────────

  Widget _buildAmountChip(double amount, String currency) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4E03D0), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4E03D0).withValues(alpha: 0.32),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(Icons.lock_rounded, color: Colors.white, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Locking',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '${CurrencySymbols.getSymbol(currency)}${NumberFormat('#,##0.00').format(amount)}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Active-account row + bottom-sheet picker ───────────────────────────

  Widget _buildAccountSelector(double amount, String currency) {
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
        if (state is AccountCardsSummaryError) {
          return _buildErrorMessage(state.message);
        }
        if (state is! AccountCardsSummaryLoaded) {
          return const SizedBox.shrink();
        }
        final accounts = state.accountSummaries;
        if (accounts.isEmpty) return _buildNoAccountsMessage();

        final active = _resolveActiveAccount(accounts, amount, currency);
        if (active == null) return _buildNoAccountsMessage();

        // Auto-bind the active account to the cubit on first paint
        // so the user can move forward without explicitly tapping —
        // the bottom sheet only appears when they want to switch.
        if (_selectedAccountId == null && _currencyMatches(active, currency)) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && _selectedAccountId == null) {
              _selectAccount(active, amount);
            }
          });
        }

        final eligible = _currencyMatches(active, currency) &&
            _hasSufficientBalance(active, amount);

        // Static row — no picker. The dashboard's primary same-
        // currency account is the only valid funding source on
        // this slide, so showing a "Change" CTA + bottom sheet
        // was just noise.
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pay from',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color: eligible
                      ? const Color(0xFF4E03D0)
                      : const Color(0xFFEF4444).withValues(alpha: 0.4),
                  width: 1.4,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 42.w,
                    height: 42.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4E03D0).withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(11.r),
                    ),
                    child: Icon(
                      Icons.account_balance_wallet_rounded,
                      color: const Color(0xFF8B5CF6),
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
                            Flexible(
                              child: Text(
                                active.accountType,
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: eligible
                                    ? const Color(0xFF10B981)
                                        .withValues(alpha: 0.2)
                                    : const Color(0xFFEF4444)
                                        .withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text(
                                eligible
                                    ? 'Active'
                                    : _currencyMatches(active, currency)
                                        ? 'Insufficient'
                                        : 'Wrong currency',
                                style: GoogleFonts.inter(
                                  color: eligible
                                      ? const Color(0xFF10B981)
                                      : const Color(0xFFEF4444),
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          CurrencySymbols.formatAmountWithCurrency(
                              active.availableBalance, active.currency),
                          style: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (!eligible) ...[
              SizedBox(height: 8.h),
              Text(
                _currencyMatches(active, currency)
                    ? 'This account does not have enough funds to lock this amount.'
                    : 'No $currency wallet on file. Add one before locking funds in this currency.',
                style: GoogleFonts.inter(
                  color: const Color(0xFFEF4444),
                  fontSize: 11.sp,
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  // Auto-renew toggle (moved here from the review slide) ───────────────

  Widget _buildAutoRenewRow(CreateLockCubit cubit) {
    final autoRenew = cubit.autoRenew;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: autoRenew
                  ? const Color(0xFF4E03D0).withValues(alpha: 0.2)
                  : Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.repeat_rounded,
              color: autoRenew
                  ? const Color(0xFF8B5CF6)
                  : const Color(0xFF9CA3AF),
              size: 18.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Auto-renew',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    )),
                SizedBox(height: 2.h),
                Text(
                  'Automatically renew this lock at maturity',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: autoRenew,
            onChanged: cubit.updateAutoRenew,
            activeThumbColor: const Color(0xFF8B5CF6),
            activeTrackColor: const Color(0xFF4E03D0).withValues(alpha: 0.5),
            inactiveThumbColor: const Color(0xFF9CA3AF),
            inactiveTrackColor: Colors.white.withValues(alpha: 0.1),
          ),
        ],
      ),
    );
  }

  // Important notes (moved here from review slide) ─────────────────────

  Widget _buildImportantNotes(CreateLockCubit cubit) {
    // Copy comes purely from the admin dashboard now: a default
    // bullet list shown always, plus a separate list appended based
    // on the auto-renew toggle. If the operator hasn't filled any
    // notes for this plan, hide the panel so we don't render an
    // empty box.
    final notes = cubit.getConfirmationNotes(
      cubit.lockType,
      autoRenew: cubit.autoRenew,
    );
    if (notes.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF59E0B).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
            color: const Color(0xFFF59E0B).withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline_rounded,
                  color: const Color(0xFFF59E0B), size: 16.sp),
              SizedBox(width: 8.w),
              Text(
                'Before you confirm',
                style: GoogleFonts.inter(
                  color: const Color(0xFFF59E0B),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          for (final n in notes) _buildBullet(n),
        ],
      ),
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 6.h),
            width: 4.w,
            height: 4.w,
            decoration: const BoxDecoration(
              color: Color(0xFFF59E0B),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                color: const Color(0xFFFBBF24),
                fontSize: 12.sp,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Upfront-interest destination picker. Same shape as the pay-from
  // selector: shows a single active row + Change CTA, opens a
  // bottom sheet listing every wallet. Inside the sheet, only
  // matching-currency wallets are selectable (regardless of
  // balance — there's no funds movement out of this account, the
  // platform only credits interest into it). Foreign-currency
  // wallets render visibly but disabled.
  Widget _buildInterestDestinationSelector(
      String currency, CreateLockCubit cubit) {
    return BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      builder: (context, state) {
        // While accounts are loading, render a labelled skeleton
        // instead of nothing — otherwise the section appears to
        // pop in late and looks like a layout glitch.
        if (state is! AccountCardsSummaryLoaded) {
          return _buildInterestDestinationHeader(
            child: Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: const Center(child: CircularProgressIndicator()),
            ),
          );
        }
        final allAccounts = state.accountSummaries;
        final matching =
            allAccounts.where((a) => _currencyMatches(a, currency)).toList();
        // No matching-currency wallet but admin has upfront-interest
        // enabled for this plan: show the section header + a clear
        // "create a $currency wallet" notice instead of hiding it.
        // Hiding silently was the bug the user just reported.
        if (matching.isEmpty) {
          return _buildInterestDestinationHeader(
            child: Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF59E0B).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                    color: const Color(0xFFF59E0B).withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline_rounded,
                      color: const Color(0xFFF59E0B), size: 18.sp),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      'No $currency wallet on file. Create one to receive your upfront interest payout.',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFFBBF24),
                        fontSize: 12.sp,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final selectedId =
            cubit.interestDestinationAccountId ?? matching.first.id;
        final active = matching.firstWhere(
          (a) => a.id == selectedId,
          orElse: () => matching.first,
        );
        // Bind a default the first time the section paints so the
        // user can advance the wizard without explicitly tapping.
        if (cubit.interestDestinationAccountId == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && cubit.interestDestinationAccountId == null) {
              cubit.updateInterestDestinationAccount(matching.first.id);
            }
          });
        }

        return _buildInterestDestinationHeader(
          child: InkWell(
              onTap: () => _openInterestDestinationPicker(
                  allAccounts, currency, cubit),
              borderRadius: BorderRadius.circular(14.r),
              child: Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: const Color(0xFF8B5CF6).withValues(alpha: 0.4),
                    width: 1.4,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 42.w,
                      height: 42.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B5CF6).withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(11.r),
                      ),
                      child: Icon(
                        Icons.account_balance_wallet_rounded,
                        color: const Color(0xFF8B5CF6),
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            active.accountType,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            CurrencySymbols.formatAmountWithCurrency(
                                active.availableBalance, active.currency),
                            style: GoogleFonts.inter(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B5CF6).withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Change',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF8B5CF6),
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Icon(Icons.arrow_drop_down_rounded,
                              color: const Color(0xFF8B5CF6), size: 16.sp),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        );
      },
    );
  }

  /// Wraps any inner widget in the same "Send upfront interest to"
  /// header so the empty / loading / picker variants line up.
  Widget _buildInterestDestinationHeader({required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bolt_rounded,
                color: const Color(0xFF8B5CF6), size: 16.sp),
            SizedBox(width: 6.w),
            Text(
              'Send upfront interest to',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        child,
      ],
    );
  }

  Future<void> _openInterestDestinationPicker(
    List<AccountSummaryEntity> accounts,
    String currency,
    CreateLockCubit cubit,
  ) async {
    final picked = await showModalBottomSheet<AccountSummaryEntity>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetCtx) => _InterestDestinationPickerSheet(
        accounts: accounts,
        currency: currency,
        selectedAccountId: cubit.interestDestinationAccountId,
      ),
    );
    if (picked != null) {
      cubit.updateInterestDestinationAccount(picked.id);
    }
  }

  // Generic empty / error states reused from the previous version.

  Widget _buildNoAccountsMessage() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Icon(Icons.account_balance_wallet_outlined,
              color: const Color(0xFF9CA3AF), size: 40.sp),
          SizedBox(height: 12.h),
          Text(
            'No accounts found',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'You need an account to fund a PiggyVault. Create one first.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 12.sp,
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
          Icon(Icons.error_outline,
              color: const Color(0xFFEF4444), size: 40.sp),
          SizedBox(height: 12.h),
          Text(
            'Could not load your accounts',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 14.h),
          GestureDetector(
            onTap: () {
              final userId = context.read<AuthenticationCubit>().userId ?? '';
              context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
                    userId: userId,
                  );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: const Color(0xFF4E03D0),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                'Retry',
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
    );
  }
}

// Pay-from picker was removed. The slide now renders the
// dashboard's resolved primary same-currency account as a static
// row — no bottom sheet, no Change CTA. _SheetAccountTile below is
// still used by _InterestDestinationPickerSheet for the upfront-
// interest picker.

class _SheetAccountTile extends StatelessWidget {
  final AccountSummaryEntity account;
  final bool isSelected;
  final bool hasBalance;
  final String? disabledReason;
  final VoidCallback? onTap;

  const _SheetAccountTile({
    required this.account,
    required this.isSelected,
    required this.hasBalance,
    required this.onTap,
    this.disabledReason,
  });

  @override
  Widget build(BuildContext context) {
    final disabled = onTap == null;
    final tag = disabledReason ??
        (isSelected ? 'Active' : (hasBalance ? null : 'Insufficient'));
    final tagColor = disabled
        ? const Color(0xFF9CA3AF)
        : isSelected
            ? const Color(0xFF10B981)
            : const Color(0xFFEF4444);
    return Opacity(
      opacity: disabled ? 0.55 : 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          margin: EdgeInsets.only(bottom: 8.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF4E03D0).withValues(alpha: 0.12)
                : const Color(0xFF0A0A0A),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF8B5CF6)
                  : Colors.transparent,
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Container(
                width: 38.w,
                height: 38.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF4E03D0).withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.account_balance_wallet,
                  color: const Color(0xFF8B5CF6),
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      account.accountType,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      CurrencySymbols.formatAmountWithCurrency(
                          account.availableBalance, account.currency),
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
              if (tag != null) ...[
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: tagColor.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    tag,
                    style: GoogleFonts.inter(
                      color: tagColor,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
              if (isSelected) ...[
                SizedBox(width: 6.w),
                Icon(Icons.check_circle,
                    color: const Color(0xFF8B5CF6), size: 16.sp),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Bottom-sheet picker for the upfront-interest destination.
/// Mirrors [_AccountPickerSheet] except: no balance gate (the
/// platform deposits INTO this account, so balance is irrelevant),
/// foreign-currency wallets render but are tap-disabled.
class _InterestDestinationPickerSheet extends StatelessWidget {
  final List<AccountSummaryEntity> accounts;
  final String currency;
  final String? selectedAccountId;

  const _InterestDestinationPickerSheet({
    required this.accounts,
    required this.currency,
    required this.selectedAccountId,
  });

  bool _matches(AccountSummaryEntity a) =>
      a.currency.toUpperCase() == currency.toUpperCase();

  @override
  Widget build(BuildContext context) {
    final matching = accounts.where(_matches).toList();
    final others = accounts.where((a) => !_matches(a)).toList();
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF3D3D3D),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 14.h),
            Text(
              'Receive upfront interest in',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Only $currency wallets can receive this interest payout',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 16.h),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.55,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (matching.isEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.h),
                        child: Center(
                          child: Text(
                            'No $currency wallets available',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      )
                    else
                      ...matching.map((a) {
                        final isSelected = a.id == selectedAccountId;
                        return _SheetAccountTile(
                          account: a,
                          isSelected: isSelected,
                          hasBalance: true,
                          onTap: () => Navigator.of(context).pop(a),
                        );
                      }),
                    if (others.isNotEmpty) ...[
                      SizedBox(height: 14.h),
                      Text(
                        'Other wallets (not eligible)',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF6B7280),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      ...others.map((a) => _SheetAccountTile(
                            account: a,
                            isSelected: false,
                            hasBalance: false,
                            disabledReason: 'Wrong currency',
                            onTap: null,
                          )),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
