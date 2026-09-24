import 'package:record/record.dart';

/// The two audio-capture profiles this app records with, in one place.
///
/// THE BUG THIS EXISTS TO STOP: `RecordConfig` defaults to STEREO at 44.1kHz, and
/// stereo silently fails to initialise on most Android mics and emulators —
/// AudioRecord returns without error and the file ends up empty. iOS's
/// AVAudioRecorder is lenient and works anyway, so the symptom is "voice notes
/// don't send on Android" with nothing in the logs and nothing reproducible on a
/// simulator.
///
/// `numChannels: 1` is therefore not a preference. Four of the chat recorders
/// omitted it — the general assistant, the per-service chat, the service bottom
/// sheet and the AI chat — while the P2P one and every voice-biometrics path set
/// it, which is why voice notes worked in a P2P conversation and not in a chat
/// with the assistant.
///
/// Mono is also correct on its own terms: a phone has one usable mic for speech,
/// so the second channel is a duplicate that doubles the upload for nothing.

/// Voice notes and any clip a PERSON will listen to or that goes to speech-to-text.
///
/// AAC at 44.1kHz/128kbps: small enough to upload on a slow connection, good
/// enough that Whisper and the African STT service transcribe it without
/// complaint, and playable everywhere without transcoding.
const RecordConfig kVoiceNoteRecordConfig = RecordConfig(
  encoder: AudioEncoder.aacLc,
  numChannels: 1,
  sampleRate: 44100,
  bitRate: 128000,
);

/// Voice biometrics — enrolment and verification.
///
/// Uncompressed WAV at 16kHz mono, which is what the speaker-embedding model
/// expects. Do NOT reach for [kVoiceNoteRecordConfig] here: AAC is lossy, and the
/// artefacts it introduces move the embedding enough to fail a legitimate
/// speaker against their own enrolment.
const RecordConfig kVoiceBiometricRecordConfig = RecordConfig(
  encoder: AudioEncoder.wav,
  sampleRate: 16000,
  numChannels: 1,
);
