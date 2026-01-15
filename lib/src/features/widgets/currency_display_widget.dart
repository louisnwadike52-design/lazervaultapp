import 'package:flutter/material.dart';
import 'package:lazervault/core/services/currency_sync_service.dart';
import 'package:lazervault/core/services/injection_container.dart';

/// Widget that displays currency and automatically updates when currency changes.
///
/// This widget subscribes to the currency stream and rebuilds whenever
/// the user's currency changes, ensuring the UI always shows the correct currency.
///
/// Usage:
/// ```dart
/// CurrencyDisplayWidget(
///   amount: 1234.56,
///   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
/// )
/// ```
class CurrencyDisplayWidget extends StatefulWidget {
  final double amount;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? decimalDigits;
  final String? currencySymbol;

  const CurrencyDisplayWidget({
    super.key,
    required this.amount,
    this.style,
    this.textAlign,
    this.decimalDigits = 2,
    this.currencySymbol,
  });

  @override
  State<CurrencyDisplayWidget> createState() => _CurrencyDisplayWidgetState();
}

class _CurrencyDisplayWidgetState extends State<CurrencyDisplayWidget> {
  final CurrencySyncService _currencySyncService = serviceLocator<CurrencySyncService>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: _currencySyncService.currencyStream,
      initialData: _currencySyncService.currentCurrency,
      builder: (context, snapshot) {
        final currency = snapshot.data ?? 'USD';
        final formattedAmount = _formatAmount(widget.amount, currency);

        return Text(
          formattedAmount,
          style: widget.style,
          textAlign: widget.textAlign,
        );
      },
    );
  }

  String _formatAmount(double amount, String currency) {
    // Get currency symbol from widget or use default
    final symbol = widget.currencySymbol ?? _getCurrencySymbol(currency);

    // Format amount with thousand separators
    final formattedAmount = amount.toStringAsFixed(widget.decimalDigits ?? 2);
    final parts = formattedAmount.split('.');
    final integerPart = _formatWithCommas(parts[0]);
    final decimalPart = parts.length > 1 ? parts[1] : '';

    return '$symbol$integerPart${decimalPart.isNotEmpty ? '.$decimalPart' : ''}';
  }

  String _formatWithCommas(String number) {
    final buffer = StringBuffer();
    final length = number.length;
    for (int i = 0; i < length; i++) {
      if (i > 0 && (length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(number[i]);
    }
    return buffer.toString();
  }

  String _getCurrencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'USD':
        return '\$';
      case 'GBP':
        return '£';
      case 'EUR':
        return '€';
      case 'JPY':
        return '¥';
      case 'CAD':
        return 'C\$';
      case 'AUD':
        return 'A\$';
      case 'CHF':
        return 'Fr';
      case 'CNY':
        return '¥';
      case 'INR':
        return '₹';
      case 'NGN':
        return '₦';
      case 'ZAR':
        return 'R';
      default:
        return '\$'; // Default to dollar symbol
    }
  }
}

/// Simple widget that displays just the currency symbol.
///
/// Automatically updates when currency changes.
class CurrencySymbolWidget extends StatelessWidget {
  final TextStyle? style;
  final String? fallbackCurrency;

  const CurrencySymbolWidget({
    super.key,
    this.style,
    this.fallbackCurrency,
  });

  @override
  Widget build(BuildContext context) {
    final currencySyncService = serviceLocator<CurrencySyncService>();

    return StreamBuilder<String>(
      stream: currencySyncService.currencyStream,
      initialData: currencySyncService.currentCurrency,
      builder: (context, snapshot) {
        final currency = snapshot.data ?? fallbackCurrency ?? 'USD';
        final symbol = _getCurrencySymbol(currency);

        return Text(symbol, style: style);
      },
    );
  }

  String _getCurrencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'USD':
        return '\$';
      case 'GBP':
        return '£';
      case 'EUR':
        return '€';
      case 'JPY':
        return '¥';
      case 'CAD':
        return 'C\$';
      case 'AUD':
        return 'A\$';
      case 'CHF':
        return 'Fr';
      case 'CNY':
        return '¥';
      case 'INR':
        return '₹';
      case 'NGN':
        return '₦';
      case 'ZAR':
        return 'R';
      default:
        return '\$';
    }
  }
}

/// Widget that displays the current currency code (e.g., "USD", "GBP").
///
/// Automatically updates when currency changes.
class CurrencyCodeWidget extends StatelessWidget {
  final TextStyle? style;
  final String? prefix;
  final String? suffix;

  const CurrencyCodeWidget({
    super.key,
    this.style,
    this.prefix,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    final currencySyncService = serviceLocator<CurrencySyncService>();

    return StreamBuilder<String>(
      stream: currencySyncService.currencyStream,
      initialData: currencySyncService.currentCurrency,
      builder: (context, snapshot) {
        final currency = snapshot.data ?? 'USD';

        return Text(
          '${prefix ?? ''}$currency${suffix ?? ''}',
          style: style,
        );
      },
    );
  }
}
