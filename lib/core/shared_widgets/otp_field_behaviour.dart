/// WHAT AN OTP FIELD HAS TO DO, IN ONE PLACE.
///
/// There are six code-entry screens in this app and, before this, six
/// different answers to "can I paste, and will the OS fill it for me". Four
/// of them could do neither. The three things below are what make a code
/// field work, and they are collected here because the mistake is never
/// "somebody wrote this wrong" — it is "somebody wrote a new code screen and
/// did not know these were needed".
///
/// ## 1. Autofill needs the hint AND an AutofillGroup
///
/// [otpAutofillHints] tags the field as a one-time code. On iOS that tag is
/// the ONLY mechanism for the "From Messages" suggestion above the keyboard —
/// the Android SMS Retriever used elsewhere in this app does not run on iOS at
/// all. On Android it additionally offers the field to the autofill framework.
///
/// Flutter only forwards the hint to the platform when an [AutofillGroup] is
/// an ANCESTOR. A field tagged without one looks correct and does nothing,
/// which is the failure mode to watch for.
///
/// ## 2. Paste needs interactive selection AND a context menu
///
/// Both of the pin packages in use default `enableInteractiveSelection` to
/// false — so a long press produces no handles and no menu — and forward
/// `contextMenuBuilder` verbatim, so leaving it null passes an explicit null
/// to the TextField and there is no menu even once selection is on. Paste is
/// not merely awkward in that state, it is unreachable.
///
/// ## 3. A pasted code is rarely just the code
///
/// People paste what they copied: "Your Lazervault code is 123456". The pin
/// fields apply no formatters of their own, so that whole string is accepted
/// and then cut by `maxLength` to its first six CHARACTERS — "Your c". Running
/// [otpInputFormatters] first reduces the same paste to 123456, because
/// Flutter applies these before the length limiter it appends after them.
///
/// ## What is deliberately NOT here
///
/// Nothing in this file holds state, and nothing reconciles a controller
/// against a widget property. In November a controlled pin component did
/// exactly that on every rebuild and a customer on Android could not type the
/// code he had been sent — four attempts, no verify call ever reaching the
/// server. These are inert configuration: they cannot sit between a keypress
/// and the text, so they cannot reproduce it.
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Tags a field as a one-time code for both platforms' autofill.
///
/// Correct for an EMAIL code as well as an SMS one: iOS offers the same
/// suggestion for a code it finds in Mail, and the hint describes what the
/// field is, not how the code arrived.
const List<String> otpAutofillHints = <String>[AutofillHints.oneTimeCode];

/// Digits only, bounded to [length].
///
/// Order matters and is the point: Flutter runs these BEFORE the limiter that
/// `maxLength` appends, so the digits are extracted from a pasted sentence
/// before anything is truncated.
List<TextInputFormatter> otpInputFormatters(int length) =>
    <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(length),
    ];

/// The platform's own selection toolbar, which is what carries Paste.
Widget otpContextMenu(BuildContext context, EditableTextState state) =>
    AdaptiveTextSelectionToolbar.editableText(editableTextState: state);

/// The digits in [raw], clipped to [length].
///
/// Used where a paste or an autofill has to be spread across several
/// single-character boxes. Returns '' when there is nothing usable, so a
/// caller can leave the field alone rather than clearing it.
String otpDigitsOf(String raw, {int length = 6}) {
  final digits = raw.replaceAll(RegExp(r'[^0-9]'), '');
  if (digits.isEmpty) return '';
  return digits.length <= length ? digits : digits.substring(0, length);
}

/// Spreads [code] across [controllers], one character each.
///
/// THE MULTI-BOX CASE, which is where paste went wrong in a way that looked
/// like it worked. Those screens capped every box at one character except the
/// first, so a paste landed only if the customer had pressed exactly box one —
/// and a six-digit paste into box three silently became a single digit.
///
/// Boxes beyond the code's length are CLEARED, so a shorter second paste
/// cannot leave digits of the first one behind. Returns the digits actually
/// written, so the caller can decide whether the code is complete.
String applyOtpPaste(
  List<TextEditingController> controllers,
  String raw,
) {
  final code = otpDigitsOf(raw, length: controllers.length);
  if (code.isEmpty) return '';
  for (var i = 0; i < controllers.length; i++) {
    final want = i < code.length ? code[i] : '';
    if (controllers[i].text == want) continue;
    controllers[i].value = TextEditingValue(
      text: want,
      // Selection set EXPLICITLY. `TextEditingValue(text:)` alone leaves it at
      // the invalid default (-1), which on Android is a caret the input
      // connection cannot place — the next keypress then has nowhere to go,
      // which is the "field went dead" report this app has already had once.
      selection: TextSelection.collapsed(offset: want.length),
    );
  }
  return code;
}

/// Makes a code box REPLACE its contents when it is focused, not append.
///
/// ## Why this is required, and not a nicety
///
/// The multi-box screens used to cap every box at one character. That made
/// paste impossible — a six-digit paste was truncated to one digit wherever it
/// landed — so the cap was raised to the full code length. Raising it
/// reintroduces a different problem at the other end:
///
///   * a box holding "3" that the customer taps and types "9" into now reports
///     "39", two characters, which the paste path reads as a pasted code and
///     spreads across the boxes — WIPING the rest of the code;
///   * and a paste into a non-empty box reports the old digit followed by the
///     pasted one, so the code distributed is off by a character with no way
///     to tell which part was already there.
///
/// Selecting the box's content on focus removes both at the source rather than
/// guessing from the length: whatever arrives next REPLACES what was there, so
/// typing yields one character and a paste yields exactly the pasted code. It
/// is also what people expect of a code box — tapping one to correct it should
/// not require deleting first.
///
/// Returns the listener so the caller can remove it in dispose. The selection
/// is applied in a post-frame callback because focus changes land mid-build
/// and mutating a controller during one is the hazard this file's header is
/// about.
VoidCallback selectAllOnFocus(
  TextEditingController controller,
  FocusNode node,
) {
  void listener() {
    if (!node.hasFocus) return;
    final text = controller.text;
    if (text.isEmpty) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Re-checked after the frame: focus can have moved on again, and
      // selecting in a box the caret has left would fight the one it is in.
      if (!node.hasFocus || controller.text != text) return;
      controller.selection =
          TextSelection(baseOffset: 0, extentOffset: text.length);
    });
  }

  node.addListener(listener);
  return listener;
}
