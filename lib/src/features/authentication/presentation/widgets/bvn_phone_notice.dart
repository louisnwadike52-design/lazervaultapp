import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/src/features/authentication/domain/sms_policy.dart';

/// Tells the user, on the phone-number step, that the number must be the one
/// registered against their BVN.
///
/// WHY THIS EXISTS. While we have no SMS provider we cannot verify a number
/// ourselves, so it reaches our KYC partners unverified. If it does not match
/// the BVN, verification fails — days later, by which time the user has long
/// forgotten what they typed and experiences it as the platform rejecting
/// them for no reason. One sentence at the point of entry prevents that.
///
/// Returns a zero-size widget when the notice is switched off, so the caller
/// can place it unconditionally without a null check or a conditional in the
/// middle of a form.
///
/// Reads [SmsPolicy] synchronously — SharedPreferences, already populated at
/// launch — so there is no future, no loading state and no frame cost in
/// deciding whether to paint it.
class BvnPhoneNotice extends StatelessWidget {
  const BvnPhoneNotice({super.key, this.margin});

  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    if (!SmsPolicy.showBvnPhoneNotice) return const SizedBox.shrink();

    final scheme = Theme.of(context).colorScheme;
    // Informational, not a warning. The user has done nothing wrong and
    // nothing has failed — painting this amber or red would read as an error
    // on a form they have not submitted yet.
    final tint = scheme.primary;

    return Container(
      margin: margin ?? EdgeInsets.only(top: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: tint.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, size: 18.sp, color: tint),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'Use the phone number registered on your BVN. We pass this '
              'number to our verification partners, and a number that does '
              'not match your BVN will fail verification later.',
              style: TextStyle(
                fontSize: 12.sp,
                height: 1.4,
                color: scheme.onSurface.withValues(alpha: 0.85),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
