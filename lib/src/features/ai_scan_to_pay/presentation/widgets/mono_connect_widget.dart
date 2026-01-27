import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mono_connect/mono_connect.dart';
import 'package:mono_connect/src/connect_web_view.dart';

import '../../../../core/config/mono_config.dart';

/// Production-ready Mono Connect Widget using native SDK
///
/// Uses Mono's official Flutter SDK for bank account linking.
/// This provides the best user experience with:
/// - Native UI components
/// - Bank pre-selection to skip bank selection screen
/// - Secure credential handling
/// - Multi-factor authentication support
///
/// Features:
/// - Institution pre-selection with selectedInstitution parameter
/// - Returns full result with bank info for UI updates
/// - Comprehensive event handling

/// Launch Mono Connect as a bottom sheet style (using native SDK)
/// Returns MonoConnectResult with auth code and institution info
///
/// Note: The native SDK manages its own UI presentation.
/// This function provides a consistent API with the previous webview implementation.
///
/// Parameters:
/// - [operation]: The type of Mono operation (accountLinking, directPay, etc.)
///   This determines the scope sent to Mono:
///   - accountLinking → 'auth' (read-only access)
///   - directPay/directDebit/mandate → 'payments' (payment authorization)
///
/// In sandbox mode (test_pk_ keys):
/// - Use test credentials: user_good/123456, PIN: 1234, OTP: 123456
/// - API calls are free
/// - Customers appear in Mono dashboard under sandbox environment
Future<MonoConnectResult?> showMonoConnectBottomSheet({
  required BuildContext context,
  required String publicKey,
  String? institutionId,
  String? reference,
  String? title,
  String? customerName,
  String? customerEmail,
  String? customerBvn,
  MonoOperation operation = MonoOperation.accountLinking,
}) async {
  final completer = MonoConnectCompleter();

  // Track selected institution for result
  String? selectedInstitutionId = institutionId;
  String? selectedInstitutionName;

  // Get institution name from config if ID provided
  if (institutionId != null) {
    final inst = MonoConfig.getInstitutionById(institutionId);
    if (inst != null) {
      selectedInstitutionName = inst.name;
    }
  }

  // Build selected institution config if institution ID is provided
  // This skips the bank selection screen
  // Use mobileBanking for better UX (cleaner than internet banking)
  ConnectInstitution? selectedInstitution;
  if (institutionId != null && institutionId.isNotEmpty) {
    selectedInstitution = ConnectInstitution(
      id: institutionId,
      authMethod: ConnectAuthMethod.mobileBanking, // Better UX than internetBanking
    );
    debugPrint('[MonoConnect] Pre-selecting institution: $institutionId (${selectedInstitutionName ?? "unknown"}) with mobileBanking');
  }

  // Use authenticated user's email directly - validated during signup
  // Production-grade: no fallback emails, use the real user data
  final emailToUse = customerEmail ?? '';

  // Build customer config - required by the SDK
  final customer = MonoCustomer(
    newCustomer: MonoNewCustomer(
      name: customerName ?? 'LazerVault User',
      email: emailToUse,
      identity: (customerBvn != null && customerBvn.isNotEmpty)
          ? MonoCustomerIdentity(
              type: 'bvn',
              number: customerBvn,
            )
          : null,
    ),
  );

  final ref = reference ?? 'lzv_${DateTime.now().millisecondsSinceEpoch}';

  // Determine the scope based on the operation type
  final scope = MonoConfig.getScopeForOperation(operation);

  debugPrint('[MonoConnect] ========== CONFIGURATION ==========');
  debugPrint('[MonoConnect] Public Key: ${publicKey.substring(0, publicKey.length > 20 ? 20 : publicKey.length)}...');
  debugPrint('[MonoConnect] Effective Mode: ${MonoConfig.effectiveMode}');
  debugPrint('[MonoConnect] Environment: ${MonoConfig.environment}');
  debugPrint('[MonoConnect] Operation: ${operation.name}');
  debugPrint('[MonoConnect] Scope: $scope');
  debugPrint('[MonoConnect] Institution ID: $institutionId');
  debugPrint('[MonoConnect] Reference: $ref');
  debugPrint('[MonoConnect] Customer Name: ${customerName ?? 'LazerVault User'}');
  debugPrint('[MonoConnect] Customer Email: $emailToUse');
  debugPrint('[MonoConnect] Requires Business Approval: ${MonoConfig.requiresBusinessApproval}');

  // Log environment/key mismatch warning if any
  final mismatchWarning = MonoConfig.environmentMismatchWarning;
  if (mismatchWarning != null) {
    debugPrint('[MonoConnect] ⚠️  $mismatchWarning');
  }

  // Log sandbox test credentials if in sandbox mode
  if (MonoConfig.isSandboxMode) {
    debugPrint('[MonoConnect] SANDBOX MODE - Use test credentials:');
    debugPrint('[MonoConnect]   Username: ${MonoConfig.sandboxTestUsername}');
    debugPrint('[MonoConnect]   Password: ${MonoConfig.sandboxTestPassword}');
    debugPrint('[MonoConnect]   PIN: ${MonoConfig.sandboxTestPin}');
    debugPrint('[MonoConnect]   OTP: ${MonoConfig.sandboxTestOtp}');
  }
  debugPrint('[MonoConnect] ==========================================');

  // Build configuration
  final config = ConnectConfiguration(
    publicKey: publicKey,
    customer: customer,
    reference: ref,
    scope: scope,
    selectedInstitution: selectedInstitution,
    onSuccess: (code) {
      debugPrint('[MonoConnect] Success - Code: ${code.substring(0, code.length > 10 ? 10 : code.length)}...');
      HapticFeedback.mediumImpact();

      // Build the result with institution info
      MonoInstitution? institution;
      if (selectedInstitutionId != null && selectedInstitutionId!.isNotEmpty) {
        institution = MonoConfig.getInstitutionById(selectedInstitutionId!);
      }

      final result = MonoConnectResult(
        code: code,
        institution: institution,
        institutionId: selectedInstitutionId,
        institutionName: selectedInstitutionName ?? institution?.name,
      );

      completer.complete(result);
    },
    onEvent: (event) {
      debugPrint('[MonoConnect] Event: ${event.type.value}');

      // Track institution selection from events
      if (event.data.institutionId != null) {
        selectedInstitutionId = event.data.institutionId;
        selectedInstitutionName = event.data.institutionName;
        debugPrint('[MonoConnect] Institution from event: $selectedInstitutionId - $selectedInstitutionName');
      }
    },
    onClose: () {
      debugPrint('[MonoConnect] Closed');
      HapticFeedback.lightImpact();

      if (!completer.isCompleted) {
        // User cancelled
        completer.complete(null);
      }
    },
  );

  // Launch Mono Connect as custom modal bottom sheet (70% height with themed background)
  _launchCustomMonoBottomSheet(context, config);

  return completer.future;
}

/// Custom themed Mono Connect bottom sheet with 90% screen height and styled overlay
void _launchCustomMonoBottomSheet(BuildContext context, ConnectConfiguration config) {
  showModalBottomSheet<dynamic>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: const Color(0xFF0D0D1A).withOpacity(0.85), // Dark themed overlay
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24),
      ),
    ),
    clipBehavior: Clip.hardEdge,
    builder: (_) => Container(
      height: MediaQuery.of(context).size.height * 0.85, // 85% of screen
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4E03D0).withOpacity(0.4),
            blurRadius: 30,
            spreadRadius: 2,
            offset: const Offset(0, -8),
          ),
          BoxShadow(
            color: const Color(0xFF6C5CE7).withOpacity(0.2),
            blurRadius: 60,
            spreadRadius: 0,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Custom themed drag handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4E03D0), Color(0xFF6C5CE7)],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Mono WebView takes remaining space
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: ConnectWebView.config(
                config: config,
                showLogs: true,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

/// Launch Mono Connect using native SDK (Full screen modal style)
/// Returns MonoConnectResult with auth code and institution info
///
/// Parameters:
/// - [operation]: The type of Mono operation. Defaults to accountLinking.
///   Use MonoOperation.directPay for payment flows.
Future<MonoConnectResult?> showMonoConnect({
  required BuildContext context,
  required String publicKey,
  String? institutionId,
  String? reference,
  String? title,
  String? customerName,
  String? customerEmail,
  String? customerBvn,
  MonoOperation operation = MonoOperation.accountLinking,
}) async {
  // Use the same implementation as bottom sheet
  // The SDK manages its own presentation
  return showMonoConnectBottomSheet(
    context: context,
    publicKey: publicKey,
    institutionId: institutionId,
    reference: reference,
    title: title,
    customerName: customerName,
    customerEmail: customerEmail,
    customerBvn: customerBvn,
    operation: operation,
  );
}

/// Helper class to handle async completion of Mono Connect flow
class MonoConnectCompleter {
  MonoConnectResult? _result;
  bool _isCompleted = false;
  void Function(MonoConnectResult?)? _onComplete;

  bool get isCompleted => _isCompleted;

  void complete(MonoConnectResult? result) {
    if (_isCompleted) return;
    _isCompleted = true;
    _result = result;
    _onComplete?.call(result);
  }

  Future<MonoConnectResult?> get future async {
    if (_isCompleted) return _result;

    // Wait for completion using a polling pattern
    // The SDK callbacks will set _isCompleted
    while (!_isCompleted) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    return _result;
  }
}

/// Legacy MonoConnectWidget class for backwards compatibility
/// The native SDK doesn't require a widget - use the launch functions instead
class MonoConnectWidget extends StatelessWidget {
  final String publicKey;
  final Function(MonoConnectResult result) onSuccess;
  final VoidCallback onCancel;
  final Function(String error) onError;
  final String? institutionId;
  final String? reference;
  final String? title;
  final String? customerName;
  final String? customerEmail;
  final String? customerBvn;

  const MonoConnectWidget({
    super.key,
    required this.publicKey,
    required this.onSuccess,
    required this.onCancel,
    required this.onError,
    this.institutionId,
    this.reference,
    this.title,
    this.customerName,
    this.customerEmail,
    this.customerBvn,
  });

  @override
  Widget build(BuildContext context) {
    // This widget is not meant to be rendered directly
    // The native SDK manages its own UI
    return const SizedBox.shrink();
  }

  /// Launch Mono Connect with native SDK
  void launch(BuildContext context) {
    showMonoConnectBottomSheet(
      context: context,
      publicKey: publicKey,
      institutionId: institutionId,
      reference: reference,
      title: title,
      customerName: customerName,
      customerEmail: customerEmail,
      customerBvn: customerBvn,
    ).then((result) {
      if (result != null) {
        onSuccess(result);
      } else {
        onCancel();
      }
    }).catchError((error) {
      onError(error.toString());
    });
  }
}
