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
  /// Group / contribution name. Lower bound: prevents accidental empty or "x"
  /// submissions.
  ///
  /// Upper bound 50, down from 80. The name is rendered on one clipped line
  /// almost everywhere it appears — the group card, the contribution card, the
  /// details header, the picker rows, the push notifications — so anything
  /// past roughly this length was never actually read by anyone; it was
  /// ellipsised at every call site and only reachable by opening the
  /// full-text dialog. 50 is the common ceiling for a title field for exactly
  /// this reason, and it is what the UI can show without truncating.
  static const int nameMinLength = 3;
  static const int nameMaxLength = 50;

  /// Description. Lower bound: forces enough context for other members to
  /// understand the purpose.
  ///
  /// Upper bound 200, down from 500. Descriptions are shown clipped to one or
  /// two lines in every list, so 500 characters bought a paragraph nobody saw
  /// and a text field that scrolled away under the keyboard while being typed.
  /// 200 is about two sentences — enough to say what the thing is for, short
  /// enough to render whole.
  static const int descriptionMinLength = 10;
  static const int descriptionMaxLength = 200;

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
      // Name the part that actually failed. The old wording said "must be
      // https://chat.whatsapp.com/..." to someone who had typed exactly
      // that — the real rejection was an invite code shorter than 8
      // characters, and the message sent them looking at the half that was
      // already right. Matches the server's wording word for word.
      return 'Paste the full WhatsApp invite link: chat.whatsapp.com/ '
          'followed by the invite code (at least 8 characters), '
          'or wa.me/<phone number>';
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
      return 'Paste the full Telegram link: t.me/ followed by the group '
          'handle or invite code (at least 4 characters)';
    }
    return null;
  }
}
