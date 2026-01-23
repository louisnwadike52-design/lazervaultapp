import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nfc_manager/nfc_manager.dart';
import '../../domain/entities/contactless_payment_entity.dart';
import '../../domain/repositories/contactless_payment_repository.dart';
import '../cubit/contactless_payment_cubit.dart';
import '../cubit/contactless_payment_state.dart';
import 'payment_success_screen.dart';

class NfcBroadcastScreen extends StatelessWidget {
  final PaymentSessionEntity session;
  final String nfcPayload;

  const NfcBroadcastScreen({
    super.key,
    required this.session,
    required this.nfcPayload,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactlessPaymentCubit(
        repository: GetIt.instance<ContactlessPaymentRepository>(),
      ),
      child: _NfcBroadcastView(
        session: session,
        nfcPayload: nfcPayload,
      ),
    );
  }
}

class _NfcBroadcastView extends StatefulWidget {
  final PaymentSessionEntity session;
  final String nfcPayload;

  const _NfcBroadcastView({
    required this.session,
    required this.nfcPayload,
  });

  @override
  State<_NfcBroadcastView> createState() => _NfcBroadcastViewState();
}

class _NfcBroadcastViewState extends State<_NfcBroadcastView>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  Timer? _expiryTimer;
  Timer? _statusPollingTimer;
  Duration _remainingTime = Duration.zero;
  bool _isNfcAvailable = false;
  bool _isNfcSessionStarted = false;
  String _currentStatus = 'pending';
  String? _payerName;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _remainingTime = widget.session.expiresAt.difference(DateTime.now());
    _startExpiryTimer();
    _checkNfcAvailability();
    _startStatusPolling();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _expiryTimer?.cancel();
    _statusPollingTimer?.cancel();
    _stopNfcSession();
    super.dispose();
  }

  void _startExpiryTimer() {
    _expiryTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime = widget.session.expiresAt.difference(DateTime.now());
        if (_remainingTime.isNegative) {
          timer.cancel();
          _handleExpired();
        }
      });
    });
  }

  void _startStatusPolling() {
    _statusPollingTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      context.read<ContactlessPaymentCubit>().checkSessionStatus(widget.session.id);
    });
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

    setState(() => _isNfcSessionStarted = true);

    await NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        // When another device taps, write our payment data
        final ndef = Ndef.from(tag);
        if (ndef == null || !ndef.isWritable) {
          return;
        }

        // Create NDEF message with our payment payload
        final ndefMessage = NdefMessage([
          NdefRecord.createText(widget.nfcPayload),
        ]);

        try {
          await ndef.write(ndefMessage);
        } catch (e) {
          debugPrint('Error writing NFC: $e');
        }
      },
      onError: (error) async {
        debugPrint('NFC Error: $error');
      },
    );
  }

  void _stopNfcSession() {
    if (_isNfcSessionStarted) {
      NfcManager.instance.stopSession();
      _isNfcSessionStarted = false;
    }
  }

  void _handleExpired() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Payment session expired')),
    );
    Navigator.of(context).pop();
  }

  void _cancelSession() {
    context.read<ContactlessPaymentCubit>().cancelSession(widget.session.id);
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocListener<ContactlessPaymentCubit, ContactlessPaymentState>(
      listener: (context, state) {
        if (state is SessionCancelled) {
          Navigator.of(context).pop();
        } else if (state is SessionStatusChecked) {
          setState(() {
            _currentStatus = state.status;
            _payerName = state.payerName;
          });

          // If completed, navigate to success
          if (state.status == 'completed') {
            _statusPollingTimer?.cancel();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentSuccessScreen(
                  amount: widget.session.amount,
                  currency: widget.session.currency,
                  payerName: state.payerName ?? 'Unknown',
                  isReceiver: true,
                ),
              ),
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Waiting for Payment'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Timer
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: _remainingTime.inSeconds < 30
                        ? colorScheme.errorContainer
                        : colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Expires in ${_formatDuration(_remainingTime)}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _remainingTime.inSeconds < 30
                          ? colorScheme.onErrorContainer
                          : colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Amount display
                Text(
                  '${widget.session.currency} ${widget.session.amount.toStringAsFixed(2)}',
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
                if (widget.session.description != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    widget.session.description!,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
                const SizedBox(height: 48),

                // NFC Animation
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedBuilder(
                          animation: _pulseAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _pulseAnimation.value,
                              child: Container(
                                width: 180,
                                height: 180,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentStatus == 'read'
                                      ? Colors.green.withValues(alpha: 0.2)
                                      : colorScheme.primaryContainer.withValues(alpha: 0.5),
                                  border: Border.all(
                                    color: _currentStatus == 'read'
                                        ? Colors.green
                                        : colorScheme.primary,
                                    width: 3,
                                  ),
                                ),
                                child: Icon(
                                  _currentStatus == 'read'
                                      ? Icons.check_circle
                                      : Icons.contactless,
                                  size: 80,
                                  color: _currentStatus == 'read'
                                      ? Colors.green
                                      : colorScheme.primary,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 32),
                        if (!_isNfcAvailable) ...[
                          Icon(
                            Icons.warning_amber,
                            color: colorScheme.error,
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'NFC is not available on this device',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: colorScheme.error,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ] else if (_currentStatus == 'read') ...[
                          Text(
                            'Payment request read!',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          if (_payerName != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              '$_payerName is reviewing...',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ] else ...[
                          Text(
                            'Ready to receive',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Ask the payer to tap their phone',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                // Cancel button
                OutlinedButton.icon(
                  onPressed: _cancelSession,
                  icon: const Icon(Icons.close),
                  label: const Text('Cancel'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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
