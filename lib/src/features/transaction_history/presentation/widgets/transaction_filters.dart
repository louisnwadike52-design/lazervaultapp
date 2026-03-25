import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/unified_transaction.dart';

/// Horizontal month selector chips — Revolut-style
class MonthFilterChips extends StatelessWidget {
  final int? selectedMonth; // 1-12, null = "All"
  final int? selectedYear;
  final ValueChanged<({int? month, int? year})> onChanged;

  const MonthFilterChips({
    super.key,
    this.selectedMonth,
    this.selectedYear,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final months = <({String label, int? month, int? year})>[
      (label: 'All', month: null, year: null),
    ];

    // Show last 12 months, current first
    for (int i = 0; i < 12; i++) {
      final date = DateTime(now.year, now.month - i, 1);
      months.add((
        label: DateFormat('MMM').format(date),
        month: date.month,
        year: date.year,
      ));
    }

    return SizedBox(
      height: 36.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: months.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final item = months[index];
          final isSelected = item.month == selectedMonth && item.year == selectedYear;

          return GestureDetector(
            onTap: () => onChanged((month: item.month, year: item.year)),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF581CD9)
                    : const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Text(
                item.label,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? Colors.white : const Color(0xFF8E8E93),
                  fontFamily: 'Inter',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Status filter row — "All" / "Completed" / "Pending" / "Failed" text tabs
class StatusFilterRow extends StatelessWidget {
  final UnifiedTransactionStatus? selectedStatus; // null = "All"
  final ValueChanged<UnifiedTransactionStatus?> onChanged;

  const StatusFilterRow({
    super.key,
    this.selectedStatus,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = <({String label, UnifiedTransactionStatus? status})>[
      (label: 'All', status: null),
      (label: 'Completed', status: UnifiedTransactionStatus.completed),
      (label: 'Pending', status: UnifiedTransactionStatus.pending),
      (label: 'Failed', status: UnifiedTransactionStatus.failed),
    ];

    return SizedBox(
      height: 36.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: tabs.length,
        separatorBuilder: (_, __) => SizedBox(width: 20.w),
        itemBuilder: (context, index) {
          final tab = tabs[index];
          final isSelected = tab.status == selectedStatus;

          return GestureDetector(
            onTap: () => onChanged(tab.status),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tab.label,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? Colors.white : const Color(0xFF8E8E93),
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  height: 2.h,
                  width: 24.w,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF581CD9)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(1.r),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Revolut-style search bar — pill-shaped
class TransactionSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final VoidCallback? onClear;

  const TransactionSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      height: 44.h,
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            color: const Color(0xFF8E8E93),
            size: 20.sp,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                fontFamily: 'Inter',
              ),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: const Color(0xFF8E8E93),
                  fontSize: 14.sp,
                  fontFamily: 'Inter',
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 10.h),
              ),
            ),
          ),
          if (controller.text.isNotEmpty)
            GestureDetector(
              onTap: onClear,
              child: Icon(
                Icons.clear_rounded,
                color: const Color(0xFF8E8E93),
                size: 18.sp,
              ),
            ),
        ],
      ),
    );
  }
}

/// Horizontal filter bar with individual per-category chips.
/// Each chip (Date, Status, Category, Type) opens its own bottom sheet.
class TransactionFilterBar extends StatelessWidget {
  final TransactionFilters? activeFilters;
  final VoidCallback onClearAll;
  final ValueChanged<TransactionFilters> onFiltersChanged;

  const TransactionFilterBar({
    super.key,
    this.activeFilters,
    required this.onClearAll,
    required this.onFiltersChanged,
  });

  bool get _hasDateFilter =>
      activeFilters?.startDate != null || activeFilters?.endDate != null;

  bool get _hasStatusFilter =>
      activeFilters?.statuses != null && activeFilters!.statuses!.isNotEmpty;

  bool get _hasCategoryFilter =>
      activeFilters?.serviceTypes != null && activeFilters!.serviceTypes!.isNotEmpty;

  bool get _hasTypeFilter =>
      activeFilters?.flows != null && activeFilters!.flows!.isNotEmpty;

  bool get _hasAnyFilter =>
      _hasDateFilter || _hasStatusFilter || _hasCategoryFilter || _hasTypeFilter;

  String _dateLabel() {
    if (!_hasDateFilter) return 'Date';
    final start = activeFilters!.startDate;
    final end = activeFilters!.endDate;
    if (start != null && end != null) {
      return '${DateFormat('d MMM').format(start)} - ${DateFormat('d MMM').format(end)}';
    } else if (start != null) {
      return 'From ${DateFormat('d MMM').format(start)}';
    } else {
      return 'Until ${DateFormat('d MMM').format(end!)}';
    }
  }

  String _statusLabel() {
    if (!_hasStatusFilter) return 'Status';
    final statuses = activeFilters!.statuses!;
    if (statuses.length == 1) return statuses.first.displayName;
    return '${statuses.length} statuses';
  }

  String _categoryLabel() {
    if (!_hasCategoryFilter) return 'Category';
    final types = activeFilters!.serviceTypes!;
    if (types.length == 1) return types.first.displayName;
    return '${types.length} categories';
  }

  String _typeLabel() {
    if (!_hasTypeFilter) return 'Type';
    final flows = activeFilters!.flows!;
    if (flows.length == 1) {
      return flows.first == TransactionFlow.incoming ? 'Incoming' : 'Outgoing';
    }
    return 'All types';
  }

  void _openDateSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _DateFilterSheet(
        startDate: activeFilters?.startDate,
        endDate: activeFilters?.endDate,
        onApply: (start, end) {
          final current = activeFilters ?? const TransactionFilters();
          onFiltersChanged(TransactionFilters(
            serviceTypes: current.serviceTypes,
            statuses: current.statuses,
            flows: current.flows,
            startDate: start,
            endDate: end != null
                ? DateTime(end.year, end.month, end.day, 23, 59, 59)
                : null,
            searchQuery: current.searchQuery,
          ));
        },
      ),
    );
  }

  void _openStatusSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _StatusFilterSheet(
        selected: activeFilters?.statuses?.toSet() ?? {},
        onApply: (statuses) {
          final current = activeFilters ?? const TransactionFilters();
          onFiltersChanged(TransactionFilters(
            serviceTypes: current.serviceTypes,
            statuses: statuses.isNotEmpty ? statuses.toList() : null,
            flows: current.flows,
            startDate: current.startDate,
            endDate: current.endDate,
            searchQuery: current.searchQuery,
          ));
        },
      ),
    );
  }

  void _openCategorySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CategoryFilterSheet(
        selected: activeFilters?.serviceTypes?.toSet() ?? {},
        onApply: (types) {
          final current = activeFilters ?? const TransactionFilters();
          onFiltersChanged(TransactionFilters(
            serviceTypes: types.isNotEmpty ? types.toList() : null,
            statuses: current.statuses,
            flows: current.flows,
            startDate: current.startDate,
            endDate: current.endDate,
            searchQuery: current.searchQuery,
          ));
        },
      ),
    );
  }

  void _openTypeSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _TypeFilterSheet(
        selectedFlow: activeFilters?.flows?.isNotEmpty == true
            ? activeFilters!.flows!.first
            : null,
        onApply: (flow) {
          final current = activeFilters ?? const TransactionFilters();
          onFiltersChanged(TransactionFilters(
            serviceTypes: current.serviceTypes,
            statuses: current.statuses,
            flows: flow != null ? [flow] : null,
            startDate: current.startDate,
            endDate: current.endDate,
            searchQuery: current.searchQuery,
          ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          _buildFilterChip(
            context,
            label: _dateLabel(),
            icon: Icons.calendar_today_rounded,
            isActive: _hasDateFilter,
            onTap: () => _openDateSheet(context),
          ),
          SizedBox(width: 8.w),
          _buildFilterChip(
            context,
            label: _statusLabel(),
            icon: Icons.circle,
            isActive: _hasStatusFilter,
            onTap: () => _openStatusSheet(context),
          ),
          SizedBox(width: 8.w),
          _buildFilterChip(
            context,
            label: _categoryLabel(),
            icon: Icons.category_rounded,
            isActive: _hasCategoryFilter,
            onTap: () => _openCategorySheet(context),
          ),
          SizedBox(width: 8.w),
          _buildFilterChip(
            context,
            label: _typeLabel(),
            icon: Icons.swap_vert_rounded,
            isActive: _hasTypeFilter,
            onTap: () => _openTypeSheet(context),
          ),
          if (_hasAnyFilter) ...[
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: onClearAll,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Text(
                  'Clear all',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF8E8E93),
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context, {
    required String label,
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFF581CD9).withValues(alpha: 0.15)
              : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: isActive
                ? const Color(0xFF581CD9).withValues(alpha: 0.5)
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? const Color(0xFF581CD9) : const Color(0xFF8E8E93),
              size: icon == Icons.circle ? 8.sp : 14.sp,
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? Colors.white : const Color(0xFF8E8E93),
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(width: 4.w),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: isActive ? Colors.white70 : const Color(0xFF8E8E93),
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Per-category bottom sheets
// ---------------------------------------------------------------------------

Widget _buildSheetHeader(BuildContext context, String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
        child: Container(
          width: 36.w,
          height: 4.h,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
      ),
      SizedBox(height: 16.h),
      Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontFamily: 'Inter',
        ),
      ),
    ],
  );
}

Widget _buildApplyButton(BuildContext context, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      height: 50.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF581CD9),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Text(
        'Apply',
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontFamily: 'Inter',
        ),
      ),
    ),
  );
}

/// Date range filter sheet
class _DateFilterSheet extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final void Function(DateTime? start, DateTime? end) onApply;

  const _DateFilterSheet({
    this.startDate,
    this.endDate,
    required this.onApply,
  });

  @override
  State<_DateFilterSheet> createState() => _DateFilterSheetState();
}

class _DateFilterSheetState extends State<_DateFilterSheet> {
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _startDate = widget.startDate;
    _endDate = widget.endDate;
  }

  Future<void> _pickDate({required bool isStart}) async {
    final initial = isStart
        ? (_startDate ?? DateTime.now().subtract(const Duration(days: 30)))
        : (_endDate ?? DateTime.now());
    final result = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF581CD9),
              surface: Color(0xFF1F1F1F),
            ),
          ),
          child: child!,
        );
      },
    );

    if (result != null) {
      setState(() {
        if (isStart) {
          _startDate = result;
          if (_endDate != null && _startDate!.isAfter(_endDate!)) {
            _endDate = _startDate;
          }
        } else {
          _endDate = result;
          if (_startDate != null && _endDate!.isBefore(_startDate!)) {
            _startDate = _endDate;
          }
        }
      });
    }
  }

  void _setQuickRange(int days) {
    setState(() {
      if (days == -1) {
        _startDate = DateTime(DateTime.now().year, 1, 1);
      } else {
        _startDate = DateTime.now().subtract(Duration(days: days));
      }
      _endDate = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20.w, 12.h, 20.w,
        MediaQuery.of(context).viewPadding.bottom + 16.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSheetHeader(context, 'Date Range'),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(child: _buildDateButton(
                'From',
                _startDate,
                () => _pickDate(isStart: true),
              )),
              SizedBox(width: 12.w),
              Expanded(child: _buildDateButton(
                'To',
                _endDate,
                () => _pickDate(isStart: false),
              )),
            ],
          ),
          SizedBox(height: 12.h),
          // Quick range buttons
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              _buildQuickRange('7 days', 7),
              _buildQuickRange('30 days', 30),
              _buildQuickRange('90 days', 90),
              _buildQuickRange('This year', -1),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.onApply(null, null);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Text(
                      'Clear',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 2,
                child: _buildApplyButton(context, () {
                  widget.onApply(_startDate, _endDate);
                  Navigator.pop(context);
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateButton(String label, DateTime? date, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                color: const Color(0xFF8E8E93),
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              date != null
                  ? DateFormat('d MMM yyyy').format(date)
                  : 'Select date',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: date != null ? Colors.white : const Color(0xFF8E8E93),
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickRange(String label, int days) {
    return GestureDetector(
      onTap: () => _setQuickRange(days),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF8E8E93),
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }
}

/// Status filter sheet — multi-select
class _StatusFilterSheet extends StatefulWidget {
  final Set<UnifiedTransactionStatus> selected;
  final void Function(Set<UnifiedTransactionStatus>) onApply;

  const _StatusFilterSheet({
    required this.selected,
    required this.onApply,
  });

  @override
  State<_StatusFilterSheet> createState() => _StatusFilterSheetState();
}

class _StatusFilterSheetState extends State<_StatusFilterSheet> {
  late final Set<UnifiedTransactionStatus> _selected;

  @override
  void initState() {
    super.initState();
    _selected = Set.from(widget.selected);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20.w, 12.h, 20.w,
        MediaQuery.of(context).viewPadding.bottom + 16.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSheetHeader(context, 'Status'),
          SizedBox(height: 16.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: UnifiedTransactionStatus.values
                .map((status) => _buildChip(status))
                .toList(),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.onApply({});
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Text(
                      'Clear',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 2,
                child: _buildApplyButton(context, () {
                  widget.onApply(_selected);
                  Navigator.pop(context);
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChip(UnifiedTransactionStatus status) {
    final isSelected = _selected.contains(status);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selected.remove(status);
          } else {
            _selected.add(status);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF581CD9).withValues(alpha: 0.15)
              : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF581CD9) : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                color: status.color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 6.w),
            Text(
              status.displayName,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? Colors.white : const Color(0xFF8E8E93),
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Category filter sheet — multi-select service types
class _CategoryFilterSheet extends StatefulWidget {
  final Set<TransactionServiceType> selected;
  final void Function(Set<TransactionServiceType>) onApply;

  const _CategoryFilterSheet({
    required this.selected,
    required this.onApply,
  });

  @override
  State<_CategoryFilterSheet> createState() => _CategoryFilterSheetState();
}

class _CategoryFilterSheetState extends State<_CategoryFilterSheet> {
  late final Set<TransactionServiceType> _selected;

  @override
  void initState() {
    super.initState();
    _selected = Set.from(widget.selected);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      padding: EdgeInsets.fromLTRB(
        20.w, 12.h, 20.w,
        MediaQuery.of(context).viewPadding.bottom + 16.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSheetHeader(context, 'Category'),
          SizedBox(height: 16.h),
          Flexible(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: TransactionServiceType.values
                    .where((t) => t != TransactionServiceType.unknown)
                    .map((type) => _buildChip(type))
                    .toList(),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.onApply({});
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Text(
                      'Clear',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 2,
                child: _buildApplyButton(context, () {
                  widget.onApply(_selected);
                  Navigator.pop(context);
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChip(TransactionServiceType type) {
    final isSelected = _selected.contains(type);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selected.remove(type);
          } else {
            _selected.add(type);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF581CD9).withValues(alpha: 0.15)
              : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF581CD9) : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              type.icon,
              color: isSelected ? type.color : const Color(0xFF8E8E93),
              size: 16.sp,
            ),
            SizedBox(width: 6.w),
            Text(
              type.displayName,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? Colors.white : const Color(0xFF8E8E93),
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Type filter sheet — single-select (All / Incoming / Outgoing)
class _TypeFilterSheet extends StatefulWidget {
  final TransactionFlow? selectedFlow;
  final void Function(TransactionFlow?) onApply;

  const _TypeFilterSheet({
    this.selectedFlow,
    required this.onApply,
  });

  @override
  State<_TypeFilterSheet> createState() => _TypeFilterSheetState();
}

class _TypeFilterSheetState extends State<_TypeFilterSheet> {
  TransactionFlow? _selectedFlow;

  @override
  void initState() {
    super.initState();
    _selectedFlow = widget.selectedFlow;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20.w, 12.h, 20.w,
        MediaQuery.of(context).viewPadding.bottom + 16.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSheetHeader(context, 'Type'),
          SizedBox(height: 16.h),
          Row(
            children: [
              _buildTypeChip('All', null),
              SizedBox(width: 8.w),
              _buildTypeChip('Incoming', TransactionFlow.incoming),
              SizedBox(width: 8.w),
              _buildTypeChip('Outgoing', TransactionFlow.outgoing),
            ],
          ),
          SizedBox(height: 20.h),
          _buildApplyButton(context, () {
            widget.onApply(_selectedFlow);
            Navigator.pop(context);
          }),
        ],
      ),
    );
  }

  Widget _buildTypeChip(String label, TransactionFlow? flow) {
    final isSelected = _selectedFlow == flow;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedFlow = flow),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF581CD9)
                : const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? Colors.white : const Color(0xFF8E8E93),
              fontFamily: 'Inter',
            ),
          ),
        ),
      ),
    );
  }
}
