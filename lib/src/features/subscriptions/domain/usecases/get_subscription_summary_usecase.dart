import 'package:dartz/dartz.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import 'package:lazervault/src/features/subscriptions/domain/entities/subscription_summary_entity.dart';
import 'package:lazervault/src/features/subscriptions/domain/repositories/i_subscription_repository.dart';

class GetSubscriptionSummaryUsecase {
  final ISubscriptionRepository repository;

  const GetSubscriptionSummaryUsecase(this.repository);

  Future<Either<Failure, SubscriptionSummaryEntity>> call() {
    return repository.getSubscriptionSummary();
  }
}
