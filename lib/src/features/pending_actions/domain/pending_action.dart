import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/core/utils/currency_utils.dart';

/// What kind of thing is waiting on the user.
///
/// This is the load-bearing distinction in the whole feature. A friend request
/// is not a bill: offering "Pay" on one would be nonsense at best and, on a
/// money screen, alarming. Payments keep "Pay"; requests get "Review".
///
/// It also decides what a frozen account hides. A frozen wallet is a reason not
/// to invite someone to pay, and no reason at all to hide a family invitation —
/// see the guard in `dashboard_screen.dart`.
enum PendingActionCategory { payment, request }

/// Where a pending action came from.
///
/// Deliberately its own enum rather than [AppServiceName]: split bills have no
/// service tile at all (they live inside the Move Money hub), and the launch
/// prompt still has to list them. Mapping to tiles is a separate concern —
/// see [PendingActionSourceX.tiles].
enum PendingActionSource {
  // Payments — money the user owes.
  tagPay,
  invoice,
  splitBill,
  // Requests — someone waiting on a decision, with no money attached.
  familyInvite,
  groupInvite,
  connectionRequest,
}

extension PendingActionSourceX on PendingActionSource {
  String get label => switch (this) {
        PendingActionSource.tagPay => 'Tag Pay',
        PendingActionSource.invoice => 'Invoice',
        PendingActionSource.splitBill => 'Split Bill',
        PendingActionSource.familyInvite => 'Family',
        PendingActionSource.groupInvite => 'Joint Funds',
        PendingActionSource.connectionRequest => 'Connection',
      };

  PendingActionCategory get category => switch (this) {
        PendingActionSource.tagPay ||
        PendingActionSource.invoice ||
        PendingActionSource.splitBill =>
          PendingActionCategory.payment,
        PendingActionSource.familyInvite ||
        PendingActionSource.groupInvite ||
        PendingActionSource.connectionRequest =>
          PendingActionCategory.request,
      };

  /// The service tiles this source badges.
  ///
  /// Invoice badges BOTH tiles: `payInvoice` is the same service under a second
  /// entry (see [AppServiceName]), so a user whose grid shows only "Pay
  /// Invoice" must still see the count.
  ///
  /// Family and Connections badge nothing on purpose: neither has an
  /// [AppServiceName] entry, so there is no tile to badge, and they surface
  /// through the launch prompt alone. Inventing a tile mapping for them would
  /// badge the wrong service.
  Set<AppServiceName> get tiles => switch (this) {
        PendingActionSource.tagPay => const {AppServiceName.tagPay},
        PendingActionSource.invoice => const {
            AppServiceName.invoice,
            AppServiceName.payInvoice,
          },
        PendingActionSource.splitBill => const {AppServiceName.splitBills},
        PendingActionSource.groupInvite => const {AppServiceName.groupAccount},
        PendingActionSource.familyInvite ||
        PendingActionSource.connectionRequest =>
          const {},
      };
}

final _amountFormat = NumberFormat('#,##0.00');

/// One thing the user owes money on, normalised across services so the launch
/// prompt can render a mixed list and the tiles can count without knowing
/// anything about tags, invoices or split bills.
class PendingAction extends Equatable {
  const PendingAction({
    required this.source,
    required this.id,
    required this.title,
    required this.route,
    this.amount,
    this.currency,
    this.subtitle,
    this.createdAt,
    this.dueAt,
    this.routeArguments,
  });

  PendingActionCategory get category => source.category;

  final PendingActionSource source;

  /// Service-native id (tag id / invoice id / split-bill id). Used for dedupe
  /// and as the dismissal key, never shown.
  final String id;

  /// Who is asking — the tagger, the invoice issuer, the bill creator.
  final String title;

  /// Secondary line: @handle, invoice number, or bill title.
  final String? subtitle;

  /// What THIS user owes, in major units. For split bills that is the user's
  /// own share, never the bill total — showing the total would tell someone
  /// they owe five times what they actually do.
  ///
  /// Null for [PendingActionCategory.request] entries, which carry no money at
  /// all. Nullable rather than defaulted to zero on purpose: a rendered
  /// "₦0.00" next to a friend request reads as a payable of nothing, which is
  /// a statement about money where none was intended.
  final double? amount;
  final String? currency;

  final DateTime? createdAt;

  /// When this stops being payable (tag expiry) or becomes late (invoice due
  /// date). Drives urgency ordering and the "expires in" line.
  final DateTime? dueAt;

  /// Where "Pay" goes, plus its GetX arguments.
  final String route;
  final Object? routeArguments;

  /// Null when there is no money involved — the caller renders nothing rather
  /// than a placeholder.
  String? get formattedAmount {
    final value = amount;
    final code = currency;
    if (value == null || code == null || code.isEmpty) return null;
    return '${CurrencyUtils.getSymbol(code)}${_amountFormat.format(value)}';
  }

  /// The verb on this row's button. "Pay" would be wrong — and on a money
  /// screen, alarming — next to a friend request.
  String get actionLabel =>
      category == PendingActionCategory.payment ? 'Pay' : 'Review';

  /// Non-null only while a deadline is both known and in the future.
  Duration? get timeLeft {
    final due = dueAt;
    if (due == null) return null;
    final left = due.difference(DateTime.now());
    return left.isNegative ? null : left;
  }

  /// True once a known deadline has passed. An expired tag is not payable and
  /// an overdue invoice is; the caller decides what to do with that, this only
  /// reports the fact.
  bool get isPastDue {
    final due = dueAt;
    return due != null && due.isBefore(DateTime.now());
  }

  /// Short human deadline, e.g. "expires in 2 days". Null when there is no
  /// deadline to speak of.
  String? get deadlineLabel {
    final left = timeLeft;
    if (left == null) return null;
    final verb = source == PendingActionSource.tagPay ? 'Expires' : 'Due';
    if (left.inDays >= 1) {
      final d = left.inDays;
      return '$verb in $d ${d == 1 ? 'day' : 'days'}';
    }
    if (left.inHours >= 1) {
      final h = left.inHours;
      return '$verb in $h ${h == 1 ? 'hour' : 'hours'}';
    }
    final m = left.inMinutes.clamp(1, 59);
    return '$verb in $m ${m == 1 ? 'minute' : 'minutes'}';
  }

  @override
  List<Object?> get props => [
        source,
        id,
        title,
        subtitle,
        amount,
        currency,
        createdAt,
        dueAt,
        route,
        routeArguments
      ];
}

/// The aggregated view every pending-payment surface reads.
class PendingActionsSnapshot extends Equatable {
  const PendingActionsSnapshot({
    this.bySource = const {},
    this.isLoading = false,
    this.fetchedAt,
    this.staleSources = const {},
  });

  /// Per-source lists, kept split so one service failing can't zero another's
  /// badge.
  final Map<PendingActionSource, List<PendingAction>> bySource;

  final bool isLoading;
  final DateTime? fetchedAt;

  /// Sources whose most recent refresh failed. Their entries here are the last
  /// good result, NOT fresh — we keep showing them rather than dropping the
  /// badge to zero, because "you owe nothing" is a far more damaging lie than
  /// a slightly stale count.
  final Set<PendingActionSource> staleSources;

  /// Everything, most urgent first: soonest real deadline leads, then newest.
  List<PendingAction> get all {
    final items = bySource.values.expand((e) => e).toList();
    items.sort((a, b) {
      final ad = a.dueAt;
      final bd = b.dueAt;
      if (ad != null && bd != null) return ad.compareTo(bd);
      if (ad != null) return -1;
      if (bd != null) return 1;
      final ac = a.createdAt;
      final bc = b.createdAt;
      if (ac != null && bc != null) return bc.compareTo(ac);
      return 0;
    });
    return items;
  }

  int get total => bySource.values.fold(0, (sum, list) => sum + list.length);

  bool get isEmpty => total == 0;

  int countForSource(PendingActionSource source) =>
      bySource[source]?.length ?? 0;

  /// Everything in one category, in the same urgency order as [all].
  List<PendingAction> forCategory(PendingActionCategory category) =>
      all.where((a) => a.category == category).toList();

  /// Money the user owes.
  List<PendingAction> get payments =>
      forCategory(PendingActionCategory.payment);

  /// People waiting on a decision — invitations and connection requests.
  List<PendingAction> get requests =>
      forCategory(PendingActionCategory.request);

  int countForCategory(PendingActionCategory category) {
    var count = 0;
    for (final entry in bySource.entries) {
      if (entry.key.category == category) count += entry.value.length;
    }
    return count;
  }

  /// A frozen account suppresses the payment half only — see the guard in
  /// `dashboard_screen.dart`. Requests still surface, because a frozen wallet
  /// is no reason to hide a family invitation.
  bool get hasPayments => countForCategory(PendingActionCategory.payment) > 0;
  bool get hasRequests => countForCategory(PendingActionCategory.request) > 0;

  /// "3 payments and 2 requests", "2 requests", "1 payment" — whichever halves
  /// are actually present, so the header never announces a category that is
  /// empty.
  String get summaryLabel {
    final p = countForCategory(PendingActionCategory.payment);
    final r = countForCategory(PendingActionCategory.request);
    String plural(int n, String word) => '$n $word${n == 1 ? '' : 's'}';
    if (p > 0 && r > 0) {
      return '${plural(p, 'payment')} and ${plural(r, 'request')}';
    }
    if (p > 0) return plural(p, 'payment');
    if (r > 0) return plural(r, 'request');
    return 'nothing';
  }

  /// How many pending payables badge this tile. Zero for every service that
  /// has none, which is most of them.
  int countForTile(AppServiceName service) {
    var count = 0;
    for (final entry in bySource.entries) {
      if (entry.key.tiles.contains(service)) count += entry.value.length;
    }
    return count;
  }

  PendingActionsSnapshot copyWith({
    Map<PendingActionSource, List<PendingAction>>? bySource,
    bool? isLoading,
    DateTime? fetchedAt,
    Set<PendingActionSource>? staleSources,
  }) {
    return PendingActionsSnapshot(
      bySource: bySource ?? this.bySource,
      isLoading: isLoading ?? this.isLoading,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      staleSources: staleSources ?? this.staleSources,
    );
  }

  @override
  List<Object?> get props => [bySource, isLoading, fetchedAt, staleSources];
}
