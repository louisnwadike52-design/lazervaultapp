import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';

/// Shared UX gate for open-banking bank LINKING.
///
/// Two operator/product rules are enforced consistently here so every link
/// entry point behaves the same and the modals are authored once:
///
///  1. Bank-linking (Link & Deposit) is only offered on the user's PERSONAL
///     account. On any other account type the [showPersonalAccountOnlyLinkDialog]
///     modal explains the rule and points to bank transfer / card / LazerBeam.
///  2. The backend caps how many banks a user may link (admin-tunable
///     `mono_max_linked_accounts`, default 3). When it returns
///     `LINK_LIMIT_REACHED`, [showLinkLimitReachedDialog] surfaces it as a
///     styled modal (never a snackbar).
///
/// Both dialogs mirror the deposit screen's existing dark-purple modal theme
/// (`_showRefreshFeeInsufficientDialog`): dark card, brand-purple accent,
/// rounded 20.r, icon disc + title + body + a single full-width action.

const Color _kBrand = Color(0xFF4E03D0); // app primary purple (AppColors.backgroundColor)
const Color _kCard = Color(0xFF1B1626); // dark modal surface

/// The backend error code returned by LinkBankAccount when a user is already at
/// their linked-bank cap. Matches banking-service banking_handler.go.
const String kLinkLimitReachedCode = 'LINK_LIMIT_REACHED';

/// Backend error code when Mono open-banking cannot onboard a NEW link because
/// the platform's provider subscription/capacity is exhausted — NOT the user's
/// per-user cap and NOT the user's fault. Matches banking-service.
const String kLinkingCapacityCode = 'LINKING_CAPACITY_EXHAUSTED';

/// Returns true when [accountType] denotes the user's PERSONAL account — the
/// only account type where open-banking bank-linking is offered.
///
/// A blank/unknown type fails OPEN (returns true) so a genuine personal deposit
/// is never wrongly blocked by absent metadata; known non-personal types
/// (savings / investment / family / business / currency wallets) return false.
/// The value comes straight from the account summary (`AccountSummaryEntity
/// .accountType`, e.g. carried in the deposit screen's `selectedCard`).
bool canLinkBankForAccountType(String? accountType) {
  final t = (accountType ?? '').trim().toLowerCase();
  if (t.isEmpty) return true; // unknown → don't block a personal deposit
  return t == 'personal';
}

/// Modal shown when a user tries to link a bank from a non-personal account.
/// Explains the personal-account rule and the supported alternatives.
void showPersonalAccountOnlyLinkDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.6),
    builder: (dialogCtx) => Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 18.h),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: _kBrand.withValues(alpha: 0.35)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 24,
                offset: const Offset(0, 10)),
          ],
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 52.w,
            height: 52.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _kBrand.withValues(alpha: 0.16),
            ),
            child: Icon(Icons.link_off_rounded, color: _kBrand, size: 26.sp),
          ),
          SizedBox(height: 14.h),
          Text('Linking is for your personal account',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w800)),
          SizedBox(height: 8.h),
          Text(
            'Connecting a bank to deposit is only available on your personal '
            'account. To add money to this account, use one of these instead:',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.72),
                fontSize: 12.5.sp,
                height: 1.4),
          ),
          SizedBox(height: 16.h),
          _altRow(
            icon: Icons.account_balance_rounded,
            title: 'Bank transfer',
            subtitle: 'Send to this account’s number from any bank.',
          ),
          SizedBox(height: 12.h),
          _altRow(
            icon: Icons.credit_card_rounded,
            title: 'Pay with card',
            subtitle: 'Top up instantly with a debit or credit card.',
          ),
          SizedBox(height: 12.h),
          _altRow(
            icon: Icons.bolt_rounded,
            title: 'LazerBeam',
            subtitle: 'Move funds from your personal account to here.',
          ),
          SizedBox(height: 18.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(dialogCtx).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: _kBrand,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 13.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                elevation: 0,
              ),
              child: Text('Got it',
                  style:
                      TextStyle(fontSize: 14.5.sp, fontWeight: FontWeight.w700)),
            ),
          ),
        ]),
      ),
    ),
  );
}

/// One alternative-method row inside [showPersonalAccountOnlyLinkDialog].
Widget _altRow(
    {required IconData icon,
    required String title,
    required String subtitle}) {
  return Row(children: [
    Container(
      width: 38.w,
      height: 38.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.06),
      ),
      child: Icon(icon, color: Colors.white.withValues(alpha: 0.85), size: 19.sp),
    ),
    SizedBox(width: 12.w),
    Expanded(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w700)),
        SizedBox(height: 2.h),
        Text(subtitle,
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.55),
                fontSize: 11.sp,
                height: 1.3)),
      ]),
    ),
  ]);
}

/// Modal shown when the backend rejects a link with `LINK_LIMIT_REACHED`.
/// [message] is the backend's user-facing message (already names the cap).
/// Returns when the user dismisses it, so callers on a dead link screen can
/// pop back afterwards.
Future<void> showLinkLimitReachedDialog(BuildContext context, String message) {
  const warn = Color(0xFFFB923C);
  final text = message.trim().isNotEmpty
      ? message.trim()
      : "You've reached the maximum number of linked bank accounts.";
  return showDialog(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.6),
    builder: (dialogCtx) => Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 18.h),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: warn.withValues(alpha: 0.35)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 24,
                offset: const Offset(0, 10)),
          ],
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 52.w,
            height: 52.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: warn.withValues(alpha: 0.16),
            ),
            child: Icon(Icons.account_balance_rounded, color: warn, size: 26.sp),
          ),
          SizedBox(height: 14.h),
          Text('Linked-bank limit reached',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w800)),
          SizedBox(height: 8.h),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.72),
                fontSize: 12.5.sp,
                height: 1.4),
          ),
          SizedBox(height: 8.h),
          Text(
            'Unlink a bank you no longer use from your linked banks, then try '
            'again.',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 11.5.sp,
                height: 1.4),
          ),
          SizedBox(height: 18.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(dialogCtx).pop();
                Get.toNamed(AppRoutes.linkedBanks);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _kBrand,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 13.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                elevation: 0,
              ),
              child: Text('Manage linked banks',
                  style:
                      TextStyle(fontSize: 14.5.sp, fontWeight: FontWeight.w700)),
            ),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.of(dialogCtx).pop(),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white.withValues(alpha: 0.7),
                padding: EdgeInsets.symmetric(vertical: 11.h),
              ),
              child: Text('Not now',
                  style:
                      TextStyle(fontSize: 13.5.sp, fontWeight: FontWeight.w600)),
            ),
          ),
        ]),
      ),
    ),
  );
}

/// Modal shown when the banking / KYC / Mono backend is unreachable (gRPC
/// UNAVAILABLE → ServiceUnavailable state, or a network drop → OpenBankingOffline).
/// Communicates that it's a temporary service issue on our side — never a
/// snackbar, never the misleading "can't reach your bank". [serviceLabel] names
/// the affected surface (e.g. "Deposits", "Bank linking", "Identity verification").
/// If [onRetry] is supplied a "Try again" primary button runs it on dismiss.
Future<void> showServiceUnavailableDialog(
  BuildContext context, {
  String serviceLabel = 'This service',
  VoidCallback? onRetry,
}) {
  const warn = Color(0xFFFB923C);
  return showDialog(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.6),
    builder: (dialogCtx) => Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 18.h),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: warn.withValues(alpha: 0.35)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 24,
                offset: const Offset(0, 10)),
          ],
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 52.w,
            height: 52.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: warn.withValues(alpha: 0.16),
            ),
            child: Icon(Icons.cloud_off_rounded, color: warn, size: 26.sp),
          ),
          SizedBox(height: 14.h),
          Text('Temporarily unavailable',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w800)),
          SizedBox(height: 8.h),
          Text(
            '$serviceLabel is temporarily unavailable. Please try again in a '
            'moment.',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.72),
                fontSize: 12.5.sp,
                height: 1.4),
          ),
          SizedBox(height: 8.h),
          Text(
            'Nothing was charged.',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 11.5.sp,
                height: 1.4),
          ),
          SizedBox(height: 18.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(dialogCtx).pop();
                if (onRetry != null) onRetry();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _kBrand,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 13.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                elevation: 0,
              ),
              child: Text(onRetry != null ? 'Try again' : 'Got it',
                  style:
                      TextStyle(fontSize: 14.5.sp, fontWeight: FontWeight.w700)),
            ),
          ),
          if (onRetry != null) ...[
            SizedBox(height: 8.h),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.of(dialogCtx).pop(),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white.withValues(alpha: 0.7),
                  padding: EdgeInsets.symmetric(vertical: 11.h),
                ),
                child: Text('Close',
                    style: TextStyle(
                        fontSize: 13.5.sp, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ]),
      ),
    ),
  );
}

/// Modal shown when open-banking linking is temporarily disabled at the PLATFORM
/// level — the Mono Connect subscription/capacity is exhausted, so no NEW bank can
/// be onboarded right now (LINKING_CAPACITY_EXHAUSTED). This is NOT the user's
/// per-user cap and NOT their fault; existing linked banks keep working. Points to
/// the other funding methods so the user isn't stuck.
Future<void> showLinkingCapacityDialog(BuildContext context) {
  const warn = Color(0xFFFB923C);
  return showDialog(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.6),
    builder: (dialogCtx) => Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 18.h),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: warn.withValues(alpha: 0.35)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 24,
                offset: const Offset(0, 10)),
          ],
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 52.w,
            height: 52.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: warn.withValues(alpha: 0.16),
            ),
            child: Icon(Icons.pause_circle_outline_rounded,
                color: warn, size: 26.sp),
          ),
          SizedBox(height: 14.h),
          Text('Bank linking is paused',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w800)),
          SizedBox(height: 8.h),
          Text(
            'New bank connections are temporarily disabled while we increase '
            'capacity. Any banks you have already linked still work.',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.72),
                fontSize: 12.5.sp,
                height: 1.4),
          ),
          SizedBox(height: 16.h),
          _altRow(
            icon: Icons.account_balance_rounded,
            title: 'Bank transfer',
            subtitle: 'Send to this account’s number from any bank.',
          ),
          SizedBox(height: 12.h),
          _altRow(
            icon: Icons.credit_card_rounded,
            title: 'Pay with card',
            subtitle: 'Top up instantly with a debit or credit card.',
          ),
          SizedBox(height: 12.h),
          _altRow(
            icon: Icons.bolt_rounded,
            title: 'LazerBeam',
            subtitle: 'Move funds from your personal account to here.',
          ),
          SizedBox(height: 18.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(dialogCtx).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: _kBrand,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 13.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                elevation: 0,
              ),
              child: Text('Got it',
                  style:
                      TextStyle(fontSize: 14.5.sp, fontWeight: FontWeight.w700)),
            ),
          ),
        ]),
      ),
    ),
  );
}
