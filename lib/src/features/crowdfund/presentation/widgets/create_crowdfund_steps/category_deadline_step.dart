import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/crowdfund_entities.dart';

class CategoryDeadlineStep extends StatelessWidget {
  final String selectedCategory;
  final List<String> categories;
  final DateTime? selectedDeadline;
  final CrowdfundVisibility selectedVisibility;
  final Function(String) onCategoryChanged;
  final Function(DateTime?) onDeadlineChanged;
  final Function(CrowdfundVisibility) onVisibilityChanged;

  const CategoryDeadlineStep({
    super.key,
    required this.selectedCategory,
    required this.categories,
    required this.selectedDeadline,
    required this.selectedVisibility,
    required this.onCategoryChanged,
    required this.onDeadlineChanged,
    required this.onVisibilityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon header
          Center(
            child: Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                Icons.category_outlined,
                size: 40.sp,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Title
          Center(
            child: Text(
              'Category & Settings',
              style: GoogleFonts.inter(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Center(
            child: Text(
              'Help donors discover your campaign',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ),
          SizedBox(height: 32.h),

          // Category selection
          _buildLabel('Category'),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: categories.map((category) {
              final isSelected = selectedCategory == category;
              return GestureDetector(
                onTap: () => onCategoryChanged(category),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? const LinearGradient(
                            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    color: isSelected ? null : const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    category,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 24.h),

          // Deadline selector
          _buildLabel('Deadline (Optional)'),
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: () => _selectDeadline(context),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedDeadline != null
                        ? '${selectedDeadline!.day}/${selectedDeadline!.month}/${selectedDeadline!.year}'
                        : 'Select deadline',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: selectedDeadline != null
                          ? Colors.white
                          : const Color(0xFF6B7280),
                    ),
                  ),
                  Row(
                    children: [
                      if (selectedDeadline != null)
                        GestureDetector(
                          onTap: () => onDeadlineChanged(null),
                          child: Icon(
                            Icons.clear,
                            color: const Color(0xFF6B7280),
                            size: 20.sp,
                          ),
                        ),
                      Icon(
                        Icons.calendar_today,
                        color: const Color(0xFF6366F1),
                        size: 20.sp,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Visibility selector
          _buildLabel('Campaign Visibility'),
          SizedBox(height: 12.h),
          ...CrowdfundVisibility.values.map((visibility) {
            final isSelected = selectedVisibility == visibility;
            return GestureDetector(
              onTap: () => onVisibilityChanged(visibility),
              child: Container(
                margin: EdgeInsets.only(bottom: 8.h),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            const Color(0xFF6366F1).withValues(alpha: 0.2),
                            const Color(0xFF8B5CF6).withValues(alpha: 0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: isSelected ? null : const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      _getVisibilityIcon(visibility),
                      color: isSelected
                          ? const Color(0xFF6366F1)
                          : const Color(0xFF6B7280),
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getVisibilityLabel(visibility),
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            _getVisibilityDescription(visibility),
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF9CA3AF),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      Icon(
                        Icons.check_circle,
                        color: const Color(0xFF6366F1),
                        size: 20.sp,
                      ),
                  ],
                ),
              ),
            );
          }),
          SizedBox(height: 32.h),

          // Info card
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6366F1).withValues(alpha: 0.1),
                  const Color(0xFF8B5CF6).withValues(alpha: 0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.public,
                  color: const Color(0xFF6366F1),
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Public campaigns are discoverable by everyone. Private campaigns are only accessible via direct link.',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  IconData _getVisibilityIcon(CrowdfundVisibility visibility) {
    switch (visibility) {
      case CrowdfundVisibility.public:
        return Icons.public;
      case CrowdfundVisibility.private:
        return Icons.lock;
      case CrowdfundVisibility.unlisted:
        return Icons.link;
    }
  }

  String _getVisibilityLabel(CrowdfundVisibility visibility) {
    switch (visibility) {
      case CrowdfundVisibility.public:
        return 'Public';
      case CrowdfundVisibility.private:
        return 'Private';
      case CrowdfundVisibility.unlisted:
        return 'Unlisted';
    }
  }

  String _getVisibilityDescription(CrowdfundVisibility visibility) {
    switch (visibility) {
      case CrowdfundVisibility.public:
        return 'Anyone can find and donate';
      case CrowdfundVisibility.private:
        return 'Only you can see this campaign';
      case CrowdfundVisibility.unlisted:
        return 'Anyone with the link can donate';
    }
  }

  Future<void> _selectDeadline(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF6366F1),
              surface: Color(0xFF1F1F1F),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      onDeadlineChanged(picked);
    }
  }
}
