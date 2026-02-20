import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/src/features/cards/presentation/cubit/card_cubit.dart';
import 'package:lazervault/src/features/cards/presentation/cubit/card_state.dart';

class CardPinSetupScreen extends StatefulWidget {
  const CardPinSetupScreen({super.key});

  @override
  State<CardPinSetupScreen> createState() => _CardPinSetupScreenState();
}

class _CardPinSetupScreenState extends State<CardPinSetupScreen> {
  late String _cardUuid;
  String _pin = '';
  String _confirmPin = '';
  bool _isConfirmStep = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _cardUuid = Get.arguments as String? ?? '';
  }

  void _onDigitPressed(int digit) {
    setState(() {
      _error = null;
      if (!_isConfirmStep) {
        if (_pin.length < 4) {
          _pin += digit.toString();
          if (_pin.length == 4) {
            _isConfirmStep = true;
          }
        }
      } else {
        if (_confirmPin.length < 4) {
          _confirmPin += digit.toString();
          if (_confirmPin.length == 4) {
            _validateAndSubmit();
          }
        }
      }
    });
  }

  void _onBackspace() {
    setState(() {
      _error = null;
      if (!_isConfirmStep) {
        if (_pin.isNotEmpty) {
          _pin = _pin.substring(0, _pin.length - 1);
        }
      } else {
        if (_confirmPin.isNotEmpty) {
          _confirmPin = _confirmPin.substring(0, _confirmPin.length - 1);
        }
      }
    });
  }

  void _validateAndSubmit() {
    if (_pin != _confirmPin) {
      setState(() {
        _error = 'PINs do not match. Please try again.';
        _confirmPin = '';
        _isConfirmStep = false;
        _pin = '';
      });
      return;
    }

    context.read<CardCubit>().setCardPIN(
      cardUuid: _cardUuid,
      pin: _pin,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CardCubit, CardState>(
      listener: (context, state) {
        if (state is CardActionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFF10B981),
            ),
          );
          Get.back(result: true);
        } else if (state is CardError) {
          setState(() {
            _error = state.message;
            _pin = '';
            _confirmPin = '';
            _isConfirmStep = false;
          });
        }
      },
      builder: (context, state) {
        final currentPin = _isConfirmStep ? _confirmPin : _pin;
        final isLoading = state is CardLoading;

        return Scaffold(
          backgroundColor: const Color(0xFF0A0A0A),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            title: const Text('Set Card PIN', style: TextStyle(color: Colors.white)),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Column(
              children: [
                const Spacer(),
                // Title
                Text(
                  _isConfirmStep ? 'Confirm your PIN' : 'Enter a 4-digit PIN',
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  _isConfirmStep
                      ? 'Re-enter your PIN to confirm'
                      : 'This PIN will be used for card transactions',
                  style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                ),
                const SizedBox(height: 32),
                // PIN dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    final isFilled = index < currentPin.length;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isFilled ? const Color(0xFF3B82F6) : Colors.transparent,
                        border: Border.all(
                          color: isFilled ? const Color(0xFF3B82F6) : const Color(0xFF9CA3AF),
                          width: 2,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 16),
                // Error message
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      _error!,
                      style: const TextStyle(color: Color(0xFFEF4444), fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                if (isLoading)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
                  ),
                const Spacer(),
                // Number pad
                _buildNumberPad(isLoading),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNumberPad(bool isLoading) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        children: [
          for (int row = 0; row < 4; row++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (row < 3)
                    for (int col = 0; col < 3; col++)
                      _buildKey(
                        label: '${row * 3 + col + 1}',
                        onTap: isLoading ? null : () => _onDigitPressed(row * 3 + col + 1),
                      ),
                  if (row == 3) ...[
                    const SizedBox(width: 72, height: 56),
                    _buildKey(
                      label: '0',
                      onTap: isLoading ? null : () => _onDigitPressed(0),
                    ),
                    _buildKey(
                      icon: Icons.backspace_outlined,
                      onTap: isLoading ? null : _onBackspace,
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildKey({String? label, IconData? icon, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12),
        ),
        child: icon != null
            ? Icon(icon, color: Colors.white, size: 24)
            : Text(
                label ?? '',
                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}
