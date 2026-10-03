import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';

/// Shared across the chat-PIN test files so the fake and the payload shape
/// cannot drift between the card test and the sequence harness.
class FakePinService implements ITransactionPinService {
  FakePinService({this.hasPin = true, this.throwOnCheck = false});

  final bool hasPin;
  final bool throwOnCheck;
  int checkCalls = 0;

  @override
  Future<bool> checkUserHasPin({bool forceRefresh = false}) async {
    checkCalls++;
    if (throwOnCheck) throw Exception('network down');
    return hasPin;
  }

  @override
  void resetPinCache() {}

  @override
  Future<TransactionPinVerificationResult> verifyPin({
    required String pin,
    required String transactionId,
    required String transactionType,
    required double amount,
    required String currency,
  }) async =>
      TransactionPinVerificationResult(
        success: true,
        verificationToken: 'tok_${transactionId}_ok',
      );

  @override
  Future<bool> validateToken({
    required String token,
    required String transactionId,
  }) async =>
      true;

  @override
  Future<bool> createPin({
    required String pin,
    required String confirmPin,
  }) async =>
      true;

  @override
  Future<bool> changePin({
    required String currentPin,
    required String newPin,
    required String confirmNewPin,
  }) async =>
      true;

  @override
  Future<bool> resetPin({
    required String verificationCode,
    required String newPin,
    required String confirmNewPin,
  }) async =>
      true;

  @override
  Future<OTPInitiationResult> initiatePinOTP({
    required String operationType,
    required String channel,
  }) async =>
      OTPInitiationResult(success: true, message: '');

  @override
  Future<PinOTPVerifyResult> verifyPinOTP({
    required String otpCode,
    required String operationType,
    String? currentPin,
    required String newPin,
    required String confirmNewPin,
  }) async =>
      PinOTPVerifyResult(success: true, message: '');

  @override
  Future<List<OTPChannelInfo>> getPinOTPChannels() async => const [];

  @override
  Future<PinOTPVerifyResult> completeForgotPin({
    required String otpCode,
    required String newPin,
    required String confirmNewPin,
  }) async =>
      PinOTPVerifyResult(success: true, message: '');
}

Map<String, dynamic> pinPayload({
  String txId = 'tx-1',
  String? expiresAt,
  String amount = '500',
}) =>
    {
      'transaction_id': txId,
      'transaction_type': 'transfer',
      'amount': amount,
      'fee': '10',
      'total_amount': '510',
      'currency': 'NGN',
      'recipient_summary': 'Chris Okoye · Alat by Wema',
      'recipient_name': 'Chris Okoye',
      if (expiresAt != null) 'expires_at': expiresAt,
    };

