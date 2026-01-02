import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/change_passcode_usecase.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

// This will generate a mock class
@GenerateMocks([IAuthRepository])
import 'change_passcode_test.mocks.dart';

void main() {
  late ChangePasscodeUseCase changePasscodeUseCase;
  late MockIAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockIAuthRepository();
    changePasscodeUseCase = ChangePasscodeUseCase(mockAuthRepository);
  });

  group('ChangePasscodeUseCase', () {
    const testOldPasscode = '123456';
    const testNewPasscode = '654321';

    test('should change passcode successfully when valid passcodes are provided', () async {
      // Arrange
      when(mockAuthRepository.changePasscode(
        oldPasscode: testOldPasscode,
        newPasscode: testNewPasscode,
      )).thenAnswer((_) async => const Right(null));

      // Act
      final result = await changePasscodeUseCase(
        oldPasscode: testOldPasscode,
        newPasscode: testNewPasscode,
      );

      // Assert
      expect(result, const Right(null));
      verify(mockAuthRepository.changePasscode(
        oldPasscode: testOldPasscode,
        newPasscode: testNewPasscode,
      )).called(1);
    });

    test('should return ServerFailure when old passcode is incorrect', () async {
      // Arrange
      final failure = ServerFailure(
        message: 'Incorrect old passcode',
        statusCode: 400,
      );
      when(mockAuthRepository.changePasscode(
        oldPasscode: testOldPasscode,
        newPasscode: testNewPasscode,
      )).thenAnswer((_) async => Left(failure));

      // Act
      final result = await changePasscodeUseCase(
        oldPasscode: testOldPasscode,
        newPasscode: testNewPasscode,
      );

      // Assert
      expect(result, Left(failure));
      verify(mockAuthRepository.changePasscode(
        oldPasscode: testOldPasscode,
        newPasscode: testNewPasscode,
      )).called(1);
    });

    test('should return ServerFailure when network error occurs', () async {
      // Arrange
      final failure = ServerFailure(
        message: 'Network error',
        statusCode: 500,
      );
      when(mockAuthRepository.changePasscode(
        oldPasscode: testOldPasscode,
        newPasscode: testNewPasscode,
      )).thenAnswer((_) async => Left(failure));

      // Act
      final result = await changePasscodeUseCase(
        oldPasscode: testOldPasscode,
        newPasscode: testNewPasscode,
      );

      // Assert
      expect(result, Left(failure));
      verify(mockAuthRepository.changePasscode(
        oldPasscode: testOldPasscode,
        newPasscode: testNewPasscode,
      )).called(1);
    });
  });
}
