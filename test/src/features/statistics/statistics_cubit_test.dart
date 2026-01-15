import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_state.dart';
import 'package:lazervault/src/features/statistics/data/statistics_repository.dart';
import 'package:lazervault/src/generated/statistics.pb.dart' as pb;

class MockStatisticsRepository extends Mock implements StatisticsRepository {}

void main() {
  late StatisticsCubit cubit;
  late MockStatisticsRepository mockRepository;

  setUp(() {
    mockRepository = MockStatisticsRepository();
    cubit = StatisticsCubit(repository: mockRepository);
  });

  tearDown(() {
    cubit.close();
  });

  group('StatisticsCubit', () {
    final testExpenses = [
      pb.ExpenseMessage()
        ..id = '1'
        ..amount = 100.0
        ..currency = 'USD'
        ..category = pb.ExpenseCategory.EXPENSE_CATEGORY_FOOD_DINING,
    ];

    final testBudgets = [
      pb.BudgetMessage()
        ..id = '1'
        ..name = 'Groceries'
        ..amount = 500.0
        ..currency = 'USD',
    ];

    test('initial state is StatisticsInitial', () {
      expect(cubit.state, isA<StatisticsInitial>());
    });

    blocTest<StatisticsCubit, StatisticsState>(
      'emits [StatisticsLoading, StatisticsLoaded] when loadStatistics succeeds',
      build: () {
        when(mockRepository.getExpenses(
          startDate: anyNamed('startDate'),
          endDate: anyNamed('endDate'),
        )).thenAnswer((_) async => testExpenses);
        when(mockRepository.getBudgets()).thenAnswer((_) async => testBudgets);
        when(mockRepository.getSpendingAnalytics(
          startDate: anyNamed('startDate'),
          endDate: anyNamed('endDate'),
        )).thenAnswer((_) async => pb.SpendingAnalytics());
        when(mockRepository.getCategoryBreakdown(
          startDate: anyNamed('startDate'),
          endDate: anyNamed('endDate'),
        )).thenAnswer((_) async => []);
        when(mockRepository.getBudgetProgress()).thenAnswer((_) async => []);
        when(mockRepository.getTrackedIncome(
          startDate: anyNamed('startDate'),
          endDate: anyNamed('endDate'),
        )).thenAnswer((_) async => 1000.0);
        when(mockRepository.getTrackedExpenditure(
          startDate: anyNamed('startDate'),
          endDate: anyNamed('endDate'),
        )).thenAnswer((_) async => 500.0);
        when(mockRepository.getTrackedIncomeBreakdown(
          startDate: anyNamed('startDate'),
          endDate: anyNamed('endDate'),
        )).thenAnswer((_) async => {});
        when(mockRepository.getTrackedExpenditureBreakdown(
          startDate: anyNamed('startDate'),
          endDate: anyNamed('endDate'),
        )).thenAnswer((_) async => {});
        when(mockRepository.getTrackedIncomeTransactions(
          startDate: anyNamed('startDate'),
          endDate: anyNamed('endDate'),
        )).thenAnswer((_) async => []);
        when(mockRepository.getTrackedExpenditureTransactions(
          startDate: anyNamed('startDate'),
          endDate: anyNamed('endDate'),
        )).thenAnswer((_) async => []);
        when(mockRepository.getComprehensiveFinancialSummary(
          startDate: anyNamed('startDate'),
          endDate: anyNamed('endDate'),
        )).thenAnswer((_) async => pb.ComprehensiveFinancialSummary());
        return cubit;
      },
      act: (cubit) => cubit.loadStatistics(
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 1, 31),
      ),
      expect: () => [
        isA<StatisticsLoading>(),
        isA<StatisticsLoaded>().having(
          (s) => s.expenses.length,
          'expenses',
          1,
        ),
      ],
    );

    blocTest<StatisticsCubit, StatisticsState>(
      'emits [StatisticsLoading, StatisticsError] when loadStatistics fails',
      build: () {
        when(mockRepository.getExpenses(
          startDate: anyNamed('startDate'),
          endDate: anyNamed('endDate'),
        )).thenThrow(Exception('Network error'));
        return cubit;
      },
      act: (cubit) => cubit.loadStatistics(
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 1, 31),
      ),
      expect: () => [
        isA<StatisticsLoading>(),
        isA<StatisticsError>().having(
          (s) => s.message,
          'message',
          'Exception: Network error',
        ),
      ],
    );

    blocTest<StatisticsCubit, StatisticsState>(
      'emits [ExpenseCreating, ExpenseCreated] when createExpense succeeds',
      build: () {
        when(mockRepository.createExpense(
          amount: anyNamed('amount'),
          currency: anyNamed('currency'),
          category: anyNamed('category'),
          transactionDate: anyNamed('transactionDate'),
        )).thenAnswer((_) async => testExpenses.first);
        return cubit;
      },
      act: (cubit) => cubit.createExpense(
        amount: 100.0,
        currency: 'USD',
        category: pb.ExpenseCategory.EXPENSE_CATEGORY_FOOD_DINING,
        transactionDate: DateTime.now(),
      ),
      expect: () => [
        isA<ExpenseCreating>(),
        isA<ExpenseCreated>(),
      ],
    );

    blocTest<StatisticsCubit, StatisticsState>(
      'emits [BudgetCreating, BudgetCreated] when createBudget succeeds',
      build: () {
        when(mockRepository.createBudget(
          name: anyNamed('name'),
          amount: anyNamed('amount'),
          currency: anyNamed('currency'),
          period: anyNamed('period'),
          startDate: anyNamed('startDate'),
          endDate: anyNamed('endDate'),
        )).thenAnswer((_) async => testBudgets.first);
        return cubit;
      },
      act: (cubit) => cubit.createBudget(
        name: 'Groceries',
        amount: 500.0,
        currency: 'USD',
        period: pb.BudgetPeriod.BUDGET_PERIOD_MONTHLY,
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 1, 31),
      ),
      expect: () => [
        isA<BudgetCreating>(),
        isA<BudgetCreated>(),
      ],
    );
  });

  group('StatisticsState', () {
    test('StatisticsLoaded copyWith creates new instance with updated fields', () {
      final now = DateTime.now();
      final state = StatisticsLoaded(
        startDate: now,
        endDate: now,
        expenses: [],
        budgets: [],
        trackedIncome: 1000.0,
        trackedExpenditure: 500.0,
      );

      final updated = state.copyWith(
        trackedIncome: 2000.0,
        isRefreshing: true,
      );

      expect(updated.trackedIncome, 2000.0);
      expect(updated.isRefreshing, true);
      expect(updated.trackedExpenditure, 500.0);
    });

    test('StatisticsLoaded props are correct', () {
      final now = DateTime.now();
      final state = StatisticsLoaded(
        startDate: now,
        endDate: now,
        trackedIncome: 1000.0,
        trackedExpenditure: 500.0,
      );

      expect(
        state.props,
        containsAll([
          [],
          [],
          null,
          [],
          [],
          now,
          now,
          null,
          false,
          [],
          1000.0,
          null,
          [],
          null,
          [],
          null,
          null,
          500.0,
          0.0,
          {},
          {},
          [],
          [],
          null,
        ]),
      );
    });
  });
}
