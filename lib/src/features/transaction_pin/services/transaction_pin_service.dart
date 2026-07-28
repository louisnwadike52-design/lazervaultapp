import 'dart:io';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/generated/transaction_pin.pbgrpc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:uuid/uuid.dart';

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
  }) : isLockedUntil = lockedUntil != null && lockedUntil.isAfter(DateTime.now());

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

/// Implementation of transaction PIN service using gRPC
class TransactionPinService implements ITransactionPinService {
  final TransactionPinServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  // Once we've confirmed the user has a PIN, cache it for the session — a PIN
  // doesn't disappear, so we can skip the (slow) gRPC check on subsequent
  // payments. This is what makes the PIN sheet appear instantly after the
  // first check / pre-warm. Reset on PIN clear/logout via [resetPinCache].
  bool _hasPinConfirmed = false;

  /// Clear the cached "has PIN" flag (call on logout / PIN removal).
  @override
  void resetPinCache() => _hasPinConfirmed = false;

  TransactionPinService({
    required TransactionPinServiceClient client,
    required GrpcCallOptionsHelper callOptionsHelper,
    required AccountManager accountManager,
  })  : _client = client,
        _callOptionsHelper = callOptionsHelper;

  Future<String> _getUserId() async {
    // Get USER ID from secure storage (not account ID)
    // The transaction PIN is tied to the user, not individual accounts
    final userId = await _callOptionsHelper.storage.read(key: 'user_id');
    if (userId != null && userId.isNotEmpty) {
      return userId;
    }
    throw Exception('No user ID found. Please log in again.');
  }

  Future<String> _getDeviceId() async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      final uuid = Uuid();

      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        return androidInfo.id;
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor ?? uuid.v4();
      }

      return uuid.v4(); // Fallback for other platforms
    } catch (e) {
      // Fallback to random UUID if device info fails
      return Uuid().v4();
    }
  }

  Future<String> _getDeviceName() async {
    try {
      final deviceInfo = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        return '${androidInfo.brand} ${androidInfo.model}';
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return iosInfo.model;
      }

      return 'Mobile Device';
    } catch (e) {
      return 'Mobile Device';
    }
  }

  /// Retries [fn] on TRANSIENT transport failures (UNAVAILABLE / connection
  /// "shutting down"). The singleton gRPC channel briefly enters a
  /// shutting-down state when the network blips or a gateway restarts; the
  /// next attempt gets a fresh HTTP/2 connection. Money-safety: only ever
  /// used for IDEMPOTENT reads and PIN verification (server-side attempt
  /// counting is keyed, a retried identical request is safe).
  Future<T> _retryOnTransient<T>(Future<T> Function() fn,
      {int retries = 2}) async {
    var attempt = 0;
    while (true) {
      try {
        return await fn();
      } on GrpcError catch (e) {
        final transient = e.code == StatusCode.unavailable ||
            (e.message?.toLowerCase().contains('shutting down') ?? false) ||
            (e.message?.toLowerCase().contains('connection terminated') ??
                false);
        if (!transient || attempt >= retries) rethrow;
        attempt++;
        print(
            '[TransactionPinService] transient transport error (attempt $attempt/$retries): ${e.codeName} — retrying');
        await Future.delayed(Duration(milliseconds: 400 * attempt));
      }
    }
  }

  @override
  Future<bool> checkUserHasPin({bool forceRefresh = false}) async {
    // Fast path: already confirmed this session — no network round-trip.
    // forceRefresh bypasses the cache (used after a login / PIN-reset enforcement
    // so a stale "true" can't skip a genuinely-required setup).
    if (_hasPinConfirmed && !forceRefresh) return true;
    try {
      final userId = await _getUserId();
      print('[TransactionPinService] checkUserHasPin for userId: $userId (forceRefresh=$forceRefresh)');

      final request = CheckUserHasPinRequest()..userId = userId;

      final response =
          await _retryOnTransient(() => _callOptionsHelper.executeWithTokenRotation(() async {
        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.checkUserHasPin(
          request,
          options: callOptions,
        );
      }));

      print('[TransactionPinService] checkUserHasPin response: hasPin=${response.hasPin}, isActive=${response.isActive}');
      // Keep the cache authoritative in BOTH directions so a forceRefresh after a
      // reset flips a stale true → false (and vice-versa).
      _hasPinConfirmed = response.hasPin;
      return response.hasPin;
    } on GrpcError catch (e) {
      print('[TransactionPinService] gRPC Error checking PIN: ${e.codeName} - ${e.message}');
      throw Exception('Failed to check PIN status: ${e.message ?? "Unknown error"}');
    } catch (e) {
      print('[TransactionPinService] Unexpected error checking PIN: $e');
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<TransactionPinVerificationResult> verifyPin({
    required String pin,
    required String transactionId,
    required String transactionType,
    required double amount,
    required String currency,
  }) async {
    try {
      final userId = await _getUserId();
      final deviceId = await _getDeviceId();

      final request = VerifyTransactionPinRequest()
        ..userId = userId
        ..pin = pin
        ..transactionId = transactionId
        ..transactionType = transactionType
        ..amount = amount
        ..currency = currency
        ..deviceId = deviceId;

      final response =
          await _retryOnTransient(() => _callOptionsHelper.executeWithTokenRotation(() async {
        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.verifyTransactionPin(
          request,
          options: callOptions,
        );
      }));

      if (!response.success) {
        // "No PIN set up" (e.g. an admin cleared it) comes back as a NORMAL
        // response (success=false, not locked), NOT a gRPC error — so detect it
        // here and signal setup, not a failed attempt. Also invalidate the
        // session cache so checkUserHasPin() stops fast-pathing to true.
        final msg = response.message.toLowerCase();
        if (!response.isLocked &&
            (msg.contains('does not have a pin') ||
                msg.contains('no pin') ||
                msg.contains('not set up') ||
                msg.contains('pin needs to be set'))) {
          _hasPinConfirmed = false;
          return TransactionPinVerificationResult.noPinSet(message: response.message);
        }

        // Check if PIN is locked
        if (response.isLocked) {
          return TransactionPinVerificationResult.locked(
            lockedUntil: response.expiresAt.toDateTime(),
            remainingAttempts: response.remainingAttempts,
          );
        }

        return TransactionPinVerificationResult.failure(
          message: response.message,
          remainingAttempts: response.remainingAttempts,
        );
      }

      return TransactionPinVerificationResult.success(
        token: response.verificationToken,
        expiresAt: response.expiresAt.toDateTime(),
        remainingAttempts: response.remainingAttempts,
      );
    } on GrpcError catch (e) {
      print('gRPC Error verifying PIN: $e');

      // Handle specific error codes. A NOT_FOUND means the user has no PIN
      // (e.g. an admin cleared it) — signal setup, not a generic failure, and
      // clear the session cache so checkUserHasPin() stops returning stale true.
      if (e.code == StatusCode.notFound) {
        _hasPinConfirmed = false;
        return TransactionPinVerificationResult.noPinSet();
      }

      throw Exception('Failed to verify PIN: ${e.message ?? "Unknown error"}');
    } catch (e) {
      print('Unexpected error verifying PIN: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  @override
  Future<bool> validateToken({
    required String token,
    required String transactionId,
  }) async {
    try {
      final userId = await _getUserId();

      final request = ValidateTransactionPinTokenRequest()
        ..token = token
        ..userId = userId
        ..transactionId = transactionId;

      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.validateTransactionPinToken(
          request,
          options: callOptions,
        );
      });

      return response.valid;
    } on GrpcError catch (e) {
      print('gRPC Error validating token: $e');
      throw Exception('Failed to validate token: ${e.message ?? "Unknown error"}');
    } catch (e) {
      print('Unexpected error validating token: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  @override
  Future<bool> createPin({
    required String pin,
    required String confirmPin,
  }) async {
    try {
      final userId = await _getUserId();
      final deviceId = await _getDeviceId();
      final deviceName = await _getDeviceName();

      final request = CreateTransactionPinRequest()
        ..userId = userId
        ..pin = pin
        ..confirmPin = confirmPin
        ..deviceId = deviceId
        ..deviceName = deviceName;

      // Run inside the token-rotation wrapper so an expired access token
      // doesn't permanently fail the create — the wrapper refreshes and
      // retries once on Unauthenticated.
      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final callOptions = await _callOptionsHelper.withAuth();
        print('[TransactionPinService] createPin for userId: $userId, deviceId: $deviceId');
        return await _client.createTransactionPin(
          request,
          options: callOptions,
        );
      });

      print('[TransactionPinService] createPin response: success=${response.success}, message=${response.message}');
      // A PIN now exists — warm the session cache so the very next PIN-gated
      // action (e.g. the payment we bounced out of, or a resumed login flow)
      // doesn't need another round-trip to discover it.
      if (response.success) _hasPinConfirmed = true;
      return response.success;
    } on GrpcError catch (e) {
      // RE-THROW the GrpcError unchanged so the caller can branch on
      // e.code (AlreadyExists, InvalidArgument, Unauthenticated, …) that the
      // backend mapped via classifyPinError in transaction_pin_server.go.
      // Wrapping in a generic Exception here would erase that signal.
      print('[TransactionPinService] gRPC Error creating PIN: ${e.codeName} - ${e.message}');
      rethrow;
    } catch (e) {
      print('Unexpected error creating PIN: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  @override
  Future<bool> changePin({
    required String currentPin,
    required String newPin,
    required String confirmNewPin,
  }) async {
    try {
      final userId = await _getUserId();

      final request = ChangeTransactionPinRequest()
        ..userId = userId
        ..currentPin = currentPin
        ..newPin = newPin
        ..confirmNewPin = confirmNewPin;

      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.changeTransactionPin(
          request,
          options: callOptions,
        );
      });

      return response.success;
    } on GrpcError catch (e) {
      // Re-throw so callers can distinguish Unauthenticated (wrong current
      // PIN) from PermissionDenied (locked) from InvalidArgument (format) —
      // see classifyPinError in transaction_pin_server.go.
      print('gRPC Error changing PIN: ${e.codeName} - ${e.message}');
      rethrow;
    } catch (e) {
      print('Unexpected error changing PIN: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  @override
  Future<bool> resetPin({
    required String verificationCode,
    required String newPin,
    required String confirmNewPin,
  }) async {
    try {
      final userId = await _getUserId();

      final request = ResetTransactionPinRequest()
        ..userId = userId
        ..verificationCode = verificationCode
        ..newPin = newPin
        ..confirmNewPin = confirmNewPin;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.resetTransactionPin(
        request,
        options: callOptions,
      );

      return response.success;
    } on GrpcError catch (e) {
      print('gRPC Error resetting PIN: $e');
      throw Exception('Failed to reset PIN: ${e.message ?? "Unknown error"}');
    } catch (e) {
      print('Unexpected error resetting PIN: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  @override
  Future<OTPInitiationResult> initiatePinOTP({
    required String operationType,
    required String channel,
  }) async {
    try {
      final userId = await _getUserId();
      final deviceId = await _getDeviceId();

      final request = InitiatePinOTPRequest()
        ..userId = userId
        ..operationType = operationType
        ..channel = channel
        ..deviceId = deviceId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.initiatePinOTP(
        request,
        options: callOptions,
      );

      return OTPInitiationResult(
        success: response.success,
        message: response.message,
        channel: response.channel,
        maskedDestination: response.maskedDestination,
        expiresInSeconds: response.expiresInSeconds,
        cooldownSeconds: response.cooldownSeconds,
      );
    } on GrpcError catch (e) {
      print('[TransactionPinService] gRPC Error initiating PIN OTP: ${e.codeName} - ${e.message}');
      throw Exception('Failed to initiate OTP: ${e.message ?? "Unknown error"}');
    } catch (e) {
      print('[TransactionPinService] Unexpected error initiating PIN OTP: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  @override
  Future<PinOTPVerifyResult> verifyPinOTP({
    required String otpCode,
    required String operationType,
    String? currentPin,
    required String newPin,
    required String confirmNewPin,
  }) async {
    try {
      final userId = await _getUserId();
      final deviceId = await _getDeviceId();

      final request = VerifyPinOTPRequest()
        ..userId = userId
        ..otpCode = otpCode
        ..operationType = operationType
        ..newPin = newPin
        ..confirmNewPin = confirmNewPin
        ..deviceId = deviceId;

      if (currentPin != null) {
        request.currentPin = currentPin;
      }

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.verifyPinOTP(
        request,
        options: callOptions,
      );

      return PinOTPVerifyResult(
        success: response.success,
        message: response.message,
        remainingAttempts: response.remainingAttempts,
      );
    } on GrpcError catch (e) {
      print('[TransactionPinService] gRPC Error verifying PIN OTP: ${e.codeName} - ${e.message}');
      throw Exception('Failed to verify OTP: ${e.message ?? "Unknown error"}');
    } catch (e) {
      print('[TransactionPinService] Unexpected error verifying PIN OTP: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  @override
  Future<List<OTPChannelInfo>> getPinOTPChannels() async {
    try {
      final userId = await _getUserId();

      final request = GetPinOTPChannelsRequest()
        ..userId = userId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.getPinOTPChannels(
        request,
        options: callOptions,
      );

      return response.channels.map((ch) => OTPChannelInfo(
        type: ch.type,
        maskedDestination: ch.maskedDestination,
        isVerified: ch.isVerified,
        isAvailable: ch.isAvailable,
      )).toList();
    } on GrpcError catch (e) {
      print('[TransactionPinService] gRPC Error getting PIN OTP channels: ${e.codeName} - ${e.message}');
      throw Exception('Failed to get OTP channels: ${e.message ?? "Unknown error"}');
    } catch (e) {
      print('[TransactionPinService] Unexpected error getting PIN OTP channels: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  @override
  Future<PinOTPVerifyResult> completeForgotPin({
    required String otpCode,
    required String newPin,
    required String confirmNewPin,
  }) async {
    try {
      final userId = await _getUserId();
      final deviceId = await _getDeviceId();

      final request = CompleteForgotPinRequest()
        ..userId = userId
        ..otpCode = otpCode
        ..newPin = newPin
        ..confirmNewPin = confirmNewPin
        ..deviceId = deviceId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.completeForgotPin(
        request,
        options: callOptions,
      );

      return PinOTPVerifyResult(
        success: response.success,
        message: response.message,
        remainingAttempts: response.remainingAttempts,
      );
    } on GrpcError catch (e) {
      print('[TransactionPinService] gRPC Error completing forgot PIN: ${e.codeName} - ${e.message}');
      throw Exception('Failed to complete forgot PIN: ${e.message ?? "Unknown error"}');
    } catch (e) {
      print('[TransactionPinService] Unexpected error completing forgot PIN: $e');
      throw Exception('An unexpected error occurred');
    }
  }
}
