import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/kyc/domain/entities/kyc_tier_entity.dart';
import 'package:lazervault/src/features/kyc/domain/repositories/kyc_repository.dart';
import 'package:lazervault/src/features/kyc/presentation/cubits/kyc_cubit.dart';
import 'package:mocktail/mocktail.dart';

class _MockKYCRepository extends Mock implements KYCRepository {}

void main() {
  late _MockKYCRepository repo;

  setUp(() {
    repo = _MockKYCRepository();
  });

  blocTest<KYCCubit, KYCState>(
    'confirmVerification emits NameConfirmationRequired with reconciliation names',
    build: () {
      when(
        () => repo.confirmVerification(
          verificationId: any(named: 'verificationId'),
          provider: any(named: 'provider'),
          providerAuthCode: any(named: 'providerAuthCode'),
          metadata: any(named: 'metadata'),
        ),
      ).thenAnswer(
        (_) async => Right(
          ConfirmVerificationResult(
            success: true,
            status: KYCStatus.inProgress,
            currentTier: KYCTier.tier1,
            message: 'name_confirmation_required',
            bvnNameReconciliation: const BVNNameReconciliation(
              nameAction: 'confirm',
              nameMatchScore: 0.75,
              verifiedName: 'Jane Verified',
              profileName: 'Jane Profile',
            ),
          ),
        ),
      );
      return KYCCubit(repository: repo);
    },
    act: (cubit) => cubit.confirmVerification(
      verificationId: 'vid-1',
      provider: 'mono',
      providerAuthCode: 'auth-code',
    ),
    expect: () => [
      isA<KYCLoading>(),
      isA<NameConfirmationRequired>()
          .having((s) => s.verificationId, 'verificationId', 'vid-1')
          .having((s) => s.verifiedName, 'verifiedName', 'Jane Verified')
          .having((s) => s.profileName, 'profileName', 'Jane Profile')
          .having((s) => s.matchScore, 'matchScore', 0.75),
    ],
  );

  blocTest<KYCCubit, KYCState>(
    'confirmVerification emits VerificationConfirmed when no name confirmation',
    build: () {
      when(
        () => repo.confirmVerification(
          verificationId: any(named: 'verificationId'),
          provider: any(named: 'provider'),
          providerAuthCode: any(named: 'providerAuthCode'),
          metadata: any(named: 'metadata'),
        ),
      ).thenAnswer(
        (_) async => const Right(
          ConfirmVerificationResult(
            success: true,
            status: KYCStatus.approved,
            currentTier: KYCTier.tier2,
            message: 'ok',
          ),
        ),
      );
      return KYCCubit(repository: repo);
    },
    act: (cubit) => cubit.confirmVerification(
      verificationId: 'vid-2',
      provider: 'mono',
      providerAuthCode: 'auth-code',
    ),
    expect: () => [
      isA<KYCLoading>(),
      isA<VerificationConfirmed>(),
    ],
  );
}
