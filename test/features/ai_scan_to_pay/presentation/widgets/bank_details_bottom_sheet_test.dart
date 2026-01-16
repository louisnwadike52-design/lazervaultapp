import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mocktail/mocktail.dart';

import 'package:lazervaultapp/src/features/ai_scan_to_pay/presentation/widgets/bank_details_bottom_sheet.dart';
import 'package:lazervaultapp/src/features/ai_scan_to_pay/presentation/cubit/ai_scan_cubit.dart';
import 'package:lazervaultapp/src/features/ai_scan_to_pay/domain/entities/bank_details.dart';
import 'package:lazervaultapp/src/features/accounts/presentation/cubit/account_cubit.dart';

// Mocks
class MockAiScanCubit extends Mock implements AiScanCubit {}
class MockAccountCubit extends Mock implements AccountCubit {}

void main() {
  late MockAiScanCubit mockAiScanCubit;
  late MockAccountCubit mockAccountCubit;

  setUp(() {
    mockAiScanCubit = MockAiScanCubit();
    mockAccountCubit = MockAccountCubit();

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

  Widget createWidgetUnderTest(BankDetailsModel bankDetails) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<AiScanCubit>.value(value: mockAiScanCubit),
              BlocProvider<AccountCubit>.value(value: mockAccountCubit),
            ],
            child: Scaffold(
              body: BankDetailsBottomSheet(
                extractedDetails: bankDetails,
                sessionId: 'test-session-id',
              ),
            ),
          ),
        );
      },
    );
  }

  group('BankDetailsBottomSheet - UI Display', () {
    testWidgets('displays extracted bank details correctly', (tester) async {
      // Arrange
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

      // Act
      await tester.pumpWidget(createWidgetUnderTest(bankDetails));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('0123456789'), findsOneWidget);
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('Chase Bank'), findsOneWidget);
      expect(find.text('Bank Details'), findsOneWidget);
    });

    testWidgets('displays "LazerVault User" badge for internal accounts', (tester) async {
      // Arrange
      final bankDetails = BankDetailsModel(
        accountNumber: '0123456789',
        accountName: 'Jane Doe',
        bankName: 'LazerVault',
        accountType: 'internal',
        confidenceScore: 0.90,
        fieldConfidence: {},
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(bankDetails));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('LazerVault User'), findsOneWidget);
    });

    testWidgets('displays "External Bank" badge for external accounts', (tester) async {
      // Arrange
      final bankDetails = BankDetailsModel(
        accountNumber: '0123456789',
        accountName: 'John Smith',
        bankName: 'Access Bank',
        accountType: 'external',
        confidenceScore: 0.85,
        fieldConfidence: {},
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(bankDetails));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('External Bank'), findsOneWidget);
    });

    testWidgets('displays "Verified" badge for account name', (tester) async {
      // Arrange
      final bankDetails = BankDetailsModel(
        accountNumber: '0123456789',
        accountName: 'John Doe',
        bankName: 'Chase Bank',
        accountType: 'internal',
        confidenceScore: 0.90,
        fieldConfidence: {},
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(bankDetails));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Verified'), findsOneWidget);
      expect(find.byIcon(Icons.verified), findsOneWidget);
    });

    testWidgets('displays routing number field when available', (tester) async {
      // Arrange
      final bankDetails = BankDetailsModel(
        accountNumber: '0123456789',
        accountName: 'John Doe',
        bankName: 'Chase Bank',
        routingNumber: '021000021',
        accountType: 'internal',
        confidenceScore: 0.90,
        fieldConfidence: {},
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(bankDetails));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('021000021'), findsOneWidget);
      expect(find.text('Routing Number'), findsOneWidget);
    });

    testWidgets('does not display routing number field when not available', (tester) async {
      // Arrange
      final bankDetails = BankDetailsModel(
        accountNumber: '0123456789',
        accountName: 'John Doe',
        bankName: 'Chase Bank',
        routingNumber: null,
        accountType: 'internal',
        confidenceScore: 0.90,
        fieldConfidence: {},
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(bankDetails));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Routing Number'), findsNothing);
    });

    testWidgets('displays confidence badges correctly', (tester) async {
      // Arrange - High confidence
      final bankDetails = BankDetailsModel(
        accountNumber: '0123456789',
        accountName: 'John Doe',
        bankName: 'Chase Bank',
        accountType: 'internal',
        confidenceScore: 0.95,
        fieldConfidence: {
          'account_number': 0.95,
        },
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(bankDetails));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('High'), findsOneWidget);
    });

    testWidgets('displays low confidence warning when confidence < 0.8', (tester) async {
      // Arrange
      final bankDetails = BankDetailsModel(
        accountNumber: '0123456789',
        accountName: 'John Doe',
        bankName: 'Chase Bank',
        accountType: 'internal',
        confidenceScore: 0.55,
        fieldConfidence: {},
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(bankDetails));
      await tester.pumpAndSettle();

      // Assert - Should display LowConfidenceWarning widget
      expect(find.textContaining('may be incorrect'), findsOneWidget);
    });

    testWidgets('displays drag handle at the top', (tester) async {
      // Arrange
      final bankDetails = BankDetailsModel(
        accountNumber: '0123456789',
        accountName: 'John Doe',
        bankName: 'Chase Bank',
        accountType: 'internal',
        confidenceScore: 0.90,
        fieldConfidence: {},
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(bankDetails));
      await tester.pumpAndSettle();

      // Assert - Find the drag handle container
      final dragHandle = find.byType(Container).evaluate().firstWhere(
        (widget) {
          final container = widget.widget as Container;
          final decoration = container.decoration as BoxDecoration?;
          return decoration?.borderRadius != null;
        },
        orElse: () => widget.widget as Container,
      );
      expect(dragHandle, isNotNull);
    });
  });

  group('BankDetailsBottomSheet - Form Validation', () {
    testWidgets('validates empty account number', (tester) async {
      // Arrange
      final bankDetails = BankDetailsModel(
        accountNumber: '',
        accountName: 'John Doe',
        bankName: 'Chase Bank',
        accountType: 'internal',
        confidenceScore: 0.90,
        fieldConfidence: {},
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(bankDetails));
      await tester.pumpAndSettle();

      // Tap "Proceed to Pay" button
      await tester.tap(find.text('Proceed to Pay'));
      await tester.pumpAndSettle();

      // Assert - Should show validation error
      expect(find.text('Account number is required'), findsOneWidget);
    });

    testWidgets('validates account number length (too short)', (tester) async {
      // Arrange
      final bankDetails = BankDetailsModel(
        accountNumber: '123',
        accountName: 'John Doe',
        bankName: 'Chase Bank',
        accountType: 'internal',
        confidenceScore: 0.90,
        fieldConfidence: {},
      );

      when(() => mockAccountCubit.state).thenReturn(
        AccountState(balance: 1000.0),
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(bankDetails));
      await tester.pumpAndSettle();

      // Enter amount
      final amountField = find.byType(TextFormField).last;
      await tester.enterText(amountField, '100');
      await tester.pumpAndSettle();

      // Tap submit
      await tester.tap(find.text('Proceed to Pay'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Invalid account number length'), findsOneWidget);
    });

    testWidgets('validates empty amount', (tester) async {
      // Arrange
      final bankDetails = BankDetailsModel(
        accountNumber: '0123456789',
        accountName: 'John Doe',
        bankName: 'Chase Bank',
        accountType: 'internal',
        confidenceScore: 0.90,
        fieldConfidence: {},
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(bankDetails));
      await tester.pumpAndSettle();

      // Tap submit without entering amount
      await tester.tap(find.text('Proceed to Pay'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Amount is required'), findsOneWidget);
    });

    testWidgets('validates insufficient balance', (tester) async {
      // Arrange
      final bankDetails = BankDetailsModel(
        accountNumber: '0123456789',
        accountName: 'John Doe',
        bankName: 'Chase Bank',
        accountType: 'internal',
        confidenceScore: 0.90,
        fieldConfidence: {},
      );

      when(() => mockAccountCubit.state).thenReturn(
        AccountState(balance: 50.0),
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(bankDetails));
      await tester.pumpAndSettle();

      // Enter amount exceeding balance
      final amountField = find.byType(TextFormField).last;
      await tester.enterText(amountField, '100');
      await tester.pumpAndSettle();

      // Tap submit
      await tester.tap(find.text('Proceed to Pay'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.textContaining('Insufficient balance'), findsOneWidget);
    });

    testWidgets('validates negative amount', (tester) async {
      // Arrange
      final bankDetails = BankDetailsModel(
        accountNumber: '0123456789',
        accountName: 'John Doe',
        bankName: 'Chase Bank',
        accountType: 'internal',
        confidenceScore: 0.90,
        fieldConfidence: {},
      );

      when(() => mockAccountCubit.state).thenReturn(
        AccountState(balance: 1000.0),
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(bankDetails));
      await tester.pumpAndSettle();

      // Enter negative amount
      final amountField = find.byType(TextFormField).last;
      await tester.enterText(amountField, '-50');
      await tester.pumpAndSettle();

      // Tap submit
      await tester.tap(find.text('Proceed to Pay'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Enter a valid amount'), findsOneWidget);
    });
  });

  group('BankDetailsBottomSheet - User Interactions', () {
    testWidgets('allows editing account number field', (tester) async {
      // Arrange
      final bankDetails = BankDetailsModel(
        accountNumber: '0123456789',
        accountName: 'John Doe',
        bankName: 'Chase Bank',
        accountType: 'internal',
        confidenceScore: 0.90,
        fieldConfidence: {},
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(bankDetails));
      await tester.pumpAndSettle();

      // Find account number field
      final accountField = find.byType(TextFormField).first;
      await tester.enterText(accountField, '9876543210');
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('9876543210'), findsOneWidget);
    });

    testWidgets('does not allow editing account name field', (tester) async {
      // Arrange
      final bankDetails = BankDetailsModel(
        accountNumber: '0123456789',
        accountName: 'John Doe',
        bankName: 'Chase Bank',
        accountType: 'internal',
        confidenceScore: 0.90,
        fieldConfidence: {},
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(bankDetails));
      await tester.pumpAndSettle();

      // Find account name field (should be read-only)
      final accountNameFields = find.byType(TextFormField).evaluate().toList();
      final accountNameField = accountNameFields.firstWhere(
        (element) => (element.widget as TextFormField).controller?.text == 'John Doe',
      );

      // Assert - Field should be read-only
      expect((accountNameField.widget as TextFormField).readOnly, isTrue);
    });

    testWidgets('allows entering amount', (tester) async {
      // Arrange
      final bankDetails = BankDetailsModel(
        accountNumber: '0123456789',
        accountName: 'John Doe',
        bankName: 'Chase Bank',
        accountType: 'internal',
        confidenceScore: 0.90,
        fieldConfidence: {},
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(bankDetails));
      await tester.pumpAndSettle();

      // Enter amount
      final amountField = find.byType(TextFormField).last;
      await tester.enterText(amountField, '150.50');
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('150.50'), findsOneWidget);
    });

    testWidgets('allows entering optional description', (tester) async {
      // Arrange
      final bankDetails = BankDetailsModel(
        accountNumber: '0123456789',
        accountName: 'John Doe',
        bankName: 'Chase Bank',
        accountType: 'internal',
        confidenceScore: 0.90,
        fieldConfidence: {},
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(bankDetails));
      await tester.pumpAndSettle();

      // Find description field
      final descriptionField = find.byType(TextFormField).evaluate().toList().firstWhere(
        (element) => (element.widget as TextFormField).decoration?.hintText?.contains('description') ?? false,
      );

      await tester.enterText(find.byWidget(descriptionField.widget), 'Payment for services');
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Payment for services'), findsOneWidget);
    });

    testWidgets('closes bottomsheet when close button tapped', (tester) async {
      // Arrange
      final bankDetails = BankDetailsModel(
        accountNumber: '0123456789',
        accountName: 'John Doe',
        bankName: 'Chase Bank',
        accountType: 'internal',
        confidenceScore: 0.90,
        fieldConfidence: {},
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(bankDetails));
      await tester.pumpAndSettle();

      // Tap close button
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      // Assert - Bottomsheet should be closed (widget no longer in tree)
      expect(find.byType(BankDetailsBottomSheet), findsNothing);
    });

    testWidgets('triggers payment initiation when "Proceed to Pay" tapped with valid data', (tester) async {
      // Arrange
      final bankDetails = BankDetailsModel(
        accountNumber: '0123456789',
        accountName: 'John Doe',
        bankName: 'Chase Bank',
        accountType: 'internal',
        confidenceScore: 0.90,
        fieldConfidence: {},
      );

      when(() => mockAccountCubit.state).thenReturn(
        AccountState(balance: 1000.0),
      );

      when(() => mockAiScanCubit.initiatePayment(
        bankDetails: any(named: 'bankDetails'),
        amount: any(named: 'amount'),
        description: any(named: 'description'),
      )).thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest(bankDetails));
      await tester.pumpAndSettle();

      // Enter valid amount
      final amountField = find.byType(TextFormField).last;
      await tester.enterText(amountField, '100');
      await tester.pumpAndSettle();

      // Tap proceed
      await tester.tap(find.text('Proceed to Pay'));
      await tester.pumpAndSettle();

      // Assert - Should call initiatePayment
      verify(() => mockAiScanCubit.initiatePayment(
        bankDetails: any(named: 'bankDetails'),
        amount: 100.0,
        description: any(named: 'description'),
      )).called(1);
    });
  });

  group('BankDetailsBottomSheet - Confidence Display', () {
    testWidgets('displays "High" confidence badge for score >= 0.8', (tester) async {
      // Arrange
      final bankDetails = BankDetailsModel(
        accountNumber: '0123456789',
        accountName: 'John Doe',
        bankName: 'Chase Bank',
        accountType: 'internal',
        confidenceScore: 0.90,
        fieldConfidence: {
          'account_number': 0.90,
        },
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(bankDetails));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('High'), findsOneWidget);
    });

    testWidgets('displays "Medium" confidence badge for score 0.6-0.8', (tester) async {
      // Arrange
      final bankDetails = BankDetailsModel(
        accountNumber: '0123456789',
        accountName: 'John Doe',
        bankName: 'Chase Bank',
        accountType: 'internal',
        confidenceScore: 0.70,
        fieldConfidence: {
          'account_number': 0.70,
        },
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(bankDetails));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Medium'), findsOneWidget);
    });

    testWidgets('displays "Low" confidence badge for score < 0.6', (tester) async {
      // Arrange
      final bankDetails = BankDetailsModel(
        accountNumber: '0123456789',
        accountName: 'John Doe',
        bankName: 'Chase Bank',
        accountType: 'internal',
        confidenceScore: 0.50,
        fieldConfidence: {
          'account_number': 0.50,
        },
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(bankDetails));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Low'), findsOneWidget);
    });
  });

  group('BankDetailsBottomSheet - Accessibility', () {
    testWidgets('has accessible labels for form fields', (tester) async {
      // Arrange
      final bankDetails = BankDetailsModel(
        accountNumber: '0123456789',
        accountName: 'John Doe',
        bankName: 'Chase Bank',
        accountType: 'internal',
        confidenceScore: 0.90,
        fieldConfidence: {},
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(bankDetails));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Account Number'), findsOneWidget);
      expect(find.text('Account Name'), findsOneWidget);
      expect(find.text('Amount'), findsOneWidget);
    });

    testWidgets('has semantic labels for icon buttons', (tester) async {
      // Arrange
      final bankDetails = BankDetailsModel(
        accountNumber: '0123456789',
        accountName: 'John Doe',
        bankName: 'Chase Bank',
        accountType: 'internal',
        confidenceScore: 0.90,
        fieldConfidence: {},
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(bankDetails));
      await tester.pumpAndSettle();

      // Assert - Close button should have semantics
      final closeButton = find.byIcon(Icons.close);
      expect(closeButton, findsOneWidget);
    });
  });
}
