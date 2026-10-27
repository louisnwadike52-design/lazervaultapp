import 'package:lazervault/core/cache/session_page_store.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_state.dart';

/// Page one of the Auto-Save rules list plus what the screen paints with it.
///
/// `AutoSaveCubit` had a 5-minute in-cubit cache, but the cubit is a factory
/// registration, so every open of the rules screen started with an empty
/// cache and a shimmer. The snapshot lives here instead, outliving the cubit,
/// so a re-open paints the last page immediately while the fetch the screen
/// always made still runs behind it.
///
/// One snapshot per (user, filter|search|sort) scope: the page the backend
/// returned, the stats fetched alongside it, and the pagination flags the
/// list needs to keep scrolling. In memory only — the entities have no JSON
/// codec and a cold start can afford one shimmer.
class AutoSaveRulesSnapshot {
  const AutoSaveRulesSnapshot({
    required this.rules,
    required this.statistics,
    required this.hasMore,
    required this.totalCount,
  });

  final List<AutoSaveRuleEntity> rules;
  final AutoSaveStatisticsEntity? statistics;
  final bool hasMore;
  final int totalCount;
}

final SessionPageStore<AutoSaveRulesSnapshot> autoSaveRulesStore =
    SessionPageStore<AutoSaveRulesSnapshot>('autosave_rules');

/// Scope key: the three server-side parameters that change which rules a
/// page holds. Mirrors `getRulesWithCache`'s own cache-validity check.
String autoSaveRulesScope({
  AutoSaveStatus? filter,
  String? search,
  required RuleSortOption sort,
}) =>
    '${filter?.name ?? ''}|${search ?? ''}|${sort.name}';
