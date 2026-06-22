import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/voice_session/cubit/voice_session_cubit.dart';

/// Dedicated voice cloning recording screen.
///
/// SHORT GUIDED FLOW: the user reads ONE fixed, phonetically-balanced script
/// aloud (~20s). This replaced the older open-ended 30-60s "story" recording —
/// a fixed script gives consistent phoneme coverage in far less time, which is
/// both faster for the user and produces a more reliable clone.
///
/// This is separate from voice enrollment (biometrics) which uses short
/// scripted phrases for identity verification.
class VoiceCloningScreen extends StatefulWidget {
  const VoiceCloningScreen({super.key});

  @override
  State<VoiceCloningScreen> createState() => _VoiceCloningScreenState();
}

enum _CloningStep { intro, recording, uploading, success, error }

class _VoiceCloningScreenState extends State<VoiceCloningScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final AudioRecorder _recorder = AudioRecorder();
  Timer? _durationTimer;
  Timer? _amplitudeTimer;
  Timer? _pendingPollTimer;

  _CloningStep _step = _CloningStep.intro;
  int _recordingSeconds = 0;
  double _currentAmplitude = 0.0;
  String? _recordingPath;
  String? _errorMessage;
  bool _isRecording = false;
  bool _isPaused = false;
  bool _isStartingRecording = false; // Double-tap guard
  bool _isUploading = false; // Prevent concurrent uploads
  bool _disposed = false;
  String? _resultStatus; // 'ready' or 'pending' from server

  /// Voice readiness/quality score (0.0-1.0) returned by the upload response
  /// and refreshed from status polls / the live `custom_voice_state` push.
  double? _score;

  /// Cloning progress 0-100 while processing (from status poll / live push).
  int? _processingProgress;

  // Upload progress
  String _uploadStatus = '';

  // Guided read-aloud targets. The fixed script below takes ~40s to read at a
  // natural pace; we accept anything past the minimum and auto-stop at max. Longer
  // than before so we capture MORE speaker audio — better speaker-embedding quality
  // for biometric recognition AND a richer phoneme set for clone enrollment.
  static const int _minDurationSeconds = 25;
  static const int _targetDurationSeconds = 40;
  static const int _maxDurationSeconds = 60;
  static const int _maxAudioSizeBytes = 10 * 1024 * 1024; // 10MB safety limit

  late AnimationController _pulseController;

  /// Whether we sent `custom_voice_setup_started` to a live session and still
  /// owe it a matching `custom_voice_setup_finished` (so we resume exactly once).
  bool _sessionPaused = false;

  /// Live custom-voice push listener (drives the processing progress/score while
  /// this screen is open and a voice call is active in the background).
  VoiceSessionCubit? _voiceSession;

  String get _voiceGatewayUrl =>
      dotenv.env['VOICE_AGENT_GATEWAY_URL'] ?? endpointRegistry.httpVoiceAgent;

  /// Fixed, phonetically-balanced read-aloud script (~40s at a natural pace).
  /// Longer on purpose: more audio means a more reliable speaker embedding for
  /// biometric recognition and a richer phoneme range for the voice clone. It
  /// covers varied vowels, plosives, fricatives, nasals, sibilants and spoken
  /// numbers across short and long words.
  static const String _readingScript =
      "Hello, this is my voice and I am setting up my personal assistant today. "
      "The quick brown fox jumps over the lazy dog while five wizards quietly judge my pitch and tone. "
      "I enjoy bright mornings, calm evenings, and a good cup of coffee with friends and family. "
      "On a typical day I might check my balance, send money to a friend, and pay a few bills before lunch. "
      "Numbers like one, two, three, seven, twelve, and fifteen should sound clear and natural when I say them aloud. "
      "I like to travel, read interesting books, listen to good music, and take long walks beside the river. "
      "My voice rises and falls as I speak, so please learn its natural rhythm, pace, and tone. "
      "Please remember my voice exactly as it sounds right now — naturally, clearly, and in my own way. "
      "Thank you for taking the time to learn how I speak, so you can recognise me whenever I come back.";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Wire the live custom-voice push so processing progress / score / terminal
    // state arrive in real time when a voice call is active in the background.
    try {
      final getIt = GetIt.I;
      if (getIt.isRegistered<VoiceSessionCubit>()) {
        _voiceSession = getIt<VoiceSessionCubit>();
        _voiceSession!.customVoiceLive.addListener(_onLiveCustomVoiceState);
      }
    } catch (_) {}

    // Check if cloning is already in progress
    _checkExistingCloningStatus();
  }

  /// React to a `custom_voice_state` push from the active voice session.
  void _onLiveCustomVoiceState() {
    final live = _voiceSession?.customVoiceLive.value;
    if (live == null || !mounted || _disposed) return;

    // Keep score/progress fresh whatever step we're on.
    if (live.score != null) _score = live.score;
    if (live.progress != null) _processingProgress = live.progress;

    // Only let a push DRIVE the terminal transition while we're waiting (upload
    // /processing). On intro/recording we don't want a stray push to yank the UI.
    if (_step == _CloningStep.uploading || _step == _CloningStep.success) {
      if (live.status == 'ready') {
        _pendingPollTimer?.cancel();
        setState(() {
          _resultStatus = 'ready';
          _processingProgress = 100;
          _step = _CloningStep.success;
        });
        return;
      }
      if (live.status == 'failed') {
        _pendingPollTimer?.cancel();
        setState(() {
          _step = _CloningStep.error;
          _errorMessage = live.error?.isNotEmpty == true
              ? _friendlyError(live.error!)
              : 'Voice cloning failed. Please try again.';
        });
        return;
      }
    }
    setState(() {}); // refresh progress/score chips
  }

  Future<void> _checkExistingCloningStatus() async {
    try {
      final secureStorage = GetIt.I<SecureStorageService>();
      final userId = await secureStorage.getUserId();
      final token = await secureStorage.getAccessToken();
      if (userId == null || userId.isEmpty || token == null) return;

      final response = await http.get(
        Uri.parse('$_voiceGatewayUrl/voice/clone/status/$userId'),
        headers: {'Authorization': 'Bearer $token'},
      ).timeout(const Duration(seconds: 10));

      if (!mounted || _disposed) return;
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final status = data['custom_voice_status'] as String? ?? 'none';
        if (status == 'pending') {
          setState(() {
            _step = _CloningStep.uploading;
            _uploadStatus = 'Voice cloning is in progress...';
            _processingProgress = _readProgress(data);
            _score = _readScore(data);
          });
          _startPendingStatusPoll();
        }
      }
    } catch (_) {
      // Non-critical — proceed with intro
    }
  }

  int? _readProgress(Map<String, dynamic> data) {
    final v = data['custom_voice_progress'];
    return v is num ? v.toInt() : null;
  }

  double? _readScore(Map<String, dynamic> data) {
    final v = data['custom_voice_score'];
    return v is num ? v.toDouble() : null;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused && _isRecording) {
      _pauseRecording();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    WidgetsBinding.instance.removeObserver(this);
    _durationTimer?.cancel();
    _amplitudeTimer?.cancel();
    _pendingPollTimer?.cancel();
    _pulseController.dispose();
    _recorder.dispose();
    // Resume the background voice session if we paused it (no-op if no session).
    _resumeSessionIfPaused();
    // removeListener can touch an already-disposed ValueNotifier if the cubit
    // closed before this screen — guard it.
    try {
      _voiceSession?.customVoiceLive.removeListener(_onLiveCustomVoiceState);
    } catch (_) {}
    // Always best-effort delete the temp recording file. The backend already
    // has the bytes (the upload reads + uploads its own copy), so a leftover
    // temp WAV serves no purpose — deleting it even mid-upload prevents the
    // file accumulating on disk across retakes / backgrounded uploads.
    if (_recordingPath != null) {
      File(_recordingPath!).delete().catchError((_) => File(''));
    }
    super.dispose();
  }

  /// Pause the live voice call (if any) while the user records their sample so
  /// the agent's mic and the recorder don't fight. No-op without a session.
  void _pauseSessionForSetup() {
    if (_sessionPaused) return;
    final session = _voiceSession;
    if (session == null || !session.hasActiveVoiceSession) return;
    _sessionPaused = true;
    session.notifyCustomVoiceSetupStarted();
  }

  /// Resume the live voice call after setup finishes / cancels / is left.
  void _resumeSessionIfPaused() {
    if (!_sessionPaused) return;
    _sessionPaused = false;
    _voiceSession?.notifyCustomVoiceSetupFinished();
  }

  Future<void> _startRecording() async {
    if (_isStartingRecording || _isRecording) return; // Double-tap guard
    _isStartingRecording = true;

    // Whether the start path successfully handed off to the recording timers.
    // We only KEEP the guard set on success; every early-return / error path
    // resets it in the finally so the Start button can never stay permanently
    // disabled (e.g. a denied-then-granted retry, or a thrown setup step).
    bool startedRecording = false;
    try {
      final micStatus = await Permission.microphone.request();
      if (!micStatus.isGranted) {
        if (mounted && !_disposed) {
          final isPermanentlyDenied =
              await Permission.microphone.isPermanentlyDenied;
          setState(() {
            _step = _CloningStep.error;
            _errorMessage = isPermanentlyDenied
                ? 'Microphone permission was denied. Please enable it in your device settings.'
                : 'Microphone permission is required for voice cloning.';
          });
        }
        return;
      }

      // Pause any live voice call before we grab the mic.
      _pauseSessionForSetup();

      // Generate file path
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      _recordingPath = '${tempDir.path}/voice_clone_$timestamp.wav';

      await _recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.wav,
          sampleRate: 16000,
          numChannels: 1,
        ),
        path: _recordingPath!,
      );

      startedRecording = true;
      _isStartingRecording = false;
      setState(() {
        _step = _CloningStep.recording;
        _isRecording = true;
        _isPaused = false;
        _recordingSeconds = 0;
      });

      _pulseController.repeat(reverse: true);

      // Duration timer
      _durationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!_isRecording || _isPaused || _disposed) {
          if (_disposed) timer.cancel();
          return;
        }
        setState(() => _recordingSeconds++);

        // Auto-stop at max duration
        if (_recordingSeconds >= _maxDurationSeconds) {
          _stopAndUpload();
        }
      });

      // Amplitude monitoring
      _amplitudeTimer = Timer.periodic(
        const Duration(milliseconds: 100),
        (timer) async {
          if (!_isRecording || _isPaused) return;
          try {
            if (await _recorder.isRecording()) {
              final amplitude = await _recorder.getAmplitude();
              final normalized = _normalizeAmplitude(amplitude.current);
              if (mounted) setState(() => _currentAmplitude = normalized);
            }
          } catch (_) {}
        },
      );
    } catch (e) {
      if (mounted && !_disposed) {
        setState(() {
          _step = _CloningStep.error;
          _errorMessage = 'Failed to start recording: $e';
        });
      }
    } finally {
      // Always release the double-tap guard unless we actually entered the
      // recording state. This prevents a permanent button lockout when the
      // start path returns early (permission denied) or throws (temp dir / mic
      // start) — the user can retry without leaving and re-entering the screen.
      if (!startedRecording) _isStartingRecording = false;
    }
  }

  double _normalizeAmplitude(double amplitude) {
    final normalized = (amplitude - (-60.0)) / (0.0 - (-60.0));
    return normalized.clamp(0.0, 1.0);
  }

  Future<void> _pauseRecording() async {
    if (!_isRecording || _isPaused) return;
    try {
      await _recorder.pause();
      setState(() => _isPaused = true);
      _pulseController.stop();
    } catch (_) {}
  }

  Future<void> _resumeRecording() async {
    if (!_isRecording || !_isPaused) return;
    try {
      await _recorder.resume();
      setState(() => _isPaused = false);
      _pulseController.repeat(reverse: true);
    } catch (_) {}
  }

  Future<void> _stopAndUpload() async {
    if (!_isRecording || _isUploading) return;
    _isRecording = false;
    _durationTimer?.cancel();
    _amplitudeTimer?.cancel();
    _pulseController.stop();

    try {
      final path = await _recorder.stop();
      final filePath = path ?? _recordingPath;

      if (filePath == null || filePath.isEmpty) {
        if (mounted && !_disposed) {
          setState(() {
            _step = _CloningStep.error;
            _errorMessage = 'Recording failed. Please try again.';
          });
        }
        return;
      }

      final file = File(filePath);
      if (!await file.exists()) {
        if (mounted && !_disposed) {
          setState(() {
            _step = _CloningStep.error;
            _errorMessage = 'Recording file not found. Please try again.';
          });
        }
        return;
      }

      final fileSize = await file.length();
      if (fileSize < 30000) {
        if (mounted && !_disposed) {
          setState(() {
            _step = _CloningStep.error;
            _errorMessage =
                'Recording too short. Please read the full script (at least $_minDurationSeconds seconds).';
          });
        }
        return;
      }

      if (fileSize > _maxAudioSizeBytes) {
        if (mounted && !_disposed) {
          setState(() {
            _step = _CloningStep.error;
            _errorMessage =
                'Recording too large. Please try again with a shorter recording.';
          });
        }
        return;
      }

      if (mounted && !_disposed) {
        setState(() {
          _step = _CloningStep.uploading;
          _uploadStatus = 'Preparing audio...';
          _processingProgress = null;
        });
      }

      await _uploadForCloning(file);
    } catch (e) {
      if (mounted && !_disposed) {
        setState(() {
          _step = _CloningStep.error;
          _errorMessage = 'Error processing recording: $e';
        });
      }
    }
  }

  Future<void> _uploadForCloning(File audioFile) async {
    if (_isUploading) return; // Prevent concurrent uploads
    _isUploading = true;

    try {
      // Get auth token
      final secureStorage = GetIt.I<SecureStorageService>();
      final token = await secureStorage.getAccessToken();
      final userId = await secureStorage.getUserId();

      if (token == null || token.isEmpty || userId == null || userId.isEmpty) {
        if (mounted && !_disposed) {
          setState(() {
            _step = _CloningStep.error;
            _errorMessage = 'Authentication error. Please log in again.';
          });
        }
        return;
      }

      if (mounted && !_disposed) {
        setState(() => _uploadStatus = 'Reading audio file...');
      }

      // Read file and encode as base64
      final audioBytes = await audioFile.readAsBytes();
      final audioB64 = base64Encode(audioBytes);

      if (mounted && !_disposed) {
        setState(() => _uploadStatus = 'Uploading to cloning service...');
      }

      final response = await http.post(
        Uri.parse('$_voiceGatewayUrl/voice/clone/upload'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'user_id': userId,
          'audio_data': audioB64,
          'sample_rate': 16000,
          'duration_seconds': _recordingSeconds,
        }),
      ).timeout(const Duration(seconds: 120)); // 2 min for slow networks

      if (!mounted || _disposed) return;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final status = data['status'] as String? ?? '';
        // Readiness score (0-1) from the upload response.
        final rawScore = data['score'];
        if (rawScore is num) _score = rawScore.toDouble();

        if (status == 'ready') {
          setState(() {
            _resultStatus = 'ready';
            _processingProgress = 100;
            _step = _CloningStep.success;
          });
        } else if (status == 'pending') {
          setState(() {
            _resultStatus = 'pending';
            _step = _CloningStep.success;
          });
        } else {
          setState(() {
            _step = _CloningStep.error;
            _errorMessage = data['error'] as String? ??
                'Voice cloning failed. Please try again.';
          });
        }
      } else if (response.statusCode == 409) {
        if (mounted && !_disposed) {
          setState(() {
            _step = _CloningStep.error;
            _errorMessage =
                'Voice cloning is already in progress. Please wait for it to complete.';
          });
        }
      } else if (response.statusCode == 429) {
        if (mounted && !_disposed) {
          setState(() {
            _step = _CloningStep.error;
            _errorMessage =
                'Too many requests. Please wait a moment and try again.';
          });
        }
      } else {
        final errorBody = response.body;
        String errorMsg = 'Server error (${response.statusCode})';
        try {
          final data = jsonDecode(errorBody);
          errorMsg = data['detail'] as String? ?? errorMsg;
        } catch (_) {}

        if (mounted && !_disposed) {
          setState(() {
            _step = _CloningStep.error;
            _errorMessage = errorMsg;
          });
        }
      }
    } on TimeoutException {
      if (mounted && !_disposed) {
        setState(() {
          _step = _CloningStep.error;
          _errorMessage =
              'Upload timed out. Please check your connection and try again.';
        });
      }
    } on SocketException {
      if (mounted && !_disposed) {
        setState(() {
          _step = _CloningStep.error;
          _errorMessage = 'Network error. Please check your internet connection.';
        });
      }
    } catch (e) {
      if (mounted && !_disposed) {
        setState(() {
          _step = _CloningStep.error;
          _errorMessage = 'Upload failed: $e';
        });
      }
    } finally {
      _isUploading = false;
      // Clean up temp file
      try {
        await audioFile.delete();
      } catch (_) {}
      _recordingPath = null;
    }
  }

  /// Poll for cloning status when result is "pending" (async provider).
  /// Acts as a FALLBACK to the live `custom_voice_state` WS push — the push
  /// resolves faster when a call is active; the poll covers the no-session case.
  void _startPendingStatusPoll() {
    _pendingPollTimer?.cancel();
    int polls = 0;
    const maxPolls = 30; // 5 min max (10s intervals)
    _pendingPollTimer =
        Timer.periodic(const Duration(seconds: 10), (timer) async {
      if (_disposed ||
          !mounted ||
          _step != _CloningStep.success && _step != _CloningStep.uploading) {
        timer.cancel();
        return;
      }
      polls++;
      if (polls > maxPolls) {
        timer.cancel();
        return;
      }

      try {
        final secureStorage = GetIt.I<SecureStorageService>();
        final userId = await secureStorage.getUserId();
        final token = await secureStorage.getAccessToken();
        if (userId == null || token == null) return;

        final response = await http.get(
          Uri.parse('$_voiceGatewayUrl/voice/clone/status/$userId'),
          headers: {'Authorization': 'Bearer $token'},
        ).timeout(const Duration(seconds: 10));

        if (!mounted || _disposed) return;
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final status = data['custom_voice_status'] as String? ?? 'none';
          final prog = _readProgress(data);
          final score = _readScore(data);
          if (status == 'ready') {
            timer.cancel();
            setState(() {
              _resultStatus = 'ready';
              _processingProgress = 100;
              if (score != null) _score = score;
              _step = _CloningStep.success;
            });
          } else if (status == 'failed') {
            timer.cancel();
            setState(() {
              _step = _CloningStep.error;
              _errorMessage = _friendlyError(
                  data['custom_voice_error'] as String? ?? '');
            });
          } else {
            // still pending — reflect progress/score
            setState(() {
              if (prog != null) _processingProgress = prog;
              if (score != null) _score = score;
            });
          }
        }
      } catch (_) {
        // Silent — keep polling
      }
    });
  }

  String _friendlyError(String rawError) {
    if (rawError.contains('paid_plan_required') ||
        rawError.contains('payment_required')) {
      return 'Voice cloning requires a premium provider plan. Please try again later.';
    }
    if (rawError.contains('rate_limit') || rawError.contains('429')) {
      return 'Provider rate limited. Please try again in a moment.';
    }
    if (rawError.contains('timeout') || rawError.contains('unavailable')) {
      return 'Provider temporarily unavailable. Tap Retake to try again.';
    }
    return rawError.isNotEmpty
        ? 'Cloning failed. Tap Retake to record again.'
        : 'Voice cloning encountered an error.';
  }

  void _cancelRecording() async {
    _isRecording = false;
    _isPaused = false;
    _durationTimer?.cancel();
    _amplitudeTimer?.cancel();
    _pulseController.stop();
    try {
      if (await _recorder.isRecording()) {
        await _recorder.stop();
      }
    } catch (_) {}
    // Clean up
    if (_recordingPath != null) {
      try {
        await File(_recordingPath!).delete();
      } catch (_) {}
      _recordingPath = null;
    }
    // Cancelling the capture finishes the setup interaction — resume the call.
    _resumeSessionIfPaused();
    if (mounted) setState(() => _step = _CloningStep.intro);
  }

  /// Restart the whole capture flow (used by both the error "Retake" and the
  /// success "Retake" buttons). The backend replaces the prior clone on the next
  /// upload, so re-recording is always safe.
  void _retake() {
    _pendingPollTimer?.cancel();
    _pendingPollTimer = null;
    setState(() {
      _step = _CloningStep.intro;
      _recordingSeconds = 0;
      _currentAmplitude = 0.0;
      _errorMessage = null;
      _resultStatus = null;
      _score = null;
      _processingProgress = null;
      _isUploading = false;
      _isStartingRecording = false;
    });
  }

  // ── Progress model (drives the stage progress bar) ──────────────────────────

  /// Overall setup progress 0.0-1.0 across stages:
  /// recording (0-40%) → uploading (40-65%) → processing (65-99%) → ready (100%).
  double get _overallProgress {
    switch (_step) {
      case _CloningStep.intro:
        return 0.0;
      case _CloningStep.recording:
        final r = (_recordingSeconds / _targetDurationSeconds).clamp(0.0, 1.0);
        return r * 0.40;
      case _CloningStep.uploading:
        // If we have a processing progress from the provider, map it into 65-99%.
        if (_processingProgress != null) {
          return 0.65 + (_processingProgress!.clamp(0, 100) / 100) * 0.34;
        }
        return 0.55; // mid-upload
      case _CloningStep.success:
        return _resultStatus == 'ready' ? 1.0 : 0.85;
      case _CloningStep.error:
        return 0.0;
    }
  }

  String get _stageLabel {
    switch (_step) {
      case _CloningStep.intro:
        return 'Ready';
      case _CloningStep.recording:
        return 'Recording';
      case _CloningStep.uploading:
        return _processingProgress != null ? 'Processing' : 'Uploading';
      case _CloningStep.success:
        return _resultStatus == 'ready' ? 'Ready' : 'Processing';
      case _CloningStep.error:
        return 'Failed';
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isRecording && !_isUploading,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          // Leaving the screen — make sure a paused call resumes.
          _resumeSessionIfPaused();
          return;
        }
        if (_isRecording) {
          _showExitConfirmation(popScreen: true);
        } else if (_isUploading) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please wait for upload to complete.'),
              duration: Duration(seconds: 2),
              backgroundColor: Color(0xFFFB923C),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              if (_isRecording) {
                _showExitConfirmation(popScreen: true);
              } else if (_isUploading) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please wait for upload to complete.'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Color(0xFFFB923C),
                  ),
                );
              } else {
                _resumeSessionIfPaused();
                Navigator.pop(context, _resultStatus == 'ready');
              }
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: Text(
            'Voice Cloning',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: switch (_step) {
            _CloningStep.intro => _buildIntroView(),
            _CloningStep.recording => _buildRecordingView(),
            _CloningStep.uploading => _buildUploadingView(),
            _CloningStep.success => _buildSuccessView(),
            _CloningStep.error => _buildErrorView(),
          },
        ),
      ),
    );
  }

  /// Compact stage progress bar shown across recording/upload/processing.
  Widget _buildStageProgress() {
    final pct = (_overallProgress * 100).round();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _stageLabel,
              style: GoogleFonts.inter(
                color: const Color(0xFF3B82F6),
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '$pct%',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: LinearProgressIndicator(
            value: _overallProgress == 0 ? null : _overallProgress,
            minHeight: 6.h,
            backgroundColor: const Color(0xFF2D2D2D),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
          ),
        ),
      ],
    );
  }

  Widget _buildIntroView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 28.h),

                  // Icon
                  Container(
                    width: 72.w,
                    height: 72.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6).withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.record_voice_over_rounded,
                      color: const Color(0xFF3B82F6),
                      size: 36.sp,
                    ),
                  ),

                  SizedBox(height: 20.h),

                  Text(
                    'Create Your Custom Voice',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 10.h),

                  Text(
                    'Read the short text below aloud, naturally. '
                    'It takes about 20 seconds.',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.55),
                      fontSize: 14.sp,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 24.h),

                  // The script to read — prominent.
                  Container(
                    padding: EdgeInsets.all(18.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.menu_book_rounded,
                              color: const Color(0xFF3B82F6),
                              size: 18.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Read the text below',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF3B82F6),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          _readingScript,
                          style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.92),
                            fontSize: 16.sp,
                            height: 1.6,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Tips (compact)
                  _buildTipCard(
                    Icons.mic_rounded,
                    'Find a quiet place',
                    'Background noise reduces cloning quality.',
                  ),
                  SizedBox(height: 10.h),
                  _buildTipCard(
                    Icons.chat_rounded,
                    'Speak naturally',
                    'Use your normal tone and pace. Don\'t rush.',
                  ),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),

          // Start button
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton.icon(
              onPressed: _isStartingRecording ? null : _startRecording,
              icon: _isStartingRecording
                  ? LazerVaultLoader.small()
                  : Icon(Icons.mic_rounded, size: 22.sp),
              label: Text(
                _isStartingRecording ? 'Preparing...' : 'Start Reading',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                disabledBackgroundColor:
                    const Color(0xFF3B82F6).withValues(alpha: 0.5),
                disabledForegroundColor: Colors.white70,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                elevation: 0,
              ),
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildTipCard(IconData icon, String title, String desc) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: const Color(0xFF9CA3AF), size: 18.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  desc,
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.4),
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordingView() {
    final isMinReached = _recordingSeconds >= _minDurationSeconds;
    final targetReached = _recordingSeconds >= _targetDurationSeconds;
    // Progress bar runs toward the ~20s target (not the hard max) so the user
    // has a clear "done enough" goal.
    final progress =
        (_recordingSeconds / _targetDurationSeconds).clamp(0.0, 1.0);
    final minutes = _recordingSeconds ~/ 60;
    final seconds = _recordingSeconds % 60;
    final timeStr =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          SizedBox(height: 12.h),

          // Always-visible script so the user reads while recording.
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.menu_book_rounded,
                        color: const Color(0xFF3B82F6), size: 16.sp),
                    SizedBox(width: 6.w),
                    Text(
                      'Read this aloud',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF3B82F6),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  _readingScript,
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.88),
                    fontSize: 14.sp,
                    height: 1.55,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          // Animated recording indicator
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              final scale =
                  1.0 + (_pulseController.value * 0.15 * _currentAmplitude);
              return Transform.scale(
                scale: _isPaused ? 1.0 : scale,
                child: Container(
                  width: 120.w,
                  height: 120.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isPaused
                        ? const Color(0xFFFB923C).withValues(alpha: 0.1)
                        : const Color(0xFFEF4444)
                            .withValues(alpha: 0.08 + (_currentAmplitude * 0.12)),
                    border: Border.all(
                      color: _isPaused
                          ? const Color(0xFFFB923C).withValues(alpha: 0.4)
                          : const Color(0xFFEF4444)
                              .withValues(alpha: 0.3 + (_currentAmplitude * 0.4)),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    _isPaused ? Icons.pause_rounded : Icons.mic_rounded,
                    color: _isPaused
                        ? const Color(0xFFFB923C)
                        : const Color(0xFFEF4444),
                    size: 48.sp,
                  ),
                ),
              );
            },
          ),

          SizedBox(height: 20.h),

          // Timer
          Text(
            timeStr,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 44.sp,
              fontWeight: FontWeight.w300,
              letterSpacing: 2,
            ),
          ),

          SizedBox(height: 6.h),

          Text(
            _isPaused
                ? 'Paused'
                : targetReached
                    ? 'Great — you can finish now, or keep reading.'
                    : isMinReached
                        ? 'Good. Keep reading to the end of the text.'
                        : 'Keep reading... ${_minDurationSeconds - _recordingSeconds}s until minimum',
            style: GoogleFonts.inter(
              color: targetReached
                  ? const Color(0xFF10B981)
                  : Colors.white.withValues(alpha: 0.5),
              fontSize: 13.sp,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 18.h),

          // Progress bar toward target
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6.h,
              backgroundColor: const Color(0xFF2D2D2D),
              valueColor: AlwaysStoppedAnimation<Color>(
                targetReached
                    ? const Color(0xFF10B981)
                    : const Color(0xFF3B82F6),
              ),
            ),
          ),

          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_minDurationSeconds}s min',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.3),
                  fontSize: 11.sp,
                ),
              ),
              Text(
                '~${_targetDurationSeconds}s target',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.3),
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),

          const Spacer(),

          // Control buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildControlButton(
                icon: Icons.close_rounded,
                label: 'Cancel',
                color: const Color(0xFF9CA3AF),
                onTap: _cancelRecording,
              ),
              SizedBox(width: 24.w),
              _buildControlButton(
                icon: _isPaused
                    ? Icons.play_arrow_rounded
                    : Icons.pause_rounded,
                label: _isPaused ? 'Resume' : 'Pause',
                color: const Color(0xFFFB923C),
                onTap: _isPaused ? _resumeRecording : _pauseRecording,
              ),
              SizedBox(width: 24.w),
              _buildControlButton(
                icon: Icons.check_rounded,
                label: 'Done',
                color: isMinReached
                    ? const Color(0xFF10B981)
                    : const Color(0xFF9CA3AF).withValues(alpha: 0.3),
                onTap: isMinReached ? _stopAndUpload : null,
              ),
            ],
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: onTap != null ? 0.15 : 0.05),
              border: Border.all(
                color: color.withValues(alpha: onTap != null ? 0.3 : 0.1),
              ),
            ),
            child: Icon(
              icon,
              color: color.withValues(alpha: onTap != null ? 1.0 : 0.3),
              size: 26.sp,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            label,
            style: GoogleFonts.inter(
              color: color.withValues(alpha: onTap != null ? 0.7 : 0.2),
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadingView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LazerVaultLoader(size: 64),
            SizedBox(height: 32.h),
            Text(
              'Creating Your Voice',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              _processingProgress != null
                  ? 'Processing your voice... $_processingProgress%'
                  : _uploadStatus,
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            // Stage progress bar
            _buildStageProgress(),
            if (_score != null) ...[
              SizedBox(height: 16.h),
              _buildScoreChip(),
            ],
            SizedBox(height: 16.h),
            Text(
              'This may take up to a minute...',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.3),
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Quality / readiness chip from the 0-1 score.
  Widget _buildScoreChip() {
    final score = _score;
    if (score == null) return const SizedBox.shrink();
    final pct = (score * 100).round();
    Color color;
    String label;
    IconData icon;
    if (score >= 0.8) {
      color = const Color(0xFF10B981);
      label = 'Good';
      icon = Icons.check_circle_rounded;
    } else if (score >= 0.6) {
      color = const Color(0xFFFB923C);
      label = 'Fair';
      icon = Icons.info_rounded;
    } else {
      color = const Color(0xFFEF4444);
      label = 'Poor';
      icon = Icons.warning_rounded;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16.sp),
          SizedBox(width: 8.w),
          Text(
            'Voice quality: $label ($pct%)',
            style: GoogleFonts.inter(
              color: color,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessView() {
    final isReady = _resultStatus == 'ready';
    final isPending = _resultStatus == 'pending';

    // Start polling if pending (fallback to the live WS push).
    if (isPending && _pendingPollTimer == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _startPendingStatusPoll();
      });
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: (isReady
                      ? const Color(0xFF10B981)
                      : const Color(0xFF3B82F6))
                  .withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: isPending
                ? Padding(
                    padding: EdgeInsets.all(18.w),
                    child: LazerVaultLoader.small(),
                  )
                : Icon(
                    Icons.check_circle_rounded,
                    color: const Color(0xFF10B981),
                    size: 48.sp,
                  ),
          ),
          SizedBox(height: 24.h),
          Text(
            isReady ? 'Custom Voice Created!' : 'Voice Submitted!',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            isReady
                ? 'Your AI assistant will now respond using your cloned voice. '
                    'You can manage this in Voice Settings.'
                : 'Your voice recording has been submitted for cloning. '
                    'This may take a few minutes. You can check the status in Voice Settings.',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.55),
              fontSize: 14.sp,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          if (isPending && _processingProgress != null) ...[
            SizedBox(height: 20.h),
            _buildStageProgress(),
          ],
          if (_score != null) ...[
            SizedBox(height: 16.h),
            _buildScoreChip(),
          ],
          SizedBox(height: 36.h),
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: () {
                _resumeSessionIfPaused();
                Navigator.pop(context, isReady);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isReady ? const Color(0xFF10B981) : const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Done',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          // Retake on the ready/submitted state too — re-records and replaces.
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: OutlinedButton.icon(
              onPressed: _retake,
              icon: Icon(Icons.refresh_rounded, size: 18.sp),
              label: Text(
                'Retake Recording',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white.withValues(alpha: 0.8),
                side: BorderSide(
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444).withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.error_outline_rounded,
              color: const Color(0xFFEF4444),
              size: 48.sp,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'Voice Cloning Failed',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            _errorMessage ?? 'An unexpected error occurred.',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.55),
              fontSize: 14.sp,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40.h),
          // Retake — the primary recovery action.
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton.icon(
              onPressed: _retake,
              icon: Icon(Icons.refresh_rounded, size: 20.sp),
              label: Text(
                'Retake Recording',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                elevation: 0,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          TextButton(
            onPressed: () {
              _resumeSessionIfPaused();
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showExitConfirmation({bool popScreen = false}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(
          'Stop Recording?',
          style: GoogleFonts.inter(
              color: Colors.white, fontWeight: FontWeight.w600),
        ),
        content: Text(
          popScreen
              ? 'Your recording will be discarded and you will leave this screen.'
              : 'Your recording will be discarded.',
          style: GoogleFonts.inter(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Continue Recording',
                style: GoogleFonts.inter(color: const Color(0xFF3B82F6))),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx); // Close dialog
              _cancelRecording();
              if (popScreen && mounted) {
                Navigator.pop(context);
              }
            },
            child: Text(
              popScreen ? 'Discard & Leave' : 'Discard',
              style: GoogleFonts.inter(color: const Color(0xFFEF4444)),
            ),
          ),
        ],
      ),
    );
  }
}
