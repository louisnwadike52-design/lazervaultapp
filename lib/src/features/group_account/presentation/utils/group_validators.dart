/// Validation helpers shared between the Create-Group bottom sheet and the
/// Edit-Group screen.
///
/// Limits below are intentionally generous for African names and
/// descriptions (long given names, hyphenated surnames, multi-clause
/// purpose statements) but bounded so the backend can store them in
/// reasonably-sized varchar / text columns.
///
/// The same limits MUST be enforced server-side (see
/// `microservices/group-accounts-service/internal/service/group_account_service.go`
/// CreateGroup / UpdateGroup) so a malicious client cannot bypass them.
library;

class GroupValidators {
  /// Group name. Lower bound: prevents accidental empty / "x" submissions.
  /// Upper bound: comfortably accommodates names like "Lagos University
  /// Alumni Class of 2018 - Engineering Faculty" without truncating.
  static const int nameMinLength = 3;
  static const int nameMaxLength = 80;

  /// Description. Lower bound: forces enough context for other members to
  /// understand the group's purpose. Upper bound: ~one paragraph.
  static const int descriptionMinLength = 10;
  static const int descriptionMaxLength = 500;

  /// External link upper bound (used when an actual URL is supplied).
  static const int linkMaxLength = 200;

  /// Returns null on valid input, error message otherwise.
  static String? name(String? raw) {
    final value = (raw ?? '').trim();
    if (value.isEmpty) return 'Please enter a group name';
    if (value.length < nameMinLength) {
      return 'Group name must be at least $nameMinLength characters';
    }
    if (value.length > nameMaxLength) {
      return 'Group name must be at most $nameMaxLength characters';
    }
    return null;
  }

  static String? description(String? raw) {
    final value = (raw ?? '').trim();
    if (value.isEmpty) return 'Please enter a description';
    if (value.length < descriptionMinLength) {
      return 'Description must be at least $descriptionMinLength characters';
    }
    if (value.length > descriptionMaxLength) {
      return 'Description must be at most $descriptionMaxLength characters';
    }
    return null;
  }

  // ---------------------------------------------------------------------
  // External link validators.
  //
  // The product asks for "actual" WhatsApp / Telegram links, not arbitrary
  // URLs that happen to live on those domains. The patterns below match
  // the canonical invite-link formats only:
  //
  //   WhatsApp:  https://chat.whatsapp.com/<code>
  //              https://wa.me/<phone>     (channel/contact deep links)
  //   Telegram:  https://t.me/<handle>
  //              https://t.me/+<invite-code>
  //              https://telegram.me/<handle>
  //
  // We intentionally REJECT arbitrary http/https URLs so a user cannot
  // smuggle a phishing link through a "group invite" field.
  // ---------------------------------------------------------------------

  static final RegExp _whatsappPattern = RegExp(
    r'^https://(chat\.whatsapp\.com/[A-Za-z0-9_-]{8,}|wa\.me/[+]?[0-9]{6,15}([?/].*)?)$',
    caseSensitive: false,
  );

  static final RegExp _telegramPattern = RegExp(
    r'^https://(t|telegram)\.me/(\+?[A-Za-z0-9_-]{4,})([?/].*)?$',
    caseSensitive: false,
  );

  /// Optional field — empty is OK. Returns error if non-empty but not a
  /// canonical WhatsApp invite link.
  static String? whatsappLink(String? raw) {
    final value = (raw ?? '').trim();
    if (value.isEmpty) return null;
    if (value.length > linkMaxLength) {
      return 'Link is too long (max $linkMaxLength characters)';
    }
    if (!_whatsappPattern.hasMatch(value)) {
      return 'Enter a valid WhatsApp invite link (https://chat.whatsapp.com/... or https://wa.me/...)';
    }
    return null;
  }

  /// Optional field — empty is OK. Returns error if non-empty but not a
  /// canonical Telegram invite link.
  static String? telegramLink(String? raw) {
    final value = (raw ?? '').trim();
    if (value.isEmpty) return null;
    if (value.length > linkMaxLength) {
      return 'Link is too long (max $linkMaxLength characters)';
    }
    if (!_telegramPattern.hasMatch(value)) {
      return 'Enter a valid Telegram invite link (https://t.me/...)';
    }
    return null;
  }
}
