import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/cache/cache_config.dart';
import '../../../../../core/cache/swr_cache_manager.dart';
import '../../domain/entities/crowdfund_entities.dart';
import '../../domain/usecases/crowdfund_usecases.dart';
import 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  final GetCrowdfundLeaderboardUseCase getCrowdfundLeaderboardUseCase;
  final SWRCacheManager? _cacheManager;

  LeaderboardSortBy _currentSortBy = LeaderboardSortBy.mostFunded;
  String? _currentCategory;
  Timer? _debounceTimer;

  LeaderboardCubit({
    required this.getCrowdfundLeaderboardUseCase,
    SWRCacheManager? cacheManager,
  })  : _cacheManager = cacheManager,
        super(const LeaderboardInitial());

  LeaderboardSortBy get currentSortBy => _currentSortBy;
  String? get currentCategory => _currentCategory;

  Future<void> loadLeaderboard({
    LeaderboardSortBy? sortBy,
    String? category,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      if (isClosed) return;

      if (sortBy != null) _currentSortBy = sortBy;
      _currentCategory = category;

      final cacheKey = 'crowdfund_leaderboard:${_currentSortBy.name}:${_currentCategory ?? ''}';

      if (_cacheManager != null) {
        emit(const LeaderboardLoading());

        await for (final result in _cacheManager!.get<List<LeaderboardEntry>>(
          key: cacheKey,
          fetcher: () => getCrowdfundLeaderboardUseCase(
            sortBy: _currentSortBy,
            category: _currentCategory,
            limit: limit,
            offset: offset,
          ),
          config: CacheConfig.leaderboard,
          serializer: (entries) =>
              jsonEncode(entries.map((e) => e.toJson()).toList()),
          deserializer: (json) => (jsonDecode(json) as List)
              .map((j) => LeaderboardEntry.fromJson(j as Map<String, dynamic>))
              .toList(),
        )) {
          if (isClosed) return;
          if (result.hasData) {
            emit(LeaderboardLoaded(
              entries: result.data!,
              sortBy: _currentSortBy,
              category: _currentCategory,
              isStale: result.isStale,
            ));
          } else if (result.hasError) {
            emit(LeaderboardError(result.error.toString()));
          }
        }
      } else {
        emit(const LeaderboardLoading());

        final entries = await getCrowdfundLeaderboardUseCase(
          sortBy: _currentSortBy,
          category: _currentCategory,
          limit: limit,
          offset: offset,
        );

        if (isClosed) return;
        emit(LeaderboardLoaded(
          entries: entries,
          sortBy: _currentSortBy,
          category: _currentCategory,
        ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(LeaderboardError(e.toString()));
    }
  }

  void changeSort(LeaderboardSortBy sortBy) {
    _currentSortBy = sortBy;
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      loadLeaderboard(sortBy: sortBy, category: _currentCategory);
    });
  }

  void changeCategory(String? category) {
    _currentCategory = category;
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      loadLeaderboard(sortBy: _currentSortBy, category: category);
    });
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
