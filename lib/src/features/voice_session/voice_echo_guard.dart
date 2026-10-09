/// Decides whether recognized speech is really the AGENT's own voice coming
/// back in through the loudspeaker.
///
/// ## Why this exists
///
/// Observed in production: Nova said *"I'm still waiting for your pin — to
/// finish that, no problem, would you like to try entering your pin again"*
/// and the app rendered that sentence as **the user's** turn, live, in the
/// middle of an authorising-a-transfer flow. On a money path, mistaking the
/// agent for the user is not cosmetic.
///
/// The old check lived inline and had three holes, all of which this fixes:
///
/// 1. **It only ran while `_agentSpeaking` was true.** The flag clears when the
///    agent's turn ends, but the loudspeaker is still emitting the tail of the
///    utterance and the room is still reverberating. Everything arriving in
///    that window was handed straight through as the user. This is the hole the
///    production failure actually came through, because in hands-free the
///    during-speech path already suppresses everything.
/// 2. **It compared against the CURRENT caption only**, and `_triggerBargeIn`
///    sets that to null. No caption meant "not echo" — the least safe default
///    available, since no caption is exactly the state right after the agent
///    stopped.
/// 3. **It required a 60% exact-token overlap.** The mic mis-hears the agent:
///    the real transcript said *"entering your **pain** again"* for the agent's
///    "pin". Exact token equality cannot match a mis-transcription, which is
///    the normal case for echo, not the exception.
///
/// Pure and clock-injected so all of that is testable without audio hardware.
class VoiceEchoGuard {
  VoiceEchoGuard({
    this.tailWindow = const Duration(milliseconds: 1500),
    this.overlapThreshold = 0.5,
    this.maxRemembered = 4,
  });

  /// How long after the agent stops speaking its voice may still reach the mic.
  ///
  /// Covers the TTS tail already in the output buffer plus room reverb. Kept
  /// deliberately short: this window costs the user responsiveness if they
  /// genuinely start talking the instant the agent stops, so it must be long
  /// enough for the echo and no longer.
  final Duration tailWindow;

  /// Fraction of recognized words that must look like the agent's.
  ///
  /// 0.5, not the old 0.6, because [_tokenMatches] tolerates near-misses and a
  /// mis-transcribed echo never reproduces the agent's words exactly.
  final double overlapThreshold;

  /// How many recent agent utterances to compare against.
  ///
  /// More than one because the echo that arrives after the agent stops belongs
  /// to the utterance that just FINISHED, which by then is no longer "current".
  final int maxRemembered;

  final List<String> _recent = <String>[];
  DateTime? _agentSpokeUntil;

  /// Record an agent utterance (its caption text) as it is spoken.
  void noteAgentUtterance(String? text) {
    final t = (text ?? '').trim();
    if (t.isEmpty) return;
    if (_recent.isNotEmpty && _recent.last == t) return;
    _recent.add(t);
    while (_recent.length > maxRemembered) {
      _recent.removeAt(0);
    }
  }

  /// Mark the moment the agent's audio stopped. Starts the tail window.
  void noteAgentStoppedSpeaking(DateTime now) => _agentSpokeUntil = now;

  /// Clear all state — a new session, or a confirmed real user turn.
  void reset() {
    _recent.clear();
    _agentSpokeUntil = null;
  }

  /// True while the agent's audio may still be reaching the mic.
  bool inTailWindow(DateTime now) {
    final until = _agentSpokeUntil;
    if (until == null) return false;
    return now.difference(until) <= tailWindow;
  }

  /// Whether [text] should be treated as the agent's own voice.
  ///
  /// [agentIsSpeaking] is the live flag; the tail window extends protection
  /// past it. Outside both, this always returns false — a guard that suppressed
  /// user speech at arbitrary times would be far worse than the bug.
  bool isEcho(String text, DateTime now, {required bool agentIsSpeaking}) {
    if (!agentIsSpeaking && !inTailWindow(now)) return false;

    final t = _normalize(text);
    if (t.isEmpty) return true;

    final words = t.split(' ').where((w) => w.isNotEmpty).toList();
    if (words.isEmpty) return true;

    for (final utterance in _recent) {
      final agentWords =
          _normalize(utterance).split(' ').where((w) => w.isNotEmpty).toList();
      if (agentWords.isEmpty) continue;
      var hits = 0;
      for (final w in words) {
        if (agentWords.any((a) => _tokenMatches(a, w))) hits++;
      }
      if (hits / words.length >= overlapThreshold) return true;
    }

    // Nothing remembered to compare against, but the agent is audible right
    // now. Hole 2 was defaulting to "user" here; the safe default while a
    // loudspeaker is playing the agent's voice is "agent".
    if (_recent.isEmpty) return true;

    return false;
  }

  static String _normalize(String s) => s
      .toLowerCase()
      .replaceAll(RegExp(r"[^a-z0-9\s']"), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();

  /// Token equality that tolerates how a microphone mangles speech.
  ///
  /// "pin" → "pain" is one edit, and that single substitution is what let a
  /// whole echoed sentence through the old exact-match check.
  static bool _tokenMatches(String a, String b) {
    if (a == b) return true;
    // Only bother for words long enough that an edit is meaningful; on 1-3
    // letter words a single edit changes the word entirely ("a"/"I", "no"/"go").
    if (a.length < 4 && b.length < 4) return false;
    if ((a.length - b.length).abs() > 1) return false;
    return _withinOneEdit(a, b);
  }

  static bool _withinOneEdit(String a, String b) {
    if (a.length == b.length) {
      var diff = 0;
      for (var i = 0; i < a.length; i++) {
        if (a[i] != b[i] && ++diff > 1) return false;
      }
      return diff <= 1;
    }
    final shorter = a.length < b.length ? a : b;
    final longer = a.length < b.length ? b : a;
    var i = 0, j = 0, skips = 0;
    while (i < shorter.length && j < longer.length) {
      if (shorter[i] == longer[j]) {
        i++;
        j++;
      } else {
        if (++skips > 1) return false;
        j++;
      }
    }
    return true;
  }
}
