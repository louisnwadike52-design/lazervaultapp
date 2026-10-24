import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_surfaces.dart';
import '../../../../core/types/app_routes.dart';
import '../../../../core/services/injection_container.dart';
import 'package:lazervault/src/features/currency_exchange/data/services/transfer_requirements_service.dart';
import '../data/fcy_account_service.dart';

/// The gate in front of an international payout.
///
/// WHY A GATE AT ALL
/// -----------------
/// Sending a customer's money abroad requires KYC on that customer. Note that this
/// is OUR compliance posture, not the provider's API requirement — a Fincra
/// disbursement payload carries no sender-KYC fields whatsoever. That distinction
/// decides what this gate checks: it unlocks once the package is COLLECTED, not once
/// the provider has issued a foreign account. Gating on issuance would take every
/// international payout offline for as long as the provider has foreign-account
/// opening disabled, which is currently indefinite.
///
/// FAIL OPEN, DELIBERATELY
/// -----------------------
/// If the status lookup fails we let the user through. The backend is the
/// authoritative gate and refuses the payout itself; blocking here on a flaky read
/// would invent an outage the server never asked for. Same reasoning as
/// `ensureCryptoTradeAllowed`, which documents the identical choice.
///
/// WHICH RAILS IT APPLIES TO IS NOW A SETTING, NOT A CONSTANT
/// ----------------------------------------------------------
/// Because this is our posture rather than an API requirement, it is not the
/// same answer for every rail. Nomba's Global Payout methods declare
/// `purposeOfPaymentRequired: false` and ask for nothing about the sender, so
/// prompting before a Nomba payout collects details no payout will use.
///
/// The backend resolves it next to the rail that will carry the corridor and
/// returns `requires_sender_kyc` with the recipient requirements, driven by an
/// admin-tunable exemption list. Switching the active provider in the
/// dashboard therefore moves this prompt with it, with no store release.
///
/// Asking here, before navigation, costs one call that the recipient screen
/// would make a moment later anyway — and it is the only place that knows the
/// corridor before the user has invested any effort in the form.
///
/// Returns true when the caller should proceed with the payout.
Future<bool> ensureFcyKycForPayout(
  BuildContext context, {
  required String destinationCurrency,
  String sourceCurrency = 'NGN',
  FCYAccountService? service,
  TransferRequirementsService? requirements,
}) async {
  final svc = service ?? FCYAccountService();
  final currency = destinationCurrency.trim().toUpperCase();

  // Does the rail carrying this corridor need the sender verified at all?
  //
  // Fails to the GATE, not past it: an unreadable answer is not permission to
  // skip a compliance step. That is the opposite of the status lookup below,
  // which fails open — and deliberately so. There, the backend is still an
  // authoritative gate that will refuse the payout; here, a wrong "skip"
  // would mean nothing ever asks.
  try {
    final reqs =
        await (requirements ?? serviceLocator<TransferRequirementsService>())
            .fetch(destCurrency: currency, sourceCurrency: sourceCurrency);
    if (reqs != null && !reqs.requiresSenderKyc) return true;
  } catch (_) {
    // Keep the gate.
  }

  String status;
  try {
    final s = await svc.status(currency);
    status = s.status.trim().toLowerCase();
  } catch (_) {
    // Fail open — see above.
    return true;
  }

  // 'active' means the account is issued; 'creating' means the package is with us
  // and in review. Both mean we have their details, which is what this gate is for.
  if (status == 'active' || status == 'creating') return true;

  if (!context.mounted) return false;

  final proceed = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _FcyKycPrompt(currency: currency),
  );

  // Opening the form is not the same as being allowed to send. The user comes back
  // to a screen that will re-check, so this always returns false: proceeding now
  // would let someone through on the strength of having merely tapped "continue".
  if (proceed == true) {
    await Get.toNamed(AppRoutes.fcyActivation,
        arguments: {'currency': currency});
  }
  return false;
}

/// The prompt itself.
///
/// Says what is needed and why, and names the one thing people want to know before
/// starting a KYC form: how long it takes. Copy is deliberately about THEIR account
/// rather than about compliance — "verify to send money abroad" is a reason,
/// "regulatory requirement" is an excuse.
class _FcyKycPrompt extends StatelessWidget {
  const _FcyKycPrompt({required this.currency});

  final String currency;

  @override
  Widget build(BuildContext context) {
    // The app-root tap-to-dismiss cannot reach inside modal sheets — the opaque
    // sheet surface occludes it — so unfocus here.
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 28.h),
        decoration: BoxDecoration(
          color: AppSurfaces.pageTop,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppSurfaces.accentPurple.withValues(alpha: 0.15),
              ),
              child: Icon(Icons.public_rounded,
                  size: 30.sp, color: AppSurfaces.accentPurple),
            ),
            SizedBox(height: 20.h),
            Text(
              'Verify your details to send abroad',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'International transfers need a one-time identity check. '
              'We have already filled in everything we hold from your verified '
              'profile, so there is less to do than it looks.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 14.sp,
                height: 1.5,
              ),
            ),
            SizedBox(height: 14.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.schedule_rounded,
                    size: 15.sp, color: Colors.white.withValues(alpha: 0.5)),
                SizedBox(width: 6.w),
                Text(
                  'Usually about 3 minutes',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppSurfaces.accentPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: Text(
                  'Verify my details',
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'Not now',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
