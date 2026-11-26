import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/config/feature_flags.dart';

/// Guidance shown on SMS OTP screens once the first resend cooldown has
/// elapsed and the customer still has no code.
///
/// WHY THIS EXISTS. Nigerian subscribers can place their line on the NCC
/// "Do Not Disturb" register, which blocks SMS delivered over promotional
/// routes. Our OTPs request the corporate/OTP route, but a provider may
/// silently downgrade that route when the sender ID is not registered for it —
/// and on a downgraded route a DND line receives NOTHING while the provider
/// reports the message as delivered. Confirmed live on 2026-11-13:
/// BulkSMSNigeria returned `requested_gateway=otp, gateway_used=direct-refund`
/// with `status=success`.
///
/// So "no code arrived" has a cause the customer can actually fix, and nothing
/// in the app ever told them. This does.
///
/// TIMING IS DELIBERATE. It renders only AFTER the first countdown, never
/// before: a code that is simply still in flight must not be met with
/// troubleshooting advice, which reads as the app blaming the user for its own
/// latency.
///
/// SMS ONLY. Never mount this on an email verification screen — DND has
/// nothing to do with email, and the advice would be nonsense there.
///
/// The short code and keyword are set by the networks/NCC, not by us, so they
/// are operator-tunable (see FeatureFlags.smsDndHelpCode / ...Keyword). A wrong
/// value baked into a shipped binary would be unfixable for weeks.
class SmsDndNotice extends StatefulWidget {
  /// Pass true on dark surfaces (e.g. the phone_passcode dark scaffold).
  final bool dark;

  /// How many resend cooldowns the customer has already waited out on this
  /// screen. Compared against sms_dnd_help_after_attempts, so an operator
  /// decides whether the notice appears after the first code or the third.
  ///
  /// A screen with NO cooldown of its own (two-factor setup) uses
  /// [revealAfter] instead and can only ever report one elapsed wait, so a
  /// threshold above 1 keeps the notice hidden there. That is deliberate:
  /// better absent than shown at a moment nobody chose.
  final int cooldownsElapsed;

  /// Self-time the reveal instead of being gated by the caller.
  ///
  /// Most screens drive a resend cooldown and simply mount this when it
  /// elapses, so they leave this null. It exists for screens whose Resend is
  /// live immediately and have NO countdown of their own (two-factor setup):
  /// there, rendering at once would put troubleshooting advice on screen
  /// before the code could plausibly have arrived.
  final Duration? revealAfter;

  const SmsDndNotice({
    super.key,
    this.dark = false,
    this.revealAfter,
    this.cooldownsElapsed = 1,
  });

  static const Color _accent = Color(0xFF4834D4);

  @override
  State<SmsDndNotice> createState() => _SmsDndNoticeState();
}

class _SmsDndNoticeState extends State<SmsDndNotice> {
  Timer? _reveal;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    final after = widget.revealAfter;
    if (after == null) {
      _visible = true;
    } else {
      _reveal = Timer(after, () {
        if (mounted) setState(() => _visible = true);
      });
    }
  }

  @override
  void dispose() {
    _reveal?.cancel();
    super.dispose();
  }

  bool get dark => widget.dark;

  @override
  Widget build(BuildContext context) {
    if (!_visible) return const SizedBox.shrink();

    // RESPECT THE MASTER SWITCH, with no release required.
    //
    // sms_provider_active / sms_otp_enabled are written from the admin
    // dashboard, persisted through EndpointRegistry and read here. When an
    // operator turns SMS off, OTP flows stop using SMS — and advice about
    // unblocking SMS on the handset becomes actively misleading, because no
    // SMS is being attempted at all. So this notice follows the same switch
    // the flow does rather than having an opinion of its own.
    if (!FeatureFlags.smsOtpEnabled) return const SizedBox.shrink();

    // APPROVAL RETIRES THIS NOTICE. The corporate/OTP route is DND-exempt, so
    // once our sender is approved for it a verification code reaches a
    // DND-registered line unaided — and telling the customer to unblock SMS
    // would be asking them to weaken their spam protection for nothing.
    if (FeatureFlags.smsOtpRouteApproved) return const SizedBox.shrink();
    if (!FeatureFlags.smsDndHelpEnabled) return const SizedBox.shrink();

    // 0 disables the notice outright — a second way to switch it off, so an
    // operator who reaches for the threshold rather than the flag still gets
    // the result they meant.
    final threshold = FeatureFlags.smsDndHelpAfterAttempts;
    if (threshold <= 0) return const SizedBox.shrink();
    final elapsed = widget.revealAfter != null ? 1 : widget.cooldownsElapsed;
    if (elapsed < threshold) return const SizedBox.shrink();

    // EVERY string here comes from admin settings. Nothing user-facing in this
    // widget is decided by the app — see FeatureFlags.smsDndHelp* for why.
    final title = FeatureFlags.smsDndHelpTitle;
    final body = FeatureFlags.smsDndHelpMessage.isNotEmpty
        ? FeatureFlags.smsDndHelpMessage
        : "Your SIM may be on your network's Do Not Disturb (DND) list, which "
            "blocks verification texts from reaching you.";
    final distinction = FeatureFlags.smsDndHelpDistinction;
    final action = FeatureFlags.smsDndHelpAction;

    // Tinted surface rather than a warning colour: this is guidance, not an
    // error, and a red panel after a slow SMS reads as a failure the customer
    // caused.
    final bg = dark
        ? Colors.white.withValues(alpha: 0.08)
        : SmsDndNotice._accent.withValues(alpha: 0.06);
    final border = dark
        ? Colors.white.withValues(alpha: 0.18)
        : SmsDndNotice._accent.withValues(alpha: 0.22);
    final titleColor = dark ? Colors.white : const Color(0xFF1F2937);
    final bodyColor =
        dark ? Colors.white.withValues(alpha: 0.78) : const Color(0xFF4B5563);

    // HEIGHT IS CAPPED, AND THE CAP IS LOAD-BEARING.
    //
    // Every string here is operator-editable up to 400 characters, and three
    // of the five screens that mount this notice (phone_otp,
    // forgot_passcode_phone, login_otp) have NO scrollable ancestor — their
    // content sits in a plain Column. So long copy does not merely look bad,
    // it throws a RenderFlex overflow and paints the yellow-and-black stripes
    // over a live auth screen. Caught by test when the action copy grew to
    // three lines: 180px over, on a 390x844 frame with nothing else on screen.
    //
    // Constraining here rather than asking each screen to scroll keeps the
    // guarantee with the thing that can grow. In the normal case the content
    // is well under the cap and this is invisible; past it the panel scrolls
    // internally instead of breaking the page.
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      constraints: BoxConstraints(maxHeight: 220.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: border),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.do_not_disturb_on_outlined,
                  size: 18.sp,
                  color: dark ? Colors.white : SmsDndNotice._accent,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: titleColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Text(
              body,
              style: TextStyle(
                fontSize: 12.5.sp,
                height: 1.45,
                color: bodyColor,
              ),
            ),
            if (distinction.isNotEmpty) ...[
              SizedBox(height: 6.h),
              // Set apart with its own rule so the "not your phone" point reads
              // as a correction, which is what it is — this is the sentence that
              // stops a customer searching their device settings.
              Container(
                padding: EdgeInsets.only(left: 8.w),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: dark
                          ? Colors.white.withValues(alpha: 0.35)
                          : SmsDndNotice._accent.withValues(alpha: 0.45),
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  distinction,
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                    color: bodyColor,
                  ),
                ),
              ),
            ],
            if (action.isNotEmpty) ...[
              SizedBox(height: 8.h),
              Text(
                action,
                style: TextStyle(
                  fontSize: 12.5.sp,
                  height: 1.45,
                  color: bodyColor,
                ),
              ),
            ],
            SizedBox(height: 10.h),
            _DndActionButton(
              // The URI needs the raw values; the LABEL is operator copy.
              keyword: FeatureFlags.smsDndHelpKeyword,
              code: FeatureFlags.smsDndHelpCode,
              label: FeatureFlags.smsDndHelpCta,
              dark: dark,
            ),
          ],
        ),
      ),
    );
  }
}

/// Opens the handset's SMS composer pre-filled with the DND keyword.
///
/// Stateful only so a launch failure can be reported in place: on a device with
/// no SMS app (a tablet, an emulator) `launchUrl` returns false, and silently
/// doing nothing would read as a dead button.
class _DndActionButton extends StatefulWidget {
  final String keyword;
  final String code;

  /// Operator-supplied button copy, already placeholder-substituted.
  final String label;
  final bool dark;

  const _DndActionButton({
    required this.keyword,
    required this.code,
    required this.label,
    required this.dark,
  });

  @override
  State<_DndActionButton> createState() => _DndActionButtonState();
}

class _DndActionButtonState extends State<_DndActionButton> {
  bool _failed = false;

  Future<void> _open() async {
    // Body goes in the query so the composer opens with the keyword already
    // typed; the customer only has to hit send.
    final uri = Uri.parse(
        'sms:${widget.code}?body=${Uri.encodeComponent(widget.keyword)}');
    var ok = false;
    try {
      ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      ok = false;
    }
    if (!mounted) return;
    setState(() => _failed = !ok);
  }

  @override
  Widget build(BuildContext context) {
    final accent = widget.dark ? Colors.white : SmsDndNotice._accent;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: _open,
          borderRadius: BorderRadius.circular(8.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.sms_outlined, size: 15.sp, color: accent),
                SizedBox(width: 6.w),
                Flexible(
                  child: Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: accent,
                      decoration: TextDecoration.underline,
                      decorationColor: accent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_failed)
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Text(
              'Couldn\'t open your messaging app — send ${widget.keyword} to ${widget.code} manually.',
              style: TextStyle(
                fontSize: 11.5.sp,
                color: widget.dark
                    ? Colors.white.withValues(alpha: 0.7)
                    : const Color(0xFF6B7280),
              ),
            ),
          ),
      ],
    );
  }
}
