import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:lazervault/src/features/plan_my_day/domain/entities/event.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/time_block.dart';

class PlanMyDayCalendar extends StatefulWidget {
  final DateTime selectedDate;
  final List<Event> events;
  final List<TimeBlock> timeBlocks;
  final Function(DateTime) onDateSelected;
  final Function(Event) onEventTap;

  const PlanMyDayCalendar({
    super.key,
    required this.selectedDate,
    required this.events,
    required this.timeBlocks,
    required this.onDateSelected,
    required this.onEventTap,
  });

  @override
  State<PlanMyDayCalendar> createState() => _PlanMyDayCalendarState();
}

class _PlanMyDayCalendarState extends State<PlanMyDayCalendar> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late CalendarFormat _calendarFormat;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.selectedDate;
    _selectedDay = widget.selectedDate;
    _calendarFormat = CalendarFormat.month;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCalendarHeader(),
        TableCalendar(
          firstDay: DateTime(2020, 1, 1),
          lastDay: DateTime(2030, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
          calendarFormat: _calendarFormat,
          eventLoader: _loadEventsForDay,
          startingDayOfWeek: StartingDayOfWeek.monday,
          rangeSelectionMode: RangeSelectionMode.disabled,
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
            widget.onDateSelected(selectedDay);
          },
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: const Color(0xFF3B82F6),
              shape: BoxShape.circle,
            ),
            todayTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
            defaultTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
            weekendTextStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 16.sp,
            ),
            outsideTextStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.sp,
            ),
            markerDecoration: BoxDecoration(
              color: const Color(0xFF3B82F6),
              shape: BoxShape.circle,
            ),
            markersMaxCount: 4,
            markerSizeScale: 0.2,
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 14.sp,
            ),
            weekendStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: 14.sp,
            ),
          ),
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            leftChevronIcon: const Icon(
              Icons.chevron_left,
              color: Color(0xFF3B82F6),
            ),
            rightChevronIcon: const Icon(
              Icons.chevron_right,
              color: Color(0xFF3B82F6),
            ),
          ),
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, date, events) {
              return _buildEventsMarker(date, events);
            },
            defaultBuilder: (context, date, focusedDay) {
              return _buildDefaultDay(date);
            },
            todayBuilder: (context, date, focusedDay) {
              return _buildTodayDay(date);
            },
            selectedBuilder: (context, date, focusedDay) {
              return _buildSelectedDay(date);
            },
          ),
        ),
        SizedBox(height: 16.h),
        _buildSelectedDayEvents(),
      ],
    );
  }

  Widget _buildCalendarHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.calendar_today, color: Color(0xFF3B82F6)),
          onPressed: () {
            setState(() {
              _focusedDay = DateTime.now();
              _selectedDay = DateTime.now();
            });
            widget.onDateSelected(DateTime.now());
          },
        ),
        Row(
          children: [
            _buildFormatButton(CalendarFormat.month, 'Month'),
            SizedBox(width: 8.w),
            _buildFormatButton(CalendarFormat.twoWeeks, '2 Weeks'),
            SizedBox(width: 8.w),
            _buildFormatButton(CalendarFormat.week, 'Week'),
          ],
        ),
      ],
    );
  }

  Widget _buildFormatButton(CalendarFormat format, String label) {
    final isSelected = _calendarFormat == format;
    return GestureDetector(
      onTap: () {
        setState(() {
          _calendarFormat = format;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(6.r),
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

  List<Event> _loadEventsForDay(DateTime day) {
    return widget.events.where((event) {
      return isSameDay(event.startTime, day) ||
          isSameDay(event.endTime, day) ||
          (day.isAfter(event.startTime) && day.isBefore(event.endTime));
    }).toList();
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    final dayEvents = _loadEventsForDay(date);
    if (dayEvents.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      width: 6.w,
      height: 6.h,
      child: Container(
        decoration: BoxDecoration(
          color: dayEvents.first.color != null
              ? Color(int.parse(dayEvents.first.color!.replaceAll('#', '0xFF')))
              : const Color(0xFF3B82F6),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildDefaultDay(DateTime day) {
    return Container(
      margin: EdgeInsets.all(4.r),
      alignment: Alignment.center,
      child: Text(
        '${day.day}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
        ),
      ),
    );
  }

  Widget _buildTodayDay(DateTime day) {
    return Container(
      margin: EdgeInsets.all(4.r),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6).withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      child: Text(
        '${day.day}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSelectedDay(DateTime day) {
    return Container(
      margin: EdgeInsets.all(4.r),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6),
        shape: BoxShape.circle,
      ),
      child: Text(
        '${day.day}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSelectedDayEvents() {
    final dayEvents = _loadEventsForDay(_selectedDay);
    final dayTimeBlocks = widget.timeBlocks.where((tb) {
      return tb.date == DateFormat('yyyy-MM-dd').format(_selectedDay);
    }).toList();

    if (dayEvents.isEmpty && dayTimeBlocks.isEmpty) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 32.h),
        alignment: Alignment.center,
        child: Column(
          children: [
            Icon(
              Icons.event_available,
              color: Colors.grey[600],
              size: 48,
            ),
            SizedBox(height: 16.h),
            Text(
              'No events scheduled',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat('EEEE, MMM d').format(_selectedDay),
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        ...dayTimeBlocks.map((timeBlock) => _buildTimeBlockItem(timeBlock)),
        ...dayEvents.map((event) => _buildEventItem(event)),
      ],
    );
  }

  Widget _buildTimeBlockItem(TimeBlock timeBlock) {
    return GestureDetector(
      onTap: () {
        // TODO: Show time block detail
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: timeBlock.color != null
                ? Color(int.parse(timeBlock.color!.replaceAll('#', '0xFF'))).withOpacity(0.3)
                : const Color(0xFF3B82F6).withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 4.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: timeBlock.color != null
                    ? Color(int.parse(timeBlock.color!.replaceAll('#', '0xFF')))
                    : const Color(0xFF3B82F6),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    timeBlock.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${timeBlock.startTime} - ${timeBlock.endTime} • ${_getTimeBlockTypeLabel(timeBlock.type)}',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14.sp,
                    ),
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
      onTap: () => widget.onEventTap(event),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border(
            left: BorderSide(
              color: event.color != null
                  ? Color(int.parse(event.color!.replaceAll('#', '0xFF')))
                  : const Color(0xFF3B82F6),
              width: 3.w,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (event.description != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      event.description!,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.grey[400],
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${DateFormat('HH:mm').format(event.startTime)} - ${DateFormat('HH:mm').format(event.endTime)}',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14.sp,
                        ),
                      ),
                      if (event.location != null) ...[
                        SizedBox(width: 12.w),
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: Colors.grey[400],
                        ),
                        SizedBox(width: 4.w),
                        Flexible(
                          child: Text(
                            event.location!,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTimeBlockTypeLabel(String type) {
    switch (type) {
      case 'focused_work':
        return 'Focused Work';
      case 'meeting':
        return 'Meeting';
      case 'break':
        return 'Break';
      case 'exercise':
        return 'Exercise';
      case 'commute':
        return 'Commute';
      default:
        return 'Other';
    }
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
