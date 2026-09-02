import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/core/utils/currency_utils.dart';

/// Where a pending payable came from.
///
/// Deliberately its own enum rather than [AppServiceName]: split bills have no
/// service tile at all (they live inside the Move Money hub), and the launch
/// prompt still has to list them. Mapping to tiles is a separate concern —
/// see [PendingActionSourceX.tiles].
enum PendingActionSource { tagPay, invoice, splitBill }

extension PendingActionSourceX on PendingActionSource {
  String get label => switch (this) {
        PendingActionSource.tagPay => 'Tag Pay',
        PendingActionSource.invoice => 'Invoice',
        PendingActionSource.splitBill => 'Split Bill',
      };

  /// The service tiles this source badges.
  ///
  /// Invoice badges BOTH tiles: `payInvoice` is the same service under a second
  /// entry (see [AppServiceName]), so a user whose grid shows only "Pay
  /// Invoice" must still see the count.
  Set<AppServiceName> get tiles => switch (this) {
        PendingActionSource.tagPay => const {AppServiceName.tagPay},
        PendingActionSource.invoice => const {
            AppServiceName.invoice,
            AppServiceName.payInvoice,
          },
        PendingActionSource.splitBill => const {AppServiceName.splitBills},
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
    required this.amount,
    required this.currency,
    required this.route,
    this.subtitle,
    this.createdAt,
    this.dueAt,
    this.routeArguments,
  });

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
  final double amount;
  final String currency;

  final DateTime? createdAt;

  /// When this stops being payable (tag expiry) or becomes late (invoice due
  /// date). Drives urgency ordering and the "expires in" line.
  final DateTime? dueAt;

  /// Where "Pay" goes, plus its GetX arguments.
  final String route;
  final Object? routeArguments;

  String get formattedAmount =>
      '${CurrencyUtils.getSymbol(currency)}${_amountFormat.format(amount)}';

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
  List<Object?> get props => [source, id, title, subtitle, amount, currency,
        createdAt, dueAt, route, routeArguments];
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
