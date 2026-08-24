part of 'auto_orders_screen.dart';

/// Auto Orders — price-triggered buy/sell. Distinct from the (passive) price
/// alerts and the favorites watchlist: an auto-order actually executes a trade
/// when the target price is hit. A BUY reserves the fiat up front.
class AutoOrdersScreen extends StatefulWidget {
  const AutoOrdersScreen({super.key});
  @override
  State<AutoOrdersScreen> createState() => _AutoOrdersScreenState();
}

class _AutoOrdersScreenState extends State<AutoOrdersScreen> {
  final CryptoGrpcClient _client = serviceLocator<CryptoGrpcClient>();
  List<AutoOrder> _active = [], _past = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final res = await _client.listAutoOrders();
      final all = res.orders.toList();
      setState(() {
        _active = all.where((o) => o.status == 'active' || o.status == 'triggered' || o.status == 'executing').toList();
        _past = all.where((o) => o.status == 'completed' || o.status == 'failed' || o.status == 'cancelled' || o.status == 'expired').toList();
        _loading = false;
      });
    } catch (_) {
      setState(() {
        _error = 'Failed to load auto orders';
        _loading = false;
      });
    }
  }

  Future<void> _cancel(String id) async {
    try {
      await _client.cancelAutoOrder(id);
      await _load();
      Get.snackbar('Cancelled', 'Auto order cancelled and any reserved funds released',
          backgroundColor: _card, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      // The swipe already dismissed the tile optimistically — reload so it
      // reappears (the hold is still live) and say WHY the cancel failed.
      await _load();
      Get.snackbar('Error', 'Could not cancel auto order: ${friendlyError(e)}',
          backgroundColor: _red.withValues(alpha: 0.9), colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
    }
  }

  void _showCreate() => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => _CreateSheet(client: _client, onCreated: _load),
      );

  @override
  Widget build(BuildContext context) {
    final empty = !_loading && _active.isEmpty && _past.isEmpty;
    return Scaffold(
      backgroundColor: _bg,
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreate,
        backgroundColor: _accent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
          child: Column(children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Row(children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(color: _card, borderRadius: BorderRadius.circular(12.r)),
                child: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
              ),
            ),
            SizedBox(width: 16.w),
            Text('Auto Orders', style: _inter(20, w: FontWeight.bold)),
          ]),
        ),
        Expanded(
            child: RefreshIndicator(
          color: _accent,
          backgroundColor: _card,
          onRefresh: _load,
          child: _loading ? _shimmer() : _error != null ? _errView() : empty ? _emptyView() : _list(),
        )),
      ])),
    );
  }

  Widget _shimmer() => Shimmer.fromColors(
        baseColor: _card,
        highlightColor: _divider,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          itemCount: 5,
          itemBuilder: (_, __) => Container(
            height: 76.h,
            margin: EdgeInsets.only(bottom: 12.h),
            decoration: BoxDecoration(color: _card, borderRadius: BorderRadius.circular(14.r)),
          ),
        ),
      );

  Widget _errView() => ListView(children: [
        SizedBox(height: 120.h),
        Center(
            child: Column(children: [
          Icon(Icons.error_outline, color: _red, size: 48.sp),
          SizedBox(height: 16.h),
          Text(_error!, style: _inter(16, c: _sub)),
          SizedBox(height: 16.h),
          TextButton(onPressed: _load, child: Text('Retry', style: _inter(14, c: _accent))),
        ])),
      ]);

  Widget _emptyView() => ListView(children: [
        SizedBox(height: 100.h),
        Center(
            child: Column(children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(color: _accent.withValues(alpha: 0.15), shape: BoxShape.circle),
            child: Icon(Icons.bolt, color: _accent, size: 40.sp),
          ),
          SizedBox(height: 24.h),
          Text('Set your first auto order', style: _inter(20, w: FontWeight.w600)),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Text(
                'Buy automatically when the price hits your target. Funds are reserved up front. Tap + to create one.',
                textAlign: TextAlign.center,
                style: _inter(14, c: _sub)),
          ),
        ])),
      ]);

  Widget _sectionLabel(String title, int count) => Row(children: [
        Text(title, style: _inter(14, w: FontWeight.w600, c: _sub)),
        SizedBox(width: 6.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          decoration: BoxDecoration(color: _divider, borderRadius: BorderRadius.circular(10.r)),
          child: Text('$count', style: _inter(12, w: FontWeight.w500, c: _sub)),
        ),
      ]);

  Widget _list() => ListView(padding: EdgeInsets.symmetric(horizontal: 20.w), children: [
        if (_active.isNotEmpty) ...[
          _sectionLabel('Active', _active.length),
          SizedBox(height: 8.h),
          ..._active.map((o) => _Tile(order: o, onCancel: () => _cancel(o.id))),
        ],
        if (_past.isNotEmpty) ...[
          SizedBox(height: 20.h),
          _sectionLabel('History', _past.length),
          SizedBox(height: 8.h),
          ..._past.map((o) => _Tile(order: o, past: true)),
        ],
        SizedBox(height: 80.h),
      ]);
}

class _Tile extends StatelessWidget {
  final AutoOrder order;
  final bool past;
  final VoidCallback? onCancel;
  const _Tile({required this.order, this.past = false, this.onCancel});

  Color get _statusColor {
    switch (order.status) {
      case 'active':
        return _green;
      case 'triggered':
      case 'executing':
        return _orange;
      case 'completed':
        return _green;
      case 'failed':
        return _red;
      default:
        return _sub;
    }
  }

  @override
  Widget build(BuildContext context) {
    final above = order.triggerDirection.toLowerCase() == 'above';
    final isBuy = order.side.toLowerCase() == 'buy';
    final sym = CurrencySymbols.getSymbol(order.fiatCurrency);

    final tile = Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: _divider),
      ),
      child: Column(children: [
        Row(children: [
          Container(
            width: 40.w,
            height: 40.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: (isBuy ? _green : _red).withValues(alpha: 0.15), shape: BoxShape.circle),
            child: Text(
              order.cryptoSymbol.toUpperCase().substring(0, order.cryptoSymbol.length > 2 ? 2 : order.cryptoSymbol.length),
              style: _inter(13, w: FontWeight.w700, c: isBuy ? _green : _red),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text('${isBuy ? 'Buy' : 'Sell'} ${order.cryptoSymbol.toUpperCase()}', style: _inter(15, w: FontWeight.w600)),
              SizedBox(width: 6.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                decoration: BoxDecoration(color: _statusColor.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6.r)),
                child: Text(order.status.toUpperCase(), style: _inter(9, w: FontWeight.w700, c: _statusColor)),
              ),
            ]),
            SizedBox(height: 2.h),
            Text('$sym${(order.amountMinor.toInt() / 100).toStringAsFixed(2)}', style: _inter(12, c: _sub)),
          ])),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text('$sym${_fmtPrice(order.targetPrice)}', style: _inter(15, w: FontWeight.w600)),
            SizedBox(height: 2.h),
            Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(above ? Icons.arrow_upward : Icons.arrow_downward, color: above ? _green : _red, size: 14.sp),
              SizedBox(width: 2.w),
              Text(above ? 'Above' : 'Below', style: _inter(12, w: FontWeight.w500, c: above ? _green : _red)),
            ]),
          ]),
        ]),
        if (order.lastError.isNotEmpty) ...[
          SizedBox(height: 8.h),
          Align(alignment: Alignment.centerLeft, child: Text(order.lastError, style: _inter(11, c: _red))),
        ],
      ]),
    );

    if (past || onCancel == null) return Opacity(opacity: past ? 0.6 : 1.0, child: tile);

    return Dismissible(
      key: Key(order.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
                backgroundColor: _card,
                title: Text('Cancel Auto Order', style: _inter(16, w: FontWeight.w600)),
                content: Text('Cancel this order? Any reserved funds are released.', style: _inter(14, c: _sub)),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text('Keep', style: _inter(14, c: _sub))),
                  TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text('Cancel order', style: _inter(14, c: _red))),
                ],
              )),
      onDismissed: (_) => onCancel!(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(color: _red.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(14.r)),
        child: Icon(Icons.delete_outline, color: _red, size: 24.sp),
      ),
      child: tile,
    );
  }
}

// --- Create auto-order bottom sheet ---
class _CreateSheet extends StatefulWidget {
  final CryptoGrpcClient client;
  final VoidCallback onCreated;
  const _CreateSheet({required this.client, required this.onCreated});
  @override
  State<_CreateSheet> createState() => _CreateSheetState();
}
