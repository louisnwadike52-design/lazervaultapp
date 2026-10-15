/// The PayID entry field already draws a fixed `PAY-` prefix, so the text the
/// user types is only the code after it.
///
/// Everything a user has to paste, though, carries that prefix: the share
/// message, the invoice PDF, the details screen's copy button and the receipt
/// all render `displayPayId`, which is `'PAY-$payId'`. Pasting one produced
/// `PAY-PAY-RSW6DQ` on screen and sent `PAY-RSW6DQ` to a lookup that expects
/// the bare code — a guaranteed "PayID Not Found" for a code that exists.
///
/// So the prefix is stripped from the INPUT rather than at submit: fixing it
/// only on the way out would leave the doubled text visible in the field,
/// which is what somebody reports as the bug.
String stripPayIdPrefix(String raw) {
  var out = raw.trimLeft();
  // Repeat: a paste on top of an earlier paste can carry it twice, and a
  // single pass would leave the second one.
  while (true) {
    final upper = out.toUpperCase();
    if (!upper.startsWith('PAY')) break;
    var rest = out.substring(3);
    // The separator is optional — "PAY-A3K9X2", "PAY A3K9X2" and "PAYA3K9X2"
    // are all the same thing to someone copying by hand.
    if (rest.startsWith('-') || rest.startsWith('_') || rest.startsWith(' ')) {
      rest = rest.substring(1);
    } else if (rest.isEmpty) {
      // Exactly "PAY" and nothing else: leave it alone. Stripping it would
      // silently empty the field mid-type, before the user has typed the
      // code they are about to paste or type.
      break;
    }
    out = rest.trimLeft();
  }
  return out;
}
