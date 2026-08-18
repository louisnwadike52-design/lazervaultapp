import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/generated/statistics.pb.dart' as pb;
import 'package:lazervault/src/features/statistics/cubit/budget_cubit.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
part 'category_selection_widgets.dart';


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
      // A modal builder does NOT inherit BlocProviders from below the Navigator,
      // so provide the app-wide BudgetCubit (a GetIt singleton) explicitly —
      // otherwise "Create custom category" hits ProviderNotFound and can only
      // ever fall back to a local-only, non-persisted category.
      builder: (context) => BlocProvider<BudgetCubit>.value(
        value: serviceLocator<BudgetCubit>(),
        child: CategorySelectionBottomSheet(
          serviceName: serviceName,
          categories: categories,
          selectedCategory: selectedCategory,
          onSelected: (category) => Navigator.pop(context, category),
        ),
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

    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      // Lift the sheet above the keyboard so the custom-category input (which
      // autofocuses on open) is visible instead of hidden behind the keyboard
      // (previously it looked like an empty overlay with no content).
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
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
                  ? LazerVaultLoader.small()
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
