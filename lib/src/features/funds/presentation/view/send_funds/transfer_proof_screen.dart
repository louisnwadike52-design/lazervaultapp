import 'package:flutter/material.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/transfer_proof.dart';

class TransferProofScreen extends StatelessWidget {
  final Map<String, dynamic> transferDetails;
  const TransferProofScreen({super.key, required this.transferDetails});

  @override
  Widget build(BuildContext context) {
    return TransferProof(transferDetails: transferDetails);
  }
}
