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

/// Horizontal filter bar showing active filter chips + filter button
class TransactionFilterBar extends StatelessWidget {
  final TransactionFilters? activeFilters;
  final VoidCallback onOpenFilters;
  final VoidCallback onClearAll;
  final Function(TransactionFilters) onRemoveFilter;

  const TransactionFilterBar({
    super.key,
    this.activeFilters,
    required this.onOpenFilters,
    required this.onClearAll,
    required this.onRemoveFilter,
  });

  List<_FilterChipData> _buildChips() {
    final chips = <_FilterChipData>[];
    final filters = activeFilters;
    if (filters == null) return chips;

    // Date range chip
    if (filters.startDate != null || filters.endDate != null) {
      final start = filters.startDate;
      final end = filters.endDate;
      String label;
      if (start != null && end != null) {
        label = '${DateFormat('d MMM').format(start)} - ${DateFormat('d MMM').format(end)}';
      } else if (start != null) {
        label = 'From ${DateFormat('d MMM').format(start)}';
      } else {
        label = 'Until ${DateFormat('d MMM').format(end!)}';
      }
      chips.add(_FilterChipData(
        label: label,
        icon: Icons.calendar_today_rounded,
        onRemove: () {
          final updated = TransactionFilters(
            serviceTypes: filters.serviceTypes,
            statuses: filters.statuses,
            flows: filters.flows,
            searchQuery: filters.searchQuery,
          );
          onRemoveFilter(updated);
        },
      ));
    }

    // Service type chips
    if (filters.serviceTypes != null) {
      for (final type in filters.serviceTypes!) {
        chips.add(_FilterChipData(
          label: type.displayName,
          icon: type.icon,
          onRemove: () {
            final remaining = filters.serviceTypes!.where((t) => t != type).toList();
            final updated = TransactionFilters(
              serviceTypes: remaining.isNotEmpty ? remaining : null,
              statuses: filters.statuses,
              flows: filters.flows,
              startDate: filters.startDate,
              endDate: filters.endDate,
              searchQuery: filters.searchQuery,
            );
            onRemoveFilter(updated);
          },
        ));
      }
    }

    // Flow chips
    if (filters.flows != null) {
      for (final flow in filters.flows!) {
        final label = flow == TransactionFlow.incoming ? 'Incoming' : 'Outgoing';
        chips.add(_FilterChipData(
          label: label,
          icon: flow == TransactionFlow.incoming
              ? Icons.arrow_downward_rounded
              : Icons.arrow_upward_rounded,
          onRemove: () {
            final remaining = filters.flows!.where((f) => f != flow).toList();
            final updated = TransactionFilters(
              serviceTypes: filters.serviceTypes,
              statuses: filters.statuses,
              flows: remaining.isNotEmpty ? remaining : null,
              startDate: filters.startDate,
              endDate: filters.endDate,
              searchQuery: filters.searchQuery,
            );
            onRemoveFilter(updated);
          },
        ));
      }
    }

    // Status chips
    if (filters.statuses != null) {
      for (final status in filters.statuses!) {
        chips.add(_FilterChipData(
          label: status.displayName,
          icon: Icons.circle,
          iconColor: status.color,
          onRemove: () {
            final remaining = filters.statuses!.where((s) => s != status).toList();
            final updated = TransactionFilters(
              serviceTypes: filters.serviceTypes,
              statuses: remaining.isNotEmpty ? remaining : null,
              flows: filters.flows,
              startDate: filters.startDate,
              endDate: filters.endDate,
              searchQuery: filters.searchQuery,
            );
            onRemoveFilter(updated);
          },
        ));
      }
    }

    return chips;
  }

  @override
  Widget build(BuildContext context) {
    final chips = _buildChips();
    final hasActiveFilters = chips.isNotEmpty;

    return SizedBox(
      height: 36.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          // Filter button
          GestureDetector(
            onTap: onOpenFilters,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: hasActiveFilters
                    ? const Color(0xFF581CD9)
                    : const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.tune_rounded,
                    color: hasActiveFilters ? Colors.white : const Color(0xFF8E8E93),
                    size: 16.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'Filter',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: hasActiveFilters ? FontWeight.w600 : FontWeight.w400,
                      color: hasActiveFilters ? Colors.white : const Color(0xFF8E8E93),
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Active filter chips
          ...chips.map((chip) => Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: GestureDetector(
              onTap: chip.onRemove,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF581CD9).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(18.r),
                  border: Border.all(
                    color: const Color(0xFF581CD9).withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      chip.icon,
                      color: chip.iconColor ?? const Color(0xFF581CD9),
                      size: chip.icon == Icons.circle ? 8.sp : 14.sp,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      chip.label,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.close_rounded,
                      color: const Color(0xFF8E8E93),
                      size: 14.sp,
                    ),
                  ],
                ),
              ),
            ),
          )),
          // Clear all button (when filters active)
          if (hasActiveFilters)
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: GestureDetector(
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
            ),
        ],
      ),
    );
  }
}

class _FilterChipData {
  final String label;
  final IconData icon;
  final Color? iconColor;
  final VoidCallback onRemove;

  const _FilterChipData({
    required this.label,
    required this.icon,
    this.iconColor,
    required this.onRemove,
  });
}

/// Comprehensive filter bottom sheet
class FilterBottomSheet extends StatefulWidget {
  final TransactionFilters? initialFilters;
  final Function(TransactionFilters) onApply;

  const FilterBottomSheet({
    super.key,
    this.initialFilters,
    required this.onApply,
  });

  static Future<void> show(
    BuildContext context, {
    TransactionFilters? initialFilters,
    required Function(TransactionFilters) onApply,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FilterBottomSheet(
        initialFilters: initialFilters,
        onApply: onApply,
      ),
    );
  }

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  DateTime? _startDate;
  DateTime? _endDate;
  final Set<TransactionServiceType> _selectedServiceTypes = {};
  final Set<UnifiedTransactionStatus> _selectedStatuses = {};
  TransactionFlow? _selectedFlow;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialFilters;
    if (initial != null) {
      _startDate = initial.startDate;
      _endDate = initial.endDate;
      if (initial.serviceTypes != null) {
        _selectedServiceTypes.addAll(initial.serviceTypes!);
      }
      if (initial.statuses != null) {
        _selectedStatuses.addAll(initial.statuses!);
      }
      if (initial.flows?.isNotEmpty == true) {
        _selectedFlow = initial.flows!.first;
      }
    }
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

  void _clearAll() {
    setState(() {
      _startDate = null;
      _endDate = null;
      _selectedServiceTypes.clear();
      _selectedStatuses.clear();
      _selectedFlow = null;
    });
  }

  void _apply() {
    final filters = TransactionFilters(
      startDate: _startDate,
      endDate: _endDate != null
          ? DateTime(_endDate!.year, _endDate!.month, _endDate!.day, 23, 59, 59)
          : null,
      serviceTypes: _selectedServiceTypes.isNotEmpty
          ? _selectedServiceTypes.toList()
          : null,
      statuses: _selectedStatuses.isNotEmpty
          ? _selectedStatuses.toList()
          : null,
      flows: _selectedFlow != null ? [_selectedFlow!] : null,
    );
    widget.onApply(filters);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle + header
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
            child: Column(
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
                SizedBox(height: 20.h),
                Text(
                  'Filter Transactions',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Customize your view',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF8E8E93),
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          // Scrollable content
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date Range section
                  _buildSectionTitle('Date Range'),
                  SizedBox(height: 10.h),
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
                  SizedBox(height: 10.h),
                  // Quick range buttons
                  SizedBox(
                    height: 34.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildQuickRange('7 days', 7),
                        SizedBox(width: 8.w),
                        _buildQuickRange('30 days', 30),
                        SizedBox(width: 8.w),
                        _buildQuickRange('90 days', 90),
                        SizedBox(width: 8.w),
                        _buildQuickRange('This year', -1),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Category section
                  _buildSectionTitle('Category'),
                  SizedBox(height: 10.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: TransactionServiceType.values
                        .where((t) => t != TransactionServiceType.unknown)
                        .map((type) => _buildCategoryChip(type))
                        .toList(),
                  ),
                  SizedBox(height: 24.h),

                  // Type section
                  _buildSectionTitle('Type'),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      _buildTypeChip('All', null),
                      SizedBox(width: 8.w),
                      _buildTypeChip('Incoming', TransactionFlow.incoming),
                      SizedBox(width: 8.w),
                      _buildTypeChip('Outgoing', TransactionFlow.outgoing),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  // Status section
                  _buildSectionTitle('Status'),
                  SizedBox(height: 10.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: UnifiedTransactionStatus.values
                        .map((status) => _buildStatusChip(status))
                        .toList(),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
          // Bottom action bar
          Container(
            padding: EdgeInsets.fromLTRB(
              20.w, 12.h, 20.w,
              MediaQuery.of(context).viewPadding.bottom + 12.h,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF141414),
              border: Border(
                top: BorderSide(
                  color: const Color(0xFF2D2D2D),
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _clearAll,
                    child: Container(
                      height: 50.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F1F1F),
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Text(
                        'Clear All',
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
                  child: GestureDetector(
                    onTap: _apply,
                    child: Container(
                      height: 50.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF581CD9),
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Text(
                        'Apply Filters',
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF8E8E93),
        fontFamily: 'Inter',
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

  Widget _buildCategoryChip(TransactionServiceType type) {
    final isSelected = _selectedServiceTypes.contains(type);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedServiceTypes.remove(type);
          } else {
            _selectedServiceTypes.add(type);
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
            color: isSelected
                ? const Color(0xFF581CD9)
                : Colors.transparent,
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

  Widget _buildTypeChip(String label, TransactionFlow? flow) {
    final isSelected = _selectedFlow == flow;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedFlow = flow),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
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

  Widget _buildStatusChip(UnifiedTransactionStatus status) {
    final isSelected = _selectedStatuses.contains(status);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedStatuses.remove(status);
          } else {
            _selectedStatuses.add(status);
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
            color: isSelected
                ? const Color(0xFF581CD9)
                : Colors.transparent,
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
