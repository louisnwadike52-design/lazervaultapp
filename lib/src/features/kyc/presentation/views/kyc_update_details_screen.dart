import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lazervault/core/network/network_timeouts.dart';
import 'package:lazervault/core/utils/dob_display.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/shared_widgets/lv_snackbar.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/phone_flow_scaffold.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/profile/cubit/profile_state.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/kyc/data/services/prove_kyc_http_service.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/kyc_profile_fix.dart';
import 'package:lazervault/src/features/profile/presentation/view/change_phone_screen.dart';
import 'package:lazervault/src/features/authentication/domain/sms_policy.dart';

/// Correct the details identity verification is checking against.
///
/// ## Why this screen has to exist
///
/// Mono validates the customer's name against the BVN/NIN record and refuses on
/// a mismatch. Somebody who signed up with a typo therefore fails verification
/// every single time, and until now had no way to fix it:
///
///   * names were IGNORED by UpdateProfile — identity, not preference — so the
///     Settings profile editor accepted the correction and silently discarded
///     it, and the next attempt failed identically;
///   * the KYC screen's own "Update profile" action routed to that same
///     editor, so the one affordance pointing at the problem led nowhere.
///
/// The immutability rule only ever made sense once KYC had verified a name.
/// An unverified holder is now allowed to correct their own (auth-service,
/// UpdateProfileWithAddress) — nothing is being contradicted, because no
/// document has been accepted and the next Prove session is what decides
/// whether the new name is real.
///
/// ## Why Continue is disabled until something changes
///
/// Every verification attempt bills a session. Submitting the same details
/// again cannot produce a different answer, so offering a live button for it
/// would spend money to reproduce a failure the customer has already seen.
/// The button turning on IS the feedback that the edit registered.
class KycUpdateDetailsScreen extends StatefulWidget {
  const KycUpdateDetailsScreen({super.key});

  @override
  State<KycUpdateDetailsScreen> createState() => _KycUpdateDetailsScreenState();
}

class _KycUpdateDetailsScreenState extends State<KycUpdateDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstName;
  late final TextEditingController _middleName;
  late final TextEditingController _lastName;

  /// What the fields held when the screen opened. The comparison baseline for
  /// "has anything changed", and what a successful save becomes.
  String _baselineFirst = '';
  /// The stored middle name, so an untouched save cannot change it.
  String _baselineMiddle = '';
  String _baselineLast = '';

  /// The date of birth and phone number AS CURRENTLY STORED, shown on their
  /// rows rather than hidden behind them.
  ///
  /// The point is that a correct value needs no interaction at all. A row
  /// reading "Date of birth ›" tells the customer nothing about whether the
  /// one on file is the one that failed — so the only way to find out is to
  /// open the editor, read it, and back out. Showing the value makes the
  /// common case (it is already right) cost nothing, and the uncommon case
  /// (it is wrong) obvious at a glance.
  String _currentDob = '';
  String _currentPhone = '';

  bool _saving = false;
  bool _loadedBaseline = false;

  /// Whether this customer has already started verification with Mono.
  ///
  /// THREE STATES, AND THE NULL MATTERS. `true` means a Prove session exists,
  /// so Mono already holds a customer record under the CURRENT name. `false`
  /// means it does not and a correction here is free. `null` means we could
  /// not find out — a failed or slow status call — and the warning hedges
  /// rather than disappearing, because the cost of not warning somebody who
  /// needed it is a locked verification and the cost of over-warning is a
  /// sentence they can ignore.
  bool? _verificationStarted;

  /// Why this screen warns at all — the trap it exists to close.
  ///
  /// MEASURED IN PRODUCTION, 2026-11-09. A customer ran eight verification
  /// attempts as one surname, corrected it here, and every attempt afterwards
  /// was refused by Mono with
  ///
  ///   400 "Customer name does not match the existing record."
  ///
  /// Mono registers a customer against the details we send and then refuses a
  /// DIFFERENT name for the same person. The correction is still the right
  /// thing to offer — Mono validates the name against the BVN record, so a
  /// typo makes verification impossible until it is fixed — but it cannot
  /// reach into Mono's registry, and nothing on this screen said so. The
  /// customer was left retrying a wall, 27 times.
  void _loadVerificationState() async {
    try {
      final st = await serviceLocator<ProveKycHttpService>()
          .status()
          .timeout(const Duration(seconds: 4));
      if (!mounted) return;
      final state = st.sessionState.trim().toLowerCase();
      setState(() {
        // '' and 'none' both mean "no session has ever been started".
        _verificationStarted = state.isNotEmpty && state != 'none';
      });
    } catch (_) {
      // Stays null — see the field note. The hedged wording covers it.
    }
  }

  @override
  void initState() {
    super.initState();
    _firstName = TextEditingController();
    _middleName = TextEditingController();
    _lastName = TextEditingController();
    _hydrate();
    _loadVerificationState();
  }

  /// Fill the fields from the profile, WITHOUT destroying anything typed.
  ///
  /// The profile can land after this screen opens — a cold resume straight
  /// into KYC is the common case. The late arrival still has to set the
  /// baseline (otherwise "has anything changed" compares against nothing and
  /// Continue goes live on an unedited field), but overwriting the
  /// controllers at that moment would wipe a correction the customer had
  /// already started typing, with no warning and no undo.
  ///
  /// So: the baseline is always recorded; the text is only replaced while the
  /// field is still untouched.
  void _hydrate() {
    final state = context.read<ProfileCubit>().state;
    if (state is! ProfileLoaded) return;

    _baselineFirst = (state.user.firstName).trim();
    _baselineLast = (state.user.lastName).trim();
    _baselineMiddle = (state.user.middleName).trim();
    // Displayed, never edited here — their editors own them. Re-read on every
    // hydrate so a value corrected in one of those editors is reflected the
    // moment this screen rebuilds, rather than showing the stale one it opened
    // with.
    // NOT FROM ProfileCubit — IT CANNOT CARRY A DATE OF BIRTH.
    //
    // `UpdateUserProfile`/`GetUserProfile` answer with the COMMON proto's
    // `User`, which has no `date_of_birth` field at all (see
    // `UserModel.fromProto`), so `ProfileLoaded.user.dateOfBirth` is null for
    // every holder — not stale, never populated. Read from here it rendered
    // "Not set" to customers whose date of birth was correctly on file, on the
    // one screen whose job is to show them what a registry check compares.
    // The copy below calls an empty date "a guaranteed mismatch", so the
    // screen was telling a correctly-registered customer their verification
    // would fail and sending them into the editor to retype a date we already
    // held — the dead end this file exists to remove, pointed the wrong way.
    //
    // The date rides the AUTH profile (`fromAuthProto`), which is also the
    // copy every registry check is actually run against. settings_screen
    // reads its birthday banner from there for the same reason, and
    // kyc_profile_fix seeds its picker from there.
    _currentDob = (context.read<AuthenticationCubit>().currentProfile?.user
                .dateOfBirth ??
            '')
        .trim();
    _currentPhone = (state.user.phoneNumber ?? '').trim();
    if (_firstName.text.trim().isEmpty) _firstName.text = _baselineFirst;
    if (_lastName.text.trim().isEmpty) _lastName.text = _baselineLast;
    // PREFILLED, and that matters: this box can CLEAR the stored value,
    // so opening blank over a real middle name would erase it on save.
    if (_middleName.text.trim().isEmpty) _middleName.text = _baselineMiddle;
    _loadedBaseline = true;
  }

  @override
  void dispose() {
    _firstName.dispose();
    _middleName.dispose();
    _lastName.dispose();
    super.dispose();
  }

  /// Compared TRIMMED and case-insensitively.
  ///
  /// "ada" and "Ada " are the same name to the provider, so treating either as
  /// an edit would bill a session to send a value the record already matches
  /// — and then, if the window had not elapsed, make the customer wait for the
  /// privilege.
  bool get _changed {
    final f = _firstName.text.trim();
    final l = _lastName.text.trim();
    if (f.isEmpty || l.isEmpty) return false;
    // The middle name counts as a change — INCLUDING being emptied, which is
    // how somebody removes one they never had. Leaving it out of this check
    // would leave Continue disabled with an edit on screen.
    final m = _middleName.text.trim();
    return f.toLowerCase() != _baselineFirst.toLowerCase() ||
        l.toLowerCase() != _baselineLast.toLowerCase() ||
        m.toLowerCase() != _baselineMiddle.toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    // The profile can arrive after this screen opens (a cold resume straight
    // into KYC). Re-hydrate once it does, so the fields are never blank over a
    // profile we actually hold.
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (_, state) {
        if (!_loadedBaseline && state is ProfileLoaded) {
          setState(_hydrate);
        }
      },
      child: PhoneFlowScaffold(
        title: 'Check your details',
        subtitle:
            'Your name has to match your BVN or NIN record exactly. If there '
            'is a spelling difference, correct it here and we will try the '
            'check again.',
        primaryLabel: 'Continue',
        isLoading: _saving,
        // DISABLED UNTIL SOMETHING ACTUALLY CHANGES — see the class note.
        onPrimary: (_changed && !_saving) ? _submit : null,
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _field(
                  controller: _firstName,
                  label: 'First name',
                  hint: 'As written on your BVN or NIN',
                ),
                SizedBox(height: 16.h),
                _field(
                  controller: _middleName,
                  label: 'Middle name (optional)',
                  hint: 'Leave empty if your record has none',
                ),
                SizedBox(height: 16.h),
                _field(
                  controller: _lastName,
                  label: 'Last name',
                  hint: 'As written on your BVN or NIN',
                ),
                SizedBox(height: 18.h),
                // Only when there is something to warn about — see
                // [_verificationStarted]. A first-timer who has never started
                // verification is told nothing, because for them changing a
                // name here really is free.
                if (_verificationStarted != false) ...[
                  _alreadyStartedWarning(),
                  SizedBox(height: 12.h),
                ],
                _hint(),

                // THE OTHER TWO THINGS A VERIFICATION COMPARES, which this
                // screen could not reach.
                //
                // A registry check compares the NAME, the DATE OF BIRTH and —
                // once an SMS provider is active — the phone number. Editors
                // for the other two already exist and are already wired into
                // the failure path: openKycProfileFix classifies a refusal and
                // routes to them. But that path only opens when a verification
                // has already failed with a message naming that specific
                // field.
                //
                // Somebody who opens "Update your information" because they
                // KNOW their date of birth is wrong found names only, and had
                // to fail a billed verification first — with exactly the right
                // wording — to be shown the editor that was there all along.
                //
                // Linked rather than inlined: the date of birth has its own
                // confirm-and-save dialog, and the phone CANNOT be a text
                // field here because changing it re-runs an OTP against the
                // new handset. Duplicating either would be two implementations
                // of a rule that has to agree.
                SizedBox(height: 20.h),
                _otherDetailsSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Date of birth and phone number, as links to the editors that own them.
  ///
  /// Each reports whether anything actually changed, and a change closes this
  /// screen with `true` — the same contract the name save uses, so the caller
  /// re-runs verification only when the retry can produce a different answer.
  Widget _otherDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Something else wrong?',
          style: GoogleFonts.inter(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Verification also checks these. If what you see here is already '
          'correct, leave it — there is nothing to change.',
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: Colors.white.withValues(alpha: 0.6),
            height: 1.4,
          ),
        ),
        SizedBox(height: 10.h),
        _otherDetailRow(
          icon: Icons.cake_outlined,
          label: 'Date of birth',
          // The value itself, so a correct one needs no tap. "Not set" is its
          // own answer and a useful one — an empty date is a guaranteed
          // mismatch, which is worth seeing before spending a verification.
          //
          // SPELLED OUT, NOT ISO. `1999-07-09` reads as 9 July to someone
          // using day/month and as 7 September to someone using month/day, so
          // the one fact that tells a customer what is wrong was shown in the
          // one format that cannot say it — see core/utils/dob_display.dart,
          // which exists for that exact confusion and which this row was
          // written before.
          value: _currentDob.isEmpty ? 'Not set' : humanDobFromIso(_currentDob),
          onTap: _saving
              ? null
              : () async {
                  final changed = await openKycDateOfBirthFix();
                  if (changed == true && mounted) Get.back(result: true);
                },
        ),
        SizedBox(height: 8.h),
        _otherDetailRow(
          icon: Icons.phone_iphone_outlined,
          label: 'Phone number',
          value: _currentPhone.isEmpty ? 'Not set' : _currentPhone,
          // DISABLED, WITH THE REASON, RATHER THAN HIDDEN.
          //
          // Changing a number means proving the new one by OTP, so with no
          // active SMS provider the change cannot complete. Hiding the row
          // would leave someone whose number is genuinely wrong hunting for an
          // option that is simply switched off; the row states that, which is
          // also what the change screen itself would say after a wasted trip.
          subtitle: SmsPolicy.canChangePhoneNumber
              ? null
              : SmsPolicy.unavailableReason,
          onTap: (_saving || !SmsPolicy.canChangePhoneNumber)
              ? null
              : () async {
                  final changed = await Get.to(() => const ChangePhoneScreen());
                  if (changed == true && mounted) Get.back(result: true);
                },
        ),
      ],
    );
  }

  Widget _otherDetailRow({
    required IconData icon,
    required String label,
    /// What is CURRENTLY STORED. Shown beside the label so the customer can
    /// see at a glance whether this field is the one that is wrong, instead of
    /// opening each editor to find out.
    String? value,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    final enabled = onTap != null;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
        child: Row(
          children: [
            Icon(icon,
                size: 18.sp,
                color: Colors.white.withValues(alpha: enabled ? 0.8 : 0.35)),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.white
                          .withValues(alpha: enabled ? 0.6 : 0.35),
                    ),
                  ),
                  if (value != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      value,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                            .withValues(alpha: enabled ? 0.95 : 0.5),
                      ),
                    ),
                  ],
                  if (subtitle != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        color: Colors.white.withValues(alpha: 0.5),
                        height: 1.3,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (enabled)
              Icon(Icons.chevron_right_rounded,
                  size: 20.sp, color: Colors.white.withValues(alpha: 0.6)),
          ],
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF262626),
          ),
        ),
        SizedBox(height: 6.h),
        TextFormField(
          controller: controller,
          textCapitalization: TextCapitalization.words,
          // A name is letters, spaces, hyphens and apostrophes. Digits in a
          // name field are always a mistake and Mono will refuse them.
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
            LengthLimitingTextInputFormatter(60),
          ],
          // Rebuild on every keystroke so Continue turns on the moment the
          // edit is real — the button IS the confirmation that it registered.
          onChanged: (_) => setState(() {}),
          style: GoogleFonts.inter(
            fontSize: 15.sp,
            color: const Color(0xFF262626),
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              fontSize: 13.sp,
              color: const Color(0xFF9CA3AF),
            ),
            filled: true,
            fillColor: const Color(0xFFF3F4F6),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF4834D4), width: 1.6),
            ),
          ),
        ),
      ],
    );
  }

  /// What a correction costs once verification has already been attempted.
  ///
  /// Deliberately amber and deliberately above the neutral hint: this is the
  /// one thing on the screen that can leave somebody unable to proceed, and it
  /// has to be read before Continue, not after.
  ///
  /// It does NOT tell the customer to avoid correcting their name. The
  /// correction is usually the only way they will ever pass — Mono checks the
  /// name against the BVN record. It tells them what to expect so that
  /// contacting support is an informed next step rather than a discovery made
  /// after twenty failed attempts.
  Widget _alreadyStartedWarning() {
    const amber = Color(0xFFB45309);
    final known = _verificationStarted == true;
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: amber.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: amber.withValues(alpha: 0.28)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, size: 18.sp, color: amber),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  known
                      ? 'You have already started verification'
                      : 'If you have already started verification',
                  style: GoogleFonts.inter(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w700,
                    color: amber,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Our verification partner already has a name on file for '
                  'you. Changing it here can mean they refuse the next check '
                  'until support updates their record — so if verification '
                  'still will not start after this, contact support rather '
                  'than retrying.',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    height: 1.45,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _hint() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF4834D4).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF4834D4).withValues(alpha: 0.18)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded,
              size: 18.sp, color: const Color(0xFF4834D4)),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'Use the spelling on the record itself, not the one you prefer. '
              'Once your identity is verified this becomes your account name '
              'and can only be changed through support.',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                height: 1.45,
                color: const Color(0xFF6B7280),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (_saving) return;
    final first = _firstName.text.trim();
    final last = _lastName.text.trim();
    // Non-null, so the server's update_middle_name flag is set and an emptied
    // box really clears it. This screen OWNS the field: it shows the stored
    // value and saves what it shows.
    final middle = _middleName.text.trim();
    if (first.isEmpty || last.isEmpty) return;

    setState(() => _saving = true);
    final cubit = context.read<ProfileCubit>();
    // BOUNDED, OR THE BUTTON NEVER COMES BACK.
    //
    // `_saving` disables Continue and every row on this screen, and it is
    // cleared only after this await returns. A write that never answers
    // therefore left a live screen with nothing enabled and no message — the
    // "UI became unresponsive" a customer reported on 2026-11-24 while trying
    // to correct exactly these fields.
    //
    // `interactive`, the app's single answer for "they tapped something and
    // are watching": the customer asked for this specific save and the write
    // matters, so it gets the full allowance before we stop waiting.
    try {
      await cubit
          .updateUserProfile(
              firstName: first, lastName: last, middleName: middle)
          .timeout(NetworkTimeouts.interactive);
    } on TimeoutException {
      if (!mounted) return;
      setState(() => _saving = false);
      // NOT WORDED AS A REFUSAL — the write may well have landed; the answer
      // is what did not arrive. And NOT popped with `true`: the caller would
      // spend a billed verification attempt on a change we cannot confirm.
      LVSnackbar.showWarning(
        title: 'Still saving',
        message: 'Your network is slow, so we could not confirm your details '
            'were saved. Check your connection and open this again — if it '
            'saved, what you typed will already be there.',
      );
      return;
    }
    if (!mounted) return;

    final state = cubit.state;
    if (state is ProfileError) {
      setState(() => _saving = false);
      LVSnackbar.showError(
        title: 'Could not save',
        message: state.message,
      );
      return;
    }

    // SAVED IS NOT THE SAME AS ACCEPTED.
    //
    // auth-service ignores a name edit from a holder whose identity is already
    // verified, and does so SILENTLY — by design, so an older app build that
    // still posts the field on every save does not break the whole profile
    // update. That means a "success" here can mean the change was dropped, and
    // returning `true` would send the caller straight into another billed
    // verification attempt with the same details.
    //
    // So the saved profile is read back and compared. Only a name that
    // actually moved counts as a change worth retrying on.
    final saved = cubit.state;
    var applied = false;
    if (saved is ProfileLoaded) {
      applied = saved.user.firstName.trim().toLowerCase() == first.toLowerCase() &&
          saved.user.lastName.trim().toLowerCase() == last.toLowerCase();
    }

    // THE SESSION COPY OF THE PROFILE HAS TO LEARN THIS TOO.
    //
    // Two cubits hold a profile. ProfileCubit is what was just written;
    // AuthenticationCubit holds the SESSION copy, and that is the one the KYC
    // screen reads the name from when it starts a Prove session.
    //
    // Without this the correction saved, the screen said so, and the retry
    // sent the OLD name — failing exactly as before. And because the backend
    // reuses an in-flight session when the identity is UNCHANGED, the old name
    // matched the previous session and reused it: no new session, no cooldown
    // notice, and the same failure with nothing to explain it. The one useful
    // move would have looked like it did nothing, which is the dead end this
    // whole flow exists to remove.
    if (applied && mounted) {
      context
          .read<AuthenticationCubit>()
          .applyCorrectedName(firstName: first, lastName: last);
    }

    setState(() => _saving = false);

    if (!applied) {
      LVSnackbar.showWarning(
        title: 'Name not changed',
        message: 'Your identity is already verified, so your name can only be '
            'changed through support.',
      );
      Get.back(result: false);
      return;
    }

    Get.back(result: true);
  }
}
