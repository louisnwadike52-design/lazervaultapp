import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import '../../../../../core/services/injection_container.dart';
import '../../../../core/grpc/crypto_grpc_client.dart';
import '../../../../generated/crypto.pb.dart';

const _bg = Color(0xFF0A0A0A);
const _card = Color(0xFF1F1F1F);
const _accent = Color.fromARGB(255, 78, 3, 208);
const _divider = Color(0xFF2D2D2D);
const _sub = Color(0xFF9CA3AF);
const _green = Color(0xFF10B981);
const _red = Color(0xFFEF4444);

TextStyle _inter(double size, {FontWeight w = FontWeight.w400, Color c = Colors.white}) =>
    GoogleFonts.inter(fontSize: size.sp, fontWeight: w, color: c);

String _fmtPrice(double p) =>
    p >= 1 ? p.toStringAsFixed(2) : (p >= 0.01 ? p.toStringAsFixed(4) : p.toStringAsFixed(6));

class PriceAlertsScreen extends StatefulWidget {
  const PriceAlertsScreen({super.key});
  @override
  State<PriceAlertsScreen> createState() => _PriceAlertsScreenState();
}

class _PriceAlertsScreenState extends State<PriceAlertsScreen> {
  final CryptoGrpcClient _client = serviceLocator<CryptoGrpcClient>();
  List<PriceAlert> _active = [], _triggered = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() { super.initState(); _load(); }

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      final res = await _client.getPriceAlerts(activeOnly: false);
      final all = res.alerts.toList();
      setState(() {
        _active = all.where((a) => a.isActive && !a.isTriggered).toList();
        _triggered = all.where((a) => a.isTriggered).toList();
        _loading = false;
      });
    } catch (_) {
      setState(() { _error = 'Failed to load alerts'; _loading = false; });
    }
  }

  Future<void> _delete(String id) async {
    try {
      await _client.deletePriceAlert(id);
      await _load();
      Get.snackbar('Deleted', 'Price alert removed',
          backgroundColor: _card, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
    } catch (_) {
      Get.snackbar('Error', 'Could not delete alert',
          backgroundColor: _red.withValues(alpha: 0.9), colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
    }
  }

  void _showCreate() => showModalBottomSheet(
    context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
    builder: (_) => _CreateSheet(client: _client, onCreated: _load),
  );

  @override
  Widget build(BuildContext context) {
    final empty = !_loading && _active.isEmpty && _triggered.isEmpty;
    return Scaffold(
      backgroundColor: _bg,
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreate, backgroundColor: _accent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(child: Column(children: [
        // App bar
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
            Text('Price Alerts', style: _inter(20, w: FontWeight.bold)),
          ]),
        ),
        Expanded(child: RefreshIndicator(
          color: _accent, backgroundColor: _card, onRefresh: _load,
          child: _loading ? _shimmer() : _error != null ? _errView() : empty ? _emptyView() : _list(),
        )),
      ])),
    );
  }

  Widget _shimmer() => Shimmer.fromColors(
    baseColor: _card, highlightColor: _divider,
    child: ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w), itemCount: 5,
      itemBuilder: (_, __) => Container(
        height: 76.h, margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(color: _card, borderRadius: BorderRadius.circular(14.r)),
      ),
    ),
  );

  Widget _errView() => ListView(children: [
    SizedBox(height: 120.h),
    Center(child: Column(children: [
      Icon(Icons.error_outline, color: _red, size: 48.sp),
      SizedBox(height: 16.h),
      Text(_error!, style: _inter(16, c: _sub)),
      SizedBox(height: 16.h),
      TextButton(onPressed: _load, child: Text('Retry', style: _inter(14, c: _accent))),
    ])),
  ]);

  Widget _emptyView() => ListView(children: [
    SizedBox(height: 100.h),
    Center(child: Column(children: [
      Container(
        width: 80.w, height: 80.w,
        decoration: BoxDecoration(color: _accent.withValues(alpha: 0.15), shape: BoxShape.circle),
        child: Icon(Icons.notifications_active, color: _accent, size: 40.sp),
      ),
      SizedBox(height: 24.h),
      Text('Set your first price alert', style: _inter(20, w: FontWeight.w600)),
      SizedBox(height: 8.h),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 48.w),
        child: Text('Get notified when crypto prices hit your target. Tap + to create one.',
          textAlign: TextAlign.center, style: _inter(14, c: _sub)),
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
      _sectionLabel('Active', _active.length), SizedBox(height: 8.h),
      ..._active.map((a) => _Tile(alert: a, onDelete: () => _delete(a.id))),
    ],
    if (_triggered.isNotEmpty) ...[
      SizedBox(height: 20.h),
      _sectionLabel('Triggered', _triggered.length), SizedBox(height: 8.h),
      ..._triggered.map((a) => _Tile(alert: a, triggered: true, onDelete: () => _delete(a.id))),
    ],
    SizedBox(height: 80.h),
  ]);
}

// --- Alert tile with swipe-to-delete ---
class _Tile extends StatelessWidget {
  final PriceAlert alert;
  final bool triggered;
  final VoidCallback onDelete;
  const _Tile({required this.alert, this.triggered = false, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final above = alert.direction.toLowerCase() == 'above';
    final dirColor = above ? _green : _red;
    final sym = CurrencySymbols.getSymbol(alert.fiatCurrency);

    return Dismissible(
      key: Key(alert.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => showDialog<bool>(context: context, builder: (ctx) => AlertDialog(
        backgroundColor: _card,
        title: Text('Delete Alert', style: _inter(16, w: FontWeight.w600)),
        content: Text('Remove this price alert?', style: _inter(14, c: _sub)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false),
            child: Text('Cancel', style: _inter(14, c: _sub))),
          TextButton(onPressed: () => Navigator.pop(ctx, true),
            child: Text('Delete', style: _inter(14, c: _red))),
        ],
      )),
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight, padding: EdgeInsets.only(right: 20.w),
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(color: _red.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(14.r)),
        child: Icon(Icons.delete_outline, color: _red, size: 24.sp),
      ),
      child: Opacity(
        opacity: triggered ? 0.5 : 1.0,
        child: Container(
          margin: EdgeInsets.only(bottom: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: _card, borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: _divider),
          ),
          child: Row(children: [
            // Symbol badge
            Container(
              width: 40.w, height: 40.w, alignment: Alignment.center,
              decoration: BoxDecoration(color: _accent.withValues(alpha: 0.15), shape: BoxShape.circle),
              child: Text(
                alert.cryptoSymbol.toUpperCase().substring(0, alert.cryptoSymbol.length > 2 ? 2 : alert.cryptoSymbol.length),
                style: _inter(13, w: FontWeight.w700, c: _accent),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(alert.cryptoSymbol.toUpperCase(), style: _inter(15, w: FontWeight.w600)),
              SizedBox(height: 2.h),
              Text(
                triggered && alert.hasTriggeredAt() ? 'Triggered ${_ts(alert.triggeredAt)}' : alert.cryptoId,
                style: _inter(12, c: _sub),
              ),
            ])),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text('$sym${_fmtPrice(alert.targetPrice)}', style: _inter(15, w: FontWeight.w600)),
              SizedBox(height: 2.h),
              Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(above ? Icons.arrow_upward : Icons.arrow_downward, color: dirColor, size: 14.sp),
                SizedBox(width: 2.w),
                Text(above ? 'Above' : 'Below', style: _inter(12, w: FontWeight.w500, c: dirColor)),
              ]),
            ]),
          ]),
        ),
      ),
    );
  }

  String _ts(dynamic ts) {
    try {
      final d = DateTime.now().difference(ts.toDateTime());
      if (d.inMinutes < 60) return '${d.inMinutes}m ago';
      if (d.inHours < 24) return '${d.inHours}h ago';
      return '${d.inDays}d ago';
    } catch (_) { return ''; }
  }
}

// --- Create alert bottom sheet ---
class _CreateSheet extends StatefulWidget {
  final CryptoGrpcClient client;
  final VoidCallback onCreated;
  const _CreateSheet({required this.client, required this.onCreated});
  @override
  State<_CreateSheet> createState() => _CreateSheetState();
}

class _CreateSheetState extends State<_CreateSheet> {
  final _priceCtrl = TextEditingController();
  final _searchCtrl = TextEditingController();
  List<CryptoMessage> _assets = [], _filtered = [];
  CryptoMessage? _selected;
  String _dir = 'above';
  bool _loadingAssets = false, _creating = false, _picking = false;

  @override
  void initState() { super.initState(); _loadAssets(); }
  @override
  void dispose() { _priceCtrl.dispose(); _searchCtrl.dispose(); super.dispose(); }

  Future<void> _loadAssets() async {
    setState(() => _loadingAssets = true);
    try {
      final r = await widget.client.getSupportedAssets(perPage: 100, vsCurrency: 'usd');
      setState(() { _assets = r.assets.toList(); _filtered = _assets; _loadingAssets = false; });
    } catch (_) { setState(() => _loadingAssets = false); }
  }

  void _filter(String q) {
    final lq = q.toLowerCase();
    setState(() => _filtered = _assets.where((a) =>
        a.name.toLowerCase().contains(lq) || a.symbol.toLowerCase().contains(lq)).toList());
  }

  Future<void> _create() async {
    if (_selected == null) return;
    final price = double.tryParse(_priceCtrl.text);
    if (price == null || price <= 0) {
      Get.snackbar('Invalid', 'Enter a valid target price',
          backgroundColor: _card, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
      return;
    }
    setState(() => _creating = true);
    try {
      await widget.client.createPriceAlert(
          cryptoId: _selected!.id, targetPrice: price, direction: _dir, fiatCurrency: 'USD');
      widget.onCreated();
      if (mounted) Navigator.pop(context);
      Get.snackbar('Alert Created',
          '${_selected!.symbol.toUpperCase()} ${_dir == 'above' ? 'above' : 'below'} \$${_fmtPrice(price)}',
          backgroundColor: _card, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
    } catch (_) {
      setState(() => _creating = false);
      Get.snackbar('Error', 'Could not create alert',
          backgroundColor: _red.withValues(alpha: 0.9), colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
    }
  }

  InputDecoration _inputDeco({String? hint, String? prefix, Widget? prefixIcon}) => InputDecoration(
    hintText: hint, hintStyle: _inter(14, c: _sub),
    prefixText: prefix, prefixStyle: _inter(16, c: _sub), prefixIcon: prefixIcon,
    filled: true, fillColor: _bg, contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: _divider)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: _divider)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: _accent)),
  );

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      padding: EdgeInsets.only(bottom: bottom),
      decoration: BoxDecoration(color: _card, borderRadius: BorderRadius.vertical(top: Radius.circular(24.r))),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Handle
            Center(child: Container(width: 40.w, height: 4.h,
              decoration: BoxDecoration(color: _divider, borderRadius: BorderRadius.circular(2.r)))),
            SizedBox(height: 20.h),
            Text('Create Price Alert', style: _inter(18, w: FontWeight.bold)),
            SizedBox(height: 20.h),
            // Asset selector
            Text('Asset', style: _inter(13, w: FontWeight.w500, c: _sub)),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () => setState(() => _picking = true),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(color: _bg, borderRadius: BorderRadius.circular(12.r), border: Border.all(color: _divider)),
                child: Row(children: [
                  Expanded(child: Text(
                    _selected != null ? '${_selected!.name} (${_selected!.symbol.toUpperCase()})' : 'Select cryptocurrency',
                    style: _inter(14, c: _selected != null ? Colors.white : _sub),
                  )),
                  Icon(Icons.keyboard_arrow_down, color: _sub, size: 20.sp),
                ]),
              ),
            ),
            if (_picking) ...[
              SizedBox(height: 8.h),
              TextField(
                controller: _searchCtrl, onChanged: _filter,
                style: _inter(14), decoration: _inputDeco(hint: 'Search assets...', prefixIcon: Icon(Icons.search, color: _sub, size: 20.sp)),
              ),
              SizedBox(height: 4.h),
              Container(
                height: 180.h,
                decoration: BoxDecoration(color: _bg, borderRadius: BorderRadius.circular(12.r), border: Border.all(color: _divider)),
                child: _loadingAssets
                  ? const Center(child: CircularProgressIndicator(color: _accent))
                  : ListView.builder(
                      padding: EdgeInsets.zero, itemCount: _filtered.length,
                      itemBuilder: (_, i) {
                        final a = _filtered[i];
                        final sel = _selected?.id == a.id;
                        return ListTile(
                          dense: true, selected: sel, selectedTileColor: _accent.withValues(alpha: 0.1),
                          leading: a.image.isNotEmpty
                            ? CircleAvatar(radius: 14.r, backgroundImage: NetworkImage(a.image), backgroundColor: _divider)
                            : CircleAvatar(radius: 14.r, backgroundColor: _accent.withValues(alpha: 0.15),
                                child: Text(a.symbol.toUpperCase().substring(0, 1), style: _inter(12, w: FontWeight.w700, c: _accent))),
                          title: Text(a.name, style: _inter(13)),
                          trailing: Text(a.symbol.toUpperCase(), style: _inter(12, c: _sub)),
                          onTap: () => setState(() { _selected = a; _picking = false; _searchCtrl.clear(); _filtered = _assets; }),
                        );
                      }),
              ),
            ],
            SizedBox(height: 16.h),
            // Target price
            Text('Target Price (USD)', style: _inter(13, w: FontWeight.w500, c: _sub)),
            SizedBox(height: 8.h),
            TextField(
              controller: _priceCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: _inter(16), decoration: _inputDeco(hint: '0.00', prefix: '\$ '),
            ),
            SizedBox(height: 16.h),
            // Direction
            Text('Direction', style: _inter(13, w: FontWeight.w500, c: _sub)),
            SizedBox(height: 8.h),
            Row(children: [
              _dirChip('Above', 'above', _green), SizedBox(width: 12.w), _dirChip('Below', 'below', _red),
            ]),
            SizedBox(height: 24.h),
            // Create button
            SizedBox(width: double.infinity, height: 50.h, child: ElevatedButton(
              onPressed: _creating || _selected == null ? null : _create,
              style: ElevatedButton.styleFrom(
                backgroundColor: _accent, disabledBackgroundColor: _accent.withValues(alpha: 0.3),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
              ),
              child: _creating
                ? SizedBox(width: 22.w, height: 22.w, child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                : Text('Create Alert', style: _inter(16, w: FontWeight.w600)),
            )),
            SizedBox(height: 8.h),
          ]),
        ),
      ),
    );
  }

  Widget _dirChip(String label, String val, Color c) {
    final sel = _dir == val;
    return Expanded(child: GestureDetector(
      onTap: () => setState(() => _dir = val),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: sel ? c.withValues(alpha: 0.15) : _bg, borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: sel ? c : _divider, width: sel ? 1.5 : 1),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(val == 'above' ? Icons.arrow_upward : Icons.arrow_downward, color: sel ? c : _sub, size: 16.sp),
          SizedBox(width: 6.w),
          Text(label, style: _inter(14, w: FontWeight.w600, c: sel ? c : _sub)),
        ]),
      ),
    ));
  }
}
