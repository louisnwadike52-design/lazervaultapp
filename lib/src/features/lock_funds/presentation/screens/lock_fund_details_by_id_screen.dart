import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../cubit/lock_funds_cubit.dart';
import '../cubit/lock_funds_state.dart';
import 'lock_fund_details_screen.dart';

/// Opens a PiggyVault plan from nothing but its id.
///
/// [LockFundDetailsScreen] takes a hydrated [LockFund], which an in-app tap
/// always has because it came from the list. A notification does NOT: a push
/// payload carries `lock_fund_id` and nothing else. Before this screen existed
/// there was no route that could turn an id into the plan, so every PiggyVault
/// notification — approved, matured, paid out, rolled over — could only land on
/// My Locks and leave the user to find the plan the message was about.
///
/// Three states, all of which a notification tap can genuinely reach:
///
/// * loading — the normal first frame
/// * loaded — hands off to the real detail screen
/// * failed — the plan was cancelled, belongs to another account the user has
///   since switched away from, or the backend is unreachable. Offers My Locks
///   rather than sitting on a spinner, which is what "the page just keeps
///   loading" looked like.
class LockFundDetailsByIdScreen extends StatefulWidget {
  final String lockFundId;

  const LockFundDetailsByIdScreen({super.key, required this.lockFundId});

  @override
  State<LockFundDetailsByIdScreen> createState() =>
      _LockFundDetailsByIdScreenState();
}

class _LockFundDetailsByIdScreenState extends State<LockFundDetailsByIdScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LockFundsCubit>().loadLockFundDetails(widget.lockFundId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LockFundsCubit, LockFundsState>(
      builder: (context, state) {
        if (state is LockFundDetailsLoaded &&
            state.lockFund.id == widget.lockFundId) {
          // Hand over the hydrated plan. The detail screen re-fetches on its
          // own initState, which is a second call we accept: it is the same
          // screen the list pushes, and special-casing it would mean two
          // entry contracts for one screen.
          return LockFundDetailsScreen(lockFund: state.lockFund);
        }
        if (state is LockFundsError) {
          return _Failed(message: state.message);
        }
        return const _Loading();
      },
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Center(child: LazerVaultLoader.small()),
    );
  }
}

class _Failed extends StatelessWidget {
  final String message;

  const _Failed({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.savings_outlined,
                size: 44.sp, color: const Color(0xFFB7ABDA)),
            SizedBox(height: 14.h),
            Text(
              'We could not open this plan',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: const Color(0xFFB7ABDA),
                height: 1.4,
              ),
            ),
            SizedBox(height: 20.h),
            TextButton(
              // offNamed, not toNamed: this screen is the notification's
              // landing, so leaving it on the stack would make Back return to
              // a dead end.
              onPressed: () => Get.offNamed(AppRoutes.lockFunds),
              child: Text(
                'Go to My Locks',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF8B5CF6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
