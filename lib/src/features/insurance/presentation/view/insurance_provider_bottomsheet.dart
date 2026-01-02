import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/insurance_payment_entity.dart';

/// Bottom sheet for selecting insurance payment method with search functionality
class InsuranceProviderBottomSheet extends StatefulWidget {
  final Function(PaymentMethod) onMethodSelected;

  const InsuranceProviderBottomSheet({
    super.key,
    required this.onMethodSelected,
  });

  @override
  State<InsuranceProviderBottomSheet> createState() =>
      _InsuranceProviderBottomSheetState();

  /// Show the bottom sheet
  static Future<PaymentMethod?> show(BuildContext context) {
    return showModalBottomSheet<PaymentMethod>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => InsuranceProviderBottomSheet(
        onMethodSelected: (method) {
          Navigator.pop(context, method);
        },
      ),
    );
  }
}

class _InsuranceProviderBottomSheetState
    extends State<InsuranceProviderBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  PaymentMethod? _selectedMethod;
  List<Map<String, dynamic>> _filteredMethods = [];

  final List<Map<String, dynamic>> _allPaymentMethods = [
    {
      'method': PaymentMethod.card,
      'name': 'Credit/Debit Card',
      'icon': Icons.credit_card,
      'description': 'Visa, Mastercard, Amex',
      'keywords': ['card', 'credit', 'debit', 'visa', 'mastercard', 'amex'],
    },
    {
      'method': PaymentMethod.bankTransfer,
      'name': 'Bank Transfer',
      'icon': Icons.account_balance,
      'description': 'Direct bank transfer',
      'keywords': ['bank', 'transfer', 'direct', 'account'],
    },
    {
      'method': PaymentMethod.mobileMoney,
      'name': 'Mobile Money',
      'icon': Icons.phone_android,
      'description': 'M-Pesa, MTN, Airtel',
      'keywords': ['mobile', 'money', 'mpesa', 'mtn', 'airtel', 'phone'],
    },
    {
      'method': PaymentMethod.crypto,
      'name': 'Cryptocurrency',
      'icon': Icons.currency_bitcoin,
      'description': 'BTC, ETH, USDT',
      'keywords': ['crypto', 'bitcoin', 'btc', 'ethereum', 'eth', 'usdt'],
    },
    {
      'method': PaymentMethod.wallet,
      'name': 'LazerVault Wallet',
      'icon': Icons.account_balance_wallet,
      'description': 'Use your wallet balance',
      'keywords': ['wallet', 'lazervault', 'balance'],
    },
  ];

  @override
  void initState() {
    super.initState();
    _filteredMethods = _allPaymentMethods;
    _searchController.addListener(_filterMethods);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterMethods);
    _searchController.dispose();
    super.dispose();
  }

  void _filterMethods() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredMethods = _allPaymentMethods;
      } else {
        _filteredMethods = _allPaymentMethods.where((method) {
          final keywords = method['keywords'] as List<String>;
          final name = (method['name'] as String).toLowerCase();
          final description = (method['description'] as String).toLowerCase();

          return name.contains(query) ||
                 description.contains(query) ||
                 keywords.any((keyword) => keyword.contains(query));
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          SizedBox(height: 16.h),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Payment Method',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // Search bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
              child: TextField(
                controller: _searchController,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                ),
                decoration: InputDecoration(
                  hintText: 'Search payment methods...',
                  hintStyle: GoogleFonts.inter(
                    color: Colors.grey[500],
                    fontSize: 15.sp,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey[500],
                    size: 20.sp,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Colors.grey[500],
                            size: 20.sp,
                          ),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 20.h),

          // Payment methods list
          Expanded(
            child: _filteredMethods.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: _filteredMethods.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: _buildPaymentMethodCard(_filteredMethods[index]),
                      );
                    },
                  ),
          ),

          // Confirm button
          if (_selectedMethod != null) _buildConfirmButton(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64.sp,
            color: Colors.grey[600],
          ),
          SizedBox(height: 16.h),
          Text(
            'No payment methods found',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              color: Colors.grey[500],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Try a different search term',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(Map<String, dynamic> methodData) {
    final method = methodData['method'] as PaymentMethod;
    final isSelected = _selectedMethod == method;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedMethod = method);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF6366F1).withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF6366F1)
                : Colors.white.withValues(alpha: 0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF6366F1).withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                methodData['icon'] as IconData,
                size: 24.sp,
                color: isSelected ? const Color(0xFF6366F1) : Colors.white,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    methodData['name'] as String,
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    methodData['description'] as String,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                size: 24.sp,
                color: const Color(0xFF6366F1),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            if (_selectedMethod != null) {
              widget.onMethodSelected(_selectedMethod!);
              Navigator.pop(context);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Text(
                'Confirm Selection',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
