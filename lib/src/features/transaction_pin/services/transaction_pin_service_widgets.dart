part of 'transaction_pin_service.dart';

/// Abstract class defining transaction PIN operations
abstract class ITransactionPinService {
  /// Check if user has a transaction PIN set up
  Future<bool> checkUserHasPin({bool forceRefresh = false});

  /// Clear the cached "has PIN" flag. MUST be called on logout (and after a
  /// server-side PIN clear) so a stale cached `true` can't skip a genuinely
  /// required setup for the next session / user.
  void resetPinCache();

  /// Verify transaction PIN before payment
  Future<TransactionPinVerificationResult> verifyPin({
    required String pin,
    required String transactionId,
    required String transactionType,
    required double amount,
    required String currency,
  });

  /// Validate a verification token
  Future<bool> validateToken({
    required String token,
    required String transactionId,
  });

  /// Create a new transaction PIN
  Future<bool> createPin({
    required String pin,
    required String confirmPin,
  });

  /// Change existing transaction PIN
  Future<bool> changePin({
    required String currentPin,
    required String newPin,
    required String confirmNewPin,
  });

  /// Reset forgotten transaction PIN
  Future<bool> resetPin({
    required String verificationCode,
    required String newPin,
    required String confirmNewPin,
  });

  /// Initiate OTP for PIN operation
  Future<OTPInitiationResult> initiatePinOTP({
    required String operationType,
    required String channel,
  });

  /// Verify OTP and execute PIN operation
  Future<PinOTPVerifyResult> verifyPinOTP({
    required String otpCode,
    required String operationType,
    String? currentPin,
    required String newPin,
    required String confirmNewPin,
  });

  /// Get available OTP channels
  Future<List<OTPChannelInfo>> getPinOTPChannels();

  /// Complete forgot PIN flow
  Future<PinOTPVerifyResult> completeForgotPin({
    required String otpCode,
    required String newPin,
    required String confirmNewPin,
  });

  /// Validate an OTP WITHOUT consuming it, so the screen that collected it can
  /// reject a wrong code there.
  ///
  /// The reset flow collects the code first and the new PIN after, and until
  /// this existed the code was only ever checked at the END — so a wrong code
  /// walked the user through choosing and confirming a new PIN before failing,
  /// and the failure arrived attached to the PIN step where it read as if the
  /// PIN had been rejected.
  ///
  /// The server does NOT mark the OTP verified and does NOT burn a 2FA backup
  /// code on this call, so a correct code still works at the real step. A
  /// WRONG code still counts against the attempt budget — otherwise this
  /// would be a free oracle for guessing it.
  Future<PinOTPVerifyResult> checkPinOtp({
    required String otpCode,
    required String operationType,
  });
}

/// Result of PIN verification
class TransactionPinVerificationResult {
  final bool success;
  final String? message;
  final String? verificationToken;
  final DateTime? expiresAt;
  final int remainingAttempts;
  final bool isLocked;
  final bool isLockedUntil;
  final DateTime? lockedUntil;

  /// True when the server reports the user has NO transaction PIN (e.g. an admin
  /// cleared it). This is NOT a wrong-PIN attempt — callers must route the user
  /// to PIN SETUP rather than count it as a failure or claim the PIN is locked.
  final bool noPinSet;

  TransactionPinVerificationResult({
    required this.success,
    this.message,
    this.verificationToken,
    this.expiresAt,
    this.remainingAttempts = 3,
    this.isLocked = false,
    this.lockedUntil,
    this.noPinSet = false,
  }) : isLockedUntil =
            lockedUntil != null && lockedUntil.isAfter(DateTime.now());

  /// Server says the user has no PIN (cleared / never set) — route to setup.
  factory TransactionPinVerificationResult.noPinSet({String? message}) {
    return TransactionPinVerificationResult(
      success: false,
      noPinSet: true,
      message: message ??
          'Your transaction PIN needs to be set up. Please create a new PIN.',
      remainingAttempts: 0,
    );
  }

  factory TransactionPinVerificationResult.success({
    required String token,
    required DateTime expiresAt,
    required int remainingAttempts,
  }) {
    return TransactionPinVerificationResult(
      success: true,
      verificationToken: token,
      expiresAt: expiresAt,
      remainingAttempts: remainingAttempts,
    );
  }

  factory TransactionPinVerificationResult.failure({
    required String message,
    required int remainingAttempts,
    bool isLocked = false,
    DateTime? lockedUntil,
  }) {
    return TransactionPinVerificationResult(
      success: false,
      message: message,
      remainingAttempts: remainingAttempts,
      isLocked: isLocked,
      lockedUntil: lockedUntil,
    );
  }

  factory TransactionPinVerificationResult.locked({
    required DateTime lockedUntil,
    required int remainingAttempts,
  }) {
    return TransactionPinVerificationResult(
      success: false,
      message: 'PIN is locked due to too many failed attempts',
      remainingAttempts: remainingAttempts,
      isLocked: true,
      lockedUntil: lockedUntil,
    );
  }
}

/// Result of OTP initiation
class OTPInitiationResult {
  final bool success;
  final String message;
  final String channel;
  final String maskedDestination;
  final int expiresInSeconds;
  final int cooldownSeconds;

  OTPInitiationResult({
    required this.success,
    required this.message,
    this.channel = '',
    this.maskedDestination = '',
    this.expiresInSeconds = 600,
    this.cooldownSeconds = 60,
  });
}

/// Result of OTP verification
class PinOTPVerifyResult {
  final bool success;
  final String message;
  final int remainingAttempts;

  PinOTPVerifyResult({
    required this.success,
    required this.message,
    this.remainingAttempts = 0,
  });
}

/// OTP channel information
class OTPChannelInfo {
  final String type;
  final String maskedDestination;
  final bool isVerified;
  final bool isAvailable;

  OTPChannelInfo({
    required this.type,
    required this.maskedDestination,
    required this.isVerified,
    required this.isAvailable,
  });
}
