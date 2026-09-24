import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/referral/domain/repositories/i_referral_repository.dart';
import 'package:lazervault/src/features/referral/presentation/widgets/convert_points_sheet.dart';

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
    final res =
        await serviceLocator<IReferralRepository>().getMyPointsBalance();
    if (!mounted) return;
    res.fold(
      (_) => setState(() => _failed = true),
      (b) => setState(() {
        _balance = b.currentBalance;
        _failed = false;
      }),
    );
  }

  /// Open the conversion sheet straight from the card.
  ///
  /// The repository is resolved BEFORE the sheet is shown, not inside the
  /// builder. A throw inside a `showModalBottomSheet` builder renders an
  /// ErrorWidget, and with `backgroundColor: Colors.transparent` that widget is
  /// invisible — the sheet "opens" and the user sees nothing at all. Resolving
  /// first turns that into a message they can read.
  void _openConvertSheet() {
    if (!serviceLocator.isRegistered<IReferralRepository>()) {
      Get.toNamed(AppRoutes.lazerPoints);
      return;
    }
    // Still loading the balance: the sheet needs it to say how many points stay
    // behind on the remainder. Send them to the screen, which shows its own
    // loading state, rather than opening a sheet that would understate it.
    final balance = _balance;
    if (balance == null) {
      Get.toNamed(AppRoutes.lazerPoints);
      return;
    }
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => ConvertPointsSheet(
        repository: serviceLocator<IReferralRepository>(),
        currentBalance: balance,
        // The card shows the balance, so it has to re-read it — a conversion
        // that left a stale number on screen would look like it failed.
        onConverted: _load,
      ),
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
                child:
                    Icon(Icons.stars_rounded, color: Colors.white, size: 24.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lazerpoints',
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
              // "Convert to cash" was a LABEL, not a control: the only tap
              // handler was the card's, which navigated to the points screen.
              // Tapping the words that say "convert" gave you an ink ripple and
              // a screen where you still had to find the real button — which
              // reads exactly as "the convert button dims and does nothing".
              //
              // It now opens the conversion sheet directly. The card tap still
              // navigates, so the screen is not orphaned.
              InkWell(
                onTap: _openConvertSheet,
                borderRadius: BorderRadius.circular(10.r),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Convert to cash',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white.withValues(alpha: 0.45),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Icon(Icons.chevron_right_rounded,
                          color: Colors.white.withValues(alpha: 0.9),
                          size: 20.sp),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
