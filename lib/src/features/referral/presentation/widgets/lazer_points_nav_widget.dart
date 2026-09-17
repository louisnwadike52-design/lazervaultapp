import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/referral/domain/repositories/i_referral_repository.dart';

/// LazerPoints, surfaced where people will actually see them.
///
/// The points screen existed but was reachable only through the referral
/// dashboard, so a reward you earn on ordinary spending was hidden behind a
/// feature about inviting friends. A balance nobody sees is a balance nobody
/// converts, which makes the whole programme decorative.
///
/// Deliberately small and self-contained: it fetches its own balance rather
/// than requiring the host screen to own rewards state, so it can be dropped
/// anywhere without that screen learning what points are.
class LazerPointsNavWidget extends StatefulWidget {
  const LazerPointsNavWidget({super.key});

  @override
  State<LazerPointsNavWidget> createState() => _LazerPointsNavWidgetState();
}

class _LazerPointsNavWidgetState extends State<LazerPointsNavWidget> {
  int? _balance;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    if (!serviceLocator.isRegistered<IReferralRepository>()) {
      if (mounted) setState(() => _failed = true);
      return;
    }
    final res = await serviceLocator<IReferralRepository>().getMyPointsBalance();
    if (!mounted) return;
    res.fold(
      (_) => setState(() => _failed = true),
      (b) => setState(() {
        _balance = b.currentBalance;
        _failed = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    // A rewards card that failed to load is worse than no card: it occupies the
    // top of the screen saying nothing, and its error is not something the user
    // can act on from here. Stay out of the way and let the points screen
    // report the problem if they go looking.
    if (_failed) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: InkWell(
        onTap: () => Get.toNamed(AppRoutes.lazerPoints),
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF4E03D0), Color(0xFF7C3AED)],
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Icons.stars_rounded,
                    color: Colors.white, size: 24.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LazerPoints',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    // While loading, show the label without a number rather
                    // than a spinner or a zero. A flashed "0" reads as "you
                    // have nothing", which is a lie told to exactly the people
                    // who have been earning.
                    Text(
                      _balance == null
                          ? 'Checking your balance…'
                          : '${NumberFormat('#,###').format(_balance)} points',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: _balance == null ? 13.sp : 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Convert to cash',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Icon(Icons.chevron_right_rounded,
                      color: Colors.white.withValues(alpha: 0.9), size: 20.sp),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
