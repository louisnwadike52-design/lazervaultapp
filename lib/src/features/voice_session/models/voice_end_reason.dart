/// How a voice call ended, translated for the person who was on it.
///
/// WHY THIS EXISTS
///
/// The end-of-call screen printed `state.endReason` verbatim — a machine token
/// like `agent_idle`, `sheet_dismissed` or `closed_by_user` — in red, under a
/// red shield icon. Two things were wrong at once:
///
///  1. The STRING. "agent_idle" is not a sentence. A user who stopped talking
///     for a minute was shown a word they have never seen and no explanation.
///  2. The SEVERITY. Any non-null reason was treated as a failure, so the most
///     ordinary endings there are — the user closing the sheet, or a quiet line
///     timing out — got the alarming treatment reserved for a security refusal.
///
/// So a reason now carries both a sentence and a severity, and anything
/// unrecognised degrades to a calm, generic ending rather than leaking a token.
library;

enum VoiceEndSeverity {
  /// Nothing went wrong — the call simply finished.
  normal,

  /// The call was cut short by something the user should know about.
  notable,

  /// A refusal the user may need to act on (e.g. voice verification).
  failure,
}

class VoiceEndReason {
  const VoiceEndReason({
    required this.severity,
    required this.title,
    this.detail,
  });

  final VoiceEndSeverity severity;

  /// Replaces the blanket "Call Ended" where a more specific heading helps.
  final String title;

  /// One calm sentence, or null to leave the default sign-off in place.
  final String? detail;

  bool get isFailure => severity == VoiceEndSeverity.failure;

  /// Translate a raw reason token.
  ///
  /// Matching is on normalised substrings, not equality: the token is produced
  /// in several places (the Flutter sheet, the voice gateway's hangup sweep,
  /// the agent worker) and has already appeared as `agent_idle`, `idle`, and
  /// `idle_timeout` for the same condition. Keying on equality would mean the
  /// one spelling nobody listed leaks to the screen.
  static VoiceEndReason? parse(String? raw) {
    final r = (raw ?? '').trim().toLowerCase().replaceAll('-', '_');
    if (r.isEmpty) return null;

    // ── ordinary endings — no alarm, no explanation needed ────────────────
    if (r.contains('closed_by_user') ||
        r.contains('sheet_dismissed') ||
        r == 'user' ||
        r.contains('user_ended') ||
        r.contains('hangup_by_user')) {
      return const VoiceEndReason(
        severity: VoiceEndSeverity.normal,
        title: 'Call ended',
      );
    }
    if (r.contains('completed') || r.contains('agent_ended') || r == 'agent') {
      return const VoiceEndReason(
        severity: VoiceEndSeverity.normal,
        title: 'Call ended',
      );
    }

    // ── the quiet line ────────────────────────────────────────────────────
    // This is the one the report was about. It is NOT a failure: the call did
    // what it was configured to do, and saying so plainly ("we didn't hear
    // anything") is both true and the cue to just start again.
    if (r.contains('idle') || r.contains('timeout') || r.contains('silence')) {
      return const VoiceEndReason(
        severity: VoiceEndSeverity.notable,
        title: 'Call ended',
        detail: "We didn't hear anything for a while, so the call was ended. "
            'Tap the mic to start again whenever you’re ready.',
      );
    }

    // ── genuine refusals and faults ───────────────────────────────────────
    if (r.contains('voice_verification') || r.contains('biometric')) {
      return const VoiceEndReason(
        severity: VoiceEndSeverity.failure,
        title: 'Call ended',
        detail: "We couldn't confirm it was you, so the call was ended for "
            'your security. You can try again, or use the app as normal.',
      );
    }
    if (r.contains('quota') || r.contains('limit')) {
      return const VoiceEndReason(
        severity: VoiceEndSeverity.notable,
        title: 'Call ended',
        detail: "You've used your voice minutes for now. Everything else in "
            'the app works as normal.',
      );
    }
    if (r.contains('disconnect') ||
        r.contains('network') ||
        r.contains('connection')) {
      return const VoiceEndReason(
        severity: VoiceEndSeverity.notable,
        title: 'Call ended',
        detail: 'The connection dropped. Your balance is unaffected — tap the '
            'mic to start again.',
      );
    }
    if (r.contains('error') || r.contains('failed') || r.contains('fault')) {
      return const VoiceEndReason(
        severity: VoiceEndSeverity.failure,
        title: 'Call ended',
        detail: 'Something went wrong and the call was ended. Your balance is '
            'unaffected.',
      );
    }

    // ── anything else ─────────────────────────────────────────────────────
    // A token we do not recognise must NEVER reach the screen. Degrade to the
    // ordinary ending: the user learns nothing, which is strictly better than
    // learning a word that means nothing to them.
    return const VoiceEndReason(
      severity: VoiceEndSeverity.normal,
      title: 'Call ended',
    );
  }
}
