part of 'directpay_authorization_sheet.dart';

/// Which flow is hosting the Mono webview. Drives the sheet chrome (header copy,
/// cancel-dialog wording, and whether we render our own close button). The
/// webview behaviour and redirect handling are identical across flows.
enum DirectPayFlow { deposit, mandate, kyc }

extension DirectPayFlowChrome on DirectPayFlow {
  String get headerTitle {
    switch (this) {
      case DirectPayFlow.kyc:
        return 'Identity Verification';
      case DirectPayFlow.mandate:
        return 'Set up Direct Debit';
      case DirectPayFlow.deposit:
        return 'Secure Payment';
    }
  }

  String get headerSubtitle {
    switch (this) {
      case DirectPayFlow.kyc:
        return 'Verify your identity securely';
      case DirectPayFlow.mandate:
        return 'Authorize recurring access';
      case DirectPayFlow.deposit:
        return 'Authorize with your bank';
    }
  }

  String get cancelTitle =>
      this == DirectPayFlow.kyc ? 'Stop verification?' : 'Cancel Payment?';

  String get cancelBody => this == DirectPayFlow.kyc
      ? 'Are you sure you want to stop identity verification? You will need to start over.'
      : 'Are you sure you want to cancel this payment authorization? You will need to start over.';

  String get cancelConfirmLabel =>
      this == DirectPayFlow.kyc ? 'Stop' : 'Cancel Payment';
}

/// DirectPay Authorization Result
class DirectPayAuthResult {
  final bool success;
  final String? paymentId;
  final String? reference;
  final String? errorMessage;

  /// The widget handed back control without telling us the outcome.
  ///
  /// NOT a failure and NOT a success — "we do not know, go and ask the
  /// provider". Mono's mandate redirect is a bare `lazervault://mandate/
  /// callback` with no status parameter, so inferring either way from it is a
  /// guess. For money and for mandates a guess is not good enough: the
  /// authoritative answer is one GET away.
  final bool unverified;

  const DirectPayAuthResult({
    required this.success,
    this.paymentId,
    this.reference,
    this.errorMessage,
    this.unverified = false,
  });

  /// The flow ended with no verdict of its own — the caller MUST confirm with
  /// the provider before telling the user anything.
  factory DirectPayAuthResult.unverified(
      {String? paymentId, String? reference}) {
    return DirectPayAuthResult(
      success: false,
      unverified: true,
      paymentId: paymentId,
      reference: reference,
    );
  }

  factory DirectPayAuthResult.success({String? paymentId, String? reference}) {
    return DirectPayAuthResult(
      success: true,
      paymentId: paymentId,
      reference: reference,
    );
  }

  factory DirectPayAuthResult.failed(String message) {
    return DirectPayAuthResult(
      success: false,
      errorMessage: message,
    );
  }

  factory DirectPayAuthResult.cancelled() {
    return const DirectPayAuthResult(
      success: false,
      errorMessage: 'Authorization cancelled',
    );
  }
}

class _DirectPayAuthSheet extends StatefulWidget {
  final String paymentUrl;
  final String paymentId;
  final String? reference;
  final String redirectScheme;
  final String redirectPath;
  final DirectPayFlow flow;

  const _DirectPayAuthSheet({
    required this.paymentUrl,
    required this.paymentId,
    this.reference,
    required this.redirectScheme,
    required this.redirectPath,
    this.flow = DirectPayFlow.deposit,
  });

  @override
  State<_DirectPayAuthSheet> createState() => _DirectPayAuthSheetState();
}
