import 'dart:async';


import 'package:dartz/dartz.dart' show Either;

import 'package:lazervault/core/utils/dob_display.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/kyc_saving_overlay.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/profile/domain/repositories/i_profile_repository.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lazervault/src/features/profile/presentation/view/change_phone_screen.dart';
import 'package:lazervault/src/features/kyc/presentation/views/kyc_update_details_screen.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/support/presentation/support_tickets_screen.dart';

/// WHEN KYC FAILS BECAUSE OF *OUR* PROFILE DATA, SAY WHERE TO FIX IT.
///
/// Several identity checks refuse before they ever reach the provider, because
/// the profile is missing something they need:
///
///   * no Nigerian phone ("0 followed by 10 digits")
///   * a phone that is present but unusable for verification
///   * no email
///   * no name
///
/// Each of those messages ends with "please update it and try again" — and the
/// dialog then offered exactly two buttons, Cancel and **Try Again**. Trying
/// again runs the identical check against the identical profile and fails the
/// identical way. The one thing the user had to do was the one thing the
/// screen would not take them to, and the place to do it is several taps away
/// inside Settings.
///
/// So the refusal now carries the fix. The classification reads the SERVER's
/// sentence rather than re-deriving the rule in the app: banking-service owns
/// what "valid" means for each provider, and a second copy here would drift
/// the first time a corridor changed.
enum KycProfileField {
  phone,
  email,
  name,

  /// The date of birth on the profile disagrees with the registry.
  ///
  /// THIS USED TO BE [support], and the ticket it opened said, in the
  /// customer's name, "I cannot change my date of birth in the app" — which was
  /// true until 2026-11-10 and is the reason this entry exists. A date of birth
  /// is the one identity field a customer knows perfectly well and we had
  /// simply recorded wrong at signup; sending them to a human to retype a
  /// number they could have typed themselves cost a day of waiting on the last
  /// screen of onboarding.
  ///
  /// It is still support's problem once the identity is VERIFIED — at that
  /// point the stored date has been matched against NIBSS or NIMC and is no
  /// longer the holder's to edit. The server enforces that and says so, and
  /// this editor surfaces that sentence rather than pretending.
  dateOfBirth,

  /// Nothing the customer can change will clear this — it needs a human.
  ///
  /// THE CASE THIS EXISTS FOR: "this BVN is already linked to another
  /// account". It classified as [none], so the dialog offered Cancel and
  /// **Try Again**, and trying again submits the same BVN against the same
  /// row and fails identically — the exact loop the rest of this file was
  /// written to stop, just with a different cause. A BVN belonging to an
  /// existing account is either a genuine duplicate (one person, two
  /// accounts) or someone using a number that is not theirs, and both are
  /// decisions, not retries.
  support,

  none,
}

/// Which profile field a refusal is really about, or [KycProfileField.none]
/// when it is a provider/network failure the user cannot fix from Settings.
///
/// Substring matching, deliberately: these strings are produced by
/// prove_kyc.go and prove_kyc_progress.go and are shown verbatim, so matching
/// on their distinctive words survives rewording better than an exact compare,
/// and an unrecognised message correctly falls through to a plain Try Again.
/// Error codes that route straight to a human, whatever the prose says.
///
/// MATCHED ON THE CODE, NOT THE SENTENCE. Every other branch below reads the
/// message text, which is fine for refusals whose wording we have owned for a
/// long time. A code is better where one exists: it survives a copy edit, and
/// these are exactly the refusals where falling through to "Try Again" costs
/// the customer the most.
///
/// NAME_LOCKED_WITH_PARTNER — our verification partner registered this
/// customer under one name and refuses any session carrying a different one.
/// banking-service first tries to realign automatically from the name we
/// recorded on the first accepted session; this code means that recovery
/// found nothing to use, so only a person can clear it. Measured 2026-11-09:
/// before this existed, one customer spent 27 attempts on a Try Again button.
const _supportOnlyCodes = {'NAME_LOCKED_WITH_PARTNER'};

/// The combined refusal: the registry's name differs AND there was no date of
/// birth to corroborate with. See [_detailsMismatchField] for why it has to be
/// routed on the code rather than the sentence.
const _detailsMismatchCode = 'IDENTITY_DETAILS_MISMATCH';

/// Which editor clears an `IDENTITY_DETAILS_MISMATCH`.
///
/// ROUTED ON THE CODE, BECAUSE THE SENTENCE DOES NOT MATCH ANY MATCHER BELOW.
/// Its message is "The provided name or date of birth does not match BVN
/// records" — no "your profile", so every message-classifying caller got
/// [KycProfileField.none] and a bare Try Again against an unchanged profile.
/// That is the loop this file exists to stop, and it was reachable from the
/// Tier-3 screen's `_handleFailure`.
///
/// AND THE DATE OF BIRTH COMES FIRST WHEN WE HOLD NONE. banking-service
/// refuses a name difference only when it has no date of birth to compare —
/// its log line reads "name mismatch with no comparable date of birth" — and
/// when a date IS comparable and agrees, the registry's spelling is adopted
/// and the check passes. So for a profile with no date on file, supplying one
/// is the action that unblocks the customer; a name edit is a guess, because
/// the registry's spelling is deliberately never shown to them.
///
/// [profileHasDateOfBirth] is null when the caller does not know. Then the
/// name editor is the answer — the same destination as before this branch
/// existed, and still strictly better than a Try Again.
KycProfileField _detailsMismatchField(bool? profileHasDateOfBirth) =>
    profileHasDateOfBirth == false
        ? KycProfileField.dateOfBirth
        : KycProfileField.name;

KycProfileField kycProfileFieldFor(
  String? rawMessage, {
  String? code,
  bool? profileHasDateOfBirth,
}) {
  if (code != null && _supportOnlyCodes.contains(code)) {
    return KycProfileField.support;
  }
  if ((code ?? '').trim().toUpperCase() == _detailsMismatchCode) {
    return _detailsMismatchField(profileHasDateOfBirth);
  }
  final m = (rawMessage ?? '').toLowerCase();
  if (m.isEmpty) return KycProfileField.none;

  // The same refusal, recognised from its wording, for any path that does not
  // carry the code through (an older server, or a message surfaced from a
  // generic catch). Guarded on BOTH halves so an unrelated sentence mentioning
  // a name cannot land here.
  if (m.contains('verification partner') &&
      m.contains('name') &&
      m.contains('support')) {
    return KycProfileField.support;
  }

  // ALREADY-LINKED FIRST, before the field matchers. The message names an
  // "account", not a field, and retrying it can never succeed — so it must
  // not fall through to a Try Again, nor be captured by a later matcher.
  if (m.contains('already linked') ||
      (m.contains('already') && m.contains('another account'))) {
    return KycProfileField.support;
  }

  // DATE OF BIRTH, and guarded on BOTH halves like everything else here.
  //
  // THE GAP THIS CLOSES. An editor for this landed on 2026-11-10 and the
  // classifier was not taught about it, so every caller that classifies by
  // MESSAGE rather than branching on the code got KycProfileField.none — a
  // "Try Again" button against an unchanged profile, which is the precise loop
  // this file was written to stop. The editor existed and was unreachable.
  //
  // "your profile" is what makes this specific. IDENTITY_DOB_MISMATCH reads
  // "The date of birth on your profile does not match this BVN", while the
  // combined IDENTITY_DETAILS_MISMATCH reads "The provided name or date of
  // birth does not match BVN records" — that one is a name decision and is
  // routed by code before this is ever consulted, so it must not be swallowed
  // here.
  if (m.contains('date of birth') && m.contains('your profile')) {
    return KycProfileField.dateOfBirth;
  }

  // Phone next: its messages are the most specific, and the Nigerian-number
  // one also contains the word "number", which nothing else does.
  if (m.contains('phone')) return KycProfileField.phone;
  if (m.contains('email')) return KycProfileField.email;
  // "we need your name on your profile" — guarded on "profile" so an
  // unrelated message mentioning a bank name is not mistaken for this.
  if (m.contains('name') && m.contains('profile')) return KycProfileField.name;
  return KycProfileField.none;
}

/// The primary button's label for [field]. Names the field, because "Open
/// Settings" leaves the user hunting for which setting.
String kycProfileFixLabel(KycProfileField field) {
  switch (field) {
    case KycProfileField.phone:
      return 'Update phone';
    case KycProfileField.email:
      return 'Update email';
    case KycProfileField.name:
      return 'Update your name';
    case KycProfileField.dateOfBirth:
      return 'Update date of birth';
    case KycProfileField.support:
      return 'Contact support';
    case KycProfileField.none:
      return 'Try Again';
  }
}

/// Takes the user to the right editor and reports whether anything changed.
///
/// A `true` result is the caller's cue to re-run verification immediately:
/// the user came here from a failed check, fixed the thing it complained
/// about, and should not have to find their way back and start again.
///
/// Phone has its own screen (it is OTP-verified, so it cannot be a text field
/// in a dialog). Name lives in the profile editor on the Settings screen, and
/// email is not directly editable today — both route to Settings, which is
/// where the editor is opened from, rather than pretending to a destination
/// that does not exist.
Future<bool> openKycProfileFix(
  KycProfileField field, {
  String? supportSubject,
  String? supportMessage,
}) async {
  switch (field) {
    case KycProfileField.phone:
      final changed = await Get.to(() => const ChangePhoneScreen());
      return changed == true;
    case KycProfileField.support:
      // The in-app ticket screen — the one destination that can actually
      // resolve a BVN already bound to another account. Pushed directly
      // because it has no named route.
      //
      // CARRIES THE CONTEXT. It used to open on an empty ticket list, so the
      // customer had to find the FAB and then describe, unaided, a refusal the
      // app had already named — and the agent got a ticket with nothing
      // identifying in it, making "which number?" the inevitable first reply.
      // The caller passes what it already knows and the composer opens on it,
      // editable.
      //
      // Returns false: no auto-retry, because nothing the customer did here
      // changed who owns that number.
      await Get.to(() => SupportTicketsScreen(
            composeSubject: supportSubject,
            composeMessage: supportMessage,
          ));
      return false;
    case KycProfileField.dateOfBirth:
      return await openKycDateOfBirthFix(
        supportSubject: supportSubject,
        supportMessage: supportMessage,
      );
    case KycProfileField.name:
      // A PURPOSE-BUILT SCREEN, NOT SETTINGS.
      //
      // This used to route to the Settings profile editor, which accepted a
      // name and silently DISCARDED it — names were ignored by UpdateProfile
      // outright. So the one action pointing at the actual problem led
      // somewhere that could not fix it, and the next attempt failed in
      // exactly the same way.
      //
      // KycUpdateDetailsScreen edits the name against the rule that now
      // applies (an unverified holder may correct their own), reads the saved
      // profile back to confirm it was really applied, and reports TRUE only
      // then — so the caller re-runs verification only when the retry can
      // actually produce a different answer.
      final updated = await Get.to(() => const KycUpdateDetailsScreen());
      return updated == true;
    case KycProfileField.email:
      await Get.toNamed(AppRoutes.profileSettings);
      // Settings cannot tell us whether the user edited anything, so this
      // never auto-retries. Returning false leaves them on the KYC screen
      // with Continue still there, which is honest about what we know.
      return false;
    case KycProfileField.none:
      return false;
  }
}

/// Let the customer correct the date of birth on their profile.
///
/// RETURNS TRUE ONLY IF THE PROFILE REALLY CHANGED, which is the contract every
/// caller here depends on: a caller retries verification on true, and retrying
/// against an unchanged profile reproduces the identical refusal. That is the
/// loop this whole file exists to prevent, so "the user tapped something" is not
/// good enough — the save has to have been accepted.
///
/// WHY THE SERVER'S SENTENCE IS SHOWN VERBATIM on refusal. auth-service decides
/// whether a date of birth may change: it accepts one while the identity is
/// unverified and refuses once it has been matched against NIBSS or NIMC. That
/// rule is not re-derived here — a second copy would drift the first time the
/// rule moved, and the server's message already says what to do.
///
/// NOTHING IS PRE-FILLED FROM THE REGISTRY. The picker opens on the date we
/// already hold, never on the one the registry returned: on a mismatch the
/// server has evidence the asker may not be the holder, so showing the
/// registry's date would hand over the answer to the only question being asked.
Future<bool> openKycDateOfBirthFix({
  String? supportSubject,
  String? supportMessage,
}) async {
  final ctx = Get.context;
  if (ctx == null) return false;

  // ASK THE GATE BEFORE OPENING THE PICKER.
  //
  // auth-service refuses a date-of-birth change once the identity has been
  // verified, and the first two days of production logs recorded that refusal
  // 36 times out of 36 attempts — a 100% dead-end rate. Every one of those
  // customers chose a date, confirmed it spelled out, waited on the write, and
  // was then told the field was locked and to contact support. A customer
  // reported it on 2026-11-24 as not being able to correct his details at all.
  //
  // The editor's own doc says the server "enforces that and says so, and this
  // editor surfaces that sentence rather than pretending" — which is right
  // about where the authority lives and wrong about where the question should
  // be ASKED. Asking first costs nothing, the answer is already on the session
  // profile, and it turns a dead end into a ticket a human can act on.
  //
  // ASK THE SERVER WHAT IT HOLDS, FIRST — the cached flag is the problem.
  //
  // The note below used to say a cached `false` was safe because "the flag
  // only goes false→true, so a stale copy can be behind the server but never
  // ahead of it", and that we would simply "let the refusal land as before".
  // Measured 2026-11-25, that is precisely the dead end that is still
  // happening: auth refused "date of birth is locked" TEN times on 25 Nov
  // alone, after the gate was added. Being behind the server is not harmless
  // here — it is the entire failure.
  //
  // How a session copy goes stale on exactly this flag: verification sets
  // `identity_verified` server-side, adopts the registry name and raises the
  // tier, and tells the app nothing. The screen is still holding the profile
  // it loaded at LOGIN. So the customer picks a date, confirms it spelled
  // out, waits on the write, and is told the field is locked — which is where
  // they get stuck, because a snackbar is not a destination.
  //
  // refreshProfileQuietly re-reads the profile without emitting (emitting
  // would make every login surface run goAfterLogin and replace the stack
  // mid-flow). It is best-effort and bounded: if it cannot answer, the cached
  // value still decides and the refusal still has somewhere to go — see the
  // locked branch on the save result below.
  try {
    await ctx.read<AuthenticationCubit>().refreshProfileQuietly().timeout(
          const Duration(seconds: 6),
        );
  } catch (_) {
    // Offline, slow, or no cubit in scope. The cached flag decides, exactly
    // as it did before this call existed.
  }
  if (!ctx.mounted) return false;

  if (_dobLockedByVerification(ctx)) {
    await _openDobSupportTicket(
      supportSubject: supportSubject,
      supportMessage: supportMessage,
    );
    return false;
  }

  final now = DateTime.now();
  // Bounds mirror auth-service's own checks. The server repeats them because a
  // client is not a validator; the client applies them so an impossible date
  // cannot be chosen in the first place.
  final latest = DateTime(now.year - 16, now.month, now.day);
  final earliest = DateTime(now.year - 100);

  DateTime initial = DateTime(now.year - 30, 1, 1);
  try {
    // THE SAME SOURCE THE SCREENS READ. An earlier version of this asked the
    // service locator for a ProfileCubit, which is not registered there — so the
    // lookup threw, the catch swallowed it, and the seeding silently never
    // happened while looking like a feature. AuthenticationCubit.currentProfile
    // is what bvn_signup_screen itself uses.
    final profile = ctx.read<AuthenticationCubit>().currentProfile;
    final existing = DateTime.tryParse(profile?.user.dateOfBirth ?? '');
    if (existing != null &&
        !existing.isAfter(latest) &&
        !existing.isBefore(earliest)) {
      // Open on what we hold, so the fix is a nudge rather than a re-entry.
      initial = existing;
    }
  } catch (_) {
    // No profile in scope — the default stands. Never a reason to refuse the
    // edit: a customer who cannot be seeded can still pick their own birthday.
  }

  final picked = await showDatePicker(
    context: ctx,
    initialDate: initial,
    firstDate: earliest,
    lastDate: latest,
    helpText: 'Your date of birth',
    // YEAR FIRST — see phone_personal_details_screen. This one writes
    // straight to the profile that every later registry check runs against.
    initialDatePickerMode: DatePickerMode.year,
    fieldHintText: 'Day, month, year',
  );
  if (picked == null) return false;
  // The picker is a route, and the customer was inside it for as long as it
  // took to scroll to a year in the 1990s. A session timeout, a background,
  // or a pop underneath leaves this context defunct; mounting the confirm
  // dialog on it would throw where the customer can only see a frozen screen.
  if (!ctx.mounted) return false;

  // CONFIRM IT SPELLED OUT BEFORE WRITING IT.
  //
  // This writes straight to the profile, and the profile is what every later
  // registry check is run against — so a wrong date here is not visible until
  // a verification fails for a reason that names neither the date nor this
  // screen. "9 July 1999" can be checked against a document; "1999-07-09"
  // cannot, because it reads as two different days depending on the reader.
  final confirmed = await showDialog<bool>(
    context: ctx,
    builder: (dctx) => AlertDialog(
      title: const Text('Is this your date of birth?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            humanDob(picked),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          const Text(dobMustMatchHint),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dctx).pop(false),
          child: const Text('Change it'),
        ),
        TextButton(
          onPressed: () => Navigator.of(dctx).pop(true),
          child: const Text('Yes, use this'),
        ),
      ],
    ),
  );
  if (confirmed != true) return false;

  final iso = isoDob(picked);

  // THE SAVE RUNS BEHIND A BLOCKING, BOUNDED OVERLAY.
  //
  // Until 2026-11-24 this was a bare `await` on the network with nothing on
  // screen. Once the confirm dialog popped the customer was looking at the
  // plain form again, with a live Continue button and no sign that a save was
  // in flight — which on a congested cell is indistinguishable from a tap
  // that did nothing. A customer reported exactly that ("the UI became
  // unresponsive") and could not finish verification. The second tap it
  // invites is not free either: it fires another identity write, or another
  // billed verification attempt against a three-attempt cap.
  //
  // `runKycSave` is also what guarantees the overlay comes DOWN — on success,
  // on refusal, on a thrown error and on a socket that never answers.
  // Stranding it would be a worse version of the same bug.
  //
  // A FRESH CONTEXT. `ctx` was captured before the picker and the confirm
  // dialog; both have come and gone since, and on a resume the one this
  // function opened with can be defunct. The overlay must mount on the tree
  // that is actually on screen now.
  final saveCtx = Get.context ?? ctx;
  // Nothing on screen to mount an overlay on. Refusing is the honest answer:
  // writing an identity field with no way to report the outcome is how a
  // correction lands and the customer is never told, which is the shape of
  // bug this whole function is being hardened against.
  if (!saveCtx.mounted) return false;

  Either<Failure, User> result;
  try {
    result = await runKycSave<Either<Failure, User>>(
      saveCtx,
      message: 'Saving your date of birth…',
      action: () => serviceLocator<IProfileRepository>()
          .updateUserProfile(dateOfBirth: iso),
    );
  } on TimeoutException {
    // NOT WORDED AS A REFUSAL. The write may well have landed — the answer is
    // what did not arrive — so "could not save" would send a customer to
    // support over a correction that is already applied. Returning false is
    // the honest answer to the caller's question ("may I retry verification
    // on this?"): we do not know that the profile changed, and retrying a
    // billed attempt on a guess is the loop this file exists to prevent.
    Get.snackbar('Still saving',
        'Your network is slow, so we could not confirm your date of birth was '
        'saved. Check your connection and open this again — if it saved, the '
        'date you picked will already be there.');
    return false;
  } catch (_) {
    // The repository converts gRPC errors into a LEFT, so reaching here means
    // something below it threw outright. Surfaced rather than swallowed, for
    // the same reason the refusal is: a customer who picked a date and saw
    // nothing happen simply picks it again.
    Get.snackbar('Could not save',
        'We could not save your date of birth just now. Please try again.');
    return false;
  }

  return result.fold(
    (failure) {
      // A LOCKED REFUSAL IS A DESTINATION, NOT A MESSAGE.
      //
      // This used to show the server's sentence in a snackbar and stop. The
      // sentence does name support — "contact support to correct it" — but
      // naming support is not reaching it: the customer is left on the same
      // screen, holding a date they cannot save, with no way forward. That is
      // the "stuck at that stage" report, and it survived the gate above
      // because the gate reads a copy that can be behind the server.
      //
      // So the refusal the gate exists to pre-empt now ends where the gate
      // would have sent them. Two routes to one place: the gate when we know
      // in advance, this when we only find out on the write.
      if (_isDobLockedFailure(failure.message)) {
        // The session copy was wrong, and we have just learned the truth from
        // the authority. Record it so a second attempt takes the gate above
        // rather than paying for another refused write.
        try {
          Get.context?.read<AuthenticationCubit>().applyIdentityVerified();
        } catch (_) {/* best effort; the server still decides */}
        unawaited(_openDobSupportTicket(
          supportSubject: supportSubject,
          supportMessage: supportMessage,
        ));
        return false;
      }
      // Any other refusal — a bad date, a validation rule — is the customer's
      // to act on here, so it stays a message on this screen.
      // Get.snackbar, not ScaffoldMessenger: this can be called from a dialog
      // route whose context has no Scaffold ancestor, where ScaffoldMessenger.of
      // throws. The rest of this feature already uses Get.snackbar.
      Get.snackbar('Could not save', failure.message);
      return false;
    },
    (saved) {
      // THE SESSION COPY HAS TO LEARN THIS, OR THE RETRY SENDS THE OLD DATE.
      //
      // This is the second half of the same customer's dead end, and it is the
      // identical defect `applyCorrectedName` was written for — on the other
      // identity field, where it was simply never done. `bvn_signup_screen`
      // reads the date of birth from AuthenticationCubit's SESSION profile
      // (`_profile()`), not from ProfileCubit and not from the server, so a
      // correction saved here left that copy stale and `_submit()` re-sent the
      // OLD date: identical refusal, with the one useful action looking like
      // it had done nothing. Tier 3 reads the same field when it opens Mono,
      // so the stale copy also hands Mono a date the customer has corrected.
      //
      // Worse than a plain stale read: the backend reuses an in-flight Prove
      // session when the identity is UNCHANGED, so the old date matches the
      // previous session and reuses it — no new session, no cooldown notice,
      // and the same failure with nothing to explain it.
      //
      // THE VALUE WE SENT, not one read back. `UpdateUserProfile` answers with
      // a `CommonUser`, and that message carries no `date_of_birth` at all
      // (see `UserModel.fromProto`) — so `saved.dateOfBirth` is null even on a
      // success and a read-back would compare against nothing. auth-service is
      // explicit rather than silent here: `UpdateDateOfBirth` refuses a
      // verified holder and the handler answers `success:false`, which arrives
      // as the LEFT above. So a RIGHT means the ISO we sent is what is stored.
      // The returned user is still preferred when it ever does carry a date,
      // so this starts using the server's answer the moment the field exists.
      final confirmed = (saved.dateOfBirth ?? '').trim();
      final applied = confirmed.isNotEmpty ? confirmed : iso;
      try {
        Get.context
            ?.read<AuthenticationCubit>()
            .applyCorrectedDateOfBirth(applied);
      } catch (_) {
        // No AuthenticationCubit above this context. The save still stands and
        // the caller may still retry — the server holds the corrected date, so
        // the worst case is the one screen that reads the session copy sending
        // the old one, which is strictly better than refusing the edit.
      }
      return true;
    },
  );
}

/// Is the stored date of birth beyond the holder's reach?
///
/// Mirrors auth-service's `UpdateDateOfBirth` gate — `users.identity_verified`
/// — read off the SESSION profile, which is the same copy the KYC screens
/// initiate verification from. Returns false on anything unexpected (no
/// profile, no cubit above this context): the server rechecks regardless, so
/// guessing "locked" here would deny an edit that would have been allowed,
/// whereas guessing "open" only reproduces the behaviour this replaced.
/// Is this refusal auth-service's identity lock?
///
/// Matched on the SERVER's own words, because the failure arrives as a message
/// rather than a code: `UpdateDateOfBirth` answers "date of birth is locked
/// because your identity has been verified — contact support to correct it".
///
/// Deliberately loose — "locked" plus an identity word — so a reworded
/// sentence still routes correctly. The cost of a false positive is a support
/// screen the customer can back out of; the cost of a false negative is the
/// dead end this exists to close.
bool _isDobLockedFailure(String message) {
  final m = message.toLowerCase();
  if (!m.contains('lock')) return false;
  return m.contains('identity') || m.contains('verified');
}

bool _dobLockedByVerification(BuildContext ctx) {
  try {
    final profile = ctx.read<AuthenticationCubit>().currentProfile;
    return profile?.user.identityVerified ?? false;
  } catch (_) {
    return false;
  }
}

/// The honest destination when the date of birth is locked.
///
/// A HUMAN, NOT A RETRY. Nothing the customer can do in the app changes a date
/// the registry has already confirmed, so the only move that exists is an
/// agent with the authority to correct the record — and the ticket opens
/// carrying what we already know, because the alternative is the customer
/// describing, unaided, a refusal the app had already named.
///
/// NO FAULT, NO CAUSE, NO APOLOGY in the composed message: it is sent in the
/// customer's name, so it says what they want done and nothing about why it
/// cannot be done here.
Future<void> _openDobSupportTicket({
  String? supportSubject,
  String? supportMessage,
}) async {
  await Get.to(() => SupportTicketsScreen(
        composeSubject: supportSubject?.trim().isNotEmpty == true
            ? supportSubject
            : 'Please correct the date of birth on my account',
        composeMessage: supportMessage?.trim().isNotEmpty == true
            ? supportMessage
            : 'The date of birth on my account is wrong and I can no longer '
                'change it in the app because my identity is verified.\n\n'
                'Please can you correct it so I can finish verifying?',
      ));
}
