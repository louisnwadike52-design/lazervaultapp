import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Transaction PIN entry modal for payment verification
class TransactionPinModal extends StatefulWidget {
  final String? title;
  final String? message;
  final double? amount;
  final String? currency;
  final Function(String) onPinSubmitted;
  final VoidCallback? onForgotPin;
  final VoidCallback? onCancel;
  final int maxAttempts;
  final int currentAttempt;
  final String? errorMessage;
  final bool isLoading;

  const TransactionPinModal({
    super.key,
    this.title,
    this.message,
    this.amount,
    this.currency,
    required this.onPinSubmitted,
    this.onForgotPin,
    this.onCancel,
    this.maxAttempts = 3,
    this.currentAttempt = 1,
    this.errorMessage,
    this.isLoading = false,
  });

  @override
  State<TransactionPinModal> createState() => _TransactionPinModalState();
}

class _TransactionPinModalState extends State<TransactionPinModal> {
  final TextEditingController _pinController = TextEditingController();
  final List<FocusNode> _pinFocusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> _pinControllers =
      List.generate(4, (_) => TextEditingController());

  String _pin = '';
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    // Auto-focus first PIN field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pinFocusNodes.isNotEmpty) {
        _pinFocusNodes[0].requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    for (var node in _pinFocusNodes) {
      node.dispose();
    }
    for (var controller in _pinControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onPinChanged(String value, int index) {
    if (value.length == 1 && index < 3) {
      // Move to next field
      _pinFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      // Move to previous field
      _pinFocusNodes[index - 1].requestFocus();
    }

    // Update PIN string
    _pin = _pinControllers.map((c) => c.text).join();

    // Auto-submit when 4 digits entered
    if (_pin.length == 4) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _submitPin();
      });
    }
  }

  void _submitPin() {
    if (_pin.length == 4) {
      widget.onPinSubmitted(_pin);
    } else {
      // Show error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a 4-digit PIN')),
      );
    }
  }

  void _clearPin() {
    for (var controller in _pinControllers) {
      controller.clear();
    }
    _pin = '';
    if (_pinFocusNodes.isNotEmpty) {
      _pinFocusNodes[0].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final remainingAttempts = widget.maxAttempts - widget.currentAttempt;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            _buildHeader(context, theme),

            const SizedBox(height: 24),

            // Amount display (if provided)
            if (widget.amount != null && widget.currency != null)
              _buildAmountDisplay(context, theme),

            const SizedBox(height: 24),

            // Error message
            if (widget.errorMessage != null)
              _buildErrorMessage(context, theme),

            const SizedBox(height: 8),

            // Remaining attempts warning
            if (remainingAttempts > 0 && remainingAttempts < widget.maxAttempts)
              _buildAttemptsWarning(context, theme, remainingAttempts),

            const SizedBox(height: 24),

            // PIN input fields
            _buildPinInputFields(context, theme),

            const SizedBox(height: 24),

            // Actions
            _buildActions(context, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme) {
    return Column(
      children: [
        // Lock icon
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.lock_outline,
            size: 32,
            color: theme.colorScheme.primary,
          ),
        ),

        const SizedBox(height: 16),

        // Title
        Text(
          widget.title ?? 'Enter Transaction PIN',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 8),

        // Message
        if (widget.message != null)
          Text(
            widget.message!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }

  Widget _buildAmountDisplay(BuildContext context, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            'Amount',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${widget.currency} ${widget.amount!.toStringAsFixed(2)}',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorMessage(BuildContext context, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: theme.colorScheme.error,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              widget.errorMessage!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onErrorContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttemptsWarning(
    BuildContext context,
    ThemeData theme,
    int remainingAttempts,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.colorScheme.error,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: theme.colorScheme.error,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$remainingAttempts attempt${remainingAttempts == 1 ? '' : 's'} remaining',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.error,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPinInputFields(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (index) {
        return SizedBox(
          width: 56,
          height: 64,
          child: TextField(
            controller: _pinControllers[index],
            focusNode: _pinFocusNodes[index],
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            keyboardType: TextInputType.number,
            obscureText: _isObscured,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(1),
            ],
            onChanged: (value) => _onPinChanged(value, index),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: theme.colorScheme.outline,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 2,
                ),
              ),
              filled: true,
              fillColor: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildActions(BuildContext context, ThemeData theme) {
    return Column(
      children: [
        // Toggle PIN visibility button
        if (!_isObscured || _pin.isNotEmpty)
          TextButton.icon(
            onPressed: () {
              setState(() {
                _isObscured = !_isObscured;
              });
            },
            icon: Icon(
              _isObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            ),
            label: Text(_isObscured ? 'Show PIN' : 'Hide PIN'),
          ),

        const SizedBox(height: 8),

        // Cancel button
        if (widget.onCancel != null)
          TextButton(
            onPressed: widget.isLoading ? null : widget.onCancel,
            child: Text(
              'Cancel',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ),

        // Forgot PIN link
        if (widget.onForgotPin != null)
          TextButton(
            onPressed: widget.isLoading ? null : widget.onForgotPin,
            child: const Text('Forgot PIN?'),
          ),
      ],
    );
  }
}

/// Show transaction PIN modal
/// Returns the PIN if submitted, null if cancelled
Future<String?> showTransactionPinModal(
  BuildContext context, {
  String? title,
  String? message,
  double? amount,
  String? currency,
  int maxAttempts = 3,
  int currentAttempt = 1,
  String? errorMessage,
  bool isLoading = false,
}) async {
  String? submittedPin;

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => TransactionPinModal(
      title: title,
      message: message,
      amount: amount,
      currency: currency,
      maxAttempts: maxAttempts,
      currentAttempt: currentAttempt,
      errorMessage: errorMessage,
      isLoading: isLoading,
      onPinSubmitted: (pin) {
        submittedPin = pin;
        Navigator.of(context).pop();
      },
      onCancel: () {
        Navigator.of(context).pop();
      },
    ),
  );

  return submittedPin;
}
