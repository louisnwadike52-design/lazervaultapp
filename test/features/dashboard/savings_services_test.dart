import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/widgets/app_services_builder.dart';

/// A savings pot is for moving money OUT of savings. The grid used to offer
/// auto-save and lock funds on the pot itself — flows that save INTO a pot, so
/// choosing them from a savings card asks the user to save from their savings —
/// alongside exchange, crowdfund and insurance, which belong to a personal
/// wallet, and a standalone airtime tile duplicating the bills hub.
void main() {
  group('savings account services', () {
    final savings = AppServicesBuilder.servicesForAccountType(
      VirtualAccountType.savings,
    ).map((s) => s.serviceName).toList();

    test('offers exactly send funds, batch transfer and the bills hub', () {
      expect(
        savings,
        containsAll([
          AppServiceName.sendFunds,
          AppServiceName.batchTransfer,
          AppServiceName.payBills,
        ]),
      );
      expect(savings, hasLength(3));
    });

    test('does not offer flows that save INTO a pot', () {
      expect(savings, isNot(contains(AppServiceName.autoSave)));
      expect(savings, isNot(contains(AppServiceName.lockFunds)));
    });

    test('does not offer wealth flows that belong to a personal wallet', () {
      for (final s in [
        AppServiceName.exchange,
        AppServiceName.crowdfund,
        AppServiceName.insurance,
      ]) {
        expect(savings, isNot(contains(s)), reason: s.toString());
      }
    });

    test('every offered service is one that debits the active wallet', () {
      // The point of the narrowing: what the grid shows is what the backend
      // will accept for this wallet, funded by the active account id.
      for (final s in savings) {
        expect(
          const [
            AppServiceName.sendFunds,
            AppServiceName.batchTransfer,
            AppServiceName.payBills,
          ],
          contains(s),
        );
      }
    });
  });
}
