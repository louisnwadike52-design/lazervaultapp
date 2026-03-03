import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../cubit/channel_management_cubit.dart';
import '../../cubit/channel_management_state.dart';

class ChannelPinSetupScreen extends StatefulWidget {
  final String channelType;
  final bool isChange;

  const ChannelPinSetupScreen({
    super.key,
    required this.channelType,
    this.isChange = false,
  });

  @override
  State<ChannelPinSetupScreen> createState() => _ChannelPinSetupScreenState();
}

class _ChannelPinSetupScreenState extends State<ChannelPinSetupScreen> {
  final _currentPinController = TextEditingController();
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();

  int _step = 0; // 0=current pin (change only), 1=new pin, 2=confirm pin

  @override
  void initState() {
    super.initState();
    _step = widget.isChange ? 0 : 1;
  }

  @override
  void dispose() {
    _currentPinController.dispose();
    _pinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  String get _channelDisplayName {
    switch (widget.channelType) {
      case 'whatsapp':
        return 'WhatsApp';
      case 'telephony':
        return 'Phone & SMS';
      default:
        return widget.channelType;
    }
  }

  String get _stepTitle {
    if (_step == 0) return 'Enter Current PIN';
    if (_step == 1) return widget.isChange ? 'Enter New PIN' : 'Create Your PIN';
    return 'Confirm Your PIN';
  }

  String get _stepSubtitle {
    if (_step == 0) {
      return 'Enter your current $_channelDisplayName banking PIN to continue.';
    }
    if (_step == 1) {
      return widget.isChange
          ? 'Enter a new 4-digit PIN for $_channelDisplayName banking.'
          : 'Create a 4-digit PIN for $_channelDisplayName banking. This PIN will be used to authorize transactions.';
    }
    return 'Re-enter your PIN to confirm.';
  }

  TextEditingController get _activeController {
    if (_step == 0) return _currentPinController;
    if (_step == 1) return _pinController;
    return _confirmPinController;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<ChannelManagementCubit>(),
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: Text(
            '${widget.isChange ? "Change" : "Set"} $_channelDisplayName PIN',
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<ChannelManagementCubit, ChannelManagementState>(
          listener: (context, state) {
            if (state is ChannelPinCreated) {
              Get.snackbar(
                'PIN Created',
                '$_channelDisplayName banking PIN has been set up successfully!',
                backgroundColor: const Color(0xFF10B981),
                colorText: Colors.white,
              );
              Get.offAllNamed(AppRoutes.dashboard);
            } else if (state is ChannelPinChanged) {
              Get.snackbar(
                'PIN Changed',
                '$_channelDisplayName banking PIN has been changed successfully!',
                backgroundColor: const Color(0xFF10B981),
                colorText: Colors.white,
              );
              Get.back();
            } else if (state is ChannelManagementError) {
              Get.snackbar(
                'Error',
                state.message,
                backgroundColor: const Color(0xFFEF4444),
                colorText: Colors.white,
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is ChannelManagementLoading;

            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _stepTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _stepSubtitle,
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (widget.isChange) _buildStepIndicator(),
                  const SizedBox(height: 24),
                  _buildPinInput(_activeController),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : () => _onNext(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                        disabledBackgroundColor:
                            const Color(0xFF3B82F6).withValues(alpha: 0.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2),
                            )
                          : Text(
                              _step == 2 ||
                                      (!widget.isChange && _step == 1)
                                  ? 'Confirm'
                                  : 'Next',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      children: List.generate(3, (index) {
        final isActive = index <= _step;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: index < 2 ? 8 : 0),
            height: 4,
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFF3B82F6)
                  : const Color(0xFF2D2D2D),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPinInput(TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      maxLength: 4,
      obscureText: true,
      textAlign: TextAlign.center,
      autofocus: true,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 32,
        letterSpacing: 16,
      ),
      decoration: InputDecoration(
        hintText: '••••',
        hintStyle: const TextStyle(
          color: Color(0xFF9CA3AF),
          fontSize: 32,
          letterSpacing: 16,
        ),
        counterText: '',
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3B82F6)),
        ),
      ),
    );
  }

  void _onNext(BuildContext context) {
    final pin = _activeController.text.trim();
    if (pin.length != 4) {
      Get.snackbar(
        'Error',
        'Please enter a 4-digit PIN',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
      );
      return;
    }

    if (widget.isChange) {
      _handleChangeFlow(context, pin);
    } else {
      _handleCreateFlow(context, pin);
    }
  }

  void _handleCreateFlow(BuildContext context, String pin) {
    if (_step == 1) {
      // Move to confirm step
      setState(() => _step = 2);
    } else if (_step == 2) {
      final newPin = _pinController.text.trim();
      final confirmPin = _confirmPinController.text.trim();
      if (newPin != confirmPin) {
        Get.snackbar(
          'Error',
          'PINs do not match. Please try again.',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
        );
        _confirmPinController.clear();
        return;
      }
      context.read<ChannelManagementCubit>().createPin(
            channelType: widget.channelType,
            pin: newPin,
            confirmPin: confirmPin,
          );
    }
  }

  void _handleChangeFlow(BuildContext context, String pin) {
    if (_step == 0) {
      // Move to new PIN step
      setState(() => _step = 1);
    } else if (_step == 1) {
      // Move to confirm step
      setState(() => _step = 2);
    } else if (_step == 2) {
      final currentPin = _currentPinController.text.trim();
      final newPin = _pinController.text.trim();
      final confirmPin = _confirmPinController.text.trim();
      if (newPin != confirmPin) {
        Get.snackbar(
          'Error',
          'PINs do not match. Please try again.',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
        );
        _confirmPinController.clear();
        return;
      }
      context.read<ChannelManagementCubit>().changePin(
            channelType: widget.channelType,
            currentPin: currentPin,
            newPin: newPin,
            confirmNewPin: confirmPin,
          );
    }
  }
}
