import 'package:flutter/material.dart';

class CBCurrencyExchangeScreen extends StatefulWidget {
  const CBCurrencyExchangeScreen({super.key});

  @override
  State<CBCurrencyExchangeScreen> createState() =>
      _CBCurrencyExchangeScreenState();
}

class _CBCurrencyExchangeScreenState extends State<CBCurrencyExchangeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('CBCurrencyExchangeScreen'),
        ],
      ),
    );
  }
}
