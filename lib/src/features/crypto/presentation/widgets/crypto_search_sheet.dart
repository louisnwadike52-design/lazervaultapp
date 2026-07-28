import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/utils/currency_formatter.dart';
import '../../domain/entities/crypto_entity.dart';

const _card = Color(0xFF1F1F1F);
const _bg = Color(0xFF0A0A0A);
const _divider = Color(0xFF2D2D2D);
const _sub = Color(0xFF9CA3AF);
const _accent = Color.fromARGB(255, 78, 3, 208);
const _green = Color(0xFF10B981);
const _red = Color(0xFFEF4444);

/// Search sheet over the Quidax-supported asset catalogue. Shows nothing until
/// the user types (no "popular" filler); each result taps through to the asset
/// detail page via [onSelect]. Purely local filtering over [assets].
Future<void> showCryptoSearchSheet(
  BuildContext context, {
  required List<Crypto> assets,
  required void Function(Crypto) onSelect,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _CryptoSearchSheet(assets: assets, onSelect: onSelect),
  );
}

class _CryptoSearchSheet extends StatefulWidget {
  final List<Crypto> assets;
  final void Function(Crypto) onSelect;
  const _CryptoSearchSheet({required this.assets, required this.onSelect});

  @override
  State<_CryptoSearchSheet> createState() => _CryptoSearchSheetState();
}

class _CryptoSearchSheetState extends State<_CryptoSearchSheet> {
  final _searchCtrl = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<Crypto> get _filtered {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return const [];
    // Rank exact-symbol and prefix matches ahead of substring matches.
    final results = widget.assets.where((c) {
      return c.name.toLowerCase().contains(q) || c.symbol.toLowerCase().contains(q);
    }).toList();
    results.sort((a, b) {
      int score(Crypto c) {
        final sym = c.symbol.toLowerCase();
        if (sym == q) return 0;
        if (sym.startsWith(q)) return 1;
        if (c.name.toLowerCase().startsWith(q)) return 2;
        return 3;
      }

      return score(a).compareTo(score(b));
    });
    return results;
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height * 0.88;
    final results = _filtered;
    return Container(
      height: h,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        children: [
          SizedBox(height: 12.h),
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: _divider,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 10.h),
            child: Row(
              children: [
                Text('Search crypto',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold)),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close_rounded, color: _sub, size: 22.sp),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextField(
              controller: _searchCtrl,
              autofocus: true,
              onChanged: (v) => setState(() => _query = v),
              style: _inter(14),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Search name or symbol',
                hintStyle: _inter(14, c: _sub),
                prefixIcon: Icon(Icons.search, color: _sub, size: 20.sp),
                suffixIcon: _query.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _searchCtrl.clear();
                          setState(() => _query = '');
                        },
                        child: Icon(Icons.close, color: _sub, size: 18.sp),
                      )
                    : null,
                filled: true,
                fillColor: _bg,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: _divider)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: _divider)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: _accent)),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Expanded(child: _body(results)),
        ],
      ),
    );
  }

  Widget _body(List<Crypto> results) {
    if (_query.trim().isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_rounded, color: _sub, size: 44.sp),
            SizedBox(height: 12.h),
            Text('Search Quidax-supported assets',
                style: _inter(14, c: Colors.white)),
            SizedBox(height: 6.h),
            Text('Start typing a name or symbol',
                style: _inter(12, c: _sub)),
          ],
        ),
      );
    }
    if (results.isEmpty) {
      return Center(
        child: Text('No assets match "$_query"', style: _inter(14, c: _sub)),
      );
    }
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: results.length,
      separatorBuilder: (_, __) =>
          Divider(height: 1, color: _divider.withValues(alpha: 0.4)),
      itemBuilder: (_, i) => _row(results[i]),
    );
  }

  Widget _row(Crypto c) {
    final up = c.priceChangePercentage24h >= 0;
    return ListTile(
      onTap: () {
        Navigator.pop(context); // close the search sheet first
        widget.onSelect(c);
      },
      contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
      leading: c.image.isNotEmpty
          ? CircleAvatar(
              radius: 18.r,
              backgroundColor: _divider,
              backgroundImage: NetworkImage(c.image))
          : CircleAvatar(
              radius: 18.r,
              backgroundColor: _accent.withValues(alpha: 0.15),
              child: Text(
                c.symbol.isNotEmpty ? c.symbol.substring(0, 1).toUpperCase() : '?',
                style: _inter(14, w: FontWeight.w700, c: _accent),
              ),
            ),
      title: Text(c.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: _inter(14, w: FontWeight.w600)),
      subtitle: Text(c.symbol.toUpperCase(), style: _inter(11, c: _sub)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (c.currentPrice > 0)
            Text(
              '${CurrencySymbols.currentSymbol}${c.currentPrice.toStringAsFixed(2)}',
              style: _inter(13, w: FontWeight.w600),
            ),
          if (c.priceChangePercentage24h != 0)
            Text(
              '${up ? '+' : ''}${c.priceChangePercentage24h.toStringAsFixed(2)}%',
              style: _inter(11, w: FontWeight.w500, c: up ? _green : _red),
            ),
        ],
      ),
    );
  }
}

TextStyle _inter(double size, {FontWeight w = FontWeight.w400, Color c = Colors.white}) =>
    GoogleFonts.inter(fontSize: size.sp, fontWeight: w, color: c);
