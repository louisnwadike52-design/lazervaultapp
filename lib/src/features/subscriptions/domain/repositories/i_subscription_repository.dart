import 'package:dartz/dartz.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import 'package:lazervault/src/features/subscriptions/domain/entities/active_subscription_entity.dart';
import 'package:lazervault/src/features/subscriptions/domain/entities/subscription_summary_entity.dart';
import 'package:lazervault/src/features/subscriptions/domain/entities/subscription_spending_entity.dart';

abstract class ISubscriptionRepository {
  Future<Either<Failure, (List<ActiveSubscriptionEntity>, int)>>
      getActiveSubscriptions({
    String? type,
    int limit = 20,
    int offset = 0,
  });

  Future<Either<Failure, SubscriptionSummaryEntity>> getSubscriptionSummary();

  Future<Either<Failure, SubscriptionSpendingEntity>> getSubscriptionSpending({
    int months = 6,
  });
}
