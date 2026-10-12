part of 'group_account_cubit.dart';

/// Page-based paging for the two Group Funds lists, with prefetch.
///
/// WHY PAGE NUMBERS AND NOT INFINITE SCROLL
/// ----------------------------------------
/// A member asked for this because the dashboard had become a long scroll
/// they could not navigate. Five rows and a numbered pager means a known
/// position — "my groups are on page 1, the old ones are on page 3" — which
/// is the thing infinite scroll takes away.
///
/// WHY PREFETCH
/// ------------
/// Next is the button people press, and a page turn that waits on a network
/// round-trip is the slowest part of a list this short. The page after the
/// one being shown is fetched in the background and served from memory when
/// it is asked for.
///
/// The prefetch cache is deliberately tiny and deliberately dropped on every
/// refresh: it exists to make ONE tap instant, not to be a second source of
/// truth about what the user's groups are.
extension GroupFundsPaging on GroupAccountCubit {
  /// Rows per page. Five is what the user asked for, and it is also about
  /// as many cards as fit above the fold on a phone — a pager you have to
  /// scroll to reach defeats the point of having one.
  static const int pageSize = 5;

  // ── Groups ────────────────────────────────────────────────────────────

  /// Load one page of the caller's groups.
  ///
  /// Serves the prefetched page instantly when there is one. Emits
  /// [GroupAccountGroupsPageLoaded] on success; on failure keeps whatever
  /// is on screen and emits an error, because a failed page turn should not
  /// empty a list the user was reading.
  Future<void> loadGroupsPage(int page, {bool force = false}) async {
    if (isClosed) return;
    final usecase = getUserGroupsPage;
    if (usecase == null) {
      // No paged use case wired (older composition, tests). Fall back to the
      // unpaged load rather than showing an empty list.
      await loadUserGroups();
      return;
    }
    if (page < 1) page = 1;

    final cached = force ? null : groupsPrefetch[page];
    if (cached != null) {
      groupsPage = cached;
      emit(GroupAccountGroupsPageLoaded(cached));
      unawaited(_prefetchGroups(page + 1));
      return;
    }

    final generation = _sessionGeneration;
    // Only the FIRST load shows a spinner. A page turn keeps the current
    // page on screen until the next one lands, which is what makes paging
    // feel like paging rather than like reloading.
    if (groupsPage == null) {
      emit(const GroupAccountLoading(message: 'Loading groups...'));
    }
    try {
      final result = await usecase(PageParams(page: page, pageSize: pageSize));
      if (!_sessionStillCurrent(generation)) return;
      groupsPage = result;
      // Keep the flat cache in step so the stats tile and every other
      // consumer of `cachedGroups` sees this page's rows.
      _cachedGroups = result.items;
      emit(GroupAccountGroupsPageLoaded(result));
      if (page == 1) unawaited(_persistGroupsPage(result));
      unawaited(_prefetchGroups(page + 1));
    } catch (e) {
      if (!_sessionStillCurrent(generation)) return;
      emit(GroupAccountError(
          GroupAccountCubit._opError('Could not load that page', e)));
    }
  }

  Future<void> _prefetchGroups(int page) async {
    final usecase = getUserGroupsPage;
    if (usecase == null || isClosed) return;
    final current = groupsPage;
    // Nothing beyond the last page, and never re-fetch what we hold.
    if (current != null && page > current.totalPages) return;
    if (groupsPrefetch.containsKey(page)) return;

    final generation = _sessionGeneration;
    try {
      final result = await usecase(PageParams(page: page, pageSize: pageSize));
      if (!_sessionStillCurrent(generation)) return;
      // One page ahead only. Holding more would mean serving rows fetched
      // several taps ago as if they were current.
      groupsPrefetch
        ..clear()
        ..[page] = result;
    } catch (_) {
      // A prefetch is an optimisation. Its failure is the user waiting a
      // moment on the next tap, which is the behaviour without it.
    }
  }

  /// Paint the last-seen first page from disk, before the network answers.
  ///
  /// Returns true when something was painted, so the caller can skip its
  /// spinner. Silent on every failure: a cache miss is simply a cold start.
  Future<bool> hydrateGroupsFromCache() async {
    if (isClosed) return false;
    final userId = currentUserId;
    if (userId == null) return false;
    if (groupsPage != null) return false;

    final raw = await GroupFundsPageCache.readGroups(userId);
    if (raw == null || raw.isEmpty || isClosed || currentUserId != userId) {
      return false;
    }
    try {
      final items = raw
          .map<GroupAccount>((j) => GroupAccountModel.fromJson(j))
          .toList();
      final page = PagedResult<GroupAccount>(
        items: items,
        page: 1,
        pageSize: pageSize,
        totalItems: items.length,
        // One page until the server says otherwise. Claiming more would
        // draw a pager with buttons that lead nowhere.
        totalPages: 1,
      );
      groupsPage = page;
      _cachedGroups = items;
      emit(GroupAccountGroupsPageLoaded(page, fromCache: true));
      return true;
    } catch (e) {
      debugPrint('[GroupAccountCubit] cached groups unreadable: $e');
      return false;
    }
  }

  Future<void> _persistGroupsPage(PagedResult<GroupAccount> page) async {
    final userId = currentUserId;
    if (userId == null) return;
    await GroupFundsPageCache.writeGroups(
      userId,
      page.items
          .map((g) => GroupAccountModel.fromEntity(g).toJson())
          .toList(),
    );
  }

  // ── Contributions ─────────────────────────────────────────────────────

  Future<void> loadContributionsPage(
    String groupId,
    int page, {
    bool force = false,
  }) async {
    if (isClosed) return;
    final usecase = getGroupContributionsPage;
    if (usecase == null) return;
    if (page < 1) page = 1;

    // A different group invalidates everything held for the previous one.
    if (contributionsPageGroupId != groupId) {
      contributionsPage = null;
      contributionsPrefetch.clear();
      contributionsPageGroupId = groupId;
    }

    final cached = force ? null : contributionsPrefetch[page];
    if (cached != null) {
      contributionsPage = cached;
      emit(GroupAccountContributionsPageLoaded(groupId, cached));
      unawaited(_prefetchContributions(groupId, page + 1));
      return;
    }

    final generation = _sessionGeneration;
    try {
      final result = await usecase(GroupPageParams(
        groupId: groupId,
        page: page,
        pageSize: pageSize,
      ));
      if (!_sessionStillCurrent(generation) ||
          contributionsPageGroupId != groupId) {
        return;
      }
      contributionsPage = result;
      emit(GroupAccountContributionsPageLoaded(groupId, result));
      if (page == 1) unawaited(_persistContributionsPage(groupId, result));
      unawaited(_prefetchContributions(groupId, page + 1));
    } catch (e) {
      if (!_sessionStillCurrent(generation)) return;
      emit(GroupAccountError(
          GroupAccountCubit._opError('Could not load that page', e)));
    }
  }

  Future<void> _prefetchContributions(String groupId, int page) async {
    final usecase = getGroupContributionsPage;
    if (usecase == null || isClosed) return;
    final current = contributionsPage;
    if (current != null && page > current.totalPages) return;
    if (contributionsPrefetch.containsKey(page)) return;

    final generation = _sessionGeneration;
    try {
      final result = await usecase(GroupPageParams(
        groupId: groupId,
        page: page,
        pageSize: pageSize,
      ));
      if (!_sessionStillCurrent(generation) ||
          contributionsPageGroupId != groupId) {
        return;
      }
      contributionsPrefetch
        ..clear()
        ..[page] = result;
    } catch (_) {
      // See _prefetchGroups.
    }
  }

  Future<void> _persistContributionsPage(
    String groupId,
    PagedResult<Contribution> page,
  ) async {
    final userId = currentUserId;
    if (userId == null) return;
    await GroupFundsPageCache.writeContributions(
      userId,
      groupId,
      page.items
          .map((c) => ContributionModel.fromEntity(c).toJson())
          .toList(),
    );
  }

  /// Drop every page and prefetch this cubit holds.
  ///
  /// Called whenever the underlying data changes in a way paging cannot
  /// patch — a reorder failing, an item hidden, a pull-to-refresh. Cheaper
  /// to re-read one page than to reason about which held page a change
  /// invalidated.
  void invalidatePages() {
    groupsPage = null;
    groupsPrefetch.clear();
    contributionsPage = null;
    contributionsPrefetch.clear();
    contributionsPageGroupId = null;
  }
}
