import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/cache/cache_config.dart';
import '../../../../../core/cache/swr_cache_manager.dart';
import 'package:lazervault/src/features/crowdfund/domain/entities/crowdfund_entities.dart';
import 'package:lazervault/src/features/crowdfund/domain/usecases/crowdfund_usecases.dart';
import 'package:lazervault/src/features/group_account/data/models/group_account_models.dart';
import 'package:lazervault/src/features/group_account/domain/usecases/group_account_usecases.dart';
import 'discovery_state.dart';

class DiscoveryCubit extends Cubit<DiscoveryState> {
  final ListCrowdfundsUseCase listCrowdfunds;
  final ListPublicGroups listPublicGroups;
  final GetPublicGroup getPublicGroup;
  final JoinPublicGroup joinPublicGroup;
  final SWRCacheManager? _cacheManager;

  bool _isJoining = false;

  DiscoveryCubit({
    required this.listCrowdfunds,
    required this.listPublicGroups,
    required this.getPublicGroup,
    required this.joinPublicGroup,
    SWRCacheManager? cacheManager,
  })  : _cacheManager = cacheManager,
        super(DiscoveryInitial());

  /// Load trending crowdfunds for the dashboard carousel.
  /// Fetches public crowdfunds sorted by "trending".
  Future<void> loadTrendingCrowdfunds({
    int page = 1,
    int pageSize = 10,
  }) async {
    if (isClosed) return;

    try {
      if (_cacheManager != null) {
        emit(const DiscoveryLoading(message: 'Loading trending crowdfunds...'));

        await for (final result in _cacheManager!.get<List<Crowdfund>>(
          key: 'trending_crowdfunds:$page:$pageSize',
          fetcher: () => listCrowdfunds(
            page: page,
            pageSize: pageSize,
            sortBy: 'trending',
            visibility: CrowdfundVisibility.public,
          ),
          config: CacheConfig.trendingCrowdfunds,
          serializer: (crowdfunds) =>
              jsonEncode(crowdfunds.map((c) => c.toJson()).toList()),
          deserializer: (json) => (jsonDecode(json) as List)
              .map((j) => Crowdfund.fromJson(j as Map<String, dynamic>))
              .toList(),
        )) {
          if (isClosed) return;
          if (result.hasData) {
            emit(TrendingCrowdfundsLoaded(
              crowdfunds: result.data!,
              isStale: result.isStale,
            ));
          } else if (result.hasError) {
            emit(DiscoveryError(result.error.toString()));
          }
        }
      } else {
        emit(const DiscoveryLoading(message: 'Loading trending crowdfunds...'));
        final crowdfunds = await listCrowdfunds(
          page: page,
          pageSize: pageSize,
          sortBy: 'trending',
          visibility: CrowdfundVisibility.public,
        );
        if (isClosed) return;
        emit(TrendingCrowdfundsLoaded(crowdfunds: crowdfunds));
      }
    } catch (e) {
      if (isClosed) return;
      emit(DiscoveryError('Failed to load trending crowdfunds: ${e.toString()}'));
    }
  }

  /// Load public groups for the dashboard carousel or full discovery screen.
  Future<void> loadPublicGroups({
    String? sortBy,
    String? search,
    int page = 1,
    int pageSize = 20,
  }) async {
    if (isClosed) return;

    try {
      if (_cacheManager != null && search == null) {
        emit(const DiscoveryLoading(message: 'Loading public groups...'));

        final cacheKey = 'public_groups:${sortBy ?? 'default'}:$page:$pageSize';

        await for (final result in _cacheManager!.get<List<GroupAccountModel>>(
          key: cacheKey,
          fetcher: () async {
            final groups = await listPublicGroups(
              page: page,
              pageSize: pageSize,
              sortBy: sortBy,
              searchQuery: search,
            );
            return groups.map((g) => GroupAccountModel.fromEntity(g)).toList();
          },
          config: CacheConfig.publicGroups,
          serializer: (groups) =>
              jsonEncode(groups.map((g) => g.toJson()).toList()),
          deserializer: (json) => (jsonDecode(json) as List)
              .map((j) => GroupAccountModel.fromJson(j as Map<String, dynamic>))
              .toList(),
        )) {
          if (isClosed) return;
          if (result.hasData) {
            emit(PublicGroupsLoaded(
              groups: result.data!,
              isStale: result.isStale,
            ));
          } else if (result.hasError) {
            emit(DiscoveryError(result.error.toString()));
          }
        }
      } else {
        emit(const DiscoveryLoading(message: 'Loading public groups...'));
        final groups = await listPublicGroups(
          page: page,
          pageSize: pageSize,
          sortBy: sortBy,
          searchQuery: search,
        );
        if (isClosed) return;
        emit(PublicGroupsLoaded(groups: groups));
      }
    } catch (e) {
      if (isClosed) return;
      emit(DiscoveryError('Failed to load public groups: ${e.toString()}'));
    }
  }

  /// Load details of a specific public group (for non-members viewing).
  Future<void> loadPublicGroupDetail(String groupId) async {
    if (isClosed) return;
    emit(const DiscoveryLoading(message: 'Loading group details...'));
    try {
      final detail = await getPublicGroup(groupId);
      if (isClosed) return;
      emit(PublicGroupDetailLoaded(detail));
    } catch (e) {
      if (isClosed) return;
      emit(DiscoveryError('Failed to load group details: ${e.toString()}'));
    }
  }

  /// Join a public group. On success, emits GroupJoinSuccess.
  Future<void> joinGroup(String groupId) async {
    if (isClosed || _isJoining) return;
    _isJoining = true;
    emit(const DiscoveryLoading(message: 'Joining group...'));
    try {
      final group = await joinPublicGroup(groupId);
      if (isClosed) return;
      await invalidatePublicGroupsCache();
      emit(GroupJoinSuccess(group: group));
    } catch (e) {
      if (isClosed) return;
      emit(DiscoveryError('Failed to join group: ${e.toString()}'));
    } finally {
      _isJoining = false;
    }
  }

  /// Invalidate the public groups cache (e.g. after joining a group).
  Future<void> invalidatePublicGroupsCache() async {
    await _cacheManager?.invalidatePattern('public_groups:');
  }
}
