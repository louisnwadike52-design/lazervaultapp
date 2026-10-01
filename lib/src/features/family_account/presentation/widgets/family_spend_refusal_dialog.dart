import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/theme/app_surfaces.dart';
import '../../../../../core/types/app_routes.dart';

/// What a member sees when a family wallet refuses their spend.
///
/// THE EXPERIENCE THIS REPLACES
/// ----------------------------
/// The server already explains itself well — accounts-service classifies the
/// refusal (allocation short, pool short, per-transaction cap, daily or monthly
/// cap, spending switched off, not a member) and returns copy written for the
/// payer, which core-payments forwards verbatim as FailedPrecondition. The app
/// then flashed it inside the PIN modal for two seconds and closed, or dropped it
/// into a snackbar. So the one explanation that would have helped arrived as a
/// blink, and what people remembered was "it just said something went wrong
/// after I entered my PIN".
///
/// A refusal is also not an error in the usual sense: nothing is broken, there is
/// nothing to retry, and there IS something the user can do — which is exactly
/// the case for a dialog with an action rather than a transient message.
///
/// WHY THE MODE DECIDES THE ACTION
/// -------------------------------
/// A Family & Friends wallet distributes money one of two ways, and the fix is
/// different in each. On a shared pool everyone spends from one balance, so the
/// answer is to put money in the pool — anyone can. On individual allocations
/// each member has their own allowance carved out of the pool, so a member who is
/// short cannot fix it themselves: the owner has to raise their allowance. Taking
/// a member to a "top up the pool" screen they have no business on would be worse
/// than saying nothing.
///
/// The mode comes from the active account summary the app already holds, not from
/// parsing the server's sentence.

/// How a family wallet hands money to its members.
enum FamilyFundMode {
  /// One balance everyone draws on.
  sharedPool,

  /// Each member has their own allowance.
  individualAllocation,

  /// Not known — the caller had no account summary. The dialog then offers only
  /// the family account, which is correct under either mode.
  unknown,
}

/// Map the server's `fund_distribution_mode` string onto the two shapes that
/// change what we offer. 'equal_split' and 'custom_allocation' differ in HOW the
/// allowance is calculated, and not at all in who can change it, so both are
/// individual allocations here.
FamilyFundMode familyFundModeFrom(String? raw) {
  switch ((raw ?? '').trim().toLowerCase()) {
    case 'shared_pool':
      return FamilyFundMode.sharedPool;
    case 'equal_split':
    case 'custom_allocation':
      return FamilyFundMode.individualAllocation;
    default:
      return FamilyFundMode.unknown;
  }
}

/// Whether the server's sentence is actually about running out of money or
/// hitting a cap.
///
/// Needed because a family wallet can be refused for reasons that have nothing
/// to do with allowances — a frozen account comes back under the same gRPC code
/// — and titling that "Not enough in your allowance" would send someone to top
/// up a wallet that was never short. Narrow on purpose: when the words are not
/// there, the dialog keeps the neutral title and still shows the server's
/// explanation, which is the part that matters.
bool familyRefusalIsAboutFunds(String message) {
  final m = message.toLowerCase();
  for (final needle in const [
    'insufficient',
    'not enough',
    'left',
    'remaining',
    'allowance',
    'allocation',
    'pool',
    'limit',
    'exceeds',
    'balance',
  ]) {
    if (m.contains(needle)) return true;
  }
  return false;
}

/// Show the refusal. Returns when the user dismisses it.
///
/// [message] is the server's own explanation and is shown verbatim: it is the
/// only part that knows WHICH limit was hit and by how much. The dialog supplies
/// the framing and the way out.
Future<void> showFamilySpendRefusalDialog(
  BuildContext context, {
  required String message,
  FamilyFundMode mode = FamilyFundMode.unknown,
  String? familyName,
}) {
  final aboutFunds = familyRefusalIsAboutFunds(message);

  final title = !aboutFunds
      ? 'This payment wasn\'t allowed'
      : switch (mode) {
          FamilyFundMode.sharedPool => 'Not enough in the family pool',
          FamilyFundMode.individualAllocation => 'Not enough in your allowance',
          FamilyFundMode.unknown => 'This payment wasn\'t allowed',
        };

  final guidance = !aboutFunds
      ? ''
      : switch (mode) {
          FamilyFundMode.sharedPool =>
            'Anyone in ${familyName ?? 'the family'} can add money to the pool, '
                'and it\'s available to spend straight away.',
          FamilyFundMode.individualAllocation =>
            'Your allowance is set by whoever manages '
                '${familyName ?? 'this account'}. Ask them to raise it, or '
                'spend a smaller amount.',
          FamilyFundMode.unknown => '',
        };

  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (ctx) => Dialog(
      backgroundColor: AppSurfaces.pageTop,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: SingleChildScrollView(
        // A refusal message can be long and the user may have large text set; an
        // unscrollable Column in a height-constrained Dialog then paints the
        // overflow stripes over the action button. Caught by the widget test at
        // 390x844 — the overflow was 123px with real server copy.
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 18.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 62.w,
                height: 62.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFFB020).withValues(alpha: 0.15),
                ),
                child: Icon(Icons.account_balance_wallet_outlined,
                    size: 28.sp, color: const Color(0xFFFFB020)),
              ),
              SizedBox(height: 18.h),
              Text(
                title,
                key: const Key('family_refusal_title'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10.h),
              // The server's sentence. It carries the figure — "you have 20.00
              // left of your 200.00 allowance" — which is the whole reason the
              // user opened this.
              Text(
                message,
                key: const Key('family_refusal_message'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.78),
                  fontSize: 14.sp,
                  height: 1.5,
                ),
              ),
              if (guidance.isNotEmpty) ...[
                SizedBox(height: 12.h),
                Text(
                  guidance,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.55),
                    fontSize: 12.5.sp,
                    height: 1.45,
                  ),
                ),
              ],
              SizedBox(height: 22.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    // Both modes land on the family account: it is where a pool
                    // is topped up AND where allowances are listed, so a member
                    // who must ask the owner can at least see what they have.
                    Get.toNamed(AppRoutes.familyDetails);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppSurfaces.accentPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Text(
                    aboutFunds && mode == FamilyFundMode.sharedPool
                        ? 'Add money to the pool'
                        : 'View family account',
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
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
