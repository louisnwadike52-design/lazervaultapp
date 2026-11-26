import 'package:lazervault/core/errors/failure.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/kyc/domain/entities/kyc_tier_entity.dart';
import 'package:lazervault/src/features/kyc/domain/repositories/kyc_repository.dart';

/// Server error codes that mean the failure is OURS, not the customer's.
///
/// One list, because two screens decide "block them or let them through" from
/// it and they must not drift: the BVN gate (bvn_signup_screen) and the NIN
/// resolver below. Matched on the CODE, never the message — these strings are
/// user-facing and get reworded, and the cost of a mismatch is either
/// stranding someone mid-onboarding or waving through a number nobody checked.
///
/// PROVIDER_UNAVAILABLE is the one that matters most in practice: Mono's BVN
/// Lookup product is not enabled on our account, so it is what the BVN branch
/// would answer for every customer the moment an admin turns that branch on.
const Set<String> kIdentityInfrastructureCodes = {
  'PROVIDER_UNAVAILABLE',
  'BANKING_SERVICE_ERROR',
  'SERVICE_UNAVAILABLE',
  'VERIFICATION_ERROR',
  // THE SAME OUTAGE, SPELLED DIFFERENTLY. auth-service answers
  // PROVIDER_NOT_AVAILABLE (auth_identity.go) where banking-service answers
  // PROVIDER_UNAVAILABLE, and because only the second was listed, a provider
  // that is switched off was reported to the customer as their mistake —
  // "check it and try again" against a number they typed correctly, forever.
  'PROVIDER_NOT_AVAILABLE',
  'PROVIDER_ERROR',
  // Our database could not be read during the ownership pre-check. Telling
  // someone to re-check an eleven-digit number is the wrong instruction when
  // the number was never the problem.
  'IDENTITY_CHECK_UNAVAILABLE',
  // The identity WAS verified and only our own write failed. Both are held
  // and retryable server-side; neither is a reason to doubt the number.
  'IDENTITY_STORE_RETRY',
  'VERIFICATION_UPDATE_FAILED',
  // The session the request needs is gone from THIS device. Routed here so it
  // stops rendering as a provider refusal; the screen's own copy explains it.
  'NO_TOKEN',
};

/// True when [code] names a failure the customer cannot do anything about.
bool isIdentityInfrastructureFailure(String? code) =>
    code != null &&
    kIdentityInfrastructureCodes.contains(code.trim().toUpperCase());

/// What happened to the NIN a customer typed during signup.
enum PendingIdentityOutcome {
  /// Nothing was stashed, or the lookup is switched off. Carry on.
  none,

  /// The registry confirmed the number against the name. The official name
  /// (in the registry's own order) is now on `identity_verifications`, which
  /// is what Mono Prove will be initiated with.
  verified,

  /// The registry has this number under a materially different name. The
  /// customer must fix one or the other; nothing was written.
  mismatch,

  /// The number is already linked to another Lazervault account.
  alreadyRegistered,

  /// We could not reach the registry, or it is not enabled. Explicitly NOT a
  /// refusal — the claim is kept and the customer is let through unchanged.
  unavailable,
}

class PendingIdentityResult {
  const PendingIdentityResult(this.outcome, {this.message});

  final PendingIdentityOutcome outcome;
  final String? message;

  /// Whether the customer should be stopped and shown something.
  ///
  /// `unavailable` is deliberately absent: a registry outage is our problem,
  /// not theirs, and blocking onboarding on it would be a strictly worse
  /// position than before any of this existed.
  bool get needsAttention =>
      outcome == PendingIdentityOutcome.mismatch ||
      outcome == PendingIdentityOutcome.alreadyRegistered;
}

/// Resolve the NIN stashed on the signup names page, if there is one.
///
/// WHY IT RUNS HERE AND NOT WHERE IT WAS TYPED. The names page has no
/// authenticated session — on the phone flow the account is created two steps
/// later, and on the legacy flow it is created by the same button press that
/// leaves the page — and `verifyIdentity` resolves the user from the bearer
/// token. So the number is stashed when typed and looked up at the first
/// authenticated moment that needs it, which is immediately before a Mono
/// Prove session is initiated: that is the one place the name actually has to
/// be right, and every onboarding path and every resumption state passes
/// through it.
///
/// IDEMPOTENT. Clears the stash on any terminal outcome, so a second call is a
/// no-op and a billed registry lookup is never repeated for the same number.
/// A transient failure keeps the stash so the next attempt can retry.
///
/// NEVER THROWS. It is called on the path to identity verification; an
/// unhandled error here would break the screen rather than the lookup.
Future<PendingIdentityResult> resolvePendingSignupIdentity({
  required String userId,
  required String firstName,
  required String lastName,
  required String dateOfBirth,
  required String phoneNumber,
}) async {
  final storage = serviceLocator<SecureStorageService>();
  String? nin;
  try {
    nin = await storage.getPendingSignupNin();
  } catch (_) {
    return const PendingIdentityResult(PendingIdentityOutcome.none);
  }
  if (nin == null || nin.trim().length != 11) {
    return const PendingIdentityResult(PendingIdentityOutcome.none);
  }
  if (userId.isEmpty || firstName.trim().isEmpty || lastName.trim().isEmpty) {
    // Without a name there is nothing to check the record against, and
    // sending a blank one would read as a mismatch against every record.
    return const PendingIdentityResult(PendingIdentityOutcome.none);
  }

  try {
    final result = await serviceLocator<KYCRepository>().verifyID(
      IDVerificationRequest(
        userId: userId,
        idType: IDType.nin,
        idNumber: nin.trim(),
        firstName: firstName.trim(),
        lastName: lastName.trim(),
        dateOfBirth: dateOfBirth.trim(),
        phoneNumber: phoneNumber.trim(),
      ),
    );

    return await result.fold<Future<PendingIdentityResult>>(
      (failure) async {
        final code = failure is APIFailure ? (failure.code ?? '') : '';
        switch (code) {
          case 'IDENTITY_DETAILS_MISMATCH':
            await _clear(storage);
            return PendingIdentityResult(
              PendingIdentityOutcome.mismatch,
              message: failure.message,
            );
          case 'IDENTITY_DOB_MISMATCH':
            // THE STASH MUST BE CLEARED OR THIS RE-BILLS FOR EVER.
            //
            // This fell to `default` → `unavailable`, which says nothing to
            // the customer AND leaves the stashed NIN in place. So every
            // later _startVerification ran another billed NIN lookup that
            // failed the same way, silently, and the one fact that would have
            // unblocked them — that their stored date of birth is the
            // blocker — was never surfaced.
            //
            // Reported as a mismatch so the screen routes it to the date
            // editor, which is the remedy the customer can actually apply.
            await _clear(storage);
            return PendingIdentityResult(
              PendingIdentityOutcome.mismatch,
              message: failure.message,
            );
          case 'NIN_ALREADY_REGISTERED':
            await _clear(storage);
            return PendingIdentityResult(
              PendingIdentityOutcome.alreadyRegistered,
              message: failure.message,
            );
          case 'NIN_INVALID_FORMAT':
            // We validated the shape before stashing, so this means the stash
            // is corrupt. Drop it rather than retrying it forever.
            await _clear(storage);
            return const PendingIdentityResult(PendingIdentityOutcome.none);
          default:
            // kIdentityInfrastructureCodes, a transport error, or an
            // unrecognised code — all transient as far as the customer is
            // concerned. Keep the claim and let them through.
            //
            // Note this is deliberately WIDER than the BVN gate's use of the
            // same set: there, an unknown code keeps the customer on a screen
            // where they can retype the number; here the lookup is an
            // enhancement on the way to the Prove widget, so anything we
            // cannot positively attribute to the customer must not stop them.
            return const PendingIdentityResult(
                PendingIdentityOutcome.unavailable);
        }
      },
      (response) async {
        if (!response.success) {
          return const PendingIdentityResult(
              PendingIdentityOutcome.unavailable);
        }
        await _clear(storage);
        return const PendingIdentityResult(PendingIdentityOutcome.verified);
      },
    );
  } catch (_) {
    return const PendingIdentityResult(PendingIdentityOutcome.unavailable);
  }
}

Future<void> _clear(SecureStorageService storage) async {
  try {
    await storage.clearPendingSignupNin();
  } catch (_) {
    // Best effort — a stash we failed to clear costs at most one repeat
    // lookup, which the server answers from the stored row anyway.
  }
}
