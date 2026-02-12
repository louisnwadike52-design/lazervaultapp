import 'package:fpdart/fpdart.dart';
import '../entities/gift_card_entity.dart';

/// Validation errors for gift card operations
abstract class ValidationError {
  final String message;
  final String? field;

  const ValidationError(this.message, [this.field]);

  @override
  String toString() => field != null ? '$field: $message' : message;
}

class AmountValidationError extends ValidationError {
  const AmountValidationError(super.message, [super.field]);
}

class CodeValidationError extends ValidationError {
  const CodeValidationError(super.message, [super.field]);
}

class EmailValidationError extends ValidationError {
  const EmailValidationError(super.message, [super.field]);
}

class BalanceValidationError extends ValidationError {
  const BalanceValidationError(super.message, [super.field]);
}

class DateValidationError extends ValidationError {
  const DateValidationError(super.message, [super.field]);
}

class GeneralValidationError extends ValidationError {
  const GeneralValidationError(super.message, [super.field]);
}

/// Comprehensive validation layer for gift card operations
class GiftCardValidation {
  GiftCardValidation._();

  /// Validates purchase amount against brand constraints
  static Either<ValidationError, double> validatePurchaseAmount({
    required double amount,
    required GiftCardBrand brand,
  }) {
    if (amount <= 0) {
      return left(const AmountValidationError(
        'Amount must be greater than zero',
        'amount',
      ));
    }

    if (brand.minAmount > 0 && amount < brand.minAmount) {
      return left(AmountValidationError(
        'Minimum amount is ${brand.minAmount.toStringAsFixed(2)}',
        'amount',
      ));
    }

    if (brand.maxAmount > 0 && amount > brand.maxAmount) {
      return left(AmountValidationError(
        'Maximum amount is ${brand.maxAmount.toStringAsFixed(2)}',
        'amount',
      ));
    }

    // Check if amount matches fixed denominations (if specified)
    if (brand.fixedDenominations.isNotEmpty) {
      final denominationValues = brand.fixedDenominations.map((d) => d.price).toList();
      if (!denominationValues.contains(amount)) {
        final validAmounts = denominationValues.map((d) => d.toStringAsFixed(0)).join(', ');
        return left(AmountValidationError(
          'Amount must be one of: $validAmounts',
          'amount',
        ));
      }
    }

    return right(amount);
  }

  /// Validates gift card code format
  static Either<ValidationError, String> validateGiftCardCode(String code) {
    final trimmedCode = code.trim();

    if (trimmedCode.isEmpty) {
      return left(const CodeValidationError(
        'Gift card code cannot be empty',
        'code',
      ));
    }

    if (trimmedCode.length < 8) {
      return left(const CodeValidationError(
        'Gift card code must be at least 8 characters',
        'code',
      ));
    }

    if (trimmedCode.length > 50) {
      return left(const CodeValidationError(
        'Gift card code is too long (max 50 characters)',
        'code',
      ));
    }

    final validCodePattern = RegExp(r'^[A-Za-z0-9\-_]+$');
    if (!validCodePattern.hasMatch(trimmedCode)) {
      return left(const CodeValidationError(
        'Gift card code contains invalid characters',
        'code',
      ));
    }

    return right(trimmedCode);
  }

  /// Validates PIN format (4-6 digits)
  static Either<ValidationError, String> validatePin(String pin) {
    final trimmedPin = pin.trim();

    if (trimmedPin.isEmpty) {
      return left(const CodeValidationError(
        'PIN cannot be empty',
        'pin',
      ));
    }

    final numericPattern = RegExp(r'^\d+$');
    if (!numericPattern.hasMatch(trimmedPin)) {
      return left(const CodeValidationError(
        'PIN must contain only numbers',
        'pin',
      ));
    }

    if (trimmedPin.length < 4 || trimmedPin.length > 6) {
      return left(const CodeValidationError(
        'PIN must be 4-6 digits',
        'pin',
      ));
    }

    return right(trimmedPin);
  }

  /// Validates email address format
  static Either<ValidationError, String> validateEmail(String email) {
    final trimmedEmail = email.trim();

    if (trimmedEmail.isEmpty) {
      return left(const EmailValidationError(
        'Email address cannot be empty',
        'email',
      ));
    }

    final emailPattern = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
    );

    if (!emailPattern.hasMatch(trimmedEmail)) {
      return left(const EmailValidationError(
        'Invalid email address format',
        'email',
      ));
    }

    if (trimmedEmail.length > 254) {
      return left(const EmailValidationError(
        'Email address is too long',
        'email',
      ));
    }

    return right(trimmedEmail.toLowerCase());
  }

  /// Validates recipient name
  static Either<ValidationError, String> validateRecipientName(String name) {
    final trimmedName = name.trim();

    if (trimmedName.isEmpty) {
      return left(const GeneralValidationError(
        'Recipient name cannot be empty',
        'recipientName',
      ));
    }

    if (trimmedName.length < 2) {
      return left(const GeneralValidationError(
        'Recipient name must be at least 2 characters',
        'recipientName',
      ));
    }

    if (trimmedName.length > 100) {
      return left(const GeneralValidationError(
        'Recipient name is too long (max 100 characters)',
        'recipientName',
      ));
    }

    final namePattern = RegExp(r"^[a-zA-Z\s\-']+$");
    if (!namePattern.hasMatch(trimmedName)) {
      return left(const GeneralValidationError(
        'Recipient name contains invalid characters',
        'recipientName',
      ));
    }

    return right(trimmedName);
  }

  /// Validates user has sufficient balance for purchase
  static Either<ValidationError, void> validateSufficientBalance({
    required double purchaseAmount,
    required double availableBalance,
  }) {
    if (purchaseAmount > availableBalance) {
      final shortfall = purchaseAmount - availableBalance;
      return left(BalanceValidationError(
        'Insufficient balance. You need ${shortfall.toStringAsFixed(2)} more',
        'balance',
      ));
    }

    return right(null);
  }

  /// Validates gift card status allows the operation (string-based)
  static Either<ValidationError, void> validateStatus({
    required String status,
    required String operation,
  }) {
    switch (operation.toLowerCase()) {
      case 'redeem':
        if (status == 'redeemed' || status == 'used') {
          return left(const GeneralValidationError(
            'This gift card has already been used',
            'status',
          ));
        }
        if (status == 'expired') {
          return left(const GeneralValidationError(
            'This gift card has expired',
            'status',
          ));
        }
        if (status == 'pending') {
          return left(const GeneralValidationError(
            'This gift card is pending activation',
            'status',
          ));
        }
        break;

      case 'transfer':
        if (status == 'redeemed' || status == 'used') {
          return left(const GeneralValidationError(
            'Cannot transfer a used gift card',
            'status',
          ));
        }
        if (status == 'expired') {
          return left(const GeneralValidationError(
            'Cannot transfer an expired gift card',
            'status',
          ));
        }
        break;
    }

    return right(null);
  }

  /// Validates message/note length
  static Either<ValidationError, String> validateMessage(String message) {
    final trimmedMessage = message.trim();

    if (trimmedMessage.length > 500) {
      return left(const GeneralValidationError(
        'Message is too long (max 500 characters)',
        'message',
      ));
    }

    return right(trimmedMessage);
  }

  /// Validates currency code (ISO 4217)
  static Either<ValidationError, String> validateCurrency(String currency) {
    final trimmedCurrency = currency.trim().toUpperCase();

    if (trimmedCurrency.isEmpty) {
      return left(const GeneralValidationError(
        'Currency code cannot be empty',
        'currency',
      ));
    }

    if (trimmedCurrency.length != 3) {
      return left(const GeneralValidationError(
        'Currency code must be 3 characters (ISO 4217)',
        'currency',
      ));
    }

    final alphaPattern = RegExp(r'^[A-Z]{3}$');
    if (!alphaPattern.hasMatch(trimmedCurrency)) {
      return left(const GeneralValidationError(
        'Invalid currency code format',
        'currency',
      ));
    }

    final supportedCurrencies = [
      'USD', 'EUR', 'GBP', 'JPY', 'CAD', 'AUD',
      'CHF', 'CNY', 'NGN', 'ZAR', 'INR',
    ];

    if (!supportedCurrencies.contains(trimmedCurrency)) {
      return left(GeneralValidationError(
        'Currency $trimmedCurrency is not currently supported',
        'currency',
      ));
    }

    return right(trimmedCurrency);
  }

  /// Validates complete purchase request
  static Either<ValidationError, void> validatePurchaseRequest({
    required double amount,
    required GiftCardBrand brand,
    required String currency,
    required double userBalance,
    String? recipientEmail,
    String? recipientName,
    String? message,
  }) {
    // Validate amount
    final amountValidation = validatePurchaseAmount(
      amount: amount,
      brand: brand,
    );
    if (amountValidation.isLeft()) {
      return left(amountValidation.getLeft().getOrElse(() =>
          const AmountValidationError('Invalid amount', 'amount')));
    }

    // Validate currency
    final currencyValidation = validateCurrency(currency);
    if (currencyValidation.isLeft()) {
      return left(currencyValidation.getLeft().getOrElse(() =>
          const GeneralValidationError('Invalid currency', 'currency')));
    }

    // Validate balance
    final balanceValidation = validateSufficientBalance(
      purchaseAmount: amount,
      availableBalance: userBalance,
    );
    if (balanceValidation.isLeft()) {
      return left(balanceValidation.getLeft().getOrElse(() =>
          const BalanceValidationError('Insufficient balance', 'balance')));
    }

    // Validate recipient email if provided
    if (recipientEmail != null && recipientEmail.isNotEmpty) {
      final emailValidation = validateEmail(recipientEmail);
      if (emailValidation.isLeft()) {
        return left(emailValidation.getLeft().getOrElse(() =>
            const EmailValidationError('Invalid email', 'recipientEmail')));
      }
    }

    // Validate recipient name if provided
    if (recipientName != null && recipientName.isNotEmpty) {
      final nameValidation = validateRecipientName(recipientName);
      if (nameValidation.isLeft()) {
        return left(nameValidation.getLeft().getOrElse(() =>
            const GeneralValidationError('Invalid name', 'recipientName')));
      }
    }

    // Validate message if provided
    if (message != null && message.isNotEmpty) {
      final messageValidation = validateMessage(message);
      if (messageValidation.isLeft()) {
        return left(messageValidation.getLeft().getOrElse(() =>
            const GeneralValidationError('Invalid message', 'message')));
      }
    }

    return right(null);
  }

  /// Helper method to get user-friendly error message
  static String getErrorMessage(ValidationError error) {
    return error.message;
  }

  /// Helper method to check if validation passed
  static bool isValid<T>(Either<ValidationError, T> validation) {
    return validation.isRight();
  }
}
