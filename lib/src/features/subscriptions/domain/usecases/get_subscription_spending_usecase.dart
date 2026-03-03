import 'package:dartz/dartz.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import 'package:lazervault/src/features/subscriptions/domain/entities/subscription_spending_entity.dart';
import 'package:lazervault/src/features/subscriptions/domain/repositories/i_subscription_repository.dart';

class GetSubscriptionSpendingUsecase {
  final ISubscriptionRepository repository;

  const GetSubscriptionSpendingUsecase(this.repository);

  Future<Either<Failure, SubscriptionSpendingEntity>> call({
    int months = 6,
  }) {
    return repository.getSubscriptionSpending(months: months);
  }
}
