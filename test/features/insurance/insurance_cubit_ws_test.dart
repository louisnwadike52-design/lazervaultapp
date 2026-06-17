// Unit tests for InsuranceCubit + MyClaimsCubit WebSocket-event handling.
//
// Covers slice-mandated scenarios 3 and 4:
//   * WSPolicyRenewed   — when ws-balance-service pushes
//                          insurance_policy_renewed, InsuranceCubit refetches
//                          the policy list.
//   * WSClaimStatus     — when ws-balance-service pushes
//                          insurance_claim_status_changed, MyClaimsCubit
//                          refetches the claims list.
//
// These run under `flutter test` — no backend dependency. We construct
// a real BalanceWebSocketService and call its `testInjectBalanceEvent`
// hook to simulate inbound events. Repository is a recording fake so we
// can assert call counts.

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/account_cards_summary/services/balance_websocket_service.dart';
import 'package:lazervault/src/features/insurance/domain/entities/insurance_claim_entity.dart';
import 'package:lazervault/src/features/insurance/domain/entities/insurance_entity.dart';
import 'package:lazervault/src/features/insurance/domain/entities/insurance_payment_entity.dart';
import 'package:lazervault/src/features/insurance/domain/entities/insurance_product_entity.dart';
import 'package:lazervault/src/features/insurance/domain/repositories/insurance_repository.dart';
import 'package:lazervault/src/features/insurance/presentation/cubit/insurance_cubit.dart';
import 'package:lazervault/src/features/insurance/presentation/cubit/my_claims_cubit.dart';

void main() {
  group('InsuranceCubit WS subscription', () {
    test('refetches on insurance_policy_renewed', () async {
      final ws = BalanceWebSocketService(secureStorage: _FakeSecureStorage());
      final repo = _RecordingInsuranceRepository();
      final cubit = InsuranceCubit(repository: repo, wsService: ws);
      cubit.setUserId('user-42');

      await _settle();
      final initialCallCount = repo.getUserInsurancesPageCalls;
      expect(initialCallCount, greaterThanOrEqualTo(1),
          reason: 'setUserId should trigger initial load');

      ws.testInjectBalanceEvent(_policyRenewedPayload('user-42'));
      await _settle();

      expect(repo.getUserInsurancesPageCalls, greaterThan(initialCallCount),
          reason: 'renewal event should trigger refetch');
      await cubit.close();
      ws.dispose();
    });

    test('ignores events for other users', () async {
      final ws = BalanceWebSocketService(secureStorage: _FakeSecureStorage());
      final repo = _RecordingInsuranceRepository();
      final cubit = InsuranceCubit(repository: repo, wsService: ws);
      cubit.setUserId('user-42');

      await _settle();
      final baseline = repo.getUserInsurancesPageCalls;

      ws.testInjectBalanceEvent(_policyRenewedPayload('someone-else'));
      await _settle();

      expect(repo.getUserInsurancesPageCalls, baseline,
          reason: 'event for other user should be ignored');
      await cubit.close();
      ws.dispose();
    });
  });

  group('MyClaimsCubit WS subscription', () {
    test('refetches on insurance_claim_status_changed', () async {
      final ws = BalanceWebSocketService(secureStorage: _FakeSecureStorage());
      final repo = _RecordingInsuranceRepository();
      final cubit = MyClaimsCubit(repo, wsService: ws);
      cubit.setUserId('user-42');

      await cubit.load();
      await _settle();
      final initialCallCount = repo.getUserClaimsCalls;
      expect(initialCallCount, greaterThanOrEqualTo(1));

      ws.testInjectBalanceEvent(_claimStatusPayload('user-42'));
      await _settle();

      expect(repo.getUserClaimsCalls, greaterThan(initialCallCount),
          reason: 'claim event should trigger refetch');
      await cubit.close();
      ws.dispose();
    });
  });
}

Map<String, dynamic> _policyRenewedPayload(String userId) => {
      'user_id': userId,
      'event_type': 'insurance_policy_renewed',
      'transaction_id': 'p1',
      'reference': 'POL-001',
      'narration': '2026-12-31',
      'amount': 0,
      'currency': 'NGN',
      'status': 'renewed',
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };

Map<String, dynamic> _claimStatusPayload(String userId) => {
      'user_id': userId,
      'event_type': 'insurance_claim_status_changed',
      'transaction_id': 'claim-1',
      'narration': 'Offer accepted',
      'status': 'approved',
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };

Future<void> _settle() async {
  await Future<void>.delayed(Duration.zero);
  await Future<void>.delayed(Duration.zero);
}

class _FakeSecureStorage extends SecureStorageService {
  _FakeSecureStorage() : super(const FlutterSecureStorage());
}

class _RecordingInsuranceRepository implements InsuranceRepository {
  int getUserInsurancesPageCalls = 0;
  int getUserClaimsCalls = 0;

  @override
  Future<UserInsurancesPage> getUserInsurancesPage({
    required String userId,
    int page = 1,
    int limit = 15,
  }) async {
    getUserInsurancesPageCalls++;
    return const UserInsurancesPage(
      insurances: <Insurance>[],
      totalItems: 0,
      currentPage: 1,
      totalPages: 1,
      hasMore: false,
    );
  }

  @override
  Future<List<InsurancePayment>> getUserPayments(String userId) async => [];

  @override
  Future<List<InsurancePayment>> getOverduePayments(String userId) async => [];

  @override
  Future<Map<String, dynamic>> getInsuranceStatistics(String userId) async =>
      {};

  @override
  Future<List<InsuranceClaim>> getUserClaims(
    String userId, {
    int page = 1,
    int limit = 20,
  }) async {
    getUserClaimsCalls++;
    return [];
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName} not stubbed');
}
