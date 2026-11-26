import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/services/active_account_snapshot.dart';
import 'package:lazervault/src/features/crypto_pay/domain/pay_source.dart';
import 'package:lazervault/src/features/crypto_pay/presentation/pay_with_crypto_sheet.dart';

/// The `Fiat | Crypto` choice, in the shape the recipient screen already uses
/// for `Bank | Lazervault user`.
///
/// WHY A SEGMENTED CONTROL AND NOT A CHECKBOX BY THE PIN. The operator asked
/// for it to be explicit without taking space, and this is the gesture the
/// same screen already teaches one row above. It also makes the state
/// impossible to miss: a checkbox near a PIN pad is read as consent to
/// something, and the one thing this must never be is accidental.
///
/// FIAT IS ALWAYS PRESELECTED. Choosing to sell crypto is a decision; paying
/// from the wallet is the default and stays the default on every entry, even
/// when the customer chose crypto last time.
///
/// HIDES ITSELF ENTIRELY when the gate is off or the feature is unavailable —
/// rather than showing a disabled control, which invites "why can't I tap
/// this" and tells every user about a feature most of them cannot use.
class PayWithCryptoSelector extends StatelessWidget {
  const PayWithCryptoSelector({
    super.key,
    required this.value,
    required this.onChanged,
    required this.amountMinor,
    this.walletBalanceMinor,
    this.email,
    this.userId,
    this.enabled = true,
    required this.onDarkSurface,
  });

  /// The current source. Fiat unless the customer has chosen otherwise.
  final PaySource value;

  final ValueChanged<PaySource> onChanged;

  /// What the payment will cost, in minor units — passed to the sheet so it
  /// can show what each holding is worth against this amount.
  final int amountMinor;

  /// What the wallet already holds, in minor units.
  ///
  /// Carried so the sheet asks of each coin only what is MISSING: the default
  /// funding mode spends the naira first and converts the difference, and a
  /// sheet that does not know the balance has to assume the whole payment,
  /// which hides coins that would in fact have worked.
  ///
  /// Left null, the ACTIVE account's spendable balance is resolved here — see
  /// `_walletBalanceMinor`. Pass it explicitly only on a screen that debits
  /// an account other than the active one.
  final int? walletBalanceMinor;

  /// Resolves what the wallet contributes, preferring an explicit figure.
  ///
  /// WHY IT IS RESOLVED HERE RATHER THAN AT SEVEN CALL SITES. The selector
  /// appears on both Send Funds flows and five bill quick-buy sheets, and
  /// only the Send Funds screens have a balance in scope. Resolving it once,
  /// through `activeAccountSnapshot()` — the accessor that reads the live
  /// cards summaries rather than `AccountManager.activeAccountDetails`, which
  /// is always null and silently gave eighteen other places "₦0" — means
  /// every surface combines wallet and crypto correctly instead of only the
  /// two that happened to have the number.
  ///
  /// Null when it genuinely cannot be resolved (summaries not loaded yet, no
  /// active account). The sheet then assumes the whole payment, which only
  /// hides a coin that would have worked — never the reverse.
  int? get _walletBalanceMinor {
    if (walletBalanceMinor != null) return walletBalanceMinor;
    final snap = activeAccountSnapshot();
    if (snap == null || !snap.isSpendable || snap.isProvisioning) return null;
    if (snap.balanceMajor <= 0) return 0;
    return (snap.balanceMajor * 100).round();
  }

  /// The signed-in email, for the whitelist override.
  final String? email;

  /// The signed-in user id — the identifier to PREFER in the pilot whitelist,
  /// because a digest of a random UUID is genuinely opaque while a digest of
  /// an email address only hides the list, not a name someone already
  /// suspects.
  final String? userId;

  /// False while a payment is already in flight. The control stays visible so
  /// the customer can see what they chose, but cannot change it underneath a
  /// request that has already been sent.
  final bool enabled;

  /// Whether this row is painted on a DARK surface.
  ///
  /// REQUIRED, AND DELIBERATELY NOT INFERRED. The row appears on two kinds of
  /// surface: the bill quick-buy sheets are near-black (#0A0A0A) and the
  /// send-funds amount sheet is white. The colours were hardcoded for the
  /// dark one, so on the white sheet "Pay with" was #E5E7EB on #FFFFFF —
  /// barely there — and the icon was a pale violet that read as a disabled
  /// control sitting between two perfectly solid rows.
  ///
  /// `Theme.of(context).brightness` cannot answer this: both surfaces live
  /// under the same app theme, and a white sheet inside it reports exactly
  /// what a dark page does. So the caller states it, and a new call site has
  /// to make the choice rather than inherit a default that happens to be
  /// wrong half the time.
  final bool onDarkSurface;

  /// The accent: the icon, the badge, the pill's text and chevron.
  ///
  /// On light this is the same deep purple the neighbouring Category and
  /// Schedule rows use, because the operator's requirement is literally that
  /// it match them.
  Color get _brand =>
      onDarkSurface ? _brandOnDark : const Color.fromARGB(255, 78, 3, 208);

  /// The "Pay with" label — matched to the sibling rows' heading colour.
  Color get _label => onDarkSurface ? _labelOnDark : const Color(0xFF111827);

  // THE ROW, THE DIALOG, THE SHEET — in that order.
  //
  // This used to be a two-segment `Wallet | Crypto` control sitting in the
  // middle of the form. It read as a pair of buttons competing with the
  // primary action, and on the bill sheets it was a second full-width control
  // directly above the pay button. The operator asked for it to match the
  // Category and Schedule rows it sits beside: a label with a pill on the
  // right, which opens a dialog.
  //
  // WHY A DIALOG AND THEN A SHEET, rather than one list of coins. Choosing to
  // sell crypto is a different decision from choosing WHICH coin, and merging
  // them puts a list of balances in front of somebody who only wanted to pay
  // from their wallet. The dialog answers "where does this money come from";
  // the sheet, only if it is needed, answers "which coin".
  //
  // FIAT REMAINS THE DEFAULT on every entry, including after a dismissed
  // sheet — backing out of choosing a coin has chosen nothing, and leaving
  // the source on "Crypto" with no asset would send a request that cannot be
  // priced.
  @override
  Widget build(BuildContext context) {
    if (!FeatureFlags.payWithCryptoAvailable(email: email, userId: userId)) {
      return const SizedBox.shrink();
    }

    return InkWell(
      onTap: enabled ? () => _openSourceDialog(context) : null,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            Icon(
              value.isCrypto
                  ? Icons.currency_bitcoin
                  : Icons.account_balance_wallet_outlined,
              size: 18.sp,
              color: _brand,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      'Pay with',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: _label,
                      ),
                    ),
                  ),
                  // SAYS THE OPTION EXISTS, once, and only while it is not
                  // already taken. Alongside the pill it would be repeating
                  // what the pill already states.
                  if (!value.isCrypto) ...[
                    SizedBox(width: 6.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 6.w, vertical: 1.5.h),
                      decoration: BoxDecoration(
                        color: _brand.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                      child: Text(
                        'Crypto available',
                        style: GoogleFonts.inter(
                          fontSize: 9.5.sp,
                          fontWeight: FontWeight.w700,
                          color: _brand,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: 8.w),
            // The pill, pinned to the right edge exactly as the Category and
            // Schedule rows pin theirs — it is the last child, so its right
            // edge IS the row's right edge.
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 170.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: _brand.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: _brand.withValues(alpha: 0.15)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        // Names the chosen coin once picked, so the customer
                        // can see WHICH asset will be sold without reopening
                        // anything.
                        value.label,
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w600,
                          color: _brand,
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Icon(Icons.keyboard_arrow_down_rounded,
                        size: 16.sp, color: _brand),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// THE BRAND VIOLET, FOR THE NEAR-BLACK PAGES THIS ROW SITS ON.
  ///
  /// It was #4E03D0 — the deep brand purple, which is correct on the WHITE
  /// surfaces further down this file (the source dialog, the coin sheet) and
  /// is a dark purple on near-black here. The bill and send-funds pages are
  /// #0A0A0A, so the icon, the "Crypto available" badge and the pill's own
  /// text and chevron were all present and all but unreadable: the feature
  /// read as switched off.
  ///
  /// #A78BFA is the violet this app already uses as an accent on a dark
  /// surface, so the row reads as part of the page rather than as a new
  /// colour. A SEPARATE token rather than a change to the shared one, because
  /// the dialog's selected state is painted on white and a pale violet there
  /// would be the same mistake inverted.
  static const Color _brandOnDark = Color(0xFFA78BFA);

  /// The row's label colour.
  ///
  /// It was #111827 — the near-black used for a heading on a white card —
  /// which on this page is black text on black. "Pay with" was effectively
  /// invisible, leaving a badge and a pill with nothing naming them.
  static const Color _labelOnDark = Color(0xFFE5E7EB);

  /// Where the money comes from. Two options, wallet first.
  Future<void> _openSourceDialog(BuildContext context) async {
    final chose = await showDialog<bool>(
      context: context,
      builder: (ctx) => _PaySourceDialog(
        current: value,
        walletBalanceMinor: _walletBalanceMinor,
      ),
    );
    if (chose == null) return; // dismissed: nothing chosen, nothing changes

    if (!chose) {
      onChanged(PaySource.wallet);
      return;
    }

    // Crypto. The coin is a SECOND decision and gets its own sheet.
    if (!context.mounted) return;
    final picked = await PayWithCryptoSheet.open(
      context,
      amountMinor: amountMinor,
      walletBalanceMinor: _walletBalanceMinor,
      current: value.isCrypto ? value.asset : null,
    );
    // A DISMISSED SHEET MUST NOT LEAVE THE SOURCE ON CRYPTO. Backing out of
    // choosing a coin has chosen nothing; the previous source stands.
    if (picked == null) return;
    onChanged(picked);
  }
}

/// "Where should this come from?" — wallet or crypto, and nothing else.
///
/// Deliberately NOT a list of coins. Somebody paying from their wallet should
/// not have to read their crypto balances to say so, and somebody paying with
/// crypto has two decisions to make, not one.
class _PaySourceDialog extends StatelessWidget {
  const _PaySourceDialog({
    required this.current,
    required this.walletBalanceMinor,
  });

  final PaySource current;
  final int? walletBalanceMinor;

  static const Color _brand = Color.fromARGB(255, 78, 3, 208);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 14.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pay with',
                style: GoogleFonts.inter(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF111827))),
            SizedBox(height: 4.h),
            Text(
              'Choose where this payment comes from.',
              style: GoogleFonts.inter(
                  fontSize: 12.5.sp, color: const Color(0xFF6B7280)),
            ),
            SizedBox(height: 16.h),
            _option(
              context,
              selected: !current.isCrypto,
              icon: Icons.account_balance_wallet_outlined,
              title: 'Wallet',
              // The balance is the whole reason somebody picks this one, so
              // it is on the row rather than a tap away.
              subtitle: walletBalanceMinor == null
                  ? 'Your Lazervault balance'
                  : 'Balance ${_naira(walletBalanceMinor!)}',
              onTap: () => Navigator.of(context).pop(false),
            ),
            SizedBox(height: 10.h),
            _option(
              context,
              selected: current.isCrypto,
              icon: Icons.currency_bitcoin,
              title: current.isCrypto ? current.label : 'Crypto',
              subtitle: 'Convert a coin to cover this payment',
              onTap: () => Navigator.of(context).pop(true),
            ),
            SizedBox(height: 6.h),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel',
                    style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF6B7280))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _naira(int minor) {
    final major = minor / 100.0;
    return '₦${major.toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+\.)'),
          (m) => '${m[1]},',
        )}';
  }

  Widget _option(
    BuildContext context, {
    required bool selected,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
        decoration: BoxDecoration(
          color: selected ? _brand.withValues(alpha: 0.06) : Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: selected ? _brand : const Color(0xFFE5E7EB),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20.sp, color: _brand),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF111827))),
                  SizedBox(height: 2.h),
                  Text(subtitle,
                      style: GoogleFonts.inter(
                          fontSize: 11.5.sp, color: const Color(0xFF6B7280))),
                ],
              ),
            ),
            // A tick rather than a radio: the row is already a button, and a
            // radio invites a second tap to "confirm" a choice that is made.
            Icon(
              selected
                  ? Icons.check_circle_rounded
                  : Icons.chevron_right_rounded,
              size: 20.sp,
              color: selected ? _brand : const Color(0xFF9CA3AF),
            ),
          ],
        ),
      ),
    );
  }
}
