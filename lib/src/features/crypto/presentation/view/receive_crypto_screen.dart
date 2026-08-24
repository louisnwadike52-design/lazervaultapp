import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:lazervault/src/core/grpc/crypto_grpc_client.dart';
import 'package:lazervault/src/features/crypto/domain/entities/crypto_entity.dart';
import 'package:lazervault/src/generated/crypto.pbgrpc.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/crypto/presentation/widgets/crypto_asset_avatar.dart';
import 'package:lazervault/src/features/crypto/presentation/widgets/network_picker_sheet.dart';

// ReceiveCryptoScreen (PR7) — pick an asset, pick its network, ensure the
// deposit address exists, and render it for the user to copy / share.
//
// Server is the source of truth for:
//   - the network list (`GetSupportedAssetNetworks` → quidax_asset_networks)
//   - the address itself (`EnsureWalletAddress` → Quidax CreatePaymentAddress)
//   - pending deposits + confirmation progress (`GetUserCryptoDeposits`)
//
// Nothing on this screen is hardcoded; the network dropdown is dynamic.

class ReceiveCryptoScreen extends StatefulWidget {
  final CryptoHolding holding;

  const ReceiveCryptoScreen({super.key, required this.holding});

  @override
  State<ReceiveCryptoScreen> createState() => _ReceiveCryptoScreenState();
}

class _ReceiveCryptoScreenState extends State<ReceiveCryptoScreen> {
  bool _loading = true;
  bool _generating = false;
  List<QuidaxAssetNetwork> _networks = const [];
  String? _selectedNetwork;
  String _address = '';
  String _destinationTag = '';
  String _minDeposit = '';
  String _error = '';
  List<UserCryptoDeposit> _pendingDeposits = const [];

  CryptoGrpcClient get _client => GetIt.I<CryptoGrpcClient>();
  String get _currency => widget.holding.cryptoSymbol.toLowerCase();

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    setState(() => _loading = true);
    try {
      // Pull network catalogue + recent deposits in parallel for fewer roundtrips.
      final results = await Future.wait([
        _client.getSupportedAssetNetworks(currency: _currency),
        _client.getUserCryptoDeposits(currency: _currency, perPage: 10),
      ]);
      final netResp = results[0] as GetSupportedAssetNetworksResponse;
      final depResp = results[1] as GetUserCryptoDepositsResponse;

      _networks = netResp.networks;
      // Default network = the row flagged is_default OR the first one.
      final defaultNet = _networks.firstWhere(
        (n) => n.isDefault,
        orElse: () => _networks.isNotEmpty ? _networks.first : QuidaxAssetNetwork.create(),
      );
      _selectedNetwork = defaultNet.network.isEmpty ? null : defaultNet.network;
      _minDeposit = defaultNet.minDepositDecimal;
      _pendingDeposits = depResp.deposits;
    } catch (e) {
      _error = e.toString();
    } finally {
      if (mounted) setState(() => _loading = false);
    }

    // Kick off the address generation immediately so the user doesn't have
    // to tap twice. EnsureWalletAddress is idempotent.
    if (_selectedNetwork != null) {
      await _ensureAddress();
    }
  }

  Future<void> _ensureAddress() async {
    if (_selectedNetwork == null) return;
    setState(() {
      _generating = true;
      _address = '';
      _destinationTag = '';
    });
    try {
      final resp = await _client.ensureWalletAddress(
        currency: _currency,
        network: _selectedNetwork!,
      );
      _address = resp.address;
      _destinationTag = resp.destinationTag;
    } catch (e) {
      _error = e.toString();
    } finally {
      if (mounted) setState(() => _generating = false);
    }
  }

  void _onNetworkChange(String? net) {
    if (net == null || net == _selectedNetwork) return;
    final match = _networks.firstWhere(
      (n) => n.network == net,
      orElse: () => QuidaxAssetNetwork.create(),
    );
    setState(() {
      _selectedNetwork = net;
      _minDeposit = match.minDepositDecimal;
      _address = '';
      _destinationTag = '';
    });
    _ensureAddress();
  }

  Future<void> _copy() async {
    if (_address.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: _address));
    if (!mounted) return;
    Get.snackbar('Copied', 'Address copied to clipboard',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xCC10B981),
        colorText: Colors.white,
        duration: const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    final symbol = widget.holding.cryptoSymbol.toUpperCase();
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        title: Text('Receive $symbol',
            style: GoogleFonts.inter(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: _loading
            ? const Center(child: LazerVaultLoader.small())
            : ListView(
                padding: EdgeInsets.all(16.w),
                children: [
                  _assetHeader(symbol),
                  SizedBox(height: 16.h),
                  if (_error.isNotEmpty) _errorBanner(),
                  _networkSelector(),
                  SizedBox(height: 16.h),
                  _addressCard(),
                  SizedBox(height: 16.h),
                  if (_minDeposit.isNotEmpty && _minDeposit != '0')
                    _minDepositNotice(symbol),
                  SizedBox(height: 16.h),
                  if (_pendingDeposits.isNotEmpty) _pendingSection(symbol),
                ],
              ),
      ),
    );
  }

  // Top section: the actual asset's logo (or its initials chip) + name, so the
  // user sees which asset they're receiving — never a shared Bitcoin icon.
  Widget _assetHeader(String symbol) {
    final name = widget.holding.cryptoName.isNotEmpty
        ? widget.holding.cryptoName
        : symbol;
    return Column(
      children: [
        CryptoAssetAvatar(symbol: symbol, size: 56),
        SizedBox(height: 10.h),
        Text(
          name,
          style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 2.h),
        Text(
          symbol,
          style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF), fontSize: 13.sp),
        ),
      ],
    );
  }

  Widget _errorBanner() => Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
            color: const Color(0xFFEF4444).withValues(alpha: 0.15),
            border: Border.all(color: const Color(0xFFEF4444), width: 1),
            borderRadius: BorderRadius.circular(8.r)),
        child: Text(_error,
            style: GoogleFonts.inter(
                color: const Color(0xFFEF4444), fontSize: 12.sp)),
      );

  /// Human name for a network slug (no fee suffix), for the selector row.
  String _receiveNetworkName(String? slug) {
    if (slug == null) return 'Select network';
    for (final n in _networks) {
      if (n.network == slug) {
        return n.networkName.isEmpty ? n.network.toUpperCase() : n.networkName;
      }
    }
    return slug.toUpperCase();
  }

  Future<void> _pickReceiveNetwork() async {
    final deposit =
        _networks.where((n) => n.depositEnabled).toList(growable: false);
    if (deposit.isEmpty) return;
    final sym = widget.holding.cryptoSymbol.toUpperCase();
    final chosen = await showNetworkPickerSheet(
      context,
      currency: widget.holding.cryptoSymbol.toLowerCase(),
      networks: deposit,
      selectedNetwork: _selectedNetwork,
      title: 'Receive $sym on',
      subtitle:
          'Only send $sym to this address on the chosen network. Sending on another network can lose funds.',
    );
    if (chosen == null || !mounted) return;
    _onNetworkChange(chosen);
  }

  Widget _networkSelector() {
    if (_networks.isEmpty) {
      return Text(
        'No networks configured for this asset yet. Contact support.',
        style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF), fontSize: 12.sp),
      );
    }
    // Opens the shared picker (deposit-enabled networks) instead of a raw
    // dropdown, matching the rest of the crypto network surface. Selection
    // flows through the existing _onNetworkChange handler.
    final label = _receiveNetworkName(_selectedNetwork);
    return Material(
      color: const Color(0xFF1F1F1F),
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: _pickReceiveNetwork,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          child: Row(
            children: [
              Icon(Icons.lan_rounded,
                  color: const Color(0xFF93C5FD), size: 18.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.inter(
                      color: Colors.white, fontSize: 14.sp),
                ),
              ),
              Icon(Icons.keyboard_arrow_down_rounded,
                  color: const Color(0xFF9CA3AF), size: 20.sp),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addressCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_generating)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: const Center(child: LazerVaultLoader.small()),
            )
          else if (_address.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Column(children: [
                Icon(Icons.hourglass_top,
                    color: const Color(0xFFFB923C), size: 48.sp),
                SizedBox(height: 8.h),
                Text(
                  'Generating your address. This usually takes a few seconds.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                ),
                SizedBox(height: 12.h),
                TextButton(
                  onPressed: _ensureAddress,
                  child: const Text('Retry'),
                ),
              ]),
            )
          else ...[
            // Scannable QR of the deposit address (qr_flutter is already a
            // dependency and used across the app) — the address-only rendering
            // forced recipients to copy-paste, defeating the send-flow scanner.
            Center(
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: QrImageView(
                  data: _address,
                  version: QrVersions.auto,
                  size: 180.w,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                  color: const Color(0xFF0A0A0A),
                  borderRadius: BorderRadius.circular(12.r)),
              child: SelectableText(
                _address,
                style: GoogleFonts.robotoMono(
                    color: Colors.white, fontSize: 13.sp),
                textAlign: TextAlign.center,
              ),
            ),
            if (_destinationTag.isNotEmpty) ...[
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                    color: const Color(0xFFFB923C).withValues(alpha: 0.15),
                    border: Border.all(color: const Color(0xFFFB923C), width: 1),
                    borderRadius: BorderRadius.circular(8.r)),
                child: Column(children: [
                  Text('Destination tag (required)',
                      style: GoogleFonts.inter(
                          color: const Color(0xFFFB923C),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 4.h),
                  SelectableText(_destinationTag,
                      style: GoogleFonts.robotoMono(
                          color: Colors.white, fontSize: 14.sp)),
                ]),
              ),
            ],
            SizedBox(height: 12.h),
            ElevatedButton.icon(
              onPressed: _copy,
              icon: const Icon(Icons.copy, size: 18),
              label: const Text('Copy address'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _minDepositNotice(String symbol) => Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
            color: const Color(0xFFFB923C).withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
                color: const Color(0xFFFB923C).withValues(alpha: 0.5))),
        child: Row(children: [
          Icon(Icons.info_outline,
              color: const Color(0xFFFB923C), size: 18.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'Minimum deposit is $_minDeposit $symbol. Deposits below this go on hold.',
              style: GoogleFonts.inter(
                  color: const Color(0xFFFB923C), fontSize: 12.sp),
            ),
          ),
        ]),
      );

  Widget _pendingSection(String symbol) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Text('Recent deposits',
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp)),
        ),
        ..._pendingDeposits.map((d) => _DepositRow(deposit: d)),
      ],
    );
  }
}

class _DepositRow extends StatelessWidget {
  final UserCryptoDeposit deposit;
  const _DepositRow({required this.deposit});

  Color _statusColor(String s) {
    switch (s.toLowerCase()) {
      case 'accepted':
      case 'confirmed':
      case 'checked':
        return const Color(0xFF10B981);
      case 'on_hold':
        return const Color(0xFFFB923C);
      case 'failed_aml':
      case 'rejected':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF9CA3AF);
    }
  }

  String _label(String s) {
    switch (s.toLowerCase()) {
      case 'accepted':
        return 'Received';
      case 'confirmed':
        return 'Confirming';
      case 'submitted':
        return 'Pending';
      case 'on_hold':
        return 'On hold';
      case 'failed_aml':
        return 'AML check failed';
      case 'rejected':
        return 'Rejected';
      case 'checked':
        return 'Received';
      default:
        return s;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(10.r)),
      child: Row(children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${deposit.amountDecimal} ${deposit.currency.toUpperCase()}',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 2.h),
              Text(
                deposit.type == 'coin_address'
                    ? '${deposit.network.toUpperCase()} · ${deposit.confirmations}/${deposit.requiredConfirmations > 0 ? deposit.requiredConfirmations : "?"} confirmations'
                    : 'Internal transfer',
                style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF), fontSize: 11.sp),
              ),
            ],
          ),
        ),
        Text(_label(deposit.status),
            style: GoogleFonts.inter(
                color: _statusColor(deposit.status),
                fontSize: 12.sp,
                fontWeight: FontWeight.w600)),
      ]),
    );
  }
}
