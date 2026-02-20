import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/generated/statistics.pb.dart' as pb;

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

  const ServiceCategory({
    required this.id,
    required this.serviceName,
    required this.subCategoryName,
    required this.budgetCategory,
    required this.displayName,
    required this.iconName,
    required this.color,
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
    );
  }

  /// Get icon data for this category
  IconData get iconData => _iconDataFromString(iconName);

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
    final buffer = StringBuffer();
    if (hex.startsWith('#')) {
      buffer.write(hex.replaceFirst('#', ''));
    } else {
      buffer.write(hex);
    }
    if (buffer.length == 6) {
      buffer.write('FF');
    }
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  IconData _iconDataFromString(String iconStr) {
    final iconMap = {
      'restaurant': Icons.restaurant,
      'shopping_bag': Icons.shopping_bag,
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
    };
    return iconMap[iconStr] ?? Icons.category;
  }

  /// Common transfer categories
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
      id: 'cat-shopping',
      serviceName: 'transfer',
      subCategoryName: 'shopping',
      budgetCategory: 3,
      displayName: 'Shopping',
      iconName: 'shopping_bag',
      color: Color(0xFF45B7D1),
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
      id: 'cat-gifts',
      serviceName: 'transfer',
      subCategoryName: 'gifts',
      budgetCategory: 13,
      displayName: 'Gifts & Donations',
      iconName: 'card_giftcard',
      color: Color(0xFFFF6B9D),
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
      id: 'cat-healthcare',
      serviceName: 'transfer',
      subCategoryName: 'healthcare',
      budgetCategory: 6,
      displayName: 'Healthcare',
      iconName: 'medical_services',
      color: Color(0xFFFECA57),
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

/// Category Selection Bottom Sheet
/// Displays a list of categories for user selection
class CategorySelectionBottomSheet extends StatelessWidget {
  final String serviceName;    // "transfer", "bill_payment", etc.
  final Function(ServiceCategory) onSelected;
  final List<ServiceCategory>? categories;
  final ServiceCategory? selectedCategory;

  const CategorySelectionBottomSheet({
    super.key,
    required this.serviceName,
    required this.onSelected,
    this.categories,
    this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    final items = categories ?? ServiceCategory.commonTransferCategories;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D2D),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          // Header
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                Icon(
                  Icons.category,
                  color: const Color(0xFF3B82F6),
                  size: 24.sp,
                ),
                SizedBox(width: 12.w),
                Text(
                  'Select Category',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: Colors.white, size: 20.sp),
                ),
              ],
            ),
          ),
          // Categories Grid
          Flexible(
            child: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final category = items[index];
                final isSelected = selectedCategory?.id == category.id;

                return GestureDetector(
                  onTap: () {
                    onSelected(category);
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? category.color.withValues(alpha: 0.2)
                          : const Color(0xFF2D2D2D),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: isSelected ? category.color : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          category.iconData,
                          color: isSelected ? category.color : const Color(0xFF9CA3AF),
                          size: 24.sp,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          category.displayName,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? category.color : Colors.white,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  /// Show the bottom sheet
  static Future<ServiceCategory?> show(
    BuildContext context, {
    required String serviceName,
    List<ServiceCategory>? categories,
    ServiceCategory? selectedCategory,
  }) {
    return showModalBottomSheet<ServiceCategory>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => CategorySelectionBottomSheet(
        serviceName: serviceName,
        categories: categories,
        selectedCategory: selectedCategory,
        onSelected: (category) => Navigator.pop(context, category),
      ),
    );
  }
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
