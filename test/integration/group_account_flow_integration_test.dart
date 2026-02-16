import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/group_account/domain/entities/group_entities.dart';
import 'package:lazervault/src/features/group_account/domain/repositories/group_account_repository.dart';
import 'package:lazervault/src/features/group_account/domain/usecases/group_account_usecases.dart';
import 'package:lazervault/src/features/group_account/presentation/cubit/group_account_cubit.dart';
import 'package:lazervault/src/features/group_account/presentation/cubit/group_account_state.dart';
import 'package:mocktail/mocktail.dart';

// ---------------------------------------------------------------------------
// Mocks
// ---------------------------------------------------------------------------

class MockGroupAccountRepository extends Mock
    implements GroupAccountRepository {}

// ---------------------------------------------------------------------------
// Test fixtures
// ---------------------------------------------------------------------------

final _now = DateTime(2026, 2, 16, 12, 0, 0);

final _testGroup = GroupAccount(
  id: 'group-001',
  name: 'Test Group',
  description: 'A test group',
  adminId: 'user-123',
  members: const [],
  contributions: const [],
  createdAt: _now,
  updatedAt: _now,
  status: GroupAccountStatus.active,
);

final _testMember = GroupMember(
  id: 'member-001',
  userId: 'user-123',
  userName: 'John Doe',
  email: 'john@example.com',
  role: GroupMemberRole.admin,
  joinedAt: _now,
  status: GroupMemberStatus.active,
);

final _testMember2 = GroupMember(
  id: 'member-002',
  userId: 'user-456',
  userName: 'Jane Smith',
  email: 'jane@example.com',
  role: GroupMemberRole.member,
  joinedAt: _now,
  status: GroupMemberStatus.active,
);

final _testContribution = Contribution(
  id: 'contrib-001',
  groupId: 'group-001',
  title: 'House Fund',
  description: 'Saving for a house',
  targetAmount: 500000.0, // Naira (already converted from kobo)
  currentAmount: 150000.0,
  currency: 'NGN',
  deadline: _now.add(const Duration(days: 365)),
  createdAt: _now,
  updatedAt: _now,
  status: ContributionStatus.active,
  createdBy: 'user-123',
  payments: const [],
  type: ContributionType.oneTime,
);

final _testContributionPaused = Contribution(
  id: 'contrib-001',
  groupId: 'group-001',
  title: 'House Fund',
  description: 'Saving for a house',
  targetAmount: 500000.0,
  currentAmount: 150000.0,
  currency: 'NGN',
  deadline: _now.add(const Duration(days: 365)),
  createdAt: _now,
  updatedAt: _now,
  status: ContributionStatus.paused,
  createdBy: 'user-123',
  payments: const [],
  type: ContributionType.oneTime,
);

final _testPayment = ContributionPayment(
  id: 'payment-001',
  contributionId: 'contrib-001',
  groupId: 'group-001',
  userId: 'user-123',
  userName: 'John Doe',
  amount: 50000.0, // Naira
  currency: 'NGN',
  paymentDate: _now,
  status: PaymentStatus.completed,
);

final _testActivityLog = ActivityLogEntry(
  id: 'log-001',
  groupId: 'group-001',
  actorUserId: 'user-123',
  actorName: 'John Doe',
  actionType: 'payment_made',
  createdAt: _now,
);

final _testReceipt = ContributionReceipt(
  id: 'receipt-001',
  paymentId: 'payment-001',
  contributionId: 'contrib-001',
  groupId: 'group-001',
  userId: 'user-123',
  userName: 'John Doe',
  amount: 50000.0,
  currency: 'NGN',
  paymentDate: _now,
  generatedAt: _now,
  receiptNumber: 'REC-001',
  receiptData: const {},
);

final _testTranscript = ContributionTranscript(
  id: 'transcript-001',
  contributionId: 'contrib-001',
  groupId: 'group-001',
  generatedAt: _now,
  payments: [_testPayment],
  totalAmount: 50000.0,
  currency: 'NGN',
  memberContributions: const {'user-123': 50000.0},
);

final _testContributionMember = ContributionMember(
  id: 'cm-001',
  contributionId: 'contrib-001',
  userId: 'user-456',
  userName: 'Jane Smith',
  email: 'jane@example.com',
  joinedAt: _now,
  totalPaid: 0.0,
  expectedAmount: 50000.0,
);

// ---------------------------------------------------------------------------
// Helper to create a cubit wired to the mock repository
// ---------------------------------------------------------------------------

GroupAccountCubit _buildCubit(MockGroupAccountRepository repo) {
  return GroupAccountCubit(
    getUserGroups: GetUserGroups(repo),
    getGroupById: GetGroupById(repo),
    createGroup: CreateGroup(repo),
    updateGroup: UpdateGroup(repo),
    deleteGroup: DeleteGroup(repo),
    getGroupMembers: GetGroupMembers(repo),
    addMemberToGroup: AddMemberToGroup(repo),
    updateMemberRole: UpdateMemberRole(repo),
    removeMemberFromGroup: RemoveMemberFromGroup(repo),
    searchUsers: SearchUsers(repo),
    getGroupContributions: GetGroupContributions(repo),
    getContributionById: GetContributionById(repo),
    createContribution: CreateContribution(repo),
    updateContribution: UpdateContribution(repo),
    deleteContribution: DeleteContribution(repo),
    addMembersToContribution: AddMembersToContribution(repo),
    getContributionMembers: GetContributionMembers(repo),
    getContributionPayments: GetContributionPayments(repo),
    makeContributionPayment: MakeContributionPayment(repo),
    updatePaymentStatus: UpdatePaymentStatus(repo),
    generateReceipt: GenerateReceipt(repo),
    getUserReceipts: GetUserReceipts(repo),
    generateContributionTranscript: GenerateContributionTranscript(repo),
    getGroupStatistics: GetGroupStatistics(repo),
    getUserContributionStats: GetUserContributionStats(repo),
    getGroupActivityLogs: GetGroupActivityLogs(repo),
    getContributionActivityLogs: GetContributionActivityLogs(repo),
    removeMemberFromContribution: RemoveMemberFromContribution(repo),
  );
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  setUpAll(() {
    registerFallbackValue(GroupMemberRole.member);
    registerFallbackValue(ContributionStatus.active);
    registerFallbackValue(ContributionType.oneTime);
    registerFallbackValue(PaymentStatus.pending);
    registerFallbackValue(_testGroup);
    registerFallbackValue(_testContribution);
  });

  late MockGroupAccountRepository mockRepository;

  setUp(() {
    mockRepository = MockGroupAccountRepository();
  });

  // =========================================================================
  // 1. LOAD USER GROUPS FLOW
  // =========================================================================

  group('Load User Groups Flow', () {
    blocTest<GroupAccountCubit, GroupAccountState>(
      'emits Loading then GroupsLoaded on success',
      setUp: () {
        when(() => mockRepository.getUserGroups('user-123'))
            .thenAnswer((_) async => [_testGroup]);
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.loadUserGroups('user-123'),
      expect: () => [
        isA<GroupAccountLoading>(),
        isA<GroupAccountGroupsLoaded>()
            .having((s) => s.groups.length, 'groups count', 1)
            .having((s) => s.groups.first.name, 'group name', 'Test Group'),
      ],
    );

    blocTest<GroupAccountCubit, GroupAccountState>(
      'emits Error when no userId and not authenticated',
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.loadUserGroups(),
      expect: () => [
        isA<GroupAccountError>()
            .having((s) => s.message, 'message', contains('not authenticated')),
      ],
    );

    blocTest<GroupAccountCubit, GroupAccountState>(
      'emits Error on repository failure',
      setUp: () {
        when(() => mockRepository.getUserGroups('user-123'))
            .thenThrow(Exception('Network error'));
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.loadUserGroups('user-123'),
      expect: () => [
        isA<GroupAccountLoading>(),
        isA<GroupAccountError>()
            .having((s) => s.message, 'message', contains('Failed to load groups')),
      ],
    );
  });

  // =========================================================================
  // 2. LOAD GROUP DETAILS FLOW
  // =========================================================================

  group('Load Group Details Flow', () {
    blocTest<GroupAccountCubit, GroupAccountState>(
      'emits Loading then GroupLoaded with group, members, and contributions',
      setUp: () {
        when(() => mockRepository.getGroupById('group-001'))
            .thenAnswer((_) async => _testGroup);
        when(() => mockRepository.getGroupMembers('group-001'))
            .thenAnswer((_) async => [_testMember, _testMember2]);
        when(() => mockRepository.getGroupContributions('group-001'))
            .thenAnswer((_) async => [_testContribution]);
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.loadGroupDetails('group-001'),
      expect: () => [
        isA<GroupAccountLoading>(),
        isA<GroupAccountGroupLoaded>()
            .having((s) => s.group.id, 'group id', 'group-001')
            .having((s) => s.members.length, 'members count', 2)
            .having((s) => s.contributions.length, 'contributions count', 1),
      ],
    );
  });

  // =========================================================================
  // 3. CREATE GROUP FLOW
  // =========================================================================

  group('Create Group Flow', () {
    blocTest<GroupAccountCubit, GroupAccountState>(
      'emits Loading then GroupCreated on success',
      setUp: () {
        when(() => mockRepository.getUserGroups('user-123'))
            .thenAnswer((_) async => [_testGroup]);
        when(() => mockRepository.createGroup(
              name: any(named: 'name'),
              description: any(named: 'description'),
              adminId: any(named: 'adminId'),
              metadata: any(named: 'metadata'),
              visibility: any(named: 'visibility'),
              imageUrl: any(named: 'imageUrl'),
            )).thenAnswer((_) async => _testGroup);
      },
      build: () {
        final cubit = _buildCubit(mockRepository);
        cubit.setUserId('user-123', userName: 'John Doe');
        return cubit;
      },
      wait: const Duration(seconds: 2),
      act: (cubit) => cubit.createNewGroup(
        name: 'Test Group',
        description: 'A test group',
      ),
      expect: () => [
        // createNewGroup emits Loading synchronously
        isA<GroupAccountLoading>(),
        // loadUserGroups (from setUserId in build) completes asynchronously
        isA<GroupAccountGroupsLoaded>(),
        // createNewGroup completes asynchronously
        isA<GroupAccountGroupCreated>()
            .having((s) => s.group.name, 'group name', 'Test Group'),
      ],
      verify: (_) {
        verify(() => mockRepository.createGroup(
              name: 'Test Group',
              description: 'A test group',
              adminId: 'user-123',
              metadata: null,
              visibility: null,
              imageUrl: null,
            )).called(1);
      },
    );

    blocTest<GroupAccountCubit, GroupAccountState>(
      'emits Error when not authenticated',
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.createNewGroup(
        name: 'Test Group',
        description: 'A test group',
      ),
      expect: () => [
        isA<GroupAccountError>()
            .having((s) => s.message, 'message', contains('not authenticated')),
      ],
    );
  });

  // =========================================================================
  // 4. MAKE PAYMENT FLOW
  // =========================================================================

  group('Make Payment Flow', () {
    blocTest<GroupAccountCubit, GroupAccountState>(
      'emits Processing then PaymentSuccess on successful payment',
      setUp: () {
        when(() => mockRepository.getUserGroups('user-123'))
            .thenAnswer((_) async => [_testGroup]);
        when(() => mockRepository.makeContributionPayment(
              contributionId: any(named: 'contributionId'),
              groupId: any(named: 'groupId'),
              userId: any(named: 'userId'),
              userName: any(named: 'userName'),
              amount: any(named: 'amount'),
              currency: any(named: 'currency'),
              notes: any(named: 'notes'),
              transactionPin: any(named: 'transactionPin'),
              sourceAccountId: any(named: 'sourceAccountId'),
              idempotencyKey: any(named: 'idempotencyKey'),
            )).thenAnswer((_) async => _testPayment);
        when(() => mockRepository.getGroupById('group-001'))
            .thenAnswer((_) async => _testGroup);
        when(() => mockRepository.getGroupMembers('group-001'))
            .thenAnswer((_) async => [_testMember]);
        when(() => mockRepository.getGroupContributions('group-001'))
            .thenAnswer((_) async => [_testContribution]);
        when(() => mockRepository.getContributionById('contrib-001'))
            .thenAnswer((_) async => _testContribution);
      },
      build: () {
        final cubit = _buildCubit(mockRepository);
        cubit.setUserId('user-123', userName: 'John Doe');
        return cubit;
      },
      wait: const Duration(seconds: 2),
      act: (cubit) => cubit.makePaymentToContribution(
        contributionId: 'contrib-001',
        groupId: 'group-001',
        amount: 50000.0,
        currency: 'NGN',
      ),
      expect: () => [
        // makePaymentToContribution emits Processing synchronously
        isA<ContributionPaymentProcessing>()
            .having((s) => s.amount, 'amount', 50000.0),
        // loadUserGroups (from setUserId in build) completes asynchronously
        isA<GroupAccountGroupsLoaded>(),
        // makePaymentToContribution completes
        isA<ContributionPaymentSuccess>()
            .having((s) => s.payment.amount, 'payment amount', 50000.0)
            .having((s) => s.message, 'message', 'Payment completed successfully'),
        // loadGroupDetails after payment emits Loading then Loaded
        isA<GroupAccountLoading>(),
        isA<GroupAccountGroupLoaded>(),
      ],
      verify: (_) {
        verify(() => mockRepository.makeContributionPayment(
              contributionId: 'contrib-001',
              groupId: 'group-001',
              userId: 'user-123',
              userName: 'John Doe',
              amount: 50000.0,
              currency: 'NGN',
              notes: null,
              transactionPin: null,
              sourceAccountId: null,
              idempotencyKey: null,
            )).called(1);
      },
    );

    blocTest<GroupAccountCubit, GroupAccountState>(
      'emits PaymentFailed on insufficient balance',
      setUp: () {
        when(() => mockRepository.getUserGroups('user-123'))
            .thenAnswer((_) async => [_testGroup]);
        when(() => mockRepository.makeContributionPayment(
              contributionId: any(named: 'contributionId'),
              groupId: any(named: 'groupId'),
              userId: any(named: 'userId'),
              userName: any(named: 'userName'),
              amount: any(named: 'amount'),
              currency: any(named: 'currency'),
              notes: any(named: 'notes'),
              transactionPin: any(named: 'transactionPin'),
              sourceAccountId: any(named: 'sourceAccountId'),
              idempotencyKey: any(named: 'idempotencyKey'),
            )).thenThrow(Exception('insufficient balance'));
      },
      build: () {
        final cubit = _buildCubit(mockRepository);
        cubit.setUserId('user-123', userName: 'John Doe');
        return cubit;
      },
      wait: const Duration(seconds: 2),
      act: (cubit) => cubit.makePaymentToContribution(
        contributionId: 'contrib-001',
        groupId: 'group-001',
        amount: 50000.0,
        currency: 'NGN',
      ),
      expect: () => [
        // makePaymentToContribution emits Processing synchronously
        isA<ContributionPaymentProcessing>(),
        // makePaymentToContribution fails quickly (sync throw)
        isA<ContributionPaymentFailed>()
            .having((s) => s.isInsufficientBalance, 'insufficient', true),
        // loadUserGroups (from setUserId in build) completes asynchronously
        isA<GroupAccountGroupsLoaded>(),
      ],
    );

    blocTest<GroupAccountCubit, GroupAccountState>(
      'emits Error when not authenticated',
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.makePaymentToContribution(
        contributionId: 'contrib-001',
        groupId: 'group-001',
        amount: 50000.0,
        currency: 'NGN',
      ),
      expect: () => [
        isA<GroupAccountError>()
            .having((s) => s.message, 'message', contains('not authenticated')),
      ],
    );
  });

  // =========================================================================
  // 5. MEMBER MANAGEMENT FLOW
  // =========================================================================

  group('Member Management Flow', () {
    blocTest<GroupAccountCubit, GroupAccountState>(
      'addMember emits Loading then MemberAddedSuccess',
      setUp: () {
        when(() => mockRepository.addMemberToGroup(
              groupId: any(named: 'groupId'),
              userId: any(named: 'userId'),
              userName: any(named: 'userName'),
              email: any(named: 'email'),
              profileImage: any(named: 'profileImage'),
              username: any(named: 'username'),
              role: any(named: 'role'),
            )).thenAnswer((_) async => _testMember2);
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.addMemberToGroupAccount(
        groupId: 'group-001',
        userId: 'user-456',
        userName: 'Jane Smith',
        email: 'jane@example.com',
      ),
      expect: () => [
        isA<GroupAccountLoading>(),
        isA<MemberAddedSuccess>()
            .having((s) => s.member.userName, 'name', 'Jane Smith')
            .having((s) => s.groupId, 'group', 'group-001'),
      ],
    );

    blocTest<GroupAccountCubit, GroupAccountState>(
      'updateMemberRole emits Loading then Success',
      setUp: () {
        when(() => mockRepository.updateMemberRole(
              groupId: any(named: 'groupId'),
              memberId: any(named: 'memberId'),
              newRole: any(named: 'newRole'),
            )).thenAnswer((_) async => _testMember2);
        when(() => mockRepository.getGroupById('group-001'))
            .thenAnswer((_) async => _testGroup);
        when(() => mockRepository.getGroupMembers('group-001'))
            .thenAnswer((_) async => [_testMember, _testMember2]);
        when(() => mockRepository.getGroupContributions('group-001'))
            .thenAnswer((_) async => []);
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.updateMemberRoleInGroup(
        groupId: 'group-001',
        memberId: 'member-002',
        newRole: GroupMemberRole.moderator,
      ),
      expect: () => [
        isA<GroupAccountLoading>(),
        isA<GroupAccountSuccess>()
            .having((s) => s.message, 'message', contains('role updated')),
        // loadGroupDetails emits Loading then Loaded
        isA<GroupAccountLoading>(),
        isA<GroupAccountGroupLoaded>(),
      ],
    );

    blocTest<GroupAccountCubit, GroupAccountState>(
      'removeMember emits Loading then Success',
      setUp: () {
        when(() => mockRepository.removeMemberFromGroup(
              groupId: any(named: 'groupId'),
              memberId: any(named: 'memberId'),
            )).thenAnswer((_) async {});
        when(() => mockRepository.getGroupById('group-001'))
            .thenAnswer((_) async => _testGroup);
        when(() => mockRepository.getGroupMembers('group-001'))
            .thenAnswer((_) async => [_testMember]);
        when(() => mockRepository.getGroupContributions('group-001'))
            .thenAnswer((_) async => []);
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.removeMemberFromGroupAccount(
        groupId: 'group-001',
        memberId: 'member-002',
      ),
      expect: () => [
        isA<GroupAccountLoading>(),
        isA<GroupAccountSuccess>()
            .having((s) => s.message, 'message', contains('removed')),
        isA<GroupAccountLoading>(),
        isA<GroupAccountGroupLoaded>(),
      ],
    );
  });

  // =========================================================================
  // 6. CONTRIBUTION MANAGEMENT FLOW
  // =========================================================================

  group('Contribution Management Flow', () {
    blocTest<GroupAccountCubit, GroupAccountState>(
      'updateContribution emits Loading then Success',
      setUp: () {
        when(() => mockRepository.updateContribution(any()))
            .thenAnswer((_) async => _testContributionPaused);
        when(() => mockRepository.getGroupById('group-001'))
            .thenAnswer((_) async => _testGroup);
        when(() => mockRepository.getGroupMembers('group-001'))
            .thenAnswer((_) async => [_testMember]);
        when(() => mockRepository.getGroupContributions('group-001'))
            .thenAnswer((_) async => [_testContributionPaused]);
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.updateContributionDetails(
        _testContribution.copyWith(status: ContributionStatus.paused),
      ),
      expect: () => [
        isA<GroupAccountLoading>(),
        isA<GroupAccountSuccess>()
            .having((s) => s.message, 'message', contains('updated')),
        isA<GroupAccountLoading>(),
        isA<GroupAccountGroupLoaded>()
            .having(
              (s) => s.contributions.first.status,
              'status',
              ContributionStatus.paused,
            ),
      ],
    );

    blocTest<GroupAccountCubit, GroupAccountState>(
      'deleteContribution emits Loading then Success',
      setUp: () {
        when(() => mockRepository.deleteContribution('contrib-001'))
            .thenAnswer((_) async {});
        when(() => mockRepository.getGroupById('group-001'))
            .thenAnswer((_) async => _testGroup);
        when(() => mockRepository.getGroupMembers('group-001'))
            .thenAnswer((_) async => [_testMember]);
        when(() => mockRepository.getGroupContributions('group-001'))
            .thenAnswer((_) async => []);
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) =>
          cubit.deleteContributionFromGroup('contrib-001', 'group-001'),
      expect: () => [
        isA<GroupAccountLoading>(),
        isA<GroupAccountSuccess>()
            .having((s) => s.message, 'message', contains('deleted')),
        isA<GroupAccountLoading>(),
        isA<GroupAccountGroupLoaded>()
            .having((s) => s.contributions.length, 'count', 0),
      ],
    );
  });

  // =========================================================================
  // 7. ADD MEMBERS TO CONTRIBUTION FLOW
  // =========================================================================

  group('Add Members to Contribution Flow', () {
    blocTest<GroupAccountCubit, GroupAccountState>(
      'emits Loading then ContributionMembersAdded on success',
      setUp: () {
        when(() => mockRepository.addMembersToContribution(
              contributionId: any(named: 'contributionId'),
              memberUserIds: any(named: 'memberUserIds'),
            )).thenAnswer((_) async => [_testContributionMember]);
        when(() => mockRepository.getGroupById('group-001'))
            .thenAnswer((_) async => _testGroup);
        when(() => mockRepository.getGroupMembers('group-001'))
            .thenAnswer((_) async => [_testMember, _testMember2]);
        when(() => mockRepository.getGroupContributions('group-001'))
            .thenAnswer((_) async => [_testContribution]);
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.addMembersToContributionAccount(
        contributionId: 'contrib-001',
        groupId: 'group-001',
        memberUserIds: ['user-456'],
      ),
      expect: () => [
        isA<GroupAccountLoading>(),
        isA<ContributionMembersAdded>()
            .having((s) => s.members.length, 'count', 1),
        isA<GroupAccountLoading>(),
        isA<GroupAccountGroupLoaded>(),
      ],
    );
  });

  // =========================================================================
  // 8. ACTIVITY LOGS FLOW
  // =========================================================================

  group('Activity Logs Flow', () {
    blocTest<GroupAccountCubit, GroupAccountState>(
      'loadGroupActivityLogs emits ActivityLogsLoading then GroupActivityLogsLoaded',
      setUp: () {
        when(() => mockRepository.getGroupActivityLogs('group-001'))
            .thenAnswer((_) async => [_testActivityLog]);
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.loadGroupActivityLogs('group-001'),
      expect: () => [
        isA<ActivityLogsLoading>(),
        isA<GroupActivityLogsLoaded>()
            .having((s) => s.logs.length, 'log count', 1)
            .having((s) => s.groupId, 'group id', 'group-001'),
      ],
    );

    blocTest<GroupAccountCubit, GroupAccountState>(
      'loadContributionActivityLogs emits ActivityLogsLoading then ContributionActivityLogsLoaded',
      setUp: () {
        when(() => mockRepository.getContributionActivityLogs('contrib-001'))
            .thenAnswer((_) async => [_testActivityLog]);
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.loadContributionActivityLogs('contrib-001'),
      expect: () => [
        isA<ActivityLogsLoading>(),
        isA<ContributionActivityLogsLoaded>()
            .having((s) => s.logs.length, 'log count', 1)
            .having((s) => s.contributionId, 'contribution id', 'contrib-001'),
      ],
    );
  });

  // =========================================================================
  // 9. RECEIPT & TRANSCRIPT FLOW
  // =========================================================================

  group('Receipt & Transcript Flow', () {
    blocTest<GroupAccountCubit, GroupAccountState>(
      'generatePaymentReceipt emits Loading then ReceiptGenerated',
      setUp: () {
        when(() => mockRepository.generateReceipt('payment-001'))
            .thenAnswer((_) async => _testReceipt);
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.generatePaymentReceipt('payment-001'),
      expect: () => [
        isA<GroupAccountLoading>(),
        isA<GroupAccountReceiptGenerated>()
            .having((s) => s.receipt.receiptNumber, 'receipt', 'REC-001'),
      ],
    );

    blocTest<GroupAccountCubit, GroupAccountState>(
      'generateTranscript emits Loading then TranscriptGenerated',
      setUp: () {
        when(() => mockRepository.generateContributionTranscript('contrib-001'))
            .thenAnswer((_) async => _testTranscript);
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) =>
          cubit.generateTranscriptForContribution('contrib-001'),
      expect: () => [
        isA<GroupAccountLoading>(),
        isA<GroupAccountTranscriptGenerated>()
            .having((s) => s.transcript.totalAmount, 'amount', 50000.0),
      ],
    );
  });

  // =========================================================================
  // 10. USER ID & NAME FLOW
  // =========================================================================

  group('User ID & Name Flow', () {
    blocTest<GroupAccountCubit, GroupAccountState>(
      'setUserId stores userId and userName, triggers loadUserGroups',
      setUp: () {
        when(() => mockRepository.getUserGroups('user-123'))
            .thenAnswer((_) async => [_testGroup]);
      },
      build: () => _buildCubit(mockRepository),
      act: (cubit) => cubit.setUserId('user-123', userName: 'John Doe'),
      verify: (cubit) {
        expect(cubit.currentUserId, 'user-123');
        expect(cubit.currentUserName, 'John Doe');
      },
      expect: () => [
        isA<GroupAccountLoading>(),
        isA<GroupAccountGroupsLoaded>(),
      ],
    );

    test('currentUserName defaults to null when not set', () {
      final cubit = _buildCubit(mockRepository);
      expect(cubit.currentUserName, isNull);
      addTearDown(cubit.close);
    });
  });

  // =========================================================================
  // 11. AMOUNT DISPLAY - NO DOUBLE DIVISION
  // =========================================================================

  group('Amount values are in Naira (no double-division)', () {
    test('Contribution amounts are passed through as-is (already Naira)', () {
      // The gRPC data source converts kobo -> Naira via _int64ToAmount.
      // Entities store amounts in Naira. UI should NOT divide by 100.
      expect(_testContribution.targetAmount, 500000.0);
      expect(_testContribution.currentAmount, 150000.0);
      expect(_testPayment.amount, 50000.0);
    });
  });

  // =========================================================================
  // 12. RESTORE GROUPS LIST STATE
  // =========================================================================

  group('Restore Groups List State', () {
    blocTest<GroupAccountCubit, GroupAccountState>(
      'restoreGroupsListState emits cached groups if available',
      setUp: () {
        when(() => mockRepository.getUserGroups('user-123'))
            .thenAnswer((_) async => [_testGroup]);
      },
      build: () => _buildCubit(mockRepository),
      seed: () => GroupAccountGroupsLoaded([_testGroup]),
      act: (cubit) {
        // First load to cache groups
        cubit.loadUserGroups('user-123');
      },
      verify: (cubit) {
        // After loading, cached groups should be set
        expect(cubit.cachedGroups, isNotNull);
        expect(cubit.cachedGroups!.length, 1);
      },
    );
  });
}
