import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../../core/services/voice_biometrics_service.dart';
import '../../../../../core/services/injection_container.dart';
import '../screens/voice_registration_screen.dart';

/// Voice Transaction Screen - Records voice command and processes transaction
/// Production-ready with comprehensive error handling
class VoiceTransactionScreen extends StatefulWidget {
  final String userId;
  final String? baseUrl; // Voice agent gateway URL

  const VoiceTransactionScreen({
    Key? key,
    required this.userId,
    this.baseUrl,
  }) : super(key: key);

  @override
  State<VoiceTransactionScreen> createState() => _VoiceTransactionScreenState();
}

class _VoiceTransactionScreenState extends State<VoiceTransactionScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final VoiceBiometricsService _voiceService = GetIt.I<VoiceBiometricsService>();
  final AudioRecorder _recorder = AudioRecorder();
  final Connectivity _connectivity = Connectivity();
  final http.Client _httpClient = http.Client();

  static const int maxRecordingSeconds = 30;
  static const int minRecordingSeconds = 1;
  static const int minAudioFileSize = 1000; // 1KB minimum
  static const int maxAudioFileSize = 10 * 1024 * 1024; // 10MB max

  bool _isCheckingEnrollment = true;
  bool _isRecording = false;
  bool _isVerifying = false;
  bool _isProcessing = false;
  bool _hasPermission = false;

  String? _transcript;
  String? _transactionResult;
  VoiceVerificationResult? _verificationResult;
  String? _currentRecordingPath;

  late AnimationController _pulseController;
  Timer? _recordingTimer;
  int _recordingSeconds = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
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
        _cancelRecording();
      }
    }
  }

  /// Initialize screen: check enrollment, permission, and connectivity
  Future<void> _initialize() async {
    setState(() {
      _isCheckingEnrollment = true;
    });

    try {
      // Check microphone permission first
      final permissionStatus = await Permission.microphone.status;
      if (!permissionStatus.isGranted) {
        final result = await Permission.microphone.request();
        if (!result.isGranted) {
          if (mounted) {
            _showError('Microphone permission is required');
            Navigator.pop(context, false);
          }
          return;
        }
      }

      setState(() {
        _hasPermission = true;
      });

      // Check voice enrollment
      final status = await _voiceService.checkEnrollmentStatus(widget.userId);

      if (!status.isEnrolled) {
        if (mounted) {
          _showNotEnrolledDialog();
        }
        return;
      }

      if (mounted) {
        setState(() {
          _isCheckingEnrollment = false;
        });
      }
    } on VoiceBiometricsException catch (e) {
      if (mounted) {
        _showError(e.userMessage);
        Navigator.pop(context, false);
      }
    } catch (e) {
      if (mounted) {
        _showError(_getErrorMessage(e));
        Navigator.pop(context, false);
      }
    }
  }

  /// Show dialog when user is not enrolled
  void _showNotEnrolledDialog() {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Voice Not Registered'),
        content: const Text(
          'You need to register your voice before using voice transactions.\n\n'
          'Would you like to register now?',
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
              final result = await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  builder: (context) => VoiceRegistrationScreen(
                    userId: widget.userId,
                  ),
                ),
              );

              if (mounted) {
                if (result == true) {
                  // Successfully enrolled, initialize again
                  _initialize();
                } else {
                  // User cancelled registration
                  Navigator.pop(context, false);
                }
              }
            },
            child: const Text('Register Voice'),
          ),
        ],
      ),
    );
  }

  /// Start recording voice command
  Future<void> _startRecording() async {
    if (_isRecording ||
        _isVerifying ||
        _isProcessing ||
        !_hasPermission) return;

    // Check network connectivity before starting
    if (!await _checkNetworkConnectivity()) {
      _showError('No internet connection. Please check your network.');
      return;
    }

    setState(() {
      _isRecording = true;
      _recordingSeconds = 0;
      _transcript = null;
      _transactionResult = null;
      _verificationResult = null;
    });

    try {
      // Double-check permission
      if (!await _recorder.hasPermission()) {
        throw Exception('Microphone permission not granted');
      }

      // Check storage space
      if (!await _checkStorageSpace()) {
        throw Exception('Insufficient storage space');
      }

      // Get temporary directory for recording
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final recordingPath = '${tempDir.path}/voice_command_$timestamp.wav';

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

      // Start timer
      _recordingTimer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (!mounted || !_isRecording) {
            timer.cancel();
            return;
          }

          setState(() {
            _recordingSeconds = timer.tick;
          });

          // Auto-stop at max duration
          if (_recordingSeconds >= maxRecordingSeconds) {
            timer.cancel();
            _stopRecording();
          }
        },
      );
    } catch (e) {
      _handleRecordingError(e);
    }
  }

  /// Stop recording and process
  Future<void> _stopRecording() async {
    if (!_isRecording) return;

    _recordingTimer?.cancel();
    _recordingTimer = null;

    // Check minimum recording duration
    if (_recordingSeconds < minRecordingSeconds) {
      if (mounted) {
        setState(() {
          _isRecording = false;
          _recordingSeconds = 0;
        });
        _showError('Recording too short. Please hold longer and speak clearly.');
        _cleanupRecordingFile();
      }
      return;
    }

    try {
      final path = await _recorder.stop();

      if (path == null || path.isEmpty) {
        throw Exception('Recording failed: no file path returned');
      }

      // Read and validate the audio file
      final audioSample = await _readAndValidateAudioFile(path);

      if (audioSample != null && mounted) {
        setState(() {
          _isRecording = false;
        });

        // First verify voice
        await _verifyVoice(audioSample);

        // If verified, process the transaction
        if (mounted && _verificationResult?.verified == true) {
          await _processVoiceCommand(audioSample);
        } else if (mounted && _verificationResult != null) {
          // Verification failed, show retry option
          _showVerificationFailedDialog();
        }
      } else {
        throw Exception('Invalid audio file recorded');
      }

      // Clean up recording file
      await _cleanupRecordingFile();
    } catch (e) {
      _handleRecordingError(e);
      await _cleanupRecordingFile();
    }
  }

  /// Cancel current recording
  Future<void> _cancelRecording() async {
    if (!_isRecording) return;

    _recordingTimer?.cancel();
    _recordingTimer = null;

    try {
      await _recorder.stop();
    } catch (e) {
      // Ignore errors during cancellation
    }

    await _cleanupRecordingFile();

    if (mounted) {
      setState(() {
        _isRecording = false;
        _recordingSeconds = 0;
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

  /// Verify voice against enrolled profile
  Future<void> _verifyVoice(Uint8List audioSample) async {
    if (!mounted) return;

    setState(() {
      _isVerifying = true;
    });

    try {
      final result = await _voiceService.verifyVoice(
        userId: widget.userId,
        audioSample: audioSample,
        threshold: 0.85, // 85% similarity required
      );

      if (mounted) {
        setState(() {
          _verificationResult = result;
          _isVerifying = false;
        });

        if (!result.verified) {
          // Determine specific failure reason
          String failureMessage = 'Voice verification failed';

          if (result.isNotEnrolled) {
            failureMessage = 'Voice not enrolled. Please register first.';
          } else if (result.isPoorQuality) {
            failureMessage =
                'Poor audio quality. Please try again in a quiet environment.';
          } else if (result.isBelowThreshold) {
            failureMessage =
                'Voice did not match (${result.similarityPercentage.toStringAsFixed(1)}% similarity)';
          } else if (result.message != null) {
            failureMessage = result.message!;
          }

          _showError(failureMessage);
        }
      }
    } on VoiceBiometricsNetworkException catch (e) {
      if (mounted) {
        setState(() {
          _isVerifying = false;
        });
        _showError(e.userMessage);
      }
    } on VoiceBiometricsServerException catch (e) {
      if (mounted) {
        setState(() {
          _isVerifying = false;
        });
        _showError(e.userMessage);
      }
    } on VoiceBiometricsException catch (e) {
      if (mounted) {
        setState(() {
          _isVerifying = false;
        });
        _showError(e.userMessage);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isVerifying = false;
        });
        _showError('Verification error: ${_getErrorMessage(e)}');
      }
    }
  }

  /// Show dialog when verification fails with retry option
  void _showVerificationFailedDialog() {
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Voice Verification Failed'),
        content: Text(
          'Your voice could not be verified.\n\n'
          'Similarity: ${_verificationResult!.similarityPercentage.toStringAsFixed(1)}%\n'
          'Required: 85%\n\n'
          'Would you like to try again?',
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
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _verificationResult = null;
              });
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  /// Process voice command via voice-agent-gateway
  Future<void> _processVoiceCommand(Uint8List audioSample) async {
    if (!mounted) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      // Get base URL for voice agent gateway
      final baseUrl = widget.baseUrl ?? 'http://10.0.2.2:8888';
      final uri = Uri.parse('$baseUrl/voice/process');

      // Prepare request with audio
      final request = http.MultipartRequest('POST', uri)
        ..fields['userId'] = widget.userId
        ..files.add(
          http.MultipartFile.fromBytes(
            'audio',
            audioSample,
            filename: 'voice_command.wav',
          ),
        );

      // Send request with timeout
      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 30),
      );

      final response = await http.Response.fromStream(streamedResponse);

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;

        setState(() {
          _transcript = data['transcript'] as String?;
          _transactionResult = data['result'] as String?;
          _isProcessing = false;
        });

        if (_transactionResult != null) {
          _showSuccess(_transactionResult!);

          // Close screen after delay
          await Future.delayed(const Duration(seconds: 3));
          if (mounted) {
            Navigator.pop(context, true);
          }
        }
      } else if (response.statusCode == 400) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        throw Exception(data['error'] ?? 'Invalid request');
      } else if (response.statusCode >= 500) {
        throw Exception('Server error. Please try again later.');
      } else {
        throw Exception('Failed to process voice command');
      }
    } on SocketException catch (_) {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
        _showErrorWithRetry(
            'No internet connection. Please check your network.');
      }
    } on TimeoutException catch (_) {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
        _showErrorWithRetry('Request timed out. Please try again.');
      }
    } on http.ClientException catch (_) {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
        _showErrorWithRetry('Network error. Please try again.');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
        _showErrorWithRetry(_getErrorMessage(e));
      }
    }
  }

  /// Show error with retry option
  void _showErrorWithRetry(String message) {
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Transaction Failed'),
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
              setState(() {
                _transcript = null;
                _transactionResult = null;
                _verificationResult = null;
              });
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
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

  /// Check if there's enough storage space
  Future<bool> _checkStorageSpace() async {
    try {
      final tempDir = await getTemporaryDirectory();
      // Try to create a test file
      final testFile = File('${tempDir.path}/test_space_check.tmp');
      await testFile.create();
      await testFile.delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Clean up recording file
  Future<void> _cleanupRecordingFile() async {
    if (_currentRecordingPath != null) {
      try {
        final file = File(_currentRecordingPath!);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        // Ignore cleanup errors
      }
      _currentRecordingPath = null;
    }
  }

  /// Handle recording errors
  void _handleRecordingError(Object error) {
    if (mounted) {
      setState(() {
        _isRecording = false;
        _recordingSeconds = 0;
        _currentRecordingPath = null;
      });
      _recordingTimer?.cancel();
      _recordingTimer = null;

      _showError('Recording failed: ${_getErrorMessage(error)}');
    }
  }

  /// Cleanup resources
  Future<void> _cleanup() async {
    _recordingTimer?.cancel();
    _recordingTimer = null;

    _pulseController.stop();
    _pulseController.dispose();

    try {
      await _recorder.dispose();
    } catch (e) {
      // Ignore disposal errors
    }

    try {
      _httpClient.close();
    } catch (e) {
      // Ignore
    }

    await _cleanupRecordingFile();
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
      } else if (message.contains('Exception:')) {
        return message.substring(message.indexOf('Exception:') + 11).trim();
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
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Show loading while checking enrollment
    if (_isCheckingEnrollment) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Voice Transaction'),
          centerTitle: true,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Checking voice enrollment...'),
            ],
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        // Prevent back navigation during operations
        if (_isRecording || _isVerifying || _isProcessing) {
          _showError('Please wait for current operation to complete');
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Voice Transaction'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Status card
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.verified_user,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Voice Authentication Active',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Your voice will be verified before processing any transaction',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Microphone visualization
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Animated microphone button
                        GestureDetector(
                          onTapDown: (_) => _startRecording(),
                          onTapUp: (_) => _stopRecording(),
                          onTapCancel: () => _stopRecording(),
                          child: AnimatedBuilder(
                            animation: _pulseController,
                            builder: (context, child) {
                              return Container(
                                width: _isRecording ? 180 : 140,
                                height: _isRecording ? 180 : 140,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _isRecording
                                      ? Colors.red.withOpacity(0.8)
                                      : _isVerifying || _isProcessing
                                          ? Colors.grey.withOpacity(0.5)
                                          : theme.colorScheme.primary,
                                  boxShadow: _isRecording
                                      ? [
                                          BoxShadow(
                                            color: Colors.red.withOpacity(
                                              0.3 +
                                                  _pulseController.value * 0.3,
                                            ),
                                            blurRadius:
                                                20 + _pulseController.value * 20,
                                            spreadRadius:
                                                5 + _pulseController.value * 10,
                                          ),
                                        ]
                                      : [
                                          BoxShadow(
                                            color: theme.colorScheme.primary
                                                .withOpacity(0.3),
                                            blurRadius: 15,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                ),
                                child: Icon(
                                  _isRecording ? Icons.stop : Icons.mic,
                                  size: _isRecording ? 80 : 60,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Status text
                        if (_isRecording)
                          Column(
                            children: [
                              Text(
                                'Recording... $_recordingSeconds/${maxRecordingSeconds}s',
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Release to stop',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          )
                        else if (_isVerifying)
                          const Column(
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 16),
                              Text(
                                'Verifying voice...',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        else if (_isProcessing)
                          const Column(
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 16),
                              Text(
                                'Processing transaction...',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        else
                          Text(
                            'Hold to speak',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        // Verification result
                        if (_verificationResult != null) ...[
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: _verificationResult!.verified
                                  ? Colors.green.shade50
                                  : Colors.red.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: _verificationResult!.verified
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _verificationResult!.verified
                                      ? Icons.check_circle
                                      : Icons.cancel,
                                  color: _verificationResult!.verified
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _verificationResult!.verified
                                      ? 'Voice Verified ✓'
                                      : 'Verification Failed',
                                  style: TextStyle(
                                    color: _verificationResult!.verified
                                        ? Colors.green.shade800
                                        : Colors.red.shade800,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Similarity: ${_verificationResult!.similarityPercentage.toStringAsFixed(1)}%',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],

                        // Transcript
                        if (_transcript != null) ...[
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'You said:',
                                  style: TextStyle(
                                    color: Colors.blue.shade700,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '"$_transcript"',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                // Instructions
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline,
                              color: theme.colorScheme.primary),
                          const SizedBox(width: 8),
                          Text(
                            'How to use:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text('1. Hold the microphone button'),
                      const Text('2. Speak your command clearly'),
                      const Text('3. Release when done'),
                      const SizedBox(height: 8),
                      Text(
                        'Examples: "Send \$100 to John", "Check my balance", "Buy 5 shares of Apple"',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
