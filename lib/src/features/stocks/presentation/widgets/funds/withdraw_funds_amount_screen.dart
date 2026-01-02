import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Step 1: Select amount to withdraw
class WithdrawFundsAmountScreen extends StatefulWidget {
  final double initialAmount;
  final double availableCash;
  final Function(double) onChanged;

  const WithdrawFundsAmountScreen({
    super.key,
    required this.initialAmount,
    required this.availableCash,
    required this.onChanged,
  });

  @override
  State<WithdrawFundsAmountScreen> createState() => _WithdrawFundsAmountScreenState();
}

class _WithdrawFundsAmountScreenState extends State<WithdrawFundsAmountScreen> {
  late TextEditingController _amountController;
  double _amount = 0.0;

  final List<double> _quickAmounts = [100, 500, 1000, 2000];

  @override
  void initState() {
    super.initState();
    _amount = widget.initialAmount;
    _amountController = TextEditingController(
      text: _amount > 0 ? _amount.toStringAsFixed(2) : '',
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _updateAmount(double amount) {
    setState(() {
      _amount = amount;
    });
    widget.onChanged(_amount);
  }

  void _withdrawAll() {
    _amountController.text = widget.availableCash.toStringAsFixed(2);
    _updateAmount(widget.availableCash);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Available cash card
          Container(
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
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFE53E3E).withValues(alpha: 0.3),
                        const Color(0xFFD53F3F).withValues(alpha: 0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.account_balance_wallet,
                    color: const Color(0xFFE53E3E),
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available Cash',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '\$${widget.availableCash.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 32.h),

          // Amount input
          Text(
            'Enter Amount',
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
            style: GoogleFonts.inter(
              fontSize: 32.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            decoration: InputDecoration(
              prefixText: '\$ ',
              prefixStyle: GoogleFonts.inter(
                fontSize: 32.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              hintText: '0.00',
              hintStyle: GoogleFonts.inter(
                fontSize: 32.sp,
                color: Colors.grey[600],
              ),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.05),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            onChanged: (value) {
              final amount = double.tryParse(value) ?? 0.0;
              _updateAmount(amount);
            },
          ),

          SizedBox(height: 24.h),

          // Quick amount buttons + Withdraw All
          Text(
            'Quick Amounts',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.h),

          Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: [
              ..._quickAmounts.where((amount) => amount <= widget.availableCash).map((amount) {
                return InkWell(
                  onTap: () {
                    _amountController.text = amount.toStringAsFixed(2);
                    _updateAmount(amount);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF6366F1).withValues(alpha: 0.2),
                          const Color(0xFF8B5CF6).withValues(alpha: 0.2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: const Color(0xFF6366F1).withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      '\$${amount.toStringAsFixed(0)}',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF6366F1),
                      ),
                    ),
                  ),
                );
              }).toList(),
              // Withdraw All button
              InkWell(
                onTap: _withdrawAll,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFE53E3E).withValues(alpha: 0.3),
                        const Color(0xFFD53F3F).withValues(alpha: 0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: const Color(0xFFE53E3E).withValues(alpha: 0.5),
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.all_inclusive,
                        color: const Color(0xFFE53E3E),
                        size: 16.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Withdraw All',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFE53E3E),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 32.h),

          // Info box
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.orange,
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Withdrawal Limits',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.orange,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Minimum: \$10 • Maximum: \$${widget.availableCash.toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.orange[200],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          if (_amount > 0) ...[
            SizedBox(height: 24.h),
            // Remaining balance preview
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Remaining Balance',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[200],
                    ),
                  ),
                  Text(
                    '\$${(widget.availableCash - _amount).toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue,
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
}
