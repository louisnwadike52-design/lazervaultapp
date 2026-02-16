import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import '../../../../../core/services/injection_container.dart';
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

class _DonationPaymentScreenState extends State<DonationPaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _messageController = TextEditingController();

  double? _selectedSuggestedAmount;
  bool _isAnonymous = false;
  bool _isCustomAmount = false;
  bool _isSubmitting = false;
  String? _selectedAccountId;
  late final AccountCardsSummaryCubit _accountsCubit;

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
    _accountsCubit = serviceLocator<AccountCardsSummaryCubit>();
    final userId = context.read<AuthenticationCubit>().userId ?? '';
    _accountsCubit.fetchAccountSummaries(userId: userId);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _messageController.dispose();
    _accountsCubit.close();
    super.dispose();
  }

  void _processDonation() {
    if (_isSubmitting) return;
    if (!_formKey.currentState!.validate()) return;

    final amount = _getDonationAmount();
    if (amount <= 0) return;

    setState(() => _isSubmitting = true);

    final cubit = context.read<CrowdfundCubit>();

    cubit.makeDonation(
          crowdfundId: widget.crowdfund.id,
          amount: amount,
          message: _messageController.text.trim().isEmpty
              ? null
              : _messageController.text.trim(),
          isAnonymous: _isAnonymous,
          sourceAccountId: _selectedAccountId,
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Crowdfund summary
              _buildCrowdfundSummary(),
              SizedBox(height: 24.h),
              // Amount section
              Text(
                'Select Amount',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 12.h),
              _buildSuggestedAmounts(),
              SizedBox(height: 12.h),
              _buildCustomAmountToggle(),
              if (_isCustomAmount) ...[
                SizedBox(height: 12.h),
                _buildCustomAmountField(),
              ],
              SizedBox(height: 24.h),
              // Source account section
              Text(
                'Source Account',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 12.h),
              _buildAccountSelector(),
              SizedBox(height: 24.h),
              // Optional message
              Text(
                'Message (Optional)',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 12.h),
              _buildMessageField(),
              SizedBox(height: 16.h),
              // Anonymous toggle
              _buildAnonymousToggle(),
              SizedBox(height: 32.h),
              // Donate button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: !_isSubmitting &&
                      _getDonationAmount() > 0 &&
                      _selectedAccountId != null
                      ? _processDonation
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    disabledBackgroundColor:
                        const Color(0xFF6366F1).withValues(alpha: 0.3),
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
    );
  }

  Widget _buildCrowdfundSummary() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1A1A3E),
            Color(0xFF0A0E27),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24.r,
                backgroundColor: const Color(0xFF6366F1).withValues(alpha: 0.2),
                backgroundImage: widget.crowdfund.creator.profilePicture != null
                    ? NetworkImage(widget.crowdfund.creator.profilePicture!)
                    : null,
                child: widget.crowdfund.creator.profilePicture == null
                    ? Text(
                        '${widget.crowdfund.creator.firstName[0]}${widget.crowdfund.creator.lastName[0]}',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF6366F1),
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
                  color: const Color(0xFF6366F1),
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

  Widget _buildSuggestedAmounts() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.h,
        childAspectRatio: 1.5,
      ),
      itemCount: _suggestedAmounts.length,
      itemBuilder: (context, index) {
        final amount = _suggestedAmounts[index];
        final isSelected =
            !_isCustomAmount && _selectedSuggestedAmount == amount;
        return InkWell(
          onTap: () {
            setState(() {
              _selectedSuggestedAmount = amount;
              _isCustomAmount = false;
            });
          },
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            decoration: BoxDecoration(
              gradient: isSelected
                  ? const LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              color: isSelected ? null : const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Text(
                '${widget.crowdfund.currency} ${amount.toInt()}',
                style: GoogleFonts.inter(
                  color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCustomAmountToggle() {
    return InkWell(
      onTap: () {
        setState(() {
          _isCustomAmount = !_isCustomAmount;
          if (_isCustomAmount) {
            _selectedSuggestedAmount = null;
          }
        });
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: _isCustomAmount
              ? const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: _isCustomAmount ? null : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: Text(
            'Custom Amount',
            style: GoogleFonts.inter(
              color: _isCustomAmount ? Colors.white : const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: _isCustomAmount ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomAmountField() {
    return TextFormField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      autofocus: true,
      style: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 16.sp,
      ),
      validator: (value) {
        if (_isCustomAmount) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter an amount';
          }
          final amount = double.tryParse(value.trim());
          if (amount == null || amount <= 0) {
            return 'Invalid amount';
          }
          if (amount < 1) {
            return 'Minimum donation is ${widget.crowdfund.currency} 1';
          }
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Enter amount',
        hintStyle: GoogleFonts.inter(
          color: const Color(0xFF6B7280),
          fontSize: 16.sp,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 14.h),
          child: Text(
            widget.crowdfund.currency,
            style: GoogleFonts.inter(
              color: const Color(0xFF6366F1),
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFFEF4444)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(
            color: Color(0xFFEF4444),
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildAccountSelector() {
    return BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      bloc: _accountsCubit,
      builder: (context, state) {
        if (state is AccountCardsSummaryLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF6366F1)),
          );
        }

        if (state is AccountCardsSummaryError) {
          return Text(
            'Failed to load accounts',
            style: GoogleFonts.inter(color: const Color(0xFFEF4444), fontSize: 13.sp),
          );
        }

        if (state is AccountCardsSummaryLoaded) {
          final accounts = state.accountSummaries
              .where((a) => a.currency.toUpperCase() == widget.crowdfund.currency.toUpperCase())
              .toList();

          if (accounts.isEmpty) {
            return Text(
              'No ${widget.crowdfund.currency} accounts available',
              style: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 13.sp),
            );
          }

          // Auto-select primary or first account
          if (_selectedAccountId == null) {
            final primary = accounts.where((a) => a.isPrimary).firstOrNull;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  _selectedAccountId = (primary ?? accounts.first).id;
                });
              }
            });
          }

          return Column(
            children: accounts.map((account) {
              final isSelected = _selectedAccountId == account.id;
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedAccountId = account.id;
                  });
                },
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? const LinearGradient(
                            colors: [Color(0xFF1A1A3E), Color(0xFF0A0E27)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    color: isSelected ? null : const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: isSelected
                            ? const Color(0xFF6366F1)
                            : const Color(0xFF6B7280),
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
                              '${account.currency} ${account.balance.toStringAsFixed(2)}',
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
            }).toList(),
          );
        }

        return const SizedBox.shrink();
      },
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
              activeColor: const Color(0xFF6366F1),
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

  double _getDonationAmount() {
    if (_isCustomAmount) {
      return double.tryParse(_amountController.text.trim()) ?? 0.0;
    }
    return _selectedSuggestedAmount ?? 0.0;
  }
}
