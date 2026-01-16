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
  // Private constructor to prevent instantiation
  GiftCardValidation._();

  /// Validates purchase amount against brand constraints
  static Either<ValidationError, double> validatePurchaseAmount({
    required double amount,
    required GiftCardBrand brand,
  }) {
    // Check if amount is positive
    if (amount <= 0) {
      return left(const AmountValidationError(
        'Amount must be greater than zero',
        'amount',
      ));
    }

    // Check minimum amount
    if (brand.minAmount != null && amount < brand.minAmount!) {
      return left(AmountValidationError(
        'Minimum amount is \$${brand.minAmount!.toStringAsFixed(2)}',
        'amount',
      ));
    }

    // Check maximum amount
    if (brand.maxAmount != null && amount > brand.maxAmount!) {
      return left(AmountValidationError(
        'Maximum amount is \$${brand.maxAmount!.toStringAsFixed(2)}',
        'amount',
      ));
    }

    // Check if amount matches available denominations (if specified)
    if (brand.availableDenominations != null &&
        brand.availableDenominations!.isNotEmpty) {
      final denominationValues = brand.availableDenominations!
          .map((d) => double.tryParse(d) ?? 0)
          .toList();

      if (!denominationValues.contains(amount)) {
        final validAmounts = brand.availableDenominations!.join(', ');
        return left(AmountValidationError(
          'Amount must be one of: \$$validAmounts',
          'amount',
        ));
      }
    }

    return right(amount);
  }

  /// Validates gift card code format
  static Either<ValidationError, String> validateGiftCardCode(String code) {
    // Remove whitespace
    final trimmedCode = code.trim();

    // Check if code is empty
    if (trimmedCode.isEmpty) {
      return left(const CodeValidationError(
        'Gift card code cannot be empty',
        'code',
      ));
    }

    // Check minimum length (typically 8-20 characters)
    if (trimmedCode.length < 8) {
      return left(const CodeValidationError(
        'Gift card code must be at least 8 characters',
        'code',
      ));
    }

    // Check maximum length
    if (trimmedCode.length > 50) {
      return left(const CodeValidationError(
        'Gift card code is too long (max 50 characters)',
        'code',
      ));
    }

    // Check for valid characters (alphanumeric and common separators)
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

    // Check if PIN is numeric
    final numericPattern = RegExp(r'^\d+$');
    if (!numericPattern.hasMatch(trimmedPin)) {
      return left(const CodeValidationError(
        'PIN must contain only numbers',
        'pin',
      ));
    }

    // Check PIN length (typically 4-6 digits)
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

    // RFC 5322 compliant email regex (simplified)
    final emailPattern = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
    );

    if (!emailPattern.hasMatch(trimmedEmail)) {
      return left(const EmailValidationError(
        'Invalid email address format',
        'email',
      ));
    }

    // Check email length
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

    // Check for valid name characters (letters, spaces, hyphens, apostrophes)
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
        'Insufficient balance. You need \$${shortfall.toStringAsFixed(2)} more',
        'balance',
      ));
    }

    return right(null);
  }

  /// Validates gift card is not expired
  static Either<ValidationError, void> validateNotExpired(
    DateTime expiryDate,
  ) {
    final now = DateTime.now();

    if (expiryDate.isBefore(now)) {
      return left(DateValidationError(
        'Gift card expired on ${expiryDate.toString().split(' ')[0]}',
        'expiryDate',
      ));
    }

    // Warn if expiring soon (within 7 days)
    final daysUntilExpiry = expiryDate.difference(now).inDays;
    if (daysUntilExpiry <= 7 && daysUntilExpiry > 0) {
      // This is a warning, not an error - still return right
      // The caller can decide what to do with this info
      return right(null);
    }

    return right(null);
  }

  /// Validates gift card status allows the operation
  static Either<ValidationError, void> validateStatus({
    required GiftCardStatus status,
    required String operation,
  }) {
    switch (operation.toLowerCase()) {
      case 'redeem':
        if (status == GiftCardStatus.used) {
          return left(const GeneralValidationError(
            'This gift card has already been used',
            'status',
          ));
        }
        if (status == GiftCardStatus.expired) {
          return left(const GeneralValidationError(
            'This gift card has expired',
            'status',
          ));
        }
        if (status == GiftCardStatus.pending) {
          return left(const GeneralValidationError(
            'This gift card is pending activation',
            'status',
          ));
        }
        break;

      case 'transfer':
      case 'sell':
        if (status == GiftCardStatus.used) {
          return left(const GeneralValidationError(
            'Cannot transfer or sell a used gift card',
            'status',
          ));
        }
        if (status == GiftCardStatus.expired) {
          return left(const GeneralValidationError(
            'Cannot transfer or sell an expired gift card',
            'status',
          ));
        }
        break;
    }

    return right(null);
  }

  /// Validates transfer amount (for partial redemptions)
  static Either<ValidationError, double> validateTransferAmount({
    required double amount,
    required double cardBalance,
  }) {
    if (amount <= 0) {
      return left(const AmountValidationError(
        'Transfer amount must be greater than zero',
        'amount',
      ));
    }

    if (amount > cardBalance) {
      return left(AmountValidationError(
        'Transfer amount exceeds card balance of \$${cardBalance.toStringAsFixed(2)}',
        'amount',
      ));
    }

    return right(amount);
  }

  /// Validates selling price
  static Either<ValidationError, double> validateSellingPrice({
    required double askingPrice,
    required double cardValue,
  }) {
    if (askingPrice <= 0) {
      return left(const AmountValidationError(
        'Selling price must be greater than zero',
        'askingPrice',
      ));
    }

    // Typically, selling price shouldn't exceed card value
    if (askingPrice > cardValue) {
      return left(AmountValidationError(
        'Selling price cannot exceed card value of \$${cardValue.toStringAsFixed(2)}',
        'askingPrice',
      ));
    }

    // Warn if selling at too steep a discount (more than 50% off)
    final discountPercentage = ((cardValue - askingPrice) / cardValue) * 100;
    if (discountPercentage > 50) {
      // This is a warning - caller should confirm with user
      // Still return right, but include info
      return right(askingPrice);
    }

    return right(askingPrice);
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

    // Check length (ISO 4217 currency codes are 3 letters)
    if (trimmedCurrency.length != 3) {
      return left(const GeneralValidationError(
        'Currency code must be 3 characters (ISO 4217)',
        'currency',
      ));
    }

    // Check if alphabetic
    final alphaPattern = RegExp(r'^[A-Z]{3}$');
    if (!alphaPattern.hasMatch(trimmedCurrency)) {
      return left(const GeneralValidationError(
        'Invalid currency code format',
        'currency',
      ));
    }

    // Common currencies list (can be expanded)
    final supportedCurrencies = [
      'USD',
      'EUR',
      'GBP',
      'JPY',
      'CAD',
      'AUD',
      'CHF',
      'CNY',
      'NGN',
      'ZAR',
      'INR',
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

  /// Validates complete redemption request
  static Either<ValidationError, void> validateRedemptionRequest({
    required GiftCard giftCard,
    required String code,
    String? pin,
  }) {
    // Validate code
    final codeValidation = validateGiftCardCode(code);
    if (codeValidation.isLeft()) {
      return left(codeValidation.getLeft().getOrElse(() =>
          const CodeValidationError('Invalid code', 'code')));
    }

    // Validate PIN if provided
    if (pin != null && pin.isNotEmpty) {
      final pinValidation = validatePin(pin);
      if (pinValidation.isLeft()) {
        return left(pinValidation.getLeft().getOrElse(() =>
            const CodeValidationError('Invalid PIN', 'pin')));
      }
    }

    // Validate status
    final statusValidation = validateStatus(
      status: giftCard.status,
      operation: 'redeem',
    );
    if (statusValidation.isLeft()) {
      return left(statusValidation.getLeft().getOrElse(() =>
          const GeneralValidationError('Invalid status', 'status')));
    }

    // Validate not expired
    final expiryValidation = validateNotExpired(giftCard.expiryDate);
    if (expiryValidation.isLeft()) {
      return left(expiryValidation.getLeft().getOrElse(() =>
          const DateValidationError('Card expired', 'expiryDate')));
    }

    return right(null);
  }

  /// Validates complete transfer request
  static Either<ValidationError, void> validateTransferRequest({
    required GiftCard giftCard,
    required String recipientEmail,
    required String recipientName,
    String? message,
  }) {
    // Validate recipient email
    final emailValidation = validateEmail(recipientEmail);
    if (emailValidation.isLeft()) {
      return left(emailValidation.getLeft().getOrElse(() =>
          const EmailValidationError('Invalid email', 'recipientEmail')));
    }

    // Validate recipient name
    final nameValidation = validateRecipientName(recipientName);
    if (nameValidation.isLeft()) {
      return left(nameValidation.getLeft().getOrElse(() =>
          const GeneralValidationError('Invalid name', 'recipientName')));
    }

    // Validate status
    final statusValidation = validateStatus(
      status: giftCard.status,
      operation: 'transfer',
    );
    if (statusValidation.isLeft()) {
      return left(statusValidation.getLeft().getOrElse(() =>
          const GeneralValidationError('Invalid status', 'status')));
    }

    // Validate not expired
    final expiryValidation = validateNotExpired(giftCard.expiryDate);
    if (expiryValidation.isLeft()) {
      return left(expiryValidation.getLeft().getOrElse(() =>
          const DateValidationError('Card expired', 'expiryDate')));
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
