# Error Handling Guide - Bank Details Scan to Pay

This guide explains the comprehensive error handling system implemented for the bank details scan-to-pay feature.

## Overview

The error handling system provides:
- **Specific exception types** for different error scenarios
- **User-friendly error messages** that explain what went wrong
- **Retry capabilities** where appropriate
- **Visual error indicators** (dialogs, snackbars, banners)
- **Graceful degradation** when services are unavailable

## Exception Hierarchy

All exceptions extend from `ScanException` base class with these properties:
- `message`: Technical error message
- `details`: Additional error context
- `canRetry`: Whether the operation can be retried
- `userMessage`: User-friendly error message

### Exception Types

#### 1. OCRException
**Used for**: Image processing and text extraction errors

**Factory methods**:
```dart
OCRException.lowConfidence(confidence: 0.45)
OCRException.noTextDetected()
OCRException.invalidImageFormat()
OCRException.imageTooSmall()
OCRException.processingTimeout()
```

**Example**:
```dart
try {
  final bankDetails = await scanBankDetails(imagePath);
} on OCRException catch (e) {
  if (e.errorType == OCRErrorType.lowConfidence) {
    // Show warning, allow user to proceed or retake
  }
}
```

#### 2. NetworkException
**Used for**: Connection and HTTP-related errors

**Factory methods**:
```dart
NetworkException.noConnection()
NetworkException.timeout()
NetworkException.serverError(statusCode: 500)
NetworkException.badRequest(reason: "Invalid image")
```

**Example**:
```dart
try {
  final response = await httpClient.post(uri);
} on SocketException {
  throw NetworkException.noConnection();
} on TimeoutException {
  throw NetworkException.timeout();
}
```

#### 3. PaymentException
**Used for**: Payment processing errors

**Factory methods**:
```dart
PaymentException.insufficientFunds(
  availableBalance: 100.0,
  requestedAmount: 150.0,
)
PaymentException.invalidAccount()
PaymentException.transactionFailed(reason: "...")
PaymentException.pinLocked(unlocksAt: "14:30")
PaymentException.invalidPin()
PaymentException.amountTooLarge(maxAmount: 10000.0)
PaymentException.amountTooSmall(minAmount: 0.01)
```

**Example**:
```dart
try {
  final receipt = await processPayment();
} on PaymentException catch (e) {
  if (e.errorType == PaymentErrorType.insufficientFunds) {
    // Show balance, suggest adding funds
  } else if (e.errorType == PaymentErrorType.pinLocked) {
    // Show locked message with unlock time
  }
}
```

#### 4. ValidationException
**Used for**: Input validation errors

**Factory methods**:
```dart
ValidationException.invalidAccountNumber()
ValidationException.invalidAmount()
ValidationException.missingBankName()
ValidationException.missingAccountName()
```

#### 5. AuthenticationException
**Used for**: Auth-related errors

**Factory methods**:
```dart
AuthenticationException.notAuthenticated()
AuthenticationException.sessionExpired()
AuthenticationException.unauthorized()
```

#### 6. RateLimitException
**Used for**: Rate limiting errors

**Factory methods**:
```dart
RateLimitException.tooManyRequests(retryAfter: 60)
RateLimitException.dailyLimitReached()
```

#### 7. BankValidationException
**Used for**: Bank account validation errors

**Factory methods**:
```dart
BankValidationException.accountNotFound()
BankValidationException.bankNotSupported(bankName: "XYZ Bank")
BankValidationException.validationFailed(reason: "...")
```

## Error Display Widgets

### 1. ScanErrorDialog
Full-screen modal dialog for critical errors.

**Usage**:
```dart
showDialog(
  context: context,
  builder: (context) => ScanErrorDialog(
    exception: OCRException.lowConfidence(confidence: 0.3),
    onRetry: () {
      // Retry logic
      Navigator.pop(context);
      retakePicture();
    },
    onCancel: () {
      Navigator.pop(context);
    },
  ),
);
```

### 2. LowConfidenceWarning
Banner widget for low OCR confidence scores.

**Usage**:
```dart
if (bankDetails.requiresReview) {
  LowConfidenceWarning(
    confidenceScore: bankDetails.confidenceScore,
    onRetake: () {
      // Return to camera
    },
  )
}
```

**Confidence Levels**:
- **Very Low** (< 0.4): Red warning, strongly suggest retake
- **Medium** (0.4 - 0.6): Amber warning, suggest verification
- **Low** (0.6 - 0.8): Light amber, minor verification
- **High** (>= 0.8): No warning

### 3. ScanErrorSnackbar
Quick, dismissible error notification.

**Usage**:
```dart
ScanErrorSnackbar.show(
  context,
  exception: NetworkException.timeout(),
  onRetry: () {
    // Retry logic
  },
);
```

### 4. FieldErrorIndicator
Inline error for specific form fields.

**Usage**:
```dart
Column(
  children: [
    TextFormField(
      controller: accountNumberController,
      decoration: InputDecoration(
        errorText: errorMessage,
      ),
    ),
    if (hasError)
      FieldErrorIndicator(
        errorMessage: 'Account number format is invalid',
        icon: Icons.error_outline,
      ),
  ],
)
```

### 5. ErrorRecoveryOverlay
Blocking overlay for critical errors requiring user action.

**Usage**:
```dart
if (state is ErrorState) {
  Stack(
    children: [
      // Main content
      MainContent(),

      // Error overlay
      ErrorRecoveryOverlay(
        exception: state.exception,
        onRetry: () => cubit.retry(),
        onCancel: () => Navigator.pop(context),
      ),
    ],
  )
}
```

## Error Handling in Cubit

The `AiScanCubit` handles errors and emits appropriate states:

### Processing Image Errors
```dart
try {
  final bankDetails = await scanBankDetailsUseCase(imagePath, sessionId);
  emit(AiScanBankDetailsExtracted(bankDetails: bankDetails));
} on OCRException catch (e) {
  emit(AiScanError(message: e.getUserMessage()));
} on NetworkException catch (e) {
  emit(AiScanError(message: e.getUserMessage()));
}
```

### Payment Processing Errors
```dart
try {
  final receipt = await processBankDetailsPaymentUseCase(...);
  emit(AiScanBankDetailsPaymentSuccess(receipt: receipt));
} on PaymentException catch (e) {
  emit(AiScanBankDetailsPaymentFailed(
    errorMessage: e.getUserMessage(),
    bankDetails: bankDetails,
    canRetry: e.canRetry,
  ));
}
```

## UI Response Patterns

### Pattern 1: Show Error Dialog
For critical errors requiring user attention:
```dart
BlocListener<AiScanCubit, AiScanState>(
  listener: (context, state) {
    if (state is AiScanError) {
      showDialog(
        context: context,
        builder: (context) => ScanErrorDialog(
          exception: /* parse from state */,
          onRetry: () {
            context.read<AiScanCubit>().retry();
          },
        ),
      );
    }
  },
)
```

### Pattern 2: Show Snackbar
For non-critical errors:
```dart
BlocListener<AiScanCubit, AiScanState>(
  listener: (context, state) {
    if (state is AiScanError) {
      ScanErrorSnackbar.show(
        context,
        exception: /* parse from state */,
      );
    }
  },
)
```

### Pattern 3: Inline Error Display
For form validation errors:
```dart
TextFormField(
  validator: (value) {
    try {
      validateAccountNumber(value);
      return null;
    } on ValidationException catch (e) {
      return e.getUserMessage();
    }
  },
)
```

## Backend Error Mapping

The datasource maps HTTP status codes to exceptions:

| Status Code | Exception Type | Description |
|-------------|---------------|-------------|
| 200 | Success | No error |
| 400 | ValidationException | Invalid input |
| 401 | AuthenticationException | Not authenticated |
| 402 | PaymentException.insufficientFunds | Insufficient balance |
| 403 | PaymentException.pinLocked | Too many PIN attempts |
| 404 | PaymentException.invalidAccount | Account not found |
| 422 | BankValidationException | Bank validation failed |
| 429 | RateLimitException | Too many requests |
| 500+ | NetworkException.serverError | Server error |
| Timeout | NetworkException.timeout | Request timeout |
| No connection | NetworkException.noConnection | No internet |

## Best Practices

### 1. Always Catch Specific Exceptions First
```dart
try {
  // operation
} on PaymentException catch (e) {
  // Handle payment errors
} on NetworkException catch (e) {
  // Handle network errors
} on ScanException catch (e) {
  // Handle other scan errors
} catch (e) {
  // Handle unexpected errors
}
```

### 2. Use getUserMessage() for User-Facing Text
```dart
try {
  await scanBankDetails();
} on OCRException catch (e) {
  // Good: User-friendly message
  showSnackbar(e.getUserMessage());

  // Bad: Technical message
  showSnackbar(e.toString());
}
```

### 3. Respect canRetry Flag
```dart
if (state is ErrorState && state.exception.canRetry) {
  // Show retry button
  ElevatedButton(
    onPressed: () => cubit.retry(),
    child: Text('Retry'),
  )
} else {
  // Show close/cancel button
  ElevatedButton(
    onPressed: () => Navigator.pop(context),
    child: Text('Close'),
  )
}
```

### 4. Log Technical Details
```dart
try {
  await processPayment();
} on PaymentException catch (e) {
  // Log technical details for debugging
  logger.error('Payment failed', {
    'error': e.message,
    'details': e.details,
    'type': e.errorType,
  });

  // Show user-friendly message
  showError(e.getUserMessage());
}
```

### 5. Provide Context in Error Messages
```dart
// Good: Specific context
throw OCRException.lowConfidence(confidence: 0.45);

// Bad: Generic error
throw Exception('Low confidence');
```

## Testing Error Scenarios

### Unit Tests
```dart
test('throws OCRException.lowConfidence when confidence < 0.3', () async {
  // Arrange
  mockResponse(confidence: 0.25);

  // Act & Assert
  expect(
    () => datasource.scanBankDetails(imagePath),
    throwsA(isA<OCRException>().having(
      (e) => e.errorType,
      'errorType',
      OCRErrorType.lowConfidence,
    )),
  );
});
```

### Widget Tests
```dart
testWidgets('shows error dialog on scan failure', (tester) async {
  // Arrange
  when(() => mockCubit.state).thenReturn(
    AiScanError(message: 'Scan failed'),
  );

  // Act
  await tester.pumpWidget(MyApp());
  await tester.pumpAndSettle();

  // Assert
  expect(find.byType(ScanErrorDialog), findsOneWidget);
});
```

## Summary

The error handling system provides:
- ✅ **Type-safe** exception handling
- ✅ **User-friendly** error messages
- ✅ **Retry capabilities** where appropriate
- ✅ **Visual consistency** across error states
- ✅ **Detailed logging** for debugging
- ✅ **Graceful degradation** when services fail
