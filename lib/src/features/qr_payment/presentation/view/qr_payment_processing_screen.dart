import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/qr_payment/presentation/cubit/qr_payment_cubit.dart';
import 'package:lazervault/src/features/qr_payment/presentation/cubit/qr_payment_state.dart';

class QRPaymentProcessingScreen extends StatefulWidget {
  const QRPaymentProcessingScreen({super.key});

  @override
  State<QRPaymentProcessingScreen> createState() =>
      _QRPaymentProcessingScreenState();
}

class _QRPaymentProcessingScreenState extends State<QRPaymentProcessingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QRPaymentCubit, QRPaymentState>(
      listener: (context, state) {
        if (state is QRPaymentSuccess) {
          Get.offNamed(
            AppRoutes.qrPaymentReceipt,
            arguments: {
              'transaction': state.transaction,
              'newBalance': state.newBalance,
            },
          );
        } else if (state is QRPaymentError) {
          Get.back();
          Get.snackbar(
            'Payment Failed',
            state.message,
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white,
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _pulseAnimation,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.qr_code_scanner,
                    color: Color(0xFF3B82F6),
                    size: 64,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Processing Payment',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Please wait while we process your QR payment...',
                style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              const SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                  color: Color(0xFF3B82F6),
                  strokeWidth: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
