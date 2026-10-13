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
      emitState(GroupAccountGroupsPageLoaded(cached));
      unawaited(_prefetchGroups(page + 1));
      return;
    }

    final generation = _sessionGeneration;
    // Only the FIRST load shows a spinner. A page turn keeps the current
    // page on screen until the next one lands, which is what makes paging
    // feel like paging rather than like reloading.
    if (groupsPage == null) {
      emitState(const GroupAccountLoading(message: 'Loading groups...'));
    }
    try {
      var result = await usecase(PageParams(page: page, pageSize: pageSize));
      if (!_sessionStillCurrent(generation)) return;

      // Stranded past the end.
      //
      // Hiding rows (or someone else removing you from a group) shrinks the
      // list under the user. Asking for page 3 of a list that now has two
      // leaves them looking at an empty page with a pager that says there is
      // nothing beyond it — and no obvious way back. Step to the last page
      // that exists instead.
      if (result.items.isEmpty &&
          result.totalPages > 0 &&
          page > result.totalPages) {
        result = await usecase(
            PageParams(page: result.totalPages, pageSize: pageSize));
        if (!_sessionStillCurrent(generation)) return;
      }

      groupsPage = result;
      // `_cachedGroups` is deliberately NOT overwritten here.
      //
      // It means "the user's groups" and is read by the stats tile, the
      // group-details fallback and the discover screen's membership check.
      // Replacing it with five rows made the header report "5 groups" to
      // someone with twelve, and made opening a group on page 2 miss its
      // instant-render snapshot. loadUserGroups keeps that cache; this owns
      // the page.
      emitState(GroupAccountGroupsPageLoaded(result));
      if (page == 1) unawaited(_persistGroupsPage(result));
      unawaited(_prefetchGroups(page + 1));
    } catch (e) {
      if (!_sessionStillCurrent(generation)) return;
      emitState(GroupAccountError(
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
      final items =
          raw.map<GroupAccount>((j) => GroupAccountModel.fromJson(j)).toList();
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
      // Only when there is nothing better: on a cold start this IS the best
      // the app has, and the group-details screen reads it to render
      // instantly instead of showing a spinner. It is replaced the moment
      // the unpaged load lands.
      _cachedGroups ??= items;
      emitState(GroupAccountGroupsPageLoaded(page, fromCache: true));
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
      page.items.map((g) => GroupAccountModel.fromEntity(g).toJson()).toList(),
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
      emitState(GroupAccountContributionsPageLoaded(groupId, cached));
      unawaited(_prefetchContributions(groupId, page + 1));
      return;
    }

    final generation = _sessionGeneration;
    try {
      var result = await usecase(GroupPageParams(
        groupId: groupId,
        page: page,
        pageSize: pageSize,
      ));
      if (!_sessionStillCurrent(generation) ||
          contributionsPageGroupId != groupId) {
        return;
      }
      // See loadGroupsPage: a hidden or deleted contribution can shrink the
      // list out from under the page the user is on.
      if (result.items.isEmpty &&
          result.totalPages > 0 &&
          page > result.totalPages) {
        result = await usecase(GroupPageParams(
          groupId: groupId,
          page: result.totalPages,
          pageSize: pageSize,
        ));
        if (!_sessionStillCurrent(generation) ||
            contributionsPageGroupId != groupId) {
          return;
        }
      }
      contributionsPage = result;
      emitState(GroupAccountContributionsPageLoaded(groupId, result));
      if (page == 1) unawaited(_persistContributionsPage(groupId, result));
      unawaited(_prefetchContributions(groupId, page + 1));
    } catch (e) {
      if (!_sessionStillCurrent(generation)) return;
      // A membership refusal is NOT a page-load failure.
      //
      // loadGroupDetails deliberately turns PermissionDenied into the
      // "Waiting for approval" / "Members only" screen, because a user who
      // opened a group they have not joined has done nothing wrong. This path
      // did not know that, so both ran: the friendly screen rendered and a red
      // "not authorized" was thrown over the top of it. Reported from the
      // dashboard's "waiting on you" sheet, which used to route an invite
      // straight at a group the invitee is by definition not in yet.
      //
      // Silent here on purpose — the group-details load owns the user-facing
      // state for this case, and a second opinion from the pager can only
      // contradict it.
      if (isNotAuthorizedError(e)) {
        debugPrint('[GroupFundsPaging] contributions page refused for $groupId '
            '(not a member) — leaving the access state to loadGroupDetails');
        return;
      }
      emitState(GroupAccountError(
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
      page.items.map((c) => ContributionModel.fromEntity(c).toJson()).toList(),
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
