import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../cubit/crypto_cubit.dart';
import '../../cubit/crypto_state.dart';
import '../models/crypto_transaction_models.dart';
import 'crypto_receipt_screen.dart';

/// Processing screen shown during crypto transaction execution.
/// Displays animated progress and handles success/error states.
class CryptoProcessingScreen extends StatefulWidget {
  final CryptoTransactionType transactionType;
  final String cryptoName;
  final String cryptoSymbol;
  final String cryptoAmount;
  final double fiatAmount;
  final double price;
  final String cryptoId;
  final double cryptoQuantity;
  final String transactionPin;
  final String paymentMethod;

  const CryptoProcessingScreen({
    super.key,
    required this.transactionType,
    required this.cryptoName,
    required this.cryptoSymbol,
    required this.cryptoAmount,
    required this.fiatAmount,
    required this.price,
    required this.cryptoId,
    required this.cryptoQuantity,
    required this.transactionPin,
    this.paymentMethod = 'LazerVault Wallet',
  });

  @override
  State<CryptoProcessingScreen> createState() => _CryptoProcessingScreenState();
}

class _CryptoProcessingScreenState extends State<CryptoProcessingScreen>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;

  ProcessingState _state = ProcessingState.initial;
  String? _errorMessage;
  String? _transactionId;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _executeTransaction();
  }

  void _setupAnimations() {
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );

    _rotationController.repeat();
  }

  Future<void> _executeTransaction() async {
    final cubit = context.read<CryptoCubit>();

    try {
      // Execute transaction based on type
      switch (widget.transactionType) {
        case CryptoTransactionType.buy:
          await cubit.buyCrypto(
            cryptoId: widget.cryptoId,
            quantity: widget.cryptoQuantity,
            price: widget.price,
            transactionPin: widget.transactionPin,
          );
          break;
        case CryptoTransactionType.sell:
          await cubit.sellCrypto(
            cryptoId: widget.cryptoId,
            quantity: widget.cryptoQuantity,
            price: widget.price,
            transactionPin: widget.transactionPin,
          );
          break;
        case CryptoTransactionType.swap:
          // Swap not implemented in buy/sell flow
          break;
      }

      // Check result
      final state = cubit.state;
      if (mounted) {
        if (state is CryptoTransactionSuccess) {
          setState(() {
            _state = ProcessingState.success;
            _transactionId = state.transaction.id;
          });
          _rotationController.stop();
          // Navigate to receipt after brief delay
          await Future.delayed(const Duration(milliseconds: 1500));
          if (mounted) _navigateToReceipt();
        } else if (state is CryptoError) {
          setState(() {
            _state = ProcessingState.error;
            _errorMessage = state.message;
          });
          _rotationController.stop();
        } else {
          // Unexpected state
          setState(() {
            _state = ProcessingState.error;
            _errorMessage = 'Transaction could not be completed. Please try again.';
          });
          _rotationController.stop();
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _state = ProcessingState.error;
          _errorMessage = e.toString().replaceAll('Exception: ', '');
        });
        _rotationController.stop();
      }
    }
  }

  void _navigateToReceipt() {
    if (_transactionId == null) return;

    final fee = widget.fiatAmount * 0.015;
    final networkFee = fee * 0.3;
    final tradingFee = fee * 0.7;
    final total = widget.fiatAmount + fee;

    final transactionDetails = CryptoTransactionDetails(
      type: widget.transactionType,
      cryptoName: widget.cryptoName,
      cryptoSymbol: widget.cryptoSymbol,
      cryptoAmount: widget.cryptoAmount,
      pricePerUnit: widget.price,
      fiatAmount: widget.fiatAmount,
      networkFee: networkFee,
      tradingFee: tradingFee,
      totalAmount: widget.transactionType == CryptoTransactionType.buy ? total : widget.fiatAmount - fee,
      paymentMethod: widget.paymentMethod,
      cryptoId: widget.cryptoId,
      cryptoQuantity: widget.cryptoQuantity,
    );

    final receipt = CryptoTransactionReceipt(
      transactionId: _transactionId!,
      transactionDetails: transactionDetails,
      timestamp: DateTime.now(),
      status: CryptoTransactionStatus.completed,
    );

    Get.off(() => CryptoReceiptScreen(receipt: receipt));
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 28.sp),
            SizedBox(width: 12.w),
            Text(
              'Transaction Failed',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: Text(
          _errorMessage ?? 'An unknown error occurred',
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 14.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 14.sp,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back(); // Close dialog
              Get.back(); // Go back to buy/sell screen
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 78, 3, 208),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Try Again',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Show error dialog when in error state
    if (_state == ProcessingState.error && _errorMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _showErrorDialog());
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1F1F1F), Color(0xFF0A0A0A)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: _state == ProcessingState.success
                ? _buildSuccessState()
                : _buildProcessingState(),
          ),
        ),
      ),
    );
  }

  Widget _buildProcessingState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _rotationAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationAnimation.value * 2 * 3.14159,
              child: Container(
                padding: EdgeInsets.all(40.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.sync,
                  size: 48.sp,
                  color: const Color.fromARGB(255, 78, 3, 208),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 40.h),
        Text(
          'Processing ${_getTransactionTitle()}',
          style: GoogleFonts.inter(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'Please do not close this screen',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
        SizedBox(height: 40.h),
        _buildProgressSteps(),
      ],
    );
  }

  Widget _buildProgressSteps() {
    return Container(
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.symmetric(horizontal: 32.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          _buildProgressStep('Verifying PIN', true),
          SizedBox(height: 12.h),
          _buildProgressStep('Fetching exchange rate', true),
          SizedBox(height: 12.h),
          _buildProgressStep('Executing ${_getTransactionTitle().toLowerCase()}', true),
          SizedBox(height: 12.h),
          _buildProgressStep('Confirming transaction', false),
        ],
      ),
    );
  }

  Widget _buildProgressStep(String text, bool isCompleted) {
    return Row(
      children: [
        Icon(
          isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isCompleted ? Colors.green : Colors.grey,
          size: 20.sp,
        ),
        SizedBox(width: 12.w),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(40.w),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_circle,
            size: 64.sp,
            color: Colors.green,
          ),
        ),
        SizedBox(height: 32.h),
        Text(
          '${_getTransactionTitle()} Successful!',
          style: GoogleFonts.inter(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'Your order has been executed',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  String _getTransactionTitle() {
    return switch (widget.transactionType) {
      CryptoTransactionType.buy => 'Purchase',
      CryptoTransactionType.sell => 'Sale',
      CryptoTransactionType.swap => 'Swap',
    };
  }
}

enum ProcessingState { initial, processing, success, error }
