import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/widgets/infinite_scroll_mixin.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import '../../data/services/sales_service.dart';
import '../../domain/entities/sale_entity.dart';
part 'sales_list_screen_widgets.dart';


/// Sell landing page — lists all recorded sales with a revenue/receivables
/// summary and a FAB to record a new sale. Themed to match the invoice/business
/// dark theme. A PAID sale is realised revenue; an UNPAID sale is a receivable.
class SalesListScreen extends StatefulWidget {
  const SalesListScreen({super.key});

  @override
  State<SalesListScreen> createState() => _SalesListScreenState();
}

class _SalesListScreenState extends State<SalesListScreen>
    with InfiniteScrollMixin<SalesListScreen> {
  static const _bg = InvoiceThemeColors.primaryBackground;
  static const _card = InvoiceThemeColors.secondaryBackground;
  static const _border = InvoiceThemeColors.borderColor;
  static const _accent = InvoiceThemeColors.primaryPurple;
  static const _accentText = InvoiceThemeColors.primaryPurpleLight;
  static const _muted = Color(0xFF9CA3AF);
  static const _green = InvoiceThemeColors.successGreen;
  static const _amber = Color(0xFFFB923C);

  static const int _limit = 20;

  List<SaleEntity> _sales = const [];
  bool _loading = true;
  String? _error;
  // Backend-computed all-time totals (null until the summary call returns).
  SalesSummary? _summaryTotals;

  @override
  void initState() {
    super.initState();
    attachInfiniteScroll();
    _loadFirst();
  }

  @override
  void dispose() {
    detachInfiniteScroll();
    super.dispose();
  }

  Future<void> _loadFirst() async {
    resetPagination();
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final svc = SalesService(endpoints: endpointRegistry);
      // Fetch the page and the backend all-time totals together. The summary is
      // best-effort — a failure there must not blank the list.
      final results = await Future.wait([
        svc.listSales(page: 1, limit: _limit),
        svc.getSummary().catchError((_) => _summaryTotals ?? const SalesSummary(
              revenue: 0, receivables: 0, count: 0, currency: 'NGN')),
      ]);
      if (!mounted) return;
      final sales = results[0] as List<SaleEntity>;
      final summary = results[1] as SalesSummary;
      setState(() {
        _sales = sales;
        _summaryTotals = summary;
        _loading = false;
        // listSales returns a plain list (no page metadata) — a full page
        // means another page probably exists.
        hasMore = sales.length >= _limit;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Future<void> onLoadMore() => runLoadMore(() async {
        final more = await SalesService(endpoints: endpointRegistry)
            .listSales(page: page + 1, limit: _limit);
        if (!mounted) return;
        setState(() {
          _sales = [..._sales, ...more];
          page += 1;
          hasMore = more.length >= _limit;
        });
      });

  Future<void> _openRecord() async {
    final result = await Get.toNamed(AppRoutes.recordSale);
    if (result == true) _loadFirst();
  }

  // Prefer the backend all-time aggregate; fall back to a page-fold only until
  // the summary call returns (otherwise totals understate past one page).
  int get _revenue =>
      _summaryTotals?.revenue ??
      _sales.where((s) => s.status == 'PAID').fold(0, (a, s) => a + s.amount);
  int get _receivables =>
      _summaryTotals?.receivables ??
      _sales.where((s) => s.status != 'PAID').fold(0, (a, s) => a + s.amount);

  String _money(int kobo) => '₦${(kobo / 100).toStringAsFixed(2)}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Sales',
            style: GoogleFonts.inter(
                color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700)),
        actions: [
          // Sales voice + chat, pinned to the business agent
          // (DIRECT_ROUTES['sales'] → chat-business-service) so the assistant
          // answers revenue/receivables questions with sales tools.
          ServiceVoiceButton(
            serviceName: 'sales',
            iconColor: _accent,
            backgroundColor: _accent,
          ),
          SizedBox(width: 4.w),
          MicroserviceChatIcon(
            serviceName: 'Sales',
            sourceContext: 'sales',
            icon: Icons.chat_bubble_outline,
            iconColor: _accent,
          ),
          SizedBox(width: 8.w),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openRecord,
        backgroundColor: _accent,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text('Record sale',
            style: GoogleFonts.inter(
                color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: _loading
            ? const Center(child: LazerVaultLoader.small())
            : _error != null
                ? _buildError()
                : RefreshIndicator(
                    onRefresh: _loadFirst,
                    color: _accentText,
                    backgroundColor: _card,
                    child: ListView(
                      controller: scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 96.h),
                      children: [
                        _summary(),
                        SizedBox(height: 20.h),
                        if (_sales.isEmpty)
                          _empty()
                        else ...[
                          Text('Recent sales',
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(height: 12.h),
                          ..._sales.map(_saleCard),
                          if (isLoadingMore)
                            Padding(
                              padding: EdgeInsets.all(16.w),
                              child: const Center(
                                  child: LazerVaultLoader.small()),
                            ),
                        ],
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget _summary() {
    return Row(
      children: [
        Expanded(child: _statCard('Revenue', _revenue, _green, Icons.trending_up_rounded)),
        SizedBox(width: 12.w),
        Expanded(child: _statCard('Receivables', _receivables, _amber, Icons.schedule_rounded)),
      ],
    );
  }

  Widget _statCard(String label, int kobo, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 15.sp),
              SizedBox(width: 6.w),
              Text(label,
                  style: GoogleFonts.inter(color: _muted, fontSize: 12.sp)),
            ],
          ),
          SizedBox(height: 8.h),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(_money(kobo),
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Widget _saleCard(SaleEntity s) {
    final paid = s.status == 'PAID';
    final title = s.itemName.isNotEmpty
        ? s.itemName
        : (s.description.isNotEmpty ? s.description : 'Sale');
    final who = s.customerName.isNotEmpty ? s.customerName : 'Walk-in';
    final date = _fmtDate(s.createdAt);
    final qty = s.quantity > 1 ? '${s.quantity} × · ' : '';
    return GestureDetector(
      onTap: () => _openDetail(s),
      behavior: HitTestBehavior.opaque,
      child: Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: _accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.point_of_sale_rounded, color: _accentText, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 3.h),
                Text('$who · $qty$date',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(color: _muted, fontSize: 11.5.sp)),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(_money(s.amount),
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700)),
              SizedBox(height: 5.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: (paid ? _green : _amber).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(paid ? 'Paid' : 'Receivable',
                    style: GoogleFonts.inter(
                        color: paid ? _green : _amber,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }

  Future<void> _openDetail(SaleEntity s) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _SaleDetailSheet(sale: s),
    );
  }

  String _fmtDate(String iso) {
    final d = DateTime.tryParse(iso);
    if (d == null) return '';
    return DateFormat('d MMM').format(d.toLocal());
  }

  Widget _empty() {
    return Padding(
      padding: EdgeInsets.only(top: 60.h),
      child: Column(
        children: [
          Icon(Icons.point_of_sale_outlined, size: 48.sp, color: _border),
          SizedBox(height: 16.h),
          Text('No sales yet',
              style: GoogleFonts.inter(
                  color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w600)),
          SizedBox(height: 6.h),
          Text('Tap “Record sale” to log your first one.',
              style: GoogleFonts.inter(color: _muted, fontSize: 12.5.sp)),
        ],
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded, size: 44.sp, color: const Color(0xFFEF4444)),
            SizedBox(height: 14.h),
            Text(_error ?? 'Could not load sales',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(color: _muted, fontSize: 13.sp)),
            SizedBox(height: 18.h),
            ElevatedButton(
              onPressed: _loadFirst,
              style: ElevatedButton.styleFrom(
                backgroundColor: _accent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
              child: Text('Retry',
                  style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
