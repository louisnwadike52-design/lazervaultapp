import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lazervault/core/types/app_routes.dart';
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
  Future<void> check(
    BuildContext context, {
    required String userId,
    required List<AccountSummaryEntity> accounts,
  }) async {
    if (userId.isEmpty || accounts.isEmpty) return;
    // One announcement per user per app session. A provider switch can move
    // several accounts at once and a stack of modals would be worse than one.
    if (_shownForUserId == userId) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      final changes = <_AccountNumberChange>[];

      for (final a in accounts) {
        final current = (a.accountNumber ?? '').trim();
        if (current.isEmpty) continue;

        final id = a.id.toString();
        final key = _key(userId, id);
        final previous = prefs.getString(key);

        if (previous == null) {
          // First sighting on this device. There is no change to report yet;
          // record the baseline so a later switch is detectable.
          await prefs.setString(key, current);
          continue;
        }
        if (previous == current) continue;

        changes.add(_AccountNumberChange(
          label: a.displayName,
          previous: previous,
          current: current,
          bankName: (a.bankName ?? '').trim(),
        ));
        await prefs.setString(key, current);
      }

      if (changes.isEmpty || !context.mounted) return;
      _shownForUserId = userId;
      await _showModal(context, changes);
    } catch (_) {/* never break the dashboard over an announcement */}
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
                  changes.length == 1
                      ? 'Your account number has changed'
                      : 'Your account numbers have changed',
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
                  'balance and history are untouched. Only the number you '
                  'share to receive money is new.',
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
                      Get.toNamed(AppRoutes.myAccount);
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
          Row(
            children: [
              Text(
                c.previous,
                style: GoogleFonts.inter(
                  color: const Color(0xFF6B7280),
                  fontSize: 14.sp,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(Icons.arrow_forward_rounded,
                  size: 14.sp, color: const Color(0xFF9CA3AF)),
              SizedBox(width: 8.w),
              Text(
                c.current,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AccountNumberChange {
  final String label;
  final String previous;
  final String current;
  final String bankName;

  const _AccountNumberChange({
    required this.label,
    required this.previous,
    required this.current,
    required this.bankName,
  });
}
