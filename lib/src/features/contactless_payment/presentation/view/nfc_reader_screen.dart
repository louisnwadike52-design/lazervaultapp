import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nfc_manager/nfc_manager.dart';
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

class _NfcReaderViewState extends State<_NfcReaderView>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _isNfcAvailable = false;
  bool _isNfcSessionStarted = false;
  bool _isProcessing = false;
  String? _errorMessage;

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
    final isAvailable = await NfcManager.instance.isAvailable();
    setState(() => _isNfcAvailable = isAvailable);

    if (isAvailable) {
      _startNfcSession();
    }
  }

  Future<void> _startNfcSession() async {
    if (_isNfcSessionStarted) return;

    setState(() {
      _isNfcSessionStarted = true;
      _errorMessage = null;
    });

    await NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        // Read NDEF data from the tag
        final ndef = Ndef.from(tag);
        if (ndef == null) {
          setState(() => _errorMessage = 'Unable to read payment data');
          return;
        }

        final cachedMessage = ndef.cachedMessage;
        if (cachedMessage == null || cachedMessage.records.isEmpty) {
          setState(() => _errorMessage = 'No payment data found');
          return;
        }

        // Parse the payment payload
        for (final record in cachedMessage.records) {
          if (record.typeNameFormat == NdefTypeNameFormat.nfcWellknown) {
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

        setState(() => _errorMessage = 'Invalid payment data');
      },
      onError: (error) async {
        setState(() => _errorMessage = 'NFC Error: $error');
      },
    );
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
      _isProcessing = false;
    });
    _startNfcSession();
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
        } else if (state is ContactlessPaymentError) {
          setState(() {
            _isProcessing = false;
            _errorMessage = state.message;
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
                if (!_isNfcAvailable) ...[
                  Icon(
                    Icons.warning_amber,
                    color: colorScheme.error,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'NFC Not Available',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your device does not support NFC or it is disabled',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ] else if (_errorMessage != null) ...[
                  Text(
                    'Error',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _errorMessage!,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
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
