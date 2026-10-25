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
