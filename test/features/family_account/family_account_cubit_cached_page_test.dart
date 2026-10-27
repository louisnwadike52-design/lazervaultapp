// The family-accounts list must paint the last overview and the last pending
// invitations at once on re-open and refresh both behind; the loader is for
// a first load only.
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:lazervault/src/core/errors/failures.dart';
import 'package:lazervault/src/features/family_account/domain/entities/family_account_entities.dart';
import 'package:lazervault/src/features/family_account/domain/usecases/family_account_usecases.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_cubit.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_page_stores.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_state.dart';

class _GetAccounts extends Mock implements GetFamilyAccountsUseCase {}

class _GetAccount extends Mock implements GetFamilyAccountUseCase {}

class _Create extends Mock implements CreateFamilyAccountUseCase {}

class _AddMember extends Mock implements AddFamilyMemberUseCase {}

class _UpdateMember extends Mock implements UpdateFamilyMemberUseCase {}

class _RemoveMember extends Mock implements RemoveFamilyMemberUseCase {}

class _Accept extends Mock implements AcceptFamilyInvitationUseCase {}

class _Decline extends Mock implements DeclineFamilyInvitationUseCase {}

class _GetPending extends Mock implements GetPendingInvitationsUseCase {}

class _GetTx extends Mock implements GetFamilyTransactionsUseCase {}

class _Allocate extends Mock implements AllocateFundsUseCase {}

class _GenCard extends Mock implements GenerateMemberCardUseCase {}

class _Freeze extends Mock implements FreezeFamilyAccountUseCase {}

class _Unfreeze extends Mock implements UnfreezeFamilyAccountUseCase {}

class _Delete extends Mock implements DeleteFamilyAccountUseCase {}

class _Leave extends Mock implements LeaveFamilyAccountUseCase {}

class _Contribute extends Mock implements ProcessMemberContributionUseCase {}

class _Setup extends Mock implements SetupFamilyAccountUseCase {}

class _DistMode extends Mock implements UpdateFundDistributionModeUseCase {}

class _Settings extends Mock implements UpdateFamilySettingsUseCase {}

class _History extends Mock implements GetMyInvitationHistoryUseCase {}

class _Sent extends Mock implements GetSentInvitationsUseCase {}

void main() {
  late _GetAccounts getAccounts;
  late _GetPending getPending;

  FamilyAccountCubit build() => FamilyAccountCubit(
        getFamilyAccounts: getAccounts,
        getFamilyAccount: _GetAccount(),
        createFamilyAccount: _Create(),
        addFamilyMember: _AddMember(),
        updateFamilyMember: _UpdateMember(),
        removeFamilyMember: _RemoveMember(),
        acceptInvitationUseCase: _Accept(),
        declineInvitationUseCase: _Decline(),
        getPendingInvitations: getPending,
        getFamilyTransactions: _GetTx(),
        allocateFunds: _Allocate(),
        generateMemberCard: _GenCard(),
        freezeFamilyAccount: _Freeze(),
        unfreezeFamilyAccount: _Unfreeze(),
        deleteFamilyAccount: _Delete(),
        leaveFamilyAccount: _Leave(),
        processMemberContribution: _Contribute(),
        setupFamilyAccount: _Setup(),
        updateFundDistributionMode: _DistMode(),
        updateFamilySettings: _Settings(),
        getMyInvitationHistory: _History(),
        getSentInvitations: _Sent(),
      );

  FamilyAccountsOverview overview(int created) => FamilyAccountsOverview(
        accounts: const [],
        maxFamilyAccounts: 3,
        createdCount: created,
      );

  void stubAccounts(int created) => when(() => getAccounts(any()))
      .thenAnswer((_) async => Right(overview(created)));

  void stubPending() => when(() => getPending(any()))
      .thenAnswer((_) async => const Right(<PendingInvitation>[]));

  // Bloc delivers to stream listeners a microtask after emit.
  Future<void> tick() => Future<void>.delayed(Duration.zero);

  setUpAll(() {
    registerFallbackValue(const GetFamilyAccountsParams());
    registerFallbackValue(NoParams());
  });

  setUp(() {
    getAccounts = _GetAccounts();
    getPending = _GetPending();
    FamilyAccountPageStores.overview.clear();
    FamilyAccountPageStores.pendingInvitations.clear();
    FamilyAccountPageStores.userIdResolver = () => 'u1';
  });

  test('first load shows the loader, then remembers the overview', () async {
    stubAccounts(1);
    final cubit = build();
    final emitted = <FamilyAccountState>[];
    final sub = cubit.stream.listen(emitted.add);

    await cubit.loadFamilyAccounts();
    await tick();
    await sub.cancel();

    expect(emitted.first, isA<FamilyAccountLoading>());
    expect(emitted.last, isA<FamilyAccountsLoaded>());
    expect(FamilyAccountPageStores.peekOverview()!.createdCount, 1);
    await cubit.close();
  });

  test('a new cubit for the same user paints the remembered overview first',
      () async {
    stubAccounts(1);
    final first = build();
    await first.loadFamilyAccounts();
    await first.close();

    stubAccounts(2);
    final cubit = build();
    final emitted = <FamilyAccountState>[];
    final sub = cubit.stream.listen(emitted.add);
    final load = cubit.loadFamilyAccounts();
    // Synchronous: the remembered overview is emitted before the first await.
    expect(cubit.state, isA<FamilyAccountsLoaded>());
    expect((cubit.state as FamilyAccountsLoaded).createdCount, 1);
    await load;
    await tick();
    await sub.cancel();

    expect(emitted.whereType<FamilyAccountLoading>(), isEmpty);
    expect((cubit.state as FamilyAccountsLoaded).createdCount, 2,
        reason: 'the fresh overview replaces the remembered one in place');
    await cubit.close();
  });

  test('a failed refresh reports the error and keeps the remembered overview',
      () async {
    stubAccounts(1);
    final first = build();
    await first.loadFamilyAccounts();
    await first.close();

    when(() => getAccounts(any())).thenAnswer((_) async =>
        Left(ServerFailure(message: 'backend down', statusCode: 500)));
    final cubit = build();
    final emitted = <FamilyAccountState>[];
    final sub = cubit.stream.listen(emitted.add);
    await cubit.loadFamilyAccounts();
    await tick();
    await sub.cancel();

    expect(emitted.first, isA<FamilyAccountsLoaded>());
    expect(emitted.whereType<FamilyAccountLoading>(), isEmpty);
    // The screen keeps its rows and shows a snackbar; the store keeps the
    // answer for the next open.
    expect(emitted.last, isA<FamilyAccountError>());
    expect(FamilyAccountPageStores.peekOverview(), isNotNull);
    await cubit.close();
  });

  test('pending invitations follow the same shape', () async {
    stubPending();
    final first = build();
    final firstEmitted = <FamilyAccountState>[];
    final firstSub = first.stream.listen(firstEmitted.add);
    await first.loadPendingInvitations();
    await tick();
    await firstSub.cancel();
    expect(firstEmitted.first, isA<FamilyAccountLoading>());
    await first.close();

    final cubit = build();
    final emitted = <FamilyAccountState>[];
    final sub = cubit.stream.listen(emitted.add);
    await cubit.loadPendingInvitations();
    await tick();
    await sub.cancel();
    expect(emitted.whereType<FamilyAccountLoading>(), isEmpty);
    expect(emitted.first, isA<PendingInvitationsLoaded>());
    await cubit.close();
  });

  test('another user never sees the remembered overview', () async {
    stubAccounts(1);
    final first = build();
    await first.loadFamilyAccounts();
    await first.close();

    FamilyAccountPageStores.userIdResolver = () => 'u2';
    final cubit = build();
    final emitted = <FamilyAccountState>[];
    final sub = cubit.stream.listen(emitted.add);
    await cubit.loadFamilyAccounts();
    await tick();
    await sub.cancel();
    expect(emitted.first, isA<FamilyAccountLoading>());
    await cubit.close();
  });
}
