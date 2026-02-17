import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/src/features/statistics/cubit/category_management_cubit.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;

String _friendlyCategoryName(String raw) => switch (raw.toLowerCase()) {
      'transfer' => 'Transfers',
      'deposit' => 'Deposits',
      'withdrawal' => 'Withdrawals',
      'fee' => 'Service Fees',
      'reversal' => 'Reversals',
      'payment' => 'Payments',
      'tag-pay' || 'tagpay' => 'TagPay',
      'invoice' => 'Invoices',
      'giftcards' || 'gift-cards' => 'Gift Cards',
      'airtime' => 'Airtime & Bills',
      'investment' || 'investments' => 'Investments',
      'core-payments' => 'Transfers',
      'banking' => 'Banking',
      'utility-payments' => 'Bills & Utilities',
      _ => raw
          .replaceAll('-', ' ')
          .replaceAll('_', ' ')
          .split(' ')
          .map((w) =>
              w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : '')
          .join(' '),
    };

class CategoryManagementScreen extends StatefulWidget {
  const CategoryManagementScreen({super.key});

  @override
  State<CategoryManagementScreen> createState() =>
      _CategoryManagementScreenState();
}

class _CategoryManagementScreenState extends State<CategoryManagementScreen> {
  // Local reordered list for drag-and-drop
  List<_CategoryDisplayItem> _categories = [];
  bool _hasReordered = false;

  @override
  void initState() {
    super.initState();
    context.read<CategoryManagementCubit>().loadCategories();
  }

  static const List<Color> categoryColors = [
    Color(0xFF4A90E2),
    Color(0xFFE2844A),
    Color(0xFF4AE28D),
    Color(0xFFE24A67),
    Color(0xFF9B4AE2),
    Color(0xFFE2E24A),
    Color(0xFF4AE2D4),
    Color(0xFFE24ABB),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Manage Categories',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          if (_hasReordered)
            TextButton(
              onPressed: _saveReorder,
              child: Text(
                'Save',
                style: TextStyle(
                  color: const Color(0xFF10B981),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      body: BlocConsumer<CategoryManagementCubit, CategoryManagementState>(
        listener: (context, state) {
          if (state is CategoryMappingUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFF10B981),
              ),
            );
          } else if (state is CategoriesReordered) {
            setState(() => _hasReordered = false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Categories reordered'),
                backgroundColor: Color(0xFF10B981),
              ),
            );
          } else if (state is CategoryManagementError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CategoryManagementLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }
          if (state is CategoryManagementLoaded) {
            _buildCategoryList(state);
          }
          if (_categories.isEmpty && state is! CategoryManagementLoading) {
            return _buildEmptyState();
          }
          return _buildContent();
        },
      ),
    );
  }

  void _buildCategoryList(CategoryManagementLoaded state) {
    if (_hasReordered) return; // Don't overwrite user's drag changes

    final mappingsByOriginal = <String, accounts_pb.UserCategoryMappingItem>{};
    for (final m in state.mappings) {
      mappingsByOriginal[m.originalCategory.toLowerCase()] = m;
    }

    _categories = state.allCategories.asMap().entries.map((entry) {
      final cat = entry.value;
      final mapping = mappingsByOriginal[cat.categoryName.toLowerCase()];
      return _CategoryDisplayItem(
        originalName: cat.categoryName,
        displayName: mapping?.customCategory ?? cat.categoryName,
        parentCategory: mapping?.parentCategory ?? '',
        displayOrder: mapping?.displayOrder ?? entry.key,
        transactionCount: cat.transactionCount,
        amount: cat.amount,
      );
    }).toList()
      ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.category_outlined, color: Colors.white60, size: 48.r),
          SizedBox(height: 12.h),
          Text(
            'No categories yet',
            style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            'Categories appear after you make transactions',
            style: TextStyle(color: const Color(0xFF6B7280), fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline,
                    color: const Color(0xFF3B82F6), size: 18.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Long-press and drag to reorder. Tap to rename.',
                    style: TextStyle(
                      color: const Color(0xFF93C5FD),
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ReorderableListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: _categories.length,
            onReorder: _onReorder,
            proxyDecorator: (child, index, animation) {
              return AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return Material(
                    color: Colors.transparent,
                    elevation: 4,
                    shadowColor: Colors.black54,
                    child: child,
                  );
                },
                child: child,
              );
            },
            itemBuilder: (context, index) {
              final cat = _categories[index];
              final color = categoryColors[index % categoryColors.length];
              return _buildCategoryTile(cat, color, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTile(
      _CategoryDisplayItem cat, Color color, int index) {
    final friendlyName = _friendlyCategoryName(cat.displayName);

    return Container(
      key: ValueKey(cat.originalName),
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        leading: Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Center(
            child: Icon(Icons.drag_indicator, color: color, size: 20.sp),
          ),
        ),
        title: Text(
          friendlyName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: cat.parentCategory.isNotEmpty
            ? Text(
                'Under: ${_friendlyCategoryName(cat.parentCategory)}',
                style: TextStyle(
                    color: const Color(0xFF6B7280), fontSize: 11.sp),
              )
            : Text(
                '${cat.transactionCount} transactions',
                style: TextStyle(
                    color: const Color(0xFF6B7280), fontSize: 11.sp),
              ),
        trailing: PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, color: Colors.white60, size: 20.sp),
          color: const Color(0xFF1F1F1F),
          onSelected: (value) => _handleMenuAction(value, cat),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'rename',
              child: Row(
                children: [
                  Icon(Icons.edit, color: Colors.white70, size: 18.sp),
                  SizedBox(width: 8.w),
                  Text('Rename',
                      style: TextStyle(
                          color: Colors.white, fontSize: 13.sp)),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'move',
              child: Row(
                children: [
                  Icon(Icons.drive_file_move_outline,
                      color: Colors.white70, size: 18.sp),
                  SizedBox(width: 8.w),
                  Text('Move to...',
                      style: TextStyle(
                          color: Colors.white, fontSize: 13.sp)),
                ],
              ),
            ),
            if (cat.displayName != cat.originalName)
              PopupMenuItem(
                value: 'reset',
                child: Row(
                  children: [
                    Icon(Icons.restore, color: Colors.orange, size: 18.sp),
                    SizedBox(width: 8.w),
                    Text('Reset Name',
                        style: TextStyle(
                            color: Colors.orange, fontSize: 13.sp)),
                  ],
                ),
              ),
          ],
        ),
        onTap: () => _showRenameDialog(cat),
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex--;
      final item = _categories.removeAt(oldIndex);
      _categories.insert(newIndex, item);
      _hasReordered = true;
    });
  }

  void _saveReorder() {
    final orderings = _categories.asMap().entries.map((entry) {
      return accounts_pb.CategoryOrderItem()
        ..originalCategory = entry.value.originalName
        ..displayOrder = entry.key;
    }).toList();

    context.read<CategoryManagementCubit>().reorderCategories(orderings);
  }

  void _handleMenuAction(String action, _CategoryDisplayItem cat) {
    switch (action) {
      case 'rename':
        _showRenameDialog(cat);
      case 'move':
        _showMoveDialog(cat);
      case 'reset':
        context.read<CategoryManagementCubit>().renameCategory(
              originalCategory: cat.originalName,
              customCategory: cat.originalName,
            );
    }
  }

  void _showRenameDialog(_CategoryDisplayItem cat) {
    final controller =
        TextEditingController(text: _friendlyCategoryName(cat.displayName));
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: Text(
          'Rename Category',
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Enter new name',
            hintStyle: const TextStyle(color: Color(0xFF6B7280)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFF3B82F6)),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel',
                style: TextStyle(color: Colors.white60, fontSize: 14.sp)),
          ),
          TextButton(
            onPressed: () {
              final newName = controller.text.trim();
              if (newName.isNotEmpty && newName != cat.displayName) {
                context.read<CategoryManagementCubit>().renameCategory(
                      originalCategory: cat.originalName,
                      customCategory: newName,
                    );
              }
              Navigator.pop(dialogContext);
            },
            child: Text('Save',
                style: TextStyle(
                    color: const Color(0xFF10B981), fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }

  void _showMoveDialog(_CategoryDisplayItem cat) {
    final otherCategories =
        _categories.where((c) => c.originalName != cat.originalName).toList();
    if (otherCategories.isEmpty) return;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: Text(
          'Move "${_friendlyCategoryName(cat.displayName)}" under...',
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: otherCategories.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return ListTile(
                  leading: Icon(Icons.remove_circle_outline,
                      color: Colors.orange, size: 20.sp),
                  title: Text('None (top level)',
                      style: TextStyle(
                          color: Colors.white, fontSize: 13.sp)),
                  onTap: () {
                    this
                        .context
                        .read<CategoryManagementCubit>()
                        .moveCategory(
                          originalCategory: cat.originalName,
                          parentCategory: '',
                        );
                    Navigator.pop(dialogContext);
                  },
                );
              }
              final target = otherCategories[index - 1];
              return ListTile(
                leading: Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    color: categoryColors[
                        (index - 1) % categoryColors.length],
                    shape: BoxShape.circle,
                  ),
                ),
                title: Text(
                  _friendlyCategoryName(target.displayName),
                  style:
                      TextStyle(color: Colors.white, fontSize: 13.sp),
                ),
                onTap: () {
                  this
                      .context
                      .read<CategoryManagementCubit>()
                      .moveCategory(
                        originalCategory: cat.originalName,
                        parentCategory: target.originalName,
                      );
                  Navigator.pop(dialogContext);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

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
