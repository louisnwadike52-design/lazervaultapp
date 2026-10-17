import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/uplift/presentation/cubit/uplift_cubit.dart';
import 'package:lazervault/src/features/uplift/presentation/views/uplift_tab_rebuilds.dart';
import 'package:lazervault/src/generated/uplift.pbgrpc.dart' as up;

/// The Lazerfunds tabs flickered.
///
/// One `BlocBuilder` wrapped the whole `TabBarView`, and `TabBarView` builds
/// its ADJACENT child — so every emission rebuilt two live subtrees, lists,
/// scroll positions and images included. A keystroke in the Discover search
/// box did it too: `onChanged` called `setState` on the screen purely to show
/// a clear icon.
///
/// These pin the predicate that now gates each tab. They are plain functions
/// precisely so the rule is testable: the screen needs gRPC, a service
/// locator and an entrance animation to mount.

up.UpliftFundMessage fund(String id) => up.UpliftFundMessage(id: id);
up.UpliftApplicationMessage application(String id) =>
    up.UpliftApplicationMessage(id: id);
up.UpliftReceiptMessage receipt(String id) => up.UpliftReceiptMessage(id: id);

void main() {
  final base = UpliftState(
    discover: [fund('d1')],
    myFunds: [fund('m1')],
    myApplications: [application('a1')],
    recentReceipts: [receipt('r1')],
  );

  group('a tab ignores what it does not render', () {
    test('typing a Discover query leaves the other two alone', () {
      final next = base.copyWith(query: 'agri');
      expect(upliftDiscoverTabChanged(base, next), isTrue);
      expect(upliftMyFundsTabChanged(base, next), isFalse);
      expect(upliftMyApplicationsTabChanged(base, next), isFalse);
    });

    test('a category chip leaves the other two alone', () {
      final next = base.copyWith(category: 'Technology');
      expect(upliftDiscoverTabChanged(base, next), isTrue);
      expect(upliftMyFundsTabChanged(base, next), isFalse);
      expect(upliftMyApplicationsTabChanged(base, next), isFalse);
    });

    test('another page of Discover results leaves the other two alone', () {
      final next = base.copyWith(
        discover: [fund('d1'), fund('d2')],
        discoverHasMore: true,
      );
      expect(upliftDiscoverTabChanged(base, next), isTrue);
      expect(upliftMyFundsTabChanged(base, next), isFalse);
      expect(upliftMyApplicationsTabChanged(base, next), isFalse);
    });

    test('refreshing My Funds does not repaint Discover', () {
      // refreshAfterFundChange / returning from a fund detail hits this path
      // constantly, and Discover is the adjacent child TabBarView keeps live.
      final next = base.copyWith(myFunds: [fund('m1'), fund('m2')]);
      expect(upliftMyFundsTabChanged(base, next), isTrue);
      expect(upliftDiscoverTabChanged(base, next), isFalse);
      expect(upliftMyApplicationsTabChanged(base, next), isFalse);
    });

    test('a new application repaints only My Applications', () {
      final next =
          base.copyWith(myApplications: [application('a1'), application('a2')]);
      expect(upliftMyApplicationsTabChanged(base, next), isTrue);
      expect(upliftDiscoverTabChanged(base, next), isFalse);
      expect(upliftMyFundsTabChanged(base, next), isFalse);
    });

    test('recent receipts belong to Discover, which hosts them', () {
      final next = base.copyWith(recentReceipts: [receipt('r1'), receipt('r2')]);
      expect(upliftDiscoverTabChanged(base, next), isTrue);
      expect(upliftMyFundsTabChanged(base, next), isFalse);
    });
  });

  group('what every tab must still watch', () {
    test('loading decides between a spinner and content, so all three react',
        () {
      final next = base.copyWith(loading: true);
      expect(upliftDiscoverTabChanged(base, next), isTrue);
      expect(upliftMyFundsTabChanged(base, next), isTrue);
      expect(upliftMyApplicationsTabChanged(base, next), isTrue);
    });

    test('an error decides between an error state and content', () {
      final next = base.copyWith(error: 'server not reachable');
      expect(upliftDiscoverTabChanged(base, next), isTrue);
      expect(upliftMyFundsTabChanged(base, next), isTrue);
      expect(upliftMyApplicationsTabChanged(base, next), isTrue);
    });

    test('clearing an error is a change too', () {
      final failed = base.copyWith(error: 'server not reachable');
      final cleared = failed.copyWith(clearError: true);
      expect(upliftDiscoverTabChanged(failed, cleared), isTrue);
      expect(upliftMyFundsTabChanged(failed, cleared), isTrue);
    });
  });

  group('no change means no rebuild', () {
    test('an identical state rebuilds nothing', () {
      final same = base.copyWith();
      expect(upliftDiscoverTabChanged(base, same), isFalse);
      expect(upliftMyFundsTabChanged(base, same), isFalse);
      expect(upliftMyApplicationsTabChanged(base, same), isFalse);
    });

    test('the same state object compared with itself rebuilds nothing', () {
      expect(upliftDiscoverTabChanged(base, base), isFalse);
      expect(upliftMyFundsTabChanged(base, base), isFalse);
      expect(upliftMyApplicationsTabChanged(base, base), isFalse);
    });
  });

  test('a RELOADED list is a change, even when it holds equal funds', () {
    // Identity, not deep equality, and deliberately so: the messages carry
    // live counts, progress and status, so a refresh that returns "the same"
    // funds still has new figures to paint. Treating it as unchanged would
    // trade a flicker for a stale screen.
    final next = base.copyWith(myFunds: [fund('m1')]);
    expect(upliftMyFundsTabChanged(base, next), isTrue);
  });
}
