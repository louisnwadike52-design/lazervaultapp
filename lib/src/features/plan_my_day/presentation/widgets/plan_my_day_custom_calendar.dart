import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/src/features/plan_my_day/domain/entities/event.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/time_block.dart';

enum CalendarViewMode { month, week, day }

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

// ==================== MONTH VIEW ====================

class _MonthCalendarView extends StatelessWidget {
  final DateTime currentDate;
  final List<Event> events;
  final List<TimeBlock> timeBlocks;
  final Function(DateTime) onDateSelected;
  final Function(DateTime)? onDateLongPress;
  final Function(Event)? onEventTap;

  const _MonthCalendarView({
    required this.currentDate,
    required this.events,
    required this.timeBlocks,
    required this.onDateSelected,
    this.onDateLongPress,
    this.onEventTap,
  });

  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(currentDate.year, currentDate.month, 1);
    final lastDayOfMonth = DateTime(currentDate.year, currentDate.month + 1, 0);
    final firstDayOfWeek = firstDayOfMonth.weekday - 1; // 0 = Monday

    final daysInMonth = List.generate(lastDayOfMonth.day, (index) => index + 1);
    final paddingDays = List.generate(firstDayOfWeek, (index) => null);

    return GridView.builder(
      padding: EdgeInsets.all(16.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.h,
      ),
      itemCount: 42, // 6 rows × 7 days
      itemBuilder: (context, index) {
        if (index < 7) {
          return _buildDayHeader(Weekday.values[index]);
        }

        final dayIndex = index - 7;
        if (dayIndex < paddingDays.length) {
          return const SizedBox.shrink();
        }

        final day = dayIndex - paddingDays.length;
        if (day > daysInMonth.length) {
          return const SizedBox.shrink();
        }

        final date = DateTime(currentDate.year, currentDate.month, day);
        final dayEvents = events.where((e) => _isSameDay(e.startTime, date)).toList();
        final dayBlocks = timeBlocks.where((b) => b.date == _toDateString(date)).toList();

        return _buildDayCell(
          context,
          date: date,
          events: dayEvents,
          timeBlocks: dayBlocks,
        );
      },
    );
  }

  Widget _buildDayHeader(Weekday day) {
    final labels = {
      Weekday.mon: 'Mon',
      Weekday.tue: 'Tue',
      Weekday.wed: 'Wed',
      Weekday.thu: 'Thu',
      Weekday.fri: 'Fri',
      Weekday.sat: 'Sat',
      Weekday.sun: 'Sun',
    };

    return Center(
      child: Text(
        labels[day]!,
        style: TextStyle(
          color: Colors.grey[400],
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildDayCell(
    BuildContext context, {
    required DateTime date,
    required List<Event> events,
    required List<TimeBlock> timeBlocks,
  }) {
    final isToday = _isSameDay(date, DateTime.now());
    final isSelected = false; // Track selected state if needed
    final hasEvents = events.isNotEmpty || timeBlocks.isNotEmpty;

    return GestureDetector(
      onTap: () => onDateSelected(date),
      onLongPress: onDateLongPress != null ? () => onDateLongPress!(date) : null,
      child: Container(
        decoration: BoxDecoration(
          color: isToday
              ? const Color(0xFF3B82F6).withOpacity(0.1)
              : isSelected
                  ? const Color(0xFF3B82F6).withOpacity(0.2)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: isToday
              ? Border.all(color: const Color(0xFF3B82F6))
              : null,
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${date.day}',
                  style: TextStyle(
                    color: isToday
                        ? const Color(0xFF3B82F6)
                        : Colors.white,
                    fontSize: 14.sp,
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                if (hasEvents)
                  _buildEventDots(events, timeBlocks),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventDots(List<Event> events, List<TimeBlock> timeBlocks) {
    final totalItems = (events.length + timeBlocks.length).clamp(0, 3);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalItems, (index) {
        Color color;
        if (index < events.length) {
          color = events[index].color != null
              ? Color(int.parse(events[index].color!.replaceAll('#', '0xFF')))
              : const Color(0xFF3B82F6);
        } else {
          final block = timeBlocks[index - events.length];
          color = block.color != null
              ? Color(int.parse(block.color!.replaceAll('#', '0xFF')))
              : const Color(0xFF8B5CF6);
        }
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 1.w),
          width: 4.w,
          height: 4.h,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
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

// ==================== WEEK VIEW ====================

class _WeekCalendarView extends StatelessWidget {
  final DateTime currentDate;
  final List<Event> events;
  final List<TimeBlock> timeBlocks;
  final Function(DateTime) onDateSelected;
  final Function(Event)? onEventTap;
  final Function(TimeBlock)? onTimeBlockTap;

  const _WeekCalendarView({
    required this.currentDate,
    required this.events,
    required this.timeBlocks,
    required this.onDateSelected,
    this.onEventTap,
    this.onTimeBlockTap,
  });

  @override
  Widget build(BuildContext context) {
    final startOfWeek = currentDate.subtract(Duration(days: currentDate.weekday - 1));
    final weekDays = List.generate(7, (index) => startOfWeek.add(Duration(days: index)));

    return Column(
      children: [
        // Day headers
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            children: weekDays.map((date) {
              final isToday = _isSameDay(date, DateTime.now());
              return Expanded(
                child: Column(
                  children: [
                    Text(
                      DateFormat('E').format(date),
                      style: TextStyle(
                        color: isToday ? const Color(0xFF3B82F6) : Colors.grey[400],
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${date.day}',
                      style: TextStyle(
                        color: isToday ? const Color(0xFF3B82F6) : Colors.white,
                        fontSize: 16.sp,
                        fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: _buildWeekTimeline(weekDays),
        ),
      ],
    );
  }

  Widget _buildWeekTimeline(List<DateTime> weekDays) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildTimeSlotRow('6 AM', weekDays, 6),
          _buildTimeSlotRow('8 AM', weekDays, 8),
          _buildTimeSlotRow('10 AM', weekDays, 10),
          _buildTimeSlotRow('12 PM', weekDays, 12),
          _buildTimeSlotRow('2 PM', weekDays, 14),
          _buildTimeSlotRow('4 PM', weekDays, 16),
          _buildTimeSlotRow('6 PM', weekDays, 18),
          _buildTimeSlotRow('8 PM', weekDays, 20),
        ],
      ),
    );
  }

  Widget _buildTimeSlotRow(String label, List<DateTime> weekDays, int hour) {
    return Row(
      children: [
        SizedBox(
          width: 40.w,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 10.sp,
              ),
            ),
          ),
        ),
        ...weekDays.map((date) {
          final dayEvents = events.where((e) {
            final eventHour = e.startTime.hour;
            return _isSameDay(e.startTime, date) && eventHour == hour;
          }).toList();

          final dayBlocks = timeBlocks.where((b) {
            return b.date == _toDateString(date) &&
                int.parse(b.startTime.split(':')[0]) == hour;
          }).toList();

          return Expanded(
            child: _buildTimeSlotCell(
              date: date,
              hour: hour,
              events: dayEvents,
              timeBlocks: dayBlocks,
            ),
          );
        }),
      ],
    );
  }

  Widget _buildTimeSlotCell({
    required DateTime date,
    required int hour,
    required List<Event> events,
    required List<TimeBlock> timeBlocks,
  }) {
    return GestureDetector(
      onTap: () => onDateSelected(date),
      child: Container(
        height: 60.h,
        margin: EdgeInsets.all(1.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          border: Border(
            left: BorderSide(
              color: _isSameDay(date, DateTime.now())
                  ? const Color(0xFF3B82F6)
                  : Colors.grey[800]!,
              width: 2,
            ),
          ),
        ),
        child: events.isNotEmpty || timeBlocks.isNotEmpty
            ? _buildTimeSlotContent(events, timeBlocks)
            : null,
      ),
    );
  }

  Widget _buildTimeSlotContent(List<Event> events, List<TimeBlock> timeBlocks) {
    if (events.isNotEmpty) {
      return Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: events.first.color != null
              ? Color(int.parse(events.first.color!.replaceAll('#', '0xFF'))).withOpacity(0.3)
              : const Color(0xFF3B82F6).withOpacity(0.3),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Text(
          events.first.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10.sp,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      );
    }
    return const SizedBox.shrink();
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

// ==================== DAY VIEW ====================

class _DayCalendarView extends StatelessWidget {
  final DateTime currentDate;
  final List<Event> events;
  final List<TimeBlock> timeBlocks;
  final Function(DateTime) onDateSelected;
  final Function(Event)? onEventTap;
  final Function(TimeBlock)? onTimeBlockTap;

  const _DayCalendarView({
    required this.currentDate,
    required this.events,
    required this.timeBlocks,
    required this.onDateSelected,
    this.onEventTap,
    this.onTimeBlockTap,
  });

  @override
  Widget build(BuildContext context) {
    // Sort events and time blocks by time
    final sortedEvents = events..sort((a, b) => a.startTime.compareTo(b.startTime));
    final sortedBlocks = timeBlocks..sort((a, b) => a.startTime.compareTo(b.startTime));

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          ...List.generate(14, (hourIndex) {
            final hour = hourIndex + 6; // Start from 6 AM
            return _buildHourRow(hour, sortedEvents, sortedBlocks);
          }),
        ],
      ),
    );
  }

  Widget _buildHourRow(int hour, List<Event> events, List<TimeBlock> timeBlocks) {
    final hourEvents = events.where((e) => e.startTime.hour == hour).toList();
    final hourBlocks = timeBlocks.where((b) {
      final blockHour = int.parse(b.startTime.split(':')[0]);
      return blockHour == hour;
    }).toList();

    final hasItems = hourEvents.isNotEmpty || hourBlocks.isNotEmpty;

    return Container(
      height: hasItems ? null : 60.h,
      margin: EdgeInsets.only(bottom: 1.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[800]!),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 50.w,
            child: Text(
              _formatHour(hour),
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12.sp,
              ),
            ),
          ),
          Expanded(
            child: hasItems
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...hourBlocks.map((block) => _buildTimeBlockItem(block)),
                      ...hourEvents.map((event) => _buildEventItem(event)),
                    ],
                  )
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildTimeBlockItem(TimeBlock block) {
    return GestureDetector(
      onTap: () => onTimeBlockTap?.call(block),
      child: Container(
        margin: EdgeInsets.only(bottom: 4.h),
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: block.color != null
              ? Color(int.parse(block.color!.replaceAll('#', '0xFF'))).withOpacity(0.2)
              : const Color(0xFF8B5CF6).withOpacity(0.2),
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            color: block.color != null
                ? Color(int.parse(block.color!.replaceAll('#', '0xFF')))
                : const Color(0xFF8B5CF6),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 3.w,
              decoration: BoxDecoration(
                color: block.color != null
                    ? Color(int.parse(block.color!.replaceAll('#', '0xFF')))
                    : const Color(0xFF8B5CF6),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    block.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (block.description != null)
                    Text(
                      block.description!,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 10.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventItem(Event event) {
    return GestureDetector(
      onTap: () => onEventTap?.call(event),
      child: Container(
        margin: EdgeInsets.only(bottom: 4.h),
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: event.color != null
              ? Color(int.parse(event.color!.replaceAll('#', '0xFF'))).withOpacity(0.2)
              : const Color(0xFF3B82F6).withOpacity(0.2),
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            color: event.color != null
                ? Color(int.parse(event.color!.replaceAll('#', '0xFF')))
                : const Color(0xFF3B82F6),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 3.w,
              decoration: BoxDecoration(
                color: event.color != null
                    ? Color(int.parse(event.color!.replaceAll('#', '0xFF')))
                    : const Color(0xFF3B82F6),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${DateFormat('HH:mm').format(event.startTime)} - ${DateFormat('HH:mm').format(event.endTime)}',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 10.sp,
                    ),
                  ),
                  if (event.location != null)
                    Text(
                      event.location!,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 10.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatHour(int hour) {
    if (hour == 0) return '12 AM';
    if (hour < 12) return '$hour AM';
    if (hour == 12) return '12 PM';
    return '${hour - 12} PM';
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

enum Weekday { mon, tue, wed, thu, fri, sat, sun }
