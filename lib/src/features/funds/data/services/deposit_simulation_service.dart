import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Deposit Simulation Service
///
/// Simulates Flutterwave deposit webhooks for development/testing.
/// In production, this should be disabled or behind authentication.
class DepositSimulationService {
  static const String _devModeFlag = 'DEPOSIT_SIMULATION_ENABLED';

  /// Check if simulation mode is enabled
  static bool get isSimulationEnabled =>
      kDebugMode &&
      dotenv.env[_devModeFlag] == 'true';

  /// Get the webhook URL from config
  /// Prefers direct local URL (reliable) over ngrok (intermittent 404s on free tier)
  static String get _bankingWebhookUrl {
    // Prefer direct local URL for emulator - avoids ngrok free tier issues
    // (interstitial page, rate limits, connection drops cause intermittent 404s)
    final localUrl = dotenv.env['WEBHOOK_GATEWAY_URL'];
    if (localUrl != null && localUrl.isNotEmpty) {
      return '$localUrl/webhooks/flutterwave';
    }
    // Fall back to ngrok URL for physical device testing (can't reach localhost)
    final ngrokUrl = dotenv.env['WEBHOOK_GATEWAY_NGROK_URL'];
    if (ngrokUrl != null && ngrokUrl.isNotEmpty) {
      return '$ngrokUrl/webhooks/flutterwave';
    }
    // Final fallback to local webhook gateway
    final grpcHost = dotenv.env['GRPC_API_HOST'] ?? '10.0.2.2';
    return 'http://$grpcHost:8090/webhooks/flutterwave';
  }

  /// Simulate a successful Flutterwave deposit webhook
  ///
  /// This sends a mock Flutterwave charge.completed event to the banking service,
  /// which will credit the user's account and send a WebSocket notification.
  static Future<SimulationResult> simulateDeposit({
    required String accountNumber,
    required String accountName,
    required double amount,
    String currency = 'NGN',
  }) async {
    if (!isSimulationEnabled) {
      return SimulationResult(
        success: false,
        message: 'Deposit simulation is disabled. Set DEPOSIT_SIMULATION_ENABLED=true in .env',
      );
    }

    try {
      // Generate unique transaction reference
      final txRef = 'SIM_${DateTime.now().millisecondsSinceEpoch}';

      // Create production-grade Flutterwave webhook payload
      // Matches actual Flutterwave bank_transfer webhook format
      final webhookPayload = {
        'event': 'charge.completed',
        'data': {
          'id': DateTime.now().millisecondsSinceEpoch,
          'tx_ref': txRef,
          'flw_ref': 'FLW-MOCK-$txRef',
          'device_fingerprint': 'SIMULATION',
          'amount': amount,
          'charged_amount': amount,
          'app_fee': 0,
          'merchant_fee': 0,
          'currency': currency,
          'customer': {
            'id': DateTime.now().millisecondsSinceEpoch,
            'name': accountName,
            'phone_number': null,
            'email': 'simulation@lazervault.app',
            'created_at': DateTime.now().toIso8601String(),
          },
          'meta': {
            'account_number': accountNumber,
            'simulation': 'true',
            '__CheckoutInitAddress': 'https://lazervault.app',
          },
          'status': 'successful',
          'payment_type': 'bank_transfer',
          'processor_response': 'Approved',
          'narration': 'LazerVault Test Deposit',
          'created_at': DateTime.now().toIso8601String(),
          // Virtual account details matching Flutterwave response
          'account_id': accountNumber,
        },
        // Include event_type for newer webhook formats
        'event.type': 'BANK_TRANSFER_TRANSACTION',
      };

      // Send webhook to banking service
      final response = await http.post(
        Uri.parse(_bankingWebhookUrl),
        headers: {
          'Content-Type': 'application/json',
          // Skip signature verification in development
          'X-Simulation-Mode': 'true',
        },
        body: jsonEncode(webhookPayload),
      );

      debugPrint('[DepositSimulation] Webhook sent: $txRef');
      debugPrint('[DepositSimulation] Response: ${response.statusCode} ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return SimulationResult(
          success: true,
          message: 'Deposit of $currency$amount simulated successfully!',
          txRef: txRef,
          amount: amount,
        );
      } else {
        return SimulationResult(
          success: false,
          message: 'Webhook failed: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      debugPrint('[DepositSimulation] Error: $e');
      return SimulationResult(
        success: false,
        message: 'Simulation failed: $e',
      );
    }
  }

  /// Get predefined test amounts
  static List<double> get testAmounts => [500, 1000, 2000, 5000, 10000, 25000];
}

/// Result of a deposit simulation
class SimulationResult {
  final bool success;
  final String message;
  final String? txRef;
  final double? amount;

  const SimulationResult({
    required this.success,
    required this.message,
    this.txRef,
    this.amount,
  });

  @override
  String toString() => 'SimulationResult(success: $success, message: $message)';
}
