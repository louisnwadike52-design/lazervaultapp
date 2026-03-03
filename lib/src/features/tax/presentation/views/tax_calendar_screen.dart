import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/tax/domain/entities/tax_calendar_entity.dart';
import 'package:lazervault/src/features/tax/domain/entities/tax_obligation_entity.dart';
import '../cubit/tax_cubit.dart';
import '../cubit/tax_state.dart';

class TaxCalendarScreen extends StatefulWidget {
  const TaxCalendarScreen({super.key});

  @override
  State<TaxCalendarScreen> createState() => _TaxCalendarScreenState();
}

class _TaxCalendarScreenState extends State<TaxCalendarScreen> {
  late int _year;
  late int _month;

  static const _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _year = now.year;
    _month = now.month;
    _loadCalendar();
  }

  void _loadCalendar() {
    context.read<TaxCubit>().getCalendar(year: _year, month: _month);
  }

  void _previousMonth() {
    setState(() {
      if (_month == 1) {
        _month = 12;
        _year--;
      } else {
        _month--;
      }
    });
    _loadCalendar();
  }

  void _nextMonth() {
    setState(() {
      if (_month == 12) {
        _month = 1;
        _year++;
      } else {
        _month++;
      }
    });
    _loadCalendar();
  }

  String get _monthYearLabel => '${_monthNames[_month - 1]} $_year';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Tax Calendar',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildMonthSelector(),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Month / Year Selector
  // ---------------------------------------------------------------------------

  Widget _buildMonthSelector() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: _previousMonth,
              child: Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                  size: 22.sp,
                ),
              ),
            ),
            Text(
              _monthYearLabel,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: _nextMonth,
              child: Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: 22.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Body
  // ---------------------------------------------------------------------------

  Widget _buildBody() {
    return BlocConsumer<TaxCubit, TaxState>(
      listener: (context, state) {
        if (state is TaxError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is TaxLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF3B82F6),
            ),
          );
        }

        if (state is TaxCalendarLoaded) {
          if (state.events.isEmpty) {
            return _buildEmptyState();
          }

          return RefreshIndicator(
            onRefresh: () async => _loadCalendar(),
            color: const Color(0xFF3B82F6),
            backgroundColor: const Color(0xFF1F1F1F),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
              itemCount: state.events.length,
              itemBuilder: (context, index) =>
                  _buildEventCard(state.events[index]),
            ),
          );
        }

        return _buildEmptyState();
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Event Card
  // ---------------------------------------------------------------------------

  Widget _buildEventCard(TaxCalendarEventEntity event) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Colored dot by tax type
          Container(
            margin: EdgeInsets.only(top: 4.h),
            width: 10.w,
            height: 10.w,
            decoration: BoxDecoration(
              color: _taxTypeColor(event.taxType),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12.w),

          // Description + due date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.description,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: const Color(0xFF9CA3AF),
                      size: 13.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      _formatDate(event.dueDate),
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '\u2022',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      event.period,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(width: 8.w),

          // Status badge
          _buildStatusBadge(event),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Status Badge
  // ---------------------------------------------------------------------------

  Widget _buildStatusBadge(TaxCalendarEventEntity event) {
    final String label;
    final Color color;

    if (event.isDone) {
      label = 'Done';
      color = const Color(0xFF10B981);
    } else if (event.isOverdue) {
      label = 'Overdue';
      color = const Color(0xFFEF4444);
    } else {
      final days = event.daysUntilDue;
      if (days == 0) {
        label = 'Due today';
        color = const Color(0xFFFB923C);
      } else if (days == 1) {
        label = '1 day left';
        color = const Color(0xFFFB923C);
      } else {
        label = '$days days left';
        color = days <= 7
            ? const Color(0xFFFB923C)
            : const Color(0xFF3B82F6);
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: color,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  Color _taxTypeColor(TaxType type) {
    switch (type) {
      case TaxType.vat:
        return const Color(0xFF3B82F6);
      case TaxType.paye:
        return const Color(0xFF10B981);
      case TaxType.wht:
        return const Color(0xFFFB923C);
      case TaxType.cit:
        return const Color(0xFF8B5CF6);
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  // ---------------------------------------------------------------------------
  // Empty State
  // ---------------------------------------------------------------------------

  Widget _buildEmptyState() {
    return RefreshIndicator(
      onRefresh: () async => _loadCalendar(),
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 120.h),
          Icon(
            Icons.event_note_outlined,
            color: const Color(0xFF2D2D2D),
            size: 64.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'No tax events this month',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Navigate to another month to view events',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
