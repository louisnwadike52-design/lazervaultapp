import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import '../../../../../core/services/injection_container.dart';
import '../../../../core/grpc/crypto_grpc_client.dart';
import '../../../../generated/crypto.pb.dart';
import '../../domain/entities/crypto_entity.dart';
import '../widgets/crypto_search_sheet.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

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
  /// Quidax-supported assets, passed in from the crypto landing where they're
  /// already loaded — so the create sheet never has to re-fetch (that fetch was
  /// the source of the "failed to load assets" bug). Falls back to a fetch only
  /// if this arrives empty.
  final List<Crypto> assets;
  const PriceAlertsScreen({super.key, this.assets = const []});
  @override
  State<PriceAlertsScreen> createState() => _PriceAlertsScreenState();
}

class _PriceAlertsScreenState extends State<PriceAlertsScreen> {
  final CryptoGrpcClient _client = serviceLocator<CryptoGrpcClient>();
  List<PriceAlert> _active = [], _triggered = [];
  bool _loading = true;
  String? _error;
  // Assets to choose from when creating an alert. Preloaded from the landing;
  // fetched only if that arrives empty.
  late List<Crypto> _assets = widget.assets;

  @override
  void initState() {
    super.initState();
    _load();
    if (_assets.isEmpty) _loadAssetsFallback();
  }

  Future<void> _loadAssetsFallback() async {
    try {
      final res = await _client.getSupportedAssets(perPage: 200, vsCurrency: 'usd');
      if (!mounted) return;
      setState(() => _assets = res.assets.map(_cryptoFromMsg).toList());
    } catch (_) {
      // Leave empty — the picker shows a clear "no assets" state.
    }
  }

  Crypto _cryptoFromMsg(CryptoMessage m) => Crypto(
        id: m.id,
        symbol: m.symbol,
        name: m.name,
        image: m.image,
        currentPrice: m.currentPrice,
        marketCap: m.marketCap.toDouble(),
        marketCapRank: m.marketCapRank,
        totalVolume: m.totalVolume.toDouble(),
        high24h: m.high24h,
        low24h: m.low24h,
        priceChange24h: m.priceChange24h,
        priceChangePercentage24h: m.priceChangePercentage24h,
        circulatingSupply: m.circulatingSupply,
        lastUpdated: DateTime.now(),
      );

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
    builder: (_) => _CreateSheet(client: _client, assets: _assets, onCreated: _load),
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
  final List<Crypto> assets;
  final VoidCallback onCreated;
  const _CreateSheet({required this.client, required this.assets, required this.onCreated});
  @override
  State<_CreateSheet> createState() => _CreateSheetState();
}

class _CreateSheetState extends State<_CreateSheet> {
  final _priceCtrl = TextEditingController();
  Crypto? _selected;
  String _dir = 'above';
  bool _creating = false;

  @override
  void dispose() { _priceCtrl.dispose(); super.dispose(); }

  // Reuse the SAME searchable asset picker the top-bar search uses, over the
  // preloaded Quidax-supported assets — no per-sheet re-fetch that could fail.
  Future<void> _pickAsset() async {
    await showCryptoSearchSheet(
      context,
      assets: widget.assets,
      onSelect: (picked) {
        if (!mounted) return;
        setState(() {
          _selected = picked;
          if (picked.currentPrice > 0) {
            _priceCtrl.text = _fmtPrice(picked.currentPrice);
          }
        });
      },
    );
  }

  Future<void> _create() async {
    if (_selected == null) return;
    final price = double.tryParse(_priceCtrl.text.trim());
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
      Get.snackbar('Alert created',
          '${_selected!.symbol.toUpperCase()} ${_dir == 'above' ? 'above' : 'below'} \$${_fmtPrice(price)}',
          backgroundColor: _card, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
    } catch (_) {
      if (mounted) setState(() => _creating = false);
      Get.snackbar('Error', 'Could not create alert. Please try again.',
          backgroundColor: _red.withValues(alpha: 0.9), colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
    }
  }

  InputDecoration _inputDeco({String? hint, String? prefix, Widget? prefixIcon}) => InputDecoration(
    hintText: hint, hintStyle: _inter(14, c: _sub),
    prefixText: prefix, prefixStyle: _inter(16, c: _sub), prefixIcon: prefixIcon,
    filled: true, fillColor: _bg, contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: _divider)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: _divider)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: _accent)),
  );

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final canCreate = !_creating && _selected != null;
    return Container(
      padding: EdgeInsets.only(bottom: bottom),
      decoration: BoxDecoration(color: _card, borderRadius: BorderRadius.vertical(top: Radius.circular(24.r))),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(child: Container(width: 40.w, height: 4.h,
              decoration: BoxDecoration(color: _divider, borderRadius: BorderRadius.circular(2.r)))),
            SizedBox(height: 20.h),
            Text('Create price alert', style: _inter(18, w: FontWeight.bold)),
            SizedBox(height: 6.h),
            Text('We will notify you the moment the price crosses your target.',
                style: _inter(13, c: _sub)),
            SizedBox(height: 20.h),
            // Asset selector — tappable card (opens the picker modal).
            Text('Asset', style: _inter(13, w: FontWeight.w500, c: _sub)),
            SizedBox(height: 8.h),
            Material(
              color: _bg,
              borderRadius: BorderRadius.circular(12.r),
              child: InkWell(
                onTap: _pickAsset,
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: _selected != null ? _accent.withValues(alpha: 0.5) : _divider),
                  ),
                  child: Row(children: [
                    if (_selected != null)
                      _assetAvatar(_selected!, 18)
                    else
                      Icon(Icons.search, color: _sub, size: 22.sp),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _selected != null
                          ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(_selected!.name, style: _inter(15, w: FontWeight.w600)),
                              SizedBox(height: 2.h),
                              Text(_selected!.symbol.toUpperCase(), style: _inter(12, c: _sub)),
                            ])
                          : Text('Select cryptocurrency', style: _inter(15, c: _sub)),
                    ),
                    Icon(Icons.keyboard_arrow_down_rounded, color: _sub, size: 22.sp),
                  ]),
                ),
              ),
            ),
            if (_selected != null && _selected!.currentPrice > 0) ...[
              SizedBox(height: 8.h),
              Row(children: [
                Icon(Icons.info_outline_rounded, color: _sub, size: 14.sp),
                SizedBox(width: 6.w),
                Text('Current price \$${_fmtPrice(_selected!.currentPrice)}', style: _inter(12, c: _sub)),
              ]),
            ],
            SizedBox(height: 18.h),
            // Target price
            Text('Target price (USD)', style: _inter(13, w: FontWeight.w500, c: _sub)),
            SizedBox(height: 8.h),
            TextField(
              controller: _priceCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (_) => setState(() {}),
              style: _inter(16), decoration: _inputDeco(hint: '0.00', prefix: '\$ '),
            ),
            SizedBox(height: 18.h),
            // Direction
            Text('Notify me when the price goes', style: _inter(13, w: FontWeight.w500, c: _sub)),
            SizedBox(height: 8.h),
            Row(children: [
              _dirChip('Above', 'above', _green), SizedBox(width: 12.w), _dirChip('Below', 'below', _red),
            ]),
            SizedBox(height: 24.h),
            SizedBox(width: double.infinity, height: 52.h, child: ElevatedButton(
              onPressed: canCreate ? _create : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _accent, disabledBackgroundColor: _accent.withValues(alpha: 0.3),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
              ),
              child: _creating
                ? LazerVaultLoader(size: 22)
                : Text(_selected == null ? 'Select an asset' : 'Create alert', style: _inter(16, w: FontWeight.w600)),
            )),
            SizedBox(height: 8.h),
          ]),
        ),
      ),
    );
  }

  Widget _dirChip(String label, String val, Color c) {
    final sel = _dir == val;
    return Expanded(child: Material(
      color: sel ? c.withValues(alpha: 0.15) : _bg,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: () => setState(() => _dir = val),
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: sel ? c : _divider, width: sel ? 1.5 : 1),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(val == 'above' ? Icons.arrow_upward : Icons.arrow_downward, color: sel ? c : _sub, size: 16.sp),
            SizedBox(width: 6.w),
            Text(label, style: _inter(14, w: FontWeight.w600, c: sel ? c : _sub)),
          ]),
        ),
      ),
    ));
  }
}

Widget _assetAvatar(Crypto a, double radius) => a.image.isNotEmpty
    ? CircleAvatar(radius: radius.r, backgroundImage: NetworkImage(a.image), backgroundColor: _divider)
    : CircleAvatar(
        radius: radius.r,
        backgroundColor: _accent.withValues(alpha: 0.15),
        child: Text(a.symbol.isNotEmpty ? a.symbol.toUpperCase().substring(0, 1) : '?',
            style: _inter(12, w: FontWeight.w700, c: _accent)),
      );
