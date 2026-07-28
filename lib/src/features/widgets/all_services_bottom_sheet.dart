import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/src/features/widgets/app_service_builder.dart';

/// Bottom sheet displaying all available services in a scrollable grid
class AllServicesBottomSheet extends StatefulWidget {
  final List<AppService> services;

  const AllServicesBottomSheet({
    super.key,
    required this.services,
  });

  @override
  State<AllServicesBottomSheet> createState() => _AllServicesBottomSheetState();
}

class _AllServicesBottomSheetState extends State<AllServicesBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  static const Color _accent = Color.fromARGB(255, 78, 3, 208);

  /// Services filtered by the current search query (case-insensitive on the
  /// display name). Returns the full list when nothing has been typed.
  List<AppService> get _filteredServices {
    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) return widget.services;
    return widget.services
        .where((s) => s.name.toLowerCase().contains(query))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28.r),
                  topRight: Radius.circular(28.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildHeader(),
                  _buildSearchField(),
                  _buildDivider(),
                  Expanded(
                    child: _buildServicesGrid(scrollController),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 16.h),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 20.h),

          // Title and close button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'All Services',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                      letterSpacing: 0.3,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _searchQuery.trim().isEmpty
                        ? '${widget.services.length} services available'
                        : '${_filteredServices.length} of ${widget.services.length} services',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: _accent.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    size: 20.sp,
                    color: _accent,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 2.h, 24.w, 10.h),
      child: TextField(
        controller: _searchController,
        onChanged: (value) => setState(() => _searchQuery = value),
        textInputAction: TextInputAction.search,
        cursorColor: _accent,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.grey.withValues(alpha: 0.08),
          hintText: 'Search services',
          hintStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey[500],
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            size: 20.sp,
            color: _accent,
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                    FocusScope.of(context).unfocus();
                  },
                  child: Icon(
                    Icons.close_rounded,
                    size: 20.sp,
                    color: Colors.grey[600],
                  ),
                )
              : null,
          contentPadding: EdgeInsets.symmetric(vertical: 14.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide(color: _accent.withValues(alpha: 0.4), width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.grey.withValues(alpha: 0.2),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  static const int _gridCrossAxisCount = 4;

  Widget _buildServicesGrid(ScrollController scrollController) {
    final services = _filteredServices;

    if (services.isEmpty) {
      return _buildEmptyState(scrollController);
    }

    final crossSpacing = 8.w;
    final mainSpacing = 10.h;

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Size tiles so the FULL service list fits without scrolling — the
          // whole point of "View All" is to show everything at once. Sizing off
          // the full count (not the filtered count) keeps tiles a consistent
          // size while searching.
          final totalRows =
              (widget.services.length / _gridCrossAxisCount).ceil();
          final tileWidth =
              (constraints.maxWidth - (_gridCrossAxisCount - 1) * crossSpacing) /
                  _gridCrossAxisCount;
          final availHeight = constraints.maxHeight - (totalRows - 1) * mainSpacing;
          final tileHeight = totalRows > 0 ? availHeight / totalRows : tileWidth;
          // Clamp so tiles never get absurdly tall/short; on very small screens
          // the lower clamp lets the grid fall back to scrolling.
          final aspectRatio =
              (tileWidth / tileHeight).clamp(0.62, 1.05).toDouble();

          return GridView.builder(
            controller: scrollController,
            padding: EdgeInsets.zero,
            physics: const AlwaysScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _gridCrossAxisCount,
              crossAxisSpacing: crossSpacing,
              mainAxisSpacing: mainSpacing,
              childAspectRatio: aspectRatio,
            ),
            itemCount: services.length,
            itemBuilder: (context, index) {
              return _buildAnimatedServiceItem(services, index);
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(ScrollController scrollController) {
    // Keep the sheet draggable/dismissable even with no results by attaching
    // the scroll controller to a scrollable that fills the available space.
    return SingleChildScrollView(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 56.h),
        child: Column(
          children: [
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                color: _accent.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_off_rounded,
                size: 34.sp,
                color: _accent.withValues(alpha: 0.7),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'No services found',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Try a different search',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedServiceItem(List<AppService> services, int index) {
    final item = AppServiceBuilder(appService: services[index]);

    // While searching, skip the staggered intro so results update instantly
    // without re-animating every tile on each keystroke.
    if (_searchQuery.trim().isNotEmpty) {
      return item;
    }

    // Staggered animation delay based on index
    final delay = Duration(milliseconds: 50 * (index % 12));

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 400) + delay,
      curve: Curves.easeOutBack,
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        // Clamp values to ensure they're within valid ranges
        final clampedValue = value.clamp(0.0, 1.0);
        return Transform.scale(
          scale: clampedValue,
          child: Opacity(
            opacity: clampedValue,
            child: child,
          ),
        );
      },
      child: item,
    );
  }
}

/// Helper function to show the all services bottom sheet
void showAllServicesBottomSheet(
  BuildContext context,
  List<AppService> services,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => AllServicesBottomSheet(services: services),
  );
}
