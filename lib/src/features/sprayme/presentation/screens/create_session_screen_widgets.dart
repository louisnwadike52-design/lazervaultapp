part of 'create_session_screen.dart';

class _OccasionType {
  final String label;
  final IconData icon;
  const _OccasionType(this.label, this.icon);
}

/// Provides occasion-based theming for SprayMe sessions.
/// Used by home screen and room screen for default backgrounds when no cover image is set.
class OccasionTheme {
  static List<Color> getGradient(String occasion) {
    switch (occasion.toLowerCase()) {
      case 'wedding':
        return const [Color(0xFFFF6B6B), Color(0xFFEE5A24)];
      case 'birthday':
        return const [Color(0xFF7C3AED), Color(0xFFFF6B00)];
      case 'graduation':
        return const [Color(0xFF3B82F6), Color(0xFF1D4ED8)];
      case 'baby shower':
      case 'naming ceremony':
        return const [Color(0xFFEC4899), Color(0xFFF9A8D4)];
      case 'housewarming':
        return const [Color(0xFFF59E0B), Color(0xFFEF4444)];
      case 'funeral':
        return const [Color(0xFF374151), Color(0xFF1F2937)];
      case 'promotion':
        return const [Color(0xFF10B981), Color(0xFF059669)];
      case 'engagement':
        return const [Color(0xFFEC4899), Color(0xFF8B5CF6)];
      case 'anniversary':
        return const [Color(0xFFD97706), Color(0xFFB45309)];
      case 'retirement':
        return const [Color(0xFF6366F1), Color(0xFF3B82F6)];
      case 'send-off':
        return const [Color(0xFFF59E0B), Color(0xFF3B82F6)];
      case 'house party':
        return const [Color(0xFF8B5CF6), Color(0xFFEC4899)];
      default:
        return const [Color(0xFF6366F1), Color(0xFF8B5CF6)];
    }
  }

  static IconData getIcon(String occasion) {
    for (final type in _occasionTypes) {
      if (type.label.toLowerCase() == occasion.toLowerCase()) {
        return type.icon;
      }
    }
    return Icons.celebration;
  }
}

// =============================================================================
// Occasion Picker Bottom Sheet
// =============================================================================

class _OccasionPickerSheet extends StatefulWidget {
  final String selectedOccasion;
  final ValueChanged<String> onSelect;

  const _OccasionPickerSheet({
    required this.selectedOccasion,
    required this.onSelect,
  });

  @override
  State<_OccasionPickerSheet> createState() => _OccasionPickerSheetState();
}

class _OccasionPickerSheetState extends State<_OccasionPickerSheet> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  List<_OccasionType> get _filteredOccasions {
    if (_searchQuery.isEmpty) return _occasionTypes.toList();
    final q = _searchQuery.toLowerCase();
    return _occasionTypes.where((t) => t.label.toLowerCase().contains(q)).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredOccasions;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          SizedBox(height: 8.h),
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xFF9CA3AF).withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 16.h),

          // Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Text(
                  'Select Occasion',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(Icons.close,
                      color: const Color(0xFF9CA3AF), size: 22.sp),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),

          // Search field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              height: 42.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: const Color(0xFF0A0A0A),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
              ),
              child: Row(
                children: [
                  Icon(Icons.search,
                      color: const Color(0xFF9CA3AF), size: 20.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (v) =>
                          setState(() => _searchQuery = v.trim()),
                      style: TextStyle(
                          color: Colors.white, fontSize: 14.sp),
                      decoration: InputDecoration(
                        hintText: 'Search occasions...',
                        hintStyle: TextStyle(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 14.sp),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8.h),
                      ),
                    ),
                  ),
                  if (_searchQuery.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        _searchController.clear();
                        setState(() => _searchQuery = '');
                      },
                      child: Icon(Icons.clear,
                          color: const Color(0xFF9CA3AF), size: 18.sp),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.h),

          Divider(color: const Color(0xFF2D2D2D), height: 1),

          // Occasions grid as pills
          Flexible(
            child: filtered.isEmpty
                ? Padding(
                    padding: EdgeInsets.all(40.w),
                    child: Text(
                      'No matching occasions',
                      style: TextStyle(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 14.sp),
                    ),
                  )
                : SingleChildScrollView(
                    padding: EdgeInsets.all(16.w),
                    child: Wrap(
                      spacing: 10.w,
                      runSpacing: 10.h,
                      children: filtered.map((occasion) {
                        final isSelected =
                            widget.selectedOccasion == occasion.label;
                        return GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            widget.onSelect(occasion.label);
                          },
                          child: AnimatedContainer(
                            duration:
                                const Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 12.h),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF7C3AED)
                                      .withValues(alpha: 0.2)
                                  : const Color(0xFF0A0A0A),
                              borderRadius:
                                  BorderRadius.circular(12.r),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF7C3AED)
                                    : const Color(0xFF2D2D2D),
                                width: isSelected ? 1.5 : 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  occasion.icon,
                                  size: 18.sp,
                                  color: isSelected
                                      ? const Color(0xFF7C3AED)
                                      : const Color(0xFF9CA3AF),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  occasion.label,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF9CA3AF),
                                    fontSize: 14.sp,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                                ),
                                if (isSelected) ...[
                                  SizedBox(width: 6.w),
                                  Icon(Icons.check,
                                      color:
                                          const Color(0xFF7C3AED),
                                      size: 16.sp),
                                ],
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 8.h),
        ],
      ),
    );
  }
}
