import 'package:flutter/material.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/transfer_proof.dart';

class TransferProofScreen extends StatefulWidget {
  final Map<String, dynamic> transferDetails;
  const TransferProofScreen({super.key, required this.transferDetails});

  @override
  State<TransferProofScreen> createState() => _TransferProofScreenState();
}

class _TransferProofScreenState extends State<TransferProofScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: 0.2),
        body: TransferProof(transferDetails: widget.transferDetails),
    );  
  }
}   