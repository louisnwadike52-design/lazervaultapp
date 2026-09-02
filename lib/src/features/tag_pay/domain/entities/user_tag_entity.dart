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

enum TagStatus {
  pending,
  paid,
  cancelled,
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
  bool get isPaid => status == TagStatus.paid;
  bool get isCancelled => status == TagStatus.cancelled;

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
      ];
}
