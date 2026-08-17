part of 'statistics.dart';

// ==================== WIDGET CLASSES ====================

/// A dark, rounded collapsible card used to group the statistics sections so
/// only what the user opens renders. LAZY: the heavy child subtree (charts) is
/// built ONLY while expanded — a collapsed section never builds its content.
class _CollapsibleSection extends StatefulWidget {
  final String title;
  final Widget? trailing;
  final bool initiallyExpanded;
  final Widget Function(BuildContext) childBuilder;

  const _CollapsibleSection({
    super.key,
    required this.title,
    required this.childBuilder,
    this.trailing,
    this.initiallyExpanded = false,
  });

  @override
  State<_CollapsibleSection> createState() => _CollapsibleSectionState();
}

class _CollapsibleSectionState extends State<_CollapsibleSection> {
  late bool _expanded = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(14.r),
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (widget.trailing != null) ...[
                    widget.trailing!,
                    SizedBox(width: 8.w),
                  ],
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 180),
                    child: Icon(Icons.keyboard_arrow_down_rounded,
                        color: const Color(0xFF9CA3AF), size: 22.sp),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: _expanded
                ? Padding(
                    padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 14.h),
                    child: widget.childBuilder(context),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final _FeatureItem feature;

  const _FeatureCard({required this.feature});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(feature.route, arguments: feature.arguments),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: feature.color.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: feature.color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    feature.icon,
                    color: feature.color,
                    size: 22.sp,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: feature.color.withValues(alpha: 0.5),
                  size: 20.sp,
                ),
              ],
            ),
            const Spacer(),
            Text(
              feature.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              feature.description,
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final String trend;
  final bool isPositive;

  const _QuickStatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.trend,
    this.isPositive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color.withValues(alpha: 0.8), size: 14.sp),
              SizedBox(width: 4.w),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 11.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: (isPositive ? Colors.white : const Color(0xFFEF4444)).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              trend,
              style: TextStyle(
                color: isPositive ? Colors.white : const Color(0xFFFFCDD2),
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final String categoryName;
  final double amount;
  final double total;

  const _CategoryItem({
    required this.categoryName,
    required this.amount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final safeTotal = total > 0 ? total : 1.0;
    final percentage = (amount / safeTotal * 100).toStringAsFixed(1);
    final displayName = _friendlyCategoryName(categoryName);
    final categoryColor = _getCategoryColor(categoryName);
    final categoryIcon = ServiceCategories.getIcon(categoryName);

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 28.w,
                      height: 28.w,
                      decoration: BoxDecoration(
                        color: categoryColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Icon(
                        categoryIcon,
                        color: categoryColor,
                        size: 16.sp,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Flexible(
                      child: Text(
                        displayName,
                        style: TextStyle(color: const Color(0xFFD1D5DB), fontSize: 13.sp),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      '$percentage%',
                      style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 11.sp),
                    ),
                  ],
                ),
              ),
              Text(
                CurrencySymbols.formatAmount(amount),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          LinearProgressIndicator(
            value: (amount / safeTotal).clamp(0.0, 1.0),
            backgroundColor: Colors.white10,
            valueColor: AlwaysStoppedAnimation<Color>(categoryColor),
            minHeight: 3.h,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String route;
  final Map<String, dynamic>? arguments;

  _FeatureItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.route,
    this.arguments,
  });
}
