import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The Group Funds tab BAR, its TabBarView children and the GroupFundsTab
/// index constants must all be in the same order.
///
/// They were not. Adding the Requests tab put it at position 1 in the bar
/// while its body was appended at position 3 in the TabBarView, so:
///
///   tapping "Invites"  rendered the join-requests body -> "Could not load
///                      requests" on a tab that has nothing to do with them
///   tapping "Requests" rendered Discover
///   GroupFundsTab.invites (2) deep-linked to Discover
///
/// A TabController does not care that the two lists disagree — it only counts
/// them — so nothing failed, it just showed the wrong screen. Asserted on the
/// source because the ordering is the defect and it lives in two lists a
/// thousand lines apart.
void main() {
  late String src;

  setUpAll(() {
    src = File(
      'lib/src/features/group_account/presentation/views/group_account_list_screen.dart',
    ).readAsStringSync();
  });

  /// Order the labels appear in the tab bar.
  List<String> barOrder() {
    final re = RegExp(r"Text\('(My Groups|Discover|Invites|Requests|Leaderboard)'\)");
    return re.allMatches(src).map((m) => m.group(1)!).toList();
  }

  /// Order the bodies appear in the TabBarView.
  List<String> viewOrder() {
    final re = RegExp(
      r'_build(MyGroups|Discover|Invites|JoinRequests|Leaderboard)Tab\(\),',
    );
    return re.allMatches(src).map((m) => m.group(1)!).toList();
  }

  // The body builder names, in the same vocabulary as the bar labels.
  const label = {
    'MyGroups': 'My Groups',
    'Discover': 'Discover',
    'Invites': 'Invites',
    'JoinRequests': 'Requests',
    'Leaderboard': 'Leaderboard',
  };

  test('the tab bar and the TabBarView are in the same order', () {
    final bar = barOrder();
    final views = viewOrder().map((v) => label[v]!).toList();

    expect(bar, hasLength(5), reason: 'expected 5 tab labels, found $bar');
    expect(views, hasLength(5), reason: 'expected 5 tab bodies, found $views');
    expect(
      bar,
      views,
      reason: 'Tab bar order $bar does not match TabBarView order $views. '
          'Every tap will open the body at the same INDEX, not the body with '
          'the matching name — which is how tapping Invites came to show '
          '"Could not load requests".',
    );
  });

  test('GroupFundsTab constants match the tab order', () {
    final views = viewOrder().map((v) => label[v]!).toList();

    const constants = {
      'myGroups': 'My Groups',
      'discover': 'Discover',
      'invites': 'Invites',
      'joinRequests': 'Requests',
      'leaderboard': 'Leaderboard',
    };

    constants.forEach((name, text) {
      final m = RegExp('static const int $name = ([0-9]+);').firstMatch(src);
      expect(m, isNotNull, reason: 'GroupFundsTab.$name is gone');
      final index = int.parse(m!.group(1)!);
      expect(
        views[index],
        text,
        reason: 'GroupFundsTab.$name = $index, but index $index of the '
            'TabBarView is "${views[index]}", not "$text". Anything deep '
            'linking with that constant lands on the wrong tab.',
      );
    });
  });
}
