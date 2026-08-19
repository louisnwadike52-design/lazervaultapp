import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/kyc/data/services/prove_kyc_http_service.dart';
import 'package:lazervault/src/features/virtual_account/domain/services/va_provisioning_service.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/usecases/get_account_summaries_usecase.dart';

/// The FAST identity check that must gate EVERY bank-link entry point BEFORE the
/// connection-fee notice / amount sheet (deposit, AI-Analytics, statistics,
/// autosave, direct-debit …). It shows a brief loading overlay so the user never
/// taps and sees "nothing happen", then:
///
///   • tier ≥ 2      → returns true (caller continues to the fee notice / link);
///   • tier < 2      → shows a verify prompt; on "Verify now" routes to BVN KYC
///                     and returns false (the link is aborted — verification
///                     takes over);
///   • error/timeout → returns true (fail-open; the backend re-gates the link).
///
/// The check is a single status call capped at 8s, so it's quick.
Future<bool> ensureVerifiedForBankLink(BuildContext context) async {
  // Loading overlay while the status resolves — dismissed the instant we know
  // the next step, so the user is never staring at a screen doing nothing.
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black54,
    builder: (_) => const Center(
      child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
    ),
  );

  void hideLoader() {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  try {
    final status = await ProveKycHttpService(serviceLocator<SecureStorageService>())
        .status()
        .timeout(const Duration(seconds: 8));
    if (!context.mounted) {
      hideLoader();
      return false;
    }
    hideLoader();
    if (status.tier >= 2) return true;
    return _promptVerify(context);
  } catch (_) {
    hideLoader();
    return true; // fail-open — the backend re-gates the link on the server side
  }
}

/// Outcome of the deposit-readiness gate.
enum DepositReadiness {
  /// The target account already has a real NUBAN (or one was just minted) — the
  /// caller may proceed to the deposit method / fee notice.
  ready,

  /// The account had no NUBAN and the user isn't verified yet — verification has
  /// taken over (routed to BVN KYC). The caller must abort.
  needsKyc,

  /// Verified, but provisioning the NUBAN didn't complete right now — the caller
  /// should show a brief "setting up your account" message and let the user retry.
  provisioning,
}

/// Result of [ensureDepositReady] — the readiness plus the freshly-minted NUBAN
/// (when one was provisioned in this call) so the caller can display it without a
/// round-trip.
class DepositGateResult {
  const DepositGateResult(
    this.status, {
    this.mintedAccountNumber,
    this.mintedAccountName,
    this.mintedBankName,
  });
  final DepositReadiness status;
  final String? mintedAccountNumber;
  final String? mintedAccountName;
  final String? mintedBankName;
}

/// The PRIMARY deposit gate. A deposit can only land if the destination account
/// can RECEIVE money — i.e. a real virtual account (NUBAN) exists for it. This
/// replaces the old "is the user KYC-verified?" gate: KYC/BVN only matters here
/// because a BVN is what lets us MINT the NUBAN (Flutterwave), so it's the
/// fallback, not the primary check.
///
/// Runs the moment the deposit CTA is tapped (before any connection-fee modal):
///   • account already has a NUBAN  → [DepositReadiness.ready] instantly, no
///     spinner, no network (the fast, common path);
///   • no NUBAN + verified (tier≥2) → shows a loading overlay while it mints the
///     NUBAN, then [ready] (or [provisioning] if the mint is still settling);
///   • no NUBAN + unverified         → routes to BVN KYC and returns [needsKyc].
///
/// [accountHasVirtualAccount] is read from the already-loaded account summary
/// (a real NUBAN = non-empty account number on a virtual account), so the happy
/// path costs nothing. Provisioning reuses [VaProvisioningService] (verified
/// check is cached; name/email fall back to secure storage; phone is optional).
Future<DepositGateResult> ensureDepositReady(
  BuildContext context, {
  required bool accountHasVirtualAccount,
  required String currency,
  String locale = 'en-NG',
  String firstName = '',
  String lastName = '',
  String email = '',
  String phoneNumber = '',
  bool isPrimary = false,
}) async {
  // Fast path — the destination can already receive deposits.
  if (accountHasVirtualAccount) {
    return const DepositGateResult(DepositReadiness.ready);
  }

  // No NUBAN yet — show a BLOCKING "Setting up your account" modal from the
  // outset (not a bottomsheet, not a transient snackbar) so the tap never looks
  // like it did nothing, and the user cannot proceed into the deposit flow while
  // we resolve verify + mint. Non-dismissible — it owns the screen until we know
  // the outcome.
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black87,
    builder: (_) => const _AccountSetupModal(),
  );
  void hideLoader() {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  final va = serviceLocator<VaProvisioningService>();
  try {
    if (!await va.isVerified()) {
      // tier < 2 (or status unresolved) → verification takes over.
      hideLoader();
      if (context.mounted) await _promptVerify(context);
      return const DepositGateResult(DepositReadiness.needsKyc);
    }
    // Verified — mint the NUBAN for the destination account now.
    final minted = await va.ensurePersonalVA(
      currency: currency,
      locale: locale,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      isPrimary: isPrimary,
    );
    hideLoader();
    final number = minted?.accountNumber ?? '';
    return DepositGateResult(
      number.isNotEmpty ? DepositReadiness.ready : DepositReadiness.provisioning,
      mintedAccountNumber: number.isNotEmpty ? number : null,
      mintedAccountName: number.isNotEmpty ? minted?.accountName : null,
      mintedBankName: number.isNotEmpty ? minted?.bankName : null,
    );
  } catch (_) {
    hideLoader();
    return const DepositGateResult(DepositReadiness.provisioning);
  }
}

/// The CENTRAL gate that EVERY bank-linking entry point must pass FIRST (deposit,
/// financial-analytics/statistics, LazerBeam, autosave, move-money, the dedicated
/// Link Bank screen …). It uses the SAME virtual-account model as deposits: a bank
/// link only makes sense once the user's account can receive money — i.e. a NUBAN
/// exists, which (by construction) means BVN KYC is already done. So the single
/// check is "does a NGN account number exist?":
///   • yes → proceed to link;
///   • no  → the blocking "Setting up your account" modal mints it (BVN KYC path)
///           or routes to verification, and the link only continues once ready.
/// Returns true when the caller may continue the linking flow.
Future<bool> ensureVirtualAccountForLink(BuildContext context) async {
  bool hasVirtualAccount = false;
  try {
    final userId =
        (await serviceLocator<SecureStorageService>().getUserId())?.trim() ?? '';
    if (userId.isNotEmpty) {
      final res = await serviceLocator<GetAccountSummariesUseCase>()
          .call(userId: userId, country: 'NG');
      hasVirtualAccount = res.fold(
        (_) => false,
        (accounts) => accounts.any((a) =>
            a.currency.toUpperCase() == 'NGN' &&
            (a.accountNumber?.trim().isNotEmpty ?? false)),
      );
    }
  } catch (_) {
    // Fail-open on a lookup hiccup — the backend re-gates the link server-side.
    return true;
  }
  if (hasVirtualAccount) return true;

  // No NUBAN yet — run the SAME deposit-readiness model: blocking setup modal,
  // mint when verified, or route to BVN KYC. The link continues only when ready.
  if (!context.mounted) return false;
  final ready = await ensureDepositReady(
    context,
    accountHasVirtualAccount: false,
    currency: 'NGN',
    isPrimary: true,
  );
  if (ready.status == DepositReadiness.ready) return true;
  if (ready.status == DepositReadiness.provisioning && context.mounted) {
    await showAccountSetupPendingModal(context);
  }
  return false; // not ready (provisioning/KYC) — the link is aborted
}

Future<bool> _promptVerify(BuildContext context) async {
  final go = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: Text(
        'Verify your identity',
        style: GoogleFonts.inter(
            color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700),
      ),
      content: Text(
        'To link a bank account, we need to verify your identity with a quick '
        'BVN check. It only takes a moment.',
        style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF), fontSize: 13.sp, height: 1.4),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: Text('Not now',
              style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600)),
        ),
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(true),
          child: Text('Verify now',
              style: GoogleFonts.inter(
                  color: const Color(0xFF3B82F6),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700)),
        ),
      ],
    ),
  );
  if (go == true) {
    Get.toNamed(AppRoutes.kycBVNVerification, arguments: {'fromDeposit': true});
  }
  return false; // link aborted; verification takes over
}

/// The blocking "Setting up your account" modal shown while the NUBAN is being
/// provisioned. A centered dialog (never a bottomsheet) with a spinner + copy, so
/// the user understands what's happening and cannot proceed until it resolves.
class _AccountSetupModal extends StatelessWidget {
  const _AccountSetupModal();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // can't be dismissed while provisioning is in flight
      child: Dialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 44.r,
                height: 44.r,
                child: const CircularProgressIndicator(
                    strokeWidth: 3, color: Color(0xFF4E03D0)),
              ),
              SizedBox(height: 20.h),
              Text(
                'Setting up your account',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 8.h),
              Text(
                'We\'re creating your deposit account. This only takes a moment — '
                'please don\'t close this screen.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF), fontSize: 13.sp, height: 1.45),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Blocking modal shown when the NUBAN mint didn't complete in this attempt. It
/// PREVENTS continuation of the deposit flow (the caller does not open the method
/// sheet) and tells the user to try again shortly. Dismiss returns to the screen.
Future<void> showAccountSetupPendingModal(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: Row(
        children: [
          Icon(Icons.hourglass_top_rounded,
              color: const Color(0xFFFB923C), size: 20.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text('Almost ready',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
      content: Text(
        'Your deposit account is still being set up. Please give it a moment and '
        'try again shortly — we\'ll take you through once it\'s ready.',
        style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF), fontSize: 13.sp, height: 1.45),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: Text('OK',
              style: GoogleFonts.inter(
                  color: const Color(0xFF4E03D0),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700)),
        ),
      ],
    ),
  );
}
