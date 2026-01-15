import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/generated/accounts.pbgrpc.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/core/types/transaction_service_mapping.dart';

/// Unit tests for Transaction History Backend Integration
///
/// These tests verify that:
/// 1. Proto messages are correctly generated
/// 2. Service name mapping works correctly
/// 3. Request/response structures are compatible
void main() {
  group('Transaction History Proto Messages', () {
    test('GetTransactionHistoryRequest can be created', () {
      final request = GetTransactionHistoryRequest()
        ..accountId = '33b4932a-d2aa-4a49-ba05-85354136e4ab'
        ..limit = 10
        ..offset = 0
        ..serviceName = 'giftcards-service';

      expect(request.accountId, equals('33b4932a-d2aa-4a49-ba05-85354136e4ab'));
      expect(request.limit, equals(10));
      expect(request.serviceName, equals('giftcards-service'));
    });

    test('GetTransactionStatisticsRequest can be created', () {
      final request = GetTransactionStatisticsRequest()
        ..accountId = '33b4932a-d2aa-4a49-ba05-85354136e4ab';

      expect(request.accountId, equals('33b4932a-d2aa-4a49-ba05-85354136e4ab'));
    });

    test('Transaction proto message has locale and serviceName fields', () {
      final transaction = Transaction()
        ..id = 'test-id'
        ..accountId = 'test-account-id'
        ..locale = 'en-US'
        ..serviceName = 'giftcards-service'
        ..amount = 100.0
        ..type = 'debit';

      expect(transaction.locale, equals('en-US'));
      expect(transaction.serviceName, equals('giftcards-service'));
      expect(transaction.amount, equals(100.0));
      expect(transaction.type, equals('debit'));
    });
  });

  group('Service Name Mapping', () {
    test('AppServiceName.giftCards maps to backend service name', () {
      const giftCardsService = AppServiceName.giftCards;
      final backendName = giftCardsService.backendServiceName;

      expect(backendName, equals('giftcards-service'));
    });

    test('AppServiceName.airtime maps to backend service name', () {
      const airtimeService = AppServiceName.airtime;
      final backendName = airtimeService.backendServiceName;

      expect(backendName, equals('airtime-service'));
    });

    test('AppServiceName.stocks maps to backend service name', () {
      const stocksService = AppServiceName.stocks;
      final backendName = stocksService.backendServiceName;

      expect(backendName, equals('stocks-service'));
    });

    test('AppServiceName.crypto maps to backend service name', () {
      const cryptoService = AppServiceName.crypto;
      final backendName = cryptoService.backendServiceName;

      expect(backendName, equals('crypto-service'));
    });

    test('AppServiceName.transfer (sendFunds) maps to transfer-service', () {
      const transferService = AppServiceName.sendFunds;
      final backendName = transferService.backendServiceName;

      expect(backendName, equals('transfer-service'));
    });

    test('AppServiceName.payElectricityBill maps to utility-payments-service', () {
      const electricityService = AppServiceName.payElectricityBill;
      final backendName = electricityService.backendServiceName;

      expect(backendName, equals('utility-payments-service'));
    });
  });

  group('Transaction Service Type Mapping', () {
    test('TransactionServiceType.giftCard maps to AppServiceName.giftCards', () {
      const giftCardType = TransactionServiceType.giftCard;
      final appService = giftCardType.toAppServiceName;

      expect(appService, equals(AppServiceName.giftCards));
    });

    test('AppServiceName.giftCards maps back to TransactionServiceType.giftCard', () {
      const giftCardsService = AppServiceName.giftCards;
      final txType = giftCardsService.toTransactionServiceType;

      expect(txType, equals(TransactionServiceType.giftCard));
    });

    test('Bidirectional mapping: giftCards service', () {
      const service = AppServiceName.giftCards;
      final backendName = service.backendServiceName;
      expect(backendName, equals('giftcards-service'));

      final txType = service.toTransactionServiceType;
      expect(txType, equals(TransactionServiceType.giftCard));

      final backToService = txType.toAppServiceName;
      expect(backToService, equals(AppServiceName.giftCards));
    });
  });

  group('All Services Have Backend Mappings', () {
    test('All 22 services have backendServiceName', () {
      final services = AppServiceName.values;

      for (final service in services) {
        final backendName = service.backendServiceName;
        expect(backendName, isNotNull);
        expect(backendName, isNotEmpty);

        // Verify it doesn't contain the placeholder prefix
        expect(backendName.startsWith('TO_IMPLEMENT_'), isFalse);
      }
    });

    test('Common services have expected backend names', () {
      expect(AppServiceName.airtime.backendServiceName, equals('airtime-service'));
      expect(AppServiceName.giftCards.backendServiceName, equals('giftcards-service'));
      expect(AppServiceName.stocks.backendServiceName, equals('stocks-service'));
      expect(AppServiceName.crypto.backendServiceName, equals('crypto-service'));
      expect(AppServiceName.insurance.backendServiceName, equals('insurance-service'));
      expect(AppServiceName.sendFunds.backendServiceName, equals('transfer-service'));
      expect(AppServiceName.tagPay.backendServiceName, equals('tag-pay-service'));
    });
  });
}
