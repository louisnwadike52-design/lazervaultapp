import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The contribution details screen's tab BAR, its TabBarView CHILDREN and the
/// TabController LENGTH must all agree — including about the conditional
/// Cycles tab.
///
/// Three lists, hundreds of lines apart, and a TabController does not care
/// that they disagree: it only counts. The failure modes are both silent and
/// both bad:
///
///   bar has Cycles, children do not   -> tapping Cycles renders nothing, or
///                                        Flutter asserts on the length
///   children have it, bar does not    -> a tab nothing can reach
///   length disagrees with either      -> "Controller's length property does
///                                        not match the number of tabs"
///
/// Same defect class as [group_funds_tab_order_matches_views_test], which was
/// written after the Requests tab shipped at position 1 in the bar and
/// position 3 in the view. Asserted on the SOURCE because the agreement
/// between three separate lists is the thing that breaks, and there is no
/// single value to call at runtime.
void main() {
  late String src;

  setUpAll(() {
    src = File(
      'lib/src/features/group_account/presentation/views/'
      'contribution_details_screen.dart',
    ).readAsStringSync();
  });

  /// Labels in the order the tab bar declares them.
  List<String> barOrder() => RegExp(r"Tab\(text: '([A-Za-z ]+)'\)")
      .allMatches(src)
      .map((m) => m.group(1)!)
      .toList();

  /// Bodies in the order the TabBarView declares them.
  List<String> viewOrder() => RegExp(
        r'_build(Overview|Payments|Members)Tab\(contribution\)|'
        r'(ContributionCyclesHistoryScreen)\(',
      ).allMatches(src).map((m) => m.group(1) ?? 'Cycles').toList();

  test('the bar and the view declare the same tabs in the same order', () {
    expect(barOrder(), ['Overview', 'Payments', 'Members', 'Cycles']);
    // The cycles screen is also referenced by _openCyclesHistory's push, so
    // take only the first four body entries — the tabs themselves.
    expect(viewOrder().take(4).toList(),
        ['Overview', 'Payments', 'Members', 'Cycles']);
  });

  test('the Cycles tab is gated by the SAME condition in both lists', () {
    // The bar's local is assigned from the shared predicate, so both lists
    // cannot disagree about when the tab exists.
    expect(src, contains('final showCycles = _showCyclesTab(contribution);'),
        reason: 'the bar must derive its flag from _showCyclesTab, not from a '
            'second copy of the condition that can drift');
    expect(src, contains("if (showCycles) const Tab(text: 'Cycles'),"));
    expect(src, contains('if (_showCyclesTab(contribution))'));
  });

  test('the controller length is derived from the same predicate', () {
    expect(src, contains('final count = _showCyclesTab(contribution) ? 4 : 3;'),
        reason: 'a hardcoded length is how "Controller\'s length property does '
            'not match the number of tabs" ships');
  });

  test('the controller is rebuilt rather than created once', () {
    // The tab count changes when a rotation opens while the screen is on
    // screen, and TabController.length is final.
    expect(src, contains('void _syncTabController('));
    expect(src, contains('_syncTabController(contribution);'),
        reason: 'computing the count without calling the sync leaves the '
            'controller stale');
    // SingleTickerProviderStateMixin asserts on a second ticker even after the
    // first is disposed, so rebuilding requires the multi-ticker mixin.
    //
    // Read off the class declaration with comments stripped and whitespace
    // collapsed: the formatter puts each mixin on its own line, so a plain
    // substring search for "with TickerProviderStateMixin" finds nothing even
    // when the mixin is there.
    final decl = src
        .replaceAll(RegExp(r'//[^\n]*'), '')
        .replaceAll(RegExp(r'\s+'), ' ');
    final clause = RegExp(r'class _ContributionDetailsScreenState[^{]*')
        .firstMatch(decl)!
        .group(0)!;
    expect(clause, contains('TickerProviderStateMixin'));
    expect(clause, isNot(contains('SingleTickerProviderStateMixin')));
  });

  test('the outgoing controller is disposed after the frame, not during it',
      () {
    // Disposing mid-build makes the next notification from the still-attached
    // TabBar throw "A TabController was used after being disposed".
    expect(src, contains('addPostFrameCallback((_) => old.dispose())'));
  });

  test('the embedded cycles tab does not nest a second Scaffold', () {
    final cycles = File(
      'lib/src/features/group_account/presentation/views/'
      'contribution_cycles_history_screen.dart',
    ).readAsStringSync();
    expect(cycles, contains('if (widget.embedded) return content;'),
        reason: 'as a tab it must return the bare content — a nested Scaffold '
            'adds a second background and a second top inset');
    expect(cycles, contains('if (!widget.embedded) _buildHeader(),'),
        reason: 'a tab has no back button of its own to render');
  });

  test('the auto-refresh timer is stopped on dispose and on background', () {
    // A timer left running lands its result on a disposed widget and spends
    // battery on a screen nobody is looking at.
    expect(src, contains('_stopAutoRefresh();'));
    expect(src, contains('Timer? _refreshTimer;'));
    expect(src, contains('if (state != AppLifecycleState.resumed) {'),
        reason: 'the poll must stop when the app leaves the foreground');
    // And it must not fire from under a modal, which would swap the
    // contribution a sheet was opened against.
    expect(src, contains("ModalRoute.of(context)?.isCurrent != true"));
  });
}
