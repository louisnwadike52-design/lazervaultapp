import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import '../../domain/entities/crowdfund_entities.dart';
import '../cubit/crowdfund_cubit.dart';
import 'donation_processing_screen.dart';

class DonationPaymentScreen extends StatefulWidget {
  final Crowdfund crowdfund;

  const DonationPaymentScreen({
    super.key,
    required this.crowdfund,
  });

  @override
  State<DonationPaymentScreen> createState() => _DonationPaymentScreenState();
}

class _DonationPaymentScreenState extends State<DonationPaymentScreen>
    with TransactionPinMixin {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isAnonymous = false;
  bool _isSubmitting = false;
  // Currently-typed/picked amount as a clean double (no commas).
  // Recomputed on every field change via the comma formatter.
  double _amount = 0.0;

  // Account state
  AccountSummaryEntity? _personalAccount;
  bool _accountLoading = true;
  String? _accountError;

  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  /// Returns currency-aware suggested amounts for donations
  List<double> get _suggestedAmounts {
    final currency = widget.crowdfund.currency.toUpperCase();
    switch (currency) {
      case 'NGN':
        return [500, 1000, 2000, 5000, 10000, 20000];
      case 'GBP':
      case 'EUR':
      case 'USD':
        return [10, 25, 50, 100, 200, 500];
      case 'ZAR':
        return [100, 250, 500, 1000, 2000, 5000];
      case 'INR':
        return [500, 1000, 2500, 5000, 10000, 25000];
      case 'CAD':
      case 'AUD':
        return [15, 30, 60, 120, 250, 500];
      default:
        return [10, 25, 50, 100, 200, 500];
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPersonalAccount();
  }

  void _loadPersonalAccount() {
    final accountsCubit = context.read<AccountCardsSummaryCubit>();
    final state = accountsCubit.state;

    if (state is AccountCardsSummaryLoaded) {
      _resolvePersonalAccount(state.accountSummaries);
    } else {
      final userId = context.read<AuthenticationCubit>().userId ?? '';
      accountsCubit.fetchAccountSummaries(userId: userId);
    }
  }

  void _resolvePersonalAccount(List<AccountSummaryEntity> accounts) {
    final currency = widget.crowdfund.currency.toUpperCase();

    // Find personal account matching the campaign currency
    final personal = accounts.where((a) =>
        a.accountType.toLowerCase() == 'personal' &&
        a.currency.toUpperCase() == currency).firstOrNull;

    setState(() {
      _personalAccount = personal;
      _accountLoading = false;
      _accountError = personal == null
          ? 'No personal $currency account found'
          : null;
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // ────────────────────────────────────────────────────────────
  // Amount input — comma-formatted display, plain number on the wire
  // ────────────────────────────────────────────────────────────

  /// Strip thousands separators and parse to double. Returns 0 on
  /// empty / malformed input.
  double _parseAmount(String raw) {
    final cleaned = raw.replaceAll(',', '').trim();
    if (cleaned.isEmpty) return 0.0;
    return double.tryParse(cleaned) ?? 0.0;
  }

  /// Render a clean double as `1,234.56` (or `1,234` if integral).
  String _formatAmount(double value) {
    if (value <= 0) return '';
    final isInt = value == value.roundToDouble();
    final whole = value.floor();
    final fractional =
        isInt ? '' : '.${((value - whole) * 100).round().toString().padLeft(2, '0')}';
    final wholeStr = whole.toString();
    final buf = StringBuffer();
    for (var i = 0; i < wholeStr.length; i++) {
      if (i > 0 && (wholeStr.length - i) % 3 == 0) buf.write(',');
      buf.write(wholeStr[i]);
    }
    return buf.toString() + fractional;
  }

  void _onAmountChanged(String value) {
    final parsed = _parseAmount(value);
    if (parsed != _amount) {
      setState(() => _amount = parsed);
    }
  }

  void _selectQuickAmount(double pillAmount) {
    final formatted = _formatAmount(pillAmount);
    _amountController.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
    setState(() => _amount = pillAmount);
  }

  Future<void> _processDonation() async {
    if (_isSubmitting) return;
    if (!_formKey.currentState!.validate()) return;

    final amount = _getDonationAmount();
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a donation amount'),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
      return;
    }

    if (_personalAccount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_accountError ?? 'No account available'),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
      return;
    }

    // Check sufficient balance
    if (_personalAccount!.availableBalance < amount) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Insufficient balance. Available: ${widget.crowdfund.currency} ${_personalAccount!.availableBalance.toStringAsFixed(2)}',
          ),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
      return;
    }

    // Mint a deterministic transaction_id used both at PIN-mint and at
    // server-side validation. The auth-service token validator looks
    // the row up by (token, user_id, transaction_id), so the same
    // string MUST flow through both calls. The crowdfund id (first 8
    // chars, uppercased to match server expectations) plus a
    // millisecond timestamp gives enough entropy that two donations
    // can't collide.
    final transactionId =
        'CF-DONATE-${widget.crowdfund.id.substring(0, 8)}-${DateTime.now().millisecondsSinceEpoch}';

    // Show PIN bottomsheet
    String? verificationToken;

    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'crowdfund_donation',
      amount: amount,
      currency: widget.crowdfund.currency,
      title: 'Confirm Donation',
      message: 'Confirm donation of ${widget.crowdfund.currency} ${amount.toStringAsFixed(2)}',
      // We have a dedicated DonationProcessingScreen that owns the
      // post-PIN processing UI, so the bottom sheet should ONLY
      // show "PIN Verified" — not "Transaction Successful" (which
      // implies the donation completed, but that happens later on
      // the processing screen after the gRPC round trip).
      showProcessingPhase: false,
      onPinValidated: (token) async {
        verificationToken = token;
      },
    );

    if (!success || verificationToken == null) return;
    if (!mounted) return;

    setState(() => _isSubmitting = true);

    final cubit = context.read<CrowdfundCubit>();

    cubit.makeDonation(
      crowdfundId: widget.crowdfund.id,
      amount: amount,
      message: _messageController.text.trim().isEmpty
          ? null
          : _messageController.text.trim(),
      isAnonymous: _isAnonymous,
      sourceAccountId: _personalAccount!.id,
      transactionPin: verificationToken!,
      transactionId: transactionId,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: DonationProcessingScreen(
            crowdfund: widget.crowdfund,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Make a Donation',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: BlocListener<AccountCardsSummaryCubit, AccountCardsSummaryState>(
        listener: (context, state) {
          if (state is AccountCardsSummaryLoaded) {
            _resolvePersonalAccount(state.accountSummaries);
          } else if (state is AccountBalanceUpdated) {
            _resolvePersonalAccount(state.accountSummaries);
          } else if (state is AccountCardsSummaryError) {
            setState(() {
              _accountLoading = false;
              _accountError = 'Failed to load accounts';
            });
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Crowdfund summary
                _buildCrowdfundSummary(),
                SizedBox(height: 16.h),
                // Amount section
                Text(
                  'Select Amount',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.h),
                _buildAmountField(),
                SizedBox(height: 10.h),
                _buildAmountQuickPills(),
                SizedBox(height: 16.h),
                // Source account (personal only)
                Text(
                  'Source Account',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.h),
                _buildPersonalAccountCard(),
                SizedBox(height: 16.h),
                // Optional message
                Text(
                  'Message (Optional)',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.h),
                _buildMessageField(),
                SizedBox(height: 16.h),
                // Anonymous toggle
                _buildAnonymousToggle(),
                SizedBox(height: 20.h),
                // Donate button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: !_isSubmitting &&
                            _getDonationAmount() > 0 &&
                            _personalAccount != null &&
                            !_accountLoading
                        ? _processDonation
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4E03D0),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      disabledBackgroundColor:
                          const Color(0xFF4E03D0).withValues(alpha: 0.3),
                      elevation: 0,
                    ),
                    child: _isSubmitting
                        ? SizedBox(
                            height: 20.h,
                            width: 20.w,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.volunteer_activism,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                _getDonationAmount() > 0
                                    ? 'Donate ${widget.crowdfund.currency} ${_getDonationAmount().toStringAsFixed(2)}'
                                    : 'Select an amount',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCrowdfundSummary() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1A1A3E),
            Color(0xFF0A0E27),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor:
                    const Color(0xFF4E03D0).withValues(alpha: 0.2),
                backgroundImage:
                    widget.crowdfund.creator.profilePicture != null
                        ? NetworkImage(
                            widget.crowdfund.creator.profilePicture!)
                        : null,
                child: widget.crowdfund.creator.profilePicture == null
                    ? Text(
                        widget.crowdfund.creator.initials,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF4E03D0),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    : null,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.crowdfund.title,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Text(
                          '${widget.crowdfund.creator.firstName} ${widget.crowdfund.creator.lastName}',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 13.sp,
                          ),
                        ),
                        if (widget.crowdfund.creator.verified) ...[
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.verified,
                            color: const Color(0xFF10B981),
                            size: 14.sp,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.1),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Target',
                style: GoogleFonts.inter(
                  color: const Color(0xFF6B7280),
                  fontSize: 12.sp,
                ),
              ),
              Text(
                '${widget.crowdfund.currency} ${widget.crowdfund.targetAmount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Raised',
                style: GoogleFonts.inter(
                  color: const Color(0xFF6B7280),
                  fontSize: 12.sp,
                ),
              ),
              Text(
                '${widget.crowdfund.currency} ${widget.crowdfund.currentAmount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: const Color(0xFF4E03D0),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmountField() {
    return TextFormField(
      controller: _amountController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        // Allow digits, commas, and a single decimal with up to 2
        // decimal places. Commas are display-only — _parseAmount
        // strips them before sending.
        FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
        _ThousandsSeparatorFormatter(),
      ],
      onChanged: _onAmountChanged,
      style: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
      ),
      validator: (_) {
        if (_amount <= 0) return 'Enter a donation amount';
        if (_amount < 1) {
          return 'Minimum donation is ${widget.crowdfund.currency} 1';
        }
        if (_personalAccount != null &&
            _amount > _personalAccount!.availableBalance) {
          return 'Amount exceeds available balance';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: '0',
        hintStyle: GoogleFonts.inter(
          color: const Color(0xFF6B7280),
          fontSize: 18.sp,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 14.h, 8.w, 14.h),
          child: Text(
            widget.crowdfund.currency,
            style: GoogleFonts.inter(
              color: const Color(0xFF4E03D0),
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 56.w),
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFFEF4444)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFFEF4444), width: 2),
        ),
      ),
    );
  }

  Widget _buildAmountQuickPills() {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: _suggestedAmounts.map((pillAmount) {
        final selected = _amount == pillAmount;
        return InkWell(
          onTap: () => _selectQuickAmount(pillAmount),
          borderRadius: BorderRadius.circular(20.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: selected
                  ? const Color(0xFF4E03D0)
                  : const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: const Color(0xFF4E03D0).withValues(alpha: 0.35),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Text(
              '${widget.crowdfund.currency} ${_formatAmount(pillAmount)}',
              style: GoogleFonts.inter(
                color: selected ? Colors.white : const Color(0xFF9CA3AF),
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPersonalAccountCard() {
    if (_accountLoading) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 20.w,
              height: 20.h,
              child: const CircularProgressIndicator(
                color: Color(0xFF4E03D0),
                strokeWidth: 2,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              'Loading account...',
              style: GoogleFonts.inter(
                color: const Color(0xFF6B7280),
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      );
    }

    if (_accountError != null || _personalAccount == null) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: const Color(0xFFEF4444).withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: const Color(0xFFEF4444),
              size: 20.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                _accountError ?? 'No personal account available',
                style: GoogleFonts.inter(
                  color: const Color(0xFFEF4444),
                  fontSize: 13.sp,
                ),
              ),
            ),
          ],
        ),
      );
    }

    final account = _personalAccount!;
    final hasSufficientBalance =
        _getDonationAmount() <= 0 || account.availableBalance >= _getDonationAmount();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A3E), Color(0xFF0A0E27)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
        border: !hasSufficientBalance
            ? Border.all(
                color: const Color(0xFFEF4444).withValues(alpha: 0.5))
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
            ),
            child: Icon(
              Icons.account_balance_wallet,
              color: const Color(0xFF4E03D0),
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  account.displayName,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '${account.currency} ${account.availableBalance.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: hasSufficientBalance
                        ? const Color(0xFF6B7280)
                        : const Color(0xFFEF4444),
                    fontSize: 12.sp,
                  ),
                ),
                if (!hasSufficientBalance) ...[
                  SizedBox(height: 2.h),
                  Text(
                    'Insufficient balance',
                    style: GoogleFonts.inter(
                      color: const Color(0xFFEF4444),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Icon(
            Icons.check_circle,
            color: const Color(0xFF4E03D0),
            size: 22.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildMessageField() {
    return TextFormField(
      controller: _messageController,
      maxLines: 3,
      maxLength: 200,
      style: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 14.sp,
      ),
      decoration: InputDecoration(
        hintText: 'Add a message of support (optional)',
        hintStyle: GoogleFonts.inter(
          color: const Color(0xFF6B7280),
          fontSize: 14.sp,
        ),
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        counterStyle: GoogleFonts.inter(
          color: const Color(0xFF6B7280),
          fontSize: 11.sp,
        ),
      ),
    );
  }

  Widget _buildAnonymousToggle() {
    return InkWell(
      onTap: () {
        setState(() {
          _isAnonymous = !_isAnonymous;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Checkbox(
              value: _isAnonymous,
              onChanged: (value) {
                setState(() {
                  _isAnonymous = value ?? false;
                });
              },
              activeColor: const Color(0xFF4E03D0),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Donate anonymously',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Your name will not be shown publicly',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF6B7280),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getDonationAmount() => _amount;
}

/// Reformats input as the user types so digits show grouped:
/// `1234567` → `1,234,567`. Caret position is reanchored from the
/// right so the user's typing index stays where they expect.
class _ThousandsSeparatorFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final raw = newValue.text;
    if (raw.isEmpty) return newValue;
    // Split on the (optional) decimal point and reformat the integer
    // half. Keep at most one decimal point and at most 2 fractional
    // digits — anything past that gets clipped.
    final parts = raw.replaceAll(',', '').split('.');
    final intPart = parts[0];
    String? fracPart = parts.length > 1 ? parts.sublist(1).join('') : null;
    if (fracPart != null && fracPart.length > 2) {
      fracPart = fracPart.substring(0, 2);
    }
    if (intPart.isEmpty && (fracPart == null || fracPart.isEmpty)) {
      return TextEditingValue(
        text: '',
        selection: const TextSelection.collapsed(offset: 0),
      );
    }
    // Reject all-zero leading runs ("000" → "0")
    final trimmed = intPart.replaceFirst(RegExp(r'^0+(?=\d)'), '');
    final buf = StringBuffer();
    for (var i = 0; i < trimmed.length; i++) {
      if (i > 0 && (trimmed.length - i) % 3 == 0) buf.write(',');
      buf.write(trimmed[i]);
    }
    final formatted = fracPart != null
        ? '$buf.$fracPart'
        : (raw.endsWith('.') ? '$buf.' : buf.toString());
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
