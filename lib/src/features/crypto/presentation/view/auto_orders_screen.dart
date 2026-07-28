import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/core/services/account_manager.dart';
import '../../../../../core/services/injection_container.dart';
import '../../../../core/grpc/crypto_grpc_client.dart';
import '../../../../generated/crypto.pb.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

const _bg = Color(0xFF0A0A0A);
const _card = Color(0xFF1F1F1F);
const _accent = Color.fromARGB(255, 78, 3, 208);
const _divider = Color(0xFF2D2D2D);
const _sub = Color(0xFF9CA3AF);
const _green = Color(0xFF10B981);
const _red = Color(0xFFEF4444);
const _orange = Color(0xFFFB923C);

TextStyle _inter(double size, {FontWeight w = FontWeight.w400, Color c = Colors.white}) =>
    GoogleFonts.inter(fontSize: size.sp, fontWeight: w, color: c);

String _fmtPrice(double p) =>
    p >= 1 ? p.toStringAsFixed(2) : (p >= 0.01 ? p.toStringAsFixed(4) : p.toStringAsFixed(6));

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
    } catch (_) {
      Get.snackbar('Error', 'Could not cancel auto order',
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
                'Buy or sell automatically when the price hits your target. Funds for a buy are reserved up front. Tap + to create one.',
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

class _CreateSheetState extends State<_CreateSheet> {
  final _priceCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _pinCtrl = TextEditingController();
  final _searchCtrl = TextEditingController();
  List<CryptoMessage> _assets = [], _filtered = [];
  CryptoMessage? _selected;
  final String _side = 'buy'; // buy-only for now (sell needs saga ToAmount support)
  String _dir = 'below';
  bool _loadingAssets = false, _creating = false, _picking = false;

  String get _ccy => CurrencySymbols.currentCurrency;
  String get _sym => CurrencySymbols.currentSymbol;

  @override
  void initState() {
    super.initState();
    _loadAssets();
  }

  @override
  void dispose() {
    _priceCtrl.dispose();
    _amountCtrl.dispose();
    _pinCtrl.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadAssets() async {
    setState(() => _loadingAssets = true);
    try {
      final r = await widget.client.getSupportedAssets(perPage: 100, vsCurrency: _ccy.toLowerCase());
      setState(() {
        _assets = r.assets.toList();
        _filtered = _assets;
        _loadingAssets = false;
      });
    } catch (_) {
      setState(() => _loadingAssets = false);
    }
  }

  void _filter(String q) {
    final lq = q.toLowerCase();
    setState(() => _filtered = _assets
        .where((a) => a.name.toLowerCase().contains(lq) || a.symbol.toLowerCase().contains(lq))
        .toList());
  }

  Future<void> _create() async {
    if (_selected == null) return;
    final price = double.tryParse(_priceCtrl.text);
    final amount = double.tryParse(_amountCtrl.text);
    final pin = _pinCtrl.text.trim();
    if (price == null || price <= 0) {
      _toast('Enter a valid target price');
      return;
    }
    if (amount == null || amount <= 0) {
      _toast('Enter a valid amount');
      return;
    }
    if (pin.length < 4) {
      _toast('Enter your transaction PIN');
      return;
    }
    final accountId = serviceLocator<AccountManager>().activeAccountId ?? '';
    if (accountId.isEmpty) {
      _toast('No active account selected');
      return;
    }

    setState(() => _creating = true);
    try {
      await widget.client.createAutoOrder(
        accountId: accountId,
        side: _side,
        cryptoId: _selected!.id,
        fiatCurrency: _ccy,
        triggerDirection: _dir,
        targetPrice: price,
        amountMinor: (amount * 100).round(),
        transactionPin: pin,
      );
      widget.onCreated();
      if (mounted) Navigator.pop(context);
      Get.snackbar(
        'Auto order created',
        '${_side == 'buy' ? 'Buy' : 'Sell'} ${_selected!.symbol.toUpperCase()} when $_dir $_sym${_fmtPrice(price)}',
        backgroundColor: _card,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      setState(() => _creating = false);
      _toast('Could not create auto order: ${e.toString().replaceAll('Exception: ', '')}', error: true);
    }
  }

  void _toast(String msg, {bool error = false}) => Get.snackbar(
        error ? 'Error' : 'Invalid',
        msg,
        backgroundColor: error ? _red.withValues(alpha: 0.9) : _card,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

  InputDecoration _inputDeco({String? hint, String? prefix, Widget? prefixIcon}) => InputDecoration(
        hintText: hint,
        hintStyle: _inter(14, c: _sub),
        prefixText: prefix,
        prefixStyle: _inter(16, c: _sub),
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: _bg,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
            Center(
                child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(color: _divider, borderRadius: BorderRadius.circular(2.r)))),
            SizedBox(height: 20.h),
            Text('Create Auto Buy', style: _inter(18, w: FontWeight.bold)),
            SizedBox(height: 6.h),
            Text(
              'We reserve the amount now and buy automatically when the price is reached.',
              style: _inter(12, c: _sub),
            ),
            SizedBox(height: 16.h),
            // Asset selector
            Text('Asset', style: _inter(13, w: FontWeight.w500, c: _sub)),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () => setState(() => _picking = true),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(color: _bg, borderRadius: BorderRadius.circular(12.r), border: Border.all(color: _divider)),
                child: Row(children: [
                  Expanded(
                      child: Text(
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
                controller: _searchCtrl,
                onChanged: _filter,
                style: _inter(14),
                decoration: _inputDeco(hint: 'Search assets...', prefixIcon: Icon(Icons.search, color: _sub, size: 20.sp)),
              ),
              SizedBox(height: 4.h),
              Container(
                height: 180.h,
                decoration: BoxDecoration(color: _bg, borderRadius: BorderRadius.circular(12.r), border: Border.all(color: _divider)),
                child: _loadingAssets
                    ? const Center(child: LazerVaultLoader.small())
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: _filtered.length,
                        itemBuilder: (_, i) {
                          final a = _filtered[i];
                          final sel = _selected?.id == a.id;
                          return ListTile(
                            dense: true,
                            selected: sel,
                            selectedTileColor: _accent.withValues(alpha: 0.1),
                            leading: a.image.isNotEmpty
                                ? CircleAvatar(radius: 14.r, backgroundImage: NetworkImage(a.image), backgroundColor: _divider)
                                : CircleAvatar(
                                    radius: 14.r,
                                    backgroundColor: _accent.withValues(alpha: 0.15),
                                    child: Text(a.symbol.toUpperCase().substring(0, 1), style: _inter(12, w: FontWeight.w700, c: _accent))),
                            title: Text(a.name, style: _inter(13)),
                            trailing: Text(a.symbol.toUpperCase(), style: _inter(12, c: _sub)),
                            onTap: () => setState(() {
                              _selected = a;
                              _picking = false;
                              _searchCtrl.clear();
                              _filtered = _assets;
                            }),
                          );
                        }),
              ),
            ],
            SizedBox(height: 16.h),
            // Target price
            Text('Target Price ($_ccy)', style: _inter(13, w: FontWeight.w500, c: _sub)),
            SizedBox(height: 8.h),
            TextField(
              controller: _priceCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: _inter(16),
              decoration: _inputDeco(hint: '0.00', prefix: '$_sym '),
            ),
            SizedBox(height: 16.h),
            // Direction
            Text('Trigger when price is', style: _inter(13, w: FontWeight.w500, c: _sub)),
            SizedBox(height: 8.h),
            Row(children: [
              _dirChip('Above', 'above', _green),
              SizedBox(width: 12.w),
              _dirChip('Below', 'below', _red),
            ]),
            SizedBox(height: 16.h),
            // Amount
            Text('Amount to spend ($_ccy)', style: _inter(13, w: FontWeight.w500, c: _sub)),
            SizedBox(height: 8.h),
            TextField(
              controller: _amountCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: _inter(16),
              decoration: _inputDeco(hint: '0.00', prefix: '$_sym '),
            ),
            SizedBox(height: 16.h),
            // PIN
            Text('Transaction PIN', style: _inter(13, w: FontWeight.w500, c: _sub)),
            SizedBox(height: 8.h),
            TextField(
              controller: _pinCtrl,
              obscureText: true,
              keyboardType: TextInputType.number,
              maxLength: 6,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: _inter(16),
              decoration: _inputDeco(hint: 'Enter PIN to authorise').copyWith(counterText: ''),
            ),
            SizedBox(height: 20.h),
            SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: _creating || _selected == null ? null : _create,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _accent,
                    disabledBackgroundColor: _accent.withValues(alpha: 0.3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                  ),
                  child: _creating ? LazerVaultLoader(size: 22) : Text('Create Auto Order', style: _inter(16, w: FontWeight.w600)),
                )),
            SizedBox(height: 8.h),
          ]),
        ),
      ),
    );
  }

  Widget _dirChip(String label, String val, Color c) {
    final sel = _dir == val;
    return Expanded(
        child: GestureDetector(
      onTap: () => setState(() => _dir = val),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: sel ? c.withValues(alpha: 0.15) : _bg,
          borderRadius: BorderRadius.circular(12.r),
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
