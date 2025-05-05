import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/account_summary_entity.dart';
 
abstract class IAccountSummaryRepository {
  Future<Either<Failure, List<AccountSummaryEntity>>> getAccountSummaries({
    required String userId, // User ID needed to fetch specific accounts
    String? accessToken, // Authentication token for API requests
  });
} 