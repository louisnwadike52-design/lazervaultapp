import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/voice_biometrics_service.dart';

/// Bottom sheet that records a short voice sample and performs a SERVER-ATTESTED
/// voice LOGIN (voice = password): the sample + cached identity go to the
/// gateway's /voice/auth/login, which verifies the ECAPA voiceprint with a
/// server-enforced threshold and — only on a match — mints a REAL session.
/// Returns the [VoiceLoginResult] (with fresh tokens) on success, or null when
/// cancelled / not verified, via Navigator.pop. The caller persists the tokens
/// exactly like a passcode login.
///
/// Used by the passcode login screen's mic button.
class VoiceLoginSheet extends StatefulWidget {
  final String userId;
  final String phone;
  const VoiceLoginSheet({super.key, required this.userId, required this.phone});

  /// Shows the sheet and returns the login result (null = cancelled/failed).
  static Future<VoiceLoginResult?> show(BuildContext context,
      {required String userId, required String phone}) {
    return showModalBottomSheet<VoiceLoginResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => VoiceLoginSheet(userId: userId, phone: phone),
    );
  }

  @override
  State<VoiceLoginSheet> createState() => _VoiceLoginSheetState();
}

enum _Phase { idle, recording, verifying, failed }

class _VoiceLoginSheetState extends State<VoiceLoginSheet> {
  static const _primary = Color(0xFF3B82F6);
  static const _textSecondary = Color(0xFF9CA3AF);
  static const _error = Color(0xFFEF4444);

  static const _recordDuration = Duration(seconds: 4);

  final AudioRecorder _recorder = AudioRecorder();
  final VoiceBiometricsService _voice = serviceLocator<VoiceBiometricsService>();

  _Phase _phase = _Phase.idle;
  String _message = 'Tap the mic and say your passphrase clearly.';
  Timer? _stopTimer;
  String? _path;

  @override
  void dispose() {
    _stopTimer?.cancel();
    _recorder.dispose();
    super.dispose();
  }

  Future<void> _start() async {
    try {
      // Mic permission.
      final status = await Permission.microphone.request();
      if (!mounted) return;
      if (!status.isGranted) {
        setState(() {
          _phase = _Phase.failed;
          // Permanently denied → the OS won't prompt again; point the user to
          // Settings instead of re-requesting into a no-op.
          _message = status.isPermanentlyDenied
              ? 'Microphone access is blocked. Enable it in your phone settings to use voice login.'
              : 'Microphone permission is required for voice login.';
        });
        if (status.isPermanentlyDenied) openAppSettings();
        return;
      }
      if (!await _recorder.hasPermission()) {
        if (!mounted) return;
        setState(() {
          _phase = _Phase.failed;
          _message = 'Microphone unavailable.';
        });
        return;
      }

      final dir = await getTemporaryDirectory();
      _path = '${dir.path}/voice_login_${DateTime.now().microsecondsSinceEpoch}.wav';

      await _recorder.start(
        const RecordConfig(encoder: AudioEncoder.wav, sampleRate: 16000, numChannels: 1),
        path: _path!,
      );
      if (!mounted) return;
      setState(() {
        _phase = _Phase.recording;
        _message = 'Listening… keep speaking.';
      });
      _stopTimer = Timer(_recordDuration, _stopAndVerify);
    } catch (e) {
      // Recorder busy, temp-dir failure, etc. — never leave the sheet frozen on
      // a silent idle/spinner; surface a retryable error.
      if (!mounted) return;
      setState(() {
        _phase = _Phase.failed;
        _message = 'Could not start recording. Close other apps using the mic and try again.';
      });
    }
  }

  Future<void> _stopAndVerify() async {
    _stopTimer?.cancel();
    final path = await _recorder.stop();
    if (!mounted) return;
    setState(() {
      _phase = _Phase.verifying;
      _message = 'Verifying your voice…';
    });

    try {
      final filePath = path ?? _path;
      if (filePath == null) throw Exception('no recording');
      final bytes = await File(filePath).readAsBytes();
      if (bytes.length < 10 * 1024) {
        throw Exception('recording too short');
      }
      // SERVER-attested login: the gateway verifies + mints a session. We NEVER
      // decide "verified" on the client.
      final result = await _voice.loginWithVoice(
        userId: widget.userId,
        phone: widget.phone,
        audioSample: Uint8List.fromList(bytes),
      );
      if (!mounted) return;
      if (result.hasSession) {
        Navigator.of(context).pop(result);
      } else {
        setState(() {
          _phase = _Phase.failed;
          _message = result.isNotEnrolled
              ? "You haven't set up Voice Login yet. Enroll your voice in Settings → Security → Biometric Login, then try again."
              : (result.status == 'IDENTITY_MISMATCH'
                  ? 'That voice doesn\'t match this account. Use your passcode.'
                  : 'Voice not recognised. Speak clearly in a quiet place, or use your passcode.');
        });
      }
    } on VoiceBiometricsNetworkException {
      if (!mounted) return;
      setState(() {
        _phase = _Phase.failed;
        _message = 'Network problem — check your connection and try again.';
      });
    } on VoiceBiometricsException catch (e) {
      if (!mounted) return;
      setState(() {
        _phase = _Phase.failed;
        _message = e.message;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _phase = _Phase.failed;
        _message = 'Could not verify your voice. Try again or use your passcode.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final recording = _phase == _Phase.recording;
    final busy = _phase == _Phase.recording || _phase == _Phase.verifying;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Voice Login',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: busy ? null : _start,
              child: Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (recording ? _error : _primary).withValues(alpha: 0.15),
                  border: Border.all(color: recording ? _error : _primary, width: 2),
                ),
                child: _phase == _Phase.verifying
                    ? const Padding(
                        padding: EdgeInsets.all(28),
                        child: CircularProgressIndicator(strokeWidth: 2, color: _primary),
                      )
                    : Icon(recording ? Icons.graphic_eq : Icons.mic,
                        color: recording ? _error : _primary, size: 40),
              ),
            ),
            const SizedBox(height: 20),
            Text(_message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: _textSecondary, fontSize: 14, height: 1.4)),
            const SizedBox(height: 20),
            if (_phase == _Phase.failed)
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF2D2D2D)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Use passcode', style: TextStyle(color: _textSecondary)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _start,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Try again', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
