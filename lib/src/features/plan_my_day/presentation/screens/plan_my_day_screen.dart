import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/src/features/plan_my_day/domain/entities/event.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/task.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_cubit.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_state.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/plan_my_day_calendar.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/task_list_card.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/time_block_list.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/daily_summary_card.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/create_task_bottom_sheet.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/create_event_bottom_sheet.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/create_time_block_bottom_sheet.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/screens/weekly_summary_screen.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/screens/productivity_insights_screen.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/screens/calendar_settings_screen.dart';

class PlanMyDayScreen extends StatefulWidget {
  const PlanMyDayScreen({super.key});

  @override
  State<PlanMyDayScreen> createState() => _PlanMyDayScreenState();
}

class _PlanMyDayScreenState extends State<PlanMyDayScreen> {
  late DateTime _selectedDate;
  late PageController _pageController;
  int _currentViewIndex = 0; // 0: Day view, 1: Calendar, 2: Tasks

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _pageController = PageController(initialPage: 0);
    context.read<PlanMyDayCubit>().loadDayData(_selectedDate);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onDateChanged(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    context.read<PlanMyDayCubit>().loadDayData(date);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlanMyDayCubit, PlanMyDayState>(
      listener: (context, state) {
        if (state is PlanMyDayError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1F1F1F),
          elevation: 0,
          title: const Text(
            'Plan My Day',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF3B82F6),
          onPressed: _showCreateMenu,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: Column(
          children: [
            _buildViewToggle(),
            Expanded(
              child: PageView.builder(
                itemCount: 3,
                onPageChanged: (index) {
                  setState(() {
                    _currentViewIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return _buildDayView();
                    case 1:
                      return _buildCalendarView();
                    case 2:
                      return _buildTasksView();
                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewToggle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildViewToggleItem('Day', 0, Icons.today_outlined),
          SizedBox(width: 8.w),
          _buildViewToggleItem('Calendar', 1, Icons.calendar_month_outlined),
          SizedBox(width: 8.w),
          _buildViewToggleItem('Tasks', 2, Icons.checklist_outlined),
        ],
      ),
    );
  }

  Widget _buildViewToggleItem(String label, int index, IconData icon) {
    final isSelected = _currentViewIndex == index;
    return GestureDetector(
      onTap: () {
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF3B82F6)
              : const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey[400],
              size: 18,
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[400],
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayView() {
    return BlocBuilder<PlanMyDayCubit, PlanMyDayState>(
      builder: (context, state) {
        if (state is PlanMyDayLoading) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
            ),
          );
        }

        if (state is PlanMyDayLoaded) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date selector
                _buildDateSelector(state.selectedDate),
                SizedBox(height: 20.h),

                // Daily Summary
                if (state.dailySummary != null)
                  DailySummaryCard(summary: state.dailySummary!),
                SizedBox(height: 20.h),

                // Greeting based on time of day
                _buildGreeting(),
                SizedBox(height: 16.h),

                // Quick Actions CTAs
                _buildQuickActions(),
                SizedBox(height: 20.h),

                // Time Blocks
                if (state.timeBlocks.isNotEmpty) ...[
                  Text(
                    'Time Blocks',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  TimeBlockList(
                    timeBlocks: state.timeBlocks,
                    tasks: state.tasks,
                    events: state.events,
                  ),
                  SizedBox(height: 20.h),
                ],

                // Tasks
                _buildSectionHeader('Today\'s Tasks', state.tasks.length),
                SizedBox(height: 12.h),
                TaskListCard(
                  tasks: state.tasks,
                  onTaskToggle: (task) {
                    if (task.isCompleted) {
                      context.read<PlanMyDayCubit>().completeTask(task.id);
                    }
                  },
                  onTaskTap: (task) {
                    _showTaskDetailBottomSheet(task);
                  },
                ),
                SizedBox(height: 20.h),

                // Events
                if (state.events.isNotEmpty) ...[
                  _buildSectionHeader('Upcoming Events', state.events.length),
                  SizedBox(height: 12.h),
                  _buildEventsList(state.events),
                ],
              ],
            ),
          );
        }

        if (state is PlanMyDayError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.grey[600],
                  size: 48,
                ),
                SizedBox(height: 16.h),
                Text(
                  state.message,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: () {
                    context.read<PlanMyDayCubit>().loadDayData(_selectedDate);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildCalendarView() {
    return BlocBuilder<PlanMyDayCubit, PlanMyDayState>(
      builder: (context, state) {
        if (state is PlanMyDayLoaded || state is PlanMyDayCalendarView) {
          final events = state is PlanMyDayLoaded
              ? (state as PlanMyDayLoaded).events
              : (state as PlanMyDayCalendarView).events;
          final timeBlocks = state is PlanMyDayLoaded
              ? (state as PlanMyDayLoaded).timeBlocks
              : (state as PlanMyDayCalendarView).timeBlocks;

          return PlanMyDayCalendar(
            selectedDate: _selectedDate,
            events: events,
            timeBlocks: timeBlocks,
            onDateSelected: _onDateChanged,
            onEventTap: (event) {
              _showEventDetailBottomSheet(event);
            },
          );
        }

        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
          ),
        );
      },
    );
  }

  Widget _buildTasksView() {
    return BlocBuilder<PlanMyDayCubit, PlanMyDayState>(
      builder: (context, state) {
        final tasks = state is PlanMyDayLoaded
            ? (state as PlanMyDayLoaded).tasks
            : state is TaskListLoaded
                ? (state as TaskListLoaded).tasks
                : <Task>[];

        if (state is PlanMyDayLoading) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
            ),
          );
        }

        return Column(
          children: [
            // Task filter tabs
            _buildTaskFilterTabs(),
            Expanded(
              child: TaskListCard(
                tasks: tasks,
                onTaskToggle: (task) {
                  if (!task.isCompleted) {
                    context.read<PlanMyDayCubit>().completeTask(task.id);
                  }
                },
                onTaskTap: (task) {
                  _showTaskDetailBottomSheet(task);
                },
                showCompleted: true,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDateSelector(DateTime date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white),
          onPressed: () {
            _onDateChanged(date.subtract(const Duration(days: 1)));
          },
        ),
        GestureDetector(
          onTap: () => _showDatePicker(),
          child: Column(
            children: [
              Text(
                DateFormat('EEEE').format(date),
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12.sp,
                ),
              ),
              Text(
                DateFormat('MMM d, yyyy').format(date),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right, color: Colors.white),
          onPressed: () {
            _onDateChanged(date.add(const Duration(days: 1)));
          },
        ),
      ],
    );
  }

  Widget _buildGreeting() {
    final hour = DateTime.now().hour;
    String greeting;
    IconData greetingIcon;

    if (hour < 12) {
      greeting = 'Good Morning';
      greetingIcon = Icons.wb_sunny_outlined;
    } else if (hour < 17) {
      greeting = 'Good Afternoon';
      greetingIcon = Icons.wb_twilight_outlined;
    } else {
      greeting = 'Good Evening';
      greetingIcon = Icons.nights_stay_outlined;
    }

    return Row(
      children: [
        Icon(greetingIcon, color: const Color(0xFF3B82F6), size: 28),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            '$greeting! Let\'s make today productive.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _buildQuickActionCard(
            icon: Icons.sync_alt,
            label: 'Sync\nCalendar',
            color: const Color(0xFF8B5CF6),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CalendarSettingsScreen(),
                ),
              );
            },
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _buildQuickActionCard(
            icon: Icons.insights_outlined,
            label: 'Productivity\nInsights',
            color: const Color(0xFF10B981),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProductivityInsightsScreen(),
                ),
              );
            },
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _buildQuickActionCard(
            icon: Icons.calendar_view_week,
            label: 'Weekly\nSummary',
            color: const Color(0xFFF59E0B),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<PlanMyDayCubit>(),
                    child: const WeeklySummaryScreen(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (count > 0)
          Text(
            '$count items',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14.sp,
            ),
          ),
      ],
    );
  }

  Widget _buildEventsList(List<Event> events) {
    return Column(
      children: events.take(3).map((event) {
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Container(
                width: 4.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: event.color != null
                      ? Color(int.parse(event.color!.replaceAll('#', '0xFF')))
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
                      event.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.h),
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
                          Expanded(
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
        );
      }).toList(),
    );
  }

  Widget _buildTaskFilterTabs() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          _buildFilterChip('All', ''),
          SizedBox(width: 8.w),
          _buildFilterChip('Pending', 'pending'),
          SizedBox(width: 8.w),
          _buildFilterChip('In Progress', 'in_progress'),
          SizedBox(width: 8.w),
          _buildFilterChip('Done', 'completed'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String status) {
    return GestureDetector(
      onTap: () => context.read<PlanMyDayCubit>().loadTasks(status: status),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFF3B82F6).withOpacity(0.3),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  void _showDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      _onDateChanged(picked);
    }
  }

  void _showCreateMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _createMenuItem(
              icon: Icons.check_circle_outline,
              label: 'New Task',
              onTap: () {
                Navigator.pop(context);
                _showCreateTaskBottomSheet();
              },
            ),
            _createMenuItem(
              icon: Icons.event_outlined,
              label: 'New Event',
              onTap: () {
                Navigator.pop(context);
                _showCreateEventBottomSheet();
              },
            ),
            _createMenuItem(
              icon: Icons.schedule_outlined,
              label: 'Time Block',
              onTap: () {
                Navigator.pop(context);
                _showCreateTimeBlockBottomSheet();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _createMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF3B82F6)),
      title: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
        ),
      ),
      onTap: onTap,
    );
  }

  void _showCreateTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => CreateTaskBottomSheet(
        selectedDate: _selectedDate,
        categories: context.read<PlanMyDayCubit>().state is PlanMyDayLoaded
            ? (context.read<PlanMyDayCubit>().state as PlanMyDayLoaded).categories
            : [],
        onTaskCreated: () {
          context.read<PlanMyDayCubit>().loadDayData(_selectedDate);
        },
      ),
    );
  }

  void _showCreateEventBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => CreateEventBottomSheet(
        selectedDate: _selectedDate,
        categories: context.read<PlanMyDayCubit>().state is PlanMyDayLoaded
            ? (context.read<PlanMyDayCubit>().state as PlanMyDayLoaded).categories
            : [],
        onEventCreated: () {
          context.read<PlanMyDayCubit>().loadDayData(_selectedDate);
        },
      ),
    );
  }

  void _showCreateTimeBlockBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        final state = context.read<PlanMyDayCubit>().state;
        final tasks = state is PlanMyDayLoaded ? (state as PlanMyDayLoaded).tasks : <Task>[];
        final events = state is PlanMyDayLoaded ? (state as PlanMyDayLoaded).events : <Event>[];

        return CreateTimeBlockBottomSheet(
          selectedDate: _selectedDate,
          tasks: tasks,
          events: events,
          onTimeBlockCreated: () {
            context.read<PlanMyDayCubit>().loadDayData(_selectedDate);
          },
        );
      },
    );
  }

  void _showTaskDetailBottomSheet(Task task) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _TaskDetailBottomSheet(task: task),
    );
  }

  void _showEventDetailBottomSheet(Event event) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _EventDetailBottomSheet(event: event),
    );
  }
}

class _TaskDetailBottomSheet extends StatelessWidget {
  final Task task;

  const _TaskDetailBottomSheet({required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  task.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _getPriorityColor(task.priority).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  task.priorityLabel,
                  style: TextStyle(
                    color: _getPriorityColor(task.priority),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (task.description != null) ...[
            SizedBox(height: 12.h),
            Text(
              task.description!,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14.sp,
              ),
            ),
          ],
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(
                task.isCompleted ? Icons.check_circle : Icons.circle_outlined,
                color: task.isCompleted ? Colors.green : Colors.grey[600],
                size: 20,
              ),
              SizedBox(width: 8.w),
              Text(
                task.isCompleted ? 'Completed' : 'Pending',
                style: TextStyle(
                  color: task.isCompleted ? Colors.green : Colors.grey[400],
                  fontSize: 14.sp,
                ),
              ),
              if (task.dueDate != null) ...[
                SizedBox(width: 16.w),
                Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: Colors.grey[400],
                ),
                SizedBox(width: 4.w),
                Text(
                  DateFormat('MMM d').format(task.dueDate!),
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return const Color(0xFF10B981); // Green - Low
      case 2:
        return const Color(0xFFF59E0B); // Orange - Medium
      case 3:
        return const Color(0xFFEF4444); // Red - High
      case 4:
        return const Color(0xFFDC2626); // Dark Red - Urgent
      default:
        return const Color(0xFF6B7280); // Gray
    }
  }
}

class _EventDetailBottomSheet extends StatelessWidget {
  final Event event;

  const _EventDetailBottomSheet({required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (event.description != null) ...[
            SizedBox(height: 12.h),
            Text(
              event.description!,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14.sp,
              ),
            ),
          ],
          SizedBox(height: 16.h),
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: const Color(0xFF3B82F6),
                size: 20,
              ),
              SizedBox(width: 8.w),
              Text(
                '${DateFormat('HH:mm').format(event.startTime)} - ${DateFormat('HH:mm').format(event.endTime)}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
          if (event.location != null) ...[
            SizedBox(height: 12.h),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: const Color(0xFF3B82F6),
                  size: 20,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    event.location!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
          if (event.isAllDay) ...[
            SizedBox(height: 12.h),
            Row(
              children: [
                Icon(
                  Icons.all_inclusive,
                  color: const Color(0xFF3B82F6),
                  size: 20,
                ),
                SizedBox(width: 8.w),
                Text(
                  'All day event',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
