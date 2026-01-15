import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/generated/accounts.pbgrpc.dart';
import 'package:lazervault/core/types/services.dart';

/// Simple Backend Integration Verification Tests
void main() {
  group('Backend Integration - Proto Messages', () {
    test('GetTransactionHistoryRequest can be created with service filter', () {
      final request = GetTransactionHistoryRequest()
        ..accountId = 'test-account-id'
        ..serviceName = 'giftcards-service'
        ..limit = 10;

      expect(request.accountId, equals('test-account-id'));
      expect(request.serviceName, equals('giftcards-service'));
      expect(request.limit, equals(10));
    });

    test('GetTransactionStatisticsRequest can be created', () {
      final request = GetTransactionStatisticsRequest()
        ..accountId = 'test-account-id';

      expect(request.accountId, equals('test-account-id'));
    });

    test('Transaction message has locale and serviceName fields', () {
      final tx = Transaction()
        ..id = 'test-id'
        ..locale = 'en-US'
        ..serviceName = 'giftcards-service'
        ..amount = 50.0;

      expect(tx.locale, equals('en-US'));
      expect(tx.serviceName, equals('giftcards-service'));
      expect(tx.amount, equals(50.0));
    });
  });

  group('Service Name Mapping', () {
    test('All critical services have backend names', () {
      expect(AppServiceName.airtime.backendServiceName, equals('airtime-service'));
      expect(AppServiceName.giftCards.backendServiceName, equals('giftcards-service'));
      expect(AppServiceName.stocks.backendServiceName, equals('stocks-service'));
      expect(AppServiceName.crypto.backendServiceName, equals('crypto-service'));
      expect(AppServiceName.insurance.backendServiceName, equals('insurance-service'));
      expect(AppServiceName.sendFunds.backendServiceName, equals('transfer-service'));
      expect(AppServiceName.tagPay.backendServiceName, equals('tag-pay-service'));
      expect(AppServiceName.autoSave.backendServiceName, equals('accounts-service'));
      expect(AppServiceName.crowdfund.backendServiceName, equals('crowdfund-service'));
    });
  });
}
