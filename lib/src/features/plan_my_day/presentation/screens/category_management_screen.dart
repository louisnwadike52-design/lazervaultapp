import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lazervault/src/features/plan_my_day/domain/entities/category.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_cubit.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_state.dart';

class CategoryManagementScreen extends StatefulWidget {
  const CategoryManagementScreen({super.key});

  @override
  State<CategoryManagementScreen> createState() => _CategoryManagementScreenState();
}

class _CategoryManagementScreenState extends State<CategoryManagementScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PlanMyDayCubit>().loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1F1F),
        elevation: 0,
        title: const Text(
          'Categories',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => _showCreateCategoryDialog(),
          ),
        ],
      ),
      body: BlocBuilder<PlanMyDayCubit, PlanMyDayState>(
        builder: (context, state) {
          if (state is PlanMyDayLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
              ),
            );
          }

          if (state is PlanMyDayError) {
            return _buildErrorState(state as PlanMyDayError);
          }

          final categories = state is CategoryListLoaded
              ? (state as CategoryListLoaded).categories
              : <Category>[];

          if (categories.isEmpty) {
            return _buildEmptyState();
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return _buildCategoryItem(
                categories[index],
                onEdit: () => _showEditCategoryDialog(categories[index]),
                onDelete: () => _confirmDeleteCategory(categories[index]),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildCategoryItem(Category category, {VoidCallback? onEdit, VoidCallback? onDelete}) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: category.color != null
              ? Color(int.parse(category.color!.replaceAll('#', '0xFF')).withOpacity(0.3)
              : Colors.grey[800]!,
        ),
      ),
      child: Row(
        children: [
          // Category icon/color
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: category.color != null
                  ? Color(int.parse(category.color!.replaceAll('#', '0xFF')))
                  : const Color(0xFF3B82F6),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: category.icon != null
                ? Center(
                    child: Text(
                      _getIconEmoji(category.icon!),
                      style: const TextStyle(fontSize: 20),
                    ),
                  )
                : Icon(
                    Icons.label,
                    color: Colors.white,
                    size: 20,
                  ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  _getTypeLabel(category.type),
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          // Actions
          if (onEdit != null)
            IconButton(
              icon: const Icon(Icons.edit_outlined, color: Color(0xFF3B82F6), size: 20),
              onPressed: onEdit,
            ),
          if (onDelete != null)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444), size: 20),
              onPressed: onDelete,
            ),
        ],
      ),
    );
  }

  Widget _buildErrorState(PlanMyDayError error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            error.isNetworkError
                ? Icons.wifi_off
                : error.isAuthError
                    ? Icons.lock_outline
                    : Icons.error_outline,
            color: Colors.grey[600],
            size: 48,
          ),
          SizedBox(height: 16.h),
          Text(
            error.message,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () => context.read<PlanMyDayCubit>().loadCategories(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.label_outline,
            color: Colors.grey[600],
            size: 48,
          ),
          SizedBox(height: 16.h),
          Text(
            'No categories yet',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Create categories to organize your tasks and events',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton.icon(
            onPressed: () => _showCreateCategoryDialog(),
            icon: const Icon(Icons.add),
            label: 'Create Category',
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
            ),
          ),
        ],
      ),
    );
  }

  void _showCreateCategoryDialog() {
    final nameController = TextEditingController();
    String selectedIcon = 'label';
    String selectedColor = '#3B82F6';
    String selectedType = 'both';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: const Color(0xFF1F1F1F),
            title: const Text(
              'Create Category',
              style: TextStyle(color: Colors.white),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                  controller: nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.grey[400]),
                    hintText: 'e.g., Work',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    filled: true,
                    fillColor: const Color(0xFF2D2D2D),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: Colors.grey[800]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: Color(0xFF3B82F6)),
                    ),
                  ),
                ),
                  SizedBox(height: 16.h),
                  _buildIconSelector(selectedIcon, (icon) {
                    setDialogState(() {
                      selectedIcon = icon;
                    });
                  }),
                  SizedBox(height: 16.h),
                  _buildColorSelector(selectedColor, (color) {
                    setDialogState(() {
                      selectedColor = color;
                    });
                  }),
                  SizedBox(height: 16.h),
                  _buildTypeSelector(selectedType, (type) {
                    setDialogState(() {
                      selectedType = type;
                    });
                  }),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Color(0xFF3B82F6)),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (nameController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter a name')),
                    );
                    return;
                  }

                  context.read<PlanMyDayCubit>().createCategory(
                    name: nameController.text.trim(),
                    icon: selectedIcon,
                    color: selectedColor,
                    type: selectedType,
                  );

                  if (mounted) Navigator.pop(context);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Category created')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                ),
                child: const Text('Create', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showEditCategoryDialog(Category category) {
    final nameController = TextEditingController(text: category.name);
    String selectedIcon = category.icon ?? 'label';
    String selectedColor = category.color ?? '#3B82F6';
    String selectedType = category.type;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: const Color(0xFF1F1F1F),
            title: const Text(
              'Edit Category',
              style: TextStyle(color: Colors.white),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      filled: true,
                      fillColor: const Color(0xFF2D2D2D),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.grey[800]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius(8.r),
                        borderSide: const BorderSide(color: Color(0xFF3B82F6)),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildIconSelector(selectedIcon, (icon) {
                    setDialogState(() {
                      selectedIcon = icon;
                    });
                  }),
                  SizedBox(height: 16.h),
                  _buildColorSelector(selectedColor, (color) {
                    setDialogState(() {
                      selectedColor = color;
                    });
                  }),
                  SizedBox(height: 16.h),
                  _buildTypeSelector(selectedType, (type) {
                    setDialogState(() {
                      selectedType = type;
                    });
                  }),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Color(0xFF3B82F6)),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (nameController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter a name')),
                    );
                    return;
                  }

                  context.read<PlanMyDayCubit>().updateCategory(
                    id: category.id,
                    name: nameController.text.trim(),
                    icon: selectedIcon,
                    color: selectedColor,
                  );

                  if (mounted) Navigator.pop(context);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Category updated')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                ),
                child: const Text('Save', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      ),
    );
  }

  void _confirmDeleteCategory(Category category) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: const Text(
          'Delete Category',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to delete "${category.name}"? This action cannot be undone.',
          style: TextStyle(color: Colors.grey[300]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF3B82F6)),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              context.read<PlanMyDayCubit>().deleteCategory(category.id);
              if (mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Category deleted')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
            ),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildIconSelector(String selectedIcon, Function(String) onSelected) {
    final icons = {
      'label': '🏷️',
      'work': '💼',
      'personal': '👤',
      'shopping': '🛒',
      'health': '💪',
      'finance': '💰',
      'travel': '✈️',
      'education': '📚',
      'family': '👨‍👩‍👧‍👦',
      'social': '👥',
      'entertainment': '🎮',
      'sports': '⚽',
      'music': '🎵',
      'art': '🎨',
      'food': '🍕',
      'home': '🏠',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Icon',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: icons.entries.map((entry) {
            final isSelected = selectedIcon == entry.key;
            return GestureDetector(
              onTap: () => onSelected(entry.key),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF3B82F6).withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF3B82F6)
                        : Colors.grey[700]!,
                  ),
                ),
                child: Text(
                  entry.value,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildColorSelector(String selectedColor, Function(String) onSelected) {
    final colors = [
      '#3B82F6', // Blue
      '#10B981', // Green
      '#F59E0B', // Orange
      '#EF4444', // Red
      '#8B5CF6', // Purple
      '#EC4899', // Pink
      '#14B8A6', // Teal
      '#F97316', // Orange Red
      '#6366F1', // Indigo
      '#64748B', // Slate
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: colors.map((color) {
            final isSelected = selectedColor == color;
            return GestureDetector(
              onTap: () => onSelected(color),
              child: Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: Color(int.parse(color.replaceAll('#', '0xFF'))),
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(
                          color: Colors.white,
                          width: 2,
                        )
                      : null,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTypeSelector(String selectedType, Function(String) onSelected) {
    final types = [
      ('both', 'Tasks & Events'),
      ('task', 'Tasks Only'),
      ('event', 'Events Only'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Applies To',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 8.h),
        ...types.map((type) {
          final isSelected = selectedType == type.$1;
          return RadioListTile<String>(
            title: Text(
              type.$2,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[400],
                fontSize: 14.sp,
              ),
            ),
            value: type.$1,
            groupValue: selectedType,
            onChanged: (value) => onSelected(value!),
            activeColor: const Color(0xFF3B82F6),
            contentPadding: EdgeInsets.zero,
          );
        }).toList(),
      ],
    );
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case 'event':
        return 'Events';
      case 'task':
        return 'Tasks';
      case 'both':
      default:
        return 'All';
    }
  }

  String _getIconEmoji(String icon) {
    final iconMap = {
      'label': '🏷️',
      'work': '💼',
      'personal': '👤',
      'shopping': '🛒',
      'health': '💪',
      'finance': '💰',
      'travel': '✈️',
      'education': '📚',
      'family': '👨‍👩‍👧‍👦',
      'social': '👥',
      'entertainment': '🎮',
      'sports': '⚽',
      'music': '🎵',
      'art': '🎨',
      'food': '🍕',
      'home': '🏠',
    };
    return iconMap[icon] ?? '🏷️';
  }
}
