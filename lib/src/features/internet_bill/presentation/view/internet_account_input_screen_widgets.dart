part of 'internet_account_input_screen.dart';

/// Per-ISP account input rules are grounded in real VTpass `/merchant-verify`
/// behavior we probed against the sandbox on 2026-04-18 plus the public
/// VTpass API docs. Every rule is sourced, not guessed.
///
/// | ISP         | Input rule                                              | Verify?                |
/// |-------------|---------------------------------------------------------|------------------------|
/// | Smile       | Email OR 10–11 digit Smile number                       | yes, VTpass            |
/// | Spectranet  | 11-digit Nigerian phone (starts with 0)                 | no (PIN-voucher biller)|
/// | IPNX/Swift  | Disabled server-side until VTpass serviceIDs confirmed. | n/a                    |
class _IspInputRules {
  const _IspInputRules({
    required this.keyboardType,
    required this.formatters,
    required this.validator,
    required this.hint,
    required this.help,
    required this.requiresVerification,
  });

  final TextInputType keyboardType;
  final List<TextInputFormatter> formatters;
  final String? Function(String? value) validator;
  final String hint;
  final String help;
  final bool requiresVerification;

  /// Unknown serviceIDs fall back to a conservative digits-only rule and
  /// require verification — any new ISP gets an explicit entry here
  /// before we ship it live.
  static _IspInputRules forServiceId(String serviceId) {
    switch (serviceId.toLowerCase()) {
      case 'smile-direct':
      case 'smile':
        return _smile;
      case 'spectranet':
        return _spectranet;
      default:
        return _genericNumeric;
    }
  }

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
  );

  static final _IspInputRules _smile = _IspInputRules(
    keyboardType: TextInputType.emailAddress,
    formatters: const [],
    requiresVerification: true,
    hint: 'name@example.com or 10-digit Smile number',
    help: 'Enter your Smile email, Smile phone number, or 10-digit Smile '
        'account number.',
    // Two-path validator: if the user typed something with an `@`,
    // we treat it as an email attempt and enforce the RFC-ish
    // pattern. Otherwise we fall through to the numeric branch and
    // enforce Smile's 10/11-digit length rule. Specific error
    // messages on each path so the user knows exactly what to fix
    // instead of seeing a catch-all string.
    validator: (value) {
      final v = (value ?? '').trim();
      if (v.isEmpty) return 'Account is required';

      // Email attempt: anything containing "@". Don't fall back to
      // the digits path once they've committed to an email — it
      // would be confusing to reject "user@x" with "must be 10–11
      // digits".
      if (v.contains('@')) {
        if (!_emailRegex.hasMatch(v)) {
          return 'Enter a valid email address (e.g. name@example.com)';
        }
        return null;
      }

      // Numeric path: strip nothing — Smile accounts are plain digits.
      // Anything else (letters, spaces) is rejected.
      if (RegExp(r'^\d+$').hasMatch(v)) {
        if (v.length < 10) return 'Smile account must be at least 10 digits';
        if (v.length > 11) return 'Smile account can\'t be more than 11 digits';
        return null;
      }

      return 'Enter a valid email or 10–11 digit Smile number';
    },
  );

  static final _IspInputRules _spectranet = _IspInputRules(
    keyboardType: TextInputType.phone,
    formatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(11)],
    // VTpass merchant-verify DOES work for Spectranet — the previous
    // "no verify" flag was added to route around a backend JSON-
    // unmarshal crash (the VTpass response for some Spectranet codes
    // returned `content` as a scalar string instead of the struct
    // shape). That crash is fixed upstream now, so we let the same
    // validation the other ISPs use catch bad account numbers
    // *before* the user sees a payment-processing failure.
    requiresVerification: true,
    hint: '0XXXXXXXXXX',
    help: 'Enter the 11-digit Nigerian phone number tied to your '
        'Spectranet PIN subscription.',
    validator: (value) {
      final v = (value ?? '').trim();
      if (v.isEmpty) return 'Phone number is required';
      if (v.length != 11) return 'Phone must be exactly 11 digits';
      if (!v.startsWith('0')) return 'Phone must start with 0';
      return null;
    },
  );

  static final _IspInputRules _genericNumeric = _IspInputRules(
    keyboardType: TextInputType.number,
    formatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(20)],
    requiresVerification: true,
    hint: 'Enter your account number',
    help: 'Enter the account number from your internet provider.',
    validator: (value) {
      final v = (value ?? '').trim();
      if (v.isEmpty) return 'Account number is required';
      if (v.length < 5) return 'Account number must be at least 5 characters';
      return null;
    },
  );
}
