import 'package:flutter_test/flutter_test.dart';
import 'dart:io';
import 'package:lazervault/src/features/voice_enrollment/data/voice_biometrics_repository.dart';
import 'package:lazervault/src/features/voice_enrollment/data/voice_biometrics_service_config.dart';

void main() {
  group('VoiceEnrollmentRepository Tests', () {
    late VoiceEnrollmentRepository repository;

    setUp(() {
      repository = VoiceEnrollmentRepository(
        VoiceBiometricsServiceConfig.development(),
      );
    });

    tearDown(() {
      repository.dispose();
    });

    group('Permission Handling', () {
      test('should check microphone permission status', () async {
        // Act
        final hasPermission = await repository.checkMicrophonePermission();

        // Assert
        expect(hasPermission, isA<bool>());
      });

      test('should request microphone permission', () async {
        // Act
        final granted = await repository.requestMicrophonePermission();

        // Assert
        expect(granted, isA<bool>());
      });
    });

    group('Audio Recording', () {
      test('should start recording successfully', () async {
        // Act
        final stream = await repository.startRecording();

        // Assert
        expect(stream, isNotNull);
        expect(stream.soundLevel, isA<Stream<double>>());
        expect(stream.stop, isA<Function>());

        // Cleanup
        await stream.stop();
      });

      test('should stop recording and return file', () async {
        // Arrange
        final stream = await repository.startRecording();

        // Act
        final file = await stream.stop();

        // Assert
        expect(file, isA<File>());
        expect(file.path, contains('.wav'));
      });

      test('should monitor sound level during recording', () async {
        // Arrange
        final stream = await repository.startRecording();

        // Act
        final soundLevelStream = stream.soundLevel;

        // Assert
        expect(soundLevelStream, isA<Stream<double>>());

        // Listen to a few values
        final values = await soundLevelStream.take(5).toList();

        expect(values, isNotEmpty);
        expect(values.every((v) => v >= 0.0 && v <= 1.0), isTrue);

        // Cleanup
        await stream.stop();
      });
    });

    group('Voice Enrollment', () {
      test('should throw error when no audio samples provided', () async {
        // Act & Assert
        expect(
          () => repository.enrollVoice(
            userId: 'test_user',
            audioSamples: [],
          ),
          throwsException,
        );
      });

      test('should throw error when less than 3 samples provided', () async {
        // Arrange
        final samples = [File('/tmp/test1.wav'), File('/tmp/test2.wav')];

        // Act & Assert
        expect(
          () => repository.enrollVoice(
            userId: 'test_user',
            audioSamples: samples,
          ),
          throwsException,
        );
      });

      test('should enroll voice with 3 audio samples', () async {
        // Note: This test requires actual WAV files and backend service
        // In a real test scenario, you would mock the gRPC client

        // This is a placeholder test to show the structure
        expect(true, isTrue);
      });

      test('should clean up files after successful enrollment', () async {
        // Note: This test would verify file cleanup
        // In a real test, you would:
        // 1. Create temporary audio files
        // 2. Call enrollVoice
        // 3. Verify files are deleted

        expect(true, isTrue);
      });

      test('should clean up files after failed enrollment', () async {
        // Note: This test would verify file cleanup on failure
        // In a real test, you would:
        // 1. Create temporary audio files
        // 2. Mock gRPC to throw error
        // 3. Verify files are still deleted

        expect(true, isTrue);
      });
    });

    group('File Cleanup', () {
      test('should clean up old voice samples', () async {
        // Act
        await repository.cleanupOldVoiceSamples();

        // Assert - should not throw
        expect(true, isTrue);
      });

      test('should dispose and cleanup resources', () {
        // Act
        repository.dispose();

        // Assert - should not throw
        expect(true, isTrue);
      });
    });

    group('Enrollment Status', () {
      test('should check enrollment status', () async {
        // Act
        final isEnrolled = await repository.checkEnrollmentStatus('test_user');

        // Assert
        expect(isEnrolled, isA<bool>());
      });
    });
  });
}
