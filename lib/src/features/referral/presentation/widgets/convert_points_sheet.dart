import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/referral/domain/entities/redemption_entities.dart';
import 'package:lazervault/src/features/referral/domain/repositories/i_referral_repository.dart';
import 'package:lazervault/src/features/referral/presentation/screens/points_conversion_receipt_screen.dart';

/// Turning LazerPoints into money.
///
/// The screen showed a balance and a "Redeemed" figure but offered no way to
/// redeem anything, so the number was decorative. This is the part that makes
/// it real, and because it moves money it is deliberately explicit about what
/// the user is about to get before they commit.
class ConvertPointsSheet extends StatefulWidget {
  const ConvertPointsSheet({
    super.key,
    required this.repository,
    required this.currentBalance,
    this.onConverted,
  });

  final IReferralRepository repository;
  final int currentBalance;

  /// Fired after a successful conversion so the screen behind can refresh its
  /// balance rather than showing the pre-conversion figure.
  final VoidCallback? onConverted;

  @override
  State<ConvertPointsSheet> createState() => _ConvertPointsSheetState();
}

class _ConvertPointsSheetState extends State<ConvertPointsSheet> {
  static const _bg = Color(0xFF121212);
  static const _card = Color(0xFF1C1C1E);
  static const _border = Color(0xFF2A2A2C);
  static const _accent = Color(0xFF4E03D0);

  RedemptionQuoteEntity? _quote;
  bool _loading = true;
  bool _converting = false;
  String? _error;

  /// The idempotency key for this conversion attempt.
  ///
  /// Generated once per sheet, not per tap: if the first attempt times out and
  /// the user presses again, the same key means the server converts once. A
  /// fresh key per tap would convert twice.
  ///
  /// It is also PERSISTED, which the per-sheet version was not. A timeout is
  /// exactly when someone closes the sheet and reopens it to try again — and a
  /// reopened sheet used to mint a brand-new key, so the retry looked like a
  /// second conversion to the server and paid out twice. The key is cleared
  /// only once an attempt has definitively resolved.
  String? _idempotencyKey;

  static const _pendingKeyPref = 'lazerpoints.pending_conversion_key';

  @override
  void initState() {
    super.initState();
    _restoreOrCreateKey();
    _loadQuote();
  }

  Future<void> _restoreOrCreateKey() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final existing = prefs.getString(_pendingKeyPref);
      if (existing != null && existing.isNotEmpty) {
        // An attempt from a previous sheet never resolved. Reusing its key is
        // what makes this a RETRY rather than a second conversion.
        _idempotencyKey = existing;
        return;
      }
      final fresh = const Uuid().v4();
      await prefs.setString(_pendingKeyPref, fresh);
      _idempotencyKey = fresh;
    } catch (_) {
      // Storage unavailable. Fall back to an in-memory key: still correct
      // within this sheet, which is the behaviour this replaced, rather than
      // blocking a conversion because a preference could not be written.
      _idempotencyKey ??= const Uuid().v4();
    }
  }

  Future<void> _clearPendingKey() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_pendingKeyPref);
    } catch (_) {
      // Nothing to do: a stale key only ever causes a retry to be treated as
      // the same conversion, which is the safe direction.
    }
  }

  Future<void> _loadQuote() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    // 0 quotes the whole balance, which is what this sheet offers. Partial
    // conversion is deliberately not offered yet: a slider invites people to
    // leave dust behind for no benefit, and the common intent is "cash out".
    final res = await widget.repository.getRedemptionQuote(points: 0);
    if (!mounted) return;
    res.fold(
      (f) => setState(() {
        _error = f.message;
        _loading = false;
      }),
      (q) => setState(() {
        _quote = q;
        _loading = false;
      }),
    );
  }

  Future<void> _convert() async {
    final q = _quote;
    if (q == null || !q.canRedeem || _converting) return;

    // The key may still be loading from storage on a very fast tap. Awaiting it
    // rather than generating a throwaway is the whole point: a throwaway key is
    // a second conversion.
    if (_idempotencyKey == null) {
      await _restoreOrCreateKey();
      if (!mounted) return;
    }

    setState(() => _converting = true);
    final res = await widget.repository.redeemPoints(
      points: q.points,
      idempotencyKey: _idempotencyKey!,
    );
    if (!mounted) return;

    await res.fold(
      (f) async {
        // The key is deliberately KEPT. A failure here may be a timeout on a
        // conversion that actually succeeded, and reusing the key is what makes
        // the user's next attempt a retry rather than a second payout.
        setState(() => _converting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(f.message),
            backgroundColor: const Color(0xFFEF4444),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      (r) async {
        // Resolved, so the key has done its job and must not bind the NEXT
        // conversion — which would make a genuine second conversion silently
        // return the first one's result.
        await _clearPendingKey();
        if (!mounted) return;

        widget.onConverted?.call();
        Navigator.of(context).pop();

        // A receipt, not a toast. This is the moment a rewards balance someone
        // spent months building becomes money, and it was the only money
        // movement in the product with nothing to download, share or refer back
        // to afterwards.
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PointsConversionReceiptScreen(
              result: r,
              pointsPerMajorUnit: q.pointsPerMajorUnit,
            ),
          ),
        );
      },
    );
  }

  String _money(double v, String ccy) =>
      '${ccy == 'NGN' ? '₦' : '$ccy '}${NumberFormat('#,##0.00').format(v)}';

  String _points(int v) => NumberFormat('#,###').format(v);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: _border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 14.h),
            Text(
              'Convert to cash',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 16.h),
            _body(),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    if (_loading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 36.h),
        child: const Center(child: LazerVaultLoader.medium()),
      );
    }

    if (_error != null) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Column(
          children: [
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13.sp),
            ),
            SizedBox(height: 12.h),
            TextButton(onPressed: _loadQuote, child: const Text('Try again')),
          ],
        ),
      );
    }

    final q = _quote!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: _border),
          ),
          child: Column(
            children: [
              Text(
                'You get',
                style: GoogleFonts.inter(
                    color: Colors.grey[500], fontSize: 12.sp),
              ),
              SizedBox(height: 4.h),
              Text(
                _money(q.cashMajor, q.currency),
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'for ${_points(q.points)} points',
                style: GoogleFonts.inter(
                    color: Colors.grey[400], fontSize: 13.sp),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),

        // The rate, stated. A conversion screen that shows only an output makes
        // people reverse-engineer the rate to check it, and the arithmetic is
        // exactly what they are suspicious of.
        _line('Rate', '${_points(q.pointsPerMajorUnit)} points = ₦1'),
        if (q.points < widget.currentBalance)
          // Says where the rest went, unprompted. Points that do not divide
          // into a whole kobo stay on the balance — without this line that
          // looks like they vanished.
          _line(
            'Staying on your balance',
            '${_points(widget.currentBalance - q.points)} points',
          ),

        SizedBox(height: 18.h),

        if (!q.canRedeem)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                  color: const Color(0xFFF59E0B).withValues(alpha: 0.3)),
            ),
            child: Text(
              // The server's own words. It knows whether the balance is short,
              // the minimum is not met, or conversion is off — a generic
              // "unavailable" would hide which.
              q.reason.isNotEmpty
                  ? q.reason
                  : 'You cannot convert points right now.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  color: Colors.grey[300], fontSize: 12.5.sp),
            ),
          )
        else
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _converting ? null : _convert,
              style: ElevatedButton.styleFrom(
                backgroundColor: _accent,
                foregroundColor: Colors.white,
                disabledBackgroundColor: _accent.withValues(alpha: 0.4),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: _converting
                  // Disabled AND visibly busy: this moves money, and a button
                  // that still looks pressable invites a second tap while the
                  // first is in flight.
                  ? const LazerVaultLoader.small()
                  : Text(
                      'Convert ${_points(q.points)} points',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
      ],
    );
  }

  Widget _line(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  GoogleFonts.inter(color: Colors.grey[500], fontSize: 12.5.sp)),
          Text(value,
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
