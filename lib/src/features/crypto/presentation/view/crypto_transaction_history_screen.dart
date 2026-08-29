import 'package:lazervault/src/features/crypto/presentation/view/send_crypto_receipt_screen.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import '../../cubit/crypto_cubit.dart';
import '../../cubit/crypto_state.dart';
import '../../domain/entities/crypto_entity.dart' as entities;
import '../models/crypto_transaction_models.dart';
import 'crypto_receipt_screen.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
part 'crypto_transaction_history_screen_widgets.dart';


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
  final ScrollController _scrollController = ScrollController();

  bool _isExporting = false;

  final List<String> _filters = ['All', 'Buy', 'Sell', 'Swap', 'Send', 'Deposit'];

  /// Transactions loaded from the backend via CryptoCubit state
  List<CryptoTransactionHistory> get _transactions {
    final state = context.read<CryptoCubit>().state;
    if (state is CryptosLoaded) {
      return state.transactions.map((t) => CryptoTransactionHistory(
        id: t.id,
        type: _mapTransactionType(t.type),
        cryptoName: t.cryptoName,
        cryptoSymbol: t.cryptoSymbol,
        amount: t.quantity.toStringAsFixed(6),
        gbpAmount: t.totalAmount,
        status: _mapStatus(t.status),
        timestamp: t.timestamp,
        fee: t.fees,
      )).toList();
    }
    return [];
  }

  CryptoTransactionType _mapTransactionType(entities.TransactionType type) {
    switch (type) {
      case entities.TransactionType.buy:
        return CryptoTransactionType.buy;
      case entities.TransactionType.sell:
        return CryptoTransactionType.sell;
      case entities.TransactionType.swap:
        return CryptoTransactionType.swap;
      case entities.TransactionType.send:
        return CryptoTransactionType.send;
      case entities.TransactionType.deposit:
        return CryptoTransactionType.deposit;
    }
  }

  CryptoTransactionStatus _mapStatus(String status) =>
      // Shared mapper — keeps this screen's badges identical to the crypto
      // landing page's recent-transactions section.
      mapBackendCryptoTxStatus(status);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _setupAnimations();
    _scrollController.addListener(_onScroll);
    // Ensure data is loaded
    final cubit = context.read<CryptoCubit>();
    if (cubit.state is! CryptosLoaded) {
      cubit.loadCryptos();
    }
  }

  /// Load-more on scroll-to-bottom: when within 400px of the end and there's
  /// another page, ask the cubit for the next batch (it appends + dedupes).
  void _onScroll() {
    if (!mounted || !_scrollController.hasClients) return;
    final pos = _scrollController.position;
    if (pos.pixels < pos.maxScrollExtent - 400) return;
    final cubit = context.read<CryptoCubit>();
    final s = cubit.state;
    if (s is CryptosLoaded &&
        s.transactionsHasMore &&
        !s.transactionsLoadingMore) {
      cubit.loadMoreTransactions();
    }
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
    _scrollController.dispose();
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
          case 'Send':
            return transaction.type == CryptoTransactionType.send;
          case 'Deposit':
            return transaction.type == CryptoTransactionType.deposit;
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
      backgroundColor: const Color(0xFF0A0A0A),
      body: BlocBuilder<CryptoCubit, CryptoState>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF1F1F1F),
                  const Color(0xFF0A0A0A),
                  const Color(0xFF0A0A0A),
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
                    child: state is CryptoLoading
                      ? const Center(child: LazerVaultLoader.small())
                      : FadeTransition(
                          opacity: _fadeAnimation,
                          child: _buildTransactionList(),
                        ),
                  ),
                ],
              ),
            ),
          );
        },
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
              color: const Color(0xFF1F1F1F),
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
          GestureDetector(
            onTap: _isExporting ? null : _downloadStatement,
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: _isExporting
                  ? SizedBox(
                      width: 20.sp,
                      height: 20.sp,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Icon(
                      Icons.file_download,
                      color: Colors.white,
                      size: 20.sp,
                    ),
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
              fillColor: const Color(0xFF1F1F1F),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            ),
          ),
          SizedBox(height: 16.h),
          // Filter tabs — horizontally scrollable so all six (incl. Send,
          // Deposit) fit comfortably without truncating on narrow screens.
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _filters.map((filter) {
                final isSelected = _selectedFilter == filter;
                return GestureDetector(
                  onTap: () => setState(() => _selectedFilter = filter),
                  child: Container(
                    margin: EdgeInsets.only(right: 8.w),
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color.fromARGB(255, 78, 3, 208) : const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      filter,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
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
        color: const Color(0xFF1F1F1F),
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
          _buildStatItem('Total Value', '${CurrencySymbols.currentSymbol}${totalValue.toStringAsFixed(2)}'),
          _buildStatItem('Total Fees', '${CurrencySymbols.currentSymbol}${totalFees.toStringAsFixed(2)}'),
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
    return RefreshIndicator(
      color: const Color.fromARGB(255, 78, 3, 208),
      backgroundColor: const Color(0xFF1F1F1F),
      onRefresh: () => context.read<CryptoCubit>().refreshTransactions(),
      child: filteredTxns.isEmpty
          // Keep a scrollable so pull-to-refresh works even with no rows.
          ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [SizedBox(height: 120.h), _buildEmptyState()],
            )
          : Builder(builder: (context) {
              final s = context.read<CryptoCubit>().state;
              // Only show the load-more footer when the user isn't filtering
              // client-side (a filter can hide a whole fetched page, so paging
              // by the raw list is what makes sense there).
              final noFilter = _selectedFilter == 'All' && _searchQuery.isEmpty;
              final loadingMore =
                  s is CryptosLoaded && s.transactionsLoadingMore;
              final hasMore = s is CryptosLoaded && s.transactionsHasMore;
              final showFooter = noFilter && (loadingMore || hasMore);
              return ListView.builder(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: filteredTxns.length + (showFooter ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= filteredTxns.length) {
                    // Bottom load-more indicator (or a subtle end hint).
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      child: Center(
                        child: loadingMore
                            ? SizedBox(
                                width: 22.w,
                                height: 22.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Color.fromARGB(255, 78, 3, 208),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    );
                  }
                  final transaction = filteredTxns[index];
                  return _buildTransactionCard(transaction);
                },
              );
            }),
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
        color: const Color(0xFF1F1F1F),
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
        // opaque = the WHOLE card is the hit target. A bare GestureDetector
        // only receives taps that land on painted pixels, so the padding and
        // the gaps between rows swallowed them — only text actually under the
        // finger (typically the reference line) opened the receipt.
        behavior: HitTestBehavior.opaque,
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
                              _getStatusLabel(transaction.status).toUpperCase(),
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
                      '${CurrencySymbols.currentSymbol}${transaction.gbpAmount.toStringAsFixed(2)}',
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
                      '${CurrencySymbols.currentSymbol}${transaction.fee.toStringAsFixed(2)}',
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
    // Straight to the full-page receipt (shared builder, real details) —
    // the intermediate details bottomsheet was removed by request.
    openCryptoTransactionReceipt(transaction);
  }

  Color _getTransactionTypeColor(CryptoTransactionType type) {
    switch (type) {
      case CryptoTransactionType.buy:
        return Colors.green;
      case CryptoTransactionType.sell:
        return Colors.red;
      case CryptoTransactionType.swap:
        return const Color.fromARGB(255, 78, 3, 208);
      case CryptoTransactionType.send:
        return Colors.orange;
      case CryptoTransactionType.deposit:
        return const Color(0xFF3B82F6);
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
      case CryptoTransactionType.send:
        return Icons.arrow_upward;
      case CryptoTransactionType.deposit:
        return Icons.arrow_downward;
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
      case CryptoTransactionType.send:
        return 'Send ${transaction.cryptoSymbol}';
      case CryptoTransactionType.deposit:
        return 'Deposit ${transaction.cryptoSymbol}';
    }
  }

  Color _getStatusColor(CryptoTransactionStatus status) =>
      cryptoTxStatusColor(status);

  String _getStatusLabel(CryptoTransactionStatus status) =>
      cryptoTxStatusLabel(status);

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  /// Exports the currently-filtered transaction history as a printable PDF and
  /// opens the system share/print sheet. Standard tabular statement (date,
  /// type, asset, amount, value, fee, status) — replaces the old fragile PNG
  /// screenshot which frequently failed on device.
  Future<void> _downloadStatement() async {
    final txns = _filteredTransactions;
    if (txns.isEmpty) {
      Get.snackbar('Nothing to export', 'There are no transactions to download.',
          backgroundColor: const Color(0xFF1F1F1F), colorText: Colors.white);
      return;
    }
    setState(() => _isExporting = true);
    try {
      final bytes = await _buildStatementPdf(txns);
      await Printing.sharePdf(
        bytes: bytes,
        filename:
            'Lazervault_Crypto_Statement_${DateFormat('yyyyMMdd_HHmm').format(DateTime.now())}.pdf',
      );
    } catch (_) {
      Get.snackbar('Export failed', 'Could not generate the statement. Please try again.',
          backgroundColor: const Color(0xFF1F1F1F), colorText: Colors.white);
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
  }

  Future<Uint8List> _buildStatementPdf(List<CryptoTransactionHistory> txns) async {
    final doc = pw.Document();
    final df = DateFormat('dd MMM yyyy, HH:mm');
    final now = DateTime.now();
    final fiatSym = CurrencySymbols.currentSymbol;
    final fiatCode = CurrencySymbols.currentCurrency.toUpperCase();
    final totalValue = txns.fold(0.0, (s, t) => s + t.gbpAmount);
    final totalFees = txns.fold(0.0, (s, t) => s + t.fee);
    final purple = PdfColor.fromInt(0xFF4E03D0);
    final grey = PdfColors.grey700;

    doc.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(28),
      build: (ctx) => [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              pw.Text('Lazervault',
                  style: pw.TextStyle(
                      fontSize: 22, fontWeight: pw.FontWeight.bold, color: purple)),
              pw.SizedBox(height: 2),
              pw.Text('Crypto Transaction Statement',
                  style: pw.TextStyle(fontSize: 12, color: grey)),
            ]),
            pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
              pw.Text('Generated', style: pw.TextStyle(fontSize: 9, color: grey)),
              pw.Text(df.format(now), style: const pw.TextStyle(fontSize: 10)),
            ]),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Divider(color: PdfColors.grey400),
        pw.SizedBox(height: 6),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
          pw.Text('${txns.length} transaction(s)',
              style: pw.TextStyle(fontSize: 10, color: grey)),
          pw.Text('Amounts in $fiatCode',
              style: pw.TextStyle(fontSize: 10, color: grey)),
        ]),
        pw.SizedBox(height: 12),
        pw.TableHelper.fromTextArray(
          headers: ['Date', 'Type', 'Asset', 'Amount', 'Value ($fiatSym)', 'Fee', 'Status'],
          data: txns
              .map((t) => [
                    df.format(t.timestamp),
                    _pdfLabel(t.type.name),
                    t.cryptoSymbol.toUpperCase(),
                    t.amount,
                    '$fiatSym${t.gbpAmount.toStringAsFixed(2)}',
                    t.fee > 0 ? '$fiatSym${t.fee.toStringAsFixed(2)}' : '-',
                    _pdfLabel(t.status.name),
                  ])
              .toList(),
          border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
          headerStyle: pw.TextStyle(
              fontSize: 9, fontWeight: pw.FontWeight.bold, color: PdfColors.white),
          headerDecoration: pw.BoxDecoration(color: purple),
          cellStyle: const pw.TextStyle(fontSize: 9),
          cellAlignment: pw.Alignment.centerLeft,
          cellPadding: const pw.EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          columnWidths: {
            0: const pw.FlexColumnWidth(2.4),
            1: const pw.FlexColumnWidth(1.2),
            2: const pw.FlexColumnWidth(1),
            3: const pw.FlexColumnWidth(1.6),
            4: const pw.FlexColumnWidth(1.6),
            5: const pw.FlexColumnWidth(1.2),
            6: const pw.FlexColumnWidth(1.3),
          },
        ),
        pw.SizedBox(height: 14),
        pw.Container(
          alignment: pw.Alignment.centerRight,
          child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
            pw.Text('Total value: $fiatSym${totalValue.toStringAsFixed(2)}',
                style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 2),
            pw.Text('Total fees: $fiatSym${totalFees.toStringAsFixed(2)}',
                style: pw.TextStyle(fontSize: 10, color: grey)),
          ]),
        ),
        pw.SizedBox(height: 16),
        pw.Text(
            'This statement was generated by Lazervault for your records. It is not a tax document.',
            style: pw.TextStyle(fontSize: 8, color: grey)),
      ],
      footer: (ctx) => pw.Container(
        alignment: pw.Alignment.centerRight,
        margin: const pw.EdgeInsets.only(top: 8),
        child: pw.Text('Page ${ctx.pageNumber} of ${ctx.pagesCount}',
            style: pw.TextStyle(fontSize: 8, color: grey)),
      ),
    ));
    return doc.save();
  }

  String _pdfLabel(String n) =>
      n.isEmpty ? n : n[0].toUpperCase() + n.substring(1);
} 