part of 'category_selection.dart';

/// Service Category Model
/// Represents a category that can be selected for transactions
class ServiceCategory {
  final String id;
  final String serviceName;     // "transfer", "bill_payment", etc.
  final String subCategoryName; // "food", "airtime", etc.
  final int budgetCategory;     // ExpenseCategory enum value
  final String displayName;     // "Food Transfer", "Airtime Top-up"
  final String iconName;        // Icon identifier
  final Color color;            // Display color
  final bool isCustom;          // True if user-created

  const ServiceCategory({
    required this.id,
    required this.serviceName,
    required this.subCategoryName,
    required this.budgetCategory,
    required this.displayName,
    required this.iconName,
    required this.color,
    this.isCustom = false,
  });

  /// Create from proto
  factory ServiceCategory.fromProto(pb.ServiceCategoryItem proto) {
    return ServiceCategory(
      id: proto.id,
      serviceName: proto.serviceName,
      subCategoryName: proto.subCategoryName,
      budgetCategory: proto.budgetCategory,
      displayName: proto.displayName,
      iconName: proto.icon.isNotEmpty ? proto.icon : _defaultIconForCategory(proto.subCategoryName),
      color: _colorFromHex(proto.color.isNotEmpty ? proto.color : '#3B82F6'),
      isCustom: proto.isCustom,
    );
  }

  /// Get icon data for this category
  IconData get iconData => _iconDataFromString(iconName);

  /// The analytics label the accounts-service SQL `subCategoryExpr` expects
  /// (e.g. "food" → "Food & Drinks"). These MUST match the CASE expressions in
  /// transaction_repository.go so a transfer's narration prefix is attributed to
  /// the right spending subcategory. Shared by every send-funds flow so the
  /// short and long flows tag spend identically.
  String get analyticsLabel {
    return switch (subCategoryName.toLowerCase()) {
      'food' => 'Food & Drinks',
      'shopping' => 'Shopping',
      'transport' => 'Transportation',
      'entertainment' => 'Entertainment',
      'healthcare' => 'Healthcare',
      'education' => 'Education',
      'rent' => 'Rent & Mortgage',
      'gifts' => 'Gifts & Donations',
      'travel' => 'Travel',
      'groceries' => 'Groceries',
      'insurance' => 'Insurance',
      'personal_care' => 'Personal Care',
      'subscriptions' => 'Subscriptions',
      'bills' || 'utilities' => 'Bills & Utilities',
      _ => subCategoryName
          .replaceAll('_', ' ')
          .split(' ')
          .map((w) => w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : '')
          .join(' '),
    };
  }

  /// Builds the transfer narration shared by BOTH send-funds flows (long and
  /// short) so category attribution is identical. When [category] is set the
  /// narration is prefixed with its [analyticsLabel] (e.g. "Food & Drinks: …")
  /// so accounts-service's SQL subCategoryExpr buckets the spend; the detail is
  /// the user's [note] when present, else [defaultNarration] (e.g.
  /// "Transfer from {name}") so the receiver still sees who sent it. With no
  /// category, the narration is the note (when given) or [defaultNarration].
  static String buildTransferNarration({
    ServiceCategory? category,
    String? note,
    required String defaultNarration,
  }) {
    final trimmedNote = (note ?? '').trim();
    final label = category?.analyticsLabel.trim() ?? '';
    if (category != null && label.isNotEmpty) {
      final detail = trimmedNote.isNotEmpty ? trimmedNote : 'Transfer';
      return '$label: $detail';
    }
    // No category (or a category with a blank label) → note, else the default.
    return trimmedNote.isNotEmpty ? trimmedNote : defaultNarration;
  }

  static String _defaultIconForCategory(String subCategory) {
    final defaults = {
      'food': 'restaurant',
      'shopping': 'shopping_bag',
      'rent': 'home',
      'gifts': 'card_giftcard',
      'transport': 'directions_car',
      'healthcare': 'medical_services',
      'airtime': 'phone_android',
      'electricity': 'bolt',
      'water': 'water_drop',
      'cable_tv': 'tv',
      'internet': 'router',
      'education': 'school',
      'stocks': 'trending_up',
      'crypto': 'currency_bitcoin',
    };
    return defaults[subCategory] ?? 'category';
  }

  static Color _colorFromHex(String hex) {
    try {
      var cleaned = hex.startsWith('#') ? hex.substring(1) : hex;
      // Expand 3-char hex to 6-char (e.g., "F00" -> "FF0000")
      if (cleaned.length == 3) {
        cleaned = cleaned[0] * 2 + cleaned[1] * 2 + cleaned[2] * 2;
      }
      if (cleaned.length == 6) {
        cleaned = 'FF$cleaned';
      }
      // Validate hex chars only
      if (!RegExp(r'^[0-9A-Fa-f]{8}$').hasMatch(cleaned)) {
        return const Color(0xFF3B82F6);
      }
      return Color(int.parse(cleaned, radix: 16));
    } catch (_) {
      return const Color(0xFF3B82F6); // Default blue on any parse error
    }
  }

  static IconData _iconDataFromString(String iconStr) {
    final iconMap = {
      'restaurant': Icons.restaurant,
      'shopping_bag': Icons.shopping_bag,
      'shopping_cart': Icons.shopping_cart,
      'home': Icons.home,
      'card_giftcard': Icons.card_giftcard,
      'directions_car': Icons.directions_car,
      'medical_services': Icons.medical_services,
      'phone_android': Icons.phone_android,
      'bolt': Icons.bolt,
      'water_drop': Icons.water_drop,
      'tv': Icons.tv,
      'router': Icons.router,
      'school': Icons.school,
      'trending_up': Icons.trending_up,
      'category': Icons.category,
      'currency_bitcoin': Icons.currency_bitcoin,
      'flight': Icons.flight,
      'security': Icons.security,
      'spa': Icons.spa,
      'subscriptions': Icons.subscriptions,
      'movie': Icons.movie,
      'local_gas_station': Icons.local_gas_station,
      'receipt': Icons.receipt,
      'qr_code_2': Icons.qr_code_2,
      'description': Icons.description,
      'account_balance': Icons.account_balance,
    };
    return iconMap[iconStr] ?? Icons.category;
  }

  /// Common transfer categories (fallback when backend unreachable).
  /// Must stay in sync with statistics-service seeds/categories.go.
  static const commonTransferCategories = [
    ServiceCategory(
      id: 'cat-food',
      serviceName: 'transfer',
      subCategoryName: 'food',
      budgetCategory: 1,
      displayName: 'Food & Dining',
      iconName: 'restaurant',
      color: Color(0xFFFF6B6B),
    ),
    ServiceCategory(
      id: 'cat-transport',
      serviceName: 'transfer',
      subCategoryName: 'transport',
      budgetCategory: 2,
      displayName: 'Transportation',
      iconName: 'directions_car',
      color: Color(0xFF4ECDC4),
    ),
    ServiceCategory(
      id: 'cat-shopping',
      serviceName: 'transfer',
      subCategoryName: 'shopping',
      budgetCategory: 3,
      displayName: 'Shopping',
      iconName: 'shopping_bag',
      color: Color(0xFF45B7D1),
    ),
    ServiceCategory(
      id: 'cat-entertainment',
      serviceName: 'transfer',
      subCategoryName: 'entertainment',
      budgetCategory: 4,
      displayName: 'Entertainment',
      iconName: 'movie',
      color: Color(0xFFA29BFE),
    ),
    ServiceCategory(
      id: 'cat-healthcare',
      serviceName: 'transfer',
      subCategoryName: 'healthcare',
      budgetCategory: 6,
      displayName: 'Healthcare',
      iconName: 'medical_services',
      color: Color(0xFFFECA57),
    ),
    ServiceCategory(
      id: 'cat-education',
      serviceName: 'transfer',
      subCategoryName: 'education',
      budgetCategory: 7,
      displayName: 'Education',
      iconName: 'school',
      color: Color(0xFFDDA0DD),
    ),
    ServiceCategory(
      id: 'cat-travel',
      serviceName: 'transfer',
      subCategoryName: 'travel',
      budgetCategory: 8,
      displayName: 'Travel',
      iconName: 'flight',
      color: Color(0xFFFF7043),
    ),
    ServiceCategory(
      id: 'cat-groceries',
      serviceName: 'transfer',
      subCategoryName: 'groceries',
      budgetCategory: 9,
      displayName: 'Groceries',
      iconName: 'shopping_cart',
      color: Color(0xFF66BB6A),
    ),
    ServiceCategory(
      id: 'cat-rent',
      serviceName: 'transfer',
      subCategoryName: 'rent',
      budgetCategory: 10,
      displayName: 'Rent & Mortgage',
      iconName: 'home',
      color: Color(0xFFBB8FCE),
    ),
    ServiceCategory(
      id: 'cat-insurance',
      serviceName: 'transfer',
      subCategoryName: 'insurance',
      budgetCategory: 11,
      displayName: 'Insurance',
      iconName: 'security',
      color: Color(0xFF5C6BC0),
    ),
    ServiceCategory(
      id: 'cat-gifts',
      serviceName: 'transfer',
      subCategoryName: 'gifts',
      budgetCategory: 13,
      displayName: 'Gifts & Donations',
      iconName: 'card_giftcard',
      color: Color(0xFFFF6B9D),
    ),
    ServiceCategory(
      id: 'cat-personal-care',
      serviceName: 'transfer',
      subCategoryName: 'personal_care',
      budgetCategory: 14,
      displayName: 'Personal Care',
      iconName: 'spa',
      color: Color(0xFFEC407A),
    ),
    ServiceCategory(
      id: 'cat-subscriptions',
      serviceName: 'transfer',
      subCategoryName: 'subscriptions',
      budgetCategory: 15,
      displayName: 'Subscriptions',
      iconName: 'subscriptions',
      color: Color(0xFFAB47BC),
    ),
    ServiceCategory(
      id: 'cat-other',
      serviceName: 'transfer',
      subCategoryName: 'other',
      budgetCategory: 16,
      displayName: 'Other',
      iconName: 'category',
      color: Color(0xFF95A5A6),
    ),
  ];
}

/// Category Selection Widget (Inline)
/// Displays as a compact row of selectable category chips
class CategorySelectionWidget extends StatelessWidget {
  final String serviceName;
  final ServiceCategory? selectedCategory;
  final Function(ServiceCategory) onCategorySelected;
  final List<ServiceCategory>? availableCategories;

  const CategorySelectionWidget({
    super.key,
    required this.serviceName,
    this.selectedCategory,
    required this.onCategorySelected,
    this.availableCategories,
  });

  @override
  Widget build(BuildContext context) {
    final categories = availableCategories ?? ServiceCategory.commonTransferCategories;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category (Optional)',
          style: TextStyle(
            fontSize: 14.sp,
            color: const Color(0xFF9CA3AF),
          ),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: categories.map((category) {
            final isSelected = selectedCategory?.id == category.id;
            return GestureDetector(
              onTap: () => onCategorySelected(category),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? category.color.withValues(alpha: 0.2)
                      : const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected ? category.color : Colors.transparent,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      category.iconData,
                      color: isSelected ? category.color : const Color(0xFF9CA3AF),
                      size: 16.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      category.displayName,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? category.color : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
