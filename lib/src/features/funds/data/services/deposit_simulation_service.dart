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

  /// Get the banking service webhook URL from config
  static String get _bankingWebhookUrl {
    final baseUrl = dotenv.env['GRPC_API_HOST'] ?? 'http://localhost:8080';
    return '$baseUrl/webhooks/flutterwave';
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

      // Create mock Flutterwave webhook payload
      final webhookPayload = {
        'event': 'charge.completed',
        'data': {
          'tx_ref': txRef,
          'flw_ref': 'FLW-MOCK-$txRef',
          'amount': amount,
          'currency': currency,
          'customer': {
            'name': accountName,
          },
          'meta': {
            'account_number': accountNumber,
            'simulation': true,
          },
          'status': 'successful',
          'payment_type': 'bank_transfer',
          'created_at': DateTime.now().toIso8601String(),
        },
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
