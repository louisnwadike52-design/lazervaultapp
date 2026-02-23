import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

/// Step 1: Select amount to add
class AddFundsAmountScreen extends StatefulWidget {
  final double initialAmount;
  final double availableCash;
  final String currency;
  final Function(double) onChanged;

  const AddFundsAmountScreen({
    super.key,
    required this.initialAmount,
    required this.availableCash,
    this.currency = 'USD',
    required this.onChanged,
  });

  @override
  State<AddFundsAmountScreen> createState() => _AddFundsAmountScreenState();
}

class _AddFundsAmountScreenState extends State<AddFundsAmountScreen> {
  late TextEditingController _amountController;
  double _amount = 0.0;

  final List<double> _quickAmounts = [100, 500, 1000, 2500, 5000, 10000];

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current balance card
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
                        const Color(0xFF4A90E2).withValues(alpha: 0.3),
                        const Color(0xFF357ABD).withValues(alpha: 0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.account_balance_wallet,
                    color: const Color(0xFF4A90E2),
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
                      CurrencySymbols.formatAmountWithCurrency(widget.availableCash, widget.currency),
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
              prefixText: '${CurrencySymbols.getSymbol(widget.currency)} ',
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

          // Quick amount buttons
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
            children: _quickAmounts.map((amount) {
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
                    '${CurrencySymbols.getSymbol(widget.currency)}${amount.toStringAsFixed(0)}',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF6366F1),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 32.h),

          // Info box
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.blue,
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deposit Limits',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Minimum: ${CurrencySymbols.getSymbol(widget.currency)}10 • Maximum: ${CurrencySymbols.getSymbol(widget.currency)}100,000 per transaction',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.blue[200],
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
            // New balance preview
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New Balance',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.green[200],
                    ),
                  ),
                  Text(
                    CurrencySymbols.formatAmountWithCurrency(widget.availableCash + _amount, widget.currency),
                    style: GoogleFonts.inter(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.green,
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
