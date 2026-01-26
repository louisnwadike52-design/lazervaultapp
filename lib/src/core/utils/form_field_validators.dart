/// Form field validators for insurance policy creation
///
/// Provides reusable validation functions extracted from authentication patterns
class FormFieldValidators {
  /// Validates email format
  ///
  /// Returns null if valid, error message if invalid
  /// Production-grade: Requires domain.tld format (must have at least one dot)
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    // Production-grade email regex - requires at least one dot in domain
    // Prevents typos like "user@gmailcom" instead of "user@gmail.com"
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+$',
      // Note: + at end requires at least one .tld in domain
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address (e.g., user@example.com)';
    }

    if (value.length > 254) {
      return 'Email is too long (max 254 characters)';
    }

    return null;
  }

  /// Checks if email format is valid (for real-time validation)
  ///
  /// Returns true if valid format, false otherwise
  /// Production-grade: Requires domain.tld format
  static bool isValidEmailFormat(String email) {
    if (email.isEmpty) return false;

    // Production-grade email regex - requires at least one dot in domain
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+$',
    );

    return emailRegex.hasMatch(email) && email.length <= 254;
  }

  /// Validates phone number format
  ///
  /// Returns null if valid, error message if invalid
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    if (!value.startsWith('+')) {
      return 'Phone number must start with country code (+)';
    }

    if (value.length < 8) {
      return 'Phone number must be at least 8 characters';
    }

    if (value.length > 20) {
      return 'Phone number is too long (max 20 characters)';
    }

    // Check if contains only numbers, plus, spaces, and hyphens
    final phoneRegex = RegExp(r'^[+\d\s\-()]+$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Phone number contains invalid characters';
    }

    return null;
  }

  /// Checks if phone format is valid (for real-time validation)
  ///
  /// Returns true if valid format, false otherwise
  static bool isValidPhoneFormat(String phone) {
    if (phone.isEmpty) return false;
    if (!phone.startsWith('+')) return false;
    if (phone.length < 8) return false;
    if (phone.length > 20) return false;

    final phoneRegex = RegExp(r'^[+\d\s\-()]+$');
    return phoneRegex.hasMatch(phone);
  }

  /// Formats phone number by removing extra characters
  static String formatPhoneNumber(String phoneNumber) {
    return phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
  }

  /// Validates person name (first name, last name)
  ///
  /// Returns null if valid, error message if invalid
  static String? validateName(String? value, {String fieldName = 'Name'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    if (value.length < 2) {
      return '$fieldName must be at least 2 characters';
    }

    if (value.length > 100) {
      return '$fieldName is too long (max 100 characters)';
    }

    // Allow letters, spaces, hyphens, and apostrophes
    final nameRegex = RegExp(r"^[a-zA-Z\s\-']+$");
    if (!nameRegex.hasMatch(value)) {
      return '$fieldName can only contain letters, spaces, hyphens, and apostrophes';
    }

    return null;
  }

  /// Validates monetary amount
  ///
  /// Returns null if valid, error message if invalid
  static String? validateAmount(
    String? value, {
    String fieldName = 'Amount',
    double? minValue,
    double? maxValue,
  }) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    // Remove currency symbols and commas
    final cleanValue = value.replaceAll(RegExp(r'[^\d.]'), '');

    final amount = double.tryParse(cleanValue);
    if (amount == null) {
      return 'Enter a valid numeric $fieldName';
    }

    if (minValue != null && amount < minValue) {
      return '$fieldName must be at least \$${minValue.toStringAsFixed(2)}';
    }

    if (maxValue != null && amount > maxValue) {
      return '$fieldName cannot exceed \$${maxValue.toStringAsFixed(2)}';
    }

    if (amount <= 0) {
      return '$fieldName must be greater than zero';
    }

    return null;
  }

  /// Validates that coverage amount is greater than premium amount
  ///
  /// Returns null if valid, error message if invalid
  static String? validateCoverageAmount(
    String? coverageValue,
    String? premiumValue,
  ) {
    final coverageError = validateAmount(
      coverageValue,
      fieldName: 'Coverage amount',
      minValue: 0.01,
    );

    if (coverageError != null) return coverageError;

    if (premiumValue == null || premiumValue.isEmpty) {
      return null; // Premium not set yet
    }

    final coverage =
        double.tryParse(coverageValue!.replaceAll(RegExp(r'[^\d.]'), ''));
    final premium =
        double.tryParse(premiumValue.replaceAll(RegExp(r'[^\d.]'), ''));

    if (coverage != null && premium != null && coverage <= premium) {
      return 'Coverage amount must be greater than premium amount';
    }

    return null;
  }

  /// Validates date range
  ///
  /// Returns error message if invalid, null if valid
  static String? validateDateRange(
    DateTime? startDate,
    DateTime? endDate, {
    int? minDurationDays,
  }) {
    if (startDate == null) {
      return 'Start date is required';
    }

    if (endDate == null) {
      return 'End date is required';
    }

    if (endDate.isBefore(startDate)) {
      return 'End date must be after start date';
    }

    if (endDate.isAtSameMomentAs(startDate)) {
      return 'End date must be different from start date';
    }

    if (minDurationDays != null) {
      final duration = endDate.difference(startDate).inDays;
      if (duration < minDurationDays) {
        return 'Policy duration must be at least $minDurationDays days';
      }
    }

    return null;
  }

  /// Validates that payment date is within policy period
  ///
  /// Returns error message if invalid, null if valid
  static String? validatePaymentDate(
    DateTime? paymentDate,
    DateTime? startDate,
    DateTime? endDate,
  ) {
    if (paymentDate == null) {
      return 'Payment date is required';
    }

    if (startDate == null) {
      return 'Start date must be set first';
    }

    if (endDate == null) {
      return 'End date must be set first';
    }

    if (paymentDate.isBefore(startDate)) {
      return 'Payment date cannot be before policy start date';
    }

    if (paymentDate.isAfter(endDate)) {
      return 'Payment date cannot be after policy end date';
    }

    return null;
  }

  /// Validates that a date is not too far in the past or future
  ///
  /// Returns error message if invalid, null if valid
  static String? validateDateBounds(
    DateTime? date, {
    String fieldName = 'Date',
    int? maxYearsInPast,
    int? maxYearsInFuture,
  }) {
    if (date == null) {
      return '$fieldName is required';
    }

    final now = DateTime.now();

    if (maxYearsInPast != null) {
      final earliestDate = DateTime(
        now.year - maxYearsInPast,
        now.month,
        now.day,
      );
      if (date.isBefore(earliestDate)) {
        return '$fieldName cannot be more than $maxYearsInPast years in the past';
      }
    }

    if (maxYearsInFuture != null) {
      final latestDate = DateTime(
        now.year + maxYearsInFuture,
        now.month,
        now.day,
      );
      if (date.isAfter(latestDate)) {
        return '$fieldName cannot be more than $maxYearsInFuture years in the future';
      }
    }

    return null;
  }

  /// Validates provider name
  ///
  /// Returns null if valid, error message if invalid
  static String? validateProvider(String? value) {
    if (value == null || value.isEmpty) {
      return 'Insurance provider is required';
    }

    if (value.length < 2) {
      return 'Provider name must be at least 2 characters';
    }

    return null;
  }

  /// Validates optional description field
  ///
  /// Returns null if valid or empty, error message if invalid
  static String? validateDescription(String? value, {int maxLength = 500}) {
    if (value == null || value.isEmpty) {
      return null; // Description is optional
    }

    if (value.length > maxLength) {
      return 'Description is too long (max $maxLength characters)';
    }

    return null;
  }
}
