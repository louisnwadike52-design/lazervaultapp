import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:lazervaultapp/src/features/ai_scan_to_pay/presentation/cubit/ai_scan_cubit.dart';
import 'package:lazervaultapp/src/features/ai_scan_to_pay/domain/usecases/scan_bank_details_usecase.dart';
import 'package:lazervaultapp/src/features/ai_scan_to_pay/domain/usecases/process_bank_details_payment_usecase.dart';
import 'package:lazervaultapp/src/features/ai_scan_to_pay/domain/entities/bank_details.dart';
import 'package:lazervaultapp/src/features/ai_scan_to_pay/domain/entities/payment_receipt.dart';
import 'package:lazervaultapp/src/features/ai_scan_to_pay/domain/exceptions/scan_exceptions.dart';

// Mocks
class MockScanBankDetailsUseCase extends Mock implements ScanBankDetailsUseCase {}
class MockProcessBankDetailsPaymentUseCase extends Mock implements ProcessBankDetailsPaymentUseCase {}

void main() {
  late AiScanCubit cubit;
  late MockScanBankDetailsUseCase mockScanUseCase;
  late MockProcessBankDetailsPaymentUseCase mockProcessPaymentUseCase;

  setUp(() {
    mockScanUseCase = MockScanBankDetailsUseCase();
    mockProcessPaymentUseCase = MockProcessBankDetailsPaymentUseCase();

    cubit = AiScanCubit(
      scanBankDetailsUseCase: mockScanUseCase,
      processBankDetailsPaymentUseCase: mockProcessPaymentUseCase,
    );

    // Register fallback values
    registerFallbackValue(BankDetailsModel(
      accountNumber: '',
      accountName: '',
      bankName: '',
      accountType: 'internal',
      confidenceScore: 0.0,
      fieldConfidence: {},
    ));
  });

  tearDown(() {
    cubit.close();
  });

  group('AiScanCubit - processBankDetailsImage', () {
    const imagePath = '/path/to/image.jpg';
    const sessionId = 'test-session-123';

    final bankDetails = BankDetailsModel(
      accountNumber: '0123456789',
      accountName: 'John Doe',
      bankName: 'Chase Bank',
      accountType: 'internal',
      confidenceScore: 0.95,
      fieldConfidence: {
        'account_number': 0.95,
        'account_name': 0.92,
        'bank_name': 0.90,
      },
    );

    blocTest<AiScanCubit, AiScanState>(
      'emits [Processing, BankDetailsExtracted] when OCR succeeds',
      build: () {
        when(() => mockScanUseCase(imagePath, sessionId))
            .thenAnswer((_) async => bankDetails);
        return cubit;
      },
      act: (cubit) => cubit.processBankDetailsImage(imagePath),
      expect: () => [
        isA<AiScanProcessing>()
            .having((s) => s.status, 'status', contains('Extracting')),
        isA<AiScanBankDetailsExtracted>()
            .having((s) => s.bankDetails.accountNumber, 'accountNumber', '0123456789')
            .having((s) => s.bankDetails.accountName, 'accountName', 'John Doe')
            .having((s) => s.bankDetails.confidenceScore, 'confidenceScore', 0.95),
      ],
      verify: (_) {
        verify(() => mockScanUseCase(imagePath, sessionId)).called(1);
      },
    );

    blocTest<AiScanCubit, AiScanState>(
      'emits [Processing, Error] when OCR fails with OCRException',
      build: () {
        when(() => mockScanUseCase(imagePath, sessionId))
            .thenThrow(OCRException.lowConfidence(confidence: 0.25));
        return cubit;
      },
      act: (cubit) => cubit.processBankDetailsImage(imagePath),
      expect: () => [
        isA<AiScanProcessing>(),
        isA<AiScanError>()
            .having((s) => s.message, 'message', contains('Image quality'))
            .having((s) => s.canRetry, 'canRetry', true),
      ],
    );

    blocTest<AiScanCubit, AiScanState>(
      'emits [Processing, Error] when network error occurs',
      build: () {
        when(() => mockScanUseCase(imagePath, sessionId))
            .thenThrow(NetworkException.noConnection());
        return cubit;
      },
      act: (cubit) => cubit.processBankDetailsImage(imagePath),
      expect: () => [
        isA<AiScanProcessing>(),
        isA<AiScanError>()
            .having((s) => s.message, 'message', contains('internet'))
            .having((s) => s.canRetry, 'canRetry', true),
      ],
    );

    blocTest<AiScanCubit, AiScanState>(
      'emits [Processing, Error] when rate limit exceeded',
      build: () {
        when(() => mockScanUseCase(imagePath, sessionId))
            .thenThrow(RateLimitException.tooManyRequests(retryAfter: 60));
        return cubit;
      },
      act: (cubit) => cubit.processBankDetailsImage(imagePath),
      expect: () => [
        isA<AiScanProcessing>(),
        isA<AiScanError>()
            .having((s) => s.message, 'message', contains('Too many'))
            .having((s) => s.canRetry, 'canRetry', true),
      ],
    );

    blocTest<AiScanCubit, AiScanState>(
      'emits [Processing, Error] when authentication fails',
      build: () {
        when(() => mockScanUseCase(imagePath, sessionId))
            .thenThrow(AuthenticationException.notAuthenticated());
        return cubit;
      },
      act: (cubit) => cubit.processBankDetailsImage(imagePath),
      expect: () => [
        isA<AiScanProcessing>(),
        isA<AiScanError>()
            .having((s) => s.message, 'message', contains('sign in'))
            .having((s) => s.canRetry, 'canRetry', false),
      ],
    );

    blocTest<AiScanCubit, AiScanState>(
      'emits [Processing, Error] when image processing times out',
      build: () {
        when(() => mockScanUseCase(imagePath, sessionId))
            .thenThrow(OCRException.processingTimeout());
        return cubit;
      },
      act: (cubit) => cubit.processBankDetailsImage(imagePath),
      expect: () => [
        isA<AiScanProcessing>(),
        isA<AiScanError>()
            .having((s) => s.message, 'message', contains('time'))
            .having((s) => s.canRetry, 'canRetry', true),
      ],
    );
  });

  group('AiScanCubit - initiatePayment', () {
    final bankDetails = BankDetailsModel(
      accountNumber: '0123456789',
      accountName: 'John Doe',
      bankName: 'Chase Bank',
      accountType: 'internal',
      confidenceScore: 0.95,
      fieldConfidence: {},
    );

    const amount = 100.0;
    const description = 'Payment for services';

    blocTest<AiScanCubit, AiScanState>(
      'emits AwaitingPIN state when initiation succeeds',
      build: () => cubit,
      act: (cubit) => cubit.initiatePayment(
        bankDetails: bankDetails,
        amount: amount,
        description: description,
      ),
      expect: () => [
        isA<AiScanBankDetailsAwaitingPIN>()
            .having((s) => s.bankDetails, 'bankDetails', bankDetails)
            .having((s) => s.amount, 'amount', amount)
            .having((s) => s.transactionId, 'transactionId', isNotEmpty),
      ],
    );

    blocTest<AiScanCubit, AiScanState>(
      'generates unique transaction ID for each payment',
      build: () => cubit,
      act: (cubit) async {
        await cubit.initiatePayment(
          bankDetails: bankDetails,
          amount: amount,
          description: description,
        );
        final state1 = cubit.state as AiScanBankDetailsAwaitingPIN;

        await cubit.initiatePayment(
          bankDetails: bankDetails,
          amount: amount,
          description: description,
        );
        final state2 = cubit.state as AiScanBankDetailsAwaitingPIN;

        expect(state1.transactionId, isNot(equals(state2.transactionId)));
      },
      skip: 1,
    );
  });

  group('AiScanCubit - processPaymentWithPIN', () {
    final bankDetails = BankDetailsModel(
      accountNumber: '0123456789',
      accountName: 'John Doe',
      bankName: 'Chase Bank',
      accountType: 'internal',
      confidenceScore: 0.95,
      fieldConfidence: {},
    );

    const amount = 100.0;
    const description = 'Payment for services';
    const verificationToken = 'valid-pin-token';
    const transactionId = 'TXN-123456';

    final receipt = PaymentReceipt(
      id: 'payment-123',
      reference: transactionId,
      recipientName: 'John Doe',
      accountNumber: '0123456789',
      maskedAccountNumber: '****6789',
      bankName: 'Chase Bank',
      amount: amount,
      currency: 'USD',
      description: description,
      status: 'completed',
      timestamp: DateTime.now(),
      isExternal: false,
    );

    blocTest<AiScanCubit, AiScanState>(
      'emits [Processing, PaymentSuccess] when payment succeeds',
      build: () {
        when(() => mockProcessPaymentUseCase(
          bankDetails: any(named: 'bankDetails'),
          amount: any(named: 'amount'),
          description: any(named: 'description'),
          verificationToken: any(named: 'verificationToken'),
          transactionId: any(named: 'transactionId'),
        )).thenAnswer((_) async => receipt);
        return cubit;
      },
      act: (cubit) => cubit.processPaymentWithPIN(
        bankDetails: bankDetails,
        amount: amount,
        description: description,
        verificationToken: verificationToken,
        transactionId: transactionId,
      ),
      expect: () => [
        isA<AiScanBankDetailsProcessing>()
            .having((s) => s.status, 'status', contains('Processing'))
            .having((s) => s.progress, 'progress', 0.6),
        isA<AiScanBankDetailsPaymentSuccess>()
            .having((s) => s.receipt.reference, 'reference', transactionId)
            .having((s) => s.receipt.recipientName, 'recipientName', 'John Doe')
            .having((s) => s.receipt.amount, 'amount', amount),
      ],
      verify: (_) {
        verify(() => mockProcessPaymentUseCase(
          bankDetails: any(named: 'bankDetails'),
          amount: amount,
          description: description,
          verificationToken: verificationToken,
          transactionId: transactionId,
        )).called(1);
      },
    );

    blocTest<AiScanCubit, AiScanState>(
      'emits [Processing, PaymentFailed] when payment fails with InsufficientFundsException',
      build: () {
        when(() => mockProcessPaymentUseCase(
          bankDetails: any(named: 'bankDetails'),
          amount: any(named: 'amount'),
          description: any(named: 'description'),
          verificationToken: any(named: 'verificationToken'),
          transactionId: any(named: 'transactionId'),
        )).thenThrow(PaymentException.insufficientFunds(
          availableBalance: 50.0,
          requestedAmount: 100.0,
        ));
        return cubit;
      },
      act: (cubit) => cubit.processPaymentWithPIN(
        bankDetails: bankDetails,
        amount: amount,
        description: description,
        verificationToken: verificationToken,
        transactionId: transactionId,
      ),
      expect: () => [
        isA<AiScanBankDetailsProcessing>(),
        isA<AiScanBankDetailsPaymentFailed>()
            .having((s) => s.errorMessage, 'errorMessage', contains('Insufficient'))
            .having((s) => s.errorMessage, 'errorMessage', contains('50.00'))
            .having((s) => s.canRetry, 'canRetry', false),
      ],
    );

    blocTest<AiScanCubit, AiScanState>(
      'emits [Processing, PaymentFailed] when PIN is locked',
      build: () {
        final unlockTime = DateTime.now().add(const Duration(minutes: 30));
        when(() => mockProcessPaymentUseCase(
          bankDetails: any(named: 'bankDetails'),
          amount: any(named: 'amount'),
          description: any(named: 'description'),
          verificationToken: any(named: 'verificationToken'),
          transactionId: any(named: 'transactionId'),
        )).thenThrow(AuthenticationException.pinLocked(unlocksAt: unlockTime));
        return cubit;
      },
      act: (cubit) => cubit.processPaymentWithPIN(
        bankDetails: bankDetails,
        amount: amount,
        description: description,
        verificationToken: verificationToken,
        transactionId: transactionId,
      ),
      expect: () => [
        isA<AiScanBankDetailsProcessing>(),
        isA<AiScanBankDetailsPaymentFailed>()
            .having((s) => s.errorMessage, 'errorMessage', contains('locked'))
            .having((s) => s.canRetry, 'canRetry', false),
      ],
    );

    blocTest<AiScanCubit, AiScanState>(
      'emits [Processing, PaymentFailed] when validation fails',
      build: () {
        when(() => mockProcessPaymentUseCase(
          bankDetails: any(named: 'bankDetails'),
          amount: any(named: 'amount'),
          description: any(named: 'description'),
          verificationToken: any(named: 'verificationToken'),
          transactionId: any(named: 'transactionId'),
        )).thenThrow(ValidationException.invalidAmount(
          message: 'Amount exceeds daily limit',
        ));
        return cubit;
      },
      act: (cubit) => cubit.processPaymentWithPIN(
        bankDetails: bankDetails,
        amount: amount,
        description: description,
        verificationToken: verificationToken,
        transactionId: transactionId,
      ),
      expect: () => [
        isA<AiScanBankDetailsProcessing>(),
        isA<AiScanBankDetailsPaymentFailed>()
            .having((s) => s.errorMessage, 'errorMessage', contains('daily limit'))
            .having((s) => s.canRetry, 'canRetry', false),
      ],
    );

    blocTest<AiScanCubit, AiScanState>(
      'emits [Processing, PaymentFailed] when network error occurs',
      build: () {
        when(() => mockProcessPaymentUseCase(
          bankDetails: any(named: 'bankDetails'),
          amount: any(named: 'amount'),
          description: any(named: 'description'),
          verificationToken: any(named: 'verificationToken'),
          transactionId: any(named: 'transactionId'),
        )).thenThrow(NetworkException.timeout());
        return cubit;
      },
      act: (cubit) => cubit.processPaymentWithPIN(
        bankDetails: bankDetails,
        amount: amount,
        description: description,
        verificationToken: verificationToken,
        transactionId: transactionId,
      ),
      expect: () => [
        isA<AiScanBankDetailsProcessing>(),
        isA<AiScanBankDetailsPaymentFailed>()
            .having((s) => s.errorMessage, 'errorMessage', contains('timed out'))
            .having((s) => s.canRetry, 'canRetry', true),
      ],
    );

    blocTest<AiScanCubit, AiScanState>(
      'emits [Processing, PaymentFailed] when generic payment error occurs',
      build: () {
        when(() => mockProcessPaymentUseCase(
          bankDetails: any(named: 'bankDetails'),
          amount: any(named: 'amount'),
          description: any(named: 'description'),
          verificationToken: any(named: 'verificationToken'),
          transactionId: any(named: 'transactionId'),
        )).thenThrow(PaymentException.paymentFailed(
          message: 'Unknown payment error',
        ));
        return cubit;
      },
      act: (cubit) => cubit.processPaymentWithPIN(
        bankDetails: bankDetails,
        amount: amount,
        description: description,
        verificationToken: verificationToken,
        transactionId: transactionId,
      ),
      expect: () => [
        isA<AiScanBankDetailsProcessing>(),
        isA<AiScanBankDetailsPaymentFailed>()
            .having((s) => s.errorMessage, 'errorMessage', contains('Unknown'))
            .having((s) => s.canRetry, 'canRetry', true),
      ],
    );
  });

  group('AiScanCubit - End-to-End Flow', () {
    const imagePath = '/path/to/image.jpg';
    const sessionId = 'test-session-123';

    final bankDetails = BankDetailsModel(
      accountNumber: '0123456789',
      accountName: 'John Doe',
      bankName: 'Chase Bank',
      accountType: 'internal',
      confidenceScore: 0.95,
      fieldConfidence: {},
    );

    const amount = 100.0;
    const description = 'Payment for services';

    final receipt = PaymentReceipt(
      id: 'payment-123',
      reference: 'TXN-123456',
      recipientName: 'John Doe',
      accountNumber: '0123456789',
      maskedAccountNumber: '****6789',
      bankName: 'Chase Bank',
      amount: amount,
      currency: 'USD',
      description: description,
      status: 'completed',
      timestamp: DateTime.now(),
      isExternal: false,
    );

    blocTest<AiScanCubit, AiScanState>(
      'completes full payment flow from scan to receipt',
      build: () {
        when(() => mockScanUseCase(imagePath, sessionId))
            .thenAnswer((_) async => bankDetails);
        when(() => mockProcessPaymentUseCase(
          bankDetails: any(named: 'bankDetails'),
          amount: any(named: 'amount'),
          description: any(named: 'description'),
          verificationToken: any(named: 'verificationToken'),
          transactionId: any(named: 'transactionId'),
        )).thenAnswer((_) async => receipt);
        return cubit;
      },
      act: (cubit) async {
        // Step 1: Process image
        await cubit.processBankDetailsImage(imagePath);

        // Step 2: Initiate payment
        await cubit.initiatePayment(
          bankDetails: bankDetails,
          amount: amount,
          description: description,
        );

        // Step 3: Process payment with PIN
        final awaitingPINState = cubit.state as AiScanBankDetailsAwaitingPIN;
        await cubit.processPaymentWithPIN(
          bankDetails: bankDetails,
          amount: amount,
          description: description,
          verificationToken: 'valid-token',
          transactionId: awaitingPINState.transactionId,
        );
      },
      expect: () => [
        // Image processing
        isA<AiScanProcessing>(),
        isA<AiScanBankDetailsExtracted>(),

        // Payment initiation
        isA<AiScanBankDetailsAwaitingPIN>(),

        // Payment processing
        isA<AiScanBankDetailsProcessing>(),
        isA<AiScanBankDetailsPaymentSuccess>(),
      ],
    );
  });

  group('AiScanCubit - State Persistence', () {
    test('initial state is AiScanInitial', () {
      expect(cubit.state, isA<AiScanInitial>());
    });

    blocTest<AiScanCubit, AiScanState>(
      'maintains bank details state after extraction',
      build: () {
        final bankDetails = BankDetailsModel(
          accountNumber: '0123456789',
          accountName: 'John Doe',
          bankName: 'Chase Bank',
          accountType: 'internal',
          confidenceScore: 0.95,
          fieldConfidence: {},
        );
        when(() => mockScanUseCase(any(), any()))
            .thenAnswer((_) async => bankDetails);
        return cubit;
      },
      act: (cubit) => cubit.processBankDetailsImage('/path/to/image.jpg'),
      verify: (cubit) {
        final state = cubit.state as AiScanBankDetailsExtracted;
        expect(state.bankDetails.accountNumber, '0123456789');
        expect(state.bankDetails.accountName, 'John Doe');
      },
    );
  });
}
