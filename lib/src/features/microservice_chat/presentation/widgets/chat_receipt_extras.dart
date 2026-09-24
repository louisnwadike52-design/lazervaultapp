/// Turning a receipt payload's `extra` map into rows a person can read.
///
/// The receipt cards rendered EVERY key in `extra` as a row, title-casing the key
/// itself. That is fine for `narration` and wrong for everything the backend puts
/// there for the app's benefit: `source_account_id` showed up as "Source Account
/// Id" with a raw UUID beside it, `recipient_image_url` as a URL, `fee_minor` as
/// a second fee row in kobo next to the real one. A receipt is the artefact
/// people screenshot and send to each other, so it is the last place that should
/// be showing internal plumbing.
///
/// Two lists, deliberately explicit rather than heuristic: a rule like "hide
/// anything ending in _id" silently hides a field a future flow wants shown, and
/// a rule like "hide anything that looks like a UUID" depends on the value rather
/// than the meaning.
library;

/// Keys that exist for the APP, not the reader.
const Set<String> kChatReceiptHiddenExtras = <String>{
  // Identifiers. The reference is the one id a receipt should carry, and it has
  // its own row already.
  'source_account_id',
  'recipient_user_id',
  'recipient_account_id',
  'recipient_bank_code',
  'batch_id',
  'client_intent_id',
  'idempotency_key',
  // Media the card renders as an avatar rather than as text.
  'recipient_image_url',
  'recipient_avatar_url',
  // Minor-unit duplicates of rows that already appear formatted. Showing both is
  // how a ₦5.10 fee ends up on a receipt beside a "510" one.
  'fee_minor',
  'new_balance_minor',
  'amount_minor',
  'total_minor',
  // Routing hints for the UI.
  'deeplink_route',
  'transfer_type',
  'status',
};

/// Friendly labels for keys worth showing.
///
/// Anything absent here falls back to title-casing the key, which is the old
/// behaviour and correct for simple fields like `narration`.
const Map<String, String> kChatReceiptExtraLabels = <String, String>{
  'source_account_label': 'From',
  'recipient_display_name': 'To',
  'recipient_username': 'Username',
  'recipient_account_number': 'Account number',
  'recipient_bank_name': 'Bank',
  'recipient_phone': 'Phone',
  'narration': 'Note',
  'category': 'Category',
  'new_balance_display': 'Balance after',
  'fee_display': 'Fee',
};

/// The order rows should appear in, most useful first.
///
/// "From" leads because it answers the question the receipt could not answer at
/// all before: which of my accounts did this leave.
const List<String> kChatReceiptExtraOrder = <String>[
  'source_account_label',
  'recipient_display_name',
  'recipient_username',
  'recipient_account_number',
  'recipient_bank_name',
  'recipient_phone',
  'narration',
  'category',
  'fee_display',
  'new_balance_display',
];

String _titleCase(String key) => key
    .split('_')
    .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
    .join(' ');

/// The label to show for an extras key.
String chatReceiptExtraLabel(String key) =>
    kChatReceiptExtraLabels[key] ?? _titleCase(key);

/// Filtered, labelled, ordered rows for a receipt's `extra` map.
///
/// Nested values are skipped: the cards render a value as a single line of text,
/// and a Map's toString on a receipt is unreadable noise.
List<MapEntry<String, String>> chatReceiptExtraRows(dynamic extra) {
  if (extra is! Map) return const [];

  final present = <String, String>{};
  extra.forEach((k, v) {
    if (v == null || v is Map || v is List) return;
    final key = k.toString();
    if (kChatReceiptHiddenExtras.contains(key)) return;
    final value = v.toString().trim();
    if (value.isEmpty) return;
    present[key] = value;
  });

  final rows = <MapEntry<String, String>>[];
  // Known keys first, in the order above.
  for (final key in kChatReceiptExtraOrder) {
    final value = present.remove(key);
    if (value != null) rows.add(MapEntry(chatReceiptExtraLabel(key), value));
  }
  // Then anything else the backend sent, so a new field still shows up rather
  // than being silently dropped by a UI that has not heard of it yet.
  final remaining = present.keys.toList()..sort();
  for (final key in remaining) {
    rows.add(MapEntry(chatReceiptExtraLabel(key), present[key]!));
  }
  return rows;
}
