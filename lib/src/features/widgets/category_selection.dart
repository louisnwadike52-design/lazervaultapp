import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/generated/statistics.pb.dart' as pb;
import 'package:lazervault/src/features/statistics/cubit/budget_cubit.dart';

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

/// Category Selection Bottom Sheet
/// Displays a grid of categories for user selection
/// When "Other" is tapped, shows a text field to create a custom category
class CategorySelectionBottomSheet extends StatefulWidget {
  final String serviceName;
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
  State<CategorySelectionBottomSheet> createState() =>
      _CategorySelectionBottomSheetState();

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

class _CategorySelectionBottomSheetState
    extends State<CategorySelectionBottomSheet> {
  bool _showCustomInput = false;
  final TextEditingController _customNameController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  bool _isCreating = false;
  String _searchQuery = '';

  @override
  void dispose() {
    _customNameController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.categories ?? ServiceCategory.commonTransferCategories;
    final filteredItems = _searchQuery.isEmpty
        ? items
        : items.where((c) =>
            c.displayName.toLowerCase().contains(_searchQuery) ||
            c.subCategoryName.toLowerCase().contains(_searchQuery)).toList();

    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.75),
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
            padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 12.w),
            child: Row(
              children: [
                Icon(
                  Icons.category,
                  color: const Color(0xFF3B82F6),
                  size: 24.sp,
                ),
                SizedBox(width: 12.w),
                Text(
                  _showCustomInput ? 'New Category' : 'Select Category',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    if (_showCustomInput) {
                      setState(() => _showCustomInput = false);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(
                    _showCustomInput ? Icons.arrow_back : Icons.close,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
              ],
            ),
          ),
          if (_showCustomInput)
            _buildCustomCategoryInput()
          else ...[
            // Search bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextField(
                controller: _searchController,
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
                decoration: InputDecoration(
                  hintText: 'Search categories...',
                  hintStyle: TextStyle(color: const Color(0xFF6B7280), fontSize: 14.sp),
                  prefixIcon: Icon(Icons.search, color: const Color(0xFF6B7280), size: 20.sp),
                  filled: true,
                  fillColor: const Color(0xFF2D2D2D),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  isDense: true,
                ),
                onChanged: (value) {
                  setState(() => _searchQuery = value.toLowerCase());
                },
              ),
            ),
            SizedBox(height: 12.h),
            // Categories List (searchable, scrollable)
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: filteredItems.length + 1, // +1 for "Create custom" option
                itemBuilder: (context, index) {
                  if (index == filteredItems.length) {
                    // "Create custom category" option at bottom
                    return Padding(
                      padding: EdgeInsets.only(top: 4.h, bottom: 8.h),
                      child: GestureDetector(
                        onTap: () => setState(() => _showCustomInput = true),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2D2D2D),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: const Color(0xFF3B82F6).withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.add_circle_outline, color: const Color(0xFF3B82F6), size: 22.sp),
                              SizedBox(width: 12.w),
                              Text(
                                'Create Custom Category',
                                style: TextStyle(
                                  color: const Color(0xFF3B82F6),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  final category = filteredItems[index];
                  final isSelected = widget.selectedCategory?.id == category.id;

                  return Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: GestureDetector(
                      onTap: () => widget.onSelected(category),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? category.color.withValues(alpha: 0.15)
                              : const Color(0xFF2D2D2D),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: isSelected ? category.color : Colors.transparent,
                            width: isSelected ? 1.5 : 0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 36.w,
                              height: 36.w,
                              decoration: BoxDecoration(
                                color: category.color.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Icon(
                                category.iconData,
                                color: isSelected ? category.color : const Color(0xFF9CA3AF),
                                size: 20.sp,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                category.displayName,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                  color: isSelected ? category.color : Colors.white,
                                ),
                              ),
                            ),
                            if (isSelected)
                              Icon(Icons.check_circle, color: category.color, size: 20.sp),
                            if (category.isCustom)
                              Padding(
                                padding: EdgeInsets.only(left: 8.w),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Text(
                                    'Custom',
                                    style: TextStyle(color: const Color(0xFF3B82F6), fontSize: 10.sp),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildCustomCategoryInput() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter a name for your custom category',
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF9CA3AF),
            ),
          ),
          SizedBox(height: 12.h),
          TextField(
            controller: _customNameController,
            autofocus: true,
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
            decoration: InputDecoration(
              hintText: 'e.g., Gym Membership',
              hintStyle: TextStyle(color: const Color(0xFF6B7280), fontSize: 16.sp),
              filled: true,
              fillColor: const Color(0xFF2D2D2D),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            ),
            textCapitalization: TextCapitalization.words,
            onSubmitted: (_) => _createCustomCategory(),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isCreating ? null : _createCustomCategory,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: _isCreating
                  ? SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'Create Category',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _createCustomCategory() async {
    final name = _customNameController.text.trim();
    if (name.isEmpty) {
      // Show feedback for empty name
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a category name'),
            duration: Duration(seconds: 2),
          ),
        );
      }
      return;
    }

    // Dismiss keyboard before async work
    FocusScope.of(context).unfocus();
    setState(() => _isCreating = true);

    try {
      final budgetCubit = context.read<BudgetCubit>();
      final created = await budgetCubit.createCustomCategory(
        serviceName: widget.serviceName,
        displayName: name,
      );

      if (created != null && mounted) {
        widget.onSelected(created);
      } else if (mounted) {
        // Fallback: create a local-only category
        widget.onSelected(_buildLocalCategory(name));
      }
    } catch (e) {
      developer.log('Failed to create custom category', name: 'CategorySelection', error: e);
      if (mounted) {
        // Fallback on error
        widget.onSelected(_buildLocalCategory(name));
      }
    } finally {
      if (mounted) {
        setState(() => _isCreating = false);
      }
    }
  }

  ServiceCategory _buildLocalCategory(String name) {
    return ServiceCategory(
      id: 'custom-${DateTime.now().millisecondsSinceEpoch}',
      serviceName: widget.serviceName,
      subCategoryName: name.toLowerCase().replaceAll(' ', '_'),
      budgetCategory: 16,
      displayName: name,
      iconName: 'category',
      color: const Color(0xFF95A5A6),
      isCustom: true,
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
