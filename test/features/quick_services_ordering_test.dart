import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/src/features/widgets/quick_services_ordering.dart';

/// Airtime and data carry the two lowest default ranks — they are the errands
/// people open the app for several times a week — and on a real device they
/// were rendering in the last two cells of the SECOND carousel, below
/// everything, where a user scanning the dashboard would never see them.
///
/// The cause was not the ranks. A saved hand-arrangement is a snapshot of the
/// services that existed the day the user last dragged a tile, and anything
/// without a rank was appended to the end of the list. On a paginated grid the
/// end of the list is the last page, so ONE drag, once, permanently hid every
/// service shipped afterwards — silently, with nothing on screen saying why.
void main() {
  AppServiceName nameOf(AppServiceName s) => s;

  List<AppServiceName> order(
    List<AppServiceName> services,
    Map<AppServiceName, int> ranks,
  ) =>
      orderByUserArrangement<AppServiceName>(services,
          ranks: ranks, nameOf: nameOf);

  test('no arrangement leaves the list untouched for the caller to sort', () {
    final services = [AppServiceName.crypto, AppServiceName.airtime];
    expect(order(services, const {}), services);
  });

  test('a hand-placed rank wins outright', () {
    // The user dragged crypto in front of airtime. That is an instruction,
    // not a guess, so it beats airtime's rank-1 default.
    final out = order(
      [AppServiceName.airtime, AppServiceName.crypto],
      {AppServiceName.crypto: 0, AppServiceName.airtime: 1},
    );
    expect(out, [AppServiceName.crypto, AppServiceName.airtime]);
  });

  test('an unranked service is NOT exiled to the end — the reported bug', () {
    // Exactly the production shape: everything arranged except airtime and
    // data, which were added to the grid after the arrangement was saved.
    final arranged = <AppServiceName, int>{
      AppServiceName.sendFunds: 0,
      AppServiceName.qrPay: 1,
      AppServiceName.contactlessPay: 2,
      AppServiceName.autoSave: 3,
      AppServiceName.crowdfund: 4,
    };
    final out = order([
      ...arranged.keys,
      AppServiceName.airtime,
      AppServiceName.data,
    ], arranged);

    expect(out.indexOf(AppServiceName.airtime), lessThan(out.length - 1),
        reason: 'airtime is still last, which on a paginated grid is the '
            'final cell of the final page');
    // Both outrank every arranged service by default order, so both lead.
    expect(out.take(2), [AppServiceName.airtime, AppServiceName.data],
        reason: 'airtime (rank 1) and data (rank 2) must lead: nothing '
            'arranged here has a lower default rank than either');
  });

  test('an unranked service lands between the right neighbours', () {
    // giftCards is default rank 5. It belongs after crypto (4) and before
    // tagPay (7) — NOT at either end.
    final arranged = <AppServiceName, int>{
      AppServiceName.crypto: 0,
      AppServiceName.tagPay: 1,
      AppServiceName.betting: 2,
    };
    final out = order([...arranged.keys, AppServiceName.giftCards], arranged);
    expect(out, [
      AppServiceName.crypto,
      AppServiceName.giftCards,
      AppServiceName.tagPay,
      AppServiceName.betting,
    ]);
  });

  test('a genuinely low-priority newcomer still goes last', () {
    // The end is the correct answer when nothing arranged belongs after it.
    // Fixing the exile must not mean promoting everything.
    final arranged = <AppServiceName, int>{
      AppServiceName.airtime: 0,
      AppServiceName.data: 1,
    };
    final out = order([...arranged.keys, AppServiceName.payroll], arranged);
    expect(out.last, AppServiceName.payroll);
  });

  test('two unranked services sharing a slot keep a deterministic order', () {
    // A wobbling grid would move a tile out from under a finger mid-drag.
    final arranged = <AppServiceName, int>{AppServiceName.payroll: 0};
    final services = [
      AppServiceName.payroll,
      AppServiceName.data,
      AppServiceName.airtime,
    ];
    final first = order(services, arranged);
    final second = order(first, arranged);
    expect(first, second);
    expect(first.take(2), [AppServiceName.airtime, AppServiceName.data]);
  });

  test('no service is lost or duplicated', () {
    final services = AppServiceName.values.toList();
    final arranged = <AppServiceName, int>{
      for (var i = 0; i < 8; i++) services[i * 3]: i,
    };
    final out = order(services, arranged);
    expect(out.length, services.length);
    expect(out.toSet().length, services.length);
    expect(out.toSet(), services.toSet());
  });
}
