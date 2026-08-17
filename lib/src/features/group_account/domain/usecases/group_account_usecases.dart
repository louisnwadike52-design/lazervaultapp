import '../entities/group_entities.dart';
import '../repositories/group_account_repository.dart';
part 'group_account_usecases_group.dart';
part 'group_account_usecases_contribution.dart';
part 'group_account_usecases_stats_invites.dart';


// Base use case class
abstract class UseCase<T, Params> {
  Future<T> call(Params params);
}

class NoParams {}
