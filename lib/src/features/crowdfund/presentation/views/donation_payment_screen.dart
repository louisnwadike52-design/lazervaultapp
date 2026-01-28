import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  int? _selectedAccountId;
  bool _isAnonymous = false;
  bool _isCustomAmount = false;

  final List<double> _suggestedAmounts = [10, 25, 50, 100];

  @override
  void dispose() {
    _amountController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _processDonation() {
    if (_formKey.currentState!.validate()) {
      final amount = _isCustomAmount
          ? double.parse(_amountController.text.trim())
          : _selectedSuggestedAmount!;

      context.read<CrowdfundCubit>().makeDonation(
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
          builder: (context) => DonationProcessingScreen(
            crowdfund: widget.crowdfund,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1F1F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Make a Donation',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
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
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
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
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12.h),
              _buildAccountSelector(),
              SizedBox(height: 24.h),
              // Optional message
              Text(
                'Message (Optional)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
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
                  onPressed: (_selectedSuggestedAmount != null ||
                          (_isCustomAmount &&
                              _amountController.text.isNotEmpty)) &&
                      _selectedAccountId != null
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
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.volunteer_activism,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Donate ${widget.crowdfund.currency} ${_getDonationAmount().toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
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
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24.r,
                backgroundColor: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                backgroundImage: widget.crowdfund.creator.profilePicture != null
                    ? NetworkImage(widget.crowdfund.creator.profilePicture!)
                    : null,
                child: widget.crowdfund.creator.profilePicture == null
                    ? Text(
                        '${widget.crowdfund.creator.firstName[0]}${widget.crowdfund.creator.lastName[0]}',
                        style: TextStyle(
                          color: const Color(0xFF4E03D0),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
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
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Text(
                          '${widget.crowdfund.creator.firstName} ${widget.crowdfund.creator.lastName}',
                          style: TextStyle(
                            color: Colors.grey[400],
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
          Divider(color: const Color(0xFF2D2D2D)),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Target',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12.sp,
                ),
              ),
              Text(
                '${widget.crowdfund.currency} ${widget.crowdfund.targetAmount.toStringAsFixed(2)}',
                style: TextStyle(
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
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12.sp,
                ),
              ),
              Text(
                '${widget.crowdfund.currency} ${widget.crowdfund.currentAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: const Color(0xFF4E03D0),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
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
              color: isSelected
                  ? const Color(0xFF4E03D0)
                  : const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF4E03D0)
                    : const Color(0xFF2D2D2D),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Center(
              child: Text(
                '${widget.crowdfund.currency} ${amount.toInt()}',
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[400],
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
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
          color: _isCustomAmount
              ? const Color(0xFF4E03D0)
              : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: _isCustomAmount
                ? const Color(0xFF4E03D0)
                : const Color(0xFF2D2D2D),
            width: _isCustomAmount ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            'Custom Amount',
            style: TextStyle(
              color: _isCustomAmount ? Colors.white : Colors.grey[400],
              fontSize: 14.sp,
              fontWeight: _isCustomAmount ? FontWeight.bold : FontWeight.w600,
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
      style: TextStyle(
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
        hintStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: 16.sp,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 14.h),
          child: Text(
            widget.crowdfund.currency,
            style: TextStyle(
              color: const Color(0xFF4E03D0),
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
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
          borderSide: const BorderSide(
            color: Color(0xFF4E03D0),
            width: 2,
          ),
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
    // Mock accounts - replace with real account data
    final accounts = [
      {'id': 1, 'name': 'Main Account', 'balance': 1000.0},
      {'id': 2, 'name': 'Savings Account', 'balance': 5000.0},
      {'id': 3, 'name': 'Business Account', 'balance': 2500.0},
    ];

    return Column(
      children: accounts.map((account) {
        final isSelected = _selectedAccountId == account['id'];
        return InkWell(
          onTap: () {
            setState(() {
              _selectedAccountId = account['id'] as int;
            });
          },
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            margin: EdgeInsets.only(bottom: 8.h),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF4E03D0).withValues(alpha: 0.1)
                  : const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF4E03D0)
                    : const Color(0xFF2D2D2D),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: isSelected
                      ? const Color(0xFF4E03D0)
                      : Colors.grey[500],
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        account['name'] as String,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Balance: ${widget.crowdfund.currency} ${(account['balance'] as double).toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.grey[500],
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

  Widget _buildMessageField() {
    return TextFormField(
      controller: _messageController,
      maxLines: 3,
      maxLength: 200,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14.sp,
      ),
      decoration: InputDecoration(
        hintText: 'Add a message of support (optional)',
        hintStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: 14.sp,
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
          borderSide: const BorderSide(
            color: Color(0xFF4E03D0),
            width: 2,
          ),
        ),
        counterStyle: TextStyle(
          color: Colors.grey[600],
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
          border: Border.all(color: const Color(0xFF2D2D2D)),
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
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Your name will not be shown publicly',
                    style: TextStyle(
                      color: Colors.grey[500],
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
