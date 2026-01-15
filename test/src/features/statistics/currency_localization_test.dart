import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/core/services/currency_localization_service.dart';

void main() {
  group('CurrencyLocalizationService', () {
    late CurrencyLocalizationService service;

    setUp(() {
      service = CurrencyLocalizationService();
    });

    test('formats USD amount correctly', () {
      expect(
        service.formatAmount(1234.56, currencyCode: 'USD'),
        '\$1,234.56',
      );
    });

    test('formats EUR amount correctly', () {
      expect(
        service.formatAmount(1234.56, currencyCode: 'EUR'),
        '1.234,56 €',
      );
    });

    test('formats JPY amount without decimals', () {
      expect(
        service.formatAmount(1234, currencyCode: 'JPY'),
        '¥1,234',
      );
    });

    test('formats amount without symbol', () {
      expect(
        service.formatAmount(1234.56, currencyCode: 'USD', showSymbol: false),
        '1,234.56',
      );
    });

    test('formats compact amounts correctly', () {
      expect(
        service.formatAmount(1500000, currencyCode: 'USD', compact: true),
        '1.5M \$',
      );

      expect(
        service.formatAmount(1500, currencyCode: 'USD', compact: true),
        '1.5K \$',
      );
    });

    test('formats percentage correctly', () {
      expect(
        service.formatPercentage(25.5),
        '25.5%',
      );
    });

    test('formats percentage without symbol', () {
      expect(
        service.formatPercentage(25.5, showSymbol: false),
        '25.5',
      );
    });

    test('formats date range correctly', () {
      final start = DateTime(2024, 1, 1);
      final end = DateTime(2024, 1, 31);

      expect(
        service.formatDateRange(start, end),
        'Jan 01 - Jan 31, 2024',
      );
    });

    test('formats relative dates correctly', () {
      final today = DateTime.now();
      final yesterday = today.subtract(const Duration(days: 1));
      final threeDaysAgo = today.subtract(const Duration(days: 3));

      expect(service.formatRelativeDate(today), 'Today');
      expect(service.formatRelativeDate(yesterday), 'Yesterday');
      expect(service.formatRelativeDate(threeDaysAgo), '3 days ago');
    });

    test('gets currency info correctly', () {
      final usdInfo = service.getCurrencyInfo('USD');

      expect(usdInfo?.code, 'USD');
      expect(usdInfo?.symbol, '\$');
      expect(usdInfo?.name, 'US Dollar');
    });

    test('returns null for invalid currency code', () {
      expect(service.getCurrencyInfo('INVALID'), isNull);
    });

    test('validates currency codes correctly', () {
      expect(service.isValidCurrency('USD'), true);
      expect(service.isValidCurrency('EUR'), true);
      expect(service.isValidCurrency('INVALID'), false);
    });

    test('gets all supported currencies', () {
      final currencies = service.getSupportedCurrencies();

      expect(currencies, contains('USD'));
      expect(currencies, contains('EUR'));
      expect(currencies, contains('GBP'));
    });

    test('parses amount from string correctly', () {
      expect(
        service.parseAmount('\$1,234.56', currencyCode: 'USD'),
        1234.56,
      );
      expect(
        service.parseAmount('€1.234,56', currencyCode: 'EUR'),
        1234.56,
      );
    });

    test('returns null for invalid amount string', () {
      expect(service.parseAmount('invalid'), isNull);
    });
  });

  group('CurrencyFormatting extension', () {
    test('formats double to currency', () {
      expect(1234.56.toCurrency(currencyCode: 'USD'), '\$1,234.56');
    });

    test('formats double to percentage', () {
      expect(25.5.toPercentage(), '25.5%');
    });
  });

  group('CurrencyLocalizationService.getAmountColor', () {
    test('returns green for positive amounts', () {
      expect(CurrencyLocalizationService.getAmountColor(100.0),
          const Color(0xFF10B981));
    });

    test('returns red for negative amounts', () {
      expect(CurrencyLocalizationService.getAmountColor(-100.0),
          const Color(0xFFEF4444));
    });

    test('returns gray for zero', () {
      expect(CurrencyLocalizationService.getAmountColor(0.0),
          const Color(0xFF6B7280));
    });
  });
}
