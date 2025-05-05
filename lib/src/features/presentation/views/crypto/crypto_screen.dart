import 'package:flutter/material.dart';
import 'package:lazervault/src/features/widgets/crypto/crypto.dart';

class CryptoScreen extends StatefulWidget {
  const CryptoScreen({super.key});

  @override
  State<CryptoScreen> createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 7, 1, 17),
      body: SafeArea(child: Crypto()),
    );
  }
}
