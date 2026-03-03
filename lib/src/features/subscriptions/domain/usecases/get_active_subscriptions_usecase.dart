import 'package:dartz/dartz.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import 'package:lazervault/src/features/subscriptions/domain/entities/active_subscription_entity.dart';
import 'package:lazervault/src/features/subscriptions/domain/repositories/i_subscription_repository.dart';

class GetActiveSubscriptionsUsecase {
  final ISubscriptionRepository repository;

  const GetActiveSubscriptionsUsecase(this.repository);

  Future<Either<Failure, (List<ActiveSubscriptionEntity>, int)>> call({
    String? type,
    int limit = 20,
    int offset = 0,
  }) {
    return repository.getActiveSubscriptions(
      type: type,
      limit: limit,
      offset: offset,
    );
  }
}
