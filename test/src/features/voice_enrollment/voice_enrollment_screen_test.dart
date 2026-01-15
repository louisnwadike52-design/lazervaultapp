import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/voice_enrollment/cubit/voice_enrollment_cubit.dart';
import 'package:lazervault/src/features/voice_enrollment/cubit/voice_enrollment_state.dart';
import 'package:lazervault/src/features/voice_enrollment/presentation/voice_enrollment_screen.dart';

// Mock Cubit
class MockVoiceEnrollmentCubit extends VoiceEnrollmentCubit {
  MockVoiceEnrollmentCubit() : super.mock();

  void mockInitialState(VoiceEnrollmentState state) {
    emit(state);
  }
}

void main() {
  group('VoiceEnrollmentScreen Widget Tests', () {
    late MockVoiceEnrollmentCubit mockCubit;

    setUp(() {
      mockCubit = MockVoiceEnrollmentCubit();
    });

    Widget createTestWidget() {
      return MaterialApp(
        home: BlocProvider<VoiceEnrollmentCubit>.value(
          value: mockCubit,
          child: const VoiceEnrollmentScreen(),
        ),
      );
    }

    group('Initial State', () {
      testWidgets('should show instruction screen initially',
          (WidgetTester tester) async {
        // Arrange
        mockCubit.mockInitialState(VoiceEnrollmentInitial());

        // Act
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Assert
        expect(find.text('Voice Enrollment'), findsOneWidget);
        expect(find.text('Get Started'), findsOneWidget);
        expect(find.byIcon(Icons.mic), findsOneWidget);
      });

      testWidgets('should show enrollment steps', (WidgetTester tester) async {
        // Arrange
        mockCubit.mockInitialState(VoiceEnrollmentInitial());

        // Act
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Assert
        expect(find.text('Record 3 voice samples'), findsOneWidget);
        expect(find.text('Each sample takes 5 seconds'), findsOneWidget);
      });

      testWidgets('should show cancel button', (WidgetTester tester) async {
        // Arrange
        mockCubit.mockInitialState(VoiceEnrollmentInitial());

        // Act
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Assert
        expect(find.text('Cancel'), findsOneWidget);
      });
    });

    group('Recording State', () {
      testWidgets('should show recording UI when recording',
          (WidgetTester tester) async {
        // Arrange
        mockCubit.mockInitialState(VoiceEnrollmentRecording(
          currentStep: 1,
          soundLevel: 0.5,
        ));

        // Act
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Assert
        expect(find.text('Sample 1 of 3'), findsOneWidget);
        expect(find.text('Stop Recording'), findsOneWidget);
        expect(find.byIcon(Icons.stop), findsOneWidget);
      });

      testWidgets('should show phrase to speak', (WidgetTester tester) async {
        // Arrange
        mockCubit.mockInitialState(VoiceEnrollmentRecording(
          currentStep: 1,
          soundLevel: 0.3,
        ));

        // Act
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Assert - should show one of the phrases
        expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is Text &&
                (widget.data?.contains('My voice is my password') == true ||
                 widget.data?.contains('I authorize LazerVault transactions') == true ||
                 widget.data?.contains('Banking by voice is secure') == true),
          ),
          findsOneWidget,
        );
      });

      testWidgets('should show sound level indicator', (WidgetTester tester) async {
        // Arrange
        mockCubit.mockInitialState(VoiceEnrollmentRecording(
          currentStep: 1,
          soundLevel: 0.7,
        ));

        // Act
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Assert
        expect(find.text('Sound Level'), findsOneWidget);
        expect(find.text('70%'), findsOneWidget);
      });
    });

    group('Processing State', () {
      testWidgets('should show processing indicator', (WidgetTester tester) async {
        // Arrange
        mockCubit.mockInitialState(VoiceEnrollmentProcessing(
          currentStep: 1,
          message: 'Processing sample 1...',
        ));

        // Act
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Assert
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.text('Processing sample 1...'), findsOneWidget);
      });
    });

    group('Success State', () {
      testWidgets('should show success message', (WidgetTester tester) async {
        // Arrange
        mockCubit.mockInitialState(const VoiceEnrollmentSuccess(
          enrollmentId: 'test_enrollment_123',
          qualityScore: 0.92,
        ));

        // Act
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Assert
        expect(find.text('Voice Enrolled!'), findsOneWidget);
        expect(find.text('Enrollment ID: test_enrollment_123'), findsOneWidget);
        expect(find.text('Quality Score: 92%'), findsOneWidget);
        expect(find.text('Done'), findsOneWidget);
      });

      testWidgets('should show success animation', (WidgetTester tester) async {
        // Arrange
        mockCubit.mockInitialState(const VoiceEnrollmentSuccess(
          enrollmentId: 'test_enrollment_123',
          qualityScore: 0.88,
        ));

        // Act
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Assert
        expect(find.byIcon(Icons.check_circle), findsOneWidget);
      });
    });

    group('Error State', () {
      testWidgets('should show error message', (WidgetTester tester) async {
        // Arrange
        mockCubit.mockInitialState(const VoiceEnrollmentError(
          message: 'Microphone permission denied',
        ));

        // Act
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Assert
        expect(find.text('Enrollment Failed'), findsOneWidget);
        expect(find.text('Microphone permission denied'), findsOneWidget);
        expect(find.text('Retry'), findsOneWidget);
      });
    });

    group('User Interactions', () {
      testWidgets('should start recording when Start is tapped',
          (WidgetTester tester) async {
        // Arrange
        mockCubit.mockInitialState(VoiceEnrollmentInitial());

        // Act
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        final startButton = find.text('Get Started');
        await tester.tap(startButton);
        await tester.pumpAndSettle();

        // Assert - should call startRecording
        verify(() => mockCubit.startRecording()).called(1);
      });

      testWidgets('should stop recording when Stop is tapped',
          (WidgetTester tester) async {
        // Arrange
        mockCubit.mockInitialState(VoiceEnrollmentRecording(
          currentStep: 1,
          soundLevel: 0.5,
        ));

        // Act
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        final stopButton = find.text('Stop Recording');
        await tester.tap(stopButton);
        await tester.pumpAndSettle();

        // Assert - should call stopRecording
        verify(() => mockCubit.stopRecording()).called(1);
      });

      testWidgets('should cancel enrollment when Cancel is tapped',
          (WidgetTester tester) async {
        // Arrange
        mockCubit.mockInitialState(VoiceEnrollmentInitial());

        // Act
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        final cancelButton = find.text('Cancel');
        await tester.tap(cancelButton);
        await tester.pumpAndSettle();

        // Assert - should show confirmation dialog
        expect(find.text('Cancel Enrollment?'), findsOneWidget);
      });
    });
  });
}
