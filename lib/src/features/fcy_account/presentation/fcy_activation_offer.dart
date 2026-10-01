import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_surfaces.dart';
import '../../../../core/types/app_routes.dart';
import '../data/fcy_account_service.dart';
import '../data/fcy_capabilities.dart';

/// What happens after someone switches the app to another country.
///
/// THE GAP THIS CLOSES
/// -------------------
/// Switching to en-GB creates a GBP wallet and shows it, and that was the end of
/// it. The activation flow for a real foreign deposit account existed — the
/// wizard, the document upload, the prefill, the backend RPC, all of it — and
/// the ONLY way to reach it was to open an account, open the actions sheet, land
/// on the right card face and notice a text link. Nothing on the switch itself
/// said the account could be activated, so in production not one user has ever
/// started it: `accounts.fcy_kyc_submissions` is empty, and 283 foreign wallets
/// sit unprovisioned.
///
/// DIALOGS, NOT SNACKBARS
/// ----------------------
/// Both outcomes here are dialogs on purpose. A snackbar for "your new wallet
/// can't take deposits yet" is a message that disappears while the user is still
/// looking for the account number.
///
/// NEVER INTERRUPTS WITH AN ERROR
/// ------------------------------
/// If the status read fails, this returns silently. A locale switch succeeded;
/// turning a failed secondary lookup into a dialog would invent an outage on top
/// of a working action.

/// Currencies already explained to this user in this app run.
///
/// The not-open-yet dialog answers "where is my account number" once. Repeating
/// it on every switch would be nagging; forgetting it across a cold start is
/// correct, because the question comes back with the next switch.
final Set<String> _explained = <String>{};

/// Offer foreign-deposit activation for [currency], if there is anything to
/// offer. Safe to call unconditionally after a locale switch.
Future<void> maybeOfferFcyActivation(
  BuildContext context, {
  required String currency,
  FCYAccountService? service,
}) async {
  final cur = currency.trim().toUpperCase();
  // NGN accounts are issued by Mono / Flutterwave / Nomba at signup and need
  // none of this. The FCY pack is for foreign currency only.
  if (cur.isEmpty || cur == 'NGN') return;

  final svc = service ?? FCYAccountService();
  FCYStatus status;
  try {
    status = await svc.status(cur);
  } catch (_) {
    return; // see "never interrupts with an error"
  }

  // Keep the shared capability cache in step with what this read just told us,
  // so the account cards agree with this dialog without a second round trip.
  FcyCapabilities.instance.adopt(status);

  final state = status.status.trim().toLowerCase();
  // Already requested, already issued, or already refused — each of those has
  // its own surface on the account card. Only 'none' is an invitation.
  if (state != 'none') return;
  if (!context.mounted) return;

  final carried = status.supportedCurrencies.isEmpty
      ? FcyCapabilities.instance.supports(cur)
      : status.supportedCurrencies.contains(cur);
  if (!carried) return; // no rail issues this currency at all

  if (status.currencyGated || FcyCapabilities.instance.isGated(cur)) {
    if (_explained.contains(cur)) return;
    _explained.add(cur);
    await _showFcyDialog(
      context,
      icon: Icons.schedule_rounded,
      title: '$cur deposits aren\'t open yet',
      body: 'Your $cur wallet is ready to hold and spend money, but we can\'t '
          'issue a $cur deposit account for new customers just yet. You can fund '
          'it right now by converting from another wallet, and we\'ll let you '
          'know as soon as deposit accounts open.',
      primaryLabel: 'Got it',
      onPrimary: () => Navigator.of(context).pop(),
    );
    return;
  }

  if (!FcyCapabilities.instance.canActivate(cur)) return;

  await _showFcyDialog(
    context,
    icon: Icons.public_rounded,
    title: 'Get a $cur account of your own',
    body: 'You can receive $cur straight into this wallet from a bank abroad. '
        'It takes a one-time identity check — and we\'ve already filled in '
        'everything we hold from your verified profile, so there\'s less to do '
        'than it looks.',
    primaryLabel: 'Set it up',
    secondaryLabel: 'Maybe later',
    footnote: 'Usually about 3 minutes',
    onPrimary: () {
      Navigator.of(context).pop();
      Get.toNamed(AppRoutes.fcyActivation, arguments: {'currency': cur});
    },
  );
}

/// The dialog both outcomes share.
///
/// barrierDismissible stays true: neither message is a decision the user has to
/// make, and a modal they cannot dismiss after switching country would be worse
/// than the silence it replaced.
Future<void> _showFcyDialog(
  BuildContext context, {
  required IconData icon,
  required String title,
  required String body,
  required String primaryLabel,
  required VoidCallback onPrimary,
  String? secondaryLabel,
  String? footnote,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (ctx) => Dialog(
      backgroundColor: AppSurfaces.pageTop,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppSurfaces.accentPurple.withValues(alpha: 0.15),
              ),
              child: Icon(icon, size: 30.sp, color: AppSurfaces.accentPurple),
            ),
            SizedBox(height: 18.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 19.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              body,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 13.5.sp,
                height: 1.5,
              ),
            ),
            if (footnote != null) ...[
              SizedBox(height: 14.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.schedule_rounded,
                      size: 14.sp, color: Colors.white.withValues(alpha: 0.5)),
                  SizedBox(width: 6.w),
                  Text(
                    footnote,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ],
            SizedBox(height: 22.h),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: onPrimary,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppSurfaces.accentPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: Text(
                  primaryLabel,
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            if (secondaryLabel != null)
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(
                  secondaryLabel,
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
  );
}

/// Test seam: forget which currencies have been explained.
void resetFcyActivationOfferForTest() => _explained.clear();
