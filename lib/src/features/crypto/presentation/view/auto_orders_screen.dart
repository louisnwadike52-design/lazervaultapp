import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/core/utils/friendly_error.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/services/injection_container.dart';
import '../../../../core/grpc/crypto_grpc_client.dart';
import '../../../../generated/crypto.pb.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
part 'auto_orders_screen_widgets.dart';


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

class _CreateSheetState extends State<_CreateSheet>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      serviceLocator<ITransactionPinService>();

  final _priceCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _searchCtrl = TextEditingController();
  List<CryptoMessage> _assets = [], _filtered = [];
  CryptoMessage? _selected;
  final String _side = 'buy'; // buy-only for now (sell needs saga ToAmount support)
  String _dir = 'below';
  bool _loadingAssets = false, _creating = false, _picking = false;

  // Stable per-sheet idempotency key: a retry after a timeout (where the first
  // call actually succeeded server-side) must NOT mint a second order + second
  // fiat hold. The server dedups on this key.
  final String _idem = 'AUTOORDER-${const Uuid().v4()}';

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
    if (price == null || price <= 0) {
      _toast('Enter a valid target price');
      return;
    }
    if (amount == null || amount <= 0) {
      _toast('Enter a valid amount');
      return;
    }
    final accountId = serviceLocator<AccountManager>().activeAccountId ?? '';
    if (accountId.isEmpty) {
      _toast('No active account selected');
      return;
    }

    // Standard transaction-PIN bottomsheet (same as buy/sell/send/swap) —
    // the backend's VerifyPinOrToken accepts the sheet's minted token in the
    // transaction_pin field, so no inline PIN text field is needed here.
    setState(() => _creating = true);
    var created = false;
    final ok = await validateTransactionPin(
      context: context,
      transactionId: _idem,
      transactionType: 'crypto_auto_order',
      amount: amount,
      currency: _ccy,
      title: 'Authorise auto order',
      message:
          '${_side == 'buy' ? 'Buy' : 'Sell'} ${_selected!.symbol.toUpperCase()} when price is $_dir $_sym${_fmtPrice(price)}',
      showProcessingPhase: true,
      successMessage: 'Auto order created',
      onPinValidated: (token) async {
        await widget.client.createAutoOrder(
          accountId: accountId,
          side: _side,
          cryptoId: _selected!.id,
          fiatCurrency: _ccy,
          triggerDirection: _dir,
          targetPrice: price,
          amountMinor: (amount * 100).round(),
          transactionPin: token,
          idempotencyKey: _idem,
        );
        created = true;
      },
    );
    if (!mounted) return;
    setState(() => _creating = false);
    if (ok && created) {
      widget.onCreated();
      Navigator.pop(context);
      Get.snackbar(
        'Auto order created',
        '${_side == 'buy' ? 'Buy' : 'Sell'} ${_selected!.symbol.toUpperCase()} when $_dir $_sym${_fmtPrice(price)}',
        backgroundColor: _card,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
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
            SizedBox(height: 20.h),
            // Authorisation happens in the standard transaction-PIN bottomsheet
            // when the user taps Create — no inline PIN field.
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
