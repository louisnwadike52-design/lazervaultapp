import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

/// Step 2: Select withdrawal method
class WithdrawFundsMethodScreen extends StatefulWidget {
  final String selectedMethod;
  final String currency;
  final Function(String, Map<String, String>) onChanged;

  const WithdrawFundsMethodScreen({
    super.key,
    required this.selectedMethod,
    this.currency = 'USD',
    required this.onChanged,
  });

  @override
  State<WithdrawFundsMethodScreen> createState() => _WithdrawFundsMethodScreenState();
}

class _WithdrawFundsMethodScreenState extends State<WithdrawFundsMethodScreen> {
  late String _selectedMethod;
  final Map<String, String> _withdrawDetails = {};

  List<Map<String, dynamic>> get _withdrawMethods => [
    {
      'name': 'Bank Transfer',
      'icon': Icons.account_balance,
      'description': 'Transfer to your linked bank account',
      'processingTime': '1-3 business days',
      'fee': 'Free',
    },
    {
      'name': 'Wire Transfer',
      'icon': Icons.payment,
      'description': 'Direct wire transfer to your account',
      'processingTime': 'Same day',
      'fee': '${CurrencySymbols.getSymbol(widget.currency)}25 fee',
    },
    {
      'name': 'PayPal',
      'icon': Icons.paypal,
      'description': 'Instant transfer to your PayPal account',
      'processingTime': 'Instant',
      'fee': '2% fee',
    },
    {
      'name': 'Check',
      'icon': Icons.mail_outline,
      'description': 'Physical check mailed to your address',
      'processingTime': '5-7 business days',
      'fee': '${CurrencySymbols.getSymbol(widget.currency)}5 fee',
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedMethod = widget.selectedMethod;
  }

  void _selectMethod(String method) {
    setState(() {
      _selectedMethod = method;
    });
    widget.onChanged(_selectedMethod, _withdrawDetails);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose Withdrawal Method',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Select how you want to receive your funds',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(height: 24.h),

          // Withdrawal method options
          ..._withdrawMethods.map((method) {
            final isSelected = _selectedMethod == method['name'];
            return Container(
              margin: EdgeInsets.only(bottom: 12.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isSelected
                      ? [
                          const Color(0xFF6366F1).withValues(alpha: 0.3),
                          const Color(0xFF8B5CF6).withValues(alpha: 0.3),
                        ]
                      : [
                          const Color(0xFF2A2A3E).withValues(alpha: 0.8),
                          const Color(0xFF1F1F35).withValues(alpha: 0.9),
                        ],
                ),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF6366F1)
                      : Colors.white.withValues(alpha: 0.1),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16.r),
                  onTap: () => _selectMethod(method['name']),
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF6366F1).withValues(alpha: 0.3)
                                : Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            method['icon'],
                            color: isSelected ? const Color(0xFF6366F1) : Colors.grey[400],
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    method['name'],
                                    style: GoogleFonts.inter(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 2.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: method['fee'] == 'Free'
                                          ? Colors.green.withValues(alpha: 0.2)
                                          : Colors.orange.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(
                                      method['fee'],
                                      style: GoogleFonts.inter(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600,
                                        color: method['fee'] == 'Free'
                                            ? Colors.green
                                            : Colors.orange,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                method['description'],
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  color: Colors.grey[400],
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.grey[500],
                                    size: 12.sp,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    method['processingTime'],
                                    style: GoogleFonts.inter(
                                      fontSize: 11.sp,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: const Color(0xFF6366F1),
                            size: 24.sp,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),

          SizedBox(height: 24.h),

          // Security info
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lock_outline,
                  color: Colors.green,
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Secure Withdrawal',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Your withdrawal information is encrypted and secure. All transactions are monitored for fraud protection.',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.green[200],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
