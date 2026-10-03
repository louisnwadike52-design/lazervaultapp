import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/open_banking/data/datasources/open_banking_grpc_datasource.dart';
import 'package:lazervault/src/features/open_banking/data/datasources/open_banking_remote_datasource.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/withdrawal.dart';
import 'package:lazervault/src/generated/banking.pbgrpc.dart' as banking;
import 'package:lazervault/src/features/recipients/data/repositories/bank_repository.dart';

// WHAT THIS LOCKS
// ---------------
// `GET /api/v1/banks` is implemented and correct on banking-service, but the
// public edge carried no ingress rule for that path, so through
// api.lazervault.app it fell to the catch-all gateway and answered
// `{"code":5,"message":"Not Found"}`. Measured 2026-10-03:
//
//   edge   GET https://api.lazervault.app/api/v1/banks        -> 404 code=5
//   svc    GET http://127.0.0.1:18073/api/v1/banks            -> 200, 633 banks
//   edge   gRPC banking.BankingService/GetBanks               -> 200, 633 banks,
//                                                                provider=nomba,
//                                                                Kuda=090267
//
// The app caught that 404 and used its BUNDLED list, which is Flutterwave-shaped
// and contains no Nombank row at all — so a user on the live Nomba rail saw a
// normal-looking picker with no "Nomba"/"Nombank" entry and Flutterwave codes
// for every fintech. That is the reported bug, from both ends.
//
// The repository therefore tries gRPC FIRST and REST second, and only reaches
// the bundled list when neither transport can answer.

class _FakeGrpc extends OpenBankingGrpcDataSource {
  _FakeGrpc({required this.result, this.throws})
      : super(
          banking.BankingServiceClient(
            ClientChannel(
              'localhost',
              port: 1,
              options: const ChannelOptions(
                credentials: ChannelCredentials.insecure(),
              ),
            ),
          ),
          GrpcCallOptionsHelper(const FlutterSecureStorage()),
        );

  final ({List<Bank> banks, String provider}) result;
  final Object? throws;
  int calls = 0;

  @override
  Future<({List<Bank> banks, String provider})> getBanksWithProvider({
    String country = 'NG',
  }) async {
    calls++;
    if (throws != null) throw throws!;
    return result;
  }
}

class _FakeRest extends OpenBankingRemoteDataSource {
  _FakeRest({required this.result, this.throws})
      : super(
          // Explicit, so constructing the fake does not go through
          // `_getBaseUrl()` — which reads dotenv and throws outside a running
          // app. Nothing in these tests performs a real request.
          baseUrl: 'http://bank-list.test/api/v1',
          secureStorage: SecureStorageService(const FlutterSecureStorage()),
        );

  final ({List<Bank> banks, String provider}) result;
  final Object? throws;
  int calls = 0;

  @override
  Future<({List<Bank> banks, String provider})> getBanksWithProvider({
    required String accessToken,
  }) async {
    calls++;
    if (throws != null) throw throws!;
    return result;
  }
}

class _TokenStorage extends SecureStorageService {
  _TokenStorage(this._token) : super(const FlutterSecureStorage());
  final String? _token;

  @override
  Future<String?> getAccessToken() async => _token;
}

const _nomba = (
  banks: [
    Bank(code: '090645', name: 'Nombank'),
    Bank(code: '090267', name: 'Kuda Microfinance Bank'),
  ],
  provider: 'nomba',
);

const _flutterwave = (
  banks: [Bank(code: '50211', name: 'Kuda Bank')],
  provider: 'flutterwave',
);

BankRepository _repo({
  required _FakeGrpc grpc,
  required _FakeRest rest,
  String? token = 'a-token',
}) =>
    BankRepository(rest, _TokenStorage(token), grpc: grpc);

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('gRPC is the transport that is used, and REST is not called', () async {
    final grpc = _FakeGrpc(result: _nomba);
    final rest = _FakeRest(result: _flutterwave);

    final banks = await _repo(grpc: grpc, rest: rest).getBanks('NG');

    expect(grpc.calls, 1);
    expect(rest.calls, 0, reason: 'REST 404s at the edge; do not depend on it');
    expect(banks.map((b) => b['name']), contains('Nombank'));
    expect(
      banks.firstWhere((b) => b['name'] == 'Kuda Microfinance Bank')['code'],
      '090267',
      reason: "Nomba's code for Kuda, not Flutterwave's 50211",
    );
  });

  test('REST is tried when gRPC fails, so one broken hop is survivable',
      () async {
    final grpc = _FakeGrpc(result: _nomba, throws: Exception('channel down'));
    final rest = _FakeRest(result: _nomba);

    final banks = await _repo(grpc: grpc, rest: rest).getBanks('NG');

    expect(grpc.calls, 1);
    expect(rest.calls, 1);
    expect(banks.map((b) => b['name']), contains('Nombank'));
  });

  test('the rail that served the list is persisted with it', () async {
    final grpc = _FakeGrpc(result: _nomba);
    await _repo(grpc: grpc, rest: _FakeRest(result: _nomba)).getBanks('NG');

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('banks_cache_provider_NG'), 'nomba',
        reason: 'a list without its rail cannot be invalidated after a switch');
  });

  test('both transports failing falls back to the bundled list, not an empty '
      'picker', () async {
    final grpc = _FakeGrpc(result: _nomba, throws: Exception('down'));
    final rest = _FakeRest(result: _nomba, throws: Exception('404'));

    final banks = await _repo(grpc: grpc, rest: rest).getBanks('NG');

    expect(grpc.calls, 1);
    expect(rest.calls, 1);
    expect(banks, isNotEmpty,
        reason: 'an empty bank picker helps no one; the server still refuses '
            'a code it cannot resolve, so the failure is a declined transfer '
            'rather than misrouted money');
  });

  test('no session means no fetch at all — not a crash', () async {
    final grpc = _FakeGrpc(result: _nomba);
    final rest = _FakeRest(result: _nomba);

    final banks =
        await _repo(grpc: grpc, rest: rest, token: null).getBanks('NG');

    expect(grpc.calls, 0);
    expect(rest.calls, 0);
    expect(banks, isNotEmpty);
  });

  test('a second read in the same session is served from cache', () async {
    final grpc = _FakeGrpc(result: _nomba);
    final rest = _FakeRest(result: _nomba);
    final repo = _repo(grpc: grpc, rest: rest);

    await repo.getBanks('NG');
    await repo.getBanks('NG');

    expect(grpc.calls, 1,
        reason: 'revalidate once per launch, then serve the fresh cache');
  });

  test('non-NG countries never touch the network', () async {
    final grpc = _FakeGrpc(result: _nomba);
    final rest = _FakeRest(result: _nomba);

    final banks = await _repo(grpc: grpc, rest: rest).getBanks('GB');

    expect(grpc.calls, 0);
    expect(rest.calls, 0);
    expect(banks, isNotEmpty);
  });
}
