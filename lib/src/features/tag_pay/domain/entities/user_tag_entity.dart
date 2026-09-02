import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

/// Money is grouped for READING. Every TagPay surface renders amounts through
/// [UserTagEntity.formattedAmount], and plain `toStringAsFixed(2)` produced
/// "₦1500000.00" — a figure the customer has to count digits on. Display only:
/// the underlying `amount` double is untouched and is what arithmetic uses.
final _tagAmountFormat = NumberFormat('#,##0.00');

class TagsPageResult {
  final List<UserTagEntity> tags;
  final int total;
  final int page;
  final int totalPages;

  const TagsPageResult({
    required this.tags,
    required this.total,
    required this.page,
    required this.totalPages,
  });
}

/// The tag lifecycle as the backend actually stores it.
///
/// [declined], [expired] and [paying] existed in the database long before they
/// had a wire representation, so the app used to render all three as [pending]
/// — i.e. as payable. Only [pending] may ever offer a Pay button: [paying]
/// means a transfer is already in flight, and the rest are terminal.
///
/// [unknown] is the landing pad for a status this build has not been taught
/// yet. It is deliberately NOT payable: a tag whose state we cannot read is the
/// last thing that should show a Pay button.
enum TagStatus {
  pending,
  paying,
  paid,
  cancelled,
  declined,
  expired,
  unknown,
}

class UserTagEntity extends Equatable {
  final String id;
  final String taggerId;
  final String taggerTagPay;
  final String taggerName;
  final String taggedUserId;
  final String taggedUserTagPay;
  final String taggedUserName;
  final double amount;
  final String currency;
  final String description;
  final TagStatus status;
  final DateTime createdAt;
  final DateTime? paidAt;

  /// When the demand lapses. Null on tags created before tags had a lifetime.
  final DateTime? expiresAt;

  /// When it was cancelled, declined or expired.
  final DateTime? respondedAt;

  const UserTagEntity({
    required this.id,
    required this.taggerId,
    required this.taggerTagPay,
    required this.taggerName,
    required this.taggedUserId,
    required this.taggedUserTagPay,
    required this.taggedUserName,
    required this.amount,
    required this.currency,
    required this.description,
    required this.status,
    required this.createdAt,
    this.paidAt,
    this.expiresAt,
    this.respondedAt,
  });

  String get formattedAmount =>
      '${currencySymbol(currency)}${_tagAmountFormat.format(amount)}';

  static String currencySymbol(String code) {
    switch (code) {
      case 'NGN':
        return '\u20A6';
      case 'GBP':
        return '\u00A3';
      case 'EUR':
        return '\u20AC';
      case 'USD':
        return '\$';
      case 'ZAR':
        return 'R';
      default:
        return '$code ';
    }
  }

  bool get isPending => status == TagStatus.pending;
  bool get isPaying => status == TagStatus.paying;
  bool get isPaid => status == TagStatus.paid;
  bool get isCancelled => status == TagStatus.cancelled;
  bool get isDeclined => status == TagStatus.declined;
  bool get isExpired => status == TagStatus.expired;

  /// The ONLY gate a Pay button may use. A [TagStatus.paying] tag already has a
  /// transfer in flight and every other non-pending state is closed, so paying
  /// from any of them is either a double debit or a payment against a demand
  /// that no longer exists.
  bool get isPayable => status == TagStatus.pending;

  /// True once a tag's 7-day lifetime has elapsed, whatever the status column
  /// still says. The expiry sweeper closes these in batches, so a tag can sit
  /// at `pending` for minutes after it stopped being payable — the server
  /// rejects the claim, but only after the user has committed to paying.
  ///
  /// Tags created before lifetimes shipped have no [expiresAt] and never
  /// elapse, matching the sweeper, which skips them too.
  bool get hasElapsed {
    final expiry = expiresAt;
    return expiry != null && expiry.isBefore(DateTime.now());
  }

  /// Payable RIGHT NOW: the status allows it and the deadline hasn't passed.
  /// Use this anywhere a tag is being offered up for payment ahead of time
  /// (reminders, prompts, badges); [isPayable] alone is the gate for a Pay
  /// button the user is already looking at.
  bool get isActionable => isPayable && !hasElapsed;

  /// One source of truth for the status word every TagPay surface prints, so a
  /// newly added state can never be labelled "PENDING" by an older branch.
  String get statusLabel {
    switch (status) {
      case TagStatus.pending:
        return 'PENDING';
      case TagStatus.paying:
        return 'PROCESSING';
      case TagStatus.paid:
        return 'PAID';
      case TagStatus.cancelled:
        return 'CANCELLED';
      case TagStatus.declined:
        return 'DECLINED';
      case TagStatus.expired:
        return 'EXPIRED';
      case TagStatus.unknown:
        return 'UNKNOWN';
    }
  }

  @override
  List<Object?> get props => [
        id,
        taggerId,
        taggerTagPay,
        taggerName,
        taggedUserId,
        taggedUserTagPay,
        taggedUserName,
        amount,
        currency,
        description,
        status,
        createdAt,
        paidAt,
        expiresAt,
        respondedAt,
      ];
}
