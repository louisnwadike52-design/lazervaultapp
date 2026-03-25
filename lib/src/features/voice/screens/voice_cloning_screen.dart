import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:get_it/get_it.dart';

/// Dedicated voice cloning recording screen.
///
/// Records 30-60 seconds of natural speech for high-quality voice cloning.
/// This is separate from voice enrollment (biometrics) which uses short
/// scripted phrases for identity verification.
///
/// ElevenLabs IVC recommends 20-90 seconds of clean speech for quality cloning.
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

  // Upload progress
  String _uploadStatus = '';

  static const int _minDurationSeconds = 30;
  static const int _maxDurationSeconds = 60;
  static const int _maxAudioSizeBytes = 10 * 1024 * 1024; // 10MB safety limit

  late AnimationController _pulseController;

  String get _voiceGatewayUrl =>
      dotenv.env['VOICE_AGENT_GATEWAY_URL'] ?? 'http://localhost:3010';

  // Reading prompts to guide natural speech
  static const List<String> _readingPrompts = [
    "Tell me about your favorite childhood memory. Describe the place, the people, and how it made you feel.",
    "Describe your ideal weekend from start to finish. What activities would you do and where would you go?",
    "Talk about a skill or hobby you're passionate about. How did you get started and what do you enjoy most?",
    "Imagine explaining your job to a curious child. How would you describe what you do every day?",
    "Share a story about a trip or adventure you've been on. What surprised you most about it?",
  ];

  late String _selectedPrompt;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Pick a random prompt
    _selectedPrompt = _readingPrompts[Random().nextInt(_readingPrompts.length)];

    // Check if cloning is already in progress
    _checkExistingCloningStatus();
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
          });
          _startPendingStatusPoll();
        }
      }
    } catch (_) {
      // Non-critical — proceed with intro
    }
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
    // Clean up temp file only if not uploading
    if (_recordingPath != null && !_isUploading) {
      File(_recordingPath!).delete().catchError((_) => File(''));
    }
    super.dispose();
  }

  Future<void> _startRecording() async {
    if (_isStartingRecording || _isRecording) return; // Double-tap guard
    _isStartingRecording = true;

    final micStatus = await Permission.microphone.request();
    if (!micStatus.isGranted) {
      _isStartingRecording = false;
      if (mounted && !_disposed) {
        // Check if permanently denied and guide user to settings
        final isPermanentlyDenied = await Permission.microphone.isPermanentlyDenied;
        setState(() {
          _step = _CloningStep.error;
          _errorMessage = isPermanentlyDenied
              ? 'Microphone permission was denied. Please enable it in your device settings.'
              : 'Microphone permission is required for voice cloning.';
        });
      }
      return;
    }

    // Generate file path
    final tempDir = await getTemporaryDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    _recordingPath = '${tempDir.path}/voice_clone_$timestamp.wav';

    try {
      await _recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.wav,
          sampleRate: 16000,
          numChannels: 1,
        ),
        path: _recordingPath!,
      );

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
      _isStartingRecording = false;
      if (mounted && !_disposed) {
        setState(() {
          _step = _CloningStep.error;
          _errorMessage = 'Failed to start recording: $e';
        });
      }
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
      if (fileSize < 50000) {
        if (mounted && !_disposed) {
          setState(() {
            _step = _CloningStep.error;
            _errorMessage =
                'Recording too short. Please record at least $_minDurationSeconds seconds.';
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
      ).timeout(const Duration(seconds: 120)); // 2 min for slow networks + cloning time

      if (!mounted || _disposed) return;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final status = data['status'] as String? ?? '';

        if (status == 'ready') {
          setState(() {
            _resultStatus = 'ready';
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
            _errorMessage = data['error'] as String? ?? 'Voice cloning failed. Please try again.';
          });
        }
      } else if (response.statusCode == 409) {
        // Concurrent cloning in progress
        if (mounted && !_disposed) {
          setState(() {
            _step = _CloningStep.error;
            _errorMessage = 'Voice cloning is already in progress. Please wait for it to complete.';
          });
        }
      } else if (response.statusCode == 429) {
        if (mounted && !_disposed) {
          setState(() {
            _step = _CloningStep.error;
            _errorMessage = 'Too many requests. Please wait a moment and try again.';
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
          _errorMessage = 'Upload timed out. Please check your connection and try again.';
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

  /// Poll for cloning status when result is "pending" (async provider like Qwen3)
  void _startPendingStatusPoll() {
    _pendingPollTimer?.cancel();
    int polls = 0;
    const maxPolls = 30; // 5 min max (10s intervals)
    _pendingPollTimer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      if (_disposed || !mounted || _step != _CloningStep.success && _step != _CloningStep.uploading) {
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
          if (status == 'ready') {
            timer.cancel();
            setState(() {
              _resultStatus = 'ready';
              _step = _CloningStep.success;
            });
          } else if (status == 'failed') {
            timer.cancel();
            setState(() {
              _step = _CloningStep.error;
              _errorMessage = data['custom_voice_error'] as String? ?? 'Voice cloning failed.';
            });
          }
        }
      } catch (_) {
        // Silent — keep polling
      }
    });
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
    if (mounted) setState(() => _step = _CloningStep.intro);
  }

  void _retry() {
    _pendingPollTimer?.cancel();
    _pendingPollTimer = null;
    setState(() {
      _step = _CloningStep.intro;
      _recordingSeconds = 0;
      _currentAmplitude = 0.0;
      _errorMessage = null;
      _resultStatus = null;
      _isUploading = false;
      _isStartingRecording = false;
      _selectedPrompt = _readingPrompts[Random().nextInt(_readingPrompts.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isRecording && !_isUploading,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        if (_isRecording) {
          _showExitConfirmation(popScreen: true);
        } else if (_isUploading) {
          // Don't allow back during upload
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

  Widget _buildIntroView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 32.h),

                  // Icon
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6).withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.record_voice_over_rounded,
                      color: const Color(0xFF3B82F6),
                      size: 40.sp,
                    ),
                  ),

                  SizedBox(height: 24.h),

                  Text(
                    'Create Your Custom Voice',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 12.h),

                  Text(
                    'Record 30-60 seconds of natural speech so the AI assistant '
                    'can respond in your own voice.',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.55),
                      fontSize: 14.sp,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 32.h),

                  // Tips
                  _buildTipCard(
                    Icons.mic_rounded,
                    'Find a quiet place',
                    'Background noise reduces cloning quality.',
                  ),
                  SizedBox(height: 10.h),
                  _buildTipCard(
                    Icons.chat_rounded,
                    'Speak naturally',
                    'Use your normal tone and pace. Avoid whispering or shouting.',
                  ),
                  SizedBox(height: 10.h),
                  _buildTipCard(
                    Icons.timer_rounded,
                    'Record at least 30 seconds',
                    'Longer recordings produce better voice quality.',
                  ),

                  SizedBox(height: 32.h),

                  // Reading prompt
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.format_quote_rounded,
                              color: const Color(0xFF3B82F6),
                              size: 18.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Suggested topic',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF3B82F6),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          _selectedPrompt,
                          style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.75),
                            fontSize: 14.sp,
                            height: 1.5,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
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
                  ? SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Icon(Icons.mic_rounded, size: 22.sp),
              label: Text(
                _isStartingRecording ? 'Preparing...' : 'Start Recording',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                disabledBackgroundColor: const Color(0xFF3B82F6).withValues(alpha: 0.5),
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
    final progress = _recordingSeconds / _maxDurationSeconds;
    final minutes = _recordingSeconds ~/ 60;
    final seconds = _recordingSeconds % 60;
    final timeStr = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          const Spacer(),

          // Animated recording indicator
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              final scale = 1.0 + (_pulseController.value * 0.15 * _currentAmplitude);
              return Transform.scale(
                scale: _isPaused ? 1.0 : scale,
                child: Container(
                  width: 140.w,
                  height: 140.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isPaused
                        ? const Color(0xFFFB923C).withValues(alpha: 0.1)
                        : const Color(0xFFEF4444).withValues(alpha: 0.08 + (_currentAmplitude * 0.12)),
                    border: Border.all(
                      color: _isPaused
                          ? const Color(0xFFFB923C).withValues(alpha: 0.4)
                          : const Color(0xFFEF4444).withValues(alpha: 0.3 + (_currentAmplitude * 0.4)),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    _isPaused ? Icons.pause_rounded : Icons.mic_rounded,
                    color: _isPaused ? const Color(0xFFFB923C) : const Color(0xFFEF4444),
                    size: 56.sp,
                  ),
                ),
              );
            },
          ),

          SizedBox(height: 32.h),

          // Timer
          Text(
            timeStr,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 48.sp,
              fontWeight: FontWeight.w300,
              letterSpacing: 2,
            ),
          ),

          SizedBox(height: 8.h),

          Text(
            _isPaused
                ? 'Paused'
                : isMinReached
                    ? 'Minimum reached! Keep going for better quality.'
                    : 'Keep speaking... ${_minDurationSeconds - _recordingSeconds}s until minimum',
            style: GoogleFonts.inter(
              color: isMinReached
                  ? const Color(0xFF10B981)
                  : Colors.white.withValues(alpha: 0.5),
              fontSize: 13.sp,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 24.h),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6.h,
              backgroundColor: const Color(0xFF2D2D2D),
              valueColor: AlwaysStoppedAnimation<Color>(
                isMinReached ? const Color(0xFF10B981) : const Color(0xFF3B82F6),
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
                '${_maxDurationSeconds}s max',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.3),
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),

          const Spacer(),

          // Prompt reminder
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              _selectedPrompt,
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 12.sp,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          SizedBox(height: 24.h),

          // Control buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Cancel
              _buildControlButton(
                icon: Icons.close_rounded,
                label: 'Cancel',
                color: const Color(0xFF9CA3AF),
                onTap: _cancelRecording,
              ),
              SizedBox(width: 24.w),
              // Pause/Resume
              _buildControlButton(
                icon: _isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded,
                label: _isPaused ? 'Resume' : 'Pause',
                color: const Color(0xFFFB923C),
                onTap: _isPaused ? _resumeRecording : _pauseRecording,
              ),
              SizedBox(width: 24.w),
              // Done (only enabled after min duration)
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
            SizedBox(
              width: 64.w,
              height: 64.w,
              child: const CircularProgressIndicator(
                color: Color(0xFF3B82F6),
                strokeWidth: 3,
              ),
            ),
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
              _uploadStatus,
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
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

  Widget _buildSuccessView() {
    final isReady = _resultStatus == 'ready';
    final isPending = _resultStatus == 'pending';

    // Start polling if pending
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
              color: (isReady ? const Color(0xFF10B981) : const Color(0xFF3B82F6))
                  .withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: isPending
                ? Padding(
                    padding: EdgeInsets.all(18.w),
                    child: const CircularProgressIndicator(
                      color: Color(0xFF3B82F6),
                      strokeWidth: 3,
                    ),
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
          SizedBox(height: 40.h),
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context, isReady),
              style: ElevatedButton.styleFrom(
                backgroundColor: isReady ? const Color(0xFF10B981) : const Color(0xFF3B82F6),
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
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton.icon(
              onPressed: _retry,
              icon: Icon(Icons.refresh_rounded, size: 20.sp),
              label: Text(
                'Try Again',
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
            onPressed: () => Navigator.pop(context),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(
          'Stop Recording?',
          style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600),
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
            child: Text('Continue Recording', style: GoogleFonts.inter(color: const Color(0xFF3B82F6))),
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
