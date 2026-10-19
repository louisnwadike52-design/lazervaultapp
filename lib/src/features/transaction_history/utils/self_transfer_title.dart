library;

/// Titling a LazerBeam — a move between the user's OWN accounts.
///
/// The history row for a beam read "Transfer from Praiz Onah". That is the
/// account holder: themselves. Telling someone money arrived "from Praiz Onah"
/// when Praiz Onah is who they are says nothing, and hides the one fact that
/// matters — WHICH of their accounts it came out of.
///
/// It happened because the generic transfer titling prefers
/// `counterparty_name`, and on a self-transfer the counterparty IS the user.
/// Measured on prod: both legs of a beam carry counterparty_name 'Praiz Onah'
/// and counterparty_user_id equal to the sender's own id, while the row's
/// DESCRIPTION already said exactly the right thing —
/// "Transfer from Personal to Business".
///
/// So the description is the evidence, and it is self-identifying: the beam
/// writes a TWO-SIDED description naming both accounts, whereas a transfer to
/// another person is one-sided ("Transfer from {Name}" / "Transfer to
/// {Name}"). Matching the two-sided form needs no user id and cannot mistake a
/// person-to-person transfer for a beam.
///
/// A custom narration returns null and the caller keeps its existing
/// behaviour — the user typed something they wanted to see.
class SelfTransferEndpoints {
  const SelfTransferEndpoints({required this.from, required this.to});

  /// The account the money left.
  final String from;

  /// The account the money arrived in.
  final String to;
}

const _fromPrefix = 'transfer from ';
const _toSeparator = ' to ';

/// Parses the beam's own description, or null if this is not one.
SelfTransferEndpoints? parseSelfTransferDescription(String description) {
  final desc = description.trim();
  if (desc.length <= _fromPrefix.length) return null;
  if (!desc.toLowerCase().startsWith(_fromPrefix)) return null;

  final body = desc.substring(_fromPrefix.length);

  // LAST " to ", not the first: an account can legitimately be called
  // "Trip to Ghana", and splitting on the first separator would report the
  // money as coming from "Trip" and going to "Ghana to Business".
  final cut = body.toLowerCase().lastIndexOf(_toSeparator);
  if (cut <= 0) return null;

  final from = body.substring(0, cut).trim();
  final to = body.substring(cut + _toSeparator.length).trim();
  if (from.isEmpty || to.isEmpty) return null;

  return SelfTransferEndpoints(from: from, to: to);
}

/// The title for one leg of a beam, or null when the row is not a beam.
///
/// Each leg names the OTHER end, which is the part the reader does not already
/// know from the account they are looking at: the credit into Business says
/// where it came from, the debit out of Personal says where it went.
String? selfTransferTitle({
  required String description,
  required bool isIncoming,
}) {
  final ends = parseSelfTransferDescription(description);
  if (ends == null) return null;
  return isIncoming
      ? 'Transfer from your ${ends.from}'
      : 'Transfer to your ${ends.to}';
}
