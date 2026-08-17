part of 'group_account_state.dart';

/// Activity logs loaded for a group
class GroupActivityLogsLoaded extends GroupAccountState {
  final List<ActivityLogEntry> logs;
  final String groupId;

  const GroupActivityLogsLoaded({
    required this.logs,
    required this.groupId,
  });

  @override
  List<Object?> get props => [logs, groupId];
}

/// Activity logs loaded for a contribution
class ContributionActivityLogsLoaded extends GroupAccountState {
  final List<ActivityLogEntry> logs;
  final String contributionId;

  const ContributionActivityLogsLoaded({
    required this.logs,
    required this.contributionId,
  });

  @override
  List<Object?> get props => [logs, contributionId];
}

/// Activity logs loading state
class ActivityLogsLoading extends GroupAccountState {
  const ActivityLogsLoading();
}

/// Report generation in progress
class GroupAccountReportLoading extends GroupAccountState {
  final String? message;

  const GroupAccountReportLoading({this.message});

  @override
  List<Object?> get props => [message];
}

/// Report generated successfully
class GroupAccountReportGenerated extends GroupAccountState {
  final GroupAccountReport report;
  final GroupAccount group;
  final List<Contribution> contributions;
  final String? groupUrl;

  const GroupAccountReportGenerated({
    required this.report,
    required this.group,
    required this.contributions,
    this.groupUrl,
  });

  @override
  List<Object?> get props => [report, group, contributions, groupUrl];
}

/// Report shared successfully
class GroupAccountReportShared extends GroupAccountState {
  final String? message;

  const GroupAccountReportShared({this.message});

  @override
  List<Object?> get props => [message];
}

/// Report share error
class GroupAccountReportShareError extends GroupAccountState {
  final String message;

  const GroupAccountReportShareError(this.message);

  @override
  List<Object?> get props => [message];
}
