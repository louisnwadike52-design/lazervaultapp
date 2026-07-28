import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/generated/rmb.pb.dart';
import 'package:lazervault/src/features/rmb/data/rmb_grpc_client.dart';
import 'package:lazervault/src/features/rmb/presentation/rmb_ui.dart';

/// Paginated RMB transfer history.
class RmbHistoryScreen extends StatefulWidget {
  const RmbHistoryScreen({super.key});

  @override
  State<RmbHistoryScreen> createState() => _RmbHistoryScreenState();
}

class _RmbHistoryScreenState extends State<RmbHistoryScreen> {
  final RmbGrpcClient _client = GetIt.I<RmbGrpcClient>();
  final ScrollController _scroll = ScrollController();
  final TextEditingController _searchCtrl = TextEditingController();
  final List<Transfer> _items = [];
  int _page = 1;
  int _total = 0;
  bool _loading = false;
  bool _initial = true;

  /// Free-text search over recipient name + reference (case-insensitive).
  String _query = '';

  /// Payment-method (rail) filter; null = all rails.
  RmbRail? _railFilter;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
    _fetch();
  }

  @override
  void dispose() {
    _scroll.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  /// Transfers matching the active search + rail filter. Filtering is
  /// client-side over what's been paged in (listTransfers has no server-side
  /// search); infinite scroll keeps appending, which widens the pool.
  List<Transfer> get _visible {
    final q = _query.trim().toLowerCase();
    return _items.where((t) {
      if (_railFilter != null && t.rail != _railFilter) return false;
      if (q.isEmpty) return true;
      return t.beneficiaryName.toLowerCase().contains(q) ||
          t.reference.toLowerCase().contains(q) ||
          t.bankName.toLowerCase().contains(q) ||
          t.accountNumber.toLowerCase().contains(q) ||
          RmbUi.railLabel(t.rail).toLowerCase().contains(q);
    }).toList();
  }

  void _onScroll() {
    if (_scroll.position.pixels > _scroll.position.maxScrollExtent - 300 &&
        !_loading &&
        _items.length < _total) {
      _fetch();
    }
  }

  Future<void> _fetch() async {
    if (_loading) return;
    setState(() => _loading = true);
    try {
      final resp = await _client.listTransfers(page: _page, pageSize: 20);
      setState(() {
        _items.addAll(resp.transfers);
        _total = resp.total;
        _page += 1;
        _initial = false;
      });
    } catch (_) {
      setState(() => _initial = false);
    } finally {
      if (mounted) setState(() => _loading = false);
      // Search/filter is client-side, so a match on an as-yet-unfetched page
      // would be missed (the short filtered list never reaches the scroll
      // trigger). While a filter is active, keep paging until everything is
      // loaded so search covers the full history.
      _autoPageForFilter();
    }
  }

  bool get _filtering => _query.trim().isNotEmpty || _railFilter != null;

  void _autoPageForFilter() {
    if (_filtering && !_loading && _items.length < _total) {
      _fetch();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RmbUi.bg,
      appBar: AppBar(
        backgroundColor: RmbUi.bg,
        elevation: 0,
        title: Text('RMB history',
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.w700)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _initial
          ? const Center(child: CircularProgressIndicator(color: RmbUi.accent))
          : _items.isEmpty
              ? Center(
                  child: Text('No transfers yet',
                      style: TextStyle(
                          color: RmbUi.textSecondary, fontSize: 13.sp)),
                )
              : Column(
                  children: [
                    _searchBar(),
                    _filterChips(),
                    Expanded(child: _list()),
                  ],
                ),
    );
  }

  Widget _list() {
    final visible = _visible;
    if (visible.isEmpty) {
      // While a filter is active we may still be paging in more history — show a
      // spinner instead of a premature "no match".
      if (_filtering && (_loading || _items.length < _total)) {
        return const Center(child: CircularProgressIndicator(color: RmbUi.accent));
      }
      return Center(
        child: Text(
            _filtering ? 'No transfers match your search' : 'No transfers yet',
            style: TextStyle(color: RmbUi.textSecondary, fontSize: 13.sp)),
      );
    }
    return ListView.builder(
      controller: _scroll,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      itemCount: visible.length + (_loading ? 1 : 0),
      itemBuilder: (context, i) {
        if (i >= visible.length) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child:
                Center(child: CircularProgressIndicator(color: RmbUi.accent)),
          );
        }
        return _tile(visible[i]);
      },
    );
  }

  Widget _searchBar() => Padding(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 6.h),
        child: TextField(
          controller: _searchCtrl,
          onChanged: (v) {
            setState(() => _query = v);
            _autoPageForFilter();
          },
          style: TextStyle(color: Colors.white, fontSize: 13.sp),
          decoration: InputDecoration(
            hintText: 'Search by name, bank, account or reference',
            hintStyle:
                TextStyle(color: RmbUi.textSecondary, fontSize: 13.sp),
            prefixIcon:
                Icon(Icons.search, color: RmbUi.textSecondary, size: 18.sp),
            suffixIcon: _query.isEmpty
                ? null
                : IconButton(
                    icon: Icon(Icons.close,
                        color: RmbUi.textSecondary, size: 18.sp),
                    onPressed: () {
                      _searchCtrl.clear();
                      setState(() => _query = '');
                    },
                  ),
            filled: true,
            fillColor: RmbUi.card,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: RmbUi.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: RmbUi.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: RmbUi.accent),
            ),
          ),
        ),
      );

  Widget _filterChips() {
    const rails = [
      null,
      RmbRail.ALIPAY,
      RmbRail.WECHAT,
      RmbRail.UNIONPAY,
      RmbRail.BANK,
    ];
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
        itemCount: rails.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, i) {
          final rail = rails[i];
          final selected = _railFilter == rail;
          final label = rail == null ? 'All' : RmbUi.railLabel(rail);
          return GestureDetector(
            onTap: () {
              setState(() => _railFilter = rail);
              _autoPageForFilter();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected
                    ? RmbUi.accent.withValues(alpha: 0.18)
                    : RmbUi.card,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                    color: selected ? RmbUi.accent : RmbUi.border),
              ),
              child: Text(label,
                  style: TextStyle(
                      color: selected ? RmbUi.accent : RmbUi.textSecondary,
                      fontSize: 12.sp,
                      fontWeight:
                          selected ? FontWeight.w600 : FontWeight.w500)),
            ),
          );
        },
      ),
    );
  }

  Widget _tile(Transfer t) => GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.rmbReceipt,
            arguments: {'transferId': t.id, 'fromHistory': true}),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: RmbUi.card,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: RmbUi.border),
          ),
          child: Row(
            children: [
              Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                  color: RmbUi.railColor(t.rail).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: RmbUi.railGlyph(t.rail, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        RmbUi.recipientName(
                          surname: t.receiverLastName,
                          given: t.receiverFirstName,
                          fallback: t.beneficiaryName,
                        ).isEmpty
                            ? 'RMB payout'
                            : RmbUi.recipientName(
                                surname: t.receiverLastName,
                                given: t.receiverFirstName,
                                fallback: t.beneficiaryName,
                              ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600)),
                    SizedBox(height: 3.h),
                    Text('${RmbUi.railLabel(t.rail)} · ${_date(t)}',
                        style: TextStyle(
                            color: RmbUi.textSecondary, fontSize: 11.sp)),
                  ],
                ),
              ),
              Text(RmbUi.cny(t.destAmountMinor.toInt()),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      );

  String _date(Transfer t) {
    if (!t.hasCreatedAt()) return '';
    return DateFormat('MMM d, HH:mm')
        .format(t.createdAt.toDateTime().toLocal());
  }
}
