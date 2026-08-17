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

  const DirectPayAuthResult({
    required this.success,
    this.paymentId,
    this.reference,
    this.errorMessage,
  });

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
