import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/grpc/crypto_grpc_client.dart';
import '../../../../generated/crypto.pb.dart'
    show GetAssetNetworkStatusResponse, AssetNetworkStatusEntry, QuidaxAssetNetwork;
import 'crypto_shimmer_loading.dart';

/// A well styled chip that shows the network a held asset lives on, plus a
/// "+N" when the asset is available on more networks. Quidax keeps one unified
/// balance per currency, so this reflects the networks the user can receive and
/// send the asset on, with one marked active.
///
/// Self contained: on mount it lazily fetches the per asset network status via
/// the crypto client, so dropping it into an accordion that only mounts on
/// expand gives free lazy loading. It shimmers while the fetch is in flight and
/// renders nothing when the user does not hold the asset. Because it fetches
/// directly (no Bloc dependency) it is safe inside modal bottom sheets that do
/// not inherit the crypto cubit provider.
class AssetNetworkBadge extends StatefulWidget {
  final String symbol;

  /// Compact removes the leading "Network" label for tight spots like the
  /// accordion row or the detail header.
  final bool compact;

  /// Use the on gradient shimmer palette when the badge sits on a coloured card.
  final bool onGradient;

  /// When the caller already knows the user holds this asset (e.g. the sell
  /// screen renders from a holding), pass true so the badge shows even if the
  /// server side mirror balance lags.
  final bool heldHint;

  /// Optional tap handler, e.g. to open the network picker sheet.
  final VoidCallback? onTap;

  const AssetNetworkBadge({
    super.key,
    required this.symbol,
    this.compact = false,
    this.onGradient = false,
    this.heldHint = false,
    this.onTap,
  });

  @override
  State<AssetNetworkBadge> createState() => _AssetNetworkBadgeState();
}

class _AssetNetworkBadgeState extends State<AssetNetworkBadge> {
  GetAssetNetworkStatusResponse? _status;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant AssetNetworkBadge old) {
    super.didUpdateWidget(old);
    if (old.symbol.toLowerCase() != widget.symbol.toLowerCase()) {
      _load();
    }
  }

  Future<void> _load() async {
    final sym = widget.symbol.trim().toLowerCase();
    if (sym.isEmpty) {
      setState(() => _loading = false);
      return;
    }
    setState(() => _loading = true);
    try {
      final res = await GetIt.I<CryptoGrpcClient>()
          .getAssetNetworkStatus(currency: sym);
      if (!mounted) return;
      setState(() {
        _status = res;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  String _label(QuidaxAssetNetwork n) =>
      n.networkName.isNotEmpty ? n.networkName : n.network.toUpperCase();

  AssetNetworkStatusEntry? _activeEntry(GetAssetNetworkStatusResponse st) {
    if (st.networks.isEmpty) return null;
    for (final e in st.networks) {
      if (e.active) return e;
    }
    for (final e in st.networks) {
      if (e.network.isDefault) return e;
    }
    return st.networks.first;
  }

  @override
  Widget build(BuildContext context) {
    final st = _status;
    if (st == null) {
      if (_loading) {
        return CryptoSkeleton(
          width: 92.w,
          height: 24.h,
          radius: 12.r,
          onGradient: widget.onGradient,
        );
      }
      return const SizedBox.shrink();
    }

    final held = widget.heldHint || st.held;
    if (!held) return const SizedBox.shrink();

    final active = _activeEntry(st);
    if (active == null) return const SizedBox.shrink();

    final enabledCount = st.networks
        .where((e) => e.network.depositEnabled || e.network.withdrawEnabled)
        .length;
    final extra = enabledCount > 1 ? enabledCount - 1 : 0;

    final chip = Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6).withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF3B82F6).withValues(alpha: 0.40),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.lan_rounded, size: 13.sp, color: const Color(0xFF93C5FD)),
          SizedBox(width: 5.w),
          if (!widget.compact) ...[
            Text(
              'Network',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 5.w),
          ],
          Text(
            _label(active.network),
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (extra > 0) ...[
            SizedBox(width: 5.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                '+$extra',
                style: GoogleFonts.inter(
                  color: const Color(0xFF93C5FD),
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
          if (widget.onTap != null) ...[
            SizedBox(width: 4.w),
            Icon(Icons.keyboard_arrow_down_rounded,
                size: 14.sp, color: const Color(0xFF9CA3AF)),
          ],
        ],
      ),
    );

    if (widget.onTap == null) return chip;
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: chip,
    );
  }
}
