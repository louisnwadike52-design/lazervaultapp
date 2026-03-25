import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lazervault/src/features/voice_enrollment/domain/repositories/voice_enrollment_repository.dart';

part 'voice_enrollment_state.dart';

/// Cubit for managing voice enrollment flow
@injectable
class VoiceEnrollmentCubit extends Cubit<VoiceEnrollmentState> {
  final VoiceEnrollmentRepository _repository;

  // Recording state
  StreamSubscription<double>? _soundLevelSubscription;
  Timer? _recordingTimer;
  int _currentStep = 0;
  final List<File> _recordedSamples = [];
  bool _enrollInFlight = false; // Prevents double-tap enrollment
  bool _isRecording = false; // Tracks whether recorder is actually active

  /// Whether the current flow is in carousel mode (vs multi-step mode)
  bool _isCarouselMode = false;

  VoiceEnrollmentCubit(this._repository)
      : super(VoiceEnrollmentInitial(currentStep: 0, totalSteps: 3)) {
    _loadSavedProgress();
  }

  /// Load saved progress from previous session
  Future<void> _loadSavedProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedStep = prefs.getInt('voice_enrollment_step');
      final savedPaths = prefs.getStringList('voice_enrollment_samples');

      if (savedStep != null && savedPaths != null && savedPaths.isNotEmpty) {
        // Verify files still exist
        final validFiles = <File>[];
        for (final path in savedPaths) {
          final file = File(path);
          if (await file.exists()) {
            validFiles.add(file);
          }
        }

        // Only resume if ALL saved files are still valid
        // If any temp files were cleaned up, start fresh to avoid partial enrollment
        if (validFiles.length == savedPaths.length && validFiles.isNotEmpty) {
          _currentStep = savedStep;
          _recordedSamples.addAll(validFiles);
          print('Resumed voice enrollment from step $_currentStep with ${validFiles.length} samples');
          emit(VoiceEnrollmentInitial(
            currentStep: _currentStep,
            totalSteps: 3,
          ));
          return;
        } else if (validFiles.isNotEmpty) {
          print('Incomplete enrollment progress (${validFiles.length}/${savedPaths.length} files found), starting fresh');
        }
      }

      // No valid saved progress, start fresh
      await _clearSavedProgress();
    } catch (e) {
      print('Failed to load saved progress: $e');
      // Continue with fresh start
    }
  }

  /// Save current progress
  Future<void> _saveProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('voice_enrollment_step', _currentStep);
      await prefs.setStringList(
        'voice_enrollment_samples',
        _recordedSamples.map((f) => f.path).toList(),
      );
      print('Saved voice enrollment progress: step $_currentStep, ${_recordedSamples.length} samples');
    } catch (e) {
      print('Failed to save progress: $e');
    }
  }

  /// Clear saved progress
  Future<void> _clearSavedProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('voice_enrollment_step');
      await prefs.remove('voice_enrollment_samples');
      print('Cleared saved voice enrollment progress');
    } catch (e) {
      print('Failed to clear saved progress: $e');
    }
  }

  /// Start the enrollment process (multi-step mode)
  Future<void> startEnrollment() async {
    _isCarouselMode = false;
    _currentStep = 0;
    _recordedSamples.clear();
    _isRecording = false;
    await _clearSavedProgress();
    emit(VoiceEnrollmentInitial(currentStep: 0, totalSteps: 3));
  }

  /// Safely stop any active recording before starting a new flow
  Future<void> _ensureRecorderStopped() async {
    if (_isRecording) {
      try {
        _recordingTimer?.cancel();
        _recordingTimer = null;
        await _soundLevelSubscription?.cancel();
        _soundLevelSubscription = null;
        await _repository.stopRecording();
      } catch (e) {
        print('Warning: Error stopping previous recording: $e');
      }
      _isRecording = false;
    }
  }

  /// Start recording a voice sample
  Future<void> startRecording() async {
    try {
      // Check microphone permission
      final hasPermission = await _repository.checkMicrophonePermission();
      if (!hasPermission) {
        emit(VoiceEnrollmentPermissionDenied());
        return;
      }

      // Ensure any previous recording is stopped
      await _ensureRecorderStopped();

      // Start recording
      final recordingStream = await _repository.startRecording();
      _isRecording = true;

      // Emit recording state
      emit(VoiceEnrollmentRecording(
        currentStep: _currentStep,
        totalSteps: 3,
        soundLevel: 0.0,
      ));

      // Cancel any existing subscription before creating a new one
      await _soundLevelSubscription?.cancel();
      // Listen to sound levels
      _soundLevelSubscription = recordingStream.soundLevel.listen((level) {
        if (state is VoiceEnrollmentRecording) {
          final currentState = state as VoiceEnrollmentRecording;
          emit(currentState.copyWith(soundLevel: level));
        }
      });

      // Auto-stop after 5 seconds
      _recordingTimer = Timer(const Duration(seconds: 5), () {
        if (_isRecording) {
          stopRecording();
        }
      });
    } catch (e) {
      _isRecording = false;
      emit(VoiceEnrollmentError(
        message: 'Failed to start recording: ${e.toString()}',
      ));
    }
  }

  /// Stop recording and process the sample
  Future<void> stopRecording() async {
    if (!_isRecording) {
      print('Warning: stopRecording called but no recording active, ignoring');
      return;
    }
    // Immediately mark as not recording to prevent concurrent stop calls
    _isRecording = false;

    // Cancel timer and subscription first (always, even if stop fails)
    _recordingTimer?.cancel();
    _recordingTimer = null;
    await _soundLevelSubscription?.cancel();
    _soundLevelSubscription = null;

    try {
      // Stop recording and get file
      final audioFile = await _repository.stopRecording();
      _recordedSamples.add(audioFile);

      // Save progress after successful recording
      await _saveProgress();

      // Emit processing state
      emit(VoiceEnrollmentProcessing(
        currentStep: _currentStep,
        totalSteps: 3,
      ));

      // Process the recording
      await Future.delayed(const Duration(milliseconds: 500));

      // Move to next step or complete enrollment
      if (_currentStep < 2) {
        _currentStep++;
        await _saveProgress(); // Save after incrementing step
        await Future.delayed(const Duration(milliseconds: 300));
        emit(VoiceEnrollmentInitial(
          currentStep: _currentStep,
          totalSteps: 3,
        ));
      } else {
        // All samples collected, enroll voice
        await _enrollVoice();
      }
    } catch (e) {
      emit(VoiceEnrollmentError(
        message: 'Failed to process recording: ${e.toString()}',
      ));
    }
  }

  /// Enroll voice with collected samples.
  /// If [_isRetryAfterDelete] is true, skip auto-delete on ALREADY_EXISTS to prevent loops.
  bool _isRetryAfterDelete = false;

  Future<void> _enrollVoice() async {
    if (_enrollInFlight) return; // Prevent double-tap
    _enrollInFlight = true;

    try {
      emit(VoiceEnrollmentLoading());

      // Validate we have exactly 3 distinct audio samples
      if (_recordedSamples.length < 3) {
        _enrollInFlight = false;
        emit(VoiceEnrollmentError(
          message: 'Not all voice samples were recorded. Please record all 3 samples.',
          errorCode: 'INCOMPLETE_SAMPLES',
        ));
        return;
      }

      // Verify all sample files still exist on disk
      for (var i = 0; i < _recordedSamples.length; i++) {
        if (!await _recordedSamples[i].exists()) {
          _enrollInFlight = false;
          emit(VoiceEnrollmentError(
            message: 'Voice sample ${i + 1} was lost. Please re-record your samples.',
            errorCode: 'SAMPLE_MISSING',
          ));
          return;
        }
      }

      // Get user ID from auth state
      final userId = await _repository.getCurrentUserId();

      // Enroll voice
      final result = await _repository.enrollVoice(
        userId: userId,
        audioSamples: _recordedSamples,
      );

      // Clear saved progress after successful enrollment
      await _clearSavedProgress();
      _isRetryAfterDelete = false;
      _enrollInFlight = false;

      // Check quality — if poor, let user decide
      if (result.qualityScore < 0.45) {
        emit(VoiceEnrollmentPoorQuality(
          enrollmentId: result.enrollmentId,
          qualityScore: result.qualityScore,
        ));
      } else {
        emit(VoiceEnrollmentSuccess(
          enrollmentId: result.enrollmentId,
          qualityScore: result.qualityScore,
        ));
      }
    } catch (e) {
      final errorStr = e.toString();

      // Auto-delete existing enrollment and retry once
      if ((errorStr.contains('ALREADY_EXISTS') || errorStr.contains('already has voice')) &&
          !_isRetryAfterDelete) {
        try {
          emit(VoiceEnrollmentReplacing());
          final userId = await _repository.getCurrentUserId();
          await _repository.deleteEnrollment(userId);
          // Brief pause for backend cleanup (Qdrant + clone provider deletion)
          await Future.delayed(const Duration(milliseconds: 500));
          _isRetryAfterDelete = true;
          _enrollInFlight = false; // Allow recursive call
          await _enrollVoice();
          return;
        } catch (deleteError) {
          _isRetryAfterDelete = false;
          _enrollInFlight = false;
          emit(VoiceEnrollmentError(
            message: 'Failed to replace existing voice profile. Please try again.',
            errorCode: 'DELETE_FAILED',
          ));
          return;
        }
      }

      _isRetryAfterDelete = false;
      _enrollInFlight = false;

      // Keep saved progress on error so user can retry
      String? code;
      String message;

      if (errorStr.contains('UNAVAILABLE') || errorStr.contains('temporarily unavailable')) {
        code = 'SERVICE_UNAVAILABLE';
        message = 'Voice processing service is temporarily unavailable. Please try again in a moment.';
      } else if (errorStr.contains('Could not process') || errorStr.contains('quieter environment')) {
        code = 'POOR_AUDIO';
        message = 'We couldn\'t process your voice samples. Try recording in a quieter place and speak clearly.';
      } else if (errorStr.contains('ALREADY_EXISTS') || errorStr.contains('already has voice')) {
        // Only reached if retry after delete also got ALREADY_EXISTS
        code = 'ALREADY_ENROLLED';
        message = 'Could not replace existing voice profile. Please try again later.';
      } else {
        message = 'Something went wrong during enrollment. Please try again.';
      }

      emit(VoiceEnrollmentError(
        message: message,
        errorCode: code,
      ));
    }
  }

  /// Request microphone permission
  Future<void> requestPermission() async {
    try {
      final granted = await _repository.requestMicrophonePermission();
      if (granted) {
        // Return to appropriate mode
        if (_isCarouselMode) {
          emit(VoiceEnrollmentCarouselState(activePage: 0));
        } else {
          emit(VoiceEnrollmentInitial(
            currentStep: _currentStep,
            totalSteps: 3,
          ));
        }
      } else {
        emit(VoiceEnrollmentPermissionDenied());
      }
    } catch (e) {
      emit(VoiceEnrollmentError(
        message: 'Failed to request permission: ${e.toString()}',
      ));
    }
  }

  /// Retry current step
  void retryStep() {
    if (_isCarouselMode) {
      emit(VoiceEnrollmentCarouselState(activePage: _currentStep));
    } else {
      emit(VoiceEnrollmentInitial(
        currentStep: _currentStep,
        totalSteps: 3,
      ));
    }
  }

  /// Reset enrollment
  Future<void> reset() async {
    await _ensureRecorderStopped();
    _currentStep = 0;
    _recordedSamples.clear();
    _isRetryAfterDelete = false;
    _recordingTimer?.cancel();
    _soundLevelSubscription?.cancel();
    await _clearSavedProgress();
    if (_isCarouselMode) {
      emit(VoiceEnrollmentCarouselState(activePage: 0));
    } else {
      emit(VoiceEnrollmentInitial(currentStep: 0, totalSteps: 3));
    }
  }

  /// Re-enroll: delete existing voice data from backend and restart enrollment.
  /// Properly restarts in carousel mode if that's the active UI.
  Future<void> reEnroll() async {
    // Cancel any in-progress recording safely
    await _ensureRecorderStopped();

    try {
      emit(VoiceEnrollmentReplacing(message: 'Removing existing voice profile...'));

      final userId = await _repository.getCurrentUserId();

      // Delete existing enrollment from Qdrant vector DB + clone providers
      await _repository.deleteEnrollment(userId);

      // Brief pause for backend cleanup propagation
      await Future.delayed(const Duration(milliseconds: 500));

      // Reset local state
      _currentStep = 0;
      _recordedSamples.clear();
      _isRetryAfterDelete = false;
      await _clearSavedProgress();

      // Restart enrollment in the correct mode
      if (_isCarouselMode) {
        emit(VoiceEnrollmentCarouselState(activePage: 0));
      } else {
        emit(VoiceEnrollmentInitial(currentStep: 0, totalSteps: 3));
      }
    } catch (e) {
      emit(VoiceEnrollmentError(
        message: 'Failed to remove existing voice profile. Please try again.',
        errorCode: 'DELETE_FAILED',
        duringReEnrollment: true,
      ));
    }
  }

  /// Skip enrollment — user opts out of voice auth for now
  /// Emits VoiceEnrollmentSkipped so the UI can navigate away without showing the success sheet
  void skipEnrollment() {
    final current = state;
    if (current is VoiceEnrollmentPoorQuality) {
      emit(VoiceEnrollmentSkipped(
        enrollmentId: current.enrollmentId,
        qualityScore: current.qualityScore,
      ));
    }
  }

  // ── Carousel-mode methods ──

  /// Start enrollment in carousel mode (single screen with PageView)
  Future<void> startCarouselEnrollment() async {
    _isCarouselMode = true;
    _currentStep = 0;
    _recordedSamples.clear();
    _isRecording = false;
    await _clearSavedProgress();
    emit(VoiceEnrollmentCarouselState(activePage: 0));
  }

  /// Update the active carousel page
  void setActivePage(int page) {
    final current = state;
    if (current is VoiceEnrollmentCarouselState) {
      emit(current.copyWith(activePage: page));
    }
  }

  /// Record sample for a specific carousel page index
  Future<void> recordSample(int index) async {
    if (index < 0 || index > 2) return; // Validate index bounds
    final current = state;
    if (current is! VoiceEnrollmentCarouselState) return;
    if (current.isRecording || current.isProcessing) return;

    try {
      final hasPermission = await _repository.checkMicrophonePermission();
      if (!hasPermission) {
        emit(VoiceEnrollmentPermissionDenied());
        return;
      }

      // Ensure any previous recording is stopped
      await _ensureRecorderStopped();

      final recordingStream = await _repository.startRecording();
      _isRecording = true;

      emit(current.copyWith(isRecording: true, soundLevel: 0.0));

      // Cancel any existing subscription before creating a new one
      await _soundLevelSubscription?.cancel();
      _soundLevelSubscription = recordingStream.soundLevel.listen((level) {
        if (state is VoiceEnrollmentCarouselState) {
          final s = state as VoiceEnrollmentCarouselState;
          if (s.isRecording) {
            emit(s.copyWith(soundLevel: level));
          }
        }
      });

      // Auto-stop after 5 seconds
      _recordingTimer = Timer(const Duration(seconds: 5), () {
        if (_isRecording) {
          stopCarouselRecording(index);
        }
      });
    } catch (e) {
      _isRecording = false;
      emit(VoiceEnrollmentError(
        message: 'Failed to start recording: ${e.toString()}',
      ));
    }
  }

  /// Stop carousel recording and mark sample as completed
  Future<void> stopCarouselRecording(int index) async {
    if (index < 0 || index > 2) return; // Validate index bounds
    final current = state;
    if (current is! VoiceEnrollmentCarouselState) return;
    if (!current.isRecording || !_isRecording) {
      print('Warning: stopCarouselRecording called but no recording active, ignoring');
      return;
    }

    // Immediately mark as not recording to prevent concurrent stop calls
    _isRecording = false;

    // Cancel timer/subscription first (always, even if stop fails)
    _recordingTimer?.cancel();
    _recordingTimer = null;
    await _soundLevelSubscription?.cancel();
    _soundLevelSubscription = null;

    try {
      final audioFile = await _repository.stopRecording();

      // Extend list to reach index, filling gaps with null-safe placeholders
      // that will be replaced when user records those pages
      while (_recordedSamples.length <= index) {
        _recordedSamples.add(audioFile);
      }
      _recordedSamples[index] = audioFile;

      emit(current.copyWith(isRecording: false, isProcessing: true));

      // Brief processing delay
      await Future.delayed(const Duration(milliseconds: 400));

      final updatedCompleted = List<bool>.from(current.sampleCompleted);
      updatedCompleted[index] = true;

      _currentStep = index;
      await _saveProgress();

      final newState = VoiceEnrollmentCarouselState(
        activePage: current.activePage,
        sampleCompleted: updatedCompleted,
        isRecording: false,
        soundLevel: 0.0,
        isProcessing: false,
      );

      // If all 3 completed, auto-enroll
      if (newState.allCompleted) {
        emit(newState);
        await _enrollVoice();
      } else {
        emit(newState);
      }
    } catch (e) {
      _isRecording = false;
      emit(VoiceEnrollmentError(
        message: 'Failed to process recording: ${e.toString()}',
      ));
    }
  }

  @override
  Future<void> close() {
    _recordingTimer?.cancel();
    _recordingTimer = null;
    _soundLevelSubscription?.cancel();
    _soundLevelSubscription = null;
    _isRecording = false;
    _enrollInFlight = false;
    return super.close();
  }
}
