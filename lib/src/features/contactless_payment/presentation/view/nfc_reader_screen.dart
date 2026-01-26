import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/ndef_record.dart';
import 'package:nfc_manager_ndef/nfc_manager_ndef.dart';
import '../../domain/repositories/contactless_payment_repository.dart';
import '../cubit/contactless_payment_cubit.dart';
import '../cubit/contactless_payment_state.dart';
import 'payment_confirmation_screen.dart';

class NfcReaderScreen extends StatelessWidget {
  const NfcReaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactlessPaymentCubit(
        repository: GetIt.instance<ContactlessPaymentRepository>(),
      ),
      child: const _NfcReaderView(),
    );
  }
}

class _NfcReaderView extends StatefulWidget {
  const _NfcReaderView();

  @override
  State<_NfcReaderView> createState() => _NfcReaderViewState();
}

enum NfcErrorType {
  notSupported,
  disabled,
  sessionFailed,
  readError,
  invalidData,
}

class _NfcReaderViewState extends State<_NfcReaderView>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _isNfcAvailable = false;
  bool _isNfcSupported = true;
  bool _isNfcSessionStarted = false;
  bool _isProcessing = false;
  String? _errorMessage;
  NfcErrorType? _errorType;
  int _retryCount = 0;
  static const int _maxRetries = 3;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _checkNfcAvailability();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _stopNfcSession();
    super.dispose();
  }

  Future<void> _checkNfcAvailability() async {
    try {
      final availability = await NfcManager.instance.checkAvailability();

      switch (availability) {
        case NfcAvailability.enabled:
          setState(() {
            _isNfcAvailable = true;
            _isNfcSupported = true;
          });
          _startNfcSession();
          break;

        case NfcAvailability.disabled:
          setState(() {
            _isNfcAvailable = false;
            _isNfcSupported = true;
            _errorType = NfcErrorType.disabled;
            _errorMessage = 'NFC is disabled. Please enable it in your device settings.';
          });
          break;

        case NfcAvailability.unsupported:
          setState(() {
            _isNfcAvailable = false;
            _isNfcSupported = false;
            _errorType = NfcErrorType.notSupported;
            _errorMessage = 'NFC is not supported on this device';
          });
          break;
      }
    } catch (e) {
      setState(() {
        _isNfcAvailable = false;
        _isNfcSupported = false;
        _errorType = NfcErrorType.notSupported;
        _errorMessage = 'NFC is not available on this device';
      });
    }
  }

  Future<void> _openNfcSettings() async {
    try {
      if (Platform.isAndroid) {
        // Use method channel to open Android NFC settings
        const platform = MethodChannel('com.lazervault.app/settings');
        try {
          await platform.invokeMethod('openNfcSettings');
        } catch (e) {
          // Fallback: Open general settings
          try {
            await platform.invokeMethod('openSettings');
          } catch (_) {
            _showSettingsInstructionDialog();
          }
        }
      } else if (Platform.isIOS) {
        // iOS doesn't allow direct NFC settings access, show instructions
        _showSettingsInstructionDialog();
      }
    } catch (e) {
      debugPrint('Failed to open NFC settings: $e');
      _showSettingsInstructionDialog();
    }
  }

  void _showSettingsInstructionDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enable NFC'),
        content: Text(
          Platform.isAndroid
              ? 'To enable NFC:\n\n1. Open your phone Settings\n2. Go to "Connected devices" or "Connections"\n3. Turn on NFC'
              : 'To enable NFC on iPhone:\n\n1. Go to Settings > Control Center\n2. Add NFC Tag Reader\n3. Use Control Center to scan NFC tags',
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

  Future<void> _startNfcSession() async {
    if (_isNfcSessionStarted) return;

    setState(() {
      _isNfcSessionStarted = true;
      _errorMessage = null;
      _errorType = null;
    });

    try {
      await NfcManager.instance.startSession(
        pollingOptions: {
          NfcPollingOption.iso14443,
          NfcPollingOption.iso15693,
        },
        onDiscovered: (NfcTag tag) async {
          try {
            // Read NDEF data from the tag
            final ndef = Ndef.from(tag);
            if (ndef == null) {
              setState(() {
                _errorMessage = 'Unable to read payment data from this device. Make sure NFC is properly positioned.';
                _errorType = NfcErrorType.readError;
              });
              return;
            }

            final cachedMessage = ndef.cachedMessage;
            if (cachedMessage == null || cachedMessage.records.isEmpty) {
              setState(() {
                _errorMessage = 'No payment data found. Please ensure the other device is displaying a payment request.';
                _errorType = NfcErrorType.invalidData;
              });
              return;
            }

            // Parse the payment payload
            for (final record in cachedMessage.records) {
              if (record.typeNameFormat == TypeNameFormat.wellKnown) {
                final payload = String.fromCharCodes(record.payload.skip(3));

                try {
                  // Try to parse as our payment payload
                  final data = jsonDecode(payload);
                  if (data['type'] == 'lazervault_contactless_payment') {
                    setState(() => _isProcessing = true);
                    _stopNfcSession();

                    // Get the full session details
                    if (mounted) {
                      context.read<ContactlessPaymentCubit>()
                          .getPaymentSession(data['session_id']);
                    }
                    return;
                  }
                } catch (e) {
                  // Not our payment format, continue checking
                }
              }
            }

            setState(() {
              _errorMessage = 'Invalid payment format. This doesn\'t appear to be a LazerVault payment request.';
              _errorType = NfcErrorType.invalidData;
            });
          } catch (e) {
            _handleNfcError(e);
          }
        },
      );
    } catch (e) {
      _handleNfcSessionError(e);
    }
  }

  void _handleNfcError(dynamic error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('cancelled') || errorString.contains('canceled')) {
      // User cancelled - not really an error
      return;
    }

    setState(() {
      if (errorString.contains('timeout')) {
        _errorMessage = 'NFC read timed out. Please try again.';
        _errorType = NfcErrorType.readError;
      } else if (errorString.contains('tag lost') || errorString.contains('connection')) {
        _errorMessage = 'Connection lost. Hold phones together steadily.';
        _errorType = NfcErrorType.readError;
      } else {
        _errorMessage = 'NFC Error: Please try again';
        _errorType = NfcErrorType.readError;
      }
    });
  }

  void _handleNfcSessionError(dynamic error) {
    setState(() {
      _isNfcSessionStarted = false;
      _errorMessage = 'Failed to start NFC session. Please try again.';
      _errorType = NfcErrorType.sessionFailed;
    });

    // Auto-retry for session start failures
    if (_retryCount < _maxRetries) {
      _retryCount++;
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted && !_isNfcSessionStarted) {
          _startNfcSession();
        }
      });
    }
  }

  void _stopNfcSession() {
    if (_isNfcSessionStarted) {
      NfcManager.instance.stopSession();
      _isNfcSessionStarted = false;
    }
  }

  void _retry() {
    setState(() {
      _errorMessage = null;
      _errorType = null;
      _isProcessing = false;
      _retryCount = 0;
    });
    _checkNfcAvailability();
  }

  void _refreshNfcStatus() {
    _stopNfcSession();
    setState(() {
      _errorMessage = null;
      _errorType = null;
      _retryCount = 0;
    });
    _checkNfcAvailability();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocListener<ContactlessPaymentCubit, ContactlessPaymentState>(
      listener: (context, state) {
        if (state is PaymentSessionLoaded) {
          // Navigate to confirmation screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentConfirmationScreen(
                session: state.session,
              ),
            ),
          );
        } else if (state is SessionExpired) {
          setState(() {
            _isProcessing = false;
            _errorMessage = state.message;
            _errorType = NfcErrorType.invalidData;
          });
        } else if (state is ContactlessPaymentError) {
          setState(() {
            _isProcessing = false;
            _errorMessage = state.message;
            _errorType = state.retryable ? NfcErrorType.sessionFailed : NfcErrorType.invalidData;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tap to Pay'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Spacer(),

                // NFC Animation
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _isProcessing ? 1.0 : _pulseAnimation.value,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _errorMessage != null
                              ? colorScheme.errorContainer.withValues(alpha: 0.5)
                              : _isProcessing
                                  ? Colors.green.withValues(alpha: 0.2)
                                  : colorScheme.primaryContainer.withValues(alpha: 0.5),
                          border: Border.all(
                            color: _errorMessage != null
                                ? colorScheme.error
                                : _isProcessing
                                    ? Colors.green
                                    : colorScheme.primary,
                            width: 3,
                          ),
                        ),
                        child: _isProcessing
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Icon(
                                _errorMessage != null
                                    ? Icons.error_outline
                                    : Icons.nfc,
                                size: 80,
                                color: _errorMessage != null
                                    ? colorScheme.error
                                    : colorScheme.primary,
                              ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),

                // Status text
                if (!_isNfcAvailable && !_isNfcSupported) ...[
                  // NFC not supported on device
                  Icon(
                    Icons.phonelink_erase,
                    color: colorScheme.error,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'NFC Not Supported',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your device does not support NFC contactless payments.\n\nPlease use a device with NFC capability.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ] else if (!_isNfcAvailable && _isNfcSupported) ...[
                  // NFC disabled but supported
                  Icon(
                    Icons.nfc_rounded,
                    color: colorScheme.tertiary,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'NFC is Disabled',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.tertiary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please enable NFC in your device settings to use contactless payments.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton.icon(
                        onPressed: _openNfcSettings,
                        icon: const Icon(Icons.settings),
                        label: const Text('Open Settings'),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton.icon(
                        onPressed: _refreshNfcStatus,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Refresh'),
                      ),
                    ],
                  ),
                ] else if (_errorMessage != null) ...[
                  Text(
                    _errorType == NfcErrorType.invalidData ? 'Invalid Data' : 'Error',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      _errorMessage!,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: _retry,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Try Again'),
                  ),
                ] else if (_isProcessing) ...[
                  Text(
                    'Processing...',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Loading payment details',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ] else ...[
                  Text(
                    'Ready to Scan',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Hold your phone near the receiver\'s device',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],

                const Spacer(),

                // Instructions
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'How to pay:',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _InstructionRow(
                        number: '1',
                        text: 'Ask the receiver to show their payment request',
                      ),
                      _InstructionRow(
                        number: '2',
                        text: 'Hold your phones close together, back to back',
                      ),
                      _InstructionRow(
                        number: '3',
                        text: 'Confirm the payment amount and enter your PIN',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InstructionRow extends StatelessWidget {
  final String number;
  final String text;

  const _InstructionRow({
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
