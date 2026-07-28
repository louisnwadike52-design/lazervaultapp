import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_recognition_result.dart';

import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';

/// "LazerAI" in a Lazerspray live.
///
/// - [summon] dispatches the platform voice-agent into the EXISTING spray room
///   (`spray_<sessionId>`) via the voice-agent-gateway. The agent joins as a
///   participant and converses in real time — everyone already subscribes to
///   room audio, so no extra client wiring is needed to hear it.
/// - [startWakeWord] runs lightweight on-device keyword spotting on the local
///   mic; when a speaker says "lazerai" it calls [summon] (once per cooldown).
///   Best-effort: on devices where LiveKit already owns the mic this may be
///   limited, so a manual "Summon LazerAI" action is offered as the reliable
///   path.
class SprayLazerAiService {
  final Dio _dio;
  final SecureStorageService _storage;
  final stt.SpeechToText _speech = stt.SpeechToText();

  SprayLazerAiService({Dio? dio, required SecureStorageService storage})
      : _dio = dio ?? Dio(),
        _storage = storage;

  bool _wakeActive = false;
  bool _available = false;
  DateTime _lastSummon =
      DateTime.fromMillisecondsSinceEpoch(0); // client-side cooldown
  static const _cooldown = Duration(seconds: 45);

  // Match "lazerai", "lazer ai", "laser ai", "lazer eye" (common ASR variants).
  static final _wakeRe = RegExp(r'laz?er\s?(ai|eye|a\.i\.?)', caseSensitive: false);

  /// Dispatch the voice-agent into the live. Returns null on success, else a
  /// short error message.
  Future<String?> summon(String sessionId) async {
    final now = DateTime.now();
    if (now.difference(_lastSummon) < _cooldown) return null; // debounce
    final token = await _storage.getAccessToken();
    if (token == null) return 'Not authenticated';
    _lastSummon = now;
    try {
      final base = endpointRegistry.httpVoiceAgent; // https tunnel base
      await _dio.post(
        '$base/voice/spray/summon',
        data: {'session_id': sessionId},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return null;
    } catch (e) {
      _lastSummon = DateTime.fromMillisecondsSinceEpoch(0); // allow retry
      return e.toString().replaceAll('Exception: ', '');
    }
  }

  /// Begin best-effort on-device wake-word listening for [sessionId].
  Future<void> startWakeWord(String sessionId) async {
    if (_wakeActive) return;
    _wakeActive = true;
    try {
      _available = await _speech.initialize(
        onError: (_) {},
        onStatus: (status) {
          // Auto-restart the recogniser between utterances while active.
          if (_wakeActive && !_speech.isListening && status == 'notListening') {
            _restart(sessionId);
          }
        },
      );
    } catch (_) {
      _available = false;
    }
    if (!_available) {
      _wakeActive = false;
      return;
    }
    await _listen(sessionId);
  }

  Future<void> _listen(String sessionId) async {
    if (!_wakeActive) return;
    try {
      await _speech.listen(
        onResult: (r) => _onResult(r, sessionId),
        listenOptions: stt.SpeechListenOptions(
          partialResults: true,
          cancelOnError: false,
        ),
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 5),
      );
    } catch (e) {
      debugPrint('LazerAI wake-word listen error: $e');
    }
  }

  void _restart(String sessionId) {
    Future<void>.delayed(const Duration(milliseconds: 400), () {
      if (_wakeActive && !_speech.isListening) _listen(sessionId);
    });
  }

  void _onResult(SpeechRecognitionResult r, String sessionId) {
    final words = r.recognizedWords;
    if (words.isEmpty) return;
    if (_wakeRe.hasMatch(words)) {
      // Fire and forget — summon() self-debounces via the cooldown.
      unawaited(summon(sessionId));
    }
  }

  Future<void> stopWakeWord() async {
    _wakeActive = false;
    try {
      if (_speech.isListening) await _speech.stop();
    } catch (_) {}
  }
}
