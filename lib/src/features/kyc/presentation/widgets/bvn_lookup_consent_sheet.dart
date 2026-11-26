import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/utils/logger.dart';
import 'package:lazervault/src/features/kyc/data/services/bvn_lookup_http_service.dart';
import 'package:lazervault/core/widgets/app_bottom_sheet.dart';

/// What the consent sheet decided, for the screen to act on.
enum BvnConsentOutcome {
  /// The OTP was accepted and the identity is stored server-side.
  verified,

  /// The customer closed the sheet. Nothing is lost — the server session
  /// stays open, so tapping Verify again resumes without re-entering the BVN.
  dismissed,

  /// The server session timed out (it lives ~15 min in memory, and a service
  /// restart drops it). The screen must send them back to the BVN field.
  sessionExpired,

  /// Our problem, not theirs. The screen lets them through unverified rather
  /// than holding onboarding on a provider outage.
  unavailable,

  /// The identity checked out and OUR WRITE failed.
  ///
  /// Distinct from every other outcome because the OTP has already been spent
  /// correctly and the record is HELD server-side: the remedy is to repeat the
  /// same completion, which retries the write with no second Mono lookup and
  /// no second SMS. Retyping the code is the one thing that cannot help, which
  /// is why this must never be shown as a wrong-code error.
  storeRetry,

  /// The BVN belongs to another account — a decision, not a retry.
  alreadyRegistered,

  /// The code was right, but the NAME on the profile disagrees with the
  /// registry record.
  ///
  /// Not fixable inside this sheet — the number and the code were both
  /// correct, and what has to change is the customer's name. The screen owns
  /// that route (KycUpdateDetailsScreen), so the sheet closes and hands the
  /// decision back rather than showing an inline error nobody can act on.
  nameMismatch,

  /// The date of birth disagreed AND every correction attempt is spent.
  ///
  /// Separate from [dobMismatch] because the remedy is opposite: the server
  /// has dropped the held session, so there is nothing left to correct and
  /// offering the date picker again sends the customer round a loop that
  /// cannot succeed.
  dobExhausted,

  /// The date of birth on the profile disagrees with the registry record.
  ///
  /// Distinct from [nameMismatch] because the remedies are opposite: a name
  /// is editable in-app, a date of birth is NOT (no screen edits one), so
  /// this one needs a human and must not be shown the name editor.
  dobMismatch,

  /// Every delivery route Mono offered has refused, so the customer CANNOT
  /// receive a code from us at all.
  ///
  /// This is not an outage and not something they can fix: the routes come
  /// from what their bank registered against their BVN at NIBSS, and a
  /// retired SIM or an unregistered email is corrected at the bank, not here.
  /// Leaving them on a gate with no skip would make an unreachable phone
  /// number the end of their onboarding, so they get the same way through
  /// that a provider outage gets.
  undeliverable,
}

/// Mono's BVN consent steps, as ONE sheet with internal stages.
///
/// WHY ONE SHEET. The two stages — choose a delivery route, then type the
/// code — move back and forth constantly: a route Mono listed can still
/// refuse at send time, and a customer who picks email then realises they
/// cannot reach it needs to switch to SMS. As separate routes that is a
/// push/pop dance with a different back-stack shape per path, which is
/// exactly where "stuck on a screen" bugs live. As stages in one sheet, the
/// back arrow is a local state change and dismissing always returns one
/// answer to one caller.
///
/// MONO SENDS THE CODE, NOT US. We never see the address or the code — only
/// Mono's pre-masked hint — so when a route fails the ONLY remedy we can
/// offer is a different route. That is why "Use a different method" is a
/// first-class control here rather than an afterthought.
Future<BvnConsentOutcome> showBvnLookupConsentSheet({
  required BuildContext context,
  required BvnLookupHttpService service,
  required List<BvnLookupMethod> methods,
  required String firstName,
  required String lastName,
  required String dateOfBirth,
}) async {
  final result = await showAppBottomSheet<BvnConsentOutcome>(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    // Dragging down is a dismissal, which this sheet handles cleanly — the
    // server session survives, so nothing is lost.
    backgroundColor: Colors.transparent,
    builder: (_) => _BvnConsentSheet(
      service: service,
      methods: methods,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
    ),
  );
  return result ?? BvnConsentOutcome.dismissed;
}

class _BvnConsentSheet extends StatefulWidget {
  const _BvnConsentSheet({
    required this.service,
    required this.methods,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
  });

  final BvnLookupHttpService service;
  final List<BvnLookupMethod> methods;
  final String firstName;
  final String lastName;
  final String dateOfBirth;

  @override
  State<_BvnConsentSheet> createState() => _BvnConsentSheetState();
}

enum _Stage { chooseMethod, enterOtp }

class _BvnConsentSheetState extends State<_BvnConsentSheet> {
  static const Color _brandPurple = Color(0xFF4834D4);
  static const Color _danger = Color(0xFFE53935);

  _Stage _stage = _Stage.chooseMethod;
  bool _busy = false;
  String? _error;
  String? _sentVia;

  final TextEditingController _otp = TextEditingController();

  /// Routes that have already refused, so the chooser can mark them instead of
  /// inviting the customer to pick the same failing one again.
  final Set<String> _failed = <String>{};

  @override
  void initState() {
    super.initState();
    _otp.addListener(() {
      // Guarded: the sheet can be dismissed mid-edit (drag-down, or the
      // Android back button), and a setState after that throws rather than
      // doing nothing.
      if (!mounted) return;
      setState(() {
        if (_error != null) _error = null;
      });
    });
  }

  @override
  void dispose() {
    _otp.dispose();
    super.dispose();
  }

  bool get _otpValid => _otp.text.trim().length >= 4;

  Future<void> _send(BvnLookupMethod m) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    final res = await widget.service.sendOtp(m.method);
    if (!mounted) return;

    if (res.sessionExpired) {
      Navigator.of(context).pop(BvnConsentOutcome.sessionExpired);
      return;
    }
    if (!res.ok) {
      // NOT terminal. The session is still open server-side, so the customer
      // picks another route — the only remedy available to us.
      AppLogger.event('kyc_bvn_lookup', 'otp_send_failed',
          level: 'warn', screen: 'bvn_signup');
      setState(() {
        _busy = false;
        _failed.add(m.method);
        final allGone = _failed.length >= widget.methods.length;
        _error = allGone
            // Do not tell someone to "try another option" when there is none
            // left — that is the sentence that makes a screen feel broken.
            // NO LONGER OFFERS "continue for now": that escape hatch was
            // removed when the dashboard became Tier-2-gated, and copy that
            // points at a button which is not there is worse than no copy.
            // The real alternative is the full check, and the sheet shows
            // its button directly beneath this.
            ? 'None of the contact details your bank holds for this BVN could '
                'receive a code. Ask your bank to update them, or use the '
                'full verification below — it checks you with a liveness '
                'check instead of a code.'
            : (res.message.isNotEmpty
                ? res.message
                : 'We couldn\'t send your code that way. Try another option.');
      });
      return;
    }
    AppLogger.event('kyc_bvn_lookup', 'otp_sent', screen: 'bvn_signup');
    setState(() {
      _busy = false;
      _stage = _Stage.enterOtp;
      _sentVia = m.hint.isNotEmpty ? m.hint : 'your ${m.label.toLowerCase()}';
      _otp.clear();
    });
  }

  Future<void> _complete() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    final res = await widget.service.complete(
      otp: _otp.text.trim(),
      firstName: widget.firstName,
      lastName: widget.lastName,
      dateOfBirth: widget.dateOfBirth,
    );
    if (!mounted) return;

    if (res.ok) {
      Navigator.of(context).pop(BvnConsentOutcome.verified);
      return;
    }
    if (res.sessionExpired) {
      Navigator.of(context).pop(BvnConsentOutcome.sessionExpired);
      return;
    }
    if (res.infrastructure) {
      Navigator.of(context).pop(BvnConsentOutcome.unavailable);
      return;
    }
    // A NAME OR DATE-OF-BIRTH REFUSAL IS NOT A WRONG CODE.
    //
    // Both arrive here, and only one of them can be acted on in this sheet.
    // Retyping the code cannot fix a name that disagrees with the registry,
    // so leaving it as an inline error strands the customer at the last step
    // of a flow they completed correctly. The screen has the routes — the
    // name editor, and support for a date of birth nobody can edit — so hand
    // it back.
    final code = res.code.trim().toUpperCase();
    if (code == 'IDENTITY_DETAILS_MISMATCH') {
      Navigator.of(context).pop(BvnConsentOutcome.nameMismatch);
      return;
    }
    if (code == 'IDENTITY_DOB_EXHAUSTED') {
      Navigator.of(context).pop(BvnConsentOutcome.dobExhausted);
      return;
    }
    if (code == 'IDENTITY_DOB_MISMATCH') {
      Navigator.of(context).pop(BvnConsentOutcome.dobMismatch);
      return;
    }
    if (code.endsWith('ALREADY_REGISTERED')) {
      Navigator.of(context).pop(BvnConsentOutcome.alreadyRegistered);
      return;
    }
    // THE CHECK PASSED AND OUR WRITE FAILED. NOT A WRONG CODE.
    //
    // The server holds the fetched record and asks for the SAME call again to
    // retry the write — no second Mono lookup, no second SMS. But its sentence
    // was landing in the red box under the OTP field, which reads as "your
    // code is wrong", and the customer's next tap then hit the held-record
    // branch: with no date of birth on the profile that answers INVALID_DOB
    // ("Enter your date of birth") into a sheet with no date field, and with
    // one it burns a DOB attempt per tap until the session is thrown away for
    // a date that was never the problem.
    //
    // The OTP has ALREADY been spent correctly, so retyping it is the one
    // thing that cannot help. Hand it back to the screen, which owns the
    // retry.
    if (code == 'IDENTITY_STORE_RETRY') {
      Navigator.of(context).pop(BvnConsentOutcome.storeRetry);
      return;
    }
    // OUR OUTAGE, NOT THEIR TYPO. The ownership pre-check could not read the
    // database. Telling someone to check an eleven-digit number they typed
    // correctly is the wrong instruction, and it is not in the infrastructure
    // set the screen already routes on.
    if (code == 'IDENTITY_CHECK_UNAVAILABLE') {
      Navigator.of(context).pop(BvnConsentOutcome.unavailable);
      return;
    }
    // A wrong code is the one thing that IS fixable here.
    setState(() {
      _busy = false;
      _error = res.message.isNotEmpty
          ? res.message
          : 'That code didn\'t match. Check it and try again.';
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      // Lifts the sheet above the keyboard on the OTP stage; without it the
      // field sits under the keyboard on short devices.
      padding: EdgeInsets.only(bottom: bottom),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
        child: SafeArea(
          top: false,
          // SCROLLABLE, because this sheet grows and the space shrinks at the
          // same time. The chooser is as long as the number of routes Mono
          // returns — not a fixed three — and the OTP stage is drawn with the
          // keyboard up, which can leave under half the screen. A Column that
          // cannot scroll answers that with a RenderFlex overflow: a striped
          // bar across the sheet, on the screen where we are asking for
          // somebody's BVN.
          //
          // mainAxisSize.min is kept so the sheet still hugs its content and
          // does not open full-height when there is little to show.
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                if (_stage == _Stage.chooseMethod)
                  ..._chooseMethod()
                else
                  ..._enterOtp(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// The delivery routes, SMS FIRST.
  ///
  /// Mono returns them in its own order — email, phone, alternate_phone — and
  /// rendering that order put email at the top. For a BVN that is the wrong
  /// default twice over:
  ///
  ///   * The address NIBSS holds is whatever was given when the account was
  ///     opened, often years ago and often not the one on this phone. The
  ///     measured case: this customer's BVN record carries the email of a
  ///     DIFFERENT account of theirs, so the top option delivered a code to an
  ///     inbox they were not looking at.
  ///   * The phone is the one contact detail a bank keeps current, because it
  ///     is what they use for transaction alerts — and the code arrives on the
  ///     device already in the customer's hand.
  ///
  /// Unknown methods keep their server order at the end rather than being
  /// dropped: a route we do not recognise is still a route the customer has.
  static const _methodPriority = <String>['phone', 'email', 'alternate_phone'];

  List<BvnLookupMethod> _orderedMethods() {
    final ranked = [...widget.methods];
    ranked.sort((a, b) {
      final ia = _methodPriority.indexOf(a.method);
      final ib = _methodPriority.indexOf(b.method);
      // -1 (unrecognised) sorts last, and ties keep their relative order
      // because List.sort is stable for equal keys here.
      final ra = ia < 0 ? _methodPriority.length : ia;
      final rb = ib < 0 ? _methodPriority.length : ib;
      return ra.compareTo(rb);
    });
    return ranked;
  }

  List<Widget> _chooseMethod() => [
        Text(
          'How should we send your code?',
          style: GoogleFonts.inter(
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black87),
        ),
        SizedBox(height: 8.h),
        Text(
          'Your bank sends a one-time code to the contact details registered '
          'against your BVN. We never see them.',
          style: GoogleFonts.inter(
              fontSize: 13.sp, height: 1.5, color: Colors.black54),
        ),
        SizedBox(height: 16.h),
        for (final m in _orderedMethods()) ...[
          _methodTile(m),
          SizedBox(height: 10.h),
        ],
        if (_error != null) ...[
          SizedBox(height: 2.h),
          _errorNotice(_error!, nextUp: _nextUntried),
        ],
        SizedBox(height: 6.h),
        // THE WAY OUT, SHOWN ONLY ONCE IT IS EARNED.
        //
        // Offered after a route has actually refused — not before, or it
        // reads as an invitation to skip verification. By that point the
        // customer has evidence we cannot reach them, and the alternative is
        // a gate with no skip and an inline error: onboarding ended by a
        // phone number their bank holds and they may no longer own.
        if (_failed.isNotEmpty) ...[
          SizedBox(
            width: double.infinity,
            height: 46.h,
            child: OutlinedButton(
              onPressed: _busy
                  ? null
                  : () => Navigator.of(context)
                      .pop(BvnConsentOutcome.undeliverable),
              style: OutlinedButton.styleFrom(
                foregroundColor: _brandPurple,
                side: BorderSide(color: _brandPurple.withValues(alpha: 0.5)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r)),
              ),
              // NOT "continue without verifying". Tier 2 is what mints the
              // account number, so skipping leaves a wallet that cannot
              // receive money and no explanation. The real alternative is the
              // full check, which uses a liveness check rather than the
              // contact details their bank holds.
              child: Text('Use full verification instead',
                  style: GoogleFonts.inter(
                      fontSize: 13.5.sp, fontWeight: FontWeight.w700)),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'It verifies you with a quick liveness check instead of a code, '
            'so it works even when your bank\'s contact details are out of date.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                fontSize: 11.5.sp, height: 1.4, color: Colors.black54),
          ),
          SizedBox(height: 6.h),
        ],
        Center(
          child: TextButton(
            onPressed: _busy
                ? null
                : () => Navigator.of(context).pop(BvnConsentOutcome.dismissed),
            style: TextButton.styleFrom(foregroundColor: Colors.black54),
            child: Text('Not now',
                style: GoogleFonts.inter(
                    fontSize: 13.5.sp, fontWeight: FontWeight.w600)),
          ),
        ),
      ];

  Widget _methodTile(BvnLookupMethod m) {
    final failed = _failed.contains(m.method);
    return Opacity(
      // Dimmed, not removed: a route can fail transiently, and deleting the
      // only option a customer has would leave an empty chooser.
      opacity: failed ? 0.55 : 1,
      child: Material(
        color: const Color(0xFFF6F5FB),
        borderRadius: BorderRadius.circular(14.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(14.r),
          onTap: _busy ? null : () => _send(m),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
            child: Row(
              children: [
                Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: BoxDecoration(
                    color: _brandPurple.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    _iconFor(m.method),
                    color: _brandPurple,
                    size: 19.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(m.label,
                          style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87)),
                      if (m.hint.isNotEmpty) ...[
                        SizedBox(height: 2.h),
                        Text(
                          m.hint,
                          style: GoogleFonts.inter(
                              fontSize: 11.5.sp,
                              height: 1.35,
                              color: Colors.black54),
                        ),
                      ],
                      if (failed) ...[
                        SizedBox(height: 3.h),
                        Text('Didn\'t work — try another',
                            style: GoogleFonts.inter(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: _danger)),
                      ],
                    ],
                  ),
                ),
                if (_busy)
                  SizedBox(
                      width: 18.w,
                      height: 18.w,
                      child: const LazerVaultLoader.tiny())
                else
                  Icon(Icons.chevron_right_rounded,
                      color: Colors.black38, size: 20.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _enterOtp() => [
        Row(
          children: [
            // Back to the chooser is a STATE change, not a pop — so it can
            // never unwind the caller's navigation by accident.
            IconButton(
              onPressed: _busy
                  ? null
                  : () => setState(() {
                        _stage = _Stage.chooseMethod;
                        _error = null;
                      }),
              icon: Icon(Icons.arrow_back_rounded,
                  size: 20.sp, color: Colors.black54),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text('Enter your code',
                  style: GoogleFonts.inter(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87)),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          _sentVia == null ? 'Enter the code your bank sent you.' : _sentVia!,
          style: GoogleFonts.inter(
              fontSize: 13.sp, height: 1.5, color: Colors.black54),
        ),
        SizedBox(height: 16.h),
        TextField(
          controller: _otp,
          autofocus: true,
          enabled: !_busy,
          keyboardType: TextInputType.number,
          // Mono has not documented a fixed OTP length, so this does NOT cap
          // at 6 — a 4- or 8-digit code must still be typeable.
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          style: GoogleFonts.inter(
              fontSize: 20.sp, fontWeight: FontWeight.w700, letterSpacing: 6),
          decoration: InputDecoration(
            hintText: '______',
            hintStyle: GoogleFonts.inter(
                fontSize: 20.sp, letterSpacing: 6, color: Colors.black26),
            filled: true,
            fillColor: const Color(0xFFF6F5FB),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                  color: _error != null ? _danger : _brandPurple, width: 1.4),
            ),
          ),
        ),
        if (_error != null) ...[
          SizedBox(height: 8.h),
          _errorLine(_error!),
        ],
        SizedBox(height: 16.h),
        SizedBox(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton(
            onPressed: (_busy || !_otpValid) ? null : _complete,
            style: ElevatedButton.styleFrom(
              backgroundColor: _brandPurple,
              foregroundColor: Colors.white,
              elevation: 0,
              disabledBackgroundColor: _brandPurple.withValues(alpha: 0.4),
              disabledForegroundColor: Colors.white70,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r)),
            ),
            child: _busy
                ? const Center(child: LazerVaultLoader.small())
                : Text('Verify',
                    style: GoogleFonts.inter(
                        fontSize: 15.sp, fontWeight: FontWeight.w700)),
          ),
        ),
        SizedBox(height: 4.h),
        Center(
          child: TextButton(
            onPressed: _busy
                ? null
                : () => setState(() {
                      _stage = _Stage.chooseMethod;
                      _error = null;
                    }),
            style: TextButton.styleFrom(foregroundColor: _brandPurple),
            child: Text('Use a different method',
                style: GoogleFonts.inter(
                    fontSize: 13.5.sp, fontWeight: FontWeight.w700)),
          ),
        ),
      ];

  /// ONE icon rule for a delivery route, shared by the list tile and the
  /// retry button in [_errorNotice] so the two can never show a different
  /// symbol for the same route.
  static IconData _iconFor(String method) => method == 'email'
      ? Icons.alternate_email_rounded
      : Icons.sms_outlined;

  /// A plain refusal line, for the CODE-ENTRY stage.
  ///
  /// Kept deliberately quiet there. A rejected code is the customer's next
  /// keystroke to fix — it sits directly under the field they are already
  /// looking at, and a banner with a heading would be louder than the mistake.
  /// The chooser's failures are different in kind: nothing the customer typed
  /// was wrong, and the next move is somewhere else on the sheet, so those
  /// get [_errorNotice].
  Widget _errorLine(String msg) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline_rounded, size: 15.sp, color: _danger),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(msg,
                style: GoogleFonts.inter(
                    fontSize: 12.sp, height: 1.4, color: _danger)),
          ),
        ],
      );

  /// A refusal the customer can act on, not a red sentence under a list.
  ///
  /// The bare line it replaces sat between the options and the buttons at
  /// 12sp, the same weight as the hint text above it, and said "Try another
  /// option" without saying WHICH — so the one piece of information the
  /// customer needed next (where to tap now) was the one thing missing. On a
  /// screen where a route has just failed, that reads as the app being broken
  /// rather than as a step with a next move.
  ///
  /// So it is a banner: tinted ground, a heading that names what happened, and
  /// the next untried route named explicitly. [nextUp] is null when every
  /// route has been tried, and the body then stops promising another one.
  Widget _errorNotice(String msg, {BvnLookupMethod? nextUp}) => Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(12.w, 11.h, 12.w, 11.h),
        decoration: BoxDecoration(
          color: _danger.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: _danger.withValues(alpha: 0.28)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.sms_failed_outlined, size: 17.sp, color: _danger),
            SizedBox(width: 9.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nextUp != null
                        ? 'That code didn\'t go through'
                        : 'We\'ve tried every option',
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      // Darkened from _danger: 13sp bold on a 7%-tinted
                      // ground needs the contrast, and a heading in the same
                      // red as the body reads as one block of alarm.
                      color: const Color(0xFFB3261E),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    msg,
                    style: GoogleFonts.inter(
                        fontSize: 12.sp, height: 1.45, color: Colors.black87),
                  ),
                  if (nextUp != null) ...[
                    SizedBox(height: 9.h),
                    // NAMES THE NEXT TAP. The whole point of the banner.
                    SizedBox(
                      height: 38.h,
                      child: ElevatedButton.icon(
                        onPressed: _busy ? null : () => _send(nextUp),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _brandPurple,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r)),
                        ),
                        icon: Icon(_iconFor(nextUp.method), size: 15.sp),
                        label: Text(
                          'Send to my ${nextUp.label.toLowerCase()} instead',
                          style: GoogleFonts.inter(
                              fontSize: 12.5.sp, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      );

  /// The first route the customer has NOT already tried, in display order, so
  /// the banner's button and the list agree on what "another option" means.
  BvnLookupMethod? get _nextUntried {
    for (final m in _orderedMethods()) {
      if (!_failed.contains(m.method)) return m;
    }
    return null;
  }
}
