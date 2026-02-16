import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:lazervault/src/features/crowdfund/domain/entities/crowdfund_entities.dart';
import 'package:lazervault/src/features/crowdfund/domain/entities/notification_channel_entities.dart';
import 'package:lazervault/src/features/crowdfund/domain/repositories/crowdfund_repository.dart';
import 'package:lazervault/src/features/crowdfund/domain/usecases/crowdfund_usecases.dart';
import 'package:lazervault/src/features/crowdfund/presentation/cubit/crowdfund_cubit.dart';
import 'package:lazervault/src/features/crowdfund/presentation/cubit/crowdfund_state.dart';

// =============================================================================
// MOCKS
// =============================================================================

class MockCrowdfundRepository extends Mock implements CrowdfundRepository {}

// =============================================================================
// TEST DATA FIXTURES
// =============================================================================

final _testCreator = const CrowdfundCreator(
  userId: 1,
  username: 'johndoe',
  firstName: 'John',
  lastName: 'Doe',
  verified: true,
  facialRecognitionEnabled: false,
);

final _testCrowdfund = Crowdfund(
  id: 'cf-001',
  creatorUserId: 1,
  creator: _testCreator,
  title: 'Help Fund Medical Treatment',
  description: 'Raising funds for urgent medical treatment for a community member.',
  story: 'A detailed story about why this fundraiser is important.',
  crowdfundCode: 'CF-MED-001',
  targetAmount: 500000.0,
  currentAmount: 125000.0,
  currency: 'NGN',
  deadline: DateTime.now().add(const Duration(days: 30)),
  category: 'Medical',
  status: CrowdfundStatus.active,
  visibility: CrowdfundVisibility.public,
  donorCount: 15,
  progressPercentage: 25.0,
  createdAt: DateTime.now().subtract(const Duration(days: 5)),
  updatedAt: DateTime.now(),
);

final _testDonation = CrowdfundDonation(
  id: 'don-001',
  crowdfundId: 'cf-001',
  donorUserId: 2,
  donor: const CrowdfundDonor(
    userId: 2,
    displayName: 'Jane Smith',
    isAnonymous: false,
    isCreator: false,
  ),
  amount: 5000.0,
  currency: 'NGN',
  donationDate: DateTime.now(),
  status: DonationStatus.completed,
  transactionId: 'txn-12345',
  receiptId: 'rcpt-001',
  message: 'Wishing you a speedy recovery!',
  isAnonymous: false,
  paymentMethod: 'wallet',
);

final _testReceipt = CrowdfundReceipt(
  id: 'rcpt-001',
  donationId: 'don-001',
  crowdfundId: 'cf-001',
  crowdfundTitle: 'Help Fund Medical Treatment',
  donorUserId: 2,
  donorName: 'Jane Smith',
  amount: 5000.0,
  currency: 'NGN',
  donationDate: DateTime.now(),
  generatedAt: DateTime.now(),
  receiptNumber: 'LV-RCPT-20260215-001',
);

final _testStatistics = CrowdfundStatistics(
  crowdfundId: 'cf-001',
  totalRaised: 125000.0,
  targetAmount: 500000.0,
  progressPercentage: 25.0,
  donorCount: 15,
  averageDonation: 8333.33,
  largestDonation: 25000.0,
  daysRemaining: 30,
  isCompleted: false,
  createdAt: DateTime.now().subtract(const Duration(days: 5)),
);

final _testWithdrawalResult = const CrowdfundWithdrawalResult(
  crowdfundId: 'cf-001',
  amountWithdrawn: 50000.0,
  remainingBalance: 75000.0,
  destinationAccountId: 'acc-001',
  destinationNewBalance: 150000.0,
  message: 'Withdrawal successful',
);

final _testWalletBalance = const CampaignWalletBalance(
  crowdfundId: 'cf-001',
  campaignWalletId: 'cw-001',
  balance: 125000.0,
  availableBalance: 120000.0,
  currency: 'NGN',
);

// =============================================================================
// INTEGRATION TEST: COMPLETE CROWDFUND FLOW (FRONTEND USER JOURNEY)
// =============================================================================

void main() {
  setUpAll(() {
    registerFallbackValue(CrowdfundVisibility.public);
    registerFallbackValue(CrowdfundStatus.active);
    registerFallbackValue(NotificationChannelType.telegram);
    registerFallbackValue(NotificationChannelStatus.active);
    registerFallbackValue(NotificationEventType.newDonation);
    registerFallbackValue(DateTime.now());
  });

  late MockCrowdfundRepository mockRepository;
  late CrowdfundCubit cubit;

  // Use case instances (thin wrappers around repository)
  late CreateCrowdfundUseCase createCrowdfundUseCase;
  late GetCrowdfundUseCase getCrowdfundUseCase;
  late ListCrowdfundsUseCase listCrowdfundsUseCase;
  late SearchCrowdfundsUseCase searchCrowdfundsUseCase;
  late UpdateCrowdfundUseCase updateCrowdfundUseCase;
  late DeleteCrowdfundUseCase deleteCrowdfundUseCase;
  late MakeDonationUseCase makeDonationUseCase;
  late GetCrowdfundDonationsUseCase getCrowdfundDonationsUseCase;
  late GetUserDonationsUseCase getUserDonationsUseCase;
  late GenerateDonationReceiptUseCase generateDonationReceiptUseCase;
  late GetUserReceiptsUseCase getUserReceiptsUseCase;
  late GetCrowdfundStatisticsUseCase getCrowdfundStatisticsUseCase;
  late GetMyCrowdfundsUseCase getMyCrowdfundsUseCase;
  late WithdrawFromCrowdfundUseCase withdrawFromCrowdfundUseCase;
  late GetCampaignWalletBalanceUseCase getCampaignWalletBalanceUseCase;
  late ConnectNotificationChannelUseCase connectNotificationChannelUseCase;
  late DisconnectNotificationChannelUseCase disconnectNotificationChannelUseCase;
  late GetNotificationChannelsUseCase getNotificationChannelsUseCase;
  late UpdateNotificationChannelUseCase updateNotificationChannelUseCase;
  late TestNotificationChannelUseCase testNotificationChannelUseCase;

  setUp(() {
    mockRepository = MockCrowdfundRepository();

    // Initialize use cases from mock repository
    createCrowdfundUseCase = CreateCrowdfundUseCase(mockRepository);
    getCrowdfundUseCase = GetCrowdfundUseCase(mockRepository);
    listCrowdfundsUseCase = ListCrowdfundsUseCase(mockRepository);
    searchCrowdfundsUseCase = SearchCrowdfundsUseCase(mockRepository);
    updateCrowdfundUseCase = UpdateCrowdfundUseCase(mockRepository);
    deleteCrowdfundUseCase = DeleteCrowdfundUseCase(mockRepository);
    makeDonationUseCase = MakeDonationUseCase(mockRepository);
    getCrowdfundDonationsUseCase = GetCrowdfundDonationsUseCase(mockRepository);
    getUserDonationsUseCase = GetUserDonationsUseCase(mockRepository);
    generateDonationReceiptUseCase =
        GenerateDonationReceiptUseCase(mockRepository);
    getUserReceiptsUseCase = GetUserReceiptsUseCase(mockRepository);
    getCrowdfundStatisticsUseCase =
        GetCrowdfundStatisticsUseCase(mockRepository);
    getMyCrowdfundsUseCase = GetMyCrowdfundsUseCase(mockRepository);
    withdrawFromCrowdfundUseCase =
        WithdrawFromCrowdfundUseCase(mockRepository);
    getCampaignWalletBalanceUseCase =
        GetCampaignWalletBalanceUseCase(mockRepository);
    connectNotificationChannelUseCase =
        ConnectNotificationChannelUseCase(mockRepository);
    disconnectNotificationChannelUseCase =
        DisconnectNotificationChannelUseCase(mockRepository);
    getNotificationChannelsUseCase =
        GetNotificationChannelsUseCase(mockRepository);
    updateNotificationChannelUseCase =
        UpdateNotificationChannelUseCase(mockRepository);
    testNotificationChannelUseCase =
        TestNotificationChannelUseCase(mockRepository);

    cubit = CrowdfundCubit(
      createCrowdfundUseCase: createCrowdfundUseCase,
      getCrowdfundUseCase: getCrowdfundUseCase,
      listCrowdfundsUseCase: listCrowdfundsUseCase,
      searchCrowdfundsUseCase: searchCrowdfundsUseCase,
      updateCrowdfundUseCase: updateCrowdfundUseCase,
      deleteCrowdfundUseCase: deleteCrowdfundUseCase,
      makeDonationUseCase: makeDonationUseCase,
      getCrowdfundDonationsUseCase: getCrowdfundDonationsUseCase,
      getUserDonationsUseCase: getUserDonationsUseCase,
      generateDonationReceiptUseCase: generateDonationReceiptUseCase,
      getUserReceiptsUseCase: getUserReceiptsUseCase,
      getCrowdfundStatisticsUseCase: getCrowdfundStatisticsUseCase,
      getMyCrowdfundsUseCase: getMyCrowdfundsUseCase,
      withdrawFromCrowdfundUseCase: withdrawFromCrowdfundUseCase,
      getCampaignWalletBalanceUseCase: getCampaignWalletBalanceUseCase,
      connectNotificationChannelUseCase: connectNotificationChannelUseCase,
      disconnectNotificationChannelUseCase: disconnectNotificationChannelUseCase,
      getNotificationChannelsUseCase: getNotificationChannelsUseCase,
      updateNotificationChannelUseCase: updateNotificationChannelUseCase,
      testNotificationChannelUseCase: testNotificationChannelUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  // ===========================================================================
  // STEP 1: Browse Crowdfunds (Home Screen)
  //
  // User opens the crowdfund home screen. The app loads all active crowdfunds
  // via listCrowdfundsUseCase -> repository.listCrowdfunds -> gRPC ListCrowdfunds.
  // ===========================================================================

  group('Step 1: Browse Crowdfunds (Home Screen)', () {
    blocTest<CrowdfundCubit, CrowdfundState>(
      'loads crowdfunds list on home screen entry',
      setUp: () {
        when(() => mockRepository.listCrowdfunds(
              page: any(named: 'page'),
              pageSize: any(named: 'pageSize'),
              statusFilter: any(named: 'statusFilter'),
              categoryFilter: any(named: 'categoryFilter'),
              myCrowdfundsOnly: any(named: 'myCrowdfundsOnly'),
              sortBy: any(named: 'sortBy'),
              visibility: any(named: 'visibility'),
            )).thenAnswer((_) async => [_testCrowdfund]);
      },
      build: () => cubit,
      act: (cubit) => cubit.loadCrowdfunds(),
      expect: () => [
        isA<CrowdfundLoading>(),
        isA<CrowdfundLoaded>()
            .having((s) => s.crowdfunds.length, 'crowdfund count', 1)
            .having(
                (s) => s.crowdfunds.first.title, 'title', _testCrowdfund.title)
            .having((s) => s.crowdfunds.first.isActive, 'is active', true),
      ],
      verify: (_) {
        verify(() => mockRepository.listCrowdfunds(
              page: 1,
              pageSize: 20,
              statusFilter: null,
              categoryFilter: null,
              myCrowdfundsOnly: false,
              sortBy: null,
              visibility: null,
            )).called(1);
      },
    );

    blocTest<CrowdfundCubit, CrowdfundState>(
      'loads crowdfunds filtered by category',
      setUp: () {
        when(() => mockRepository.listCrowdfunds(
              page: any(named: 'page'),
              pageSize: any(named: 'pageSize'),
              statusFilter: any(named: 'statusFilter'),
              categoryFilter: 'Medical',
              myCrowdfundsOnly: any(named: 'myCrowdfundsOnly'),
              sortBy: any(named: 'sortBy'),
              visibility: any(named: 'visibility'),
            )).thenAnswer((_) async => [_testCrowdfund]);
      },
      build: () => cubit,
      act: (cubit) => cubit.loadCrowdfunds(categoryFilter: 'Medical'),
      expect: () => [
        isA<CrowdfundLoading>(),
        isA<CrowdfundLoaded>()
            .having((s) => s.crowdfunds.first.category, 'category', 'Medical'),
      ],
    );

    blocTest<CrowdfundCubit, CrowdfundState>(
      'handles empty crowdfunds list',
      setUp: () {
        when(() => mockRepository.listCrowdfunds(
              page: any(named: 'page'),
              pageSize: any(named: 'pageSize'),
              statusFilter: any(named: 'statusFilter'),
              categoryFilter: any(named: 'categoryFilter'),
              myCrowdfundsOnly: any(named: 'myCrowdfundsOnly'),
              sortBy: any(named: 'sortBy'),
              visibility: any(named: 'visibility'),
            )).thenAnswer((_) async => []);
      },
      build: () => cubit,
      act: (cubit) => cubit.loadCrowdfunds(),
      expect: () => [
        isA<CrowdfundLoading>(),
        isA<CrowdfundLoaded>()
            .having((s) => s.crowdfunds.length, 'empty list', 0),
      ],
    );

    blocTest<CrowdfundCubit, CrowdfundState>(
      'handles network error when loading crowdfunds',
      setUp: () {
        when(() => mockRepository.listCrowdfunds(
              page: any(named: 'page'),
              pageSize: any(named: 'pageSize'),
              statusFilter: any(named: 'statusFilter'),
              categoryFilter: any(named: 'categoryFilter'),
              myCrowdfundsOnly: any(named: 'myCrowdfundsOnly'),
              sortBy: any(named: 'sortBy'),
              visibility: any(named: 'visibility'),
            )).thenThrow(Exception('Network error'));
      },
      build: () => cubit,
      act: (cubit) => cubit.loadCrowdfunds(),
      expect: () => [
        isA<CrowdfundLoading>(),
        isA<CrowdfundError>()
            .having((s) => s.message, 'error message', contains('Network')),
      ],
    );
  });

  // ===========================================================================
  // STEP 2: Search Crowdfunds
  //
  // User types a search query. Debounced search calls searchCrowdfundsUseCase
  // -> repository.searchCrowdfunds -> gRPC SearchCrowdfunds.
  // ===========================================================================

  group('Step 2: Search Crowdfunds', () {
    blocTest<CrowdfundCubit, CrowdfundState>(
      'searches crowdfunds by query string',
      setUp: () {
        when(() => mockRepository.searchCrowdfunds(
              query: 'medical',
              limit: any(named: 'limit'),
            )).thenAnswer((_) async => [_testCrowdfund]);
      },
      build: () => cubit,
      act: (cubit) => cubit.searchCrowdfunds(query: 'medical'),
      expect: () => [
        isA<CrowdfundLoading>(),
        isA<CrowdfundLoaded>()
            .having((s) => s.crowdfunds.length, 'result count', 1),
      ],
    );

    blocTest<CrowdfundCubit, CrowdfundState>(
      'empty search query falls back to loadCrowdfunds',
      setUp: () {
        when(() => mockRepository.listCrowdfunds(
              page: any(named: 'page'),
              pageSize: any(named: 'pageSize'),
              statusFilter: any(named: 'statusFilter'),
              categoryFilter: any(named: 'categoryFilter'),
              myCrowdfundsOnly: any(named: 'myCrowdfundsOnly'),
              sortBy: any(named: 'sortBy'),
              visibility: any(named: 'visibility'),
            )).thenAnswer((_) async => [_testCrowdfund]);
      },
      build: () => cubit,
      act: (cubit) => cubit.searchCrowdfunds(query: ''),
      expect: () => [
        isA<CrowdfundLoading>(),
        isA<CrowdfundLoaded>(),
      ],
      verify: (_) {
        verifyNever(() => mockRepository.searchCrowdfunds(
              query: any(named: 'query'),
              limit: any(named: 'limit'),
            ));
      },
    );

    blocTest<CrowdfundCubit, CrowdfundState>(
      'handles search returning no results',
      setUp: () {
        when(() => mockRepository.searchCrowdfunds(
              query: 'nonexistent',
              limit: any(named: 'limit'),
            )).thenAnswer((_) async => []);
      },
      build: () => cubit,
      act: (cubit) => cubit.searchCrowdfunds(query: 'nonexistent'),
      expect: () => [
        isA<CrowdfundLoading>(),
        isA<CrowdfundLoaded>()
            .having((s) => s.crowdfunds.length, 'no results', 0),
      ],
    );
  });

  // ===========================================================================
  // STEP 3: View Crowdfund Details
  //
  // User taps a crowdfund card from the list. The app loads the full details
  // including recent donations and statistics via getCrowdfundUseCase,
  // getCrowdfundDonationsUseCase, getCrowdfundStatisticsUseCase.
  // ===========================================================================

  group('Step 3: View Crowdfund Details', () {
    blocTest<CrowdfundCubit, CrowdfundState>(
      'loads crowdfund details with donations and statistics',
      setUp: () {
        when(() => mockRepository.getCrowdfund('cf-001'))
            .thenAnswer((_) async => _testCrowdfund);
        when(() => mockRepository.getCrowdfundDonations(
              crowdfundId: 'cf-001',
              page: 1,
              pageSize: 50,
            )).thenAnswer((_) async => [_testDonation]);
        when(() => mockRepository.getCrowdfundStatistics('cf-001'))
            .thenAnswer((_) async => _testStatistics);
      },
      build: () => cubit,
      act: (cubit) => cubit.loadCrowdfundDetails('cf-001'),
      expect: () => [
        isA<CrowdfundLoading>(),
        isA<CrowdfundDetailsLoaded>()
            .having((s) => s.crowdfund.id, 'crowdfund id', 'cf-001')
            .having((s) => s.crowdfund.title, 'title',
                'Help Fund Medical Treatment')
            .having((s) => s.donations.length, 'donation count', 1)
            .having((s) => s.statistics?.donorCount, 'donor count', 15)
            .having((s) => s.statistics?.progressPercentage, 'progress', 25.0),
      ],
    );

    blocTest<CrowdfundCubit, CrowdfundState>(
      'loads details even when statistics fail (optional)',
      setUp: () {
        when(() => mockRepository.getCrowdfund('cf-001'))
            .thenAnswer((_) async => _testCrowdfund);
        when(() => mockRepository.getCrowdfundDonations(
              crowdfundId: 'cf-001',
              page: 1,
              pageSize: 50,
            )).thenAnswer((_) async => [_testDonation]);
        when(() => mockRepository.getCrowdfundStatistics('cf-001'))
            .thenThrow(Exception('Statistics service unavailable'));
      },
      build: () => cubit,
      act: (cubit) => cubit.loadCrowdfundDetails('cf-001'),
      expect: () => [
        isA<CrowdfundLoading>(),
        isA<CrowdfundDetailsLoaded>()
            .having((s) => s.crowdfund.id, 'crowdfund id', 'cf-001')
            .having((s) => s.donations.length, 'donation count', 1)
            .having((s) => s.statistics, 'statistics is null', null),
      ],
    );

    test('crowdfund entity computed properties work correctly', () {
      expect(_testCrowdfund.isActive, isTrue);
      expect(_testCrowdfund.isCompleted, isFalse);
      expect(_testCrowdfund.isPaused, isFalse);
      expect(_testCrowdfund.isCancelled, isFalse);
      expect(_testCrowdfund.hasDeadline, isTrue);
      expect(_testCrowdfund.isExpired, isFalse);
      expect(_testCrowdfund.daysRemaining, greaterThan(0));
      expect(_testCrowdfund.amountRemaining, equals(375000.0));
      expect(_testCrowdfund.isTargetReached, isFalse);
    });
  });

  // ===========================================================================
  // STEP 4: Create a Crowdfund Campaign
  //
  // User fills in the multi-step creation form (carousel): basic info,
  // category/deadline, story/media, social links, funding goal, review.
  // On submit -> createCrowdfundUseCase -> repository.createCrowdfund
  // -> gRPC CreateCrowdfund.
  // ===========================================================================

  group('Step 4: Create a Crowdfund Campaign', () {
    blocTest<CrowdfundCubit, CrowdfundState>(
      'creates crowdfund successfully with all fields',
      setUp: () {
        when(() => mockRepository.createCrowdfund(
              title: 'Help Fund Medical Treatment',
              description:
                  'Raising funds for urgent medical treatment for a community member.',
              story:
                  'A detailed story about why this fundraiser is important.',
              targetAmount: 500000.0,
              currency: 'NGN',
              deadline: any(named: 'deadline'),
              category: 'Medical',
              imageUrl: null,
              visibility: CrowdfundVisibility.public,
              metadata: any(named: 'metadata'),
            )).thenAnswer((_) async => _testCrowdfund);
      },
      build: () => cubit,
      act: (cubit) => cubit.createCrowdfund(
        title: 'Help Fund Medical Treatment',
        description:
            'Raising funds for urgent medical treatment for a community member.',
        story: 'A detailed story about why this fundraiser is important.',
        targetAmount: 500000.0,
        currency: 'NGN',
        deadline: DateTime.now().add(const Duration(days: 30)),
        category: 'Medical',
        visibility: CrowdfundVisibility.public,
      ),
      expect: () => [
        isA<CrowdfundLoading>(),
        isA<CrowdfundCreated>()
            .having((s) => s.crowdfund.id, 'crowdfund id', 'cf-001')
            .having(
                (s) => s.crowdfund.status, 'status', CrowdfundStatus.active),
      ],
    );

    blocTest<CrowdfundCubit, CrowdfundState>(
      'handles verification required error for unverified user',
      setUp: () {
        when(() => mockRepository.createCrowdfund(
              title: any(named: 'title'),
              description: any(named: 'description'),
              story: any(named: 'story'),
              targetAmount: any(named: 'targetAmount'),
              currency: any(named: 'currency'),
              deadline: any(named: 'deadline'),
              category: any(named: 'category'),
              imageUrl: any(named: 'imageUrl'),
              visibility: any(named: 'visibility'),
              metadata: any(named: 'metadata'),
            )).thenThrow(
                Exception('PermissionDenied: Only verified users can create'));
      },
      build: () => cubit,
      act: (cubit) => cubit.createCrowdfund(
        title: 'My Campaign',
        description: 'A test campaign description',
        story: '',
        targetAmount: 100000.0,
        currency: 'NGN',
        category: 'Medical',
        visibility: CrowdfundVisibility.public,
      ),
      expect: () => [
        isA<CrowdfundLoading>(),
        isA<CrowdfundError>()
            .having((s) => s.errorCode, 'error code', 'VERIFICATION_REQUIRED')
            .having((s) => s.message, 'message', contains('verified')),
      ],
    );
  });

  // ===========================================================================
  // STEP 5: Make a Donation (Payment Flow)
  //
  // This is the core payment flow that mimics the frontend journey:
  //   DonationPaymentScreen -> DonationProcessingScreen -> DonationReceiptScreen
  //
  // Flow: User selects amount + source account -> taps "Donate" ->
  //   cubit.makeDonation() -> 4-step processing:
  //     Step 1: Verifying donation
  //     Step 2: Processing payment (gRPC MakeDonation)
  //     Step 3: Updating crowdfund
  //     Step 4: Generating receipt
  //   -> DonationCompleted state -> navigate to receipt screen
  // ===========================================================================

  group('Step 5: Make a Donation (Full Payment Flow)', () {
    blocTest<CrowdfundCubit, CrowdfundState>(
      'completes donation flow with receipt generation',
      setUp: () {
        when(() => mockRepository.makeDonation(
              crowdfundId: 'cf-001',
              amount: 5000.0,
              message: 'Wishing you a speedy recovery!',
              isAnonymous: false,
              sourceAccountId: 1,
            )).thenAnswer((_) async => _testDonation);
        when(() => mockRepository.generateDonationReceipt('don-001'))
            .thenAnswer((_) async => _testReceipt);
      },
      build: () => cubit,
      act: (cubit) => cubit.makeDonation(
        crowdfundId: 'cf-001',
        amount: 5000.0,
        message: 'Wishing you a speedy recovery!',
        isAnonymous: false,
        sourceAccountId: 1,
      ),
      wait: const Duration(seconds: 3),
      expect: () => [
        // Step 1: Verifying donation
        isA<DonationProcessing>()
            .having((s) => s.step, 'step', 'Verifying donation')
            .having((s) => s.currentStepIndex, 'index', 1)
            .having((s) => s.totalSteps, 'total', 4),
        // Step 2: Processing payment (gRPC call happens here)
        isA<DonationProcessing>()
            .having((s) => s.step, 'step', 'Processing payment')
            .having((s) => s.currentStepIndex, 'index', 2),
        // Step 3: Updating crowdfund
        isA<DonationProcessing>()
            .having((s) => s.step, 'step', 'Updating crowdfund')
            .having((s) => s.currentStepIndex, 'index', 3),
        // Step 4: Generating receipt
        isA<DonationProcessing>()
            .having((s) => s.step, 'step', 'Generating receipt')
            .having((s) => s.currentStepIndex, 'index', 4),
        // Final: Donation completed with donation object and receipt
        isA<DonationCompleted>()
            .having((s) => s.donation.id, 'donation id', 'don-001')
            .having((s) => s.donation.amount, 'amount', 5000.0)
            .having((s) => s.donation.isCompleted, 'is completed', true)
            .having((s) => s.receipt, 'receipt not null', isNotNull)
            .having((s) => s.receipt?.receiptNumber, 'receipt number',
                'LV-RCPT-20260215-001'),
      ],
      verify: (_) {
        verify(() => mockRepository.makeDonation(
              crowdfundId: 'cf-001',
              amount: 5000.0,
              message: 'Wishing you a speedy recovery!',
              isAnonymous: false,
              sourceAccountId: 1,
            )).called(1);
        verify(() => mockRepository.generateDonationReceipt('don-001'))
            .called(1);
      },
    );

    blocTest<CrowdfundCubit, CrowdfundState>(
      'completes anonymous donation without message',
      setUp: () {
        final anonymousDonation = CrowdfundDonation(
          id: 'don-002',
          crowdfundId: 'cf-001',
          donorUserId: 2,
          donor: const CrowdfundDonor(
            userId: 2,
            displayName: 'Anonymous',
            isAnonymous: true,
            isCreator: false,
          ),
          amount: 10000.0,
          currency: 'NGN',
          donationDate: DateTime.now(),
          status: DonationStatus.completed,
          isAnonymous: true,
          paymentMethod: 'wallet',
        );

        when(() => mockRepository.makeDonation(
              crowdfundId: 'cf-001',
              amount: 10000.0,
              message: null,
              isAnonymous: true,
              sourceAccountId: null,
            )).thenAnswer((_) async => anonymousDonation);
        when(() => mockRepository.generateDonationReceipt('don-002'))
            .thenThrow(Exception('Receipt generation failed'));
      },
      build: () => cubit,
      act: (cubit) => cubit.makeDonation(
        crowdfundId: 'cf-001',
        amount: 10000.0,
        isAnonymous: true,
      ),
      wait: const Duration(seconds: 3),
      expect: () => [
        isA<DonationProcessing>(),
        isA<DonationProcessing>(),
        isA<DonationProcessing>(),
        isA<DonationProcessing>(),
        // Donation completes even if receipt generation fails (optional)
        isA<DonationCompleted>()
            .having((s) => s.donation.isAnonymous, 'is anonymous', true)
            .having((s) => s.receipt, 'receipt is null (failed)', null),
      ],
    );

    blocTest<CrowdfundCubit, CrowdfundState>(
      'handles payment failure during donation',
      setUp: () {
        when(() => mockRepository.makeDonation(
              crowdfundId: 'cf-001',
              amount: 5000.0,
              message: any(named: 'message'),
              isAnonymous: any(named: 'isAnonymous'),
              sourceAccountId: any(named: 'sourceAccountId'),
            )).thenThrow(Exception('Insufficient balance'));
      },
      build: () => cubit,
      act: (cubit) => cubit.makeDonation(
        crowdfundId: 'cf-001',
        amount: 5000.0,
      ),
      wait: const Duration(seconds: 2),
      expect: () => [
        // Step 1 emits before the error
        isA<DonationProcessing>(),
        // Step 2 starts but gRPC call fails
        isA<DonationProcessing>(),
        // Error state
        isA<CrowdfundError>()
            .having((s) => s.message, 'error', contains('Insufficient')),
      ],
    );

    test('donation entity status helpers work correctly', () {
      expect(_testDonation.isCompleted, isTrue);
      expect(_testDonation.isPending, isFalse);
      expect(_testDonation.isProcessing, isFalse);
      expect(_testDonation.isFailed, isFalse);

      // Test pending donation
      final pendingDonation = CrowdfundDonation(
        id: 'don-pending',
        crowdfundId: 'cf-001',
        donorUserId: 2,
        donor: const CrowdfundDonor(
          userId: 2,
          displayName: 'Test',
          isAnonymous: false,
          isCreator: false,
        ),
        amount: 1000.0,
        currency: 'NGN',
        donationDate: DateTime.now(),
        status: DonationStatus.pending,
        isAnonymous: false,
        paymentMethod: 'wallet',
      );
      expect(pendingDonation.isPending, isTrue);
      expect(pendingDonation.isCompleted, isFalse);

      // Test processing donation
      final processingDonation = CrowdfundDonation(
        id: 'don-processing',
        crowdfundId: 'cf-001',
        donorUserId: 2,
        donor: const CrowdfundDonor(
          userId: 2,
          displayName: 'Test',
          isAnonymous: false,
          isCreator: false,
        ),
        amount: 1000.0,
        currency: 'NGN',
        donationDate: DateTime.now(),
        status: DonationStatus.processing,
        isAnonymous: false,
        paymentMethod: 'wallet',
      );
      expect(processingDonation.isProcessing, isTrue);
      expect(processingDonation.isCompleted, isFalse);
    });
  });

  // ===========================================================================
  // STEP 6: View Donation History
  //
  // User navigates to their donation history. The cubit loads all past
  // donations via getUserDonationsUseCase.
  // ===========================================================================

  group('Step 6: View User Donation History', () {
    blocTest<CrowdfundCubit, CrowdfundState>(
      'loads user donation history with pagination',
      setUp: () {
        when(() => mockRepository.getUserDonations(
              page: 1,
              pageSize: 20,
            )).thenAnswer((_) async => [_testDonation]);
      },
      build: () => cubit,
      act: (cubit) => cubit.loadUserDonations(),
      expect: () => [
        isA<CrowdfundLoading>(),
        isA<UserDonationsLoaded>()
            .having((s) => s.donations.length, 'donation count', 1)
            .having((s) => s.currentPage, 'page', 1),
      ],
    );
  });

  // ===========================================================================
  // STEP 7: Generate and View Receipt
  //
  // User taps "Generate Receipt" on a donation. Calls generateDonationReceiptUseCase
  // -> repository.generateDonationReceipt -> gRPC GenerateDonationReceipt.
  // Receipt screen shows: receipt number, donation ID, campaign, creator,
  // amount, date, transaction ID, payment method, status badge.
  // ===========================================================================

  group('Step 7: Generate and View Receipt', () {
    blocTest<CrowdfundCubit, CrowdfundState>(
      'generates receipt for a donation',
      setUp: () {
        when(() => mockRepository.generateDonationReceipt('don-001'))
            .thenAnswer((_) async => _testReceipt);
      },
      build: () => cubit,
      act: (cubit) => cubit.generateReceipt('don-001'),
      expect: () => [
        isA<CrowdfundLoading>(),
        isA<ReceiptGenerated>()
            .having((s) => s.receipt.receiptNumber, 'receipt number',
                'LV-RCPT-20260215-001')
            .having((s) => s.receipt.amount, 'amount', 5000.0)
            .having((s) => s.receipt.donorName, 'donor', 'Jane Smith'),
      ],
    );

    blocTest<CrowdfundCubit, CrowdfundState>(
      'loads user receipts list',
      setUp: () {
        when(() => mockRepository.getUserReceipts(
              page: 1,
              pageSize: 20,
            )).thenAnswer((_) async => [_testReceipt]);
      },
      build: () => cubit,
      act: (cubit) => cubit.loadUserReceipts(),
      expect: () => [
        isA<CrowdfundLoading>(),
        isA<UserReceiptsLoaded>()
            .having((s) => s.receipts.length, 'receipt count', 1),
      ],
    );
  });

  // ===========================================================================
  // STEP 8: View Campaign Statistics
  //
  // User views the statistics/insights for a campaign: total raised,
  // donor count, average donation, largest donation, days remaining.
  // ===========================================================================

  group('Step 8: View Campaign Statistics', () {
    blocTest<CrowdfundCubit, CrowdfundState>(
      'loads crowdfund statistics',
      setUp: () {
        when(() => mockRepository.getCrowdfundStatistics('cf-001'))
            .thenAnswer((_) async => _testStatistics);
      },
      build: () => cubit,
      act: (cubit) => cubit.loadStatistics('cf-001'),
      expect: () => [
        isA<CrowdfundLoading>(),
        isA<StatisticsLoaded>()
            .having((s) => s.statistics.totalRaised, 'total raised', 125000.0)
            .having((s) => s.statistics.donorCount, 'donors', 15)
            .having(
                (s) => s.statistics.averageDonation, 'avg donation', 8333.33)
            .having(
                (s) => s.statistics.largestDonation, 'largest', 25000.0)
            .having((s) => s.statistics.isCompleted, 'not completed', false),
      ],
    );
  });

  // ===========================================================================
  // STEP 9: Update Crowdfund Campaign
  //
  // Creator updates their campaign (title, description, status, etc.) via
  // updateCrowdfundUseCase -> repository.updateCrowdfund -> gRPC UpdateCrowdfund.
  // ===========================================================================

  group('Step 9: Update Crowdfund Campaign', () {
    blocTest<CrowdfundCubit, CrowdfundState>(
      'updates crowdfund title and description',
      setUp: () {
        final updatedCrowdfund = Crowdfund(
          id: 'cf-001',
          creatorUserId: 1,
          creator: _testCreator,
          title: 'Updated Title',
          description: 'Updated description.',
          story: _testCrowdfund.story,
          crowdfundCode: _testCrowdfund.crowdfundCode,
          targetAmount: _testCrowdfund.targetAmount,
          currentAmount: _testCrowdfund.currentAmount,
          currency: _testCrowdfund.currency,
          deadline: _testCrowdfund.deadline,
          category: _testCrowdfund.category,
          status: CrowdfundStatus.active,
          visibility: _testCrowdfund.visibility,
          donorCount: _testCrowdfund.donorCount,
          progressPercentage: _testCrowdfund.progressPercentage,
          createdAt: _testCrowdfund.createdAt,
          updatedAt: DateTime.now(),
        );
        when(() => mockRepository.updateCrowdfund(
              crowdfundId: 'cf-001',
              title: 'Updated Title',
              description: 'Updated description.',
              story: any(named: 'story'),
              deadline: any(named: 'deadline'),
              status: any(named: 'status'),
              imageUrl: any(named: 'imageUrl'),
              metadata: any(named: 'metadata'),
            )).thenAnswer((_) async => updatedCrowdfund);
      },
      build: () => cubit,
      act: (cubit) => cubit.updateCrowdfund(
        crowdfundId: 'cf-001',
        title: 'Updated Title',
        description: 'Updated description.',
      ),
      expect: () => [
        isA<CrowdfundLoading>(),
        isA<CrowdfundUpdated>()
            .having((s) => s.crowdfund.title, 'updated title', 'Updated Title'),
      ],
    );

    blocTest<CrowdfundCubit, CrowdfundState>(
      'pauses a crowdfund campaign',
      setUp: () {
        final pausedCrowdfund = Crowdfund(
          id: 'cf-001',
          creatorUserId: 1,
          creator: _testCreator,
          title: _testCrowdfund.title,
          description: _testCrowdfund.description,
          story: _testCrowdfund.story,
          crowdfundCode: _testCrowdfund.crowdfundCode,
          targetAmount: _testCrowdfund.targetAmount,
          currentAmount: _testCrowdfund.currentAmount,
          currency: _testCrowdfund.currency,
          deadline: _testCrowdfund.deadline,
          category: _testCrowdfund.category,
          status: CrowdfundStatus.paused,
          visibility: _testCrowdfund.visibility,
          donorCount: _testCrowdfund.donorCount,
          progressPercentage: _testCrowdfund.progressPercentage,
          createdAt: _testCrowdfund.createdAt,
          updatedAt: DateTime.now(),
        );
        when(() => mockRepository.updateCrowdfund(
              crowdfundId: 'cf-001',
              title: any(named: 'title'),
              description: any(named: 'description'),
              story: any(named: 'story'),
              deadline: any(named: 'deadline'),
              status: CrowdfundStatus.paused,
              imageUrl: any(named: 'imageUrl'),
              metadata: any(named: 'metadata'),
            )).thenAnswer((_) async => pausedCrowdfund);
      },
      build: () => cubit,
      act: (cubit) => cubit.updateCrowdfund(
        crowdfundId: 'cf-001',
        status: CrowdfundStatus.paused,
      ),
      expect: () => [
        isA<CrowdfundLoading>(),
        isA<CrowdfundUpdated>()
            .having(
                (s) => s.crowdfund.status, 'status', CrowdfundStatus.paused)
            .having((s) => s.crowdfund.isPaused, 'is paused', true),
      ],
    );
  });

  // ===========================================================================
  // STEP 10: Delete Crowdfund Campaign
  //
  // Creator deletes their campaign. Calls deleteCrowdfundUseCase ->
  // repository.deleteCrowdfund -> gRPC DeleteCrowdfund. Then reloads the list.
  // ===========================================================================

  group('Step 10: Delete Crowdfund Campaign', () {
    blocTest<CrowdfundCubit, CrowdfundState>(
      'deletes crowdfund and reloads list',
      setUp: () {
        when(() => mockRepository.deleteCrowdfund('cf-001'))
            .thenAnswer((_) async {});
        when(() => mockRepository.listCrowdfunds(
              page: any(named: 'page'),
              pageSize: any(named: 'pageSize'),
              statusFilter: any(named: 'statusFilter'),
              categoryFilter: any(named: 'categoryFilter'),
              myCrowdfundsOnly: any(named: 'myCrowdfundsOnly'),
              sortBy: any(named: 'sortBy'),
              visibility: any(named: 'visibility'),
            )).thenAnswer((_) async => []);
      },
      build: () => cubit,
      act: (cubit) => cubit.deleteCrowdfund('cf-001'),
      expect: () => [
        isA<CrowdfundLoading>(), // Delete loading
        isA<CrowdfundLoading>(), // Reload loading
        isA<CrowdfundLoaded>()
            .having((s) => s.crowdfunds.length, 'empty after delete', 0),
      ],
      verify: (_) {
        verify(() => mockRepository.deleteCrowdfund('cf-001')).called(1);
      },
    );
  });

  // ===========================================================================
  // STEP 11: Campaign Wallet Operations (Creator)
  //
  // Creator manages their campaign wallet:
  //   1. View my campaigns (getMyCrowdfunds)
  //   2. Check wallet balance (getCampaignWalletBalance)
  //   3. Withdraw funds (withdrawFromCrowdfund with transaction PIN)
  // ===========================================================================

  group('Step 11: Campaign Wallet Operations', () {
    blocTest<CrowdfundCubit, CrowdfundState>(
      'loads creator\'s own campaigns',
      setUp: () {
        when(() => mockRepository.getMyCrowdfunds(
              page: 1,
              pageSize: 20,
              statusFilter: null,
            )).thenAnswer((_) async => [_testCrowdfund]);
      },
      build: () => cubit,
      act: (cubit) => cubit.loadMyCrowdfunds(),
      expect: () => [
        isA<CrowdfundLoading>(),
        isA<MyCrowdfundsLoaded>()
            .having((s) => s.crowdfunds.length, 'my campaigns', 1),
      ],
    );

    blocTest<CrowdfundCubit, CrowdfundState>(
      'loads campaign wallet balance',
      setUp: () {
        when(() => mockRepository.getCampaignWalletBalance('cf-001'))
            .thenAnswer((_) async => _testWalletBalance);
      },
      build: () => cubit,
      act: (cubit) => cubit.loadCampaignWalletBalance('cf-001'),
      expect: () => [
        isA<CrowdfundLoading>(),
        isA<CampaignWalletBalanceLoaded>()
            .having((s) => s.balance.balance, 'balance', 125000.0)
            .having(
                (s) => s.balance.availableBalance, 'available', 120000.0)
            .having((s) => s.balance.hasAvailableFunds, 'has funds', true)
            .having((s) => s.balance.currency, 'currency', 'NGN'),
      ],
    );

    blocTest<CrowdfundCubit, CrowdfundState>(
      'withdraws funds from campaign wallet with PIN verification',
      setUp: () {
        when(() => mockRepository.withdrawFromCrowdfund(
              crowdfundId: 'cf-001',
              amount: 50000.0,
              transactionPin: '1234',
              destinationAccountId: null,
              destinationAccountType: null,
            )).thenAnswer((_) async => _testWithdrawalResult);
      },
      build: () => cubit,
      act: (cubit) => cubit.withdrawFromCrowdfund(
        crowdfundId: 'cf-001',
        amount: 50000.0,
        transactionPin: '1234',
      ),
      expect: () => [
        isA<CrowdfundLoading>(),
        isA<WithdrawalCompleted>()
            .having((s) => s.result.amountWithdrawn, 'withdrawn', 50000.0)
            .having(
                (s) => s.result.remainingBalance, 'remaining', 75000.0)
            .having((s) => s.result.destinationNewBalance, 'new balance',
                150000.0)
            .having((s) => s.result.message, 'message',
                'Withdrawal successful'),
      ],
    );

    blocTest<CrowdfundCubit, CrowdfundState>(
      'handles withdrawal failure (wrong PIN)',
      setUp: () {
        when(() => mockRepository.withdrawFromCrowdfund(
              crowdfundId: 'cf-001',
              amount: 50000.0,
              transactionPin: '0000',
              destinationAccountId: any(named: 'destinationAccountId'),
              destinationAccountType: any(named: 'destinationAccountType'),
            )).thenThrow(Exception('Invalid transaction PIN'));
      },
      build: () => cubit,
      act: (cubit) => cubit.withdrawFromCrowdfund(
        crowdfundId: 'cf-001',
        amount: 50000.0,
        transactionPin: '0000',
      ),
      expect: () => [
        isA<CrowdfundLoading>(),
        isA<CrowdfundError>()
            .having((s) => s.message, 'error', contains('Invalid')),
      ],
    );
  });

  // ===========================================================================
  // STEP 12: Notification Channel Management
  //
  // Creator connects notification channels (Telegram, Discord, Slack) to get
  // real-time updates about donations, milestones, etc.
  // ===========================================================================

  group('Step 12: Notification Channel Management', () {
    final testChannel = NotificationChannel(
      id: 'ch-001',
      crowdfundId: 'cf-001',
      creatorUserId: '1',
      channelType: NotificationChannelType.telegram,
      channelName: 'My Campaign Updates',
      status: NotificationChannelStatus.active,
      enabledEvents: const [
        NotificationEventType.newDonation,
        NotificationEventType.milestoneReached,
        NotificationEventType.goalReached,
      ],
      preferences: NotificationPreferences.defaultPrefs(),
      notificationCount: 0,
      failureCount: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    blocTest<CrowdfundCubit, CrowdfundState>(
      'loads notification channels for a campaign',
      setUp: () {
        when(() => mockRepository.getNotificationChannels('cf-001'))
            .thenAnswer((_) async => [testChannel]);
      },
      build: () => cubit,
      act: (cubit) => cubit.loadNotificationChannels('cf-001'),
      expect: () => [
        isA<CrowdfundLoading>(),
        isA<NotificationChannelsLoaded>()
            .having((s) => s.channels.length, 'channel count', 1)
            .having((s) => s.channels.first.channelType, 'type',
                NotificationChannelType.telegram),
      ],
    );

    blocTest<CrowdfundCubit, CrowdfundState>(
      'connects a Telegram notification channel',
      setUp: () {
        when(() => mockRepository.connectNotificationChannel(
              crowdfundId: 'cf-001',
              channelType: NotificationChannelType.telegram,
              channelName: 'My Campaign Updates',
              telegramChatId: '-1001234567890',
              discordWebhookUrl: any(named: 'discordWebhookUrl'),
              discordServerName: any(named: 'discordServerName'),
              discordChannelName: any(named: 'discordChannelName'),
              slackWebhookUrl: any(named: 'slackWebhookUrl'),
              slackWorkspaceName: any(named: 'slackWorkspaceName'),
              slackChannelName: any(named: 'slackChannelName'),
              enabledEvents: any(named: 'enabledEvents'),
            )).thenAnswer((_) async => testChannel);
      },
      build: () => cubit,
      act: (cubit) => cubit.connectNotificationChannel(
        crowdfundId: 'cf-001',
        channelType: NotificationChannelType.telegram,
        channelName: 'My Campaign Updates',
        telegramChatId: '-1001234567890',
      ),
      expect: () => [
        isA<CrowdfundLoading>(),
        isA<NotificationChannelConnected>()
            .having((s) => s.channel.id, 'channel id', 'ch-001')
            .having((s) => s.channel.status, 'status',
                NotificationChannelStatus.active),
      ],
    );

    blocTest<CrowdfundCubit, CrowdfundState>(
      'tests a notification channel',
      setUp: () {
        when(() => mockRepository.testNotificationChannel('ch-001'))
            .thenAnswer((_) async => true);
      },
      build: () => cubit,
      act: (cubit) => cubit.testNotificationChannel('ch-001'),
      expect: () => [
        isA<NotificationChannelTested>()
            .having((s) => s.success, 'test passed', true)
            .having((s) => s.channelId, 'channel id', 'ch-001'),
      ],
    );

    blocTest<CrowdfundCubit, CrowdfundState>(
      'disconnects a notification channel',
      setUp: () {
        when(() => mockRepository.disconnectNotificationChannel('ch-001'))
            .thenAnswer((_) async {});
      },
      build: () => cubit,
      act: (cubit) => cubit.disconnectNotificationChannel('ch-001'),
      expect: () => [
        isA<CrowdfundLoading>(),
        isA<NotificationChannelDisconnected>()
            .having((s) => s.channelId, 'channel id', 'ch-001'),
      ],
    );
  });

  // ===========================================================================
  // STEP 13: Full End-to-End Journey (Sequential)
  //
  // Simulates the complete user journey as it happens on the frontend:
  //   1. Open crowdfund home -> browse campaigns
  //   2. Search for "medical"
  //   3. Tap campaign -> view details
  //   4. Make a donation -> processing -> receipt
  //   5. View donation history
  //   6. Creator: check wallet balance -> withdraw funds
  // ===========================================================================

  group('Step 13: Full End-to-End Sequential Journey', () {
    test('complete user flow from browse to donate to receipt', () async {
      // Setup all repository mocks for the complete journey
      when(() => mockRepository.listCrowdfunds(
            page: any(named: 'page'),
            pageSize: any(named: 'pageSize'),
            statusFilter: any(named: 'statusFilter'),
            categoryFilter: any(named: 'categoryFilter'),
            myCrowdfundsOnly: any(named: 'myCrowdfundsOnly'),
            sortBy: any(named: 'sortBy'),
            visibility: any(named: 'visibility'),
          )).thenAnswer((_) async => [_testCrowdfund]);

      when(() => mockRepository.searchCrowdfunds(
            query: 'medical',
            limit: any(named: 'limit'),
          )).thenAnswer((_) async => [_testCrowdfund]);

      when(() => mockRepository.getCrowdfund('cf-001'))
          .thenAnswer((_) async => _testCrowdfund);

      when(() => mockRepository.getCrowdfundDonations(
            crowdfundId: 'cf-001',
            page: any(named: 'page'),
            pageSize: any(named: 'pageSize'),
          )).thenAnswer((_) async => [_testDonation]);

      when(() => mockRepository.getCrowdfundStatistics('cf-001'))
          .thenAnswer((_) async => _testStatistics);

      when(() => mockRepository.makeDonation(
            crowdfundId: 'cf-001',
            amount: 5000.0,
            message: any(named: 'message'),
            isAnonymous: any(named: 'isAnonymous'),
            sourceAccountId: any(named: 'sourceAccountId'),
          )).thenAnswer((_) async => _testDonation);

      when(() => mockRepository.generateDonationReceipt('don-001'))
          .thenAnswer((_) async => _testReceipt);

      when(() => mockRepository.getUserDonations(
            page: any(named: 'page'),
            pageSize: any(named: 'pageSize'),
          )).thenAnswer((_) async => [_testDonation]);

      final states = <CrowdfundState>[];
      final subscription = cubit.stream.listen(states.add);

      // --- Journey Step 1: Browse crowdfunds ---
      await cubit.loadCrowdfunds();
      await Future.delayed(const Duration(milliseconds: 100));

      expect(states.last, isA<CrowdfundLoaded>());
      final loadedState = states.last as CrowdfundLoaded;
      expect(loadedState.crowdfunds.length, 1);
      expect(loadedState.crowdfunds.first.title, 'Help Fund Medical Treatment');

      // --- Journey Step 2: Search ---
      await cubit.searchCrowdfunds(query: 'medical');
      await Future.delayed(const Duration(milliseconds: 100));

      expect(states.last, isA<CrowdfundLoaded>());

      // --- Journey Step 3: View details ---
      await cubit.loadCrowdfundDetails('cf-001');
      await Future.delayed(const Duration(milliseconds: 100));

      expect(states.last, isA<CrowdfundDetailsLoaded>());
      final detailsState = states.last as CrowdfundDetailsLoaded;
      expect(detailsState.crowdfund.id, 'cf-001');
      expect(detailsState.donations.length, 1);
      expect(detailsState.statistics?.donorCount, 15);

      // --- Journey Step 4: Make donation ---
      await cubit.makeDonation(
        crowdfundId: 'cf-001',
        amount: 5000.0,
        message: 'Get well soon!',
        sourceAccountId: 1,
      );
      // Wait for all processing steps + delays
      await Future.delayed(const Duration(seconds: 3));

      expect(states.last, isA<DonationCompleted>());
      final donationState = states.last as DonationCompleted;
      expect(donationState.donation.id, 'don-001');
      expect(donationState.donation.amount, 5000.0);
      expect(donationState.donation.isCompleted, isTrue);
      expect(donationState.receipt?.receiptNumber, 'LV-RCPT-20260215-001');

      // --- Journey Step 5: View donation history ---
      await cubit.loadUserDonations();
      await Future.delayed(const Duration(milliseconds: 100));

      expect(states.last, isA<UserDonationsLoaded>());
      final historyState = states.last as UserDonationsLoaded;
      expect(historyState.donations.length, 1);

      // Verify all repository calls were made in the correct order
      verifyInOrder([
        () => mockRepository.listCrowdfunds(
              page: any(named: 'page'),
              pageSize: any(named: 'pageSize'),
              statusFilter: any(named: 'statusFilter'),
              categoryFilter: any(named: 'categoryFilter'),
              myCrowdfundsOnly: any(named: 'myCrowdfundsOnly'),
              sortBy: any(named: 'sortBy'),
              visibility: any(named: 'visibility'),
            ),
        () => mockRepository.searchCrowdfunds(
              query: 'medical',
              limit: any(named: 'limit'),
            ),
        () => mockRepository.getCrowdfund('cf-001'),
        () => mockRepository.getCrowdfundDonations(
              crowdfundId: 'cf-001',
              page: any(named: 'page'),
              pageSize: any(named: 'pageSize'),
            ),
        () => mockRepository.makeDonation(
              crowdfundId: 'cf-001',
              amount: 5000.0,
              message: any(named: 'message'),
              isAnonymous: any(named: 'isAnonymous'),
              sourceAccountId: any(named: 'sourceAccountId'),
            ),
        () => mockRepository.generateDonationReceipt('don-001'),
        () => mockRepository.getUserDonations(
              page: any(named: 'page'),
              pageSize: any(named: 'pageSize'),
            ),
      ]);

      await subscription.cancel();
    });
  });

  // ===========================================================================
  // STEP 14: Edge Cases and Error Handling
  // ===========================================================================

  group('Step 14: Edge Cases', () {
    test('CrowdfundStatus enum properties', () {
      // Active campaign
      final active = _testCrowdfund;
      expect(active.isActive, isTrue);
      expect(active.isCompleted, isFalse);

      // Completed campaign
      final completed = Crowdfund(
        id: 'cf-done',
        creatorUserId: 1,
        creator: _testCreator,
        title: 'Completed Campaign',
        description: 'Done',
        story: '',
        crowdfundCode: 'CF-DONE',
        targetAmount: 100000.0,
        currentAmount: 100000.0,
        currency: 'NGN',
        category: 'Medical',
        status: CrowdfundStatus.completed,
        visibility: CrowdfundVisibility.public,
        donorCount: 50,
        progressPercentage: 100.0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      expect(completed.isCompleted, isTrue);
      expect(completed.isTargetReached, isTrue);
      expect(completed.amountRemaining, 0.0);
    });

    test('expired campaign detection', () {
      final expired = Crowdfund(
        id: 'cf-expired',
        creatorUserId: 1,
        creator: _testCreator,
        title: 'Expired Campaign',
        description: 'Past deadline',
        story: '',
        crowdfundCode: 'CF-EXP',
        targetAmount: 100000.0,
        currentAmount: 50000.0,
        currency: 'NGN',
        deadline: DateTime.now().subtract(const Duration(days: 1)),
        category: 'Medical',
        status: CrowdfundStatus.active,
        visibility: CrowdfundVisibility.public,
        donorCount: 10,
        progressPercentage: 50.0,
        createdAt: DateTime.now().subtract(const Duration(days: 31)),
        updatedAt: DateTime.now(),
      );
      expect(expired.hasDeadline, isTrue);
      expect(expired.isExpired, isTrue);
      expect(expired.daysRemaining, lessThan(0));
    });

    test('campaign without deadline', () {
      final noDeadline = Crowdfund(
        id: 'cf-nodeadline',
        creatorUserId: 1,
        creator: _testCreator,
        title: 'No Deadline',
        description: 'Open ended',
        story: '',
        crowdfundCode: 'CF-ND',
        targetAmount: 100000.0,
        currentAmount: 0.0,
        currency: 'NGN',
        category: 'Community',
        status: CrowdfundStatus.active,
        visibility: CrowdfundVisibility.public,
        donorCount: 0,
        progressPercentage: 0.0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      expect(noDeadline.hasDeadline, isFalse);
      expect(noDeadline.isExpired, isFalse);
      expect(noDeadline.daysRemaining, 0);
    });

    test('wallet with no available funds', () {
      const emptyWallet = CampaignWalletBalance(
        crowdfundId: 'cf-001',
        campaignWalletId: 'cw-002',
        balance: 5000.0,
        availableBalance: 0.0,
        currency: 'NGN',
      );
      expect(emptyWallet.hasAvailableFunds, isFalse);
    });

    test('Crowdfund serialization roundtrip', () {
      final json = _testCrowdfund.toJson();
      final restored = Crowdfund.fromJson(json);
      expect(restored.id, _testCrowdfund.id);
      expect(restored.title, _testCrowdfund.title);
      expect(restored.targetAmount, _testCrowdfund.targetAmount);
      expect(restored.currentAmount, _testCrowdfund.currentAmount);
      expect(restored.status, _testCrowdfund.status);
      expect(restored.visibility, _testCrowdfund.visibility);
    });

    test('CrowdfundCreator serialization roundtrip', () {
      final json = _testCreator.toJson();
      final restored = CrowdfundCreator.fromJson(json);
      expect(restored.userId, _testCreator.userId);
      expect(restored.username, _testCreator.username);
      expect(restored.fullName, 'John Doe');
      expect(restored.displayName, 'johndoe');
      expect(restored.verified, isTrue);
    });

    blocTest<CrowdfundCubit, CrowdfundState>(
      'reset returns to initial state',
      build: () => cubit,
      act: (cubit) => cubit.reset(),
      expect: () => [isA<CrowdfundInitial>()],
    );
  });
}
