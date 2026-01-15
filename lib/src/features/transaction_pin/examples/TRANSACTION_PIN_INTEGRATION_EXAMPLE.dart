import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';

/// Example: How to integrate Transaction PIN into Airtime Payment
///
/// This shows the complete integration including:
/// 1. Adding the mixin to the screen
/// 2. Implementing the required getter
/// 3. Calling validateTransactionPin
/// 4. Handling the verification token
class AirtimePaymentExample extends StatefulWidget {
  final String phoneNumber;
  final double amount;
  final String provider;

  const AirtimePaymentExample({
    Key? key,
    required this.phoneNumber,
    required this.amount,
    required this.provider,
  }) : super(key: key);

  @override
  State<AirtimePaymentExample> createState() => _AirtimePaymentExampleState();
}

/// Step 1: Add TransactionPinMixin to your State class
class _AirtimePaymentExampleState extends State<AirtimePaymentExample>
    with TransactionPinMixin {

  /// Step 2: Implement the required getter
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  bool _isProcessing = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airtime Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Payment details
            _buildPaymentDetails(),

            const SizedBox(height: 32),

            // Error message
            if (_errorMessage != null)
              _buildErrorMessage(),

            const SizedBox(height: 24),

            // Confirm button
            ElevatedButton(
              onPressed: _isProcessing ? null : _processPayment,
              child: _isProcessing
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Confirm Payment'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetails() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Summary',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(height: 24),
            _buildDetailRow('Provider', widget.provider),
            _buildDetailRow('Phone Number', widget.phoneNumber),
            _buildDetailRow('Amount', '₦${widget.amount.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red[700], size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _errorMessage!,
              style: TextStyle(color: Colors.red[900]),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: () {
              setState(() {
                _errorMessage = null;
              });
            },
          ),
        ],
      ),
    );
  }

  /// Step 3: Call validateTransactionPin when processing payment
  Future<void> _processPayment() async {
    setState(() {
      _isProcessing = true;
      _errorMessage = null;
    });

    try {
      // Generate unique transaction ID
      final transactionId = 'airtime_${DateTime.now().millisecondsSinceEpoch}_${widget.phoneNumber}';

      // Validate PIN and execute payment
      final success = await validateTransactionPin(
        context: context,
        transactionId: transactionId,
        transactionType: 'airtime_purchase', // ← Use correct transaction type
        amount: widget.amount,
        currency: 'NGN', // ← Use appropriate currency
        title: 'Confirm Airtime Purchase',
        message: 'Purchase ₦${widget.amount.toStringAsFixed(2)} airtime for ${widget.phoneNumber}?',
        onPinValidated: (verificationToken) async {
          /// Step 4: Execute payment with verification token
          await _executeAirtimePurchase(transactionId, verificationToken);
        },
      );

      if (!success) {
        // PIN validation failed or user cancelled
        setState(() {
          _errorMessage = 'Payment was cancelled. Please try again.';
        });
      }
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  /// Step 5: Execute actual payment with verification token
  Future<void> _executeAirtimePurchase(
    String transactionId,
    String verificationToken,
  ) async {
    try {
      // Call your airtime service with the verification token
      // final response = await airtimeService.purchase(
      //   phoneNumber: widget.phoneNumber,
      //   amount: widget.amount,
      //   provider: widget.provider,
      //   transactionId: transactionId,
      //   verificationToken: verificationToken, // ← Include token
      // );

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Show success and navigate
      if (mounted) {
        _showSuccessDialog();
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Payment failed: ${e.toString()}';
      });
      rethrow;
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.check_circle,
          color: Colors.green[700],
          size: 64,
        ),
        title: const Text('Payment Successful'),
        content: Text(
          '₦${widget.amount.toStringAsFixed(2)} airtime has been sent to ${widget.phoneNumber}.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Go back to previous screen
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}

/// ========================================
/// ALTERNATIVE: Direct PIN Validation (Without Payment Execution)
/// ========================================
///
/// Use this when you just need to validate the PIN without executing a payment
/// For example, when setting up recurring payments or saving beneficiary
class DirectPinValidationExample extends StatefulWidget {
  const DirectPinValidationExample({Key? key}) : super(key: key);

  @override
  State<DirectPinValidationExample> createState() => _DirectPinValidationExampleState();
}

class _DirectPinValidationExampleState extends State<DirectPinValidationExample>
    with TransactionPinMixin {

  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  Future<void> _validatePinOnly() async {
    final result = await validatePinOnly(
      context: context,
      transactionId: 'validation_${DateTime.now().millisecondsSinceEpoch}',
      transactionType: 'validation',
      amount: 0, // Not processing actual payment
      currency: 'NGN',
    );

    if (result != null && result!.success) {
      // PIN is valid
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PIN validated successfully')),
      );

      // Store token for later use if needed
      final token = result!.verificationToken;
      print('Token: $token');
      print('Expires at: ${result.expiresAt}');
    } else if (result?.isLocked == true) {
      // PIN is locked - error shown automatically by mixin
    } else if (result == null) {
      // User cancelled
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PIN validation cancelled')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PIN Validation Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: _validatePinOnly,
          child: const Text('Validate PIN'),
        ),
      ),
    );
  }
}

/// ========================================
/// COMPLETE WORKING EXAMPLE WITH MOCK SERVICE
/// ========================================
///
/// This example includes a mock airtime service for testing
class CompleteAirtimePaymentExample extends StatefulWidget {
  final String phoneNumber;
  final double amount;

  const CompleteAirtimePaymentExample({
    Key? key,
    required this.phoneNumber,
    required this.amount,
  }) : super(key: key);

  @override
  State<CompleteAirtimePaymentExample> createState() =>
      _CompleteAirtimePaymentExampleState();
}

class _CompleteAirtimePaymentExampleState extends State<CompleteAirtimePaymentExample>
    with TransactionPinMixin {

  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airtime Payment - Complete Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Purchase ₦${amount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'for $phoneNumber',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _processAirtimePurchase,
              child: const Text('Purchase Airtime'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _processAirtimePurchase() async {
    // Generate transaction ID
    final transactionId = 'airtime_${DateTime.now().millisecondsSinceEpoch}';

    // Validate PIN
    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'airtime_purchase',
      amount: amount,
      currency: 'NGN',
      title: 'Confirm Purchase',
      message: 'Confirm airtime purchase for $phoneNumber?',
      onPinValidated: (token) async {
        // Execute payment with token
        await _mockAirtimeServiceCall(transactionId, token);
      },
    );

    if (!success) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Payment cancelled or failed')),
        );
      }
    }
  }

  Future<void> _mockAirtimeServiceCall(String txnId, String token) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // In production, call actual API:
    // await airtimeService.purchase(
    //   phoneNumber: widget.phoneNumber,
    //   amount: widget.amount,
    //   transactionId: txnId,
    //   verificationToken: token,
    // );

    if (mounted) {
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: Colors.green, size: 64),
        title: const Text('Success!'),
        content: Text(
          '₦${amount.toStringAsFixed(2)} airtime sent to $phoneNumber',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
