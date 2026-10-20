import '../entities/group_entities.dart';
import '../repositories/group_account_repository.dart';
import 'package:lazervault/src/features/group_account/domain/contribution_round_state.dart';
part 'group_account_usecases_group.dart';
part 'group_account_usecases_contribution.dart';
part 'group_account_usecases_stats_invites.dart';
part 'group_account_usecases_dashboard.dart';

// Base use case class
abstract class UseCase<T, Params> {
  Future<T> call(Params params);
}

class NoParams {}
