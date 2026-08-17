import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/src/features/plan_my_day/domain/entities/event.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/time_block.dart';
part 'plan_my_day_custom_calendar_widgets.dart';


class PlanMyDayCustomCalendar extends StatefulWidget {
  final DateTime initialDate;
  final List<Event> events;
  final List<TimeBlock> timeBlocks;
  final Function(DateTime) onDateSelected;
  final Function(Event)? onEventTap;
  final Function(TimeBlock)? onTimeBlockTap;
  final Function(DateTime)? onDateLongPress;
  final CalendarViewMode initialViewMode;

  const PlanMyDayCustomCalendar({
    super.key,
    required this.initialDate,
    required this.events,
    required this.timeBlocks,
    required this.onDateSelected,
    this.onEventTap,
    this.onTimeBlockTap,
    this.onDateLongPress,
    this.initialViewMode = CalendarViewMode.month,
  });

  @override
  State<PlanMyDayCustomCalendar> createState() => _PlanMyDayCustomCalendarState();
}

class _PlanMyDayCustomCalendarState extends State<PlanMyDayCustomCalendar> {
  late DateTime _currentDate;
  late CalendarViewMode _viewMode;
  late PageController _pageController;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentDate = widget.initialDate;
    _viewMode = widget.initialViewMode;
    _currentPage = 0;
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        _buildViewModeToggle(),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                _currentPage = page;
                _updateCurrentDateForPage(page);
              });
            },
            itemBuilder: (context, index) {
              return _buildCalendarBody();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left, color: Colors.white),
            onPressed: _navigatePrevious,
          ),
          GestureDetector(
            onTap: () => _selectDate(),
            child: Text(
              _getHeaderText(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right, color: Colors.white),
            onPressed: _navigateNext,
          ),
          IconButton(
            icon: Icon(Icons.today, color: Colors.grey[400]),
            onPressed: _goToToday,
          ),
        ],
      ),
    );
  }

  Widget _buildViewModeToggle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: CalendarViewMode.values.map((mode) {
          final isSelected = _viewMode == mode;
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: _buildViewModeChip(
              label: _getViewModeLabel(mode),
              isSelected: isSelected,
              onTap: () => setState(() => _viewMode = mode),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildViewModeChip({required String label, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3B82F6) : Colors.transparent,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF3B82F6) : Colors.grey[700]!,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[400],
            fontSize: 12.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarBody() {
    switch (_viewMode) {
      case CalendarViewMode.month:
        return _MonthCalendarView(
          currentDate: _currentDate,
          events: eventsForDate(_currentDate),
          timeBlocks: timeBlocksForDate(_currentDate),
          onDateSelected: widget.onDateSelected,
          onDateLongPress: widget.onDateLongPress,
          onEventTap: widget.onEventTap,
        );
      case CalendarViewMode.week:
        return _WeekCalendarView(
          currentDate: _currentDate,
          events: widget.events,
          timeBlocks: widget.timeBlocks,
          onDateSelected: widget.onDateSelected,
          onEventTap: widget.onEventTap,
          onTimeBlockTap: widget.onTimeBlockTap,
        );
      case CalendarViewMode.day:
        return _DayCalendarView(
          currentDate: _currentDate,
          events: eventsForDate(_currentDate),
          timeBlocks: timeBlocksForDate(_currentDate),
          onDateSelected: widget.onDateSelected,
          onEventTap: widget.onEventTap,
          onTimeBlockTap: widget.onTimeBlockTap,
        );
    }
  }

  void _navigatePrevious() {
    setState(() {
      switch (_viewMode) {
        case CalendarViewMode.month:
          _currentDate = DateTime(_currentDate.year, _currentDate.month - 1, 1);
          break;
        case CalendarViewMode.week:
          _currentDate = _currentDate.subtract(const Duration(days: 7));
          break;
        case CalendarViewMode.day:
          _currentDate = _currentDate.subtract(const Duration(days: 1));
          break;
      }
    });
  }

  void _navigateNext() {
    setState(() {
      switch (_viewMode) {
        case CalendarViewMode.month:
          _currentDate = DateTime(_currentDate.year, _currentDate.month + 1, 1);
          break;
        case CalendarViewMode.week:
          _currentDate = _currentDate.add(const Duration(days: 7));
          break;
        case CalendarViewMode.day:
          _currentDate = _currentDate.add(const Duration(days: 1));
          break;
      }
    });
  }

  void _goToToday() {
    setState(() {
      _currentDate = DateTime.now();
    });
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _currentDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _currentDate = picked;
      });
    }
  }

  void _updateCurrentDateForPage(int page) {
    final diff = page - _currentPage;
    setState(() {
      switch (_viewMode) {
        case CalendarViewMode.month:
          _currentDate = DateTime(_currentDate.year, _currentDate.month + diff, 1);
          break;
        case CalendarViewMode.week:
          _currentDate = _currentDate.add(Duration(days: diff * 7));
          break;
        case CalendarViewMode.day:
          _currentDate = _currentDate.add(Duration(days: diff));
          break;
      }
    });
  }

  String _getHeaderText() {
    switch (_viewMode) {
      case CalendarViewMode.month:
        return DateFormat('MMMM yyyy').format(_currentDate);
      case CalendarViewMode.week:
        final startOfWeek = _currentDate.subtract(Duration(days: _currentDate.weekday - 1));
        final endOfWeek = startOfWeek.add(const Duration(days: 6));
        if (startOfWeek.month == endOfWeek.month) {
          return '${DateFormat('MMM d').format(startOfWeek)} - ${DateFormat('d').format(endOfWeek)}, ${startOfWeek.year}';
        } else {
          return '${DateFormat('MMM d').format(startOfWeek)} - ${DateFormat('MMM d').format(endOfWeek)}, ${startOfWeek.year}';
        }
      case CalendarViewMode.day:
        return DateFormat('EEEE, MMM d, yyyy').format(_currentDate);
    }
  }

  String _getViewModeLabel(CalendarViewMode mode) {
    switch (mode) {
      case CalendarViewMode.month:
        return 'Month';
      case CalendarViewMode.week:
        return 'Week';
      case CalendarViewMode.day:
        return 'Day';
    }
  }

  List<Event> eventsForDate(DateTime date) {
    return widget.events.where((event) {
      return _isSameDay(event.startTime, date);
    }).toList();
  }

  List<TimeBlock> timeBlocksForDate(DateTime date) {
    return widget.timeBlocks.where((block) {
      return block.date == _toDateString(date);
    }).toList();
  }

  String _toDateString(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
