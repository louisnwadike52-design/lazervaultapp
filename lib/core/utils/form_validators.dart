/// Shared form validators for consistent inline validation across the app.
///
/// Return an error string (rendered in red below the field by [TextFormField])
/// or null when valid.
class FormValidators {
  FormValidators._();

  // Pragmatic email shape: something@something.tld — no leading/trailing junk.
  static final RegExp _emailRe = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');

  /// Validates an email address. When [required] is false, an empty value is
  /// allowed (returns null); a non-empty value must be a valid email shape.
  static String? email(String? value, {bool required = false}) {
    final s = value?.trim() ?? '';
    if (s.isEmpty) return required ? 'Email is required' : null;
    return _emailRe.hasMatch(s) ? null : 'Enter a valid email address';
  }
}
