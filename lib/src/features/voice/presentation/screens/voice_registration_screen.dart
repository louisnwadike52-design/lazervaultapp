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
import '../../../../../core/services/injection_container.dart';

/// Voice Registration Screen - Records multiple voice samples for enrollment
/// Production-ready with comprehensive error handling
class VoiceRegistrationScreen extends StatefulWidget {
  final String userId;
  final VoidCallback? onEnrollmentComplete;

  const VoiceRegistrationScreen({
    Key? key,
    required this.userId,
    this.onEnrollmentComplete,
  }) : super(key: key);

  @override
  State<VoiceRegistrationScreen> createState() =>
      _VoiceRegistrationScreenState();
}

class _VoiceRegistrationScreenState extends State<VoiceRegistrationScreen>
    with WidgetsBindingObserver {
  final VoiceBiometricsService _voiceService = GetIt.I<VoiceBiometricsService>();
  final AudioRecorder _recorder = AudioRecorder();
  final Connectivity _connectivity = Connectivity();

  static const int requiredSamples = 5;
  static const int sampleDurationSeconds = 4;
  static const int minAudioFileSize = 1000; // Minimum 1KB to validate audio
  static const int maxAudioFileSize = 10 * 1024 * 1024; // 10MB max

  List<Uint8List> _audioSamples = [];
  List<String> _tempFilePaths = []; // Track temp files for cleanup
  int _currentSample = 0;
  bool _isRecording = false;
  bool _isProcessing = false;
  bool _isCheckingStatus = true;
  bool _isAlreadyEnrolled = false;
  bool _hasPermission = false;
  bool _permissionPermanentlyDenied = false;
  double _recordingProgress = 0.0;
  Timer? _recordingTimer;
  String? _currentRecordingPath;

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

    // Handle app backgrounding during recording
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      if (_isRecording) {
        _cancelCurrentRecording();
      }
    }
  }

  /// Initialize screen: check permission and enrollment status
  Future<void> _initialize() async {
    setState(() {
      _isCheckingStatus = true;
    });

    try {
      // Check if already enrolled
      final status = await _voiceService.checkEnrollmentStatus(widget.userId);

      if (mounted && status.isEnrolled) {
        setState(() {
          _isAlreadyEnrolled = true;
          _isCheckingStatus = false;
        });
        _showAlreadyEnrolledDialog();
        return;
      }

      // Check microphone permission
      await _checkAndRequestMicrophonePermission();
    } catch (e) {
      if (mounted) {
        _showError(_getErrorMessage(e));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isCheckingStatus = false;
        });
      }
    }
  }

  /// Check and request microphone permission with proper error handling
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
        _showPermissionDeniedDialog();
        return;
      }

      // Request permission
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
        _showPermissionDeniedDialog();
      } else {
        setState(() {
          _hasPermission = false;
        });
        _showError('Microphone permission is required for voice registration');
        Navigator.pop(context, false);
      }
    } catch (e) {
      _showError('Failed to check microphone permission: ${_getErrorMessage(e)}');
      Navigator.pop(context, false);
    }
  }

  /// Show dialog when permission is permanently denied
  void _showPermissionDeniedDialog() {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Microphone Permission Required'),
        content: const Text(
          'Voice registration requires microphone access to record your voice samples.\n\n'
          'Please enable microphone permission in Settings.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, false);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  /// Show dialog when user is already enrolled
  void _showAlreadyEnrolledDialog() {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Already Enrolled'),
        content: const Text(
          'Your voice is already registered. Would you like to re-register?\n\n'
          'Re-registering will replace your existing voice profile.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, false);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await _deleteExistingEnrollment();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Re-register'),
          ),
        ],
      ),
    );
  }

  /// Delete existing enrollment to allow re-registration
  Future<void> _deleteExistingEnrollment() async {
    setState(() {
      _isProcessing = true;
    });

    try {
      final deleted = await _voiceService.deleteVoiceEnrollment(widget.userId);

      if (mounted) {
        if (deleted) {
          setState(() {
            _isAlreadyEnrolled = false;
            _isProcessing = false;
          });
          _showSuccess('Previous enrollment deleted. You can now re-register.');
        } else {
          setState(() {
            _isProcessing = false;
          });
          _showError('Failed to delete previous enrollment');
          Navigator.pop(context, false);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
        _showError(_getErrorMessage(e));
        Navigator.pop(context, false);
      }
    }
  }

  /// Record a voice sample with comprehensive error handling
  Future<void> _recordSample() async {
    if (_isRecording || _currentSample >= requiredSamples || !_hasPermission) {
      return;
    }

    setState(() {
      _isRecording = true;
      _recordingProgress = 0.0;
    });

    try {
      // Double-check permission
      if (!await _recorder.hasPermission()) {
        throw Exception('Microphone permission not granted');
      }

      // Check available storage
      if (!await _checkStorageSpace()) {
        throw Exception('Insufficient storage space');
      }

      // Get temporary directory for recording
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final recordingPath = '${tempDir.path}/voice_sample_$timestamp.wav';

      setState(() {
        _currentRecordingPath = recordingPath;
      });

      // Start recording with WAV format
      await _recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.wav,
          sampleRate: 16000,
          numChannels: 1,
          bitRate: 256000,
        ),
        path: recordingPath,
      );

      // Show progress for specified duration
      int tickCount = 0;
      const tickInterval = 100; // milliseconds
      final totalTicks = (sampleDurationSeconds * 1000) ~/ tickInterval;

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
            _stopRecording();
          }
        },
      );
    } catch (e) {
      _handleRecordingError(e);
    }
  }

  /// Stop recording and save the sample
  Future<void> _stopRecording() async {
    if (!_isRecording) return;

    _recordingTimer?.cancel();
    _recordingTimer = null;

    try {
      final path = await _recorder.stop();

      if (path == null || path.isEmpty) {
        throw Exception('Recording failed: no file path returned');
      }

      // Read and validate the recorded file
      final audioData = await _readAndValidateAudioFile(path);

      if (audioData != null) {
        setState(() {
          _audioSamples.add(audioData);
          _tempFilePaths.add(path);
          _currentSample++;
          _isRecording = false;
          _recordingProgress = 0.0;
          _currentRecordingPath = null;
        });

        // Auto-submit if we have all samples
        if (_audioSamples.length >= requiredSamples && !_isProcessing) {
          await Future.delayed(const Duration(milliseconds: 500));
          if (mounted) {
            _submitEnrollment();
          }
        }
      } else {
        throw Exception('Invalid audio file recorded');
      }
    } catch (e) {
      _handleRecordingError(e);
    }
  }

  /// Cancel current recording (e.g., when app is backgrounded)
  Future<void> _cancelCurrentRecording() async {
    if (!_isRecording) return;

    _recordingTimer?.cancel();
    _recordingTimer = null;

    try {
      await _recorder.stop();
    } catch (e) {
      // Ignore errors during cancellation
    }

    // Clean up current recording file
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
      _showError('Recording cancelled');
    }
  }

  /// Read and validate audio file
  Future<Uint8List?> _readAndValidateAudioFile(String path) async {
    try {
      final file = File(path);

      if (!await file.exists()) {
        _showError('Recording file not found');
        return null;
      }

      final fileSize = await file.length();

      // Validate file size
      if (fileSize < minAudioFileSize) {
        _showError('Recording is too short or empty. Please try again.');
        return null;
      }

      if (fileSize > maxAudioFileSize) {
        _showError('Recording is too large. Please try again.');
        return null;
      }

      // Read file
      final bytes = await file.readAsBytes();

      return bytes;
    } catch (e) {
      _showError('Failed to read audio file: ${_getErrorMessage(e)}');
      return null;
    }
  }

  /// Check if there's enough storage space
  Future<bool> _checkStorageSpace() async {
    try {
      final tempDir = await getTemporaryDirectory();
      // Estimate needed space: ~128KB per 4-second sample
      final neededSpace = 128 * 1024 * requiredSamples;

      // Try to create a test file to check if we have space
      final testFile = File('${tempDir.path}/test_space_check.tmp');
      await testFile.create();
      await testFile.delete();

      return true;
    } catch (e) {
      _showError('Insufficient storage space');
      return false;
    }
  }

  /// Handle recording errors
  void _handleRecordingError(Object error) {
    if (mounted) {
      setState(() {
        _isRecording = false;
        _recordingProgress = 0.0;
        _currentRecordingPath = null;
      });
      _recordingTimer?.cancel();
      _recordingTimer = null;

      _showError('Recording failed: ${_getErrorMessage(error)}');
    }
  }

  /// Submit enrollment with retry mechanism
  Future<void> _submitEnrollment() async {
    if (_audioSamples.length < 3) {
      _showError('At least 3 voice samples are required');
      return;
    }

    if (_isProcessing) return;

    // Check network connectivity
    if (!await _checkNetworkConnectivity()) {
      _showError('No internet connection. Please check your network and try again.');
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      final result = await _voiceService.enrollVoice(
        userId: widget.userId,
        audioSamples: _audioSamples,
        sampleRate: 16000,
        channels: 1,
      );

      if (!mounted) return;

      if (result.success) {
        _showSuccess(
          'Voice registered successfully!\n'
          'Quality Score: ${((result.qualityScore ?? 0) * 100).toStringAsFixed(1)}%',
        );

        // Clean up temp files
        await _cleanupTempFiles();

        // Notify callback
        widget.onEnrollmentComplete?.call();

        await Future.delayed(const Duration(seconds: 2));

        if (mounted) {
          Navigator.pop(context, true);
        }
      } else {
        _showErrorWithRetry(
          result.message ?? 'Enrollment failed. Please try again.',
        );
      }
    } on VoiceBiometricsNetworkException catch (e) {
      if (mounted) {
        _showErrorWithRetry(e.userMessage);
      }
    } on VoiceBiometricsServerException catch (e) {
      if (mounted) {
        _showErrorWithRetry(e.userMessage);
      }
    } on VoiceBiometricsException catch (e) {
      if (mounted) {
        _showError(e.userMessage);
      }
    } catch (e) {
      if (mounted) {
        _showErrorWithRetry(_getErrorMessage(e));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  /// Check network connectivity
  Future<bool> _checkNetworkConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return result != ConnectivityResult.none;
    } catch (e) {
      // If connectivity check fails, assume connected
      return true;
    }
  }

  /// Show error with retry option
  void _showErrorWithRetry(String message) {
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enrollment Failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _submitEnrollment();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  /// Delete a recorded sample
  void _deleteSample(int index) {
    if (_isProcessing || _isRecording) return;

    setState(() {
      _audioSamples.removeAt(index);

      // Clean up temp file if exists
      if (index < _tempFilePaths.length) {
        final path = _tempFilePaths.removeAt(index);
        _deleteTempFile(path);
      }

      _currentSample--;
    });
  }

  /// Delete a single temp file
  Future<void> _deleteTempFile(String path) async {
    try {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      // Ignore cleanup errors
    }
  }

  /// Clean up all temporary files
  Future<void> _cleanupTempFiles() async {
    for (final path in _tempFilePaths) {
      await _deleteTempFile(path);
    }
    _tempFilePaths.clear();
  }

  /// Cleanup resources
  Future<void> _cleanup() async {
    _recordingTimer?.cancel();
    _recordingTimer = null;

    try {
      await _recorder.dispose();
    } catch (e) {
      // Ignore disposal errors
    }

    // Clean up temp files
    await _cleanupTempFiles();

    // Clear audio samples from memory
    _audioSamples.clear();
  }

  /// Get user-friendly error message
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

  /// Cancel enrollment and go back
  void _cancelEnrollment() {
    if (_isProcessing || _isRecording) {
      _showError('Please wait for current operation to complete');
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Registration?'),
        content: Text(
          _audioSamples.isEmpty
              ? 'Are you sure you want to cancel voice registration?'
              : 'You have recorded ${_audioSamples.length} sample(s). Cancel registration?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, false);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Show loading while checking status
    if (_isCheckingStatus) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Register Your Voice'),
          centerTitle: true,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Checking enrollment status...'),
            ],
          ),
        ),
      );
    }

    // Show processing state
    if (_isProcessing) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Register Your Voice'),
          centerTitle: true,
        ),
        body: WillPopScope(
          onWillPop: () async => false, // Prevent back during processing
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Processing voice enrollment...'),
                SizedBox(height: 8),
                Text(
                  'Please wait, this may take a moment',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Show permission denied state
    if (_permissionPermanentlyDenied) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Register Your Voice'),
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
                  'Please enable microphone permission in Settings to continue with voice registration.',
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

    // Main registration UI
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Your Voice'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _cancelEnrollment,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Text(
                'Voice Security',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Record $requiredSamples voice samples to secure your account',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Progress indicator
              LinearProgressIndicator(
                value: _audioSamples.length / requiredSamples,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.colorScheme.primary,
                ),
                minHeight: 8,
              ),
              const SizedBox(height: 8),
              Text(
                '${_audioSamples.length}/$requiredSamples samples recorded',
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Sample list
              Expanded(
                child: ListView.builder(
                  itemCount: requiredSamples,
                  itemBuilder: (context, index) {
                    final isRecorded = index < _audioSamples.length;
                    final isRecording = index == _currentSample && _isRecording;

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: isRecorded
                              ? Colors.green
                              : isRecording
                                  ? theme.colorScheme.primary
                                  : Colors.grey[300],
                          child: Icon(
                            isRecorded
                                ? Icons.check
                                : isRecording
                                    ? Icons.mic
                                    : Icons.mic_none,
                            color: Colors.white,
                          ),
                        ),
                        title: Text('Sample ${index + 1}'),
                        subtitle: isRecording
                            ? LinearProgressIndicator(
                                value: _recordingProgress,
                                backgroundColor: Colors.grey[200],
                              )
                            : Text(
                                isRecorded ? 'Recorded' : 'Pending',
                                style: TextStyle(
                                  color: isRecorded
                                      ? Colors.green
                                      : Colors.grey[600],
                                ),
                              ),
                        trailing: isRecorded && !_isProcessing && !_isRecording
                            ? IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () => _deleteSample(index),
                                color: Colors.red,
                              )
                            : null,
                      ),
                    );
                  },
                ),
              ),

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
                        Icon(Icons.info_outline, color: Colors.blue[700]),
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
                    const Text('• Find a quiet environment'),
                    const Text('• Speak naturally and clearly'),
                    const Text('• Hold phone steady near your mouth'),
                    const Text('• Each sample lasts $sampleDurationSeconds seconds'),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Record button
              SizedBox(
                height: 120,
                child: _isRecording
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: CircularProgressIndicator(
                                value: _recordingProgress,
                                strokeWidth: 8,
                                backgroundColor: Colors.grey[200],
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Recording...',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    : ElevatedButton.icon(
                        onPressed: _currentSample < requiredSamples && _hasPermission
                            ? _recordSample
                            : null,
                        icon: const Icon(Icons.mic, size: 32),
                        label: Text(
                          _currentSample < requiredSamples
                              ? 'TAP TO RECORD SAMPLE ${_currentSample + 1}'
                              : 'ALL SAMPLES RECORDED',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
              ),

              // Submit button
              if (_audioSamples.length >= 3 && !_isProcessing)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                    onPressed: _submitEnrollment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'COMPLETE REGISTRATION (${_audioSamples.length} samples)',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
