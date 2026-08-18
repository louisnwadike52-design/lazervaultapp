import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/kyc/data/services/prove_kyc_http_service.dart';
import 'package:lazervault/src/features/virtual_account/domain/services/va_provisioning_service.dart';

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
  const DepositGateResult(this.status, {this.mintedAccountNumber});
  final DepositReadiness status;
  final String? mintedAccountNumber;
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

  // No NUBAN yet — show the loading overlay from the outset so the tap never
  // looks like it did nothing while we resolve verify + mint.
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
    );
  } catch (_) {
    hideLoader();
    return const DepositGateResult(DepositReadiness.provisioning);
  }
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
