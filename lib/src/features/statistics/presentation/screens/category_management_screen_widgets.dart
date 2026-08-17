part of 'category_management_screen.dart';

class _CategoryDisplayItem {
  final String originalName;
  final String displayName;
  final String parentCategory;
  final int displayOrder;
  final int transactionCount;
  final double amount;

  _CategoryDisplayItem({
    required this.originalName,
    required this.displayName,
    required this.parentCategory,
    required this.displayOrder,
    required this.transactionCount,
    required this.amount,
  });
}
