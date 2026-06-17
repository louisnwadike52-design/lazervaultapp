import 'package:flutter/material.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class LoadingColumn extends StatelessWidget {
  const LoadingColumn({required this.message, super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LazerVaultLoader.small(),
          const SizedBox(height: 10),
          Text("$message...")
        ],
      ),
    );
  }
}
