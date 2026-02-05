import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'crypto_confirmation_screen.dart';
import 'crypto_receipt_screen.dart';

class CryptoTransactionHistoryScreen extends StatefulWidget {
  const CryptoTransactionHistoryScreen({super.key});

  @override
  State<CryptoTransactionHistoryScreen> createState() => _CryptoTransactionHistoryScreenState();
}

class _CryptoTransactionHistoryScreenState extends State<CryptoTransactionHistoryScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  String _selectedFilter = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  
  final List<String> _filters = ['All', 'Buy', 'Sell', 'Swap'];
  
  // Mock transaction data
  final List<CryptoTransactionHistory> _transactions = [
    CryptoTransactionHistory(
      id: 'TXN001',
      type: CryptoTransactionType.buy,
      cryptoName: 'Bitcoin',
      cryptoSymbol: 'BTC',
      amount: '0.005432',
      gbpAmount: 350.00,
      status: CryptoTransactionStatus.completed,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      fee: 5.25,
    ),
    CryptoTransactionHistory(
      id: 'TXN002',
      type: CryptoTransactionType.sell,
      cryptoName: 'Ethereum',
      cryptoSymbol: 'ETH',
      amount: '0.2145',
      gbpAmount: 331.25,
      status: CryptoTransactionStatus.completed,
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      fee: 4.97,
    ),
    CryptoTransactionHistory(
      id: 'TXN003',
      type: CryptoTransactionType.swap,
      cryptoName: 'Solana',
      cryptoSymbol: 'SOL',
      amount: '2.5',
      gbpAmount: 392.50,
      status: CryptoTransactionStatus.pending,
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      fee: 3.92,
      fromCrypto: 'ETH',
      toCrypto: 'SOL',
    ),
    CryptoTransactionHistory(
      id: 'TXN004',
      type: CryptoTransactionType.buy,
      cryptoName: 'Cardano',
      cryptoSymbol: 'ADA',
      amount: '1250.0',
      gbpAmount: 1112.50,
      status: CryptoTransactionStatus.completed,
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
      fee: 16.69,
    ),
    CryptoTransactionHistory(
      id: 'TXN005',
      type: CryptoTransactionType.sell,
      cryptoName: 'Bitcoin',
      cryptoSymbol: 'BTC',
      amount: '0.001',
      gbpAmount: 64.50,
      status: CryptoTransactionStatus.failed,
      timestamp: DateTime.now().subtract(const Duration(days: 5)),
      fee: 0.97,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<CryptoTransactionHistory> get _filteredTransactions {
    var filtered = _transactions;
    
    // Filter by type
    if (_selectedFilter != 'All') {
      filtered = filtered.where((transaction) {
        switch (_selectedFilter) {
          case 'Buy':
            return transaction.type == CryptoTransactionType.buy;
          case 'Sell':
            return transaction.type == CryptoTransactionType.sell;
          case 'Swap':
            return transaction.type == CryptoTransactionType.swap;
          default:
            return true;
        }
      }).toList();
    }
    
    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((transaction) {
        return transaction.cryptoName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
               transaction.cryptoSymbol.toLowerCase().contains(_searchQuery.toLowerCase()) ||
               transaction.id.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E27),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0A0E27),
              const Color(0xFF0F0F23),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildSearchAndFilter(),
              _buildSummaryStats(),
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildTransactionList(),
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
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2746),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: GestureDetector(
              onTap: () => Get.back(),
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
              'Transaction History',
              style: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2746),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.file_download,
              color: Colors.white,
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        children: [
          // Search bar
          TextField(
            controller: _searchController,
            onChanged: (value) => setState(() => _searchQuery = value),
            style: GoogleFonts.inter(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search transactions...',
              hintStyle: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 14.sp,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white.withValues(alpha: 0.5),
                size: 20.sp,
              ),
              filled: true,
              fillColor: const Color(0xFF1E2746),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            ),
          ),
          SizedBox(height: 16.h),
          // Filter tabs
          Row(
            children: _filters.map((filter) {
              final isSelected = _selectedFilter == filter;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedFilter = filter),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF6C5CE7) : const Color(0xFF1E2746),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Text(
                        filter,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryStats() {
    final filteredTxns = _filteredTransactions;
    final totalValue = filteredTxns.fold(0.0, (sum, txn) => sum + txn.gbpAmount);
    final totalFees = filteredTxns.fold(0.0, (sum, txn) => sum + txn.fee);
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Transactions', '${filteredTxns.length}'),
          _buildStatItem('Total Value', '£${totalValue.toStringAsFixed(2)}'),
          _buildStatItem('Total Fees', '£${totalFees.toStringAsFixed(2)}'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionList() {
    final filteredTxns = _filteredTransactions;
    
    if (filteredTxns.isEmpty) {
      return _buildEmptyState();
    }
    
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: filteredTxns.length,
      itemBuilder: (context, index) {
        final transaction = filteredTxns[index];
        return _buildTransactionCard(transaction);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long,
            size: 64.sp,
            color: Colors.white.withValues(alpha: 0.3),
          ),
          SizedBox(height: 16.h),
          Text(
            'No transactions found',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Try adjusting your search or filter criteria',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(CryptoTransactionHistory transaction) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: GestureDetector(
        onTap: () => _showTransactionDetails(transaction),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: _getTransactionTypeColor(transaction.type).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    _getTransactionTypeIcon(transaction.type),
                    color: _getTransactionTypeColor(transaction.type),
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _getTransactionTitle(transaction),
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: _getStatusColor(transaction.status).withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              transaction.status.name.toUpperCase(),
                              style: GoogleFonts.inter(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor(transaction.status),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        _formatDateTime(transaction.timestamp),
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Amount',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                    Text(
                      '${transaction.amount} ${transaction.cryptoSymbol}',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Value',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                    Text(
                      '£${transaction.gbpAmount.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Fee',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                    Text(
                      '£${transaction.fee.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ID: ${transaction.id}',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white.withValues(alpha: 0.5),
                  size: 16.sp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showTransactionDetails(CryptoTransactionHistory transaction) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.85,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A3E),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.w),
                child: _buildTransactionDetailsContent(transaction),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildTransactionDetailsContent(CryptoTransactionHistory transaction) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transaction Details',
              style: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () => Get.back(),
              child: Icon(Icons.close, color: Colors.white, size: 24.sp),
            ),
          ],
        ),
        SizedBox(height: 24.h),
        _buildDetailSection('Basic Information', [
          _buildDetailRow('Transaction ID', transaction.id),
          _buildDetailRow('Type', _getTransactionTitle(transaction)),
          _buildDetailRow('Status', transaction.status.name.toUpperCase()),
          _buildDetailRow('Date & Time', _formatDateTime(transaction.timestamp)),
        ]),
        SizedBox(height: 24.h),
        _buildDetailSection('Transaction Details', [
          _buildDetailRow('Cryptocurrency', transaction.cryptoName),
          _buildDetailRow('Amount', '${transaction.amount} ${transaction.cryptoSymbol}'),
          _buildDetailRow('GBP Value', '£${transaction.gbpAmount.toStringAsFixed(2)}'),
          _buildDetailRow('Fee', '£${transaction.fee.toStringAsFixed(2)}'),
          if (transaction.type == CryptoTransactionType.swap) ...[
            _buildDetailRow('From', transaction.fromCrypto ?? 'Unknown'),
            _buildDetailRow('To', transaction.toCrypto ?? 'Unknown'),
          ],
        ]),
        SizedBox(height: 24.h),
        _buildDetailSection('Security & Compliance', [
          _buildDetailRow('Blockchain Network', _getBlockchainNetwork(transaction.cryptoSymbol)),
          _buildDetailRow('Encryption', '256-bit SSL'),
          _buildDetailRow('Regulation', 'FCA Authorized'),
          _buildDetailRow('Storage', 'Cold Storage Wallet'),
        ]),
        SizedBox(height: 32.h),
        if (transaction.status == CryptoTransactionStatus.completed)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _viewReceipt(transaction),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C5CE7),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'View Receipt',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _viewReceipt(CryptoTransactionHistory transaction) {
    Get.back(); // Close bottom sheet
    
    // Create transaction details
    final transactionDetails = CryptoTransactionDetails(
      type: transaction.type,
      cryptoName: transaction.cryptoName,
      cryptoSymbol: transaction.cryptoSymbol,
      cryptoAmount: transaction.amount,
      pricePerUnit: transaction.gbpAmount / double.parse(transaction.amount),
      gbpAmount: transaction.gbpAmount,
      networkFee: transaction.fee * 0.3,
      tradingFee: transaction.fee * 0.7,
      totalAmount: transaction.gbpAmount + transaction.fee,
      paymentMethod: 'Card',
      fromCrypto: transaction.fromCrypto,
      toCrypto: transaction.toCrypto,
    );
    
    // Create receipt
    final receipt = CryptoTransactionReceipt(
      transactionId: transaction.id,
      transactionDetails: transactionDetails,
      timestamp: transaction.timestamp,
      status: transaction.status,
    );
    
    Get.to(() => CryptoReceiptScreen(receipt: receipt));
  }

  Color _getTransactionTypeColor(CryptoTransactionType type) {
    switch (type) {
      case CryptoTransactionType.buy:
        return Colors.green;
      case CryptoTransactionType.sell:
        return Colors.red;
      case CryptoTransactionType.swap:
        return const Color(0xFF6C5CE7);
    }
  }

  IconData _getTransactionTypeIcon(CryptoTransactionType type) {
    switch (type) {
      case CryptoTransactionType.buy:
        return Icons.add_circle_outline;
      case CryptoTransactionType.sell:
        return Icons.remove_circle_outline;
      case CryptoTransactionType.swap:
        return Icons.swap_horiz;
    }
  }

  String _getTransactionTitle(CryptoTransactionHistory transaction) {
    switch (transaction.type) {
      case CryptoTransactionType.buy:
        return 'Buy ${transaction.cryptoSymbol}';
      case CryptoTransactionType.sell:
        return 'Sell ${transaction.cryptoSymbol}';
      case CryptoTransactionType.swap:
        return 'Swap ${transaction.fromCrypto} → ${transaction.toCrypto}';
    }
  }

  Color _getStatusColor(CryptoTransactionStatus status) {
    switch (status) {
      case CryptoTransactionStatus.completed:
        return Colors.green;
      case CryptoTransactionStatus.pending:
        return Colors.orange;
      case CryptoTransactionStatus.failed:
        return Colors.red;
    }
  }

  String _getBlockchainNetwork(String symbol) {
    switch (symbol.toUpperCase()) {
      case 'BTC':
        return 'Bitcoin Network';
      case 'ETH':
        return 'Ethereum Network';
      case 'BNB':
        return 'Binance Smart Chain';
      case 'SOL':
        return 'Solana Network';
      default:
        return 'Ethereum Network (ERC-20)';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

// Transaction history model
class CryptoTransactionHistory {
  final String id;
  final CryptoTransactionType type;
  final String cryptoName;
  final String cryptoSymbol;
  final String amount;
  final double gbpAmount;
  final CryptoTransactionStatus status;
  final DateTime timestamp;
  final double fee;
  final String? fromCrypto;
  final String? toCrypto;

  const CryptoTransactionHistory({
    required this.id,
    required this.type,
    required this.cryptoName,
    required this.cryptoSymbol,
    required this.amount,
    required this.gbpAmount,
    required this.status,
    required this.timestamp,
    required this.fee,
    this.fromCrypto,
    this.toCrypto,
  });
} 