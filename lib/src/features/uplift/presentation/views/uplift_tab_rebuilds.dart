library;

import 'package:lazervault/src/features/uplift/presentation/cubit/uplift_cubit.dart';

/// WHEN EACH LAZERFUNDS TAB IS ALLOWED TO REBUILD.
///
/// THE FLICKER
/// -----------
/// One `BlocBuilder` wrapped the whole `TabBarView`, so every emission rebuilt
/// all three tabs at once — and `TabBarView` BUILDS ITS ADJACENT CHILD, so the
/// tab you are looking at and the one beside it were both thrown away and
/// rebuilt on:
///
///   * each keystroke in the Discover search box (the screen called
///     `setState` on every `onChanged` purely to show/hide a clear icon),
///   * every `loadAll` / `searchDiscover` / `refreshMine` /
///     `loadMoreDiscover`, which each emit at least twice (loading, then
///     result),
///   * the up-to-three `setState`s the first-run guide resolution fires right
///     after mount, while the entrance animation is still sliding.
///
/// Each rebuild swaps the tab body's widget TYPE whenever a flag moves
/// (`UpLoading` ⇄ `UpEmptyState` ⇄ `RefreshIndicator`), which tears the
/// subtree down and builds a new one — the list, its scroll position and its
/// images with it. That is what reads as flickering.
///
/// THE RULE
/// --------
/// A tab rebuilds only when something IT renders changed. Typing in Discover
/// cannot repaint My Funds; a My Funds refresh cannot repaint Discover.
///
/// These are plain functions, not methods, so the rule is testable on its own
/// — the screen that uses them needs gRPC, a service locator and an entrance
/// animation to mount.
///
/// IDENTITY, NOT DEEP EQUALITY. `UpliftState` is a plain class whose lists are
/// replaced wholesale by `copyWith`, so `identical` answers "did this slice
/// change" exactly, in constant time, for lists of any length. Comparing
/// element by element would be slower AND wrong — a reloaded list of the same
/// funds is still new data to paint (counts, progress and status all live on
/// the messages).

/// Discover: the fund list, its paging flags, the active filters, and the
/// recent-activity strip that shares the tab.
bool upliftDiscoverTabChanged(UpliftState a, UpliftState b) =>
    !identical(a.discover, b.discover) ||
    !identical(a.recentReceipts, b.recentReceipts) ||
    a.discoverHasMore != b.discoverHasMore ||
    a.discoverLoadingMore != b.discoverLoadingMore ||
    a.category != b.category ||
    a.query != b.query ||
    _sharedFlagsChanged(a, b);

/// My Funds: the funds the user has opened.
bool upliftMyFundsTabChanged(UpliftState a, UpliftState b) =>
    !identical(a.myFunds, b.myFunds) || _sharedFlagsChanged(a, b);

/// My Applications: the applications the user has sent.
bool upliftMyApplicationsTabChanged(UpliftState a, UpliftState b) =>
    !identical(a.myApplications, b.myApplications) || _sharedFlagsChanged(a, b);

/// `loading` and `error` are screen-wide in this cubit — any load raises the
/// one flag — so every tab has to watch them: they are what decides between a
/// spinner, an error state and content.
///
/// This is the honest cost of a single shared flag. It still removes the
/// rebuilds that actually hurt: a keystroke, a filter chip, a page of Discover
/// results and a My Funds refresh all leave the other tabs alone.
bool _sharedFlagsChanged(UpliftState a, UpliftState b) =>
    a.loading != b.loading || a.error != b.error;
