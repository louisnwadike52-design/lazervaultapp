import 'dart:async';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
part 'pin_entry_workflow_widgets.dart';


/// PIN Entry Screen
class PINEntryScreen extends StatefulWidget {
  final PINWorkflowManager workflowManager;
  final VoidCallback? onPINValidated;
  final VoidCallback? onPINBlocked;
  final VoidCallback? onCancelled;

  const PINEntryScreen({
    super.key,
    required this.workflowManager,
    this.onPINValidated,
    this.onPINBlocked,
    this.onCancelled,
  });

  @override
  State<PINEntryScreen> createState() => _PINEntryScreenState();
}

class _PINEntryScreenState extends State<PINEntryScreen> {
  final TextEditingController _pinController = TextEditingController();
  final List<FocusNode> _pinFocusNodes = List.generate(4, (_) => FocusNode());

  String _currentPIN = '';
  String? _errorMessage;
  bool _isLoading = false;
  int _retriesRemaining = 3;
  bool _isBlocked = false;

  // Session timeout - 5 minutes for PIN entry
  Timer? _sessionTimeoutTimer;
  static const Duration _sessionTimeout = Duration(minutes: 5);

  @override
  void initState() {
    super.initState();

    // Start 5-minute session timeout
    _startSessionTimeout();

    // Listen to PIN workflow events
    widget.workflowManager.events.listen((event) {
      if (!mounted) return;

      switch (event.type) {
        case PINWorkflowEventType.pinInvalid:
          setState(() {
            _errorMessage = event.message ?? 'Invalid PIN';
            _retriesRemaining = event.data?['retries_remaining'] ?? _retriesRemaining - 1;
            _isLoading = false;
            _clearPIN();
          });
          break;

        case PINWorkflowEventType.pinValidated:
          setState(() {
            _isLoading = false;
          });
          widget.onPINValidated?.call();
          break;

        case PINWorkflowEventType.pinBlocked:
          setState(() {
            _isBlocked = true;
            _isLoading = false;
            _errorMessage = event.message ?? 'Too many invalid attempts';
          });
          widget.onPINBlocked?.call();
          break;

        case PINWorkflowEventType.workflowComplete:
          // Transaction completed
          Navigator.of(context).pop(event.data);
          break;

        case PINWorkflowEventType.workflowCancelled:
          Navigator.of(context).pop();
          break;

        case PINWorkflowEventType.sessionExpired:
          setState(() {
            _errorMessage = 'PIN entry session expired. Please try again.';
            _isLoading = false;
          });
          break;

        default:
          break;
      }
    });
  }

  @override
  void dispose() {
    _sessionTimeoutTimer?.cancel();
    _pinController.dispose();
    for (var node in _pinFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startSessionTimeout() {
    _sessionTimeoutTimer?.cancel();
    _sessionTimeoutTimer = Timer(_sessionTimeout, () {
      if (mounted) {
        setState(() {
          _errorMessage = 'PIN entry session expired. Please try again.';
          _isLoading = false;
        });
        // Cancel PIN and close dialog after short delay to show error
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            widget.onCancelled?.call();
            Navigator.of(context).pop();
          }
        });
      }
    });
  }

  void _clearPIN() {
    _currentPIN = '';
    _pinController.clear();
    for (var node in _pinFocusNodes) {
      node.unfocus();
    }
    _pinFocusNodes[0].requestFocus();
  }

  void _onPINDigitChanged(String value) {
    if (value.length > 4) return;

    setState(() {
      _currentPIN = value;
    });

    // Auto-focus next field
    if (value.length < 4) {
      _pinFocusNodes[value.length].requestFocus();
    }

    // Auto-submit when 4 digits entered
    if (value.length == 4 && !_isLoading && !_isBlocked) {
      _submitPIN();
    }
  }

  Future<void> _submitPIN() async {
    if (_currentPIN.length != 4 || _isLoading || _isBlocked) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await widget.workflowManager.submitPIN(_currentPIN);
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to submit PIN. Please try again.';
      });
    }
  }

  void _cancel() {
    widget.workflowManager.cancelPIN();
    widget.onCancelled?.call();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _cancel();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Enter Transaction PIN'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: _cancel,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Icon
                Icon(
                  _isBlocked ? Icons.block : Icons.lock_outline,
                  size: 80,
                  color: _isBlocked
                      ? theme.colorScheme.error
                      : theme.colorScheme.primary,
                ),
                const SizedBox(height: 24),

                // Title
                Text(
                  _isBlocked ? 'PIN Blocked' : 'Enter Your PIN',
                  style: theme.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),

                // Description
                Text(
                  _isBlocked
                      ? 'Too many invalid PIN attempts. This transaction has been cancelled for your security.'
                      : 'Please enter your 4-digit transaction PIN to authorize this payment.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // PIN Input Fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return _PINDigitField(
                      focusNode: _pinFocusNodes[index],
                      value: _currentPIN.length > index ? _currentPIN[index] : '',
                      isLoading: _isLoading && index == _currentPIN.length - 1,
                      onChanged: (value) {
                        if (value.isEmpty) return;
                        _onPINDigitChanged(_currentPIN + value);
                      },
                    );
                  }),
                ),
                const SizedBox(height: 24),

                // Error Message
                if (_errorMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _isBlocked
                          ? theme.colorScheme.errorContainer
                          : theme.colorScheme.errorContainer.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _isBlocked ? Icons.block : Icons.error_outline,
                          color: _isBlocked
                              ? theme.colorScheme.error
                              : theme.colorScheme.error,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _errorMessage!,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: _isBlocked
                                  ? theme.colorScheme.error
                                  : theme.colorScheme.error,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Retries Remaining
                if (!_isBlocked && _retriesRemaining < 3)
                  Text(
                    '$_retriesRemaining attempts remaining',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),

                const SizedBox(height: 24),

                // Cancel Button
                OutlinedButton.icon(
                  onPressed: _isLoading || _isBlocked ? null : _cancel,
                  icon: const Icon(Icons.cancel_outlined),
                  label: const Text('Cancel Transaction'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),

                // Loading Indicator
                if (_isLoading) ...[
                  const SizedBox(height: 24),
                  const Center(
                    child: Column(
                      children: [
                        LazerVaultLoader.small(),
                        SizedBox(height: 12),
                        Text('Validating PIN...'),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
