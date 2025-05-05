import 'package:flutter/material.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/widgets/input_pin.dart';

class InputPinScreen extends StatefulWidget {
  final User recipient;
  const InputPinScreen({super.key, required this.recipient});

  @override
  State<InputPinScreen> createState() => _InputPinScreenState();
}

class _InputPinScreenState extends State<InputPinScreen> {


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child:InputPin(recipient: widget.recipient),
      ),
    );
  }
}
