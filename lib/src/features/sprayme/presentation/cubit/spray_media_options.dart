import 'package:livekit_client/livekit_client.dart';

/// How LazerSpray publishes and subscribes to live media.
///
/// These were all LiveKit defaults before, and two of the defaults are wrong
/// for a live broadcast.
///
/// DTX IS WHY THE VOICE "COMES ON AND OFF"
/// ---------------------------------------
/// Discontinuous Transmission stops sending packets during silence and sends a
/// comfort-noise frame instead. It is the right default for a conference call —
/// it saves bandwidth when nobody is talking. It is the wrong default for a
/// party stream, because:
///
///   * the "silence" detector is a VAD, and over a noisy Nigerian mobile link
///     it trips mid-sentence, clipping the first syllable every time speech
///     restarts — heard exactly as audio cutting in and out;
///   * a stream with gaps in it gives the jitter buffer nothing to hold on to,
///     so each restart arrives as a fresh burst and the decoder stalls again;
///   * music and crowd noise — the whole point of a spray session — are
///     precisely the signals a VAD misclassifies.
///
/// So DTX is OFF. RED (redundant audio encoding, which piggybacks a copy of the
/// previous frame on each packet) stays ON: it is what makes a single dropped
/// packet inaudible instead of a click, and it is the right trade on a mobile
/// network where loss is the normal condition rather than an anomaly.
///
/// ADAPTIVE STREAM IS WHY BACKGROUNDING KILLED THE VIDEO
/// ----------------------------------------------------
/// Adaptive stream pauses a subscribed video track when no renderer is visible.
/// Minimise the app and every renderer goes invisible, so the track pauses;
/// come back and it has to be un-paused, which did not reliably happen. It
/// stays OFF here: a live stream is watched full-screen by definition, so the
/// bandwidth it would save is bandwidth we want spent, and the failure it
/// causes is the stream going black.
///
/// Dynacast stays ON. It pauses PUBLISHED video layers nobody is subscribed to,
/// which is pure saving on the broadcaster's battery and uplink and cannot
/// blank anybody's screen.
class SprayMediaOptions {
  const SprayMediaOptions._();

  /// Audio tuned for a live broadcast rather than a phone call.
  static const AudioPublishOptions audioPublish = AudioPublishOptions(
    dtx: false,
    red: true,
    // Speech preset is sized for a single talking voice. A spray session has
    // music, a crowd and several guests at once, so it gets the music preset's
    // headroom — the same bitrate the platform already pays for video.
    audioBitrate: AudioPreset.music,
  );

  /// Capture tuned for a phone held at arm's length in a loud room.
  ///
  /// Echo cancellation and noise suppression stay ON — with several guests on
  /// speakerphone in one room, echo is the failure everyone hears. Auto-gain
  /// stays ON so a quiet guest and a shouting one arrive at comparable levels.
  ///
  /// Three defaults are turned OFF, and each of them is a way the voice stops:
  ///
  ///   * typingNoiseDetection momentarily mutes the mic when it thinks it hears
  ///     a keyboard. Clapping, a drink being put down and bass transients all
  ///     read as typing, and each one takes a syllable with it.
  ///   * voiceIsolation strips everything that is not a single speaking voice.
  ///     That is a feature on a call and a catastrophe at a party: it removes
  ///     the music the session exists for and ducks a second person talking.
  ///   * stopAudioCaptureOnMute tears the capture device down on every mute and
  ///     re-acquires it on unmute. On iOS re-acquiring the audio session takes
  ///     seconds and occasionally fails outright, so a guest who muted to
  ///     cough could come back silent. Muting is now just a flag on a track
  ///     that stays open.
  static const AudioCaptureOptions audioCapture = AudioCaptureOptions(
    echoCancellation: true,
    noiseSuppression: true,
    autoGainControl: true,
    typingNoiseDetection: false,
    voiceIsolation: false,
    stopAudioCaptureOnMute: false,
  );

  /// Room options for every LazerSpray connection, publisher or viewer.
  static RoomOptions room() => const RoomOptions(
        adaptiveStream: false,
        dynacast: true,
        defaultAudioPublishOptions: audioPublish,
        defaultAudioCaptureOptions: audioCapture,
      );

  /// Connect options.
  ///
  /// LiveKit retries a dropped signal connection on its own; these widen the
  /// window so a lift ride or a cell handover resumes the same session instead
  /// of ending it. Anything longer than this and the stream is over anyway.
  static ConnectOptions connect() => const ConnectOptions(
        autoSubscribe: true,
        timeouts: Timeouts(
          connection: Duration(seconds: 20),
          debounce: Duration(milliseconds: 100),
          publish: Duration(seconds: 10),
          peerConnection: Duration(seconds: 20),
          iceRestart: Duration(seconds: 15),
        ),
      );
}
