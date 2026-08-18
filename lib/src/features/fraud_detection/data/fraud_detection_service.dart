import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/generated/payments.pbgrpc.dart';

/// Thin client for the per-user behavioural fraud-detection RPCs on the Transfer
/// Gateway → core-payments (setting toggle, freeze status, tx-PIN self-unfreeze).
/// Every call attaches the authed JWT via [GrpcCallOptionsHelper.withAuth].
class FraudDetectionService {
  FraudDetectionService(this._client, this._callOptions);

  final PaymentsServiceClient _client;
  final GrpcCallOptionsHelper _callOptions;

  /// Whether the user's fraud detection is ON (default true). Fails safe to ON.
  Future<bool> getEnabled() async {
    final opts = await _callOptions.withAuth();
    final res = await _client.getFraudDetectionSetting(
      GetFraudDetectionSettingRequest(),
      options: opts,
    );
    return res.enabled;
  }

  /// Turn fraud detection on/off. Returns the persisted value.
  Future<bool> setEnabled(bool enabled) async {
    final opts = await _callOptions.withAuth();
    final res = await _client.setFraudDetectionSetting(
      SetFraudDetectionSettingRequest()..enabled = enabled,
      options: opts,
    );
    return res.enabled;
  }

  /// Whether the account is currently frozen for suspicious activity.
  Future<FraudFreezeStatus> getFreezeStatus() async {
    final opts = await _callOptions.withAuth();
    return _client.getFraudFreezeStatus(
      GetFraudFreezeStatusRequest(),
      options: opts,
    );
  }

  /// Self-unfreeze after re-proving identity with the tx-PIN verification token
  /// (the same token the send-funds flow mints).
  Future<RequestFraudUnfreezeResponse> requestUnfreeze({
    required String verificationToken,
    required String transactionId,
  }) async {
    final opts = await _callOptions.withAuth();
    return _client.requestFraudUnfreeze(
      RequestFraudUnfreezeRequest()
        ..verificationToken = verificationToken
        ..transactionId = transactionId,
      options: opts,
    );
  }
}
