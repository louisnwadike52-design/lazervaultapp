part of 'voice_enrollment_cubit.dart';

/// Enrollment phrases used across states
const List<String> enrollmentPhrases = [
  'My voice is my password',
  'I authorize LazerVault transactions',
  'Banking by voice is secure and convenient',
];

/// Base state for voice enrollment
abstract class VoiceEnrollmentState {}

/// Initial state - enrollment not started
class VoiceEnrollmentInitial extends VoiceEnrollmentState {
  final int currentStep;
  final int totalSteps;

  VoiceEnrollmentInitial({
    this.currentStep = 0,
    this.totalSteps = 3,
  });

  List<String> get phrases => enrollmentPhrases;

  String get currentPhrase => phrases[currentStep];
}

/// Loading state - processing enrollment
class VoiceEnrollmentLoading extends VoiceEnrollmentState {
  VoiceEnrollmentLoading();
}

/// Recording state - capturing voice sample
class VoiceEnrollmentRecording extends VoiceEnrollmentState {
  final int currentStep;
  final int totalSteps;
  final double soundLevel; // 0.0 to 1.0

  VoiceEnrollmentRecording({
    required this.currentStep,
    this.totalSteps = 3,
    this.soundLevel = 0.0,
  });

  List<String> get phrases => enrollmentPhrases;

  String get currentPhrase => phrases[currentStep];

  VoiceEnrollmentRecording copyWith({double? soundLevel}) {
    return VoiceEnrollmentRecording(
      currentStep: currentStep,
      totalSteps: totalSteps,
      soundLevel: soundLevel ?? this.soundLevel,
    );
  }
}

/// Processing state - analyzing recording
class VoiceEnrollmentProcessing extends VoiceEnrollmentState {
  final int currentStep;
  final int totalSteps;

  VoiceEnrollmentProcessing({
    required this.currentStep,
    this.totalSteps = 3,
  });

  String get message => switch (currentStep) {
    0 => 'Analyzing first sample...',
    1 => 'Analyzing second sample...',
    2 => 'Analyzing final sample...',
    _ => 'Processing...',
  };
}

/// Success state - enrollment completed
class VoiceEnrollmentSuccess extends VoiceEnrollmentState {
  final String enrollmentId;
  final double qualityScore;

  VoiceEnrollmentSuccess({
    required this.enrollmentId,
    required this.qualityScore,
  });
}

/// Error state - enrollment failed
class VoiceEnrollmentError extends VoiceEnrollmentState {
  final String message;
  final String? errorCode;

  VoiceEnrollmentError({
    required this.message,
    this.errorCode,
  });
}

/// Permission denied state
class VoiceEnrollmentPermissionDenied extends VoiceEnrollmentState {
  final String message;

  VoiceEnrollmentPermissionDenied({
    this.message = 'Microphone permission is required for voice enrollment',
  });
}

/// Carousel state — drives the single-screen carousel enrollment UI
class VoiceEnrollmentCarouselState extends VoiceEnrollmentState {
  final int activePage;
  final List<bool> sampleCompleted;
  final bool isRecording;
  final double soundLevel;
  final bool isProcessing;

  VoiceEnrollmentCarouselState({
    this.activePage = 0,
    List<bool>? sampleCompleted,
    this.isRecording = false,
    this.soundLevel = 0.0,
    this.isProcessing = false,
  }) : sampleCompleted = sampleCompleted ?? [false, false, false];

  int get completedCount => sampleCompleted.where((s) => s).length;
  bool get allCompleted => sampleCompleted.every((s) => s);
  String get currentPhrase => enrollmentPhrases[activePage];
  bool get currentPageCompleted => sampleCompleted[activePage];

  VoiceEnrollmentCarouselState copyWith({
    int? activePage,
    List<bool>? sampleCompleted,
    bool? isRecording,
    double? soundLevel,
    bool? isProcessing,
  }) {
    return VoiceEnrollmentCarouselState(
      activePage: activePage ?? this.activePage,
      sampleCompleted: sampleCompleted ?? List.from(this.sampleCompleted),
      isRecording: isRecording ?? this.isRecording,
      soundLevel: soundLevel ?? this.soundLevel,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}
