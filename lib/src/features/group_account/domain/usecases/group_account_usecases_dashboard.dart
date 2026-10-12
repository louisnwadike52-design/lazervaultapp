part of 'group_account_usecases.dart';

/// Which kind of row a dashboard preference applies to. Mirrors the
/// server's closed vocabulary — a value outside it is rejected there, so
/// these constants are the only two the app may send.
class DashboardItemTypes {
  const DashboardItemTypes._();
  static const String group = 'group';
  static const String contribution = 'contribution';
}

class SetDashboardOrderParams {
  /// One of [DashboardItemTypes].
  final String itemType;

  /// The visible page in its new order, front to back.
  final List<String> orderedItemIds;

  /// The group whose contributions were reordered. Required for
  /// contributions, unused for groups.
  final String? scopeId;

  /// Rank of [orderedItemIds].first within the WHOLE list. Non-zero on page
  /// 2+, so reordering a later page does not renumber those rows to the
  /// front of the list.
  final int startIndex;

  const SetDashboardOrderParams({
    required this.itemType,
    required this.orderedItemIds,
    this.scopeId,
    this.startIndex = 0,
  });
}

class SetDashboardOrder extends UseCase<int, SetDashboardOrderParams> {
  final GroupAccountRepository repository;

  SetDashboardOrder(this.repository);

  @override
  Future<int> call(SetDashboardOrderParams params) {
    return repository.setDashboardOrder(
      itemType: params.itemType,
      orderedItemIds: params.orderedItemIds,
      scopeId: params.scopeId,
      startIndex: params.startIndex,
    );
  }
}

class DashboardItemParams {
  final String itemType;
  final String itemId;
  const DashboardItemParams({required this.itemType, required this.itemId});
}

/// The user-facing "delete": the row stops appearing on the caller's lists
/// and nothing leaves the database. Refused server-side while they are
/// still an active member — leave first, then clear it away.
class HideDashboardItem extends UseCase<void, DashboardItemParams> {
  final GroupAccountRepository repository;

  HideDashboardItem(this.repository);

  @override
  Future<void> call(DashboardItemParams params) {
    return repository.hideDashboardItem(
      itemType: params.itemType,
      itemId: params.itemId,
    );
  }
}

class UnhideDashboardItem extends UseCase<void, DashboardItemParams> {
  final GroupAccountRepository repository;

  UnhideDashboardItem(this.repository);

  @override
  Future<void> call(DashboardItemParams params) {
    return repository.unhideDashboardItem(
      itemType: params.itemType,
      itemId: params.itemId,
    );
  }
}

/// Start an esusu and freeze its roster.
///
/// Lives alongside the dashboard use cases rather than with the contribution
/// CRUD because it is a lifecycle transition, not an edit: it changes what
/// the schedulers will do, and after it the member list is no longer
/// editable at all.
class OpenContribution extends UseCase<Contribution, String> {
  final GroupAccountRepository repository;

  OpenContribution(this.repository);

  @override
  Future<Contribution> call(String contributionId) {
    return repository.openContribution(contributionId);
  }
}

/// What the caller is behind on, across every group they belong to.
///
/// Feeds the "cycles to pay" reminder. Read-only and cheap enough to call on
/// a screen open: one query, 90-day lookback, capped at 100 rows server-side.
class GetOverdueContributions extends UseCase<List<Contribution>, String> {
  final GroupAccountRepository repository;

  GetOverdueContributions(this.repository);

  @override
  Future<List<Contribution>> call(String userId) {
    return repository.getOverdueContributions(userId);
  }
}

class PageParams {
  final int page;
  final int pageSize;
  const PageParams({this.page = 1, this.pageSize = 5});
}

class GroupPageParams extends PageParams {
  final String groupId;
  const GroupPageParams({
    required this.groupId,
    super.page,
    super.pageSize,
  });
}

/// One page of the caller's groups.
class GetUserGroupsPage extends UseCase<PagedResult<GroupAccount>, PageParams> {
  final GroupAccountRepository repository;

  GetUserGroupsPage(this.repository);

  @override
  Future<PagedResult<GroupAccount>> call(PageParams params) {
    return repository.getUserGroupsPage(
      page: params.page,
      pageSize: params.pageSize,
    );
  }
}

/// One page of a group's contributions.
class GetGroupContributionsPage
    extends UseCase<PagedResult<Contribution>, GroupPageParams> {
  final GroupAccountRepository repository;

  GetGroupContributionsPage(this.repository);

  @override
  Future<PagedResult<Contribution>> call(GroupPageParams params) {
    return repository.getGroupContributionsPage(
      groupId: params.groupId,
      page: params.page,
      pageSize: params.pageSize,
    );
  }
}
