/// WHEN THE VOICE SESSION MAY TOUCH THE OUTPUT ROUTE.
///
/// This exists because "the agent's volume keeps going up and down" was never a
/// gain bug — it was the session being RECONFIGURED mid-turn, three times per
/// agent reply, by a loudspeaker override that is no longer needed on either
/// platform.
///
/// What `Hardware.setSpeakerphoneOn(true)` actually does on iOS
/// (flutter_webrtc `AudioUtils.m`): `lockForConfiguration`, then
/// `setMode:` + `setCategory:withOptions:` taken from
/// `[RTCAudioSessionConfiguration webRTCConfiguration]` — **WebRTC's** defaults,
/// not LiveKit's — followed by `overrideOutputAudioPort:`.
///
/// LiveKit's pinned `NativeAudioConfiguration.playAndRecordSpeaker` asks for
/// `AppleAudioMode.videoChat`, whose output curve is the loud, speaker-oriented
/// one. WebRTC's default is `voiceChat`, the quiet earpiece-oriented curve. So
/// every override swapped the curve out from under the reply that was already
/// being spoken, and the next one swapped it back. Three per turn is audible as
/// a level that rises and falls inside a sentence.
///
/// It is also redundant: `videoChat` already routes to the built-in speaker, and
/// the configuration is pinned for the life of the room, so there is nothing to
/// re-assert.
///
/// Android reaches the same answer by a different road: the session runs under
/// `AndroidAudioConfiguration.media`, and `setSpeakerphoneOn` drags it back into
/// `MODE_IN_COMMUNICATION` — the mode the media profile exists to escape. Media
/// playback is already on the loudspeaker.
///
/// Which leaves exactly one case where the override still earns its keep: an
/// Android session that has NOT applied the media profile (the legacy
/// communication-mode path), where the route really does default to the earpiece.
library;

/// True only when a per-turn output-route override is still necessary.
///
/// [isIOS] — the native audio configuration is pinned, so never override.
/// [androidMediaProfileApplied] — media playback already uses the loudspeaker.
bool shouldOverrideOutputRoute({
  required bool isIOS,
  required bool androidMediaProfileApplied,
}) {
  if (isIOS) return false;
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
