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
  Future<bool> checkUserHasPin();

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

  TransactionPinVerificationResult({
    required this.success,
    this.message,
    this.verificationToken,
    this.expiresAt,
    this.remainingAttempts = 3,
    this.isLocked = false,
    this.lockedUntil,
  }) : isLockedUntil = lockedUntil != null && lockedUntil.isAfter(DateTime.now());

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

/// Implementation of transaction PIN service using gRPC
class TransactionPinService implements ITransactionPinService {
  final TransactionPinServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;
  final AccountManager _accountManager;

  TransactionPinService({
    required TransactionPinServiceClient client,
    required GrpcCallOptionsHelper callOptionsHelper,
    required AccountManager accountManager,
  })  : _client = client,
        _callOptionsHelper = callOptionsHelper,
        _accountManager = accountManager;

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
        return androidInfo.id ?? uuid.v4();
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
        return iosInfo.model ?? 'iOS Device';
      }

      return 'Mobile Device';
    } catch (e) {
      return 'Mobile Device';
    }
  }

  @override
  Future<bool> checkUserHasPin() async {
    try {
      final userId = await _getUserId();

      final request = CheckUserHasPinRequest()..userId = userId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.checkUserHasPin(
        request,
        options: callOptions,
      );

      return response.hasPin;
    } on GrpcError catch (e) {
      print('gRPC Error checking PIN: $e');
      throw Exception('Failed to check PIN status: ${e.message ?? "Unknown error"}');
    } catch (e) {
      print('Unexpected error checking PIN: $e');
      throw Exception('An unexpected error occurred');
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

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.verifyTransactionPin(
        request,
        options: callOptions,
      );

      if (!response.success) {
        // Check if PIN is locked
        if (response.isLocked) {
          return TransactionPinVerificationResult.locked(
            lockedUntil: response.expiresAt.toDateTime(),
            remainingAttempts: response.remainingAttempts,
          );
        }

        return TransactionPinVerificationResult.failure(
          message: response.message ?? 'Invalid PIN',
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

      // Handle specific error codes
      if (e.code == StatusCode.notFound) {
        return TransactionPinVerificationResult.failure(
          message: 'Transaction PIN not set up. Please create a PIN first.',
          remainingAttempts: 0,
        );
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

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.validateTransactionPinToken(
        request,
        options: callOptions,
      );

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

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.createTransactionPin(
        request,
        options: callOptions,
      );

      return response.success;
    } on GrpcError catch (e) {
      print('gRPC Error creating PIN: $e');
      throw Exception('Failed to create PIN: ${e.message ?? "Unknown error"}');
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

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.changeTransactionPin(
        request,
        options: callOptions,
      );

      return response.success;
    } on GrpcError catch (e) {
      print('gRPC Error changing PIN: $e');
      throw Exception('Failed to change PIN: ${e.message ?? "Unknown error"}');
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
}
