import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/domain/repositories/i_autosave_repository.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/create_autosave_rule_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/delete_autosave_rule_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/get_autosave_rules_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/get_autosave_statistics_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/get_autosave_transactions_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/toggle_autosave_rule_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/trigger_autosave_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/update_autosave_rule_usecase.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_cubit.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_state.dart';
import 'package:mocktail/mocktail.dart';

// ---------------------------------------------------------------------------
// Mocks
// ---------------------------------------------------------------------------

class MockAutoSaveRepository extends Mock implements IAutoSaveRepository {}

// ---------------------------------------------------------------------------
// Test fixtures
// ---------------------------------------------------------------------------

final _now = DateTime(2026, 2, 15, 12, 0, 0);

final _testRule = AutoSaveRuleEntity(
  id: 'rule-001',
  userId: 'user-123',
  name: 'Save on Paycheck',
  description: 'Auto save 10% of every deposit',
  triggerType: TriggerType.onDeposit,
  amountType: AmountType.percentage,
  amountValue: 10.0,
  sourceAccountId: 'acct-src-001',
  destinationAccountId: 'acct-dst-001',
  status: AutoSaveStatus.active,
  createdAt: _now,
  updatedAt: _now,
  triggerCount: 0,
  totalSaved: 0.0,
);

final _testRuleFixed = AutoSaveRuleEntity(
  id: 'rule-002',
  userId: 'user-123',
  name: 'Daily 500 Save',
  description: 'Save 500 Naira every day',
  triggerType: TriggerType.scheduled,
  amountType: AmountType.fixed,
  amountValue: 500.0, // Naira
  sourceAccountId: 'acct-src-001',
  destinationAccountId: 'acct-dst-001',
  status: AutoSaveStatus.active,
  frequency: ScheduleFrequency.daily,
  scheduleTime: '08:00',
  targetAmount: 50000.0,
  minimumBalance: 1000.0,
  maximumPerSave: 2000.0,
  createdAt: _now,
  updatedAt: _now,
  triggerCount: 5,
  totalSaved: 2500.0,
);

final _testRulePaused = AutoSaveRuleEntity(
  id: 'rule-001',
  userId: 'user-123',
  name: 'Save on Paycheck',
  description: 'Auto save 10% of every deposit',
  triggerType: TriggerType.onDeposit,
  amountType: AmountType.percentage,
  amountValue: 10.0,
  sourceAccountId: 'acct-src-001',
  destinationAccountId: 'acct-dst-001',
  status: AutoSaveStatus.paused,
  createdAt: _now,
  updatedAt: _now,
  triggerCount: 0,
  totalSaved: 0.0,
);

final _testTransaction = AutoSaveTransactionEntity(
  id: 'txn-001',
  ruleId: 'rule-001',
  userId: 'user-123',
  sourceAccountId: 'acct-src-001',
  destinationAccountId: 'acct-dst-001',
  amount: 500.0, // Naira (already converted from kobo by model)
  triggerType: TriggerType.onDeposit,
  triggerReason: 'Deposit received',
  success: true,
  createdAt: _now,
);

final _testStatistics = AutoSaveStatisticsEntity(
  userId: 'user-123',
  activeRulesCount: 2,
  totalSavedAllTime: 15000.0,
  totalSavedThisMonth: 3000.0,
  totalSavedThisWeek: 1000.0,
  totalTransactions: 30,
  averageSaveAmount: 500.0,
  mostActiveRule: _testRule,
);

const _serverFailure = ServerFailure(
  message: 'Internal server error',
  statusCode: 500,
);

// ---------------------------------------------------------------------------
// Helper to create a cubit wired to the mock repository
// ---------------------------------------------------------------------------

AutoSaveCubit _buildCubit(MockAutoSaveRepository repo) {
  return AutoSaveCubit(
    createAutoSaveRuleUseCase: CreateAutoSaveRuleUseCase(repo),
    getAutoSaveRulesUseCase: GetAutoSaveRulesUseCase(repo),
    updateAutoSaveRuleUseCase: UpdateAutoSaveRuleUseCase(repo),
    toggleAutoSaveRuleUseCase: ToggleAutoSaveRuleUseCase(repo),
    deleteAutoSaveRuleUseCase: DeleteAutoSaveRuleUseCase(repo),
    getAutoSaveTransactionsUseCase: GetAutoSaveTransactionsUseCase(repo),
    getAutoSaveStatisticsUseCase: GetAutoSaveStatisticsUseCase(repo),
    triggerAutoSaveUseCase: TriggerAutoSaveUseCase(repo),
  );
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  setUpAll(() {
    registerFallbackValue(TriggerType.onDeposit);
    registerFallbackValue(AmountType.fixed);
    registerFallbackValue(ScheduleFrequency.daily);
    registerFallbackValue(AutoSaveStatus.active);
  });

  late MockAutoSaveRepository mockRepository;

  setUp(() {
    mockRepository = MockAutoSaveRepository();
  });

  // =========================================================================
  // 1. CREATE RULE FLOW (the main end-to-end creation flow)
  // =========================================================================

  group('Create AutoSave Rule Flow', () {
    blocTest<AutoSaveCubit, AutoSaveState>(
      'emits step-by-step creating states then AutoSaveRuleCreated on success',
      setUp: () {
        when(() => mockRepository.createAutoSaveRule(
              name: any(named: 'name'),
              description: any(named: 'description'),
              triggerType: any(named: 'triggerType'),
              amountType: any(named: 'amountType'),
              amountValue: any(named: 'amountValue'),
              sourceAccountId: any(named: 'sourceAccountId'),
              destinationAccountId: any(named: 'destinationAccountId'),
              frequency: any(named: 'frequency'),
              scheduleTime: any(named: 'scheduleTime'),
              scheduleDay: any(named: 'scheduleDay'),
              roundUpTo: any(named: 'roundUpTo'),
              targetAmount: any(named: 'targetAmount'),
              minimumBalance: any(named: 'minimumBalance'),
              maximumPerSave: any(named: 'maximumPerSave'),
            )).thenAnswer((_) async => Right(_testRule));
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.createRule(
        name: 'Save on Paycheck',
        description: 'Auto save 10% of every deposit',
        triggerType: TriggerType.onDeposit,
        amountType: AmountType.percentage,
        amountValue: 10.0,
        sourceAccountId: 'acct-src-001',
        destinationAccountId: 'acct-dst-001',
      ),
      wait: const Duration(seconds: 2),
      expect: () => [
        // Step 1: Configure
        isA<AutoSaveRuleCreating>()
            .having((s) => s.currentStepIndex, 'step', 0),
        // Step 2: Validate
        isA<AutoSaveRuleCreating>()
            .having((s) => s.currentStepIndex, 'step', 1),
        // Step 3: Create (actual gRPC call)
        isA<AutoSaveRuleCreating>()
            .having((s) => s.currentStepIndex, 'step', 2),
        // Step 4: Confirm
        isA<AutoSaveRuleCreating>()
            .having((s) => s.currentStepIndex, 'step', 3),
        // Final: Created with the actual rule entity
        isA<AutoSaveRuleCreated>()
            .having((s) => s.rule.id, 'ruleId', 'rule-001')
            .having((s) => s.rule.name, 'name', 'Save on Paycheck'),
      ],
      verify: (_) {
        verify(() => mockRepository.createAutoSaveRule(
              name: 'Save on Paycheck',
              description: 'Auto save 10% of every deposit',
              triggerType: TriggerType.onDeposit,
              amountType: AmountType.percentage,
              amountValue: 10.0,
              sourceAccountId: 'acct-src-001',
              destinationAccountId: 'acct-dst-001',
              frequency: null,
              scheduleTime: null,
              scheduleDay: null,
              roundUpTo: null,
              targetAmount: null,
              minimumBalance: null,
              maximumPerSave: null,
            )).called(1);
      },
    );

    blocTest<AutoSaveCubit, AutoSaveState>(
      'emits creating steps then AutoSaveError on server failure',
      setUp: () {
        when(() => mockRepository.createAutoSaveRule(
              name: any(named: 'name'),
              description: any(named: 'description'),
              triggerType: any(named: 'triggerType'),
              amountType: any(named: 'amountType'),
              amountValue: any(named: 'amountValue'),
              sourceAccountId: any(named: 'sourceAccountId'),
              destinationAccountId: any(named: 'destinationAccountId'),
              frequency: any(named: 'frequency'),
              scheduleTime: any(named: 'scheduleTime'),
              scheduleDay: any(named: 'scheduleDay'),
              roundUpTo: any(named: 'roundUpTo'),
              targetAmount: any(named: 'targetAmount'),
              minimumBalance: any(named: 'minimumBalance'),
              maximumPerSave: any(named: 'maximumPerSave'),
            )).thenAnswer((_) async => const Left(_serverFailure));
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.createRule(
        name: 'Save on Paycheck',
        description: 'test',
        triggerType: TriggerType.onDeposit,
        amountType: AmountType.fixed,
        amountValue: 500.0,
        sourceAccountId: 'acct-src-001',
        destinationAccountId: 'acct-dst-001',
      ),
      wait: const Duration(seconds: 2),
      expect: () => [
        isA<AutoSaveRuleCreating>(),
        isA<AutoSaveRuleCreating>(),
        isA<AutoSaveRuleCreating>()
            .having((s) => s.currentStepIndex, 'step', 2),
        isA<AutoSaveError>()
            .having((s) => s.message, 'message', 'Internal server error'),
      ],
    );

    blocTest<AutoSaveCubit, AutoSaveState>(
      'creates scheduled rule with frequency, time, and optional limits',
      setUp: () {
        when(() => mockRepository.createAutoSaveRule(
              name: any(named: 'name'),
              description: any(named: 'description'),
              triggerType: any(named: 'triggerType'),
              amountType: any(named: 'amountType'),
              amountValue: any(named: 'amountValue'),
              sourceAccountId: any(named: 'sourceAccountId'),
              destinationAccountId: any(named: 'destinationAccountId'),
              frequency: any(named: 'frequency'),
              scheduleTime: any(named: 'scheduleTime'),
              scheduleDay: any(named: 'scheduleDay'),
              roundUpTo: any(named: 'roundUpTo'),
              targetAmount: any(named: 'targetAmount'),
              minimumBalance: any(named: 'minimumBalance'),
              maximumPerSave: any(named: 'maximumPerSave'),
            )).thenAnswer((_) async => Right(_testRuleFixed));
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.createRule(
        name: 'Daily 500 Save',
        description: 'Save 500 Naira every day',
        triggerType: TriggerType.scheduled,
        amountType: AmountType.fixed,
        amountValue: 500.0,
        sourceAccountId: 'acct-src-001',
        destinationAccountId: 'acct-dst-001',
        frequency: ScheduleFrequency.daily,
        scheduleTime: '08:00',
        targetAmount: 50000.0,
        minimumBalance: 1000.0,
        maximumPerSave: 2000.0,
      ),
      wait: const Duration(seconds: 2),
      expect: () => [
        isA<AutoSaveRuleCreating>(),
        isA<AutoSaveRuleCreating>(),
        isA<AutoSaveRuleCreating>(),
        isA<AutoSaveRuleCreating>(),
        isA<AutoSaveRuleCreated>()
            .having((s) => s.rule.id, 'ruleId', 'rule-002')
            .having((s) => s.rule.frequency, 'freq', ScheduleFrequency.daily)
            .having((s) => s.rule.scheduleTime, 'time', '08:00')
            .having((s) => s.rule.targetAmount, 'target', 50000.0)
            .having((s) => s.rule.minimumBalance, 'minBal', 1000.0)
            .having((s) => s.rule.maximumPerSave, 'maxSave', 2000.0),
      ],
      verify: (_) {
        verify(() => mockRepository.createAutoSaveRule(
              name: 'Daily 500 Save',
              description: 'Save 500 Naira every day',
              triggerType: TriggerType.scheduled,
              amountType: AmountType.fixed,
              amountValue: 500.0,
              sourceAccountId: 'acct-src-001',
              destinationAccountId: 'acct-dst-001',
              frequency: ScheduleFrequency.daily,
              scheduleTime: '08:00',
              scheduleDay: null,
              roundUpTo: null,
              targetAmount: 50000.0,
              minimumBalance: 1000.0,
              maximumPerSave: 2000.0,
            )).called(1);
      },
    );
  });

  // =========================================================================
  // 2. GET RULES FLOW
  // =========================================================================

  group('Get AutoSave Rules', () {
    blocTest<AutoSaveCubit, AutoSaveState>(
      'emits Loading then RulesLoaded on success',
      setUp: () {
        when(() => mockRepository.getAutoSaveRules(
              accountId: any(named: 'accountId'),
              status: any(named: 'status'),
            )).thenAnswer((_) async => Right([_testRule, _testRuleFixed]));
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.getRules(),
      expect: () => [
        isA<AutoSaveLoading>(),
        isA<AutoSaveRulesLoaded>()
            .having((s) => s.rules.length, 'count', 2),
      ],
    );

    blocTest<AutoSaveCubit, AutoSaveState>(
      'emits Loading then Error on failure',
      setUp: () {
        when(() => mockRepository.getAutoSaveRules(
              accountId: any(named: 'accountId'),
              status: any(named: 'status'),
            )).thenAnswer((_) async => const Left(_serverFailure));
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.getRules(),
      expect: () => [
        isA<AutoSaveLoading>(),
        isA<AutoSaveError>(),
      ],
    );

    blocTest<AutoSaveCubit, AutoSaveState>(
      'emits empty list when user has no rules',
      setUp: () {
        when(() => mockRepository.getAutoSaveRules(
              accountId: any(named: 'accountId'),
              status: any(named: 'status'),
            )).thenAnswer((_) async => const Right([]));
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.getRules(),
      expect: () => [
        isA<AutoSaveLoading>(),
        isA<AutoSaveRulesLoaded>()
            .having((s) => s.rules.length, 'count', 0),
      ],
    );
  });

  // =========================================================================
  // 3. TOGGLE RULE FLOW (pause/resume)
  // =========================================================================

  group('Toggle AutoSave Rule', () {
    blocTest<AutoSaveCubit, AutoSaveState>(
      'pause: emits Loading then RuleUpdated with paused status',
      setUp: () {
        when(() => mockRepository.toggleAutoSaveRule(
              ruleId: 'rule-001',
              action: 'pause',
            )).thenAnswer((_) async => Right(_testRulePaused));
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.toggleRule(ruleId: 'rule-001', action: 'pause'),
      expect: () => [
        isA<AutoSaveLoading>(),
        isA<AutoSaveRuleUpdated>()
            .having((s) => s.rule.status, 'status', AutoSaveStatus.paused),
      ],
    );

    blocTest<AutoSaveCubit, AutoSaveState>(
      'resume: emits Loading then RuleUpdated with active status',
      setUp: () {
        when(() => mockRepository.toggleAutoSaveRule(
              ruleId: 'rule-001',
              action: 'resume',
            )).thenAnswer((_) async => Right(_testRule));
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.toggleRule(ruleId: 'rule-001', action: 'resume'),
      expect: () => [
        isA<AutoSaveLoading>(),
        isA<AutoSaveRuleUpdated>()
            .having((s) => s.rule.status, 'status', AutoSaveStatus.active),
      ],
    );

    blocTest<AutoSaveCubit, AutoSaveState>(
      'toggle failure emits AutoSaveError',
      setUp: () {
        when(() => mockRepository.toggleAutoSaveRule(
              ruleId: any(named: 'ruleId'),
              action: any(named: 'action'),
            )).thenAnswer((_) async => const Left(_serverFailure));
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.toggleRule(ruleId: 'rule-001', action: 'pause'),
      expect: () => [
        isA<AutoSaveLoading>(),
        isA<AutoSaveError>(),
      ],
    );
  });

  // =========================================================================
  // 4. MANUAL TRIGGER FLOW (with PIN verification)
  // =========================================================================

  group('Manual Trigger AutoSave', () {
    blocTest<AutoSaveCubit, AutoSaveState>(
      'emits step-by-step trigger states then TransactionTriggered on success',
      setUp: () {
        when(() => mockRepository.triggerAutoSave(
              ruleId: 'rule-001',
              customAmount: null,
              transactionPinToken: 'pin-token-abc',
            )).thenAnswer((_) async => Right(_testTransaction));
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.triggerSave(
        ruleId: 'rule-001',
        transactionPinToken: 'pin-token-abc',
      ),
      wait: const Duration(seconds: 2),
      expect: () => [
        // Step 1: Validate
        isA<AutoSaveTriggerProcessing>()
            .having((s) => s.currentStepIndex, 'step', 0),
        // Step 2: Execute
        isA<AutoSaveTriggerProcessing>()
            .having((s) => s.currentStepIndex, 'step', 1),
        // Step 3: Update
        isA<AutoSaveTriggerProcessing>()
            .having((s) => s.currentStepIndex, 'step', 2),
        // Step 4: Complete
        isA<AutoSaveTriggerProcessing>()
            .having((s) => s.currentStepIndex, 'step', 3),
        // Final: Transaction triggered
        isA<AutoSaveTransactionTriggered>()
            .having((s) => s.transaction.id, 'txnId', 'txn-001')
            .having((s) => s.transaction.amount, 'amount', 500.0)
            .having((s) => s.transaction.success, 'success', true),
      ],
      verify: (_) {
        verify(() => mockRepository.triggerAutoSave(
              ruleId: 'rule-001',
              customAmount: null,
              transactionPinToken: 'pin-token-abc',
            )).called(1);
      },
    );

    blocTest<AutoSaveCubit, AutoSaveState>(
      'trigger with custom amount passes correct amount',
      setUp: () {
        when(() => mockRepository.triggerAutoSave(
              ruleId: any(named: 'ruleId'),
              customAmount: any(named: 'customAmount'),
              transactionPinToken: any(named: 'transactionPinToken'),
            )).thenAnswer((_) async => Right(_testTransaction));
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.triggerSave(
        ruleId: 'rule-001',
        transactionPinToken: 'pin-token-abc',
        customAmount: 1000.0,
      ),
      wait: const Duration(seconds: 2),
      verify: (_) {
        verify(() => mockRepository.triggerAutoSave(
              ruleId: 'rule-001',
              customAmount: 1000.0,
              transactionPinToken: 'pin-token-abc',
            )).called(1);
      },
    );

    blocTest<AutoSaveCubit, AutoSaveState>(
      'trigger failure emits AutoSaveError after processing steps',
      setUp: () {
        when(() => mockRepository.triggerAutoSave(
              ruleId: any(named: 'ruleId'),
              customAmount: any(named: 'customAmount'),
              transactionPinToken: any(named: 'transactionPinToken'),
            )).thenAnswer(
                (_) async => const Left(_serverFailure));
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.triggerSave(
        ruleId: 'rule-001',
        transactionPinToken: 'pin-token-abc',
      ),
      wait: const Duration(seconds: 2),
      expect: () => [
        isA<AutoSaveTriggerProcessing>()
            .having((s) => s.currentStepIndex, 'step', 0),
        isA<AutoSaveTriggerProcessing>()
            .having((s) => s.currentStepIndex, 'step', 1),
        isA<AutoSaveError>()
            .having((s) => s.message, 'msg', 'Internal server error'),
      ],
    );
  });

  // =========================================================================
  // 5. UPDATE RULE FLOW
  // =========================================================================

  group('Update AutoSave Rule', () {
    final updatedRule = AutoSaveRuleEntity(
      id: 'rule-002',
      userId: 'user-123',
      name: 'Updated Rule Name',
      description: 'Updated description',
      triggerType: TriggerType.scheduled,
      amountType: AmountType.fixed,
      amountValue: 750.0,
      sourceAccountId: 'acct-src-001',
      destinationAccountId: 'acct-dst-001',
      status: AutoSaveStatus.active,
      frequency: ScheduleFrequency.weekly,
      scheduleTime: '09:00',
      createdAt: _now,
      updatedAt: _now,
      triggerCount: 5,
      totalSaved: 2500.0,
    );

    blocTest<AutoSaveCubit, AutoSaveState>(
      'emits Loading then RuleUpdated on success',
      setUp: () {
        when(() => mockRepository.updateAutoSaveRule(
              ruleId: any(named: 'ruleId'),
              name: any(named: 'name'),
              description: any(named: 'description'),
              amountType: any(named: 'amountType'),
              amountValue: any(named: 'amountValue'),
              frequency: any(named: 'frequency'),
              scheduleTime: any(named: 'scheduleTime'),
              scheduleDay: any(named: 'scheduleDay'),
              roundUpTo: any(named: 'roundUpTo'),
              targetAmount: any(named: 'targetAmount'),
              minimumBalance: any(named: 'minimumBalance'),
              maximumPerSave: any(named: 'maximumPerSave'),
            )).thenAnswer((_) async => Right(updatedRule));
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.updateRule(
        ruleId: 'rule-002',
        name: 'Updated Rule Name',
        amountValue: 750.0,
        frequency: ScheduleFrequency.weekly,
      ),
      expect: () => [
        isA<AutoSaveLoading>(),
        isA<AutoSaveRuleUpdated>()
            .having((s) => s.rule.name, 'name', 'Updated Rule Name')
            .having((s) => s.rule.amountValue, 'amount', 750.0),
      ],
    );
  });

  // =========================================================================
  // 6. DELETE RULE FLOW
  // =========================================================================

  group('Delete AutoSave Rule', () {
    blocTest<AutoSaveCubit, AutoSaveState>(
      'emits Loading then RuleDeleted on success',
      setUp: () {
        when(() => mockRepository.deleteAutoSaveRule(
              ruleId: 'rule-001',
            )).thenAnswer((_) async => const Right(true));
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.deleteRule(ruleId: 'rule-001'),
      expect: () => [
        isA<AutoSaveLoading>(),
        isA<AutoSaveRuleDeleted>()
            .having((s) => s.ruleId, 'id', 'rule-001'),
      ],
    );

    blocTest<AutoSaveCubit, AutoSaveState>(
      'delete failure emits AutoSaveError',
      setUp: () {
        when(() => mockRepository.deleteAutoSaveRule(
              ruleId: any(named: 'ruleId'),
            )).thenAnswer((_) async => const Left(_serverFailure));
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.deleteRule(ruleId: 'rule-001'),
      expect: () => [
        isA<AutoSaveLoading>(),
        isA<AutoSaveError>(),
      ],
    );
  });

  // =========================================================================
  // 7. STATISTICS FLOW
  // =========================================================================

  group('Get AutoSave Statistics', () {
    blocTest<AutoSaveCubit, AutoSaveState>(
      'emits Loading then StatisticsLoaded with correct values',
      setUp: () {
        when(() => mockRepository.getAutoSaveStatistics())
            .thenAnswer((_) async => Right(_testStatistics));
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.getStatistics(),
      expect: () => [
        isA<AutoSaveLoading>(),
        isA<AutoSaveStatisticsLoaded>()
            .having((s) => s.statistics.activeRulesCount, 'active', 2)
            .having((s) => s.statistics.totalSavedAllTime, 'total', 15000.0)
            .having(
                (s) => s.statistics.totalSavedThisMonth, 'month', 3000.0)
            .having((s) => s.statistics.totalSavedThisWeek, 'week', 1000.0)
            .having((s) => s.statistics.averageSaveAmount, 'avg', 500.0),
      ],
    );
  });

  // =========================================================================
  // 8. TRANSACTION HISTORY FLOW
  // =========================================================================

  group('Get AutoSave Transactions', () {
    blocTest<AutoSaveCubit, AutoSaveState>(
      'emits Loading then TransactionsLoaded',
      setUp: () {
        when(() => mockRepository.getAutoSaveTransactions(
              ruleId: any(named: 'ruleId'),
              accountId: any(named: 'accountId'),
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            )).thenAnswer((_) async => Right([_testTransaction]));
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.getTransactions(ruleId: 'rule-001'),
      expect: () => [
        isA<AutoSaveLoading>(),
        isA<AutoSaveTransactionsLoaded>()
            .having((s) => s.transactions.length, 'count', 1)
            .having(
                (s) => s.transactions.first.amount, 'amount', 500.0),
      ],
    );
  });

  // =========================================================================
  // 9. DASHBOARD LOAD (statistics + rules combined)
  // =========================================================================

  group('Dashboard Load', () {
    blocTest<AutoSaveCubit, AutoSaveState>(
      'emits Loading then DashboardLoaded with stats and rules',
      setUp: () {
        when(() => mockRepository.getAutoSaveStatistics())
            .thenAnswer((_) async => Right(_testStatistics));
        when(() => mockRepository.getAutoSaveRules(
              accountId: any(named: 'accountId'),
              status: any(named: 'status'),
            )).thenAnswer((_) async => Right([_testRule, _testRuleFixed]));
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.loadDashboard(),
      expect: () => [
        isA<AutoSaveLoading>(),
        isA<AutoSaveDashboardLoaded>()
            .having((s) => s.statistics.activeRulesCount, 'active', 2)
            .having((s) => s.rules.length, 'ruleCount', 2),
      ],
    );

    blocTest<AutoSaveCubit, AutoSaveState>(
      'dashboard fails if statistics call fails',
      setUp: () {
        when(() => mockRepository.getAutoSaveStatistics())
            .thenAnswer((_) async => const Left(_serverFailure));
        when(() => mockRepository.getAutoSaveRules(
              accountId: any(named: 'accountId'),
              status: any(named: 'status'),
            )).thenAnswer((_) async => Right([_testRule]));
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.loadDashboard(),
      expect: () => [
        isA<AutoSaveLoading>(),
        isA<AutoSaveError>(),
      ],
    );

    blocTest<AutoSaveCubit, AutoSaveState>(
      'dashboard fails if rules call fails',
      setUp: () {
        when(() => mockRepository.getAutoSaveStatistics())
            .thenAnswer((_) async => Right(_testStatistics));
        when(() => mockRepository.getAutoSaveRules(
              accountId: any(named: 'accountId'),
              status: any(named: 'status'),
            )).thenAnswer((_) async => const Left(_serverFailure));
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.loadDashboard(),
      expect: () => [
        isA<AutoSaveLoading>(),
        isA<AutoSaveError>(),
      ],
    );
  });

  // =========================================================================
  // 10. OPTIMISTIC TOGGLE (advanced UX flow)
  // =========================================================================

  group('Optimistic Toggle', () {
    blocTest<AutoSaveCubit, AutoSaveState>(
      'optimistic toggle with cache: shows immediate update then confirms',
      setUp: () {
        // First load rules into cache
        when(() => mockRepository.getAutoSaveRules(
              accountId: any(named: 'accountId'),
              status: any(named: 'status'),
            )).thenAnswer((_) async => Right([_testRule]));
        when(() => mockRepository.toggleAutoSaveRule(
              ruleId: 'rule-001',
              action: 'pause',
            )).thenAnswer((_) async => Right(_testRulePaused));
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) async {
        // Load rules first to populate cache
        await cubit.getRulesWithCache(forceRefresh: true);
        // Then optimistically toggle
        await cubit.toggleRuleOptimistic(ruleId: 'rule-001', action: 'pause');
      },
      expect: () => [
        // From getRulesWithCache
        isA<AutoSaveRulesLoadingState>(),
        isA<AutoSaveRulesLoadedState>()
            .having((s) => s.rules.length, 'count', 1),
        // From optimistic toggle
        isA<AutoSaveRuleTogglingState>()
            .having((s) => s.ruleId, 'id', 'rule-001'),
        // Optimistic update
        isA<AutoSaveRulesLoadedState>()
            .having(
                (s) => s.rules.first.status, 'status', AutoSaveStatus.paused),
        // Server confirmation
        isA<AutoSaveRuleToggleSuccess>()
            .having(
                (s) => s.rule.status, 'status', AutoSaveStatus.paused),
        // Refresh with confirmed data
        isA<AutoSaveRulesLoadedState>(),
      ],
    );

    blocTest<AutoSaveCubit, AutoSaveState>(
      'optimistic toggle reverts on failure',
      setUp: () {
        when(() => mockRepository.getAutoSaveRules(
              accountId: any(named: 'accountId'),
              status: any(named: 'status'),
            )).thenAnswer((_) async => Right([_testRule]));
        when(() => mockRepository.toggleAutoSaveRule(
              ruleId: 'rule-001',
              action: 'pause',
            )).thenAnswer((_) async => const Left(_serverFailure));
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) async {
        await cubit.getRulesWithCache(forceRefresh: true);
        await cubit.toggleRuleOptimistic(ruleId: 'rule-001', action: 'pause');
      },
      expect: () => [
        isA<AutoSaveRulesLoadingState>(),
        isA<AutoSaveRulesLoadedState>(),
        isA<AutoSaveRuleTogglingState>(),
        // Optimistic: paused
        isA<AutoSaveRulesLoadedState>()
            .having(
                (s) => s.rules.first.status, 'status', AutoSaveStatus.paused),
        // Reverted: error
        isA<AutoSaveError>(),
        // Reverted: back to active
        isA<AutoSaveRulesLoadedState>()
            .having(
                (s) => s.rules.first.status, 'status', AutoSaveStatus.active),
      ],
    );
  });

  // =========================================================================
  // 11. CACHE & FILTERING FLOW
  // =========================================================================

  group('Cache and Filtering', () {
    blocTest<AutoSaveCubit, AutoSaveState>(
      'search filters cached rules by name',
      setUp: () {
        when(() => mockRepository.getAutoSaveRules(
              accountId: any(named: 'accountId'),
              status: any(named: 'status'),
            )).thenAnswer((_) async => Right([_testRule, _testRuleFixed]));
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) async {
        await cubit.getRulesWithCache(forceRefresh: true);
        cubit.searchRules('Daily');
      },
      expect: () => [
        isA<AutoSaveRulesLoadingState>(),
        isA<AutoSaveRulesLoadedState>()
            .having((s) => s.rules.length, 'all', 2),
        // After search: only the "Daily 500 Save" rule matches
        isA<AutoSaveRulesLoadedState>()
            .having((s) => s.rules.length, 'filtered', 1)
            .having((s) => s.rules.first.name, 'name', 'Daily 500 Save'),
      ],
    );

    blocTest<AutoSaveCubit, AutoSaveState>(
      'sort by totalSaved descending',
      setUp: () {
        when(() => mockRepository.getAutoSaveRules(
              accountId: any(named: 'accountId'),
              status: any(named: 'status'),
            )).thenAnswer((_) async => Right([_testRule, _testRuleFixed]));
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) async {
        await cubit.getRulesWithCache(forceRefresh: true);
        cubit.sortRules(RuleSortOption.totalSavedDesc);
      },
      expect: () => [
        isA<AutoSaveRulesLoadingState>(),
        isA<AutoSaveRulesLoadedState>(),
        // After sort: rule-002 (2500 saved) should be first
        isA<AutoSaveRulesLoadedState>()
            .having((s) => s.rules.first.id, 'first', 'rule-002')
            .having((s) => s.rules.first.totalSaved, 'saved', 2500.0),
      ],
    );
  });

  // =========================================================================
  // 12. EDGE CASES
  // =========================================================================

  group('Edge Cases', () {
    blocTest<AutoSaveCubit, AutoSaveState>(
      'cubit does not emit after being closed',
      setUp: () {
        when(() => mockRepository.createAutoSaveRule(
              name: any(named: 'name'),
              description: any(named: 'description'),
              triggerType: any(named: 'triggerType'),
              amountType: any(named: 'amountType'),
              amountValue: any(named: 'amountValue'),
              sourceAccountId: any(named: 'sourceAccountId'),
              destinationAccountId: any(named: 'destinationAccountId'),
              frequency: any(named: 'frequency'),
              scheduleTime: any(named: 'scheduleTime'),
              scheduleDay: any(named: 'scheduleDay'),
              roundUpTo: any(named: 'roundUpTo'),
              targetAmount: any(named: 'targetAmount'),
              minimumBalance: any(named: 'minimumBalance'),
              maximumPerSave: any(named: 'maximumPerSave'),
            )).thenAnswer((_) async {
          // Simulate slow response
          await Future.delayed(const Duration(seconds: 1));
          return Right(_testRule);
        });
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) async {
        // Start creation then immediately close cubit (simulates screen pop)
        unawaited(cubit.createRule(
          name: 'Test',
          description: 'Test',
          triggerType: TriggerType.onDeposit,
          amountType: AmountType.fixed,
          amountValue: 100.0,
          sourceAccountId: 'src',
          destinationAccountId: 'dst',
        ));
        await Future.delayed(const Duration(milliseconds: 100));
        await cubit.close();
      },
      wait: const Duration(seconds: 3),
      // Should only see initial steps before close, no crash
      expect: () => [
        isA<AutoSaveRuleCreating>(),
      ],
    );

    test('entity helper methods work correctly', () {
      expect(_testRule.isActive, true);
      expect(_testRulePaused.isPaused, true);
      expect(_testRuleFixed.hasReachedGoal, false);

      final reachedGoal = AutoSaveRuleEntity(
        id: 'rule-goal',
        userId: 'user-123',
        name: 'Goal Reached',
        description: 'test',
        triggerType: TriggerType.scheduled,
        amountType: AmountType.fixed,
        amountValue: 500.0,
        sourceAccountId: 'src',
        destinationAccountId: 'dst',
        status: AutoSaveStatus.completed,
        targetAmount: 5000.0,
        createdAt: _now,
        updatedAt: _now,
        triggerCount: 10,
        totalSaved: 5000.0,
      );
      expect(reachedGoal.hasReachedGoal, true);
      expect(reachedGoal.progressPercentage, 100.0);
    });

    test('AutoSaveTransactionEntity stores correct amount in Naira', () {
      // The model fromProto divides by 100 (kobo -> Naira)
      // So by the time it reaches the entity, amount is in Naira
      expect(_testTransaction.amount, 500.0);
      expect(_testTransaction.success, true);
    });

    test('AutoSaveStatisticsEntity totals are in Naira', () {
      expect(_testStatistics.totalSavedAllTime, 15000.0);
      expect(_testStatistics.totalSavedThisMonth, 3000.0);
      expect(_testStatistics.averageSaveAmount, 500.0);
    });
  });
}

// Helper for fire-and-forget future
void unawaited(Future<void> future) {}
