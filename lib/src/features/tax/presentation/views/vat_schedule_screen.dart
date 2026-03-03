import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/tax_cubit.dart';
import '../cubit/tax_state.dart';

class VATScheduleScreen extends StatefulWidget {
  const VATScheduleScreen({super.key});

  @override
  State<VATScheduleScreen> createState() => _VATScheduleScreenState();
}

class _VATScheduleScreenState extends State<VATScheduleScreen> {
  final _periodController = TextEditingController();
  late String _currentPeriod;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _currentPeriod =
        '${now.year}-${now.month.toString().padLeft(2, '0')}';
    _periodController.text = _currentPeriod;
    _loadSchedule();
  }

  @override
  void dispose() {
    _periodController.dispose();
    super.dispose();
  }

  void _loadSchedule() {
    context.read<TaxCubit>().getVATSchedule(_currentPeriod);
  }

  void _onPeriodChanged(String value) {
    final trimmed = value.trim();
    // Validate format: YYYY-MM
    if (RegExp(r'^\d{4}-\d{2}$').hasMatch(trimmed)) {
      final month = int.tryParse(trimmed.substring(5));
      if (month != null && month >= 1 && month <= 12) {
        setState(() => _currentPeriod = trimmed);
        _loadSchedule();
      }
    }
  }

  String _formatAmount(dynamic amount) {
    final value = (amount is int) ? amount.toDouble() : (amount as double);
    return '\u20A6${value.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'VAT Schedule',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildPeriodSelector(),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Period Selector
  // ---------------------------------------------------------------------------

  Widget _buildPeriodSelector() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: TextField(
        controller: _periodController,
        onSubmitted: _onPeriodChanged,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
        decoration: InputDecoration(
          labelText: 'Period',
          labelStyle: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
          ),
          hintText: 'e.g. 2026-02',
          hintStyle: GoogleFonts.inter(
            color: const Color(0xFF6B7280),
            fontSize: 15.sp,
          ),
          prefixIcon: Icon(
            Icons.calendar_month_outlined,
            color: const Color(0xFF9CA3AF),
            size: 20.sp,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.search,
              color: const Color(0xFF3B82F6),
              size: 20.sp,
            ),
            onPressed: () => _onPeriodChanged(_periodController.text),
          ),
          filled: true,
          fillColor: const Color(0xFF1F1F1F),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Body
  // ---------------------------------------------------------------------------

  Widget _buildBody() {
    return BlocConsumer<TaxCubit, TaxState>(
      listener: (context, state) {
        if (state is TaxError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: GoogleFonts.inter(color: Colors.white),
              ),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is TaxLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF3B82F6),
            ),
          );
        }

        if (state is VATScheduleLoaded) {
          return _buildContent(state.data);
        }

        // Initial or error state
        return _buildEmptyState();
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Content
  // ---------------------------------------------------------------------------

  Widget _buildContent(Map<String, dynamic> data) {
    final totalOutputVat = (data['totalOutputVat'] ?? 0.0) as double;
    final totalInputVat = (data['totalInputVat'] ?? 0.0) as double;
    final netVatPayable = (data['netVatPayable'] ?? 0.0) as double;
    final entries = (data['entries'] as List<dynamic>?) ?? [];

    if (entries.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async => _loadSchedule(),
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          SizedBox(height: 8.h),
          _buildSummaryCards(totalOutputVat, totalInputVat, netVatPayable),
          SizedBox(height: 24.h),
          _buildSectionHeader('VAT Entries'),
          SizedBox(height: 12.h),
          ...entries.map((entry) => _buildEntryCard(entry as Map<String, dynamic>)),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Summary Cards
  // ---------------------------------------------------------------------------

  Widget _buildSummaryCards(
    double totalOutputVat,
    double totalInputVat,
    double netVatPayable,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildSummaryCard(
                label: 'Output VAT',
                amount: totalOutputVat,
                color: const Color(0xFF3B82F6),
                icon: Icons.arrow_upward,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildSummaryCard(
                label: 'Input VAT',
                amount: totalInputVat,
                color: const Color(0xFF10B981),
                icon: Icons.arrow_downward,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        _buildNetPayableCard(netVatPayable),
      ],
    );
  }

  Widget _buildSummaryCard({
    required String label,
    required double amount,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, color: color, size: 18.sp),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            _formatAmount(amount),
            style: GoogleFonts.inter(
              color: color,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNetPayableCard(double netVatPayable) {
    final isPayable = netVatPayable > 0;
    final displayColor =
        isPayable ? const Color(0xFFEF4444) : const Color(0xFF10B981);
    final label = isPayable ? 'Net VAT Payable' : 'Net VAT Refundable';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: displayColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: displayColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  isPayable ? Icons.payment : Icons.account_balance_wallet,
                  color: displayColor,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                label,
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Text(
            _formatAmount(netVatPayable.abs()),
            style: GoogleFonts.inter(
              color: displayColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Entries List
  // ---------------------------------------------------------------------------

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildEntryCard(Map<String, dynamic> entry) {
    final direction = (entry['direction'] ?? 'OUTPUT') as String;
    final isOutput = direction.toUpperCase() == 'OUTPUT';
    final directionColor =
        isOutput ? const Color(0xFF3B82F6) : const Color(0xFF10B981);
    final description = (entry['description'] ?? '') as String;
    final baseAmount = (entry['baseAmount'] ?? 0.0) as double;
    final vatAmount = (entry['vatAmount'] ?? 0.0) as double;
    final invoiceRef = (entry['invoiceReference'] ?? '') as String;
    final date = (entry['date'] ?? '') as String;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: direction badge + date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: directionColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  direction.toUpperCase(),
                  style: GoogleFonts.inter(
                    color: directionColor,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (date.isNotEmpty)
                Text(
                  date,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                  ),
                ),
            ],
          ),
          SizedBox(height: 10.h),

          // Description
          Text(
            description,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10.h),

          // Divider
          Container(
            height: 1,
            color: const Color(0xFF2D2D2D),
          ),
          SizedBox(height: 10.h),

          // Amount details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Base Amount',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 11.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    _formatAmount(baseAmount),
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'VAT (7.5%)',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 11.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    _formatAmount(vatAmount),
                    style: GoogleFonts.inter(
                      color: directionColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              if (invoiceRef.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Invoice',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 11.sp,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      invoiceRef,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Empty State
  // ---------------------------------------------------------------------------

  Widget _buildEmptyState() {
    return RefreshIndicator(
      onRefresh: () async => _loadSchedule(),
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 120.h),
          Icon(
            Icons.receipt_long_outlined,
            color: const Color(0xFF2D2D2D),
            size: 64.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'No VAT entries for this period',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Record a VAT transaction to get started',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
