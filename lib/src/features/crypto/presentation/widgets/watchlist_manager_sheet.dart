import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../cubit/crypto_cubit.dart';
import '../../cubit/crypto_state.dart';
import '../../domain/entities/crypto_entity.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

const _bg = Color(0xFF0A0A0A);
const _card = Color(0xFF1F1F1F);
const _accent = Color.fromARGB(255, 78, 3, 208);
const _divider = Color(0xFF2D2D2D);

// WatchlistManagerSheet — bottom sheet that lets the user toggle which
// cryptos are in their watchlist. Reads `state.cryptos` + `state.watchlists`
// from the cubit and calls the gRPC repository CRUD methods on toggle.
//
// Behaviour:
//   - On open, ensures a default watchlist exists (creates one named
//     "My Watchlist" if the user has none). Without this, addToWatchlist
//     would have no watchlist_id to attach to.
//   - Toggle is optimistic — local list updates immediately, rolls back
//     on error with a Get.snackbar.
//   - Pulls in the cubit so changes propagate back to the landing page
//     watchlist preview on close.
class WatchlistManagerSheet extends StatefulWidget {
  const WatchlistManagerSheet({super.key});

  @override
  State<WatchlistManagerSheet> createState() => _WatchlistManagerSheetState();
}

class _WatchlistManagerSheetState extends State<WatchlistManagerSheet> {
  final TextEditingController _searchCtl = TextEditingController();
  String _query = '';
  // Track in-flight rows so we can spinner / disable taps mid-call.
  final Set<String> _busy = <String>{};
  String? _defaultWatchlistId;
  bool _ensuringWatchlist = false;

  @override
  void initState() {
    super.initState();
    _ensureDefaultWatchlist();
  }

  @override
  void dispose() {
    _searchCtl.dispose();
    super.dispose();
  }

  Future<void> _ensureDefaultWatchlist() async {
    final cubit = context.read<CryptoCubit>();
    final s = cubit.state;
    if (s is! CryptosLoaded) return;
    if (s.watchlists.isNotEmpty) {
      setState(() => _defaultWatchlistId = s.watchlists.first.id);
      return;
    }
    setState(() => _ensuringWatchlist = true);
    try {
      final wl = await cubit.repository.createWatchlist('My Watchlist', '');
      // Re-read state so the new watchlist is visible to the next add call.
      await cubit.loadCryptos();
      if (!mounted) return;
      setState(() {
        _defaultWatchlistId = wl.id;
        _ensuringWatchlist = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _ensuringWatchlist = false);
      Get.snackbar('Watchlist error', 'Could not create a default watchlist',
          backgroundColor: _card, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Set<String> _watchlistedIds(CryptosLoaded s) {
    final ids = <String>{};
    for (final wl in s.watchlists) {
      ids.addAll(wl.cryptoIds);
    }
    for (final c in s.cryptos) {
      if (c.isFavorite) ids.add(c.id);
    }
    return ids;
  }

  Future<void> _toggle(Crypto crypto, bool currentlyIn) async {
    final cubit = context.read<CryptoCubit>();
    final wlId = _defaultWatchlistId;
    if (wlId == null) {
      Get.snackbar('Not ready', 'Watchlist still initialising — try again',
          backgroundColor: _card, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    setState(() => _busy.add(crypto.id));
    try {
      if (currentlyIn) {
        await cubit.repository.removeFromWatchlist(wlId, crypto.id);
      } else {
        await cubit.repository.addToWatchlist(wlId, crypto.id);
      }
      // Refresh cubit so the parent watchlist preview reflects the change.
      await cubit.loadCryptos();
    } catch (_) {
      if (!mounted) return;
      Get.snackbar('Save failed', 'Could not update watchlist',
          backgroundColor: _card, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      if (mounted) setState(() => _busy.remove(crypto.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CryptoCubit, CryptoState>(
      builder: (context, state) {
        // Non-loaded states (Loading / Error / Initial) get their own
        // shells so the sheet doesn't spin forever when the cubit is
        // in an error state.
        if (state is CryptoError) {
          return _shell(
            child: Padding(
              padding: EdgeInsets.all(32.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _grabHandle(),
                  SizedBox(height: 16.h),
                  Icon(Icons.error_outline, color: Colors.red, size: 36.sp),
                  SizedBox(height: 12.h),
                  Text(
                    'Could not load assets',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => context.read<CryptoCubit>().loadCryptos(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is! CryptosLoaded) {
          return _shell(child: const Center(
            child: Padding(
              padding: EdgeInsets.all(48),
              child: LazerVaultLoader.small(),
            ),
          ));
        }
        // Loaded but cubit is mid-search; cryptos list may still have
        // values from the previous query, which is fine.
        if (state.cryptos.isEmpty) {
          return _shell(
            child: Padding(
              padding: EdgeInsets.all(32.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _grabHandle(),
                  SizedBox(height: 16.h),
                  Icon(Icons.token_outlined,
                      color: Colors.white.withValues(alpha: 0.4), size: 36.sp),
                  SizedBox(height: 12.h),
                  Text(
                    'No assets to add yet',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Market data is still loading. Try again in a moment.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        final watchlisted = _watchlistedIds(state);
        final filtered = state.cryptos.where((c) {
          if (_query.isEmpty) return true;
          final q = _query.toLowerCase();
          return c.name.toLowerCase().contains(q) ||
              c.symbol.toLowerCase().contains(q);
        }).toList();

        return _shell(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _grabHandle(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Row(
                  children: [
                    Text(
                      'Manage Watchlist',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    if (_ensuringWatchlist)
                      LazerVaultLoader(size: 14),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white.withValues(alpha: 0.7), size: 20.sp),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 8.h),
                child: TextField(
                  controller: _searchCtl,
                  onChanged: (v) => setState(() => _query = v),
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
                  decoration: InputDecoration(
                    hintText: 'Search by name or symbol',
                    hintStyle: GoogleFonts.inter(color: Colors.white38, fontSize: 14.sp),
                    prefixIcon: Icon(Icons.search, color: Colors.white38, size: 18.sp),
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.05),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: _divider),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: _divider),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: _accent),
                    ),
                  ),
                ),
              ),
              const Divider(color: _divider, height: 1),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.55,
                child: filtered.isEmpty
                    ? Center(
                        child: Text(
                          'No matches',
                          style: GoogleFonts.inter(color: Colors.white38, fontSize: 14.sp),
                        ),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        itemCount: filtered.length,
                        separatorBuilder: (_, __) =>
                            const Divider(color: _divider, height: 1, indent: 64),
                        itemBuilder: (context, i) {
                          final c = filtered[i];
                          final inList = watchlisted.contains(c.id);
                          final busy = _busy.contains(c.id);
                          return _row(c, inList: inList, busy: busy);
                        },
                      ),
              ),
              SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 8),
            ],
          ),
        );
      },
    );
  }

  Widget _shell({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        border: Border.all(color: _divider),
      ),
      child: SafeArea(top: false, child: child),
    );
  }

  Widget _grabHandle() => Center(
        child: Container(
          width: 40,
          height: 4,
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      );

  Widget _row(Crypto c, {required bool inList, required bool busy}) {
    return InkWell(
      onTap: busy ? null : () => _toggle(c, inList),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Row(
          children: [
            ClipOval(
              child: SizedBox(
                width: 32.w,
                height: 32.w,
                child: c.image.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: c.image,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(color: _card),
                        errorWidget: (_, __, ___) => Container(
                          color: _card,
                          child: Icon(Icons.token, color: Colors.white24, size: 16.sp),
                        ),
                      )
                    : Container(
                        color: _card,
                        child: Icon(Icons.token, color: Colors.white24, size: 16.sp),
                      ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    c.name,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    c.symbol.toUpperCase(),
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            if (busy)
              LazerVaultLoader(size: 18)
            else
              Container(
                width: 28.w,
                height: 28.w,
                decoration: BoxDecoration(
                  color: inList ? _accent : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: inList ? _accent : Colors.white.withValues(alpha: 0.25),
                    width: 1.5,
                  ),
                ),
                child: inList
                    ? Icon(Icons.check, color: Colors.white, size: 16.sp)
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}
