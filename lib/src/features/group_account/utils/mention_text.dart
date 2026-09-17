/// The text half of @mentions: finding the token being typed, inserting a
/// chosen name, and working out which mentions survived editing.
///
/// Kept free of widgets so the fiddly parts — caret positions, word
/// boundaries, a name deleted after it was picked — can be tested directly.
/// Every one of these is a case where getting it slightly wrong produces a
/// message that tags the wrong person or nobody.
library;

/// An in-progress "@..." at the caret.
class MentionQuery {
  /// Index of the '@'.
  final int start;

  /// Index just past the last character of the token.
  final int end;

  /// What follows the '@' — may be empty, which is the moment the picker
  /// should open showing everyone.
  final String term;

  const MentionQuery({
    required this.start,
    required this.end,
    required this.term,
  });
}

class MentionText {
  MentionText._();

  /// Longest run of words a display name may span when matching.
  ///
  /// Names here are commonly two or three words ("Praiz Onah Flw"), and the
  /// token being typed has no way to know where the name ends — so matching
  /// tries progressively longer runs up to this bound rather than assuming one
  /// word.
  static const int maxNameWords = 4;

  /// The mention token the caret currently sits in, or null.
  ///
  /// Requires the '@' to start a word: preceded by nothing or by whitespace.
  /// Without that rule an email address ("pay ada@site.com") would open the
  /// picker mid-address, and every reply containing one would fight the user.
  ///
  /// The token ends at the caret, not at the next space — a name can contain
  /// spaces, and stopping at the first one would make "@Praiz Onah"
  /// unmatchable.
  /// [notBefore] is the end of the most recently COMPLETED mention.
  ///
  /// Because a token may contain spaces (names are multi-word), a trailing
  /// space cannot close it — the walk-back would sail straight over the space
  /// and find the '@' of the name just chosen, reopening the picker on top of
  /// it. Selection therefore records a boundary and the scan refuses to look
  /// back past it, which is what actually ends a mention.
  static MentionQuery? queryAt(String text, int caret, {int notBefore = 0}) {
    if (caret < 0 || caret > text.length) return null;

    // Walk back to the nearest '@' that could open a token.
    var i = caret - 1;
    var wordsSeen = 0;
    while (i >= 0 && i >= notBefore) {
      final ch = text[i];
      if (ch == '@') {
        final before = i == 0 ? null : text[i - 1];
        final startsWord = before == null || _isSpace(before);
        if (!startsWord) return null;
        return MentionQuery(
          start: i,
          end: caret,
          term: text.substring(i + 1, caret),
        );
      }
      // A newline always terminates a token — a mention never spans lines.
      if (ch == '\n') return null;
      if (_isSpace(ch)) {
        wordsSeen++;
        // Give up once the run is longer than any name we would match, so
        // typing a paragraph after an unfinished '@' stops re-opening the
        // picker.
        if (wordsSeen >= maxNameWords) return null;
      }
      i--;
    }
    return null;
  }

  static bool _isSpace(String ch) => ch == ' ' || ch == '\n' || ch == '\t';

  /// Replace the token at [query] with "@Name " and report the new caret.
  ///
  /// The trailing space matters: without it the caret sits immediately after
  /// the name, [queryAt] still sees an open token, and the picker reopens over
  /// the name that was just chosen.
  static ({String text, int caret}) applyMention(
    String text,
    MentionQuery query,
    String displayName,
  ) {
    final token = '@$displayName ';
    final next = text.replaceRange(query.start, query.end, token);
    return (text: next, caret: query.start + token.length);
  }

  /// Ids whose "@Name" is still present in [text].
  ///
  /// A mention is only real while its text is: if someone picks Ada and then
  /// deletes the name, sending Ada's id would notify her about a message that
  /// never names her. Re-checking the text at send time is what keeps the
  /// stored ids honest against arbitrary editing — including a name partially
  /// backspaced, which leaves no whole "@Ada" to find.
  ///
  /// [chosen] maps user id to the display name that was inserted.
  static List<String> survivingMentions(
    String text,
    Map<String, String> chosen,
  ) {
    if (chosen.isEmpty) return const [];
    final out = <String>[];
    for (final entry in chosen.entries) {
      final needle = '@${entry.value}';
      if (needle.length > 1 && text.contains(needle)) out.add(entry.key);
    }
    return out;
  }

  /// Rank candidates for a term.
  ///
  /// Prefix matches lead: someone typing "@ad" means a name that STARTS with
  /// "ad" far more often than one merely containing it, and burying the
  /// obvious answer under coincidental substring hits is what makes a picker
  /// feel wrong.
  static List<T> rank<T>(
    Iterable<T> candidates,
    String term, {
    required String Function(T) nameOf,
  }) {
    final q = term.trim().toLowerCase();
    final list = candidates.toList();
    if (q.isEmpty) return list;

    final prefix = <T>[];
    final contains = <T>[];
    for (final c in list) {
      final n = nameOf(c).toLowerCase();
      if (n.startsWith(q)) {
        prefix.add(c);
      } else if (n.contains(q)) {
        contains.add(c);
      }
    }
    return [...prefix, ...contains];
  }
}

/// One run of message text, flagged as a mention or not.
class MentionSpan {
  final String text;
  final bool isMention;

  /// True when the mention is of the reader. Their own name in a busy thread
  /// is the one they scan for, so it earns stronger emphasis than a mention of
  /// somebody else.
  final bool isSelf;

  const MentionSpan(this.text, {this.isMention = false, this.isSelf = false});
}

/// Split [text] into plain and mentioned runs.
///
/// Driven by NAMES rather than by scanning for "@word", because a display name
/// contains spaces and an "@word" rule would highlight only its first word —
/// leaving "@Praiz" coloured and "Onah Flw" plain, which looks like a rendering
/// fault rather than a mention.
///
/// [namesById] supplies the display name for each mentioned id; ids with no
/// known name (a member who has since left) simply go unhighlighted rather
/// than guessing at a substring.
extension MentionHighlighting on MentionText {
  static List<MentionSpan> spans(
    String text,
    List<String> mentionedIds,
    Map<String, String> namesById, {
    String? selfUserId,
  }) {
    if (text.isEmpty) return const [];
    if (mentionedIds.isEmpty) return [MentionSpan(text)];

    // Longest first: when one name is a prefix of another ("Ada" / "Ada Obi"),
    // matching the short one first would leave " Obi" dangling outside the
    // highlight.
    final targets = <({String needle, bool isSelf})>[];
    for (final id in mentionedIds) {
      final name = namesById[id];
      if (name == null || name.trim().isEmpty) continue;
      targets.add((needle: '@${name.trim()}', isSelf: id == selfUserId));
    }
    if (targets.isEmpty) return [MentionSpan(text)];
    targets.sort((a, b) => b.needle.length.compareTo(a.needle.length));

    final out = <MentionSpan>[];
    var i = 0;
    while (i < text.length) {
      ({String needle, bool isSelf})? hit;
      var at = -1;
      for (final t in targets) {
        final idx = text.indexOf(t.needle, i);
        if (idx >= 0 && (at < 0 || idx < at)) {
          at = idx;
          hit = t;
        }
      }
      if (hit == null || at < 0) {
        out.add(MentionSpan(text.substring(i)));
        break;
      }
      if (at > i) out.add(MentionSpan(text.substring(i, at)));
      out.add(MentionSpan(hit.needle, isMention: true, isSelf: hit.isSelf));
      i = at + hit.needle.length;
    }
    return out;
  }
}
