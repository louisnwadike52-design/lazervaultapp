import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/grpc/crypto_grpc_client.dart';
import '../../../../generated/crypto.pb.dart' show QuidaxAssetNetwork;

/// Loads the enabled networks for [symbol], opens the shared picker, and — when
/// the user chooses one — provisions that chain's deposit address and marks it
/// the user's active network for the asset (Quidax keeps one unified balance, so
/// this only changes the receive/send chain, never a trade). Safe to call from
/// any screen (buy/sell/swap/receive). Returns the chosen network slug or null.
Future<String?> showNetworkPickerForAsset(
  BuildContext context, {
  required String symbol,
  String? selectedNetwork,
  bool depositOnly = false,
  bool withdrawOnly = false,
  String? title,
  String? subtitle,
}) async {
  final client = GetIt.I<CryptoGrpcClient>();
  final sym = symbol.toLowerCase();
  List<QuidaxAssetNetwork> nets = const [];
  String? active = selectedNetwork;
  try {
    final res = await client.getAssetNetworkStatus(currency: sym);
    if (active == null && res.activeNetwork.isNotEmpty) active = res.activeNetwork;
    nets = res.networks
        .where((e) =>
            (!depositOnly || e.network.depositEnabled) &&
            (!withdrawOnly || e.network.withdrawEnabled))
        .map((e) => e.network)
        .toList(growable: false);
  } catch (_) {
    // fall through with an empty list — the sheet renders its empty state.
  }
  if (!context.mounted) return null;
  final chosen = await showNetworkPickerSheet(
    context,
    currency: sym,
    networks: nets,
    selectedNetwork: active,
    title: title ?? 'Network for ${symbol.toUpperCase()}',
    subtitle: subtitle ??
        'Your balance is the same on every network. This sets the chain used to receive and send ${symbol.toUpperCase()}.',
  );
  if (chosen != null && chosen != active) {
    // Provision + set active. Best-effort; never blocks the caller.
    try {
      await client.ensureWalletAddress(currency: sym, network: chosen);
    } catch (_) {}
  }
  return chosen;
}

/// Shared, well styled network chooser used across buy, sell, send and swap so
/// every surface looks and behaves identically. Returns the chosen network slug
/// (e.g. `trc20`) or null when dismissed.
///
/// The caller supplies an already filtered list (deposit enabled for receive and
/// buy, withdraw enabled for send) so this widget stays purely presentational.
Future<String?> showNetworkPickerSheet(
  BuildContext context, {
  required String currency,
  required List<QuidaxAssetNetwork> networks,
  String? selectedNetwork,
  String title = 'Select network',
  String? subtitle,
}) {
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => _NetworkPickerSheet(
      currency: currency,
      networks: networks,
      selectedNetwork: selectedNetwork,
      title: title,
      subtitle: subtitle,
    ),
  );
}

class _NetworkPickerSheet extends StatelessWidget {
  final String currency;
  final List<QuidaxAssetNetwork> networks;
  final String? selectedNetwork;
  final String title;
  final String? subtitle;

  const _NetworkPickerSheet({
    required this.currency,
    required this.networks,
    required this.selectedNetwork,
    required this.title,
    this.subtitle,
  });

  String _label(QuidaxAssetNetwork n) =>
      n.networkName.isNotEmpty ? n.networkName : n.network.toUpperCase();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFF3D3D3D),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 18.h),
          Row(
            children: [
              Icon(Icons.lan_rounded,
                  size: 18.sp, color: const Color(0xFF93C5FD)),
              SizedBox(width: 8.w),
              Text(
                title,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          if (subtitle != null) ...[
            SizedBox(height: 6.h),
            Text(
              subtitle!,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
              ),
            ),
          ],
          SizedBox(height: 16.h),
          if (networks.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Text(
                'No network is available for this asset right now. Please try again later.',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                ),
              ),
            )
          else
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: networks.length,
                separatorBuilder: (_, __) => SizedBox(height: 10.h),
                itemBuilder: (_, i) {
                  final n = networks[i];
                  final selected = selectedNetwork != null &&
                      n.network.toLowerCase() ==
                          selectedNetwork!.toLowerCase();
                  return _NetworkRow(
                    label: _label(n),
                    slug: n.network.toUpperCase(),
                    isDefault: n.isDefault,
                    minDeposit: n.minDepositDecimal,
                    withdrawFee: n.withdrawFeeDecimal,
                    selected: selected,
                    onTap: () => Navigator.of(context).pop(n.network),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _NetworkRow extends StatelessWidget {
  final String label;
  final String slug;
  final bool isDefault;
  final String minDeposit;
  final String withdrawFee;
  final bool selected;
  final VoidCallback onTap;

  const _NetworkRow({
    required this.label,
    required this.slug,
    required this.isDefault,
    required this.minDeposit,
    required this.withdrawFee,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? const Color(0xFF3B82F6).withValues(alpha: 0.12)
          : const Color(0xFF0A0A0A),
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: selected
                  ? const Color(0xFF3B82F6).withValues(alpha: 0.55)
                  : const Color(0xFF2D2D2D),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 34.w,
                height: 34.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.lan_rounded,
                    size: 16.sp, color: const Color(0xFF93C5FD)),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            label,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (isDefault) ...[
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 1.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981)
                                  .withValues(alpha: 0.16),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              'Default',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF10B981),
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      slug,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (selected)
                Icon(Icons.check_circle_rounded,
                    size: 20.sp, color: const Color(0xFF3B82F6))
              else
                Icon(Icons.circle_outlined,
                    size: 20.sp, color: const Color(0xFF3D3D3D)),
            ],
          ),
        ),
      ),
    );
  }
}
