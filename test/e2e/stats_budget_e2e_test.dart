/// E2E (debug-mode) tests for the AI budgeting / statistics stack:
/// REAL Flutter datasources + cubits against the REAL local backends —
/// no widgets, no mocks on the wire.
///
/// Covers, end to end:
///  1. StatisticsCubit source contract (wallet / bank / combined) with EXACT
///     per-bank totals from synced Mono external transactions.
///  2. Per-bank scoping (changeBank) including the genuine-EMPTY state for a
///     linked bank with no synced activity, and the honest UNAVAILABLE state
///     for a non-owned bank id.
///  3. Budget flexible-vs-strict enforcement via the live statistics-service:
///     strict blocks (budget_exceeded_strict), flexible allows with warning
///     (budget_exceeded_flexible).
///
/// Prereqs (the local stack):
///   * core-gateway 50070/7878, banking-gateway 50077, investment-gateway
///     50072 (statistics RPCs), banking-service, accounts-service,
///     statistics-service all running (start_all_local_no_docker.sh)
///   * seeded user provetest2@gmail.com / Password1$ with linked banks +
///     synced external transactions (GTBank + Zenith on 2026-06-05)
///
/// Run: flutter test test/e2e/stats_budget_e2e_test.dart
library stats_budget_e2e_test;

import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';

import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/src/core/grpc/accounts_grpc_client.dart';
import 'package:lazervault/src/features/open_banking/data/datasources/open_banking_grpc_datasource.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_state.dart';
import 'package:lazervault/src/features/statistics/data/budget_repository.dart';
import 'package:lazervault/src/features/statistics/data/financial_analytics_repository.dart';
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_pb;
import 'package:lazervault/src/generated/banking.pbgrpc.dart' as banking_pb;
import 'package:lazervault/src/generated/statistics.pbgrpc.dart' as stats_pb;

// ── Test fixtures (live local stack) ────────────────────────────────────────
const _host = 'localhost';
const _email = 'provetest2@gmail.com';
const _password = 'Password1\$';
const _userId = 'e233d0fd-88fe-4be8-a919-4b25ac4442b4';
const _walletAccountId = '2a07884c-f7e5-46b9-bb31-a0ec00df79cc';
// Linked banks (banking-service linked_bank_accounts):
const _gtbankId = '660a683f-95a3-4979-a4d7-aa1ccd041201'; // synced activity
const _zenithId = '1ba3b149-8014-4ff6-8e32-b7b04c9f40d7'; // synced activity
const _providusId = '6e1ba6af-0032-4388-9bb9-779933c32ad9'; // NO synced txns

/// In-memory FlutterSecureStorage stand-in carrying the real JWT.
class _TestStorage extends Fake implements FlutterSecureStorage {
  final Map<String, String> _data = {};

  @override
  Future<String?> read({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async =>
      _data[key];

  @override
  Future<void> write({
    required String key,
    required String? value,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    if (value == null) {
      _data.remove(key);
    } else {
      _data[key] = value;
    }
  }
}

/// Real login against core-gateway HTTP, returns the access token.
Future<String> _login() async {
  final client = HttpClient();
  try {
    final req = await client.postUrl(
        Uri.parse('http://$_host:7878/api/v1/auth/login'));
    req.headers.contentType = ContentType.json;
    req.write(jsonEncode({'email': _email, 'password': _password}));
    final res = await req.close();
    final body = jsonDecode(await res.transform(utf8.decoder).join());
    expect(body['success'], isTrue,
        reason: 'Login failed: ${body['msg']} — is the stack up and the '
            'provetest2 account unlocked?');
    return body['accessToken'] as String;
  } finally {
    client.close();
  }
}

ClientChannel _channel(int port) => ClientChannel(
      _host,
      port: port,
      options:
          const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

Future<StatisticsLoaded> _loadedState(StatisticsCubit cubit) async {
  final state = cubit.state;
  expect(state, isA<StatisticsLoaded>(),
      reason: 'expected StatisticsLoaded, got $state');
  return state as StatisticsLoaded;
}

void main() {
  late _TestStorage storage;
  late GrpcCallOptionsHelper authHelper;
  late AccountManager accountManager;
  late LocaleManager localeManager;
  late ClientChannel coreChannel; // accounts-service RPCs
  late ClientChannel bankingChannel; // banking-service RPCs
  late ClientChannel statsChannel; // statistics-service RPCs
  late OpenBankingGrpcDataSource bankingDataSource;
  late FinancialAnalyticsRepository analyticsRepository;
  late BudgetRepository budgetRepository;

  setUpAll(() async {
    final token = await _login();
    storage = _TestStorage();
    await storage.write(key: 'access_token', value: token);
    await storage.write(key: 'user_id', value: _userId);

    accountManager = AccountManager()..setActiveAccount(_walletAccountId);
    localeManager = LocaleManager();
    authHelper = GrpcCallOptionsHelper(
      storage,
      localeManager: localeManager,
      accountManager: accountManager,
    );

    coreChannel = _channel(50070);
    bankingChannel = _channel(50077);
    statsChannel = _channel(50072);

    bankingDataSource = OpenBankingGrpcDataSource(
      banking_pb.BankingServiceClient(bankingChannel),
      authHelper,
    );
    analyticsRepository = FinancialAnalyticsRepository(
      grpcClient: AccountsGrpcClient(
        client: accounts_pb.AccountsServiceClient(coreChannel),
        callOptionsHelper: authHelper,
      ),
      accountManager: accountManager,
      localeManager: localeManager,
    );
    budgetRepository = BudgetRepository(
      grpcClient: stats_pb.StatisticsServiceClient(statsChannel),
      accountManager: accountManager,
      callOptionsHelper: authHelper,
    );
  });

  tearDownAll(() async {
    await coreChannel.shutdown();
    await bankingChannel.shutdown();
    await statsChannel.shutdown();
  });

  StatisticsCubit newCubit() => StatisticsCubit(
        analyticsRepository: analyticsRepository,
        bankingDataSource: bankingDataSource,
      )..userId = _userId;

  group('External bank analytics (real Mono-synced data)', () {
    // Window covering the synced statements (2026-06-05).
    final start = DateTime(2026, 5, 1);
    final end = DateTime(2026, 12, 31);

    Future<StatisticsLoaded> loadBankScope(String? bankId) async {
      final cubit = newCubit()..changeSourceForTest(StatisticsSource.bank);
      if (bankId != null) cubit.changeBankForTest(bankId);
      await cubit.loadStatistics(startDate: start, endDate: end);
      final st = await _loadedState(cubit);
      await cubit.close();
      return st;
    }

    test(
        'per-bank ADDITIVITY: all-banks == GTBank + Zenith (real synced Mono data)',
        () async {
      final all = await loadBankScope(null);
      final gt = await loadBankScope(_gtbankId);
      final zen = await loadBankScope(_zenithId);

      expect(all.source, StatisticsSource.bank);
      expect(all.externalStatus, ExternalDataStatus.ready,
          reason: 'externalError=${all.externalError}');
      expect(gt.externalStatus, ExternalDataStatus.ready);
      expect(zen.externalStatus, ExternalDataStatus.ready);
      expect(gt.selectedBankAccountId, _gtbankId);

      // Real activity, not zeros.
      expect(gt.financialAnalytics!.currentPeriod.totalExpenses, greaterThan(0));
      expect(zen.financialAnalytics!.currentPeriod.totalExpenses, greaterThan(0));
      expect(all.financialAnalytics!.currentPeriod.transactionCount,
          greaterThan(10));

      // Per-bank scoping is exact: the parts sum to the whole.
      expect(
        all.financialAnalytics!.currentPeriod.totalExpenses,
        closeTo(
            gt.financialAnalytics!.currentPeriod.totalExpenses +
                zen.financialAnalytics!.currentPeriod.totalExpenses,
            0.01),
      );
      expect(
        all.financialAnalytics!.currentPeriod.totalIncome,
        closeTo(
            gt.financialAnalytics!.currentPeriod.totalIncome +
                zen.financialAnalytics!.currentPeriod.totalIncome,
            0.01),
      );
      expect(
        all.financialAnalytics!.currentPeriod.transactionCount,
        gt.financialAnalytics!.currentPeriod.transactionCount +
            zen.financialAnalytics!.currentPeriod.transactionCount,
      );
    });

    test('honest EMPTY: linked bank with no synced activity', () async {
      final st = await loadBankScope(_providusId);
      expect(st.externalStatus, ExternalDataStatus.empty,
          reason: 'Providus has no synced transactions — must surface as '
              'EMPTY, never as fabricated metrics');
      expect(st.financialAnalytics!.currentPeriod.totalExpenses, 0);
    });

    test('honest UNAVAILABLE: non-owned bank id is refused, not zeroed',
        () async {
      final st =
          await loadBankScope('00000000-0000-4000-8000-000000000000');
      expect(st.externalStatus, ExternalDataStatus.unavailable,
          reason: 'ownership check must surface as UNAVAILABLE');
      expect(st.externalError, isNotNull);
    });

    test('combined = wallet + external (strictly >= bank-only)', () async {
      final bankCubit = newCubit()..changeSourceForTest(StatisticsSource.bank);
      await bankCubit.loadStatistics(startDate: start, endDate: end);
      final bankOnly = await _loadedState(bankCubit);

      final bothCubit = newCubit(); // default source = both
      await bothCubit.loadStatistics(startDate: start, endDate: end);
      final both = await _loadedState(bothCubit);

      final walletCubit = newCubit()
        ..changeSourceForTest(StatisticsSource.lazervault);
      await walletCubit.loadStatistics(startDate: start, endDate: end);
      final wallet = await _loadedState(walletCubit);

      // Additive contract: combined == wallet + bank for the same window.
      expect(
        both.financialAnalytics!.currentPeriod.totalExpenses,
        closeTo(
          wallet.financialAnalytics!.currentPeriod.totalExpenses +
              bankOnly.financialAnalytics!.currentPeriod.totalExpenses,
          0.01,
        ),
      );
      expect(wallet.externalStatus, ExternalDataStatus.notApplicable);
      await bankCubit.close();
      await bothCubit.close();
      await walletCubit.close();
    });
  });

  group('Budget enforcement (real statistics-service)', () {
    const category = stats_pb.ExpenseCategory.EXPENSE_CATEGORY_FOOD_DINING;
    final createdIds = <String>[];

    Future<String> createBudget(stats_pb.BudgetEnforcementMode mode) async {
      final resp = await budgetRepository.createBudget(
        name: 'E2E ${mode == stats_pb.BudgetEnforcementMode.BUDGET_ENFORCEMENT_MODE_STRICT ? "Strict" : "Flexible"} ${DateTime.now().millisecondsSinceEpoch}',
        amount: 50.0, // ₦50 limit — any real transfer exceeds it
        currency: 'NGN',
        category: category,
        period: stats_pb.BudgetPeriod.BUDGET_PERIOD_MONTHLY,
        enforcementMode: mode,
      );
      expect(resp.success, isTrue, reason: resp.message);
      createdIds.add(resp.budget.id);
      return resp.budget.id;
    }

    tearDownAll(() async {
      for (final id in createdIds) {
        try {
          await budgetRepository.deleteBudget(id);
        } catch (_) {}
      }
    });

    test('STRICT budget blocks an over-limit transfer', () async {
      await createBudget(
          stats_pb.BudgetEnforcementMode.BUDGET_ENFORCEMENT_MODE_STRICT);

      final v = await budgetRepository.validateCategoryBudget(
        budgetCategory: category.value,
        amountMinor: 10000 * 100, // ₦10,000 against a ₦50 limit
        currency: 'NGN',
      );
      expect(v.allowed, isFalse,
          reason: 'strict + exceeded must BLOCK (got reason=${v.reason})');
      expect(v.reason, 'budget_exceeded_strict');
      // Cleanup this one before the flexible test so only one Food budget
      // is active at a time.
      await budgetRepository.deleteBudget(createdIds.removeLast());
    });

    test('FLEXIBLE budget allows the same transfer with a warning', () async {
      await createBudget(
          stats_pb.BudgetEnforcementMode.BUDGET_ENFORCEMENT_MODE_FLEXIBLE);

      final v = await budgetRepository.validateCategoryBudget(
        budgetCategory: category.value,
        amountMinor: 10000 * 100,
        currency: 'NGN',
      );
      expect(v.allowed, isTrue,
          reason: 'flexible + exceeded must ALLOW with warning');
      expect(v.reason, 'budget_exceeded_flexible');
    });
  });
}
