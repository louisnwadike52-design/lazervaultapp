/// Parses a scanned QR code's raw text into a Klasha-usable wallet identifier.
///
/// Klasha's C2C WALLET payout (Alipay / WeChat Pay) accepts ONLY a mobile
/// number or an email as the account identifier (accountId type MOBILE|EMAIL —
/// docs-confirmed; there is no QR/UID account type). Personal Alipay/WeChat
/// receive-codes encode an opaque token (`qr.alipay.com/…`, `wxp://…`) that
/// does NOT contain the login phone/email, so those are detected and reported
/// as [RmbQrReceiveCode] with a friendly explanation instead of being pasted
/// into the account field.
///
/// What we CAN extract: `tel:` links, `mailto:` links, vCard/MECARD contact
/// codes (TEL/EMAIL lines), plain emails and plain phone numbers.
sealed class RmbQrResult {
  const RmbQrResult();
}

/// A phone number usable as an Alipay/WeChat MOBILE account id.
class RmbQrPhone extends RmbQrResult {
  final String phone;
  const RmbQrPhone(this.phone);
}

/// An email usable as an Alipay EMAIL account id (Alipay only).
class RmbQrEmail extends RmbQrResult {
  final String email;
  const RmbQrEmail(this.email);
}

/// An Alipay/WeChat personal receive-code — cannot be converted to a
/// phone/email; the user must ask the recipient for their login id.
class RmbQrReceiveCode extends RmbQrResult {
  const RmbQrReceiveCode();
}

/// Nothing usable found in the code.
class RmbQrUnrecognized extends RmbQrResult {
  const RmbQrUnrecognized();
}

final RegExp _emailRe = RegExp(
    r'[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}',
    caseSensitive: false);

// 7+ digits with optional +, spaces, dashes, parentheses between them.
final RegExp _phoneRe = RegExp(r'\+?[0-9][0-9\s\-().]{5,}[0-9]');

const List<String> _receiveCodeMarkers = [
  'qr.alipay.com',
  'alipays://',
  'alipay://',
  'wxp://',
  'weixin://',
  'wechat://',
  'weixin.qq.com',
];

RmbQrResult extractRmbWalletId(String raw) {
  final text = raw.trim();
  if (text.isEmpty) return const RmbQrUnrecognized();
  final lower = text.toLowerCase();

  for (final marker in _receiveCodeMarkers) {
    if (lower.contains(marker)) return const RmbQrReceiveCode();
  }

  if (lower.startsWith('tel:')) {
    final p = _normalizePhone(text.substring(4));
    return p == null ? const RmbQrUnrecognized() : RmbQrPhone(p);
  }
  if (lower.startsWith('mailto:')) {
    final m = _emailRe.firstMatch(text.substring(7));
    return m == null ? const RmbQrUnrecognized() : RmbQrEmail(m.group(0)!);
  }

  // vCard / MECARD contact codes — prefer TEL, then EMAIL.
  if (lower.contains('begin:vcard') || lower.startsWith('mecard:')) {
    for (final line in text.split(RegExp(r'[\r\n;]'))) {
      final l = line.trim();
      final u = l.toUpperCase();
      if (u.startsWith('TEL')) {
        final idx = l.indexOf(':');
        if (idx > 0) {
          final p = _normalizePhone(l.substring(idx + 1));
          if (p != null) return RmbQrPhone(p);
        }
      }
    }
    final m = _emailRe.firstMatch(text);
    if (m != null) return RmbQrEmail(m.group(0)!);
    return const RmbQrUnrecognized();
  }

  // Plain email / plain phone content.
  final email = _emailRe.firstMatch(text);
  if (email != null) return RmbQrEmail(email.group(0)!);
  final phoneMatch = _phoneRe.firstMatch(text);
  if (phoneMatch != null) {
    // Only treat it as a phone if the code is essentially just the number —
    // arbitrary URLs full of digits should not be mistaken for one.
    final digits = text.replaceAll(RegExp(r'[^0-9]'), '');
    final matched = phoneMatch.group(0)!.replaceAll(RegExp(r'[^0-9]'), '');
    if (matched.length >= 7 && matched.length >= digits.length - 2) {
      final p = _normalizePhone(phoneMatch.group(0)!);
      if (p != null) return RmbQrPhone(p);
    }
  }
  return const RmbQrUnrecognized();
}

/// Normalizes to the digits-only shape Klasha expects (e.g. `8613800138000`):
/// strips separators and a leading `+`/`00`; a bare 11-digit Chinese mobile
/// (starts with 1) gets the `86` country code prefixed.
String? _normalizePhone(String s) {
  var digits = s.replaceAll(RegExp(r'[^0-9+]'), '');
  if (digits.startsWith('+')) digits = digits.substring(1);
  if (digits.startsWith('00')) digits = digits.substring(2);
  if (digits.length < 7) return null;
  if (digits.length == 11 && digits.startsWith('1')) return '86$digits';
  return digits;
}
