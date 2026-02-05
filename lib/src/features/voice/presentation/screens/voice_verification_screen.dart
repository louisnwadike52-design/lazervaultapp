import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:record/record.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../../../core/services/voice_biometrics_service.dart';

/// Voice Verification Screen - Verifies user's voice before allowing access
/// Production-ready with comprehensive error handling and retry mechanisms
class VoiceVerificationScreen extends StatefulWidget {
  final String userId;
  final VoidCallback? onVerificationSuccess;
  final VoidCallback? onEnrollmentRequired;

  const VoiceVerificationScreen({
    super.key,
    required this.userId,
    this.onVerificationSuccess,
    this.onEnrollmentRequired,
  });

  @override
  State<VoiceVerificationScreen> createState() => _VoiceVerificationScreenState();
}

class _VoiceVerificationScreenState extends State<VoiceVerificationScreen>
    with WidgetsBindingObserver {
  final VoiceBiometricsService _voiceService = GetIt.I<VoiceBiometricsService>();
  final AudioRecorder _recorder = AudioRecorder();
  final Connectivity _connectivity = Connectivity();

  static const int verificationDuration = 4;
  static const int maxRetries = 3;
  static const double verificationThreshold = 0.85;

  bool _isRecording = false;
  bool _isVerifying = false;
  bool _hasPermission = false;
  bool _permissionPermanentlyDenied = false;
  double _recordingProgress = 0.0;
  Timer? _recordingTimer;
  String? _currentRecordingPath;
  int _retryCount = 0;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initialize();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cleanup();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      if (_isRecording) {
        _cancelCurrentRecording();
      }
    }
  }

  Future<void> _initialize() async {
    try {
      await _checkAndRequestMicrophonePermission();
    } catch (e) {
      if (mounted) {
        _showError(_getErrorMessage(e));
      }
    }
  }

  Future<void> _checkAndRequestMicrophonePermission() async {
    try {
      final status = await Permission.microphone.status;

      if (status.isGranted) {
        setState(() {
          _hasPermission = true;
        });
        return;
      }

      if (status.isPermanentlyDenied) {
        setState(() {
          _permissionPermanentlyDenied = true;
          _hasPermission = false;
        });
        return;
      }

      final result = await Permission.microphone.request();

      if (result.isGranted) {
        setState(() {
          _hasPermission = true;
        });
      } else if (result.isPermanentlyDenied) {
        setState(() {
          _permissionPermanentlyDenied = true;
          _hasPermission = false;
        });
      } else {
        setState(() {
          _hasPermission = false;
        });
        _showError('Microphone permission is required for voice verification');
        _handleCancel();
      }
    } catch (e) {
      _showError('Failed to check microphone permission: ${_getErrorMessage(e)}');
      _handleCancel();
    }
  }

  Future<void> _recordAndVerify() async {
    if (_isRecording || _isVerifying || !_hasPermission) {
      return;
    }

    if (_retryCount >= maxRetries) {
      _showError('Maximum verification attempts reached. Please try again later.');
      await Future.delayed(const Duration(seconds: 2));
      _handleCancel();
      return;
    }

    setState(() {
      _isRecording = true;
      _recordingProgress = 0.0;
      _errorMessage = null;
    });

    try {
      if (!await _recorder.hasPermission()) {
        throw Exception('Microphone permission not granted');
      }

      if (!await _checkStorageSpace()) {
        throw Exception('Insufficient storage space');
      }

      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final recordingPath = '${tempDir.path}/voice_verify_$timestamp.wav';

      setState(() {
        _currentRecordingPath = recordingPath;
      });

      await _recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.wav,
          sampleRate: 16000,
          numChannels: 1,
          bitRate: 256000,
        ),
        path: recordingPath,
      );

      int tickCount = 0;
      const tickInterval = 100;
      final totalTicks = (verificationDuration * 1000) ~/ tickInterval;

      _recordingTimer = Timer.periodic(
        const Duration(milliseconds: tickInterval),
        (timer) {
          if (!mounted || !_isRecording) {
            timer.cancel();
            return;
          }

          tickCount++;
          setState(() {
            _recordingProgress = tickCount / totalTicks;
          });

          if (_recordingProgress >= 1.0) {
            timer.cancel();
            _stopRecordingAndVerify();
          }
        },
      );
    } catch (e) {
      _handleRecordingError(e);
    }
  }

  Future<void> _stopRecordingAndVerify() async {
    if (!_isRecording) return;

    _recordingTimer?.cancel();
    _recordingTimer = null;

    try {
      final path = await _recorder.stop();

      if (path == null || path.isEmpty) {
        throw Exception('Recording failed: no file path returned');
      }

      final audioData = await _readAndValidateAudioFile(path);

      if (audioData != null) {
        setState(() {
          _isRecording = false;
          _isVerifying = true;
          _recordingProgress = 0.0;
          _currentRecordingPath = null;
        });

        await _verifyVoice(audioData);
      } else {
        throw Exception('Invalid audio file recorded');
      }
    } catch (e) {
      _handleRecordingError(e);
    }
  }

  Future<void> _verifyVoice(Uint8List audioData) async {
    if (!await _checkNetworkConnectivity()) {
      setState(() {
        _isVerifying = false;
        _errorMessage = 'No internet connection. Please check your network and try again.';
      });
      return;
    }

    try {
      final result = await _voiceService.verifyVoice(
        userId: widget.userId,
        audioSample: audioData,
        threshold: verificationThreshold,
      );

      if (!mounted) return;

      setState(() {
        _isVerifying = false;
      });

      if (result.verified) {
        _showSuccess('Voice verified successfully!');
        await Future.delayed(const Duration(seconds: 1));

        // Clean up
        await _cleanup();

        if (mounted) {
          widget.onVerificationSuccess?.call();
          Navigator.pop(context, true);
        }
      } else {
        _retryCount++;

        String errorMessage;
        if (result.isNotEnrolled) {
          // User needs to enroll first
          await Future.delayed(const Duration(seconds: 1));
          if (mounted) {
            widget.onEnrollmentRequired?.call();
            Navigator.pop(context, false);
          }
          return;
        } else if (result.isPoorQuality) {
          errorMessage = 'Voice quality too low. Please speak clearly and try again.';
        } else if (result.isBelowThreshold) {
          final similarity = result.similarityPercentage.toStringAsFixed(1);
          errorMessage = 'Voice similarity ($similarity%) below threshold. Please try again.';
        } else {
          errorMessage = result.message ?? 'Verification failed. Please try again.';
        }

        setState(() {
          _errorMessage = errorMessage;
        });

        // Show retry dialog
        _showRetryDialog(errorMessage, result.similarityScore ?? 0);
      }
    } on VoiceBiometricsNetworkException catch (e) {
      if (mounted) {
        setState(() {
          _isVerifying = false;
          _errorMessage = e.userMessage;
        });
        _showRetryDialog(e.userMessage, 0);
      }
    } on VoiceBiometricsServerException catch (e) {
      if (mounted) {
        setState(() {
          _isVerifying = false;
          _errorMessage = e.userMessage;
        });
        _showRetryDialog(e.userMessage, 0);
      }
    } on VoiceBiometricsException catch (e) {
      if (mounted) {
        setState(() {
          _isVerifying = false;
          _errorMessage = e.userMessage;
        });
        _showError(e.userMessage);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isVerifying = false;
          _errorMessage = _getErrorMessage(e);
        });
        _showRetryDialog(_getErrorMessage(e), 0);
      }
    }
  }

  void _showRetryDialog(String message, double similarityScore) {
    if (!mounted) return;
    final attemptsRemaining = maxRetries - _retryCount;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(
              similarityScore > 0.7 ? Icons.warning_amber_rounded : Icons.error_outline,
              color: similarityScore > 0.7 ? Colors.orange : Colors.red,
            ),
            const SizedBox(width: 8),
            const Expanded(child: Text('Verification Failed')),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message),
            const SizedBox(height: 16),
            if (similarityScore > 0) ...[
              Text('Similarity Score: ${similarityScore.toStringAsFixed(1)}%',
                  style: TextStyle(
                    color: similarityScore > 0.8 ? Colors.orange : Colors.red,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 8),
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: similarityScore.clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: similarityScore > 0.8 ? Colors.orange : Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            Text(
              'Attempts remaining: $attemptsRemaining of $maxRetries',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _handleCancel();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _recordAndVerify();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Future<Uint8List?> _readAndValidateAudioFile(String path) async {
    try {
      final file = File(path);

      if (!await file.exists()) {
        _showError('Recording file not found');
        return null;
      }

      final fileSize = await file.length();

      if (fileSize < 1000) {
        _showError('Recording is too short. Please speak clearly and try again.');
        return null;
      }

      if (fileSize > 10 * 1024 * 1024) {
        _showError('Recording is too large. Please try again.');
        return null;
      }

      return await file.readAsBytes();
    } catch (e) {
      _showError('Failed to read audio file: ${_getErrorMessage(e)}');
      return null;
    }
  }

  Future<bool> _checkStorageSpace() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final testFile = File('${tempDir.path}/test_space_check.tmp');
      await testFile.create();
      await testFile.delete();
      return true;
    } catch (e) {
      _showError('Insufficient storage space');
      return false;
    }
  }

  Future<bool> _checkNetworkConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return !result.contains(ConnectivityResult.none);
    } catch (e) {
      return true;
    }
  }

  void _handleRecordingError(Object error) {
    if (mounted) {
      setState(() {
        _isRecording = false;
        _recordingProgress = 0.0;
        _currentRecordingPath = null;
        _errorMessage = _getErrorMessage(error);
      });
      _recordingTimer?.cancel();
      _recordingTimer = null;
    }
  }

  Future<void> _cancelCurrentRecording() async {
    if (!_isRecording) return;

    _recordingTimer?.cancel();
    _recordingTimer = null;

    try {
      await _recorder.stop();
    } catch (e) {
      // Ignore errors during cancellation
    }

    if (_currentRecordingPath != null) {
      try {
        final file = File(_currentRecordingPath!);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        // Ignore cleanup errors
      }
    }

    if (mounted) {
      setState(() {
        _isRecording = false;
        _recordingProgress = 0.0;
        _currentRecordingPath = null;
      });
    }
  }

  Future<void> _cleanup() async {
    _recordingTimer?.cancel();
    _recordingTimer = null;

    try {
      await _recorder.dispose();
    } catch (e) {
      // Ignore disposal errors
    }
  }

  String _getErrorMessage(Object error) {
    if (error is VoiceBiometricsException) {
      return error.userMessage;
    } else if (error is SocketException) {
      return 'No internet connection';
    } else if (error is TimeoutException) {
      return 'Request timed out. Please try again';
    } else {
      final message = error.toString();
      if (message.contains('permission')) {
        return 'Microphone permission denied';
      } else if (message.contains('storage') || message.contains('space')) {
        return 'Insufficient storage space';
      } else {
        return 'An error occurred. Please try again';
      }
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _showSuccess(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _handleCancel() {
    if (_isVerifying) return;
    Navigator.pop(context, false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_permissionPermanentlyDenied) {
      return _buildPermissionDeniedScreen();
    }

    if (_isVerifying) {
      return _buildVerifyingScreen();
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _isVerifying ? null : _handleCancel,
        ),
        title: const Text('Voice Verification'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.primaryColor.withValues(alpha: 0.1),
                  border: Border.all(
                    color: theme.primaryColor,
                    width: 3,
                  ),
                ),
                child: Icon(
                  Icons.verified_user_rounded,
                  size: 60,
                  color: theme.primaryColor,
                ),
              ),

              const SizedBox(height: 32),

              // Title
              Text(
                'Verify Your Voice',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Subtitle
              Text(
                'Please speak clearly to verify your identity',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // Error message
              if (_errorMessage != null) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red[700], size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(color: Colors.red[900], fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // Recording indicator
              if (_isRecording) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Recording...',
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Progress bar
                SizedBox(
                  width: 200,
                  child: LinearProgressIndicator(
                    value: _recordingProgress,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(height: 32),
              ],

              // Record button
              SizedBox(
                width: 200,
                height: 200,
                child: GestureDetector(
                  onTap: _hasPermission && !_isRecording && !_isVerifying
                      ? _recordAndVerify
                      : null,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _hasPermission && !_isRecording && !_isVerifying
                          ? theme.primaryColor
                          : Colors.grey[300],
                      boxShadow: _hasPermission && !_isRecording && !_isVerifying
                          ? [
                              BoxShadow(
                                color: theme.primaryColor.withValues(alpha: 0.3),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ]
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _isRecording ? Icons.mic : Icons.mic_rounded,
                          size: 60,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _isRecording ? 'Recording...' : 'TAP TO SPEAK',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Instructions
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue[700], size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Tips for best results:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('• Speak in a quiet environment'),
                    const Text('• Hold your phone steady'),
                    const Text('• Speak clearly and naturally'),
                    const Text('• Recording lasts $verificationDuration seconds'),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Cancel button
              TextButton(
                onPressed: _isVerifying ? null : _handleCancel,
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionDeniedScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Verification'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.mic_off, size: 80, color: Colors.grey[400]),
              const SizedBox(height: 24),
              const Text(
                'Microphone Permission Required',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Please enable microphone permission in Settings to continue with voice verification.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () => openAppSettings(),
                icon: const Icon(Icons.settings),
                label: const Text('Open Settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerifyingScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Verification'),
        centerTitle: true,
      ),
      body: PopScope(
        canPop: false,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 24),
              const Text(
                'Verifying your voice...',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please wait',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
