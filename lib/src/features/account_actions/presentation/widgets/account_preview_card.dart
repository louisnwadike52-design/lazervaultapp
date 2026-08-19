import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable account/card preview shown at the top of the account-actions bottom
/// sheet (and anywhere a "card" needs to be previewed with live status).
///
/// Renders like an actual payment card — chip, masked number, holder, brand,
/// and the current balances. When [isFrozen] flips true the card performs a
/// smart 3D back-flip into a frosted, blurred "Frozen" face; flipping back to
/// false rotates it forward again. Balances stay readable in BOTH states — the
/// frozen face re-surfaces the available balance clearly on top of the frost so
/// the user always sees their money as of now.
class AccountPreviewCard extends StatefulWidget {
  final Map<String, dynamic> accountArgs;
  final String currencySymbol;

  /// Whether the card is frozen. When null we derive it from
  /// `accountArgs['status']` so existing call-sites keep working; callers that
  /// want live freeze/unfreeze animation should pass this explicitly.
  final bool? isFrozen;

  const AccountPreviewCard({
    super.key,
    required this.accountArgs,
    required this.currencySymbol,
    this.isFrozen,
  });

  @override
  State<AccountPreviewCard> createState() => _AccountPreviewCardState();
}

class _AccountPreviewCardState extends State<AccountPreviewCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _flip;
  late final Animation<double> _curved;

  bool get _frozen =>
      widget.isFrozen ??
      _statusIsFrozen((widget.accountArgs['status'] as String?) ?? 'active');

  static bool _statusIsFrozen(String status) {
    switch (status.toLowerCase()) {
      case 'frozen':
      case 'blocked_temporary':
      case 'blocked_permanent':
      case 'blocked_stolen':
        return true;
      default:
        return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _flip = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 620),
      value: _frozen ? 1.0 : 0.0,
    );
    // A gentle overshoot on the way in reads as the card "settling" into its
    // frozen state; plain ease on the way back out.
    _curved = CurvedAnimation(
      parent: _flip,
      curve: Curves.easeInOutCubic,
      reverseCurve: Curves.easeInOutCubic,
    );
  }

  @override
  void didUpdateWidget(covariant AccountPreviewCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_frozen && _flip.status != AnimationStatus.completed) {
      _flip.forward();
    } else if (!_frozen && _flip.status != AnimationStatus.dismissed) {
      _flip.reverse();
    }
  }

  @override
  void dispose() {
    _flip.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _curved,
      builder: (context, _) {
        final t = _curved.value; // 0 (front/active) → 1 (back/frozen)
        final angle = t * math.pi; // 0 → 180°
        final showBack = angle > math.pi / 2;

        // Perspective + Y rotation for the flip.
        final transform = Matrix4.identity()
          ..setEntry(3, 2, 0.0011)
          ..rotateY(angle);

        return Transform(
          alignment: Alignment.center,
          transform: transform,
          child: showBack
              // Counter-rotate the back face so its content isn't mirrored.
              ? Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateY(math.pi),
                  child: _buildFrozenFace(t),
                )
              : _buildActiveFace(),
        );
      },
    );
  }

  // ── Data helpers ──────────────────────────────────────────────────────────

  double get _balance => (widget.accountArgs['balance'] as double?) ?? 0.0;
  double get _available =>
      (widget.accountArgs['availableBalance'] as double?) ?? _balance;
  double get _reserved =>
      (widget.accountArgs['reservedBalance'] as double?) ?? 0.0;
  String get _accountType =>
      (widget.accountArgs['accountType'] as String?) ?? 'Personal';

  /// Real account-holder name for the card face. Prefers an explicit
  /// `holderName`, then the provisioned `accountName` (NUBAN holder). Returns
  /// an empty string when neither is set — the card face then simply shows no
  /// holder rather than a mock ("LAZERVAULT") or the account type.
  String get _holderName {
    final holder = (widget.accountArgs['holderName'] as String?)?.trim();
    if (holder != null && holder.isNotEmpty) return holder;
    final name = (widget.accountArgs['accountName'] as String?)?.trim();
    if (name != null && name.isNotEmpty) return name;
    return '';
  }

  String get _money => '${widget.currencySymbol}${_available.toStringAsFixed(2)}';

  /// Currencies for which a real deposit account (bank-transfer number) can be
  /// issued: NGN today (Flutterwave v3), and GHS/KES/ZAR via v4 once enabled on
  /// the account. Any other currency (e.g. USD/GBP) has NO deposit number — it is
  /// funded by CONVERTING from another wallet, so we show that state rather than a
  /// perpetual "being set up".
  static const Set<String> _depositCapableCurrencies = {'NGN', 'GHS', 'KES', 'ZAR'};

  String get _currency =>
      ((widget.accountArgs['currency'] as String?) ?? '').trim().toUpperCase();

  /// True when this wallet's currency can never receive a direct deposit number,
  /// so it's funded by conversion (USD/GBP today).
  bool get _isConvertOnly =>
      _currency.isNotEmpty && !_depositCapableCurrencies.contains(_currency);

  /// True when a REAL provisioned deposit number is present (not masked/partial).
  bool get _hasRealNumber {
    final raw = (widget.accountArgs['accountNumber'] as String?) ?? '';
    if (raw.contains('•')) return false;
    return raw.replaceAll(RegExp(r'[^0-9]'), '').length >= 6;
  }

  /// FULL account number for the account-details face — this is where the user
  /// reads/copies their real deposit NUBAN, so it is never masked. Shows a
  /// "being set up" placeholder only while the account is un-provisioned (no
  /// real number yet). Digits are lightly grouped for readability.
  String get _fullNumber {
    final raw = (widget.accountArgs['accountNumber'] as String?) ?? '';
    // A masked placeholder ("•••• 1234") or a too-short value is NOT a real
    // deposit number — show the un-provisioned state instead of a partial number.
    if (raw.contains('•')) return 'Being set up…';
    final digits = raw.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length < 6) return 'Being set up…';
    // Group in 3s for readability without altering the value (e.g. 9954855797
    // → "995 485 5797"); the exact digits are preserved.
    final buf = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buf.write(' ');
      buf.write(digits[i]);
    }
    return buf.toString();
  }

  /// The deposit bank name EXACTLY as the provider returned it (empty until the
  /// account is provisioned). Shown on the card face in place of a brand label —
  /// a bank account card should carry the bank, not the app name.
  String get _bankName =>
      (widget.accountArgs['bankName'] as String?)?.trim() ?? '';

  List<Color> get _activeGradient {
    switch (_accountType.toLowerCase()) {
      case 'savings':
        return const [Color(0xFF0EA5E9), Color(0xFF2563EB)];
      case 'investment':
        return const [Color(0xFF059669), Color(0xFF0D9488)];
      case 'family':
        return const [Color(0xFF7C3AED), Color(0xFF4F46E5)];
      case 'business':
        return const [Color(0xFF9333EA), Color(0xFF4E03D0)];
      default:
        return const [Color(0xFF4E03D0), Color(0xFF4F46E5)];
    }
  }

  // ── Active (front) face ───────────────────────────────────────────────────

  Widget _buildActiveFace() {
    return _cardShell(
      gradient: _activeGradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  _formatAccountType(_accountType),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              _statusPill(active: true),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            _isConvertOnly && !_hasRealNumber ? 'Funding' : 'Account number',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.6,
            ),
          ),
          SizedBox(height: 4.h),
          if (_isConvertOnly && !_hasRealNumber)
            // No bank-transfer number exists for this currency (e.g. USD/GBP) —
            // it's funded by converting from another wallet, not by a deposit.
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.swap_horiz_rounded,
                    color: Colors.white.withValues(alpha: 0.9), size: 18.sp),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    'Fund by converting from another wallet',
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.95),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            )
          else
            Text(
              _fullNumber,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.95),
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.0,
              ),
            ),
          SizedBox(height: 14.h),
          _balanceBlock(labelColor: Colors.white.withValues(alpha: 0.65)),
          SizedBox(height: 4.h),
          _secondaryBalances(),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Real NUBAN holder name (provider value) — NOT a mock and NOT the
              // account type. Blank until the backend provisions it.
              Expanded(
                flex: 3,
                child: Text(
                  _holderName.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              // The deposit bank (provider value) sits where a card would carry
              // its network/bank mark — never the app's own name.
              Flexible(
                flex: 2,
                child: Text(
                  _bankName,
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Frozen (back) face — blurred, frosted, balance still visible ──────────

  Widget _buildFrozenFace(double t) {
    // Blur ramps up with the flip so the card visibly "frosts over".
    final blur = 8.0 * t.clamp(0.0, 1.0);
    return _cardShell(
      gradient: const [Color(0xFF1E3A5F), Color(0xFF334155)],
      child: Stack(
        children: [
          // Faint underlying card art (blurred) so it reads as the same card.
          Positioned.fill(
            child: Opacity(
              opacity: 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),
                  _chip(),
                  SizedBox(height: 14.h),
                  Text(
                    _fullNumber,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 15.sp,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Frost pane: blur + cold white wash over the whole card.
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18.r),
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.10 * t),
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                ),
              ),
            ),
          ),
          // Foreground: Frozen badge (centre) + clear balance (never blurred).
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _formatAccountType(_accountType),
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  _statusPill(active: false),
                ],
              ),
              const Spacer(),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.white.withValues(alpha: 0.35)),
                      ),
                      child: Icon(Icons.ac_unit_rounded,
                          color: Colors.white, size: 22.sp),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Frozen',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Spending is paused',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Balance stays legible even while frozen. A small bottom gap keeps
              // the balance items off the card's bottom edge so they align with
              // the active face's rhythm rather than sitting flush.
              _balanceBlock(labelColor: Colors.white.withValues(alpha: 0.7)),
              SizedBox(height: 4.h),
              _secondaryBalances(),
              SizedBox(height: 6.h),
            ],
          ),
        ],
      ),
    );
  }

  // ── Shared building blocks ────────────────────────────────────────────────

  Widget _cardShell({required List<Color> gradient, required Widget child}) {
    return Container(
      width: double.infinity,
      // Fixed height so (a) both faces are identical size for a clean flip and
      // (b) the frozen face's Spacers have a bounded parent to centre against.
      height: 238.h,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: gradient.last.withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _chip() {
    return Container(
      width: 38.w,
      height: 28.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE7C873), Color(0xFFB8891F)],
        ),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Center(
        child: Container(
          width: 22.w,
          height: 14.h,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black.withValues(alpha: 0.25), width: 0.8),
            borderRadius: BorderRadius.circular(3.r),
          ),
        ),
      ),
    );
  }

  Widget _statusPill({required bool active}) {
    final color = active ? const Color(0xFF10B981) : const Color(0xFF93C5FD);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(active ? Icons.circle : Icons.ac_unit_rounded,
              color: color, size: active ? 7.sp : 11.sp),
          SizedBox(width: 5.w),
          Text(
            active ? 'Active' : 'Frozen',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// Primary balance (available) — big, always shown.
  Widget _balanceBlock({required Color labelColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available balance',
          style: TextStyle(color: labelColor, fontSize: 10.sp),
        ),
        SizedBox(height: 2.h),
        Text(
          _money,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  /// Compact secondary line: total + held/reserved, so no balance info is lost
  /// even in the card-style layout (shown in both active and frozen faces).
  Widget _secondaryBalances() {
    final parts = <String>[
      'Total ${widget.currencySymbol}${_balance.toStringAsFixed(2)}',
      if (_reserved > 0.01)
        'Held ${widget.currencySymbol}${_reserved.toStringAsFixed(2)}',
    ];
    return Text(
      parts.join('   •   '),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.white.withValues(alpha: 0.7),
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  String _formatAccountType(String type) {
    switch (type.toLowerCase()) {
      case 'personal':
        return 'Personal Account';
      case 'savings':
        return 'Savings Account';
      case 'investment':
        return 'Investment Account';
      case 'family':
        return 'Family & Friends';
      case 'business':
        return 'Business Account';
      default:
        return 'Account';
    }
  }
}
