import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/group_entities.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'contribution_payment_confirmation_screen.dart';

class MakePaymentScreen extends StatefulWidget {
  final String contributionId;
  final Contribution? contribution;

  const MakePaymentScreen({
    super.key,
    required this.contributionId,
    this.contribution,
  });

  @override
  State<MakePaymentScreen> createState() => _MakePaymentScreenState();
}

class _MakePaymentScreenState extends State<MakePaymentScreen>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  String? _selectedAccountId;
  double? _selectedAccountBalance;
  bool _isProcessing = false;

  // Idempotency key for the CURRENT payment intent. Generated lazily on
  // the first attempt and REUSED on every retry until the user changes
  // the parameters of the payment (amount or source account). This is
  // load-bearing for money safety:
  //
  //   - If we generated a fresh key on each tap, a transient timeout +
  //     user retry would create two distinct payments at the backend.
  //     Even though accounts-service is idempotent, the SECOND call uses
  //     a new key, so it would commit a fresh debit — charging the user
  //     twice for the same intended payment.
  //
  //   - With a stable key, the backend's MakePayment idempotency check
  //     returns the in-flight payment row instead of starting a new one.
  //     The supervisor independently resolves the original via the
  //     LookupTransactionByReference probe.
  String? _pendingIdempotencyKey;
  // The (amount + account) tuple the current key was issued for. If the
  // user changes either, we treat it as a NEW payment intent and rotate
  // the key so the backend doesn't conflate two distinct intents.
  String? _pendingIdempotencyKeyFingerprint;

  String _idempotencyFingerprint(double amount, String accountId) {
    return '$accountId:${amount.toStringAsFixed(2)}';
  }

  String _resolveIdempotencyKey(double amount, String accountId) {
    final fp = _idempotencyFingerprint(amount, accountId);
    if (_pendingIdempotencyKey == null || _pendingIdempotencyKeyFingerprint != fp) {
      _pendingIdempotencyKey = const Uuid().v4();
      _pendingIdempotencyKeyFingerprint = fp;
    }
    return _pendingIdempotencyKey!;
  }

  /// True for ROSCA / esusu contributions where every member pays a
  /// fixed per-cycle amount. UI surfaces (amount field, quick chips,
  /// helper copy) treat these specially: the amount is locked to
  /// regularAmount and quick amounts are hidden because there is no
  /// "pay what you can" option.
  bool get _isRotatingSavings =>
      widget.contribution?.type == ContributionType.rotatingSavings;

  /// The fixed per-member-per-cycle amount for ROSCA. Returns null
  /// when the contribution is one-time or when regularAmount is unset.
  double? get _fixedRoscaAmount {
    if (!_isRotatingSavings) return null;
    final amt = widget.contribution?.regularAmount;
    if (amt == null || amt <= 0) return null;
    return amt;
  }

  @override
  void initState() {
    super.initState();
    if (widget.contribution != null) {
      final fixed = _fixedRoscaAmount;
      if (fixed != null) {
        // ROSCA: lock to the per-member amount. Backend rejects any
        // mismatch, so prefilling the exact amount is both correct and
        // user-friendly (one tap to pay your share).
        _amountController.text = fixed.toStringAsFixed(2);
      } else {
        // One-time: prefill remaining balance as a suggestion. Field
        // stays editable so members can pay any portion they can afford.
        final remaining = widget.contribution!.targetAmount -
            widget.contribution!.currentAmount;
        if (remaining > 0) {
          _amountController.text = remaining.toStringAsFixed(2);
        }
      }
    }

    // Ensure accounts are loaded
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is! AccountCardsSummaryLoaded) {
      final userId = context.read<AuthenticationCubit>().userId ?? '';
      context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
            userId: userId,
          );
    }
  }

  bool get _hasInsufficientBalance {
    if (_selectedAccountBalance == null) return false;
    final amount = double.tryParse(_amountController.text) ?? 0;
    return amount > _selectedAccountBalance!;
  }

  void _processPayment() async {
    final amount = double.parse(_amountController.text);

    HapticFeedback.mediumImpact();

    // Generate transaction ID for PIN verification
    final idPrefix = widget.contributionId.length >= 8
        ? widget.contributionId.substring(0, 8)
        : widget.contributionId;
    final transactionId = 'GRP-PAY-$idPrefix';

    // Validate PIN
    String? verificationToken;

    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'group_contribution_payment',
      amount: amount,
      currency: widget.contribution?.currency ?? 'USD',
      title: 'Confirm Payment',
      message: 'Confirm group contribution payment of ${widget.contribution?.currency ?? 'USD'} ${amount.toStringAsFixed(2)}',
      onPinValidated: (token) async {
        verificationToken = token;
      },
    );

    if (!success || verificationToken == null) return;

    setState(() {
      _isProcessing = true;
    });

    if (!mounted) return;

    // Resolve the idempotency key for THIS payment intent. Same key on
    // every retry of the same (amount, account) tuple — backend dedupes.
    final accountForKey = _selectedAccountId ?? 'default';
    final idempotencyKey = _resolveIdempotencyKey(amount, accountForKey);
    final notes = _notesController.text.trim();

    // Call the cubit to make payment
    context.read<GroupAccountCubit>().makePaymentToContribution(
          contributionId: widget.contributionId,
          groupId: widget.contribution?.groupId ?? '',
          amount: amount,
          currency: widget.contribution?.currency ?? 'USD',
          notes: notes.isEmpty ? null : notes,
          transactionPin: verificationToken!,
          sourceAccountId: _selectedAccountId,
          idempotencyKey: idempotencyKey,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: BlocListener<GroupAccountCubit, GroupAccountState>(
        listener: (context, state) {
          if (state is ContributionPaymentSuccess) {
            setState(() {
              _isProcessing = false;
            });
            // Navigate to confirmation screen
            Get.off(
              () => ContributionPaymentConfirmationScreen(
                contribution: widget.contribution!,
                payment: state.payment,
                paymentMethod: 'bank_transfer', // Default for now
              ),
            );
          } else if (state is ContributionPaymentFailed) {
            setState(() {
              _isProcessing = false;
            });

            String errorTitle = 'Payment Failed';
            if (state.isInsufficientBalance) {
              errorTitle = 'Insufficient Balance';
            } else if (state.isPinInvalid) {
              errorTitle = 'Invalid PIN';
            } else if (state.isDuplicate) {
              errorTitle = 'Duplicate Payment';
            }

            Get.snackbar(
              errorTitle,
              state.error,
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              duration: const Duration(seconds: 4),
            );
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.contribution != null)
                          _buildContributionSummary(),
                        SizedBox(height: 24.h),
                        _buildAmountSection(),
                        SizedBox(height: 24.h),
                        _buildAccountSelector(),
                        SizedBox(height: 24.h),
                        _buildNotesSection(),
                        SizedBox(height: 32.h),
                        _buildPaymentButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        border: Border(
          bottom: BorderSide(color: const Color(0xFF2D2D2D), width: 1),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              'Make Payment',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          Icon(
            Icons.security,
            color: const Color(0xFF10B981),
            size: 24.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildContributionSummary() {
    final contribution = widget.contribution!;
    final progressPercentage = contribution.progressPercentage;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color.fromARGB(255, 78, 3, 208),
            const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            contribution.title,
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            contribution.description,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.8),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Progress',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${contribution.currency} ${contribution.currentAmount.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Target Amount',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${contribution.currency} ${contribution.targetAmount.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Progress',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  Text(
                    '${progressPercentage.toStringAsFixed(0)}%',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Container(
                height: 6.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(3.r),
                ),
                child: Stack(
                  children: [
                    FractionallySizedBox(
                      widthFactor: progressPercentage / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Amount',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 12.h),
        TextFormField(
          controller: _amountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          // ROSCA: amount is the per-member fixed share. Locking the
          // field at the UI layer matches the backend enforcement and
          // makes the contract obvious to the user.
          readOnly: _isRotatingSavings,
          enabled: !_isRotatingSavings,
          style: GoogleFonts.inter(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          onChanged: (_) => setState(() {}), // Trigger rebuild for balance check
          decoration: InputDecoration(
            hintText: '0.00',
            hintStyle: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF666666),
            ),
            prefixIcon: Container(
              padding: EdgeInsets.all(16.w),
              child: Text(
                widget.contribution?.currency ?? 'USD',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 78, 3, 208),
                ),
              ),
            ),
            suffixIcon: _isRotatingSavings
                ? Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Icon(Icons.lock_outline,
                        color: Colors.grey[500], size: 18.sp),
                  )
                : null,
            filled: true,
            fillColor: _isRotatingSavings
                ? const Color(0xFF181818)
                : const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: _hasInsufficientBalance
                    ? const Color(0xFFEF4444)
                    : const Color(0xFF2D2D2D),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: _hasInsufficientBalance
                    ? const Color(0xFFEF4444)
                    : const Color(0xFF2D2D2D),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: _hasInsufficientBalance
                    ? const Color(0xFFEF4444)
                    : const Color.fromARGB(255, 78, 3, 208),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFFEF4444)),
            ),
            contentPadding: EdgeInsets.all(20.w),
          ),
          validator: (value) {
            if (value?.isEmpty == true) return 'Amount is required';
            if (double.tryParse(value!) == null) return 'Invalid amount';
            if (double.parse(value) <= 0) return 'Amount must be greater than 0';
            return null;
          },
        ),
        if (_isRotatingSavings) ...[
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.info_outline,
                  color: Colors.grey[500], size: 14.sp),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  'Esusu contributions are a fixed share per cycle. Everyone pays the same amount.',
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ],
          ),
        ],
        if (_hasInsufficientBalance) ...[
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: const Color(0xFFEF4444),
                size: 16.sp,
              ),
              SizedBox(width: 6.w),
              Text(
                'Insufficient balance in selected account',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: const Color(0xFFEF4444),
                ),
              ),
            ],
          ),
        ],
        // Quick amounts only apply to one-time contributions (variable
        // payments). ROSCA is fixed per cycle so chips would be misleading.
        if (widget.contribution != null && !_isRotatingSavings) ...[
          SizedBox(height: 12.h),
          _buildQuickAmountButtons(),
        ],
      ],
    );
  }

  Widget _buildQuickAmountButtons() {
    final contribution = widget.contribution!;
    final remaining = contribution.targetAmount - contribution.currentAmount;
    final quickAmounts = [
      remaining * 0.25,
      remaining * 0.5,
      remaining * 0.75,
      remaining,
    ].where((amount) => amount > 0).toList();

    if (quickAmounts.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick amounts',
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: const Color(0xFF888888),
          ),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: quickAmounts.map((amount) {
            return GestureDetector(
              onTap: () {
                _amountController.text = amount.toStringAsFixed(2);
                setState(() {}); // Trigger balance check
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: const Color(0xFF3D3D3D)),
                ),
                child: Text(
                  '${contribution.currency} ${amount.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }).toList(),
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
          // Filter accounts by matching currency if contribution has currency
          final contributionCurrency = widget.contribution?.currency;
          final filteredAccounts = contributionCurrency != null
              ? state.accountSummaries
                  .where((a) => a.currency == contributionCurrency)
                  .toList()
              : state.accountSummaries;

          if (filteredAccounts.isEmpty) {
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
                    color: const Color(0xFF666666),
                    size: 40.sp,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'No ${contributionCurrency ?? ''} accounts available',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: const Color(0xFF888888),
                    ),
                  ),
                ],
              ),
            );
          }

          // Pick a default selection on first build only — prefer the
          // PRIMARY account (the one the dashboard surfaces as
          // active), falling back to the first account in the
          // filtered list. AccountSummaryEntity doesn't carry a
          // canonical usability flag at the entity level today;
          // accounts-service rejects frozen/closed accounts at debit
          // time with a clean error that the cubit surfaces, which
          // is acceptable while a richer client-side flag isn't
          // available. Subsequent rebuilds (e.g. balance refresh)
          // keep the user's manual choice intact.
          if (_selectedAccountId == null) {
            final primary = filteredAccounts.firstWhere(
              (a) => a.isPrimary,
              orElse: () => filteredAccounts.first,
            );
            // setState during build is verboten, so defer to next frame.
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              setState(() {
                _selectedAccountId = primary.id.toString();
                _selectedAccountBalance = primary.balance;
              });
            });
          }

          // Resolve the currently-selected account for the compact
          // tile. If the saved id is no longer in the filtered list
          // (e.g. user changed contribution currency), reset it.
          AccountSummaryEntity? selected;
          for (final a in filteredAccounts) {
            if (a.id.toString() == _selectedAccountId) {
              selected = a;
              break;
            }
          }
          selected ??= filteredAccounts.first;
          final selectedAcc = selected;
          final amount =
              double.tryParse(_amountController.text) ?? 0;
          final hasEnough = amount <= selectedAcc.balance;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pay From',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  if (filteredAccounts.length > 1)
                    Text(
                      '${filteredAccounts.length} available',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        color: Colors.grey[500],
                      ),
                    ),
                ],
              ),
              SizedBox(height: 12.h),
              // Compact preselected tile. Tap opens the picker bottom
              // sheet when there's more than one account; otherwise
              // it's a static row showing the only choice.
              GestureDetector(
                onTap: filteredAccounts.length > 1
                    ? () => _openAccountPicker(filteredAccounts)
                    : null,
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    border: Border.all(
                      color: const Color.fromARGB(255, 78, 3, 208)
                          .withValues(alpha: 0.5),
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 78, 3, 208)
                              .withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Icon(
                          Icons.account_balance_wallet,
                          color: const Color.fromARGB(255, 78, 3, 208),
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
                                    selectedAcc.accountType,
                                    style: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (selectedAcc.isPrimary) ...[
                                  SizedBox(width: 8.w),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.w,
                                      vertical: 2.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF10B981)
                                          .withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                    child: Text(
                                      'Primary',
                                      style: GoogleFonts.inter(
                                        fontSize: 9.sp,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF10B981),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            SizedBox(height: 2.h),
                            Row(
                              children: [
                                Text(
                                  '${selectedAcc.currency} ${selectedAcc.balance.toStringAsFixed(2)}',
                                  style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: hasEnough
                                        ? const Color(0xFF9CA3AF)
                                        : const Color(0xFFEF4444),
                                  ),
                                ),
                                if (!hasEnough && amount > 0) ...[
                                  SizedBox(width: 8.w),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.w,
                                      vertical: 2.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEF4444)
                                          .withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                    child: Text(
                                      'Low Balance',
                                      style: GoogleFonts.inter(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFFEF4444),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (filteredAccounts.length > 1)
                        Icon(
                          Icons.expand_more,
                          color: Colors.grey[400],
                          size: 24.sp,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }

        if (state is AccountCardsSummaryError) {
          return Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.error_outline,
                  color: const Color(0xFFEF4444),
                  size: 40.sp,
                ),
                SizedBox(height: 12.h),
                Text(
                  'Failed to load accounts',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: const Color(0xFFEF4444),
                  ),
                ),
                SizedBox(height: 8.h),
                TextButton(
                  onPressed: () {
                    final userId = context.read<AuthenticationCubit>().userId ?? '';
                    context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
                          userId: userId,
                        );
                  },
                  child: Text(
                    'Retry',
                    style: GoogleFonts.inter(
                      color: const Color.fromARGB(255, 78, 3, 208),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  // Opens the bottom-sheet picker so the user can switch from the
  // preselected primary account to another funded one. Mirrors the
  // dashboard's "switch active account" pattern. Filtered list is
  // built by the caller; we just render + commit on tap.
  bool _pickerOpen = false;
  void _openAccountPicker(List<AccountSummaryEntity> accounts) {
    // Re-entrancy guard. A double-tap while the sheet animation is
    // still settling would otherwise stack two pickers and leave the
    // app deadlocked under the modal barrier on dismiss.
    if (_pickerOpen) return;
    _pickerOpen = true;
    final amount = double.tryParse(_amountController.text) ?? 0;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetCtx) {
        // Note: the picker future's whenComplete (below the
        // showModalBottomSheet call) clears _pickerOpen on dismiss
        // so subsequent taps work.
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Pay From',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(sheetCtx).size.height * 0.55,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: accounts.length,
                    itemBuilder: (_, i) {
                      final a = accounts[i];
                      final isSelected =
                          _selectedAccountId == a.id.toString();
                      final ok = amount <= a.balance;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedAccountId = a.id.toString();
                            _selectedAccountBalance = a.balance;
                          });
                          Navigator.of(sheetCtx).pop();
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          padding: EdgeInsets.all(14.w),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color.fromARGB(255, 78, 3, 208)
                                    .withValues(alpha: 0.12)
                                : const Color(0xFF0A0A0A),
                            border: Border.all(
                              color: isSelected
                                  ? const Color.fromARGB(255, 78, 3, 208)
                                  : const Color(0xFF2D2D2D),
                              width: isSelected ? 1.5 : 1,
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 36.w,
                                height: 36.w,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                          255, 78, 3, 208)
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(18.r),
                                ),
                                child: Icon(
                                  Icons.account_balance_wallet,
                                  color: const Color.fromARGB(
                                      255, 78, 3, 208),
                                  size: 18.sp,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            a.accountType,
                                            style: GoogleFonts.inter(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        if (a.isPrimary) ...[
                                          SizedBox(width: 6.w),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 5.w,
                                              vertical: 1.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF10B981)
                                                  .withValues(alpha: 0.2),
                                              borderRadius:
                                                  BorderRadius.circular(3.r),
                                            ),
                                            child: Text(
                                              'Primary',
                                              style: GoogleFonts.inter(
                                                fontSize: 9.sp,
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xFF10B981),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      '${a.currency} ${a.balance.toStringAsFixed(2)}',
                                      style: GoogleFonts.inter(
                                        fontSize: 11.sp,
                                        color: ok
                                            ? const Color(0xFF9CA3AF)
                                            : const Color(0xFFEF4444),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: const Color.fromARGB(
                                      255, 78, 3, 208),
                                  size: 22.sp,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        );
      },
    ).whenComplete(() {
      // Sheet is dismissed (tap-outside, swipe-down, or our own
      // Navigator.pop on row select). Reset the re-entrancy guard
      // so the next tap re-opens correctly.
      if (mounted) _pickerOpen = false;
    });
  }

  Widget _buildNotesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notes (Optional)',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 12.h),
        TextFormField(
          controller: _notesController,
          maxLines: 3,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: 'Add a note for this payment...',
            hintStyle: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xFF666666),
            ),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color.fromARGB(255, 78, 3, 208)),
            ),
            contentPadding: EdgeInsets.all(16.w),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isProcessing ? null : _validateAndProcessPayment,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              _isProcessing ? const Color(0xFF3D3D3D) : const Color.fromARGB(255, 78, 3, 208),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: _isProcessing
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Processing Payment...',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock, size: 20.sp),
                  SizedBox(width: 8.w),
                  Text(
                    'Pay Securely',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void _validateAndProcessPayment() {
    // Validate amount first
    final amountText = _amountController.text.trim();
    if (amountText.isEmpty) {
      Get.snackbar(
        'Amount Required',
        'Please enter an amount to pay',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      Get.snackbar(
        'Invalid Amount',
        'Please enter a valid amount greater than 0',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    // Validate account selection
    if (_selectedAccountId == null) {
      Get.snackbar(
        'No Account Selected',
        'Please select an account to pay from',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    // Validate balance
    if (_hasInsufficientBalance) {
      Get.snackbar(
        'Insufficient Balance',
        'Your selected account does not have enough balance for this payment',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    // All validations passed, proceed with payment
    _processPayment();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}
