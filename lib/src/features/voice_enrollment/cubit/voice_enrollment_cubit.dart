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

        if (validFiles.isNotEmpty) {
          _currentStep = savedStep;
          _recordedSamples.addAll(validFiles);
          print('Resumed voice enrollment from step $_currentStep with ${validFiles.length} samples');
          emit(VoiceEnrollmentInitial(
            currentStep: _currentStep,
            totalSteps: 3,
          ));
          return;
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

  /// Start the enrollment process
  Future<void> startEnrollment() async {
    _currentStep = 0;
    _recordedSamples.clear();
    await _clearSavedProgress();
    emit(VoiceEnrollmentInitial(currentStep: 0, totalSteps: 3));
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

      // Start recording
      final recordingStream = await _repository.startRecording();

      // Emit recording state
      emit(VoiceEnrollmentRecording(
        currentStep: _currentStep,
        totalSteps: 3,
        soundLevel: 0.0,
      ));

      // Listen to sound levels
      _soundLevelSubscription = recordingStream.soundLevel.listen((level) {
        if (state is VoiceEnrollmentRecording) {
          final currentState = state as VoiceEnrollmentRecording;
          emit(currentState.copyWith(soundLevel: level));
        }
      });

      // Auto-stop after 5 seconds
      _recordingTimer = Timer(const Duration(seconds: 5), () {
        stopRecording();
      });
    } catch (e) {
      emit(VoiceEnrollmentError(
        message: 'Failed to start recording: ${e.toString()}',
      ));
    }
  }

  /// Stop recording and process the sample
  Future<void> stopRecording() async {
    try {
      // Cancel timer and subscription
      _recordingTimer?.cancel();
      await _soundLevelSubscription?.cancel();

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

  /// Enroll voice with collected samples
  Future<void> _enrollVoice() async {
    try {
      emit(VoiceEnrollmentLoading());

      // Get user ID from auth state
      final userId = await _repository.getCurrentUserId();

      // Enroll voice
      final result = await _repository.enrollVoice(
        userId: userId,
        audioSamples: _recordedSamples,
      );

      // Clear saved progress after successful enrollment
      await _clearSavedProgress();

      // Emit success
      emit(VoiceEnrollmentSuccess(
        enrollmentId: result.enrollmentId,
        qualityScore: result.qualityScore,
      ));
    } catch (e) {
      // Keep saved progress on error so user can retry
      emit(VoiceEnrollmentError(
        message: 'Enrollment failed: ${e.toString()}',
      ));
    }
  }

  /// Request microphone permission
  Future<void> requestPermission() async {
    try {
      final granted = await _repository.requestMicrophonePermission();
      if (granted) {
        emit(VoiceEnrollmentInitial(
          currentStep: _currentStep,
          totalSteps: 3,
        ));
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
    emit(VoiceEnrollmentInitial(
      currentStep: _currentStep,
      totalSteps: 3,
    ));
  }

  /// Reset enrollment
  Future<void> reset() async {
    _currentStep = 0;
    _recordedSamples.clear();
    _recordingTimer?.cancel();
    _soundLevelSubscription?.cancel();
    await _clearSavedProgress();
    emit(VoiceEnrollmentInitial(currentStep: 0, totalSteps: 3));
  }

  @override
  Future<void> close() {
    _recordingTimer?.cancel();
    _soundLevelSubscription?.cancel();
    return super.close();
  }
}
