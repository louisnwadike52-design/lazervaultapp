import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lazervault/core/shared_widgets/otp_field_behaviour.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sms_autofill/sms_autofill.dart';

/// A standard 6-digit verification code input widget with individual boxes
/// and SMS autofill support.
///
/// Features:
/// - 6 individual styled boxes for each digit
/// - Auto-focus and auto-advance between boxes
/// - SMS autofill support (auto-reads OTP from SMS) when [enableSmsAutofill]
/// - Backspace handling
/// - Theme-based styling
///
/// ## Resetting it
///
/// There is no imperative `clear()`. Give it a `ValueKey` you bump — every
/// OTP screen in this app does — and it comes back empty and focused. That is
/// not cosmetic: the field auto-submits on the sixth digit, and once six
/// digits are in, `maxLength` discards further keypresses and the decoration
/// stops painting a caret. A rejected code left in place therefore reads as a
/// dead screen — keypad responding, no digit appearing, no cursor — which is
/// exactly how it was reported from the field.
class VerificationCodeInput extends StatefulWidget {
  /// Callback when the complete 6-digit code is entered
  final ValueChanged<String>? onCompleted;

  /// Callback when the code changes
  final ValueChanged<String>? onChanged;

  /// Initial code value
  final String? initialValue;

  /// Whether to enable SMS autofill (default: true).
  ///
  /// Pass FALSE on any screen whose code does not arrive by SMS — an email
  /// OTP, for instance. On Android this starts the SMS retriever, and
  /// subscribing a screen to a channel that can never deliver to it is at
  /// best waste and at worst a foreign code arriving in the field.
  final bool enableSmsAutofill;

  const VerificationCodeInput({
    super.key,
    this.onCompleted,
    this.onChanged,
    this.initialValue,
    this.enableSmsAutofill = true,
  });

  @override
  State<VerificationCodeInput> createState() => _VerificationCodeInputState();
}

/// ONE SMS LISTENER, ONE FIELD, AND ONE SOURCE OF TRUTH FOR THE TEXT.
///
/// The history here is two attempts at the same problem, and both failed the
/// same way — by letting the autofill mechanism sit in the path between a
/// keypress and the text.
///
/// FIRST, this mixed `CodeAutoFill` with `PinFieldAutoFill`, which already
/// subscribes internally: two subscriptions to one singleton stream, and a
/// `codeUpdated` that fed received codes back in through `currentCode`, so any
/// SMS carrying four to six digits could replace what the user was typing.
///
/// THEN that was "fixed" by handing everything to `PinFieldAutoFill` — which
/// moved the problem rather than removing it. That widget is a CONTROLLED
/// component: it keeps its own `code`, reconciles against `currentCode` in
/// didUpdateWidget, and assigns `TextEditingValue(text: code)` with no
/// selection. It also tags the field `AutofillHints.oneTimeCode`, handing it to
/// the Android autofill framework, and starts the SMS Retriever — none of
/// which happens on iOS, because `listenForCode()` returns early there. So the
/// SMS screens ran an input path the email screens never touched, on one
/// platform only. A customer on Android could not enter a code he had received
/// (2026-11-18: four attempts, no verify call ever reached the server).
///
/// NOW the two concerns are separate, which is what neither attempt did:
///
///   * the FIELD is `PinInputTextField` — uncontrolled, identical on both
///     platforms, the same widget the email screens have always used. The
///     controller is the only source of truth and nothing reconciles against
///     it.
///   * the LISTENER is the `CodeAutoFill` mixin here, subscribed once, and it
///     may only ever fill an EMPTY field.
///
/// Autofill is additive. If it never fires, the customer types their code.
class _VerificationCodeInputState extends State<VerificationCodeInput>
    with CodeAutoFill {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final seed = widget.initialValue ?? '';
    _controller = TextEditingController(
      text: seed.length <= 6 ? seed : seed.substring(0, 6),
    );
    // Listening is a no-op off Android (CodeAutoFill.listenForCode returns
    // early), so no platform check is needed here — and the field below is the
    // same on both platforms either way.
    if (_autofillWanted) {
      listenForCode();
    }
  }

  /// Whether this mount should listen for an incoming SMS.
  ///
  /// The SCREEN decides first: an email-code screen passes false because any
  /// SMS carrying four to six digits — a bank alert, a delivery notice — would
  /// otherwise match the retriever's default pattern. The operator flag can
  /// only ever turn listening further OFF; it can never give a listener to a
  /// screen that said no.
  bool get _autofillWanted =>
      widget.enableSmsAutofill && endpointRegistry.otpSmsAutofillEnabled;

  /// An SMS arrived and the retriever extracted a code.
  ///
  /// FILLS ONLY AN EMPTY FIELD. If the customer has started typing, their
  /// digits win: the code is on their screen either way, and overwriting what
  /// somebody is part-way through entering is the behaviour this widget's
  /// history is littered with. It is also why the old wrapper was removed —
  /// it fed received codes back in through `currentCode` and replaced live
  /// input.
  @override
  void codeUpdated() {
    final incoming = (code ?? '').trim();
    if (incoming.isEmpty || !mounted) return;
    if (_controller.text.isNotEmpty) return;

    final clipped = incoming.length <= 6 ? incoming : incoming.substring(0, 6);
    // Selection set EXPLICITLY. `TextEditingValue(text:)` alone leaves
    // selection at the invalid default (offset -1), which is what the package
    // does internally — on Android that is a caret the input connection cannot
    // place, and the next keypress has nowhere to go.
    _controller.value = TextEditingValue(
      text: clipped,
      selection: TextSelection.collapsed(offset: clipped.length),
    );
    _handleChanged(clipped);
  }

  @override
  void dispose() {
    // Both halves: cancel() drops our stream subscription, unregisterListener()
    // tells the platform to stop the retriever. Leaving either behind leaks a
    // listener per OTP screen visit.
    unawaited(cancel());
    if (_autofillWanted) {
      unawaited(unregisterListener());
    }
    _controller.dispose();
    super.dispose();
  }

  // ONE FIELD, BOTH PLATFORMS.
  //
  // This used to swap between PinInputTextField and PinFieldAutoFill depending
  // on whether the screen wanted SMS autofill — which meant the SMS screens ran
  // an input path that the email screens never touched, and that path exists
  // only on Android.
  //
  // PinFieldAutoFill is PinInputTextField plus two things: an SMS listener, and
  // an `AutofillHints.oneTimeCode` tag that hands the field to the Android
  // autofill framework. It is also a CONTROLLED component — it keeps its own
  // `code` and reconciles against `currentCode` in didUpdateWidget, calling
  // `controller.value = TextEditingValue(text: code)` with no selection. Every
  // OTP screen here reports each keystroke up to a cubit, which emits, which
  // rebuilds, so that reconciliation ran on every digit.
  //
  // On 2026-11-18 a customer on Android received his code and could not enter
  // it — four login attempts over forty minutes with NO verify call reaching
  // the server, so the digits never left the device. Every screen on the
  // autofill branch is an SMS screen; the two email screens, on the plain
  // branch, were never reported.
  //
  // So the listener is now separated from the field. The field is the one the
  // email screens have always used, identical on iOS and Android, uncontrolled
  // — the controller is the single source of truth and nothing reconciles
  // against it. Autofill survives as the CodeAutoFill mixin above, which can
  // only ever fill an empty field. It is additive; it is no longer in the path
  // between a keypress and the text.
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      // AN AutofillGroup IS REQUIRED, not decorative.
      //
      // Flutter only hands a field's `autofillHints` to the platform when an
      // AutofillGroup is an ancestor. Without one the hint is inert, which is
      // why tagging the field alone would have looked done and changed
      // nothing.
      child: AutofillGroup(
        child: PinInputTextField(
          controller: _controller,
          pinLength: 6,
          autoFocus: true,
          decoration: _decoration(primaryColor),
          keyboardType: const TextInputType.numberWithOptions(),
          // THE ONLY AUTOFILL PATH THAT EXISTS ON iOS.
          //
          // `CodeAutoFill` above is the Android SMS Retriever and returns
          // early on iOS, so before this there was no autofill on iPhone at
          // all: no "From Messages" suggestion over the keyboard, nothing.
          // This hint is what produces it, and on Android it additionally
          // offers the field to the autofill framework.
          //
          // It is SAFE in a way `PinFieldAutoFill` was not. That widget was a
          // CONTROLLED component reconciling its own `code` against a prop on
          // every rebuild, which is what broke typing on Android in November.
          // This is a hint on the underlying TextField and nothing more — it
          // adds no state, reconciles nothing, and cannot sit between a
          // keypress and the text.
          autofillHints: otpAutofillHints,
          // PASTE. Both of these are needed and neither was set.
          //
          // The package defaults `enableInteractiveSelection` to false, so a
          // long press did nothing — no handles, no menu, no way to paste a
          // code the customer had copied out of their messages. And
          // `contextMenuBuilder` is forwarded VERBATIM to the TextField, so
          // leaving it null means an explicit null there: no menu even once
          // selection is enabled. Supplying the adaptive toolbar gives the
          // platform's own Paste item.
          enableInteractiveSelection: true,
          contextMenuBuilder: otpContextMenu,
          // AND THE PASTE HAS TO SURVIVE BEING PASTED.
          //
          // People paste what they copied, which is usually more than the
          // code — "Your Lazervault code is 123456". The field applies no
          // formatters of its own, so without this that whole string is
          // accepted and then truncated by maxLength to its first six
          // CHARACTERS: "Your c". Filtering to digits first turns the same
          // paste into 123456, because Flutter runs these before the
          // maxLength limiter it appends after them.
          inputFormatters: otpInputFormatters(6),
          onChanged: _handleChanged,
          onSubmit: _handleSubmitted,
        ),
      ),
    );
  }

  void _handleChanged(String? code) {
    final value = code ?? '';
    widget.onChanged?.call(value);
    if (value.length == 6) {
      widget.onCompleted?.call(value);
    }
  }

  void _handleSubmitted(String code) {
    if (code.length == 6) {
      widget.onCompleted?.call(code);
    }
  }

  PinDecoration _decoration(Color primaryColor) => BoxLooseDecoration(
        strokeColorBuilder: FixedColorBuilder(
          primaryColor.withValues(alpha: 0.3),
        ),
        bgColorBuilder: FixedColorBuilder(Colors.white),
        textStyle: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        gapSpace: 8.w,
        radius: Radius.circular(12.r),
        strokeWidth: 2,
      );
}
