import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../currency_exchange/domain/entities/transaction_entity.dart';
import '../../../currency_exchange/domain/entities/recipient_entity.dart';
import '../../../currency_exchange/domain/entities/currency_entity.dart';
import '../../../currency_exchange/data/currency_data.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  final TextEditingController _searchController = TextEditingController();
  List<CurrencyTransaction> _allTransactions = [];
  List<CurrencyTransaction> _filteredTransactions = [];
  TransactionStatus? _selectedStatusFilter;
  String? _selectedCurrencyFilter;
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
    
    _loadMockTransactions();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _loadMockTransactions() {
    final mockRecipients = [
      Recipient(
        id: '1',
        name: 'John Smith',
        email: 'john.smith@email.com',
        accountNumber: '1234567890',
        bankName: 'Chase Bank',
        countryCode: 'US',
        currency: 'USD',
        createdAt: DateTime.now(),
      ),
      Recipient(
        id: '2',
        name: 'Emma Johnson',
        email: 'emma.johnson@email.com',
        accountNumber: '12345678',
        bankName: 'Barclays',
        countryCode: 'GB',
        currency: 'GBP',
        createdAt: DateTime.now(),
      ),
      Recipient(
        id: '3',
        name: 'Marie Dubois',
        email: 'marie.dubois@email.com',
        accountNumber: 'FR1420041010050500013M02606',
        bankName: 'BNP Paribas',
        countryCode: 'FR',
        currency: 'EUR',
        createdAt: DateTime.now(),
      ),
    ];

    _allTransactions = [
      CurrencyTransaction(
        id: '1',
        fromCurrency: 'USD',
        toCurrency: 'EUR',
        fromAmount: 1000.0,
        toAmount: 850.0,
        exchangeRate: 0.85,
        fees: 10.0,
        totalCost: 1010.0,
        recipient: mockRecipients[0],
        status: TransactionStatus.completed,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        completedAt: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
        referenceNumber: 'TXN001',
        type: TransactionType.send,
      ),
      CurrencyTransaction(
        id: '2',
        fromCurrency: 'GBP',
        toCurrency: 'USD',
        fromAmount: 500.0,
        toAmount: 685.0,
        exchangeRate: 1.37,
        fees: 5.0,
        totalCost: 505.0,
        recipient: mockRecipients[1],
        status: TransactionStatus.processing,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        referenceNumber: 'TXN002',
        type: TransactionType.send,
      ),
      CurrencyTransaction(
        id: '3',
        fromCurrency: 'EUR',
        toCurrency: 'GBP',
        fromAmount: 750.0,
        toAmount: 650.0,
        exchangeRate: 0.867,
        fees: 7.5,
        totalCost: 757.5,
        recipient: mockRecipients[2],
        status: TransactionStatus.failed,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        referenceNumber: 'TXN003',
        type: TransactionType.send,
        failureReason: 'Insufficient funds',
      ),
      CurrencyTransaction(
        id: '4',
        fromCurrency: 'USD',
        toCurrency: 'JPY',
        fromAmount: 2000.0,
        toAmount: 220000.0,
        exchangeRate: 110.0,
        fees: 20.0,
        totalCost: 2020.0,
        recipient: mockRecipients[0],
        status: TransactionStatus.completed,
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        completedAt: DateTime.now().subtract(const Duration(days: 5, hours: 1)),
        referenceNumber: 'TXN004',
        type: TransactionType.send,
      ),
      CurrencyTransaction(
        id: '5',
        fromCurrency: 'CAD',
        toCurrency: 'USD',
        fromAmount: 1250.0,
        toAmount: 1000.0,
        exchangeRate: 0.8,
        fees: 12.5,
        totalCost: 1262.5,
        recipient: mockRecipients[1],
        status: TransactionStatus.pending,
        createdAt: DateTime.now().subtract(const Duration(hours: 6)),
        referenceNumber: 'TXN005',
        type: TransactionType.send,
      ),
    ];
    
    _filteredTransactions = List.from(_allTransactions);
    setState(() {});
  }

  void _filterTransactions() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredTransactions = _allTransactions.where((transaction) {
        final matchesSearch = query.isEmpty ||
            transaction.recipient.name.toLowerCase().contains(query) ||
            transaction.fromCurrency.toLowerCase().contains(query) ||
            transaction.toCurrency.toLowerCase().contains(query) ||
            transaction.referenceNumber?.toLowerCase().contains(query) == true;
        
        final matchesStatus = _selectedStatusFilter == null || 
            transaction.status == _selectedStatusFilter;
        
        final matchesCurrency = _selectedCurrencyFilter == null ||
            transaction.fromCurrency == _selectedCurrencyFilter ||
            transaction.toCurrency == _selectedCurrencyFilter;
        
        final matchesDate = _selectedDateRange == null ||
            (transaction.createdAt.isAfter(_selectedDateRange!.start) &&
             transaction.createdAt.isBefore(_selectedDateRange!.end.add(const Duration(days: 1))));
        
        return matchesSearch && matchesStatus && matchesCurrency && matchesDate;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F23),
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
              _buildSearchAndFilters(),
              _buildFilterChips(),
              _buildSummaryCards(),
              Expanded(
                child: _buildTransactionsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: FadeTransition(
        opacity: _fadeAnimation,
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
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '${_filteredTransactions.length} transactions',
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: IconButton(
                icon: Icon(Icons.file_download, color: Colors.white, size: 20.sp),
                onPressed: () => _exportTransactions(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey[400], size: 20.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search transactions...',
                      hintStyle: GoogleFonts.inter(
                        color: Colors.grey[400],
                        fontSize: 16.sp,
                      ),
                    ),
                    onChanged: (_) => _filterTransactions(),
                  ),
                ),
                if (_searchController.text.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      _searchController.clear();
                      _filterTransactions();
                    },
                    child: Icon(Icons.clear, color: Colors.grey[400], size: 20.sp),
                  ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _buildFilterButton(
                  'Date Range',
                  Icons.date_range,
                  _selectedDateRange != null ? 'Custom' : 'All Time',
                  () => _showDateRangePicker(),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _buildFilterButton(
                  'Currency',
                  Icons.monetization_on,
                  _selectedCurrencyFilter ?? 'All',
                  () => _showCurrencyFilter(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String label, IconData icon, String value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.grey[400], size: 16.sp),
            SizedBox(width: 6.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 10.sp,
                    ),
                  ),
                  Text(
                    value,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 50.h,
      margin: EdgeInsets.symmetric(vertical: 16.h),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          _buildStatusFilterChip('All', null),
          SizedBox(width: 8.w),
          _buildStatusFilterChip('Completed', TransactionStatus.completed),
          SizedBox(width: 8.w),
          _buildStatusFilterChip('Processing', TransactionStatus.processing),
          SizedBox(width: 8.w),
          _buildStatusFilterChip('Pending', TransactionStatus.pending),
          SizedBox(width: 8.w),
          _buildStatusFilterChip('Failed', TransactionStatus.failed),
        ],
      ),
    );
  }

  Widget _buildStatusFilterChip(String label, TransactionStatus? status) {
    final isSelected = _selectedStatusFilter == status;
    Color chipColor = Colors.grey[900]!;
    Color textColor = Colors.grey[400]!;
    
    if (isSelected) {
      switch (status) {
        case TransactionStatus.completed:
          chipColor = Colors.green;
          textColor = Colors.white;
          break;
        case TransactionStatus.processing:
          chipColor = Colors.orange;
          textColor = Colors.white;
          break;
        case TransactionStatus.pending:
          chipColor = Colors.blue;
          textColor = Colors.white;
          break;
        case TransactionStatus.failed:
          chipColor = Colors.red;
          textColor = Colors.white;
          break;
        default:
          chipColor = Colors.blue;
          textColor = Colors.white;
      }
    }
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStatusFilter = isSelected ? null : status;
        });
        _filterTransactions();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: chipColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? chipColor : Colors.white.withOpacity(0.1),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: textColor,
            fontSize: 14.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCards() {
    final totalSent = _filteredTransactions
        .where((t) => t.status == TransactionStatus.completed)
        .fold(0.0, (sum, t) => sum + t.fromAmount);
    
    final totalFees = _filteredTransactions
        .where((t) => t.status == TransactionStatus.completed)
        .fold(0.0, (sum, t) => sum + t.fees);
    
    final completedCount = _filteredTransactions
        .where((t) => t.status == TransactionStatus.completed)
        .length;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryCard(
              'Total Sent',
              '\$${totalSent.toStringAsFixed(2)}',
              Icons.arrow_upward,
              Colors.green,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _buildSummaryCard(
              'Total Fees',
              '\$${totalFees.toStringAsFixed(2)}',
              Icons.receipt,
              Colors.orange,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _buildSummaryCard(
              'Completed',
              '$completedCount',
              Icons.check_circle,
              Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24.sp),
          SizedBox(height: 8.h),
          Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 12.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList() {
    if (_filteredTransactions.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: _filteredTransactions.length,
      itemBuilder: (context, index) {
        final transaction = _filteredTransactions[index];
        return _buildTransactionCard(transaction, index);
      },
    );
  }

  Widget _buildTransactionCard(CurrencyTransaction transaction, int index) {
    final fromCurrency = CurrencyData.getCurrencyByCode(transaction.fromCurrency);
    final toCurrency = CurrencyData.getCurrencyByCode(transaction.toCurrency);
    
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16.r),
            onTap: () => _showTransactionDetails(transaction),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: _getStatusColor(transaction.status).withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _getStatusIcon(transaction.status),
                          color: _getStatusColor(transaction.status),
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
                                if (fromCurrency != null) ...[
                                  _buildCurrencyFlag(fromCurrency),
                                  SizedBox(width: 4.w),
                                ],
                                Text(
                                  transaction.fromCurrency,
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Icon(Icons.arrow_forward, color: Colors.grey[400], size: 16.sp),
                                SizedBox(width: 8.w),
                                if (toCurrency != null) ...[
                                  _buildCurrencyFlag(toCurrency),
                                  SizedBox(width: 4.w),
                                ],
                                Text(
                                  transaction.toCurrency,
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'To ${transaction.recipient.name}',
                              style: GoogleFonts.inter(
                                color: Colors.grey[400],
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              _formatDate(transaction.createdAt),
                              style: GoogleFonts.inter(
                                color: Colors.grey[500],
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            transaction.formattedFromAmount,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: _getStatusColor(transaction.status).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              _getStatusText(transaction.status),
                              style: GoogleFonts.inter(
                                color: _getStatusColor(transaction.status),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (transaction.status == TransactionStatus.failed && transaction.failureReason != null) ...[
                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.red.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline, color: Colors.red, size: 16.sp),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              transaction.failureReason!,
                              style: GoogleFonts.inter(
                                color: Colors.red,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrencyFlag(Currency currency) {
    return Container(
      width: 20.w,
      height: 14.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.r),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2.r),
        child: CachedNetworkImage(
          imageUrl: currency.flagUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: Colors.grey[300],
            child: Icon(Icons.flag, size: 10.sp, color: Colors.grey[600]),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[300],
            child: Icon(Icons.flag, size: 10.sp, color: Colors.grey[600]),
          ),
        ),
      ),
    );
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
              Icons.receipt_long,
              size: 48.sp,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'No Transactions Found',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Your transaction history will appear here',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.completed:
        return Colors.green;
      case TransactionStatus.processing:
        return Colors.orange;
      case TransactionStatus.pending:
        return Colors.blue;
      case TransactionStatus.failed:
        return Colors.red;
      case TransactionStatus.cancelled:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.completed:
        return Icons.check_circle;
      case TransactionStatus.processing:
        return Icons.hourglass_empty;
      case TransactionStatus.pending:
        return Icons.schedule;
      case TransactionStatus.failed:
        return Icons.error;
      case TransactionStatus.cancelled:
        return Icons.cancel;
    }
  }

  String _getStatusText(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.completed:
        return 'Completed';
      case TransactionStatus.processing:
        return 'Processing';
      case TransactionStatus.pending:
        return 'Pending';
      case TransactionStatus.failed:
        return 'Failed';
      case TransactionStatus.cancelled:
        return 'Cancelled';
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;
    
    if (difference == 0) {
      return 'Today ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return '$difference days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _showTransactionDetails(CurrencyTransaction transaction) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.grey[900],
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
            Row(
              children: [
                Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: _getStatusColor(transaction.status).withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getStatusIcon(transaction.status),
                    color: _getStatusColor(transaction.status),
                    size: 30.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transaction Details',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        transaction.referenceNumber ?? 'No reference',
                        style: GoogleFonts.inter(
                          color: Colors.grey[400],
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            _buildDetailRow('From', transaction.formattedFromAmount),
            _buildDetailRow('To', transaction.formattedToAmount),
            _buildDetailRow('Exchange Rate', '1 ${transaction.fromCurrency} = ${transaction.exchangeRate.toStringAsFixed(4)} ${transaction.toCurrency}'),
            _buildDetailRow('Fees', transaction.formattedFees),
            _buildDetailRow('Total Cost', transaction.formattedTotalCost),
            _buildDetailRow('Recipient', transaction.recipient.name),
            _buildDetailRow('Bank', transaction.recipient.bankName),
            _buildDetailRow('Status', _getStatusText(transaction.status)),
            _buildDetailRow('Created', _formatDate(transaction.createdAt)),
            if (transaction.completedAt != null)
              _buildDetailRow('Completed', _formatDate(transaction.completedAt!)),
            if (transaction.failureReason != null)
              _buildDetailRow('Failure Reason', transaction.failureReason!),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Get.back();
                      _shareTransaction(transaction);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white.withOpacity(0.3)),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Share',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      _downloadReceipt(transaction);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Download Receipt',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontSize: 12.sp,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDateRangePicker() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      initialDateRange: _selectedDateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.blue,
              onPrimary: Colors.white,
              surface: Colors.grey[900]!,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      setState(() {
        _selectedDateRange = picked;
      });
      _filterTransactions();
    }
  }

  void _showCurrencyFilter() {
    final currencies = CurrencyData.allCurrencies.map((c) => c.code).toSet().toList();
    
    Get.bottomSheet(
      Container(
        height: 400.h,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
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
              'Filter by Currency',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView.builder(
                itemCount: currencies.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _buildCurrencyFilterItem('All Currencies', null);
                  }
                  final currency = currencies[index - 1];
                  return _buildCurrencyFilterItem(currency, currency);
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildCurrencyFilterItem(String label, String? currency) {
    final isSelected = _selectedCurrencyFilter == currency;
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () {
            setState(() {
              _selectedCurrencyFilter = currency;
            });
            _filterTransactions();
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
                             children: [
                 if (currency != null) ...[
                   () {
                     final currencyData = CurrencyData.getCurrencyByCode(currency);
                     if (currencyData != null) {
                       return Row(
                         children: [
                           _buildCurrencyFlag(currencyData),
                           SizedBox(width: 12.w),
                         ],
                       );
                     }
                     return const SizedBox.shrink();
                   }(),
                 ],
                Text(
                  label,
                  style: GoogleFonts.inter(
                    color: isSelected ? Colors.blue : Colors.white,
                    fontSize: 14.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                const Spacer(),
                if (isSelected)
                  Icon(Icons.check, color: Colors.blue, size: 20.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _exportTransactions() {
    Get.snackbar(
      'Export',
      'Transaction export feature will be implemented',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue.withOpacity(0.8),
      colorText: Colors.white,
    );
  }

  void _shareTransaction(CurrencyTransaction transaction) {
    Get.snackbar(
      'Share',
      'Transaction sharing feature will be implemented',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue.withOpacity(0.8),
      colorText: Colors.white,
    );
  }

  void _downloadReceipt(CurrencyTransaction transaction) {
    Get.snackbar(
      'Download',
      'Receipt download feature will be implemented',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
    );
  }
} 