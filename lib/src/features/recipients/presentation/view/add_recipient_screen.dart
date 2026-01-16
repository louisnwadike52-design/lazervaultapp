import 'package:flutter/material.dart';
// Import for SystemUiOverlayStyle
// Add import for serviceLocator
// Add import for RecipientCubit
import 'package:lazervault/src/features/recipients/presentation/widgets/add_recipient.dart';

class AddRecipientScreen extends StatefulWidget {
  const AddRecipientScreen({super.key});

  @override
  State<AddRecipientScreen> createState() => _AddRecipientScreenState();
}

class _AddRecipientScreenState extends State<AddRecipientScreen> {
  @override
  Widget build(BuildContext context) {
    return const AddRecipient();
  }
}
