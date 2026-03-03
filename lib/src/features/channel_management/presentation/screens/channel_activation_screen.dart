import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import '../../cubit/channel_management_cubit.dart';
import '../../cubit/channel_management_state.dart';
import 'channel_pin_setup_screen.dart';

class ChannelActivationScreen extends StatefulWidget {
  final String channelType;

  const ChannelActivationScreen({super.key, required this.channelType});

  @override
  State<ChannelActivationScreen> createState() =>
      _ChannelActivationScreenState();
}

class _ChannelActivationScreenState extends State<ChannelActivationScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _otpSent = false;
  String _maskedPhone = '';

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
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
            'Activate $_channelDisplayName Banking',
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<ChannelManagementCubit, ChannelManagementState>(
          listener: (context, state) {
            if (state is ChannelOtpSent) {
              setState(() {
                _otpSent = true;
                _maskedPhone = state.maskedPhone;
              });
            } else if (state is ChannelActivated) {
              Get.snackbar(
                'Channel Activated',
                '$_channelDisplayName banking is now active!',
                backgroundColor: const Color(0xFF10B981),
                colorText: Colors.white,
              );
              // Navigate to PIN setup
              Get.off(() => ChannelPinSetupScreen(
                    channelType: widget.channelType,
                    isChange: false,
                  ));
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
                    _otpSent
                        ? 'Enter Verification Code'
                        : 'Enter Your Phone Number',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _otpSent
                        ? 'We sent a 6-digit code to $_maskedPhone'
                        : 'We\'ll send a verification code to activate $_channelDisplayName banking.',
                    style: const TextStyle(
                        color: Color(0xFF9CA3AF), fontSize: 14),
                  ),
                  const SizedBox(height: 32),
                  if (!_otpSent) ...[
                    TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: '+234 800 000 0000',
                        hintStyle:
                            const TextStyle(color: Color(0xFF9CA3AF)),
                        prefixIcon: const Icon(Icons.phone,
                            color: Color(0xFF9CA3AF)),
                        filled: true,
                        fillColor: const Color(0xFF1F1F1F),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Color(0xFF3B82F6)),
                        ),
                      ),
                    ),
                  ] else ...[
                    TextField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          letterSpacing: 8),
                      decoration: InputDecoration(
                        hintText: '000000',
                        hintStyle: const TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 24,
                            letterSpacing: 8),
                        counterText: '',
                        filled: true,
                        fillColor: const Color(0xFF1F1F1F),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Color(0xFF3B82F6)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              context
                                  .read<ChannelManagementCubit>()
                                  .registerChannel(
                                    channelType: widget.channelType,
                                    phoneNumber: _phoneController.text.trim(),
                                  );
                            },
                      child: const Text(
                        'Resend Code',
                        style: TextStyle(color: Color(0xFF3B82F6)),
                      ),
                    ),
                  ],
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : () => _onSubmit(context),
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
                              _otpSent ? 'Verify' : 'Send Verification Code',
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

  void _onSubmit(BuildContext context) {
    if (!_otpSent) {
      final phone = _phoneController.text.trim();
      if (phone.isEmpty) {
        Get.snackbar('Error', 'Please enter your phone number',
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white);
        return;
      }
      context.read<ChannelManagementCubit>().registerChannel(
            channelType: widget.channelType,
            phoneNumber: phone,
          );
    } else {
      final otp = _otpController.text.trim();
      if (otp.length != 6) {
        Get.snackbar('Error', 'Please enter the 6-digit code',
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white);
        return;
      }
      context.read<ChannelManagementCubit>().verifyOTP(
            channelType: widget.channelType,
            otpCode: otp,
          );
    }
  }
}
