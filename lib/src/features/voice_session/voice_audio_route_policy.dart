/// WHO OWNS THE OUTPUT ROUTE, AND WHEN THE MIC MAY OPEN.
///
/// **The volume swing, and what actually caused it.** The agent's level rising
/// and falling between turns was LiveKit's DEFAULT native-audio configuration
/// function reacting to the track state:
///
///   * `remoteOnly` (the agent is talking, no local mic published)
///       -> `NativeAudioConfiguration.playback` — category playback, mode
///          spokenAudio, the LOUD media curve
///   * `localAndRemote` (the echo-cancelled mic is published for barge-in)
///       -> `NativeAudioConfiguration.playAndRecordSpeaker` — playAndRecord,
///          mode videoChat, a different and quieter curve
///
/// On iOS the AEC mic is published at the start of every agent turn, so the
/// session swapped output curve mid-conversation, every turn. The fix is the
/// `onConfigureNativeAudio` pin at the Room construction site, which returns
/// `playAndRecordSpeaker` whatever the track state — one curve for the life of
/// the session. That pin is the whole fix and it is not in this file.
///
/// **What this file is NOT.** An earlier version of it claimed
/// `Hardware.instance.setSpeakerphoneOn(true)` was the culprit, on the grounds
/// that flutter_webrtc's `AudioUtils.m` replaces the mode with WebRTC's
/// `voiceChat` default. That is the ANDROID branch. On iOS
/// `Hardware.setSpeakerphoneOn` re-invokes `onConfigureNativeAudio` and applies
/// the result through `Native.configureAudio` — so with the pin in place it
/// re-applies OUR pinned configuration, idempotently. Gating it off on iOS
/// removed a useful safety net (an external component — the transaction-PIN
/// sheet, a platform interruption — can reconfigure the session and leave the
/// agent on the earpiece with nothing restoring it) and fixed nothing.
///
/// So re-assertion is kept on iOS, where it is cheap and genuinely restorative,
/// and stays suppressed under the Android media profile, where
/// `setSpeakerphoneOn` really does take the flutter_webrtc path and drag the
/// session back into `MODE_IN_COMMUNICATION` — the mode the media profile
/// exists to escape.
library;

/// True when re-asserting the output route is useful rather than harmful.
///
/// [isIOS] — re-applies the PINNED LiveKit configuration; safe and restorative.
/// [androidMediaProfileApplied] — media playback is already on the loudspeaker,
/// and the override would undo the profile.
bool shouldOverrideOutputRoute({
  required bool isIOS,
  required bool androidMediaProfileApplied,
}) {
  if (isIOS) return true;
  return !androidMediaProfileApplied;
}

/// Whether the ON-DEVICE RECOGNISER may be live while the agent is audible.
///
/// Never. "At no point does the voice AI go into the user's voice" is a
/// prevention rule, not a filtering rule: the textual echo guard is a second
/// line of defence for the loudspeaker tail, not a licence to hold the mic open
/// through a reply.
///
/// Neither platform needs it open:
///
///   * iOS hands the agent phase to LiveKit's mic, which runs under the
///     voice-processing I/O unit and therefore has HARDWARE echo cancellation.
///     The recogniser — which has none — is stopped for the duration.
///   * Android runs the session under `AndroidAudioConfiguration.media`, which
///     deliberately does NOT engage voice processing, so a recogniser left open
///     hears the agent's own sentence off the loudspeaker and submits it as the
///     user's turn.
///
/// And nothing is lost by closing it. Acoustic barge-in needed two non-echo
/// words before it fired, so the agent talked over the first half of the
/// sentence while the user competed with it; a deliberate press interrupts
/// immediately and arrives earlier. Push-to-talk already calls the barge-in
/// path from the button, which clears the speaking flags before the capture
/// window opens — so by the time the recogniser starts, the agent is no longer
/// speaking and this rule does not stand in its way.
///
/// The window this closes: the button held as the agent BEGINS a reply. There
/// the press came first, so it could not clear a flag that was not yet set, and
/// the mic was opened 700 ms into the agent's own audio with no echo canceller.
bool recogniserMayOpenWhileAgentSpeaks() => false;
