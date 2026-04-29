import 'dart:io';
import 'dart:typed_data';
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

    // All ISO 4217 currency codes are accepted — Reloadly supports 100+ currencies.
    // The backend validates currency support for the specific product at purchase time.
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

    // Balance validation is handled by the backend via accounts-service HoldFunds.
    // The backend has the authoritative balance and handles cross-currency correctly.

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

  // ── Sell-flow image upload validation ────────────────────────────
  //
  // Mirrors Prestmit's documented /giftcard-trade/sell/create limits
  // verbatim (per documentation.prestmit.io "Common Issues #2"):
  //   • Format: JPG or PNG only
  //   • Size:   ≤ 5MB per file
  //   • Count:  ≤ 20 attachments per trade
  // Reject client-side BEFORE upload so the user sees a clear inline
  // error instead of a 422 from /sell/create that's parsed back as a
  // generic "service error". Each helper is independently callable so
  // the sell screen can validate one slot at a time as the user picks.

  /// Maximum file size accepted by Prestmit's /sell/create attachments[].
  static const int maxImageBytes = 5 * 1024 * 1024;

  /// Maximum number of attachments per Prestmit sell submission.
  static const int maxImagesPerSubmission = 20;

  /// Magic-byte signatures for the two formats Prestmit accepts.
  static const List<int> _jpegMagic = [0xFF, 0xD8, 0xFF];
  static const List<int> _pngMagic = [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A];

  /// validateImageBytes inspects the file's magic bytes + size in one
  /// pass. Magic-byte sniff is the canonical "is this really a JPG/PNG"
  /// check — file extension on iOS / Android can lie (heic/webp
  /// renamed to .jpg). Returns Right(null) on accept; Left(error) on
  /// any rule violation.
  static Either<ValidationError, void> validateImageBytes(Uint8List bytes) {
    if (bytes.isEmpty) {
      return left(const GeneralValidationError(
        "Image is empty.",
        "image",
      ));
    }
    if (bytes.length > maxImageBytes) {
      return left(GeneralValidationError(
        "Image is ${(bytes.length / 1024 / 1024).toStringAsFixed(1)} MB. "
        "Prestmit accepts up to ${(maxImageBytes / 1024 / 1024).toStringAsFixed(0)} MB.",
        "image",
      ));
    }
    if (!_matchesMagic(bytes, _jpegMagic) && !_matchesMagic(bytes, _pngMagic)) {
      return left(const GeneralValidationError(
        "Image must be JPG or PNG. Take a photo or save the screenshot as JPEG/PNG.",
        "image",
      ));
    }
    return right(null);
  }

  /// validateImageFile is the File-aware variant for image_picker
  /// results. Reads the file's bytes and forwards to
  /// validateImageBytes — keeps the magic-byte sniff identical.
  static Future<Either<ValidationError, void>> validateImageFile(File file) async {
    try {
      final stat = await file.stat();
      if (stat.size > maxImageBytes) {
        return left(GeneralValidationError(
          "Image is ${(stat.size / 1024 / 1024).toStringAsFixed(1)} MB. "
          "Prestmit accepts up to ${(maxImageBytes / 1024 / 1024).toStringAsFixed(0)} MB.",
          "image",
        ));
      }
      final bytes = await file.readAsBytes();
      return validateImageBytes(bytes);
    } catch (e) {
      return left(GeneralValidationError(
        "Couldn't read image: $e",
        "image",
      ));
    }
  }

  /// validateImageBatch enforces the per-submission attachment cap.
  /// Call once before /sell/create with the full list of staged
  /// images; per-image format/size checks should already have run
  /// at upload time.
  static Either<ValidationError, void> validateImageBatch(int count) {
    if (count <= 0) {
      return left(const GeneralValidationError(
        "At least one image is required for Physical cards.",
        "images",
      ));
    }
    if (count > maxImagesPerSubmission) {
      return left(GeneralValidationError(
        "Too many images: $count. Prestmit accepts up to $maxImagesPerSubmission per submission.",
        "images",
      ));
    }
    return right(null);
  }

  static bool _matchesMagic(Uint8List bytes, List<int> magic) {
    if (bytes.length < magic.length) return false;
    for (var i = 0; i < magic.length; i++) {
      if (bytes[i] != magic[i]) return false;
    }
    return true;
  }
}
