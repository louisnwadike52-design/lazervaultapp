import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';

import '../../../funds/presentation/widgets/directpay_authorization_sheet.dart';
import '../../cubit/mandate_cubit.dart';
import '../../cubit/mandate_state.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/move_money/domain/mandate_auth_attempt_store.dart';

/// Bottom sheet shown after account linking to offer mandate setup.
///
/// If the user enables Direct Debit and the mandate requires e-mandate
/// authorization, opens the authorization URL in the browser.
Future<bool> showMandateSetupBottomSheet({
  required BuildContext context,
  required String linkedAccountId,
  required String userId,
  required String bankName,
  required String accountName,
  String? userEmail,
  String? userName,
  String? userPhone,
  VoidCallback? onKycRequired,
}) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: const Color(0xFF1F1F1F),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    // MandateCubit is a GetIt singleton; resolve it from the service locator
    // rather than context.read. Callers like the deposit screen provide it
    // INSIDE build() (so the caller's State context sits above that provider
    // and a context.read here throws "Could not find Provider<MandateCubit>").
    // The singleton is the same instance every other call site uses.
    builder: (ctx) => BlocProvider.value(
      value: serviceLocator<MandateCubit>(),
      child: _MandateSetupSheet(
        linkedAccountId: linkedAccountId,
        userId: userId,
        bankName: bankName,
        accountName: accountName,
        userEmail: userEmail,
        userName: userName,
        userPhone: userPhone,
        onKycRequired: onKycRequired,
      ),
    ),
  );
  return result ?? false;
}

class _MandateSetupSheet extends StatefulWidget {
  final String linkedAccountId;
  final String userId;
  final String bankName;
  final String accountName;
  final String? userEmail;
  final String? userName;
  final String? userPhone;
  final VoidCallback? onKycRequired;

  const _MandateSetupSheet({
    required this.linkedAccountId,
    required this.userId,
    required this.bankName,
    required this.accountName,
    this.userEmail,
    this.userName,
    this.userPhone,
    this.onKycRequired,
  });

  @override
  State<_MandateSetupSheet> createState() => _MandateSetupSheetState();
}

class _MandateSetupSheetState extends State<_MandateSetupSheet> {
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // The spent-link guard reads the local stamp synchronously; make sure it's
    // hydrated even when this sheet is reached without visiting the deposit
    // screen first (Beam, autosave, linked-accounts). Safe to call repeatedly.
    MandateAuthAttemptStore.hydrate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MandateCubit, MandateState>(
      listener: (context, state) async {
        if (state is MandateCreated) {
          // Capture the Navigator + cubit BEFORE any await so we never do an
          // inherited-widget lookup on a context that may be deactivated after
          // the await (that's what threw "Looking up a deactivated widget's
          // ancestor").
          final navigator = Navigator.of(context);
          final cubit = context.read<MandateCubit>();
          if (state.needsAuthorization && state.authorizationUrl != null) {
            // SPENT-LINK GUARD: if this device already opened this mandate's
            // authorization recently, the payment leg is likely done and Mono
            // is confirming it at the bank (up to ~30 min) — the link is spent
            // and reopening it dead-ends in Mono's "Configuration error".
            // Poll instead and tell the user it completes automatically.
            if (state.mandate.authAttemptedRecently ||
                MandateAuthAttemptStore.openedRecently(state.mandate.id)) {
              cubit.pollMandateStatus(
                mandateId: state.mandate.id,
                userId: widget.userId,
              );
              Get.snackbar(
                'Confirming with your bank',
                'Your authorization was received and is being confirmed by '
                    'your bank — this can take up to 30 minutes and completes '
                    'automatically. No need to authorize again.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.92),
                colorText: Colors.white,
                duration: const Duration(seconds: 5),
              );
              if (mounted) navigator.pop(true);
              return;
            }
            // Authorize the mandate IN-APP. This used to bounce to an external
            // browser (LaunchMode.externalApplication) with no progress and no
            // status refresh on return. Reuse the shared Mono webview sheet in
            // mandate mode; on a successful authorization, poll the mandate so
            // its status flips to authorized/ready/active in the UI.
            final authResult = await showDirectPayAuthorizationSheet(
              context: context,
              paymentUrl: state.authorizationUrl!,
              paymentId: state.mandate.id,
              reference: state.mandate.reference,
              redirectPath: '/mandate/callback',
              flow: DirectPayFlow.mandate,
            );
            // Stamp ONLY on the explicit success callback — merely opening the
            // widget means nothing (a user can open/close it at will) and must
            // NOT flip the badge to "Setting up". A granted authorization is
            // the real signal: from here the mandate is provisioning with the
            // bank/NIBSS, so surfaces show "Setting up" while Mono converges.
            // Server-side stamp so ANY device (relogin, other phone) sees it —
            // the local store is only the offline fallback.
            if (authResult.success) {
              await MandateAuthAttemptStore.markOpened(state.mandate.id);
              unawaited(cubit.markAuthAttempt(state.mandate.id));
              cubit.pollMandateStatus(
                mandateId: state.mandate.id,
                userId: widget.userId,
              );
            }
            // Pop with the AUTHORIZATION outcome, not a blanket success: when
            // the user closes the Mono webview, the mandate is stranded in
            // awaiting_authorization and callers must not treat the setup as
            // done (the deposit card shows "Finish setup" to resume it).
            if (mounted) navigator.pop(authResult.success);
            return;
          }
          if (mounted) navigator.pop(true);
        } else if (state is MandateError) {
          if (!mounted) return;
          // KYC gate: Direct Debit needs a verified BVN/NIN. When the backend
          // returns KYC_REQUIRED, close the sheet and route the user into the
          // KYC flow instead of showing a raw error they can't act on.
          final lower = state.message.toLowerCase();
          if (lower.contains('kyc_required') ||
              lower.contains('verify your identity') ||
              lower.contains('verify') && lower.contains('bvn')) {
            // Close the sheet first.
            Navigator.of(context).pop(false);
            // When a caller (e.g. the deposit screen) supplies a handler, let
            // IT own the KYC detour so it can save the in-flight deposit
            // context and route back to resume afterwards. Otherwise fall back
            // to the standalone behaviour (Beam mandate management): just send
            // the user to KYC.
            if (widget.onKycRequired != null) {
              widget.onKycRequired!();
              return;
            }
            Get.snackbar(
              'Verify your identity',
              'Complete a quick BVN verification to set up Direct Debit.',
              snackPosition: SnackPosition.BOTTOM,
            );
            Get.toNamed(AppRoutes.kycBVNVerification);
            return;
          }
          setState(() {
            _errorMessage = state.message;
          });
        }
      },
      builder: (context, state) {
        final isLoading = state is MandateLoading;

        return Padding(
          padding: EdgeInsets.fromLTRB(
            20.w,
            16.h,
            20.w,
            MediaQuery.of(context).viewInsets.bottom + 20.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF6B7280),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 24.h),

              // Shield icon
              Container(
                width: 64.w,
                height: 64.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.verified_user_rounded,
                  color: const Color(0xFF10B981),
                  size: 32.sp,
                ),
              ),
              SizedBox(height: 16.h),

              // Title
              Text(
                'Enable Direct Debit',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8.h),

              // Bank info
              Text(
                '${widget.bankName} - ${widget.accountName}',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(height: 12.h),

              // Explanation
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  'Authorize once to skip bank login for future transfers. '
                  'You set limits and can cancel anytime.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              // Benefits
              _buildBenefitRow(Icons.flash_on_rounded, 'Instant transfers — no bank approval each time'),
              _buildBenefitRow(Icons.lock_outline_rounded, 'You control limits & can cancel'),
              _buildBenefitRow(Icons.shield_outlined, 'Bank-level security & encryption'),
              SizedBox(height: 16.h),

              // Inline error message
              if (_errorMessage != null) ...[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: const Color(0xFFEF4444).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        color: const Color(0xFFEF4444),
                        size: 18.sp,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          'Failed to enable Direct Debit. Please try again.',
                          style: GoogleFonts.inter(
                            color: const Color(0xFFFCA5A5),
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
              ],

              // Enable button
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          setState(() => _errorMessage = null);
                          context.read<MandateCubit>().createMandate(
                                userId: widget.userId,
                                linkedAccountId: widget.linkedAccountId,
                                userEmail: widget.userEmail,
                                userName: widget.userName,
                                userPhone: widget.userPhone,
                              );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    disabledBackgroundColor:
                        const Color(0xFF10B981).withValues(alpha: 0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: isLoading
                      ? LazerVaultLoader.small()
                      : Text(
                          'Enable Direct Debit',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 12.h),

              // Not now button
              TextButton(
                onPressed: isLoading ? null : () => Navigator.of(context).pop(false),
                child: Text(
                  'Not Now',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBenefitRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF10B981), size: 18.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                color: const Color(0xFFD1D5DB),
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
