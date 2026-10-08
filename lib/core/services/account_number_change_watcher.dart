import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'account_details_sheet_opener.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';

/// Tells a user, on the dashboard, that their deposit account number changed.
///
/// WHY THIS EXISTS ALONGSIDE AccountUpdateAnnouncementService. That one is
/// admin-authored: someone publishes `announce_va_migration` after a migration
/// batch and every user sees the same broadcast text once. It depends on an
/// admin remembering, it goes to everyone including users whose number never
/// moved, and it cannot show anyone their actual new number.
///
/// This watcher is the opposite: it fires only for the user whose number
/// ACTUALLY changed, at the moment they next open the dashboard, and shows the
/// real old and new values. Switching the virtual-account provider from the
/// admin dashboard is now enough on its own — accounts re-point or mint lazily
/// at login, and this is what closes the loop with the customer, who otherwise
/// finds out by having a deposit sent to a number that no longer exists.
///
/// It is entirely client side by design. The change is detected by comparing
/// what the server reports now against what this device last saw, so it needs
/// no new endpoint, no settings key and no server-side per-user state.
class AccountNumberChangeWatcher {
  AccountNumberChangeWatcher._();
  static final AccountNumberChangeWatcher instance =
      AccountNumberChangeWatcher._();

  /// Last account number this device saw for a given user+account.
  static String _key(String userId, String accountId) =>
      'acct_number_seen_${userId}_$accountId';

  /// Suppresses repeat modals within one app session. Scoped to the user who
  /// saw it: on this device a second account can sign in without inheriting
  /// the first user's suppression and silently missing their own change.
  String? _shownForUserId;

  /// Compares [accounts] against what was last seen and, on a real change,
  /// shows one modal describing it.
  ///
  /// Best effort end to end: any failure leaves the baseline untouched so the
  /// change is simply reported on a later load rather than lost.
  /// Returns true when a modal was shown, so the caller can stand the broadcast
  /// announcement down rather than stacking a second dialog on top of this one.
  Future<bool> check(
    BuildContext context, {
    required String userId,
    required List<AccountSummaryEntity> accounts,
  }) async {
    if (userId.isEmpty || accounts.isEmpty) return false;
    // One announcement per user per app session. A provider switch can move
    // several accounts at once and a stack of modals would be worse than one.
    if (_shownForUserId == userId) return false;

    try {
      final prefs = await SharedPreferences.getInstance();
      final changes = <_AccountNumberChange>[];

      for (final a in accounts) {
        final currentNumber = (a.accountNumber ?? '').trim();
        if (currentNumber.isEmpty) continue;

        final currentBank = (a.bankName ?? '').trim();
        final currentHolder = (a.virtualAccountHolderName ?? '').trim();

        final id = a.id.toString();
        final key = _key(userId, id);
        final previousRaw = prefs.getString(key);

        if (previousRaw == null) {
          await prefs.setString(
              key, snapshotFor(currentNumber, currentBank, currentHolder));
          continue;
        }

        // The baseline used to be the bare account number, so an existing
        // install has a plain number stored here. Parsed leniently: an old
        // baseline yields an unknown bank and holder, which are then treated as
        // "not changed" rather than announcing a change that may not have
        // happened. Those fields become comparable from the next load onward.
        final prev = parseSnapshot(previousRaw);

        final numberMoved = prev.number != currentNumber;
        final bankMoved = prev.bank != null &&
            currentBank.isNotEmpty &&
            prev.bank != currentBank;
        final holderMoved = prev.holder != null &&
            currentHolder.isNotEmpty &&
            prev.holder != currentHolder;

        // Persist the new baseline whatever we decide to show, so a change is
        // announced once rather than on every load.
        //
        // CARRY FORWARD anything this pass did not have. An empty bank or
        // holder means "not loaded yet on this pass", NOT "changed to blank" —
        // the summary can arrive with the number populated and the bank still
        // filling in. Writing the empty value over a known one made the NEXT
        // load compare "" against the real bank and report a change that never
        // happened, which is why the modal kept reappearing with identical
        // details.
        final nextBank =
            currentBank.isNotEmpty ? currentBank : (prev.bank ?? '');
        final nextHolder =
            currentHolder.isNotEmpty ? currentHolder : (prev.holder ?? '');
        await prefs.setString(
            key, snapshotFor(currentNumber, nextBank, nextHolder));

        if (!numberMoved && !bankMoved && !holderMoved) continue;

        changes.add(_AccountNumberChange(
          accountId: id,
          label: _labelFor(a),
          previous: prev.number,
          current: currentNumber,
          numberChanged: numberMoved,
          bankName: currentBank,
          previousBankName: bankMoved ? (prev.bank ?? '') : '',
          holderName: currentHolder,
          previousHolderName: holderMoved ? (prev.holder ?? '') : '',
        ));
      }

      if (changes.isEmpty || !context.mounted) return false;
      _shownForUserId = userId;
      await _showModal(context, changes);
      return true;
    } catch (_) {
      // Never break the dashboard over an announcement.
      return false;
    }
  }

  /// Encodes the three details a payer reads back, as one stored baseline.
  ///
  /// A provider switch moves all three together — number, bank and the holder
  /// name the sending bank will display — and announcing only the number left
  /// the other two to change silently underneath the user. Someone who had
  /// saved "Praiz Onah FLW / Flutterwave MFB" would be told their number moved
  /// while the name on it quietly became something else.
  ///
  /// Tab-separated because none of the three can contain a tab, and it keeps
  /// the value readable in storage. Deliberately NOT JSON: this key already
  /// exists on every install holding a bare account number, and a parser that
  /// throws on the old format would suppress announcements for existing users.
  @visibleForTesting
  static String snapshotFor(String number, String bank, String holder) {
    // Trailing unknown fields are OMITTED, not written as empty.
    //
    // _parseSnapshot draws a deliberate distinction: a missing field is null
    // ("this device never recorded it", never reported as a change) while a
    // present-but-empty one is '' ("recorded as absent", which IS comparable).
    // Always joining three parts destroyed that distinction — a first load
    // whose bank had not arrived yet stored '' and the next load then saw ''
    // -> 'Nombank MFB' as a genuine change.
    if (holder.isNotEmpty) return [number, bank, holder].join('\t');
    if (bank.isNotEmpty) return [number, bank].join('\t');
    return number;
  }

  /// Reads a baseline written by [snapshotFor], tolerating the legacy bare number.
  ///
  /// A missing field comes back as null rather than '' — the difference matters.
  /// Null means "this device never recorded it", which must NOT be reported as a
  /// change; '' means it was recorded as absent.
  @visibleForTesting
  static ({String number, String? bank, String? holder}) parseSnapshot(
      String raw) {
    final parts = raw.split('\t');
    return (
      number: parts.isNotEmpty ? parts[0] : '',
      bank: parts.length > 1 ? parts[1] : null,
      holder: parts.length > 2 ? parts[2] : null,
    );
  }

  /// How an account should be NAMED in the modal.
  ///
  /// [AccountSummaryEntity.displayName] is the account TYPE, deliberately — it is
  /// what differentiates rows in a picker, and accountLabel holds the account
  /// HOLDER's name for personal accounts, which would render every row as the
  /// same person.
  ///
  /// Family accounts are the exception, and the reason this exists: a user can
  /// have several, so "Family & Friends" does not identify which one moved. For
  /// those the backend fills accountLabel with the FAMILY name, which is what the
  /// dashboard carousel titles the card with — so the modal now says "Household"
  /// and matches the card the user is looking at.
  static String _labelFor(AccountSummaryEntity a) {
    if (a.accountTypeEnum == VirtualAccountType.family) {
      final name = (a.accountLabel ?? '').trim();
      if (name.isNotEmpty) return name;
      return 'Family & Friends';
    }
    return a.displayName;
  }

  Future<void> _showModal(
      BuildContext context, List<_AccountNumberChange> changes) async {
    await showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'Account number changed',
      barrierColor: Colors.black.withValues(alpha: 0.7),
      transitionDuration: const Duration(milliseconds: 220),
      transitionBuilder: (ctx, anim, _, child) => FadeTransition(
        opacity: anim,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.94, end: 1).animate(
              CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
          child: child,
        ),
      ),
      pageBuilder: (ctx, _, __) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            key: const Key('account_number_change_modal'),
            width: 340.w,
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            decoration: BoxDecoration(
              color: const Color(0xFF16162A),
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.45),
                  blurRadius: 40,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64.w,
                  height: 64.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF4E03D0).withValues(alpha: 0.35),
                        const Color(0xFF4E03D0).withValues(alpha: 0.12),
                      ],
                    ),
                    border: Border.all(
                        color: const Color(0xFF9B6DFF).withValues(alpha: 0.35)),
                  ),
                  child: Icon(Icons.sync_alt_rounded,
                      color: const Color(0xFF9B6DFF), size: 30.sp),
                ),
                SizedBox(height: 18.h),
                Text(
                  // The headline follows what actually moved. A switch can
                  // re-issue the same NUBAN under a new sponsor bank, changing
                  // the name and bank but not the number — announcing "your
                  // account number has changed" then sends people to re-check a
                  // number that is still correct.
                  !changes.any((c) => c.numberChanged)
                      ? (changes.length == 1
                          ? 'Your account details have changed'
                          : 'Your account details have changed')
                      : (changes.length == 1
                          ? 'Your account number has changed'
                          : 'Your account numbers have changed'),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'We upgraded the banking partner behind your wallet. Your '
                  'balance and history are untouched — only the details you '
                  'share to receive money have changed. Update them anywhere '
                  'you have them saved.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: const Color(0xFFB6B9C6),
                    fontSize: 13.sp,
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 18.h),
                ...changes.map(_changeRow),
                SizedBox(height: 18.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      // Open the details bottom sheet — the SAME sheet the
                      // dashboard card's Details chip opens, so the user sees the
                      // new number with copy/share instead of a settings page.
                      // Outer dashboard context: it can read the summaries cubit,
                      // the dialog ctx can't.
                      //
                      // Only name an account when exactly ONE moved. A provider
                      // switch re-mints every wallet at once, and `changes.first`
                      // is then whichever row the query happened to return first —
                      // so the sheet opened, say, Savings while the user was
                      // looking at Personal. Same sheet, different wallet, and
                      // because the card is tinted per account type (savings is
                      // blue, personal purple) it read as a second, unrelated
                      // sheet rather than the one they knew.
                      //
                      // With several changed, defer to the opener's own order —
                      // active account, then personal/primary — which is the
                      // wallet the user is actually looking at.
                      openAccountDetailsSheet(
                        context,
                        preferAccountId: changes.length == 1
                            ? changes.first.accountId
                            : null,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4E03D0),
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r)),
                    ),
                    child: Text(
                      'View account details',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(
                    'Got it',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _changeRow(_AccountNumberChange c) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            c.bankName.isNotEmpty ? '${c.label} · ${c.bankName}' : c.label,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
          ),
          SizedBox(height: 8.h),
          // Only the details that actually moved are shown as before → after.
          // A provider switch usually moves all three, but not always, and
          // striking through a value that did not change would tell the user
          // something untrue about their own account.
          if (c.numberChanged)
            _beforeAfter(c.previous, c.current, emphasise: true),
          if (c.previousHolderName.isNotEmpty) ...[
            SizedBox(height: 6.h),
            _beforeAfter(c.previousHolderName, c.holderName),
          ],
          if (c.previousBankName.isNotEmpty) ...[
            SizedBox(height: 6.h),
            _beforeAfter(c.previousBankName, c.bankName),
          ],
        ],
      ),
    );
  }

  /// One "old → new" line.
  ///
  /// [emphasise] is for the account number, which is the detail someone is most
  /// likely to have saved with their bank; the name and bank are supporting
  /// context and are set smaller so the number still leads.
  Widget _beforeAfter(String before, String after, {bool emphasise = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            before,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: emphasise ? 14.sp : 12.sp,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Padding(
          padding: EdgeInsets.only(top: emphasise ? 2.h : 1.h),
          child: Icon(Icons.arrow_forward_rounded,
              size: emphasise ? 14.sp : 12.sp, color: const Color(0xFF9CA3AF)),
        ),
        SizedBox(width: 8.w),
        Flexible(
          child: Text(
            after,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: emphasise ? 15.sp : 12.5.sp,
              fontWeight: emphasise ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _AccountNumberChange {
  final String accountId;
  final String label;
  final String previous;
  final String current;

  /// False when the number itself held steady and only the name or bank moved —
  /// which happens when a provider re-issues the same NUBAN under a new sponsor.
  final bool numberChanged;

  final String bankName;
  final String holderName;

  /// Empty means "did not change" (or was never recorded on this device), so the
  /// row is omitted rather than rendered as a change from nothing.
  final String previousBankName;
  final String previousHolderName;

  const _AccountNumberChange({
    required this.accountId,
    required this.label,
    required this.previous,
    required this.current,
    required this.numberChanged,
    required this.bankName,
    required this.holderName,
    required this.previousBankName,
    required this.previousHolderName,
  });
}
