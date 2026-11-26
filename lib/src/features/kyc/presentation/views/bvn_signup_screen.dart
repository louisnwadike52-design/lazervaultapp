import 'package:lazervault/core/utils/dob_display.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/utilities/safe_back_button.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;

import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/errors/failure.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/bvn_lookup_consent_sheet.dart';
import 'package:lazervault/src/features/kyc/data/services/bvn_lookup_http_service.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/kyc_gate_exit_cta.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/kyc_profile_fix.dart';
import 'package:lazervault/src/features/kyc/domain/pending_signup_identity.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/support/data/support_api.dart';
import 'package:lazervault/src/features/support/presentation/support_contact_cta.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/logger.dart';
import 'package:lazervault/core/network/network_timeouts.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/kyc/domain/entities/kyc_tier_entity.dart';
import 'package:lazervault/src/features/kyc/presentation/cubits/kyc_cubit.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/data_reconciliation_dialog.dart';
import '../../../profile/domain/repositories/i_profile_repository.dart';

/// Mandatory BVN capture in the signup flow — sits AFTER the personal-info /
/// transaction-PIN steps and BEFORE dashboard access.
///
/// The BVN is verified independently (auth-service `verifyIdentity` → banking,
/// which mints the Flutterwave virtual account off a valid BVN) so a real NUBAN
/// exists before the user reaches the dashboard. On success we persist the BVN
/// (encrypted) via [SecureStorageService.saveBvn] so the optional Mono Prove
/// widget can pre-fill it instead of starting empty.
///
/// Mono KYC remains skippable; the BVN here is not. Flutterwave's VA creation
/// only needs the BVN (name/DOB come from the earlier signup pages), so this
/// screen collects nothing else.
/// Which government number this screen is collecting.
///
/// EXACTLY ONE IS EVER SHOWN. The admin switch `bvn_signup_screen_enabled`
/// picks it: on → [bvn], off → [nin]. They are never both asked for here —
/// a second number is what the optional Mono widget collects later, and
/// asking for two 11-digit numbers before anyone has seen the dashboard is
/// how onboarding loses people.
///
/// One screen rather than two files: the styling, the 11-digit entry, the
/// name-reconciliation sheet, the fail-open-on-outage rule and the gate exit
/// are identical, and a copy would drift the moment one side was fixed.
enum IdentityKind {
  bvn,
  nin;

  bool get isBvn => this == IdentityKind.bvn;

  /// The admin-selected kind. Read once per screen build.
  static IdentityKind get active =>
      FeatureFlags.isBvnSignupScreenEnabled() ? IdentityKind.bvn : IdentityKind.nin;

  String get label => isBvn ? 'BVN' : 'NIN';

  IDType get idType => isBvn ? IDType.bvn : IDType.nin;

  String get analyticsScope => isBvn ? 'kyc_bvn_signup' : 'kyc_nin_signup';
}

class BVNSignupScreen extends StatelessWidget {
  const BVNSignupScreen({super.key, this.kind});

  /// Overrides the admin-selected kind. Only for tests and for a caller that
  /// deliberately wants one specific screen.
  final IdentityKind? kind;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<KYCCubit>(
      create: (_) => serviceLocator<KYCCubit>(),
      child: _BVNSignupView(kind: kind ?? IdentityKind.active),
    );
  }
}

class _BVNSignupView extends StatefulWidget {
  const _BVNSignupView({required this.kind});

  final IdentityKind kind;

  @override
  State<_BVNSignupView> createState() => _BVNSignupViewState();
}

class _BVNSignupViewState extends State<_BVNSignupView> {
  static const Color _brandPurple = Color(0xFF4834D4);
  static const Color _brandPurpleDeep = Color(0xFF2D2B6B);

  final TextEditingController _bvnController = TextEditingController();
  final FocusNode _bvnFocus = FocusNode();

  bool _obscure = false;
  bool _submitting = false;
  String? _inlineError;

  /// Whether [_inlineError] is something a retry could actually clear.
  ///
  /// THE GAP: every inline refusal rendered as red helper text under the
  /// field, and the only way to act on it was to notice that the CTA was
  /// still live and press it again. For "We couldn't start the check" — a
  /// transient provider failure, the commonest of them — that is the entire
  /// remedy, and it was invisible. A customer who reads "try again" and sees
  /// no way to try again concludes the app is stuck.
  ///
  /// False for refusals a retry cannot clear (a malformed number is fixed by
  /// typing, not by pressing), so the control never promises a different
  /// answer to the same input.
  bool _inlineRetryable = false;

  /// The name decision the customer closed without answering.
  ///
  /// Held so it can be RE-OPENED. The verification is already sitting on the
  /// server waiting for one of two action strings; re-running the lookup to
  /// get back to the same question would cost a second Mono session and a
  /// second code to the holder's phone, for a decision we already have in
  /// hand. Cleared the moment it is answered or the number changes.
  NameConfirmationRequired? _pendingNameConfirmation;

  /// The operator-published support address, or null when none is configured.
  ///
  /// FETCHED ONCE, LAZILY, AND NEVER AWAITED BY THE UI. This screen gates the
  /// account, so nothing it renders may depend on a settings call completing:
  /// a null address simply removes the "or email us" line. The value is read
  /// at init so it is already in hand by the time a refusal needs it, rather
  /// than fetched inside a dialog builder where a slow network would show an
  /// empty row and then pop it in.
  String? _supportEmail;

  Future<void> _loadSupportEmail() async {
    try {
      final settings =
          await SupportApi(serviceLocator<SecureStorageService>())
              .supportSettings();
      if (!mounted) return;
      setState(() => _supportEmail = settings.contactEmail);
    } catch (_) {
      // Leave it null — the line is optional by design.
    }
  }

  bool get _isValid => _bvnController.text.trim().length == 11;

  @override
  void initState() {
    super.initState();
    // Fire and forget — see _loadSupportEmail.
    _loadSupportEmail();
    _bvnController.addListener(() {
      if (_inlineError != null) {
        setState(() {
          _inlineError = null;
          _inlineRetryable = false;
          // A different number is a different verification; the held
          // decision belongs to the old one.
          _pendingNameConfirmation = null;
        });
      }
      setState(() {}); // refresh CTA enabled-state + counter
    });
    AppLogger.event(widget.kind.analyticsScope, 'screen_open',
        screen: widget.kind.isBvn ? 'bvn_signup' : 'nin_signup');
  }

  @override
  void dispose() {
    _bvnController.dispose();
    _bvnFocus.dispose();
    super.dispose();
  }

  ({
    String firstName,
    String lastName,
    String phone,
    String userId,
    String dateOfBirth
  }) _profile() {
    try {
      final profile = context.read<AuthenticationCubit>().currentProfile;
      if (profile != null) {
        return (
          firstName: profile.user.firstName,
          lastName: profile.user.lastName,
          phone: profile.user.phoneNumber ?? '',
          userId: profile.user.id,
          dateOfBirth: profile.user.dateOfBirth ?? '',
        );
      }
    } catch (_) {/* profile not available yet — backend resolves what it can */}
    return (
      firstName: '',
      lastName: '',
      phone: '',
      userId: '',
      dateOfBirth: ''
    );
  }

  void _submit() {
    FocusManager.instance.primaryFocus?.unfocus();
    final bvn = _bvnController.text.trim();
    if (bvn.length != 11) {
      setState(() =>
          _inlineError = 'Your ${widget.kind.label} must be exactly 11 digits.');
      return;
    }
    final p = _profile();
    setState(() {
      _submitting = true;
      _inlineError = null;
    });
    AppLogger.event(widget.kind.analyticsScope, 'verify_start',
        screen: widget.kind.isBvn ? 'bvn_signup' : 'nin_signup');

    // TWO PROVIDERS, TWO SHAPES. A NIN is one silent lookup, so it stays on
    // the cubit's one-shot verifyID. A BVN is NIBSS-regulated and needs the
    // holder's CONSENT: Mono sends them a one-time code and we exchange it.
    // That cannot happen behind a spinner — it needs a delivery-method
    // chooser and an OTP step — so it runs its own flow.
    if (widget.kind.isBvn) {
      unawaited(_runBvnConsentFlow(bvn, p));
      return;
    }

    context.read<KYCCubit>().verifyID(
          IDVerificationRequest(
            userId: p.userId,
            idType: widget.kind.idType,
            idNumber: bvn,
            firstName: p.firstName,
            lastName: p.lastName,
            // SEND THE DATE OF BIRTH. It used to be '' with a note that the
            // server would validate it from the signup pages — but the server
            // only compares a DOB when BOTH sides are non-empty, so sending
            // nothing silently skipped the check. That matters now: the name
            // on a matching record is adopted automatically, and the date of
            // birth is the thing standing between "my name is registered the
            // other way round" and "this number belongs to someone else".
            dateOfBirth: p.dateOfBirth,
            phoneNumber: p.phone,
          ),
        );
  }

  Future<void> _onVerified() async {
    // Persist the verified BVN (encrypted) so the optional Mono Prove widget can
    // pre-fill it later instead of starting empty.
    try {
      final storage = serviceLocator<SecureStorageService>();
      final number = _bvnController.text.trim();
      if (widget.kind.isBvn) {
        await storage.saveBvn(number);
      } else {
        // Both stores' contract is "verified only", which this now satisfies —
        // the server confirmed the number against the registry before we got
        // here. The Mono widget pre-fills from whichever is on file.
        await storage.saveNin(number);
      }
      // A signup-page stash is a CLAIM, and this is now a fact stored
      // server-side, so drop it rather than leave it to be looked up again.
      await storage.clearPendingSignupNin();
    } catch (_) {/* non-fatal — verification already succeeded server-side */}
    // ONBOARDING IS OVER FOR THE BVN BRANCH — SAY SO IN STORAGE.
    //
    // `kyc_onboarding_pending` is written at passcode setup and read by the
    // boot router as "take this person to verification". A verified BVN is
    // Tier 2, which reads as verified, so the router WOULD clear it — but
    // only from the tier it cached at the last full login. A customer who
    // reaches Tier 2 after that login has a stale Tier-1 snapshot, and the
    // next launch would march them to the Mono gate this branch exists to
    // remove from onboarding.
    //
    // Cleared on BOTH secure-storage backends because the signup cubit writes
    // with the default config while main.dart reads with
    // encryptedSharedPreferences — different stores on Android.
    //
    // NOT cleared for the NIN branch: a NIN is Tier 1 and the Mono gate is
    // still genuinely outstanding there, so the flag is still true.
    if (widget.kind.isBvn) {
      for (final store in const [
        FlutterSecureStorage(),
        FlutterSecureStorage(
          aOptions: AndroidOptions(
            encryptedSharedPreferences: true,
            resetOnError: true,
          ),
        ),
      ]) {
        try {
          await store.delete(key: 'kyc_onboarding_pending');
        } catch (_) {/* best-effort on both backends */}
      }
    }
    // CARRY THE VERIFIED PROFILE TO THE DASHBOARD.
    //
    // Verification has just changed the account server-side and told this
    // screen nothing: banking-service adopts the registry's spelling of the
    // name onto the profile, raises `kyc_tier` and sets `identity_verified`.
    // Navigating on the copy loaded at login landed the holder on a dashboard
    // greeting them by the name the registry had just replaced, with every
    // tier gate reading the old tier — the app offering Tier-1 limits while
    // the ledger enforced Tier 2.
    //
    // The QUIET refresh, not `refreshProfile`: that one emits
    // AuthenticationSuccess, which every login surface answers with
    // `goAfterLogin` — a second router replacing the stack a frame before the
    // `offAllNamed` below does.
    //
    // Bounded with `probe`, and failure is not surfaced. The customer is
    // verified and waiting to be let in; a slow profile read must not hold
    // the door, and the backend re-checks KYC at every operation boundary
    // regardless.
    if (mounted) {
      try {
        await context
            .read<AuthenticationCubit>()
            .refreshProfileQuietly()
            .timeout(NetworkTimeouts.probe);
      } catch (_) {/* stale name or tier is better than a stuck spinner */}
    }
    if (!mounted) return;
    Get.offAllNamed(_nextRoute());
  }

  /// Where onboarding goes once this screen is done.
  ///
  /// THE TWO BRANCHES END IN DIFFERENT PLACES, and getting it wrong is silent
  /// — both "work", one just strands the customer.
  ///
  ///   BVN -> the DASHBOARD. A verified BVN is Tier 2, which publishes
  ///          kyc.tier.upgrade and mints the account number. Onboarding is
  ///          genuinely finished, and the Mono widget becomes a limit upgrade
  ///          started from Settings, or from the prompt the transfer screens
  ///          now show when a cap stops someone.
  ///   NIN -> the MONO GATE. A NIN alone is a Tier 1 identity and mints
  ///          NOTHING, so the dashboard would leave a wallet that cannot
  ///          receive a bank transfer and no explanation of why. The NIN's job
  ///          was to put the registered name on file so the widget opens with
  ///          a name the registry agrees with; the widget still earns the
  ///          account number.
  ///
  /// An explicit `nextRoute` argument wins, for callers that open this screen
  /// as a step inside some other flow.
  String _nextRoute() {
    final args = Get.arguments;
    if (args is Map && args['nextRoute'] is String) {
      return args['nextRoute'] as String;
    }
    return widget.kind.isBvn
        ? AppRoutes.dashboard
        : AppRoutes.kycBVNVerification;
  }

  /// Mono's three-step BVN consent flow, end to end.
  ///
  /// Every exit resets `_submitting` or leaves the screen, because this gate
  /// has no skip: a spinner left running here is a customer who cannot
  /// proceed and cannot retry.
  Future<void> _runBvnConsentFlow(
    String bvn,
    ({
      String firstName,
      String lastName,
      String phone,
      String userId,
      String dateOfBirth
    }) p,
  ) async {
    final service = BvnLookupHttpService(serviceLocator<SecureStorageService>());

    // ── Step 1: open the consent session ─────────────────────────────────
    //
    // A NEW SESSION MEANS A NEW BUDGET. The server replaces the session here
    // (StartBVNLookup overwrites unconditionally), so the three date-of-birth
    // corrections it allows start again. Carrying the old tally forward
    // refused a customer who had just paid for this lookup.
    _dobCorrectionsUsed = 0;
    final start = await service.initiate(bvn);
    if (!mounted) return;

    if (!start.ok) {
      if (start.infrastructure) {
        // Our outage — but NOT a reason to hand out an un-minted dashboard.
        // Tier 2 is what creates the account number, so "letting them
        // through" leaves a wallet that cannot receive money and no
        // explanation. Offer the two things that can actually finish it.
        AppLogger.event(widget.kind.analyticsScope,
            'verify_unavailable_blocked',
            level: 'warn', screen: 'bvn_signup');
        setState(() => _submitting = false);
        _showCannotVerifyDialog(
          title: 'We couldn\'t start the check',
          body: 'Our verification partner did not respond. This is on our '
              'side — try again in a moment, or use the full verification '
              'instead.',
        );
        return;
      }
      if (start.alreadyRegistered) {
        setState(() => _submitting = false);
        _showSupportNeededDialog('BVN_ALREADY_REGISTERED', start.message);
        return;
      }
      setState(() {
        _submitting = false;
        // A refusal from the provider, not a typo we can see: offer the retry
        // explicitly rather than leaving the customer to guess the CTA still
        // works.
        _inlineRetryable = true;
        _inlineError = start.message.isNotEmpty
            ? start.message
            : 'We couldn\'t start the check. Please check the number and try again.';
      });
      return;
    }

    if (start.methods.isEmpty) {
      // A session Mono will not deliver to cannot be completed, and an empty
      // chooser is the worst possible thing to show.
      //
      // THIS USED TO END IN AN INLINE ERROR AND NOTHING ELSE — including the
      // words "or continue for now", pointing at an escape hatch that was
      // removed when the dashboard became Tier-2-gated. So the one customer
      // whose bank holds no contact details at all got a sentence, a gate
      // with no skip, and no next move anywhere on the screen.
      //
      // It is the SAME SITUATION as every route refusing (undeliverable),
      // which already routes to the full check — Mono Prove verifies with a
      // liveness check and does not touch the contact details NIBSS holds, so
      // it works precisely when this fails. Treating the two alike also means
      // there is one answer to maintain, not two that can drift.
      AppLogger.event(widget.kind.analyticsScope, 'verify_no_methods_to_prove',
          level: 'warn', screen: 'bvn_signup');
      setState(() => _submitting = false);
      _showCannotVerifyDialog(
        offerRetry: false,
        title: 'Your bank has no contact details for this BVN',
        body: 'We can\'t send you a code because your bank has no email or '
            'phone number registered against this BVN. Ask them to update it '
            '— or use the full verification, which checks you with a quick '
            'liveness check instead of a code.',
      );
      return;
    }

    // Held for a date-of-birth correction: that call re-runs the server's
    // reconciliation, and it must assert the SAME name this attempt did.
    // Sending anything else would turn a date correction into a name change
    // and could refuse for a different reason entirely.
    _assertedFirstName = p.firstName;
    _assertedLastName = p.lastName;

    // ── Steps 2 + 3: choose a route, then enter the code ─────────────────
    final outcome = await showBvnLookupConsentSheet(
      context: context,
      service: service,
      methods: start.methods,
      firstName: p.firstName,
      lastName: p.lastName,
      dateOfBirth: p.dateOfBirth,
    );
    if (!mounted) return;

    switch (outcome) {
      case BvnConsentOutcome.verified:
        await _onVerified();
      case BvnConsentOutcome.unavailable:
        setState(() => _submitting = false);
        _showCannotVerifyDialog(
          title: 'We couldn\'t reach our verification partner',
          body: 'This is on our side, not yours. Try again in a moment, or '
              'use the full verification instead.',
        );
      case BvnConsentOutcome.undeliverable:
        // Every route their bank registered has refused. Not an outage, and
        // nothing they can fix from this app — the record is corrected at
        // their bank.
        //
        // OFFER THE OTHER ROUTE RATHER THAN THE DASHBOARD. Mono Prove does
        // NOT depend on the contact details NIBSS holds: it verifies by
        // liveness plus the ID number typed in its own widget. So a customer
        // whose BVN-registered SIM is dead can still reach Tier 3 that way —
        // and dropping them at the dashboard instead would leave the one
        // person with no alternative believing they had none.
        //
        // `skipBvnLookup` is essential: without it the gate's own
        // interception would send them straight back to the lookup that just
        // failed, forever.
        AppLogger.event(widget.kind.analyticsScope, 'verify_undeliverable_to_prove',
            level: 'warn', screen: 'bvn_signup');
        _offerProveInstead();
      case BvnConsentOutcome.alreadyRegistered:
        setState(() => _submitting = false);
        _showSupportNeededDialog('BVN_ALREADY_REGISTERED', null);
      case BvnConsentOutcome.dobMismatch:
        // NO LONGER A DEAD END.
        //
        // This went straight to support, because a date of birth could not be
        // edited anywhere in the app. But the refusal means the code WORKED
        // and the registry returned the record — the only thing wrong is a
        // date the customer knows and we had stored incorrectly. The server
        // now holds that record open, so they can give the right date and
        // finish with no second lookup and no second SMS.
        setState(() => _submitting = false);
        _showDobCorrectionDialog();
      case BvnConsentOutcome.dobExhausted:
        // Every correction is spent and the server has dropped the session.
        // Straight to support — the one outcome where a person really is the
        // next step, and the only one the old code reached for every DOB
        // refusal including the first.
        setState(() => _submitting = false);
        _showSupportNeededDialog('IDENTITY_DOB_EXHAUSTED', null);
      case BvnConsentOutcome.nameMismatch:
        // The number and the code were both right; the NAME is what
        // disagrees. Offer the editor, not a retry.
        setState(() => _submitting = false);
        _showNameMismatchDialog();
      case BvnConsentOutcome.sessionExpired:
        // The server holds the session in memory for ~15 minutes and a
        // restart drops it. The BVN stays in the field — retyping it is
        // pointless friction — so this is just "tap again".
        setState(() {
          _submitting = false;
          // The copy named the CTA because there was nothing else to name.
          // There is now a Try again control on the error itself.
          _inlineRetryable = true;
          _inlineError = 'That check timed out — nothing was lost. '
              'Start it again when you\'re ready.';
        });
      case BvnConsentOutcome.storeRetry:
        // THE CHECK PASSED. OUR WRITE DID NOT.
        //
        // The record is held server-side and the next completion retries the
        // write — no second Mono lookup, no second SMS, and the OTP already
        // spent is not asked for again. So this is a retry the customer can
        // actually win, which is why it gets the Try again control rather
        // than a dead sentence.
        //
        // NOT worded as their mistake. It was ours, and the previous
        // behaviour — the server's sentence in the red box under the OTP
        // field — read as "your code is wrong" on a code that was right.
        setState(() {
          _submitting = false;
          _inlineRetryable = true;
          _inlineError = 'Your ${widget.kind.label} checked out, but we '
              'couldn\'t save it just now. Tap Try again — you won\'t need '
              'a new code.';
        });
      case BvnConsentOutcome.dismissed:
        // Nothing is lost: the server session is still open, so tapping
        // again resumes at the chooser without re-entering the BVN.
        setState(() => _submitting = false);
    }
  }

  /// Hand an undeliverable customer the verification route that does not
  /// need their bank's contact details.
  ///
  /// Pushed rather than offAllNamed when there is somewhere to go back to, so
  /// a customer who reached this from Settings returns to Settings. When this
  /// screen IS the onboarding root there is nothing to pop, so the gate
  /// replaces it and owns the journey from there.
  void _offerProveInstead() {
    if (!mounted) return;
    const args = {'skipBvnLookup': true};
    if (Navigator.of(context).canPop()) {
      Get.toNamed(AppRoutes.kycBVNVerification, arguments: args);
      setState(() => _submitting = false);
      return;
    }
    Get.offAllNamed(AppRoutes.kycBVNVerification, arguments: args);
  }

  /// What a support ticket for [code] should say, so the agent can act on the
  /// first reply instead of asking what happened.
  ///
  /// THE LAST FOUR DIGITS ONLY. Enough for an agent to match the number
  /// against the account they already hold, without writing a full government
  /// identity number into a support thread that is stored, searchable and
  /// read by more people than the account itself.
  ({String subject, String message}) _supportTicketFor(String code) {
    final id = widget.kind.label; // "BVN" or "NIN"
    final typed = _bvnController.text.trim();
    final tail = typed.length >= 4 ? typed.substring(typed.length - 4) : '';
    final ref = tail.isEmpty ? '' : ' ending $tail';
    if (code.trim().toUpperCase().endsWith('ALREADY_REGISTERED')) {
      return (
        subject: '$id already linked to another account',
        message: 'I tried to verify my $id$ref during sign-up and was told it '
            'is already linked to another Lazervault account.\n\n'
            'The $id is mine. Please can you check which account holds it and '
            'release it so I can finish verifying?\n\n'
            '(Sent from the verification screen — reference: $code)',
      );
    }
    return (
      subject: 'Date of birth does not match my $id',
      message: 'I tried to verify my $id$ref during sign-up and was told the '
          'date of birth on my profile does not match the one registered to '
          'it.\n\n'
          // NEVER CLAIM SOMETHING THE SENDER DID NOT EXPERIENCE. This said,
          // in the customer's own name, that the app refused to let them
          // change the date because their identity was already verified. On
          // the three-step lookup path that is simply false — it never sets
          // identity_verified, as this file documents — and an agent acting
          // on it would chase a flag that was never set.
          'I used the tries the check allows and the date still did not '
          'match. Please can you check it with me and correct my profile so '
          'I can finish verifying?\n\n'
          '(Sent from the verification screen — reference: $code)',
    );
  }

  /// Refusals no amount of retyping can clear.
  /// IDENTITY_DOB_MISMATCH WAS HERE AND IS NOT ANY MORE.
  ///
  /// It was support-only because no screen in this app could edit a date of
  /// birth. One can now (KycProfileField.dateOfBirth), so routing it here would
  /// send a customer to a human to retype a date they know, which is what
  /// stranded one on the last screen of onboarding on 2026-11-10. It still
  /// reaches support when the server refuses the edit — which it does once the
  /// identity is verified — but that refusal is the server's to make, not a
  /// blanket rule here.
  static const _supportOnlyCodes = {
    'BVN_ALREADY_REGISTERED',
    'NIN_ALREADY_REGISTERED',
  };

  bool _needsAHuman(String code) =>
      _supportOnlyCodes.contains(code.trim().toUpperCase());

  /// A name that disagrees with the registry, and the two ways out.
  ///
  /// NO REGISTRY NAME IS SHOWN. On a refusal the server has evidence the
  /// asker may not be the holder, so echoing the name on that record would
  /// hand one customer another person's name — the same reason
  /// ProveKycStatus leaves bvnName empty for `name_mismatch`.
  /// Offer the date-of-birth editor on the ONE-SHOT verification path.
  ///
  /// Distinct from [_showDobCorrectionDialog], which resumes a HELD session: no
  /// session exists here, so the correction is written to the profile and the
  /// whole verification is re-run. Retried only on a real change — retrying
  /// against an unchanged profile reproduces the identical refusal, which is
  /// the loop kyc_profile_fix.dart exists to prevent.
  /// [missingNotMismatched] distinguishes the two refusals that land here, and
  /// it only changes the SUPPORT copy — the editor itself is the same. A
  /// customer with no date of birth on file is asking us to add one; a
  /// customer whose date disagrees with the registry is asking us to correct
  /// one. A ticket that describes the wrong problem costs a round trip with an
  /// agent, so the subject has to say which it is.
  Future<void> _offerDobEdit({bool missingNotMismatched = false}) async {
    final changed = await openKycProfileFix(
      KycProfileField.dateOfBirth,
      supportSubject: missingNotMismatched
          ? 'Please add my date of birth so I can verify'
          : 'Date of birth does not match my ${widget.kind.label}',
      supportMessage: missingNotMismatched
          ? 'My account has no date of birth, so my ${widget.kind.label} '
              'cannot be checked against one.\n\n'
              'Please can you add it so I can finish verifying?'
          : 'My ${widget.kind.label} is correct but verification says the date '
              'of birth on my profile does not match the one registered to it, '
              'and I cannot change it myself.',
    );
    if (!mounted) return;
    if (changed) {
      _submit();
    }
  }

  /// How many corrections the SERVER allows before it drops the held record.
  /// Mirrored here only so the copy can count down; the server is the
  /// authority and refuses on its own once the cap is reached.
  static const int _dobCorrectionLimit = 3;

  /// Corrections spent against the CURRENT server session.
  ///
  /// RESET WHEN A NEW SESSION IS OPENED, and that is not a detail. The server
  /// replaces the session on every `initiate`, so a fresh lookup carries a
  /// fresh three-attempt budget. This counter did not know that: it only ever
  /// incremented, so a customer who exhausted their tries, paid for a SECOND
  /// billed lookup and a second SMS, and typed the new code correctly, was met
  /// by `remaining <= 0` and sent straight to support — the date picker never
  /// opened, and the server had refused nothing.
  int _dobCorrectionsUsed = 0;

  /// The name asserted by the attempt that is currently held open.
  String _assertedFirstName = '';
  String _assertedLastName = '';

  /// Let the customer give the date of birth registered against their BVN.
  ///
  /// WHY A CORRECTION AND NOT A SUPPORT TICKET. The refusal that brings us
  /// here means everything else was right: the number, and the one-time code
  /// the customer had just typed correctly. Sending them to support over a
  /// field they know the answer to — and which only disagreed because our
  /// profile copy was wrong — left them stuck at the last step of onboarding
  /// with no account number. On 2026-11-10 a customer hit it twice in ninety
  /// seconds, and because the refusal also dropped the session, his next
  /// attempt re-issued a code and the one on his screen went stale: he was
  /// told a correct code did not match.
  ///
  /// NOTHING IS ECHOED. The registry's date is never shown or pre-filled. It
  /// is the one piece of corroboration standing between a mistyped-but-valid
  /// number and somebody else's identity, so showing it would hand over the
  /// answer to the only question being asked. The customer tells US.
  /// [serverMessage] is what the server said about the LAST attempt. It is
  /// preferred over anything composed here because the server is the only side
  /// that knows how many attempts remain — it counts them on the held session,
  /// which survives this screen being rebuilt, backed out of, or reopened.
  Future<void> _showDobCorrectionDialog({String serverMessage = ''}) async {
    final remaining = _dobCorrectionLimit - _dobCorrectionsUsed;
    if (remaining <= 0) {
      // A LOCAL BACKSTOP, NOT THE AUTHORITY.
      //
      // The server decides when the tries are gone (IDENTITY_DOB_EXHAUSTED)
      // and this screen routes on that. This check only stops the dialog
      // reopening in the one case the server has not spoken yet, and it
      // deliberately uses the EXHAUSTED code so support sees the real reason.
      _showSupportNeededDialog('IDENTITY_DOB_EXHAUSTED', null);
      return;
    }
    final hint = serverMessage.trim();
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
        title: Text('Check your date of birth',
            style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w700)),
        content: Text(
          _dobCorrectionsUsed == 0
              ? 'Your code was correct. The date of birth we have on your '
                  'profile is different from the one registered to this '
                  '${widget.kind.label} — pick the right one and we\'ll finish '
                  'without sending you another code.'
              // The server's wording carries the real remaining count. Falling
              // back to the local one only when it said nothing keeps the
              // dialog honest if an older build is talking to us.
              : hint.isNotEmpty
                  ? hint
                  : 'That date still doesn\'t match the one registered to this '
                      '${widget.kind.label}. You can try '
                      '$remaining more ${remaining == 1 ? 'time' : 'times'}.',
          style: TextStyle(fontSize: 13.5.sp, height: 1.5, color: Colors.black87),
        ),
        actionsPadding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 10.h),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('Contact support',
                style: TextStyle(
                    fontSize: 13.5.sp,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: _brandPurple,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r)),
            ),
            child: Text('Choose date',
                style: TextStyle(fontSize: 13.5.sp, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
    if (!mounted) return;
    if (confirmed != true) {
      _showSupportNeededDialog('IDENTITY_DOB_MISMATCH', null);
      return;
    }

    final now = DateTime.now();
    // PICK AND CONFIRM IN A LOOP, so "Change it" re-opens the calendar
    // instead of dropping out.
    //
    // The session is HELD at this point — the code worked and the registry
    // answered. Leaving here would lose it, and the only way back is a fresh
    // BVN entry, a new session and a second SMS. "Change it" has to mean
    // change it, not start over.
    final picked = await _pickAndConfirmDob(now);
    if (!mounted) return;
    if (picked == null) {
      // Cancelled out of the calendar itself: leave the held session alone
      // and return them to the screen, which still offers the correction.
      setState(() => _submitting = false);
      return;
    }
    await _submitDobCorrection(picked);
  }

  /// Show the calendar, then confirm the chosen date spelled out.
  ///
  /// Returns null when the customer backed out of the calendar. Declining the
  /// confirmation re-opens the calendar rather than returning, because the
  /// only reason to decline is to pick a different date.
  Future<DateTime?> _pickAndConfirmDob(DateTime now) async {
    while (true) {
      final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 30, 1, 1),
      firstDate: DateTime(now.year - 100),
      lastDate: DateTime(now.year - 16, now.month, now.day),
      helpText: 'Your date of birth',
      // YEAR FIRST — see phone_personal_details_screen. This picker decides
      // one of only three correction attempts, so the month must be chosen by
      // NAME rather than landed on in a grid.
      initialDatePickerMode: DatePickerMode.year,
      fieldHintText: 'Day, month, year',
    );
      if (!mounted || picked == null) return null;

    // CONFIRM THE DATE BEFORE SPENDING AN ATTEMPT.
    //
    // There are only three corrections per session, and this used to submit
    // the instant the picker closed — so a mis-scroll cost a try with nothing
    // on screen saying which date had just been sent. Showing it spelled out
    // is also the point: "9 July 1999" is checkable against a document in a
    // way "1999-07-09" is not, and a transposed day and month is the whole
    // reason this correction step exists.
    final sure = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Is this your date of birth?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              humanDob(picked),
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const Text(dobMustMatchHint),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Change it'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Yes, use this'),
          ),
        ],
      ),
    );
      if (!mounted) return null;
      if (sure == true) return picked;
      // "Change it": nothing spent, and the held session is untouched — go
      // round again so they can choose a different date.
    }
  }

  /// Write the corrected date of birth onto the profile.
  ///
  /// BEST-EFFORT BY DESIGN. The customer is already verified by the time this
  /// runs; a failure here costs them nothing today and is recoverable by
  /// support, whereas surfacing it would turn a success into an error dialog on
  /// the last screen of onboarding. Logged so it is not invisible.
  Future<void> _persistCorrectedDob(String iso) async {
    try {
      // BOUNDED, BECAUSE THE CUSTOMER IS ALREADY VERIFIED AND WAITING.
      //
      // This is awaited between a SUCCESSFUL verification and `_onVerified()`,
      // which is what navigates them on. Unbounded, a write that never answers
      // holds a verified customer on a spinner for as long as the socket stays
      // open — a success that looks like a hang, which is the shape of the
      // report this screen's date-of-birth work came from.
      //
      // `probe`, not `interactive`: this is the one tier where giving up early
      // is right. The verification is already done and nothing here can undo
      // it, and the fallback is real — support can correct the stored date and
      // the customer meets the editor again on a Tier-3 upgrade. Waiting
      // longer costs them more than not having the answer.
      final res = await serviceLocator<IProfileRepository>()
          .updateUserProfile(dateOfBirth: iso)
          .timeout(NetworkTimeouts.probe);
      // A REFUSAL IS A LEFT, NOT A THROW. The likeliest failure here — the
      // server declining because the identity is already verified — comes back
      // as a returned failure, so a try/catch alone would have recorded
      // nothing and this would have looked like it was working.
      res.fold(
        (failure) => AppLogger.event(
            widget.kind.analyticsScope, 'verify_dob_persist_refused',
            level: 'warn', screen: 'bvn_signup'),
        (_) {
          AppLogger.event(widget.kind.analyticsScope, 'verify_dob_persisted',
              screen: 'bvn_signup');
          // THE SESSION COPY, TOO. `_profile()` above reads the date of birth
          // from AuthenticationCubit, and a Tier-3 upgrade reads the same field
          // when it initiates Mono. Leaving it stale is how a date the registry
          // has just CONFIRMED still arrives at the next check as the old one.
          // See AuthenticationCubit.applyCorrectedDateOfBirth.
          if (mounted) {
            context.read<AuthenticationCubit>().applyCorrectedDateOfBirth(iso);
          }
        },
      );
    } catch (e) {
      AppLogger.event(widget.kind.analyticsScope, 'verify_dob_persist_failed',
          level: 'warn', screen: 'bvn_signup');
    }
  }

  /// Send the corrected date to the HELD session.
  ///
  /// This is the ordinary complete call with a different date of birth: the
  /// server recognises a session whose record is already fetched and treats it
  /// as the correction, so no OTP is consumed and Mono is not called again.
  Future<void> _submitDobCorrection(DateTime picked) async {
    setState(() => _submitting = true);
    // ONE implementation of the wire format, shared with onboarding and the
    // KYC profile fix. Three hand-rolled copies of the same zero-padding is
    // how a format drifts between the screens that must agree on it.
    final iso = isoDob(picked);

    final service = BvnLookupHttpService(serviceLocator<SecureStorageService>());
    final res = await service.complete(
      // Already spent, and already accepted. The held record is what the
      // server matches on; an empty code here is not a missing one.
      otp: '',
      firstName: _assertedFirstName,
      lastName: _assertedLastName,
      dateOfBirth: iso,
    );
    if (!mounted) return;

    if (res.ok) {
      AppLogger.event(widget.kind.analyticsScope, 'verify_dob_corrected',
          screen: 'bvn_signup');
      // PERSIST IT, OR THEY FIX IT AGAIN NEXT TIME.
      //
      // Verification itself is already done — it matched against the record the
      // server held, using the date passed above, so nothing here can undo it.
      // But the PROFILE still holds the wrong date, and the profile is what the
      // next reconciliation reads: without this, the same customer meets the
      // same refusal on their Tier-3 upgrade, and their statements keep a date
      // they have just told us is wrong.
      //
      // AFTER verification, not before. Persisting first would be easier —
      // the server's gate is certainly open then — but it would write a date
      // the customer has only CLAIMED, overwriting a stored one that may have
      // been right, and then fail the check anyway. Only a date the registry
      // has confirmed is worth keeping, and that is known only here.
      //
      // A failure costs them nothing today, so it is not surfaced: they are
      // already verified, and support can correct the profile.
      //
      // ONE DEPENDENCY, NAMED SO IT IS NOT DISCOVERED THE HARD WAY. The server
      // refuses a date-of-birth change once users.identity_verified is true.
      // This write lands because the three-step lookup does NOT set that flag —
      // only the one-shot VerifyIdentity path calls UpdateIdentityVerification,
      // which is why prod holds completed lookups and zero identity_verified.
      // If that ever changes, this write starts failing silently and the
      // profile keeps the wrong date: the fix then is for banking-service to
      // push the confirmed date to auth the way it already pushes the adopted
      // NAME (pushAdoptedIdentityName), which is the authoritative route.
      await _persistCorrectedDob(iso);
      await _onVerified();
      return;
    }

    _dobCorrectionsUsed++;
    setState(() => _submitting = false);

    final code = res.code.trim().toUpperCase();
    if (code == 'IDENTITY_DOB_EXHAUSTED') {
      // THE SERVER HAS DROPPED THE SESSION. There is no fourth attempt to
      // offer, and offering one would send them round a loop that cannot
      // succeed — which reads as the app being broken rather than as being
      // out of tries.
      _showSupportNeededDialog(code, res.message);
      return;
    }
    if (code == 'IDENTITY_DOB_MISMATCH') {
      // ATTEMPTS LEFT, AS THE SERVER COUNTS THEM.
      //
      // This used to also require a LOCAL tally (_dobCorrectionsUsed <
      // _dobCorrectionLimit), which drifts: the counter lives on this widget
      // and resets if the customer backs out and comes back, while the
      // server's lives on the held session and does not. The two disagreeing
      // meant either a fourth try the server would refuse, or support being
      // offered while the server still had attempts left.
      await _showDobCorrectionDialog(serverMessage: res.message);
      return;
    }
    if (res.sessionExpired) {
      // The held record aged out. Honest answer: start the check again.
      //
      // THE MESSAGE IS THE WHOLE FIX. This set the retry flag and nothing
      // else — and the retry affordance is gated on `hasError`, which is
      // `_inlineError != null`. So the picker closed, the confirm dialog
      // closed, the spinner stopped, and the screen was pixel-identical to
      // before the correction: no message, no retry link, no explanation.
      // That is the literal "nothing happened" a customer reports as the app
      // being frozen, at the end of a flow they completed correctly.
      setState(() {
        _submitting = false;
        _inlineRetryable = true;
        _inlineError = 'That check timed out while you were correcting your '
            'date of birth — nothing was lost. Start it again when you\'re '
            'ready.';
      });
      return;
    }
    _showSupportNeededDialog(
        code.isEmpty ? 'IDENTITY_DOB_MISMATCH' : code, res.message);
  }

  /// IDENTITY_DETAILS_MISMATCH WITH NO DATE OF BIRTH ON FILE.
  ///
  /// THIS IS THE DEAD END A CUSTOMER HIT ON 2026-11-24, and it is a routing
  /// mistake rather than a missing feature. banking-service's
  /// `reconcileSignupIdentity` refuses a name difference only when it has no
  /// date of birth to corroborate with — the log line says it in those words,
  /// "name mismatch with no comparable date of birth" — and when a date IS
  /// comparable and agrees, the registry's spelling is ADOPTED and the check
  /// passes. So on this refusal the one action that unblocks the customer is
  /// supplying their date of birth, and the dialog offered only a name edit.
  ///
  /// Worse, it offered it blind: no registry name is shown (deliberately — on
  /// a refusal the server has evidence the asker may not be the holder), so
  /// "update your name to match exactly" asks them to guess a spelling they
  /// cannot see. He tried twice, two minutes apart, then abandoned Tier 2 and
  /// fell back to a Tier-1 session he could not finish either.
  ///
  /// A phone+passcode or social signup captures no date of birth at all, which
  /// is how a profile reaches a BVN check with nothing to compare. That makes
  /// this the common case, not an edge one.
  ///
  /// WHY THE BRANCH IS SAFE. `IDENTITY_DETAILS_MISMATCH` is returned from
  /// exactly one place, and only when `dobComparable` is false. A date on our
  /// side that DISAGREES is a different code (`IDENTITY_DOB_MISMATCH`) and a
  /// date that AGREES adopts the name instead of refusing. So an empty date on
  /// the profile identifies this branch precisely; a non-empty one means the
  /// REGISTRY's date is the missing half, which nothing the customer types can
  /// fix, and the name dialog remains the only lever.
  /// UNKNOWN IS NOT ABSENT, and conflating them asks a customer to re-enter a
  /// date we already hold.
  ///
  /// `_profile()` returns an empty date for THREE different situations: the
  /// profile genuinely has none, the session copy has not landed yet, and
  /// `context.read` threw. Only the first is a reason to open the date editor.
  ///
  /// bvn_verification_screen asks the same question and already answers it
  /// correctly — "unknown, not absent" — so the two screens disagreed on one
  /// decision. This is the same answer, derived the same way: read the session
  /// profile directly, and treat a missing profile as unknown.
  bool get _hasNoDateOfBirthOnFile {
    try {
      final profile = context.read<AuthenticationCubit>().currentProfile;
      if (profile == null) return false; // unknown — do not send them to the editor
      return (profile.user.dateOfBirth ?? '').trim().isEmpty;
    } catch (_) {
      return false;
    }
  }

  void _showNameMismatchDialog() {
    if (_hasNoDateOfBirthOnFile) {
      _showMissingDobDialog();
      return;
    }
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
        title: Text('Your name doesn\'t match this ${widget.kind.label}',
            style:
                TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w700)),
        content: Text(
          'The name on your profile is different from the one registered to '
          'this ${widget.kind.label}. The number looks fine — update your '
          'name to match your ${widget.kind.label} exactly and we\'ll try '
          'again.',
          style: TextStyle(
              fontSize: 13.5.sp, height: 1.5, color: Colors.black87),
        ),
        actionsPadding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 10.h),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              // Not the dashboard: Tier 2 is what mints the account, so
              // "continue" would hand them a wallet that cannot receive money.
              _offerProveInstead();
            },
            child: Text('Use full verification',
                style: TextStyle(
                    fontSize: 13.5.sp,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600)),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              final changed = await openKycProfileFix(KycProfileField.name);
              if (!mounted) return;
              // Only retry when the name REALLY changed — otherwise the
              // customer is bounced straight back into the same refusal.
              if (changed) {
                _submit();
              } else {
                setState(() => _submitting = false);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _brandPurple,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r)),
            ),
            child: Text('Update my name',
                style: TextStyle(
                    fontSize: 13.5.sp, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  /// Ask for the date of birth, because that is what the check was missing.
  ///
  /// NO REGISTRY VALUE IS ECHOED, same rule as everywhere else on this screen:
  /// the date of birth is the corroboration standing between a
  /// mistyped-but-valid number and somebody else's identity, so showing or
  /// pre-filling the registry's would hand over the answer to the only
  /// question being asked. The customer tells US.
  ///
  /// NO FAULT AND NO CAUSE IN THE COPY. It says what is needed and what
  /// happens next; it does not explain that we never collected it.
  void _showMissingDobDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
        title: Text('We need your date of birth',
            style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w700)),
        content: Text(
          'Your ${widget.kind.label} is registered with a date of birth, and '
          'your account does not have one yet — so there is nothing to check '
          'it against. Add it and we will carry on from here.',
          style:
              TextStyle(fontSize: 13.5.sp, height: 1.5, color: Colors.black87),
        ),
        actionsPadding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 10.h),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              // The name editor stays reachable: a customer who knows their
              // registry spelling differs can still take that route, and
              // removing it would trade one dead end for another.
              _offerNameEditInstead();
            },
            child: Text('My name is wrong instead',
                style: TextStyle(
                    fontSize: 13.5.sp,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              // Not awaited here for the reason the DOB-mismatch branch gives:
              // this is a dialog callback, and the work needs to await
              // properly in a method of its own.
              _offerDobEdit(missingNotMismatched: true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _brandPurple,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r)),
            ),
            child: Text('Add my date of birth',
                style:
                    TextStyle(fontSize: 13.5.sp, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  /// The name route, reached from [_showMissingDobDialog]'s secondary action.
  ///
  /// Mirrors the primary action of [_showNameMismatchDialog] exactly — the
  /// purpose-built editor, retried only on a real change — so the two doors
  /// behave identically whichever one the customer came through.
  Future<void> _offerNameEditInstead() async {
    final changed = await openKycProfileFix(KycProfileField.name);
    if (!mounted) return;
    if (changed) {
      _submit();
    } else {
      setState(() => _submitting = false);
    }
  }

  /// Say what happened, and offer the only two moves that exist.
  ///
  /// NO NAME IS ECHOED. On an already-registered number the server has
  /// evidence the asker may not be the holder, and on a date-of-birth
  /// disagreement the record is probably someone else's — printing either
  /// would hand one customer another person's details.
  void _showSupportNeededDialog(String code, String? serverMessage) {
    final isTaken = code.trim().toUpperCase().endsWith('ALREADY_REGISTERED');
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
        title: Text(
          isTaken
              ? 'That ${widget.kind.label} is already in use'
              : 'Your date of birth does not match',
          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w700),
        ),
        content: Text(
          isTaken
              ? 'This ${widget.kind.label} is already linked to another '
                  'Lazervault account. If it is yours, our support team can '
                  'sort it out — retrying here will give the same answer.'
              // STALE COPY, CORRECTED. A date of birth CAN be changed in the
              // app (openKycDateOfBirthFix), and this dialog is reached from
              // the correction dialog's own "Contact support" button — so the
              // customer was handed a date picker and told, one tap later,
              // that the app cannot change dates.
              //
              // What is actually true here: they have spent the corrections
              // this check allows, so the next move is a human.
              : 'The date of birth on your profile does not match the one '
                  'registered to this ${widget.kind.label}, and you have used '
                  'the tries this check allows. Our support team can check it '
                  'with you.',
          style: TextStyle(
              fontSize: 13.5.sp, height: 1.5, color: Colors.black87),
        ),
        // THE PUBLISHED ADDRESS, BESIDE THE TICKET.
        //
        // A ticket is the better channel — it threads, it carries images, and
        // support sees the account it belongs to. But someone who has just
        // been told the app cannot verify them does not always trust the app
        // to carry their message, and an industry-standard failure screen
        // offers a way out that does not depend on the thing that just failed.
        //
        // Rendered ONLY when an operator has published an address; it is a
        // server setting with no default, so nothing is hardcoded and an
        // unset value simply removes the line.
        actionsPadding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 10.h),
        actions: [
          if (_supportEmail != null)
            Align(
              alignment: Alignment.center,
              child: SupportEmailLine(
                address: _supportEmail,
                subject: 'Identity verification — $code',
                linkColor: _brandPurple,
              ),
            ),
          // "USE FULL VERIFICATION" IS NOT OFFERED FOR AN ALREADY-REGISTERED
          // NUMBER, because it cannot work — and it fails LATE.
          //
          // Mono Prove dedups against the same identity_verifications table
          // (prove_kyc.go), but only at COMPLETION when the widget collects
          // the number itself. After this refusal saveBvn() was deliberately
          // not called — that store's contract is "verified only" — so
          // getBvn() is empty, the Prove session starts with no number, the
          // initiate-time check at prove_kyc.go:252 is skipped, and the
          // customer walks camera permission, liveness and ID entry before
          // meeting the identical sentence. Two minutes and a billed Mono
          // session to arrive back here.
          //
          // It IS still offered for a date-of-birth mismatch (below), because
          // Prove's completion dedup is on the NUMBER only — it does not
          // compare against our stored date of birth, so that route genuinely
          // can finish.
          if (!isTaken)
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                _offerProveInstead();
              },
              child: Text('Use full verification',
                  style: TextStyle(
                      fontSize: 13.5.sp,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600)),
            ),
          // NOT A ONE-BUTTON DIALOG, and especially not on an
          // already-registered number.
          //
          // The barrier is non-dismissible, so until this existed the only
          // move from here was to open a support ticket — including for the
          // commonest real cause by far, a MISTYPED number that happens to
          // belong to somebody else's account. The customer had no way to
          // simply go back and fix eleven digits.
          //
          // The screen behind is already usable (`_submitting` is cleared
          // before this dialog opens, and the "Not you? Sign in as someone
          // else" exit sits on it), so closing is enough — this selects the
          // number and puts the keyboard back so the correction is one
          // action rather than a hunt.
          if (isTaken)
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                if (!mounted) return;
                final text = _bvnController.text;
                _bvnController.selection = TextSelection(
                    baseOffset: 0, extentOffset: text.length);
                FocusScope.of(context).requestFocus(_bvnFocus);
              },
              child: Text('Use a different number',
                  style: TextStyle(
                      fontSize: 13.5.sp,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600)),
            ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              final t = _supportTicketFor(code);
              // SupportContact, not openKycProfileFix: it checks for an
              // EXISTING open ticket first and lands on the thread rather
              // than seeding a duplicate about the same wall. See
              // SupportContact.open.
              SupportContact.open(subject: t.subject, body: t.message);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _brandPurple,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r)),
            ),
            child: Text('Contact support',
                style: TextStyle(
                    fontSize: 13.5.sp, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  /// Leave the gate WITHOUT claiming anything was verified.
  ///
  /// Deliberately does not call saveBvn: that store's contract is "verified
  /// only" and it pre-fills the insurance purchase form, so an unchecked
  /// number must not land in it. The server already persists a claimed BVN
  /// when a Prove session starts, which is the right place for a claim.
  /// THE DASHBOARD IS NOT AN ESCAPE HATCH ANY MORE.
  ///
  /// This used to send an unverified customer straight to the dashboard
  /// whenever the lookup failed for a reason that was not their fault. The
  /// intent was kindness; the result was the opposite. Tier 2 is what mints
  /// the account number, so an unverified customer arrives at a dashboard
  /// with a wallet that cannot receive a transfer, no account details, and
  /// NOTHING explaining why — which is exactly what happened in production on
  /// 2026-11-10: a signup whose BVN never reached the backend landed on the
  /// dashboard with no confirmation at all and no idea anything had failed.
  ///
  /// So a failed verification now STAYS on this screen and offers the two
  /// moves that can actually finish it — try again, or the full Mono
  /// verification, which does not depend on the BVN lookup at all. The only
  /// way past without verifying is KycGateExitCta (sign out), which is
  /// correct: someone who cannot verify on this device has no business
  /// holding an un-minted account.
  void _showCannotVerifyDialog({
    required String title,
    required String body,
    bool offerRetry = true,
    bool offerSupport = false,
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
        title: Text(title,
            style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w700)),
        content: Text(body,
            style: TextStyle(
                fontSize: 13.5.sp, height: 1.5, color: Colors.black87)),
        actionsPadding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 10.h),
        actions: [
          // Same reasoning as the support-needed dialog: a published address
          // beside the in-app route, shown only when one is configured.
          if (_supportEmail != null)
            Align(
              alignment: Alignment.center,
              child: SupportEmailLine(
                address: _supportEmail,
                subject: 'Identity verification — cannot complete',
                linkColor: _brandPurple,
              ),
            ),
          if (offerSupport)
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                // The cannot-verify dialog is raised for provider failures and
                // for a bank holding no contact details — neither carries a
                // refusal code, so the ticket describes the situation the
                // customer is actually in rather than quoting one.
                final typed = _bvnController.text.trim();
                final tail = typed.length >= 4
                    ? ' ending ${typed.substring(typed.length - 4)}'
                    : '';
                SupportContact.open(
                  subject:
                      'Cannot verify my ${widget.kind.label} during sign-up',
                  body:
                      'I am trying to verify my ${widget.kind.label}$tail to '
                      'finish signing up, and the check will not complete.\n\n'
                      '$title\n$body\n\n'
                      'Please can you help me finish verifying?',
                );
              },
              child: Text('Contact support',
                  style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600)),
            ),
          // ALWAYS offered: Mono Prove verifies by liveness and its own ID
          // entry, so it works when the BVN lookup cannot — a dead registered
          // SIM, an unreachable email, a lookup outage. It is the difference
          // between "try later" and a real second route to Tier 2.
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _offerProveInstead();
            },
            child: Text('Use full verification',
                style: TextStyle(
                    fontSize: 13.sp,
                    color: _brandPurple,
                    fontWeight: FontWeight.w700)),
          ),
          if (offerRetry)
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                _submit();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _brandPurple,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
              child: Text('Try again',
                  style: TextStyle(
                      fontSize: 13.5.sp, fontWeight: FontWeight.w700)),
            ),
        ],
      ),
    ).then((_) {
      if (mounted) setState(() => _submitting = false);
    });
  }

  /// Ask the customer whether the BVN belongs to them, then act on the answer.
  ///
  /// THE BVN IS THE AUTHORITY and the profile name is the editable side — you
  /// cannot change your BVN from this app. So "yes, that's me" offers to bring
  /// the PROFILE into line, never the other way round.
  ///
  /// DISMISSING IS NOT CONSENT. ConfirmBVNName approves the verification for
  /// BOTH actions it accepts — they differ only in whether the name is
  /// rewritten. There is no "reject" action, so a customer who closes the
  /// sheet because the BVN is not theirs must result in NO call at all.
  /// Treating a dismissal as either action would grant a tier against someone
  /// else's identity.
  Future<void> _handleNameConfirmation(NameConfirmationRequired state) async {
    final cubit = context.read<KYCCubit>();
    final action = await showDataReconciliationDialog(
      context,
      verifiedName: state.verifiedName,
      profileName: state.profileName,
      matchScore: state.matchScore,
    );
    if (!mounted) return;

    if (action == null) {
      // Dismissed. Leave the verification where it is and say what happened,
      // rather than leaving the screen silent the way it was before.
      //
      // THE COPY NO LONGER POINTS AT SETTINGS. It used to say "check your
      // name in Settings", and the name field there is immutable — the exact
      // dead end kyc_profile_fix.dart was written to stop, offered here by
      // the one screen a customer reaches before they have an account to fix
      // anything in. The real move is the decision they just closed, so the
      // state is kept and re-offered beside the message.
      setState(() {
        _submitting = false;
        _pendingNameConfirmation = state;
        _inlineError =
            'The name on that ${widget.kind.label} is close to your profile '
            'name but not identical, so we need you to confirm which is '
            'right before we can continue.';
      });
      AppLogger.event(widget.kind.analyticsScope,
          'name_confirmation_dismissed',
          level: 'warn',
          screen: widget.kind.isBvn ? 'bvn_signup' : 'nin_signup');
      return;
    }

    AppLogger.event(widget.kind.analyticsScope,
        'name_confirmation_$action',
        screen: widget.kind.isBvn ? 'bvn_signup' : 'nin_signup');
    setState(() {
      _pendingNameConfirmation = null;
      _inlineError = null;
    });
    await cubit.confirmBVNName(
      verificationId: state.verificationId,
      action: action,
    );
  }

  @override
  Widget build(BuildContext context) {
    // THE OS BACK GESTURE, ON A SCREEN THAT IS A GATE.
    //
    // When this is the only route on the stack — the signup path, where it is
    // reached by `Get.offAllNamed` — a plain back press CLOSES THE APP on
    // somebody who is signed in and half-way through onboarding. That is the
    // other half of the same bug as `offAllKeepingHome`: the stack is one
    // route deep by design, so Android's back has nothing to pop and hands
    // the press to the system.
    //
    // So back is intercepted there and routed through the ONE sanctioned
    // exit, the same confirmation the "Not you? Sign in as someone else" link
    // shows. One answer to "how do I leave this screen", wherever it is asked
    // from — and no silent escape from a gate that has not been passed.
    //
    // When the screen CAN pop it was reached from somewhere, and back means
    // what it always means; canPop:true leaves Flutter to do it.
    final isGate = !Navigator.of(context).canPop();
    return PopScope(
      canPop: !isGate,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop || !isGate || !mounted) return;
        KycGateExitCta.confirmExit(context);
      },
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocListener<KYCCubit, KYCState>(
      listener: (context, state) {
        if (state is IDVerificationSuccess) {
          _onVerified();
        } else if (state is NameConfirmationRequired) {
          // THE MISSING WIRE.
          //
          // Every other piece of this journey already existed: auth-service
          // scores the BVN name against the profile and returns `confirm` in
          // the 50-80% band, the proto carries it, the datasource parses it,
          // the cubit emits this state, and showDataReconciliationDialog is a
          // finished 312-line sheet returning exactly the two action strings
          // the backend accepts.
          //
          // Nothing listened for the state. A customer whose BVN name only
          // partly matched reached this screen and it simply stopped — no
          // sheet, no error, no way forward. The work was all done and the
          // journey still dead-ended.
          _handleNameConfirmation(state);
        } else if (state is BVNNameConfirmed) {
          // Either action APPROVES the verification server-side; they differ
          // only in whether the profile name is rewritten to the BVN's. So a
          // confirmation is a successful verification.
          _onVerified();
        } else if (state is KYCError) {
          // OUR OUTAGE IS NOT THEIR BLOCKER.
          //
          // This screen is reached only when an admin turns on
          // bvn_signup_screen_enabled, and it is a GATE — there is no skip,
          // and a KYCError left the customer on it with an inline message and
          // nowhere to go. That is correct for a BVN they can retype and
          // wrong for everything else, and the difference is not academic:
          // the Mono BVN lookup product is NOT currently enabled on our
          // account, so the very first thing that toggle would do today is
          // answer PROVIDER_UNAVAILABLE for every single signup and brick
          // onboarding entirely — with no deploy in the loop to catch it.
          //
          // So infrastructure failures fall through to the step the customer
          // would have reached anyway. They land on Tier 1 without an account
          // number, which is exactly where they are today with the toggle
          // off; nothing is granted, nothing is claimed, and Settings still
          // offers verification later. A user-fixable refusal still stops
          // here, where it can actually be fixed.
          final code = state.failure is APIFailure
              ? ((state.failure as APIFailure).code ?? '')
              : '';
          if (isIdentityInfrastructureFailure(code)) {
            AppLogger.event(widget.kind.analyticsScope,
                'verify_unavailable_blocked',
                level: 'warn',
                screen: widget.kind.isBvn ? 'bvn_signup' : 'nin_signup');
            setState(() => _submitting = false);
            _showCannotVerifyDialog(
              title: 'We couldn\'t reach our verification partner',
              body: 'This is on our side, not yours. Try again in a moment, '
                  'or use the full verification instead — it takes a couple '
                  'of minutes and gets you to the same place.',
            );
            return;
          }
          // REFUSALS RETYPING CANNOT FIX GET A HUMAN, NOT AN INLINE ERROR.
          //
          // The inline message ends "please check it and try again", which is
          // the right answer for a mistyped number and a loop for these two:
          //
          //   IDENTITY_DOB_MISMATCH   — the date of birth disagrees with the
          //     registry. There is NO screen in this app that edits a date of
          //     birth (verified 2026-11-09), so the customer cannot change
          //     either side of that comparison.
          //   *_ALREADY_REGISTERED    — the number belongs to an account that
          //     already exists. Retrying submits the same number against the
          //     same row and fails identically; it is a decision, not a retry.
          //     This is precisely the case KycProfileField.support was added
          //     for.
          // A NAME MISMATCH IS FIXABLE — BY EDITING THE NAME, NOT THE NUMBER.
          //
          // The inline fallback ends "check it and try again", which is right
          // for a mistyped number and useless here: the BVN is correct and
          // the NAME is what disagrees. Retyping the number returns the same
          // refusal forever.
          //
          // SOCIAL SIGN-UPS ARE THE COHORT THIS STRANDS. Google and Apple
          // supply a display name and NO date of birth (verified: neither
          // use case captures one). With no date of birth to corroborate
          // against, reconcileSignupIdentity refuses a name mismatch instead
          // of adopting it — correct, since adopting on no evidence is how
          // somebody claims a stranger's record — and a Google display name
          // rarely matches a NIBSS record exactly. So they meet a dead end on
          // a number that is genuinely theirs.
          //
          // KycUpdateDetailsScreen is the purpose-built editor: it applies
          // the name against the rule for an unverified holder, reads the
          // saved profile back, and reports true ONLY if it really changed —
          // so verification is retried only when the retry can produce a
          // different answer.
          if (code.trim().toUpperCase() == 'IDENTITY_DETAILS_MISMATCH') {
            setState(() => _submitting = false);
            _showNameMismatchDialog();
            return;
          }
          // A DATE OF BIRTH IS NOW FIXABLE TOO — BY EDITING THE DATE.
          //
          // This path has no held verification session (it is the one-shot
          // verify, not the three-step lookup), so there is nothing to resume:
          // the correction goes to the PROFILE and verification is re-run, the
          // same shape the name mismatch above uses. Retried only when the
          // profile really changed, because retrying against an unchanged one
          // reproduces the identical refusal.
          if (code.trim().toUpperCase() == 'IDENTITY_DOB_MISMATCH') {
            setState(() => _submitting = false);
            AppLogger.event(widget.kind.analyticsScope, 'verify_dob_edit_offered',
                screen: widget.kind.isBvn ? 'bvn_signup' : 'nin_signup');
            // Not awaited here: a BlocListener callback is void, and making it
            // async would swallow errors into an unobserved future. The work
            // lives in its own method so it can await properly.
            _offerDobEdit();
            return;
          }
          if (_needsAHuman(code)) {
            AppLogger.event(widget.kind.analyticsScope, 'verify_needs_support',
                level: 'warn',
                screen: widget.kind.isBvn ? 'bvn_signup' : 'nin_signup');
            setState(() => _submitting = false);
            _showSupportNeededDialog(code, state.userMessage);
            return;
          }
          setState(() {
            _submitting = false;
            // Reached only when the refusal carried no code we route on, so
            // we genuinely do not know whether retyping helps — offering the
            // retry costs one tap and is the only move left on this screen.
            _inlineRetryable = true;
            _inlineError = (state.userMessage != null &&
                    state.userMessage!.isNotEmpty)
                ? state.userMessage
                : 'We couldn\'t verify that ${widget.kind.label}. Please check '
                    'it and try again.';
          });
          AppLogger.event(widget.kind.analyticsScope, 'verify_error',
              level: 'warn',
              screen: widget.kind.isBvn ? 'bvn_signup' : 'nin_signup');
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xFFF6F5FB),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg/up-down-curve-bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  _buildTopBar(),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(),
                          SizedBox(height: 20.h),
                          _buildMatchBanner(),
                          SizedBox(height: 16.h),
                          _buildBvnCard(),
                          SizedBox(height: 16.h),
                          _buildPrivacyNote(),
                        ],
                      ),
                    ),
                  ),
                  _buildStickyCta(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 8.h, 16.w, 0),
      child: Row(
        children: [
          // A SPACER, not a dead arrow, when back is impossible — this sits
          // in a Row, so the header must keep its height either way.
          // Disabled (not hidden) mid-submit: the arrow staying put while it
          // greys out reads as "wait", whereas vanishing reads as a glitch.
          // WHITE, because this row sits in the PURPLE band at the top of the
          // curved background. It was Colors.black87 — dark ink on a dark
          // brand-purple header.
          //
          // Shown only when there is genuinely somewhere to go:
          // maybeBackButton returns null when nothing can be popped (this
          // screen is the onboarding root, reached by offAllNamed), and the
          // Row keeps its height with a spacer so the header does not jump.
          // It IS poppable when the customer arrived from the KYC gate or
          // Settings, and back must work there.
          maybeBackButton(
                context,
                icon: Icons.arrow_back_ios_new,
                color: Colors.white,
                onBack: _submitting ? null : () => Get.back(),
              ) ??
              SizedBox(width: 48.w),
          const Spacer(),
          // A SOLID pill, because the curve cuts straight through this row.
          //
          // This was purple text on an 8%-purple pill. Over the purple band
          // that is invisible; only the few pixels overlapping the white
          // curve were legible, which is why it read as "...tep" half-hidden
          // behind the header. Nothing was mis-layered — it was a contrast
          // failure that LOOKED like one.
          //
          // White fill with brand text reads on both halves, and the shadow
          // keeps it off the white curve where fill alone would vanish.
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.10),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              'Final step',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: _brandPurple,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 56.w,
          height: 56.w,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_brandPurple, _brandPurpleDeep],
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: _brandPurple.withValues(alpha: 0.28),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Icon(Icons.verified_user_rounded,
              color: Colors.white, size: 28.sp),
        ),
        SizedBox(height: 16.h),
        Text(
          'Verify your identity',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
            height: 1.1,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          widget.kind.isBvn
              ? 'Enter your Bank Verification Number (BVN) to activate your '
                  'account. This creates your secure account number and '
                  'unlocks deposits, transfers and withdrawals.'
              // The NIN here does NOT mint an account number — a NIN alone is
              // a Tier 1 identity. Saying so plainly beats promising a NUBAN
              // the branch cannot deliver and losing the customer's trust at
              // the first screen that asks for a government number.
              : 'Enter your National Identification Number (NIN). We use it to '
                  'confirm your legal name exactly as it is registered, so '
                  'verification does not reject it later.',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black54,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildMatchBanner() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7E6),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFF6C453), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_rounded, color: const Color(0xFFB7791F), size: 20.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              widget.kind.isBvn
                  ? 'Your name and date of birth must match the records linked '
                      'to this BVN. Mismatched details will fail verification.'
                  // Names are ADOPTED from NIMC, not rejected — so the only
                  // thing the customer must get right is the number and the
                  // date of birth. Telling them their name must match would be
                  // both wrong and the exact anxiety this screen removes.
                  : 'Make sure the number and your date of birth are right. '
                      'If your name is registered differently, we will use the '
                      'version on your NIN — you do not need to change it.',
              style: TextStyle(
                fontSize: 12.5.sp,
                color: const Color(0xFF7A5A12),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBvnCard() {
    final hasError = _inlineError != null;
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.kind.isBvn
                ? 'Bank Verification Number'
                : 'National Identification Number',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 10.h),
          TextField(
            controller: _bvnController,
            focusNode: _bvnFocus,
            enabled: !_submitting,
            keyboardType: TextInputType.number,
            obscureText: _obscure,
            maxLength: 11,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              color: Colors.black87,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(11),
            ],
            decoration: InputDecoration(
              counterText: '',
              hintText: '0 0 0 0 0 0 0 0 0 0 0',
              hintStyle: TextStyle(
                fontSize: 16.sp,
                letterSpacing: 2,
                // A placeholder may sit lighter than body text, but black26
                // on this ground is ≈2.2:1 and reads as an empty field.
                color: Colors.black38,
                fontWeight: FontWeight.w600,
              ),
              prefixIcon: Icon(Icons.pin_rounded,
                  color: _brandPurple.withValues(alpha: 0.7), size: 20.sp),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscure
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  color: Colors.black38,
                  size: 20.sp,
                ),
                onPressed: () => setState(() => _obscure = !_obscure),
              ),
              filled: true,
              fillColor: const Color(0xFFF6F5FB),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color:
                      hasError ? const Color(0xFFE53935) : Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: hasError ? const Color(0xFFE53935) : _brandPurple,
                  width: 1.5,
                ),
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  hasError
                      ? _inlineError!
                      : widget.kind.isBvn
                          ? 'Dial *565*0# on your registered line to get your BVN.'
                          : 'Dial *346# on your registered line to get your NIN.',
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    // black45 on the #F6F5FB ground is ≈3.5:1 — under the
                    // 4.5:1 AA floor, and this is the 11.5sp helper that tells
                    // someone HOW to find their number.
                    color: hasError ? const Color(0xFFE53935) : Colors.black54,
                    height: 1.3,
                  ),
                ),
              ),
              // THE RETRY, WHERE THE REFUSAL IS. Only for refusals a retry
              // can clear, and only while not already submitting, so it can
              // never queue a second request behind the first.
              // THE DECISION, NOT A RETRY. `_submit` would start the whole
              // lookup again — another Mono session, another code to the
              // holder's phone — to arrive back at a question the server is
              // already holding open. So when a name confirmation is pending
              // this replaces the retry entirely.
              if (hasError && _pendingNameConfirmation != null) ...[
                SizedBox(width: 8.w),
                InkWell(
                  onTap: _submitting
                      ? null
                      : () {
                          final held = _pendingNameConfirmation;
                          if (held != null) _handleNameConfirmation(held);
                        },
                  borderRadius: BorderRadius.circular(8.r),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.fact_check_outlined,
                            size: 14.sp, color: _brandPurple),
                        SizedBox(width: 4.w),
                        Text(
                          'Confirm your name',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: _brandPurple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else if (hasError && _inlineRetryable) ...[
                SizedBox(width: 8.w),
                InkWell(
                  onTap: _submitting ? null : _submit,
                  borderRadius: BorderRadius.circular(8.r),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.refresh_rounded,
                            size: 14.sp, color: _brandPurple),
                        SizedBox(width: 4.w),
                        Text(
                          'Try again',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: _brandPurple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              SizedBox(width: 8.w),
              Text(
                '${_bvnController.text.trim().length}/11',
                style: TextStyle(
                  fontSize: 11.5.sp,
                  fontWeight: FontWeight.w600,
                  color: _isValid ? const Color(0xFF10B981) : Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyNote() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.lock_rounded, size: 15.sp, color: Colors.black54),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            widget.kind.isBvn
                ? 'Your BVN is encrypted and used only to verify your identity. '
                    'We never see or store your banking password.'
                : 'Your NIN is encrypted and used only to verify your identity, '
                    'as required by CBN rules.',
            style: TextStyle(
              fontSize: 11.5.sp,
              // Raised from black45: this is the privacy note, the smallest
              // text on a screen that is asking for a government number, and
              // it has to be legible to be reassuring.
              color: Colors.black54,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStickyCta() {
    final enabled = _isValid && !_submitting;
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_brandPurple, _brandPurpleDeep],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: _brandPurple,
                disabledBackgroundColor: Colors.white.withValues(alpha: 0.55),
                disabledForegroundColor: _brandPurple.withValues(alpha: 0.5),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.r),
                ),
              ),
              onPressed: enabled ? _submit : null,
              child: _submitting
                  ? LazerVaultLoader(size: 22)
                  : Text(
                      'Verify & Continue',
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w700),
                    ),
            ),
          ),
          // THE ONLY WAY OUT OF A GATE THAT HAS NO OTHER ONE.
          //
          // transaction_pin_setup_screen reaches this screen with
          // `Get.offAllNamed`, so it IS the navigation root: the back arrow
          // correctly renders as a spacer (maybeBackButton returns null when
          // nothing can be popped), there is no skip — the BVN here is
          // deliberately not skippable — and nothing else on the screen signs
          // out. Someone whose BVN genuinely does not match, or who does not
          // have it to hand, had the app rendered unusable with no route even
          // back to login.
          //
          // The KYC screen already hit exactly this and KycGateExitCta is the
          // answer it settled on; reusing it keeps the two gates behaving the
          // same way. Shown only when there is really nothing to pop, so a
          // customer who arrived here from somewhere with a stack still just
          // uses back.
          if (!Navigator.of(context).canPop()) const KycGateExitCta(),
        ],
      ),
    );
  }
}
