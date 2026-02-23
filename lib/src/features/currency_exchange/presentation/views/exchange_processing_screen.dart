import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../cubit/exchange_cubit.dart';
import '../cubit/exchange_state.dart';

class ExchangeProcessingScreen extends StatefulWidget {
  const ExchangeProcessingScreen({super.key});

  @override
  State<ExchangeProcessingScreen> createState() => _ExchangeProcessingScreenState();
}

class _ExchangeProcessingScreenState extends State<ExchangeProcessingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _pulseAnimation;
  String _transactionId = '';
  bool _isConversion = true;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );

    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      _transactionId = args['transactionId'] as String? ?? '';
      _isConversion = args['isConversion'] as bool? ?? true;
    }

    if (_transactionId.isNotEmpty) {
      context.read<ExchangeCubit>().pollTransactionStatus(_transactionId);
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: BlocListener<ExchangeCubit, ExchangeState>(
        listener: (context, state) {
          if (state is ExchangeSuccess) {
            Get.offNamed(
              AppRoutes.exchangeReceipt,
              arguments: state.transaction,
            );
          } else if (state is ExchangeError) {
            Get.offNamed(AppRoutes.exchangeHome);
            Get.snackbar(
              'Exchange Update',
              state.message,
              backgroundColor: const Color(0xFF1F1F1F),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
          }
        },
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _pulseAnimation.value,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(
                            Icons.swap_horiz,
                            color: Color(0xFF3B82F6),
                            size: 48,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  Text(
                    _isConversion ? 'Converting...' : 'Processing Transfer...',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _isConversion
                        ? 'Your currency conversion is being processed'
                        : 'Your international transfer is being processed',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const CircularProgressIndicator(
                    color: Color(0xFF3B82F6),
                    strokeWidth: 2,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'This may take a few moments...',
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
