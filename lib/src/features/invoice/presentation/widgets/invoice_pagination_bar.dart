import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/invoice_theme_colors.dart';

/// A pagination bar widget showing page numbers with prev/next buttons.
/// Handles edge cases like too many pages by showing ellipsis.
class InvoicePaginationBar extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final bool hasNext;
  final bool hasPrevious;
  final ValueChanged<int> onPageChanged;

  const InvoicePaginationBar({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    required this.hasNext,
    required this.hasPrevious,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (totalPages <= 1) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        border: Border(
          top: BorderSide(color: InvoiceThemeColors.dividerColor, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Previous button
          _buildNavButton(
            icon: Icons.chevron_left,
            enabled: hasPrevious,
            onTap: () => onPageChanged(currentPage - 1),
          ),
          SizedBox(width: 4.w),

          // Page numbers
          ..._buildPageNumbers(),

          SizedBox(width: 4.w),
          // Next button
          _buildNavButton(
            icon: Icons.chevron_right,
            enabled: hasNext,
            onTap: () => onPageChanged(currentPage + 1),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageNumbers() {
    final pages = <Widget>[];
    final pageNumbers = _getVisiblePages();

    for (int i = 0; i < pageNumbers.length; i++) {
      final page = pageNumbers[i];
      if (page == -1) {
        // Ellipsis
        pages.add(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Text(
              '...',
              style: GoogleFonts.inter(
                color: InvoiceThemeColors.textGray400,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      } else {
        pages.add(_buildPageButton(page));
      }
    }

    return pages;
  }

  /// Determine which page numbers to show.
  /// For <= 7 pages, show all. Otherwise show first, last, current ± 1, with ellipsis.
  List<int> _getVisiblePages() {
    if (totalPages <= 7) {
      return List.generate(totalPages, (i) => i + 1);
    }

    final Set<int> visible = {};
    // Always show first and last
    visible.add(1);
    visible.add(totalPages);
    // Show current page and neighbors
    for (int i = currentPage - 1; i <= currentPage + 1; i++) {
      if (i >= 1 && i <= totalPages) visible.add(i);
    }

    final sorted = visible.toList()..sort();
    final result = <int>[];

    for (int i = 0; i < sorted.length; i++) {
      if (i > 0 && sorted[i] - sorted[i - 1] > 1) {
        result.add(-1); // ellipsis
      }
      result.add(sorted[i]);
    }

    return result;
  }

  Widget _buildPageButton(int page) {
    final isSelected = page == currentPage;
    return GestureDetector(
      onTap: isSelected ? null : () => onPageChanged(page),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        width: 32.w,
        height: 32.w,
        decoration: BoxDecoration(
          color: isSelected
              ? InvoiceThemeColors.primaryPurple
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Text(
            '$page',
            style: GoogleFonts.inter(
              color: isSelected ? Colors.white : InvoiceThemeColors.textGray400,
              fontSize: 13.sp,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 32.w,
        height: 32.w,
        decoration: BoxDecoration(
          color: enabled
              ? InvoiceThemeColors.primaryPurple.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          icon,
          size: 18.sp,
          color: enabled
              ? InvoiceThemeColors.primaryPurple
              : InvoiceThemeColors.textGray500.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}
