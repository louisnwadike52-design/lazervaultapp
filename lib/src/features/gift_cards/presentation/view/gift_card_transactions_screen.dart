import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/gift_card_entity.dart';

class GiftCardTransactionsScreen extends StatefulWidget {
  const GiftCardTransactionsScreen({super.key});

  @override
  State<GiftCardTransactionsScreen> createState() =>
      _GiftCardTransactionsScreenState();
}

class _GiftCardTransactionsScreenState
    extends State<GiftCardTransactionsScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _searchController = TextEditingController();
  String? _selectedFilter;
  List<GiftCardTransaction> _transactions = [];
  List<GiftCardTransaction> _filteredTransactions = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _animationController.forward();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF0F0F23),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    // Load transactions
    _loadMockTransactions();
  }

  void _loadMockTransactions() {
    // Mock data - in production, this would come from the cubit
    _transactions = [
      GiftCardTransaction(
        id: 'txn_1',
        giftCardId: 'gc_1',
        userId: 'user_1',
        amount: 100.00,
        currency: 'USD',
        transactionDate: DateTime.now().subtract(const Duration(hours: 2)),
        transactionType: 'purchase',
        status: GiftCardStatus.active,
        brandName: 'Amazon',
        description: 'Purchased Amazon gift card',
      ),
      GiftCardTransaction(
        id: 'txn_2',
        giftCardId: 'gc_2',
        userId: 'user_1',
        amount: 50.00,
        currency: 'USD',
        transactionDate: DateTime.now().subtract(const Duration(days: 1)),
        transactionType: 'redeem',
        status: GiftCardStatus.used,
        brandName: 'Starbucks',
        description: 'Redeemed Starbucks gift card',
      ),
      GiftCardTransaction(
        id: 'txn_3',
        giftCardId: 'gc_3',
        userId: 'user_1',
        amount: 75.00,
        currency: 'USD',
        transactionDate: DateTime.now().subtract(const Duration(days: 2)),
        transactionType: 'transfer',
        status: GiftCardStatus.active,
        brandName: 'iTunes',
        description: 'Transferred to John Doe',
      ),
      GiftCardTransaction(
        id: 'txn_4',
        giftCardId: 'gc_4',
        userId: 'user_1',
        amount: 25.00,
        currency: 'USD',
        transactionDate: DateTime.now().subtract(const Duration(days: 3)),
        transactionType: 'purchase',
        status: GiftCardStatus.active,
        brandName: 'Netflix',
        description: 'Purchased Netflix gift card',
      ),
      GiftCardTransaction(
        id: 'txn_5',
        giftCardId: 'gc_5',
        userId: 'user_1',
        amount: 200.00,
        currency: 'USD',
        transactionDate: DateTime.now().subtract(const Duration(days: 5)),
        transactionType: 'sell',
        status: GiftCardStatus.used,
        brandName: 'Best Buy',
        description: 'Sold to marketplace',
      ),
      GiftCardTransaction(
        id: 'txn_6',
        giftCardId: 'gc_6',
        userId: 'user_1',
        amount: 150.00,
        currency: 'USD',
        transactionDate: DateTime.now().subtract(const Duration(days: 7)),
        transactionType: 'purchase',
        status: GiftCardStatus.active,
        brandName: 'Target',
        description: 'Purchased Target gift card',
      ),
    ];
    _filteredTransactions = _transactions;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterTransactions(String? type) {
    setState(() {
      _selectedFilter = type;
      if (type == null) {
        _filteredTransactions = _transactions;
      } else {
        _filteredTransactions = _transactions
            .where((txn) => txn.transactionType.toLowerCase() == type.toLowerCase())
            .toList();
      }
    });
  }

  void _searchTransactions(String query) {
    setState(() {
      if (query.isEmpty) {
        _filterTransactions(_selectedFilter);
      } else {
        _filteredTransactions = _transactions.where((txn) {
          final brandMatch =
              txn.brandName?.toLowerCase().contains(query.toLowerCase()) ?? false;
          final descMatch =
              txn.description?.toLowerCase().contains(query.toLowerCase()) ?? false;
          return brandMatch || descMatch;
        }).toList();
      }
    });
  }

  Future<void> _onRefresh() async {
    // Simulate refresh
    await Future.delayed(const Duration(seconds: 1));
    _loadMockTransactions();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F23),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0F0F23),
              const Color(0xFF0A0A1A),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildSearchBar(),
              _buildFilterChips(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  backgroundColor: const Color(0xFF1A1A3E),
                  color: Colors.blue,
                  child: _buildTransactionsList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h),
        child: Row(
          children: [
            Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transaction History',
                    style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${_filteredTransactions.length} transactions',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF6366F1),
                    const Color(0xFF8B5CF6),
                  ],
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: IconButton(
                onPressed: _showExportDialog,
                icon: Icon(
                  Icons.download_rounded,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
          ),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: _searchTransactions,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
          ),
          decoration: InputDecoration(
            hintText: 'Search transactions...',
            hintStyle: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 14.sp,
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: Colors.grey[400],
              size: 20.sp,
            ),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear_rounded,
                      color: Colors.grey[400],
                      size: 20.sp,
                    ),
                    onPressed: () {
                      _searchController.clear();
                      _searchTransactions('');
                    },
                  )
                : null,
            border: InputBorder.none,
            isDense: true,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = [
      {'label': 'All', 'value': null},
      {'label': 'Purchase', 'value': 'purchase'},
      {'label': 'Redeem', 'value': 'redeem'},
      {'label': 'Transfer', 'value': 'transfer'},
      {'label': 'Sell', 'value': 'sell'},
    ];

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        height: 50.h,
        margin: EdgeInsets.only(bottom: 8.h),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          itemCount: filters.length,
          itemBuilder: (context, index) {
            final filter = filters[index];
            final isSelected = _selectedFilter == filter['value'];
            return Container(
              margin: EdgeInsets.only(right: 8.w),
              child: FilterChip(
                selected: isSelected,
                label: Text(
                  filter['label'] as String,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.grey[400],
                  ),
                ),
                onSelected: (selected) {
                  _filterTransactions(selected ? filter['value'] : null);
                },
                backgroundColor: Colors.grey[900],
                selectedColor: const Color(0xFF6366F1),
                checkmarkColor: Colors.white,
                side: BorderSide(
                  color: isSelected
                      ? const Color(0xFF6366F1)
                      : Colors.white.withOpacity(0.1),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTransactionsList() {
    if (_filteredTransactions.isEmpty) {
      return _buildEmptyState();
    }

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          itemCount: _filteredTransactions.length,
          itemBuilder: (context, index) {
            final transaction = _filteredTransactions[index];
            return _buildTransactionCard(transaction, index);
          },
        ),
      ),
    );
  }

  Widget _buildTransactionCard(GiftCardTransaction transaction, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.08),
            Colors.white.withOpacity(0.04),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () => _showTransactionDetails(transaction),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                _buildTransactionIcon(transaction.transactionType),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.brandName ?? 'Gift Card',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        transaction.description ?? _getTransactionTypeLabel(transaction.transactionType),
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          color: Colors.grey[400],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        DateFormat('MMM dd, yyyy • hh:mm a')
                            .format(transaction.transactionDate),
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${_getTransactionSign(transaction.transactionType)}\$${transaction.amount.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: _getTransactionColor(transaction.transactionType),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    _buildStatusBadge(transaction.status),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionIcon(String type) {
    IconData icon;
    List<Color> gradientColors;

    switch (type.toLowerCase()) {
      case 'purchase':
        icon = Icons.shopping_cart_rounded;
        gradientColors = [const Color(0xFF10B981), const Color(0xFF059669)];
        break;
      case 'redeem':
        icon = Icons.redeem_rounded;
        gradientColors = [const Color(0xFF3B82F6), const Color(0xFF2563EB)];
        break;
      case 'transfer':
        icon = Icons.send_rounded;
        gradientColors = [const Color(0xFF8B5CF6), const Color(0xFF7C3AED)];
        break;
      case 'sell':
        icon = Icons.attach_money_rounded;
        gradientColors = [const Color(0xFFF59E0B), const Color(0xFFD97706)];
        break;
      default:
        icon = Icons.receipt_rounded;
        gradientColors = [const Color(0xFF6366F1), const Color(0xFF4F46E5)];
    }

    return Container(
      width: 48.w,
      height: 48.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradientColors),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: gradientColors[0].withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 24.sp,
      ),
    );
  }

  Widget _buildStatusBadge(GiftCardStatus status) {
    Color color;
    String label;

    switch (status) {
      case GiftCardStatus.active:
        color = const Color(0xFF10B981);
        label = 'Active';
        break;
      case GiftCardStatus.used:
        color = const Color(0xFF6B7280);
        label = 'Used';
        break;
      case GiftCardStatus.expired:
        color = const Color(0xFFEF4444);
        label = 'Expired';
        break;
      case GiftCardStatus.pending:
        color = const Color(0xFFF59E0B);
        label = 'Pending';
        break;
      case GiftCardStatus.cancelled:
        color = const Color(0xFFEF4444);
        label = 'Cancelled';
        break;
      case GiftCardStatus.partiallyRedeemed:
        color = const Color(0xFF3B82F6);
        label = 'Partially Redeemed';
        break;
      default:
        color = const Color(0xFF6366F1);
        label = 'Unknown';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  String _getTransactionSign(String type) {
    switch (type.toLowerCase()) {
      case 'purchase':
        return '-';
      case 'sell':
        return '+';
      case 'transfer':
        return '-';
      case 'redeem':
        return '';
      default:
        return '';
    }
  }

  Color _getTransactionColor(String type) {
    switch (type.toLowerCase()) {
      case 'purchase':
        return const Color(0xFFEF4444);
      case 'sell':
        return const Color(0xFF10B981);
      case 'transfer':
        return const Color(0xFF8B5CF6);
      case 'redeem':
        return const Color(0xFF3B82F6);
      default:
        return Colors.white;
    }
  }

  String _getTransactionTypeLabel(String type) {
    switch (type.toLowerCase()) {
      case 'purchase':
        return 'Gift card purchased';
      case 'redeem':
        return 'Gift card redeemed';
      case 'transfer':
        return 'Gift card transferred';
      case 'sell':
        return 'Gift card sold';
      default:
        return 'Transaction';
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Icon(
              Icons.receipt_long_rounded,
              size: 48.sp,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'No Transactions',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              _selectedFilter != null
                  ? 'No $_selectedFilter transactions found'
                  : 'Your transaction history will appear here',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.white.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  void _showTransactionDetails(GiftCardTransaction transaction) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF2C3E50),
            ],
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 20.h),
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            Text(
              'Transaction Details',
              style: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 24.h),
            _buildDetailRow('Transaction ID', transaction.id),
            SizedBox(height: 12.h),
            _buildDetailRow('Brand', transaction.brandName ?? 'N/A'),
            SizedBox(height: 12.h),
            _buildDetailRow('Type', _getTransactionTypeLabel(transaction.transactionType)),
            SizedBox(height: 12.h),
            _buildDetailRow('Amount', '\$${transaction.amount.toStringAsFixed(2)}'),
            SizedBox(height: 12.h),
            _buildDetailRow(
              'Date',
              DateFormat('MMM dd, yyyy • hh:mm a').format(transaction.transactionDate),
            ),
            SizedBox(height: 12.h),
            _buildDetailRow('Status', transaction.status.toString().split('.').last),
            if (transaction.description != null) ...[
              SizedBox(height: 12.h),
              _buildDetailRow('Description', transaction.description!),
            ],
            SizedBox(height: 24.h),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF6366F1),
                    const Color(0xFF8B5CF6),
                  ],
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Close',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: Colors.grey[400],
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.right,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  void _showExportDialog() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF2C3E50),
            ],
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 20.h),
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Text(
              'Export Transactions',
              style: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.h),
            _buildExportOption(
              'Export as PDF',
              Icons.picture_as_pdf_rounded,
              const Color(0xFFEF4444),
              () {
                Get.back();
                Get.snackbar(
                  'Exporting',
                  'Generating PDF report...',
                  backgroundColor: const Color(0xFFEF4444),
                  colorText: Colors.white,
                  borderRadius: 12.r,
                  margin: EdgeInsets.all(16.w),
                );
              },
            ),
            SizedBox(height: 12.h),
            _buildExportOption(
              'Export as CSV',
              Icons.table_chart_rounded,
              const Color(0xFF10B981),
              () {
                Get.back();
                Get.snackbar(
                  'Exporting',
                  'Generating CSV file...',
                  backgroundColor: const Color(0xFF10B981),
                  colorText: Colors.white,
                  borderRadius: 12.r,
                  margin: EdgeInsets.all(16.w),
                );
              },
            ),
            SizedBox(height: 12.h),
            _buildExportOption(
              'Share Report',
              Icons.share_rounded,
              const Color(0xFF3B82F6),
              () {
                Get.back();
                Get.snackbar(
                  'Sharing',
                  'Preparing report for sharing...',
                  backgroundColor: const Color(0xFF3B82F6),
                  colorText: Colors.white,
                  borderRadius: 12.r,
                  margin: EdgeInsets.all(16.w),
                );
              },
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildExportOption(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(icon, color: color, size: 24.sp),
                ),
                SizedBox(width: 16.w),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey[400],
                  size: 16.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
