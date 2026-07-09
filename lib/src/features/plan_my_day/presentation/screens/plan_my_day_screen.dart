import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/ai_plan_input_modal.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/event.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/task.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_cubit.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_state.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/plan_board_view.dart';
import 'package:lazervault/src/features/plan_my_day/services/plan_notification_service.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/time_block_list.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/create_task_bottom_sheet.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/create_event_bottom_sheet.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/create_time_block_bottom_sheet.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/screens/weekly_summary_screen.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/screens/productivity_insights_screen.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/screens/calendar_settings_screen.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class PlanMyDayScreen extends StatefulWidget {
  const PlanMyDayScreen({super.key});

  @override
  State<PlanMyDayScreen> createState() => _PlanMyDayScreenState();
}

class _PlanMyDayScreenState extends State<PlanMyDayScreen> {
  late DateTime _selectedDate;
  late PageController _pageController;
  int _currentViewIndex = 0; // 0: Day (default), 1: Board
  final PlanNotificationService _notifications = PlanNotificationService();

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

  /// Opens the focused AI input modal; on success reloads the board so the
  /// AI-created tasks/events/time-blocks appear.
  void _openAiPlanModal() {
    final cubit = context.read<PlanMyDayCubit>();
    AiPlanInputModal.show(
      context,
      selectedDate: _selectedDate,
      onPlanCreated: () => cubit.loadDayData(_selectedDate, forceRefresh: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlanMyDayCubit, PlanMyDayState>(
      listener: (context, state) {
        if (state is PlanMyDayError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is PlanMyDayLoaded) {
          // Keep OS-scheduled reminders in sync with the loaded tasks.
          _notifications.syncTaskSchedules(state.tasks);
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
          actions: [
            // Per-service voice button — pins the session to the Plan My Day
            // agent via the gateway's 'planning' source-context routing
            // (chat-planning-service). Non-money: no PIN.
            ServiceVoiceButton(
              serviceName: 'planning',
              iconColor: const Color(0xFF3B82F6),
              backgroundColor: const Color(0xFF3B82F6),
            ),
            SizedBox(width: 8.w),
            // Conversational AI chat about Plan My Day — opens the standard chat
            // bottom sheet wired to the chat agent system (planning source-context
            // → chat-planning-service; also reachable as the general chatbot).
            // This is for CHATTING about the plan; the auto_awesome button below
            // is the one-shot CREATE flow.
            const MicroserviceChatIcon(
              serviceName: 'planning',
              sourceContext: 'planning',
              icon: Icons.chat_bubble_outline,
              iconColor: Color(0xFF3B82F6),
              chatAccentColor: Color(0xFF8B5CF6),
              agentDescription: 'Ask about your day, tasks and schedule',
              size: 40,
              iconSize: 20,
            ),
            SizedBox(width: 8.w),
            // AI plan-my-day: opens a focused input modal (NOT the chat sheet)
            // where the user describes their day; the agent builds the board.
            IconButton(
              icon: const Icon(Icons.auto_awesome, color: Color(0xFF8B5CF6)),
              tooltip: 'AI plan my day',
              onPressed: _openAiPlanModal,
            ),
            SizedBox(width: 4.w),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF4E03D0),
          onPressed: _showCreateMenu,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: Column(
          children: [
            _buildViewToggle(),
            Expanded(
              // Two views only. Day (agenda for a date — events + time blocks +
              // tasks + summary, with month-grid date picking in its header) and
              // Board (status-filtered task management + drag-reorder). The old
              // Calendar tab folded into Day's date picker; the old Tasks tab
              // folded into Board's status pills — both were redundant filters
              // over the same PlanMyDayLoaded dataset.
              child: PageView.builder(
                controller: _pageController,
                itemCount: 2,
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
                      return _buildBoardView();
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
      margin: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 4.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Expanded(child: _buildViewToggleItem('Day', 0, Icons.today_outlined)),
          SizedBox(width: 4.w),
          Expanded(
            child: _buildViewToggleItem('Board', 1, Icons.view_kanban_outlined),
          ),
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4E03D0) : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
              size: 18,
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: GoogleFonts.inter(
                color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                fontSize: 13.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBoardView() {
    return BlocBuilder<PlanMyDayCubit, PlanMyDayState>(
      builder: (context, state) {
        if (state is PlanMyDayLoading) {
          return const Center(child: LazerVaultLoader.small());
        }
        if (state is PlanMyDayLoaded) {
          if (state.tasks.isEmpty) {
            return _buildBoardEmpty();
          }
          return PlanBoardView(
            tasks: state.tasks,
            onMove: (task, status, {int? index}) {
              HapticFeedback.selectionClick();
              context
                  .read<PlanMyDayCubit>()
                  .moveTask(task.id, status, boardOrder: index);
            },
            onReorder: (status, orderedIds) {
              context.read<PlanMyDayCubit>().reorderColumn(status, orderedIds);
            },
            onTapTask: (task) => _showTaskDetailBottomSheet(task),
            onAddTask: _showCreateMenu,
          );
        }
        if (state is PlanMyDayError) {
          return _buildInlineError(state.message);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildBoardEmpty() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.view_kanban_rounded,
                  color: const Color(0xFF4E03D0), size: 48.sp),
            ),
            SizedBox(height: 16.h),
            Text(
              'Your board is empty',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Tell the AI assistant your day — "gym at 7, finish the deck by '
              'noon, follow up with the bank" — or add a task yourself.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF), fontSize: 13.sp),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _openAiPlanModal,
                  icon: const Icon(Icons.auto_awesome, size: 18),
                  label: Text('AI plan my day',
                      style: GoogleFonts.inter(
                          fontSize: 13.sp, fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B5CF6),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                ),
                SizedBox(width: 12.w),
                OutlinedButton.icon(
                  onPressed: _showCreateMenu,
                  icon: const Icon(Icons.add, size: 18),
                  label: Text('Add task',
                      style: GoogleFonts.inter(
                          fontSize: 13.sp, fontWeight: FontWeight.w600)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFF4E03D0)),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInlineError(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.grey[600], size: 48),
          SizedBox(height: 16.h),
          Text(
            message,
            style: TextStyle(color: Colors.grey[400], fontSize: 16.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () =>
                context.read<PlanMyDayCubit>().loadDayData(_selectedDate),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildDayView() {
    return BlocBuilder<PlanMyDayCubit, PlanMyDayState>(
      builder: (context, state) {
        if (state is PlanMyDayLoading) {
          return const Center(
            child: LazerVaultLoader.small(),
          );
        }

        if (state is PlanMyDayLoaded) {
          final tasks = state.tasks;
          final events = state.events;
          final done = tasks.where((t) => t.isCompleted).length;
          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 96.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _dayHeaderCard(state.selectedDate, done, tasks.length,
                    events.length, state.dailySummary?.focusMinutes),
                SizedBox(height: 14.h),
                _dayUtilities(),
                SizedBox(height: 22.h),
                if (state.timeBlocks.isNotEmpty) ...[
                  _daySectionHeader('Schedule', state.timeBlocks.length),
                  SizedBox(height: 10.h),
                  TimeBlockList(
                    timeBlocks: state.timeBlocks,
                    tasks: tasks,
                    events: events,
                  ),
                  SizedBox(height: 22.h),
                ],
                if (events.isNotEmpty) ...[
                  _daySectionHeader('Events', events.length),
                  SizedBox(height: 10.h),
                  ...events.map(_compactEventRow),
                  SizedBox(height: 22.h),
                ],
                _daySectionHeader('Tasks', tasks.length),
                SizedBox(height: 10.h),
                if (tasks.isEmpty)
                  _dayEmptyHint('No tasks for this day yet.')
                else
                  ...tasks.map(_compactTaskRow),
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

  // ── Day tab: clean, concise, agenda-style layout ─────────────────────────
  static const _dayPurple = Color(0xFF4E03D0);
  static const _dayCard = Color(0xFF1F1F1F);
  static const _dayBorder = Color(0xFF2D2D2D);
  static const _dayMuted = Color(0xFF9CA3AF);

  /// One cohesive header: date navigation + a progress bar + inline stats.
  /// Replaces the old separate date selector, gradient summary card and
  /// "let's make today productive" greeting.
  Widget _dayHeaderCard(
      DateTime date, int done, int total, int events, num? focusMinutes) {
    final isToday = DateUtils.isSameDay(date, DateTime.now());
    final pct = total == 0 ? 0.0 : done / total;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _dayCard,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: _dayBorder),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _dayNavBtn(Icons.chevron_left_rounded,
                  () => _onDateChanged(date.subtract(const Duration(days: 1)))),
              Expanded(
                child: GestureDetector(
                  onTap: _showDatePicker,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('EEE, MMM d').format(date),
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (isToday) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: _dayPurple.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            'Today',
                            style: GoogleFonts.inter(
                              color: _dayPurple,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              _dayNavBtn(Icons.chevron_right_rounded,
                  () => _onDateChanged(date.add(const Duration(days: 1)))),
            ],
          ),
          SizedBox(height: 14.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: pct,
              minHeight: 6.h,
              backgroundColor: _dayBorder,
              valueColor: const AlwaysStoppedAnimation<Color>(_dayPurple),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              _dayStatChip(Icons.check_circle_outline, '$done/$total', 'tasks',
                  const Color(0xFF10B981)),
              SizedBox(width: 10.w),
              _dayStatChip(Icons.event_outlined, '$events', 'events',
                  const Color(0xFF3B82F6)),
              if (focusMinutes != null && focusMinutes > 0) ...[
                SizedBox(width: 10.w),
                _dayStatChip(
                    Icons.psychology_outlined,
                    '${(focusMinutes / 60).toStringAsFixed(1)}h',
                    'focus',
                    const Color(0xFFF59E0B)),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _dayNavBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
          color: const Color(0xFF141414),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(icon, color: Colors.white, size: 22.sp),
      ),
    );
  }

  Widget _dayStatChip(IconData icon, String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 15.sp),
            SizedBox(width: 5.w),
            Text(
              value,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 3.w),
            Text(
              label,
              style: GoogleFonts.inter(color: _dayMuted, fontSize: 11.sp),
            ),
          ],
        ),
      ),
    );
  }

  /// Secondary utilities as a compact single-line chip row (was three bulky
  /// two-line cards).
  Widget _dayUtilities() {
    return Row(
      children: [
        _dayUtilityChip(Icons.sync_alt_rounded, 'Sync', const Color(0xFF8B5CF6),
            () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CalendarSettingsScreen()),
          );
        }),
        SizedBox(width: 8.w),
        _dayUtilityChip(
            Icons.insights_rounded, 'Insights', const Color(0xFF10B981), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<PlanMyDayCubit>(),
                child: const ProductivityInsightsScreen(),
              ),
            ),
          );
        }),
        SizedBox(width: 8.w),
        _dayUtilityChip(
            Icons.calendar_view_week_rounded, 'Weekly', const Color(0xFFF59E0B),
            () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<PlanMyDayCubit>(),
                child: const WeeklySummaryScreen(),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _dayUtilityChip(
      IconData icon, String label, Color color, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: _dayCard,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: _dayBorder),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 17.sp),
              SizedBox(width: 6.w),
              Text(
                label,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _daySectionHeader(String title, int count) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 8.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: const Color(0xFF141414),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            '$count',
            style: GoogleFonts.inter(
              color: _dayMuted,
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _compactTaskRow(Task task) {
    final pColor = _dayPriorityColor(task.priority);
    final overdue = task.dueDate != null &&
        task.dueDate!.isBefore(DateTime.now()) &&
        !task.isCompleted;
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () => _showTaskDetailBottomSheet(task),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: _dayCard,
              borderRadius: BorderRadius.circular(12.r),
              border: Border(left: BorderSide(color: pColor, width: 3)),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    final cubit = context.read<PlanMyDayCubit>();
                    if (task.isCompleted) {
                      cubit.moveTask(task.id, 'pending');
                    } else {
                      cubit.completeTask(task.id);
                    }
                  },
                  child: Container(
                    width: 22.w,
                    height: 22.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: task.isCompleted
                          ? const Color(0xFF10B981)
                          : Colors.transparent,
                      border: Border.all(
                        color: task.isCompleted
                            ? const Color(0xFF10B981)
                            : _dayMuted,
                        width: 2,
                      ),
                    ),
                    child: task.isCompleted
                        ? const Icon(Icons.check, size: 13, color: Colors.white)
                        : null,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          color: task.isCompleted ? _dayMuted : Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      if (task.dueDate != null) ...[
                        SizedBox(height: 3.h),
                        Row(
                          children: [
                            Icon(Icons.event_rounded,
                                size: 12.sp,
                                color: overdue
                                    ? const Color(0xFFEF4444)
                                    : _dayMuted),
                            SizedBox(width: 4.w),
                            Text(
                              DateFormat('MMM d').format(task.dueDate!),
                              style: GoogleFonts.inter(
                                color: overdue
                                    ? const Color(0xFFEF4444)
                                    : _dayMuted,
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  task.priorityLabel,
                  style: GoogleFonts.inter(
                    color: pColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _compactEventRow(Event event) {
    final accent = _eventColor(event.color);
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: GestureDetector(
        onTap: () => _showEventDetailBottomSheet(event),
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: _dayCard,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    Text(
                      DateFormat('HH:mm').format(event.startTime),
                      style: GoogleFonts.inter(
                        color: accent,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (event.endTime != null)
                      Text(
                        DateFormat('HH:mm').format(event.endTime!),
                        style: GoogleFonts.inter(
                          color: accent.withValues(alpha: 0.7),
                          fontSize: 10.sp,
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if ((event.location ?? '').isNotEmpty) ...[
                      SizedBox(height: 3.h),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              size: 12.sp, color: _dayMuted),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              event.location!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                  color: _dayMuted, fontSize: 11.sp),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dayEmptyHint(String message) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 22.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _dayCard,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _dayBorder),
      ),
      child: Text(
        message,
        style: GoogleFonts.inter(color: _dayMuted, fontSize: 13.sp),
      ),
    );
  }

  Color _dayPriorityColor(int priority) {
    switch (priority) {
      case 4:
        return const Color(0xFFEF4444);
      case 3:
        return const Color(0xFFFB923C);
      case 2:
        return const Color(0xFF3B82F6);
      default:
        return const Color(0xFF6B7280);
    }
  }

  Color _eventColor(String? hex) {
    if (hex == null || hex.isEmpty) return const Color(0xFF3B82F6);
    try {
      return Color(int.parse(hex.replaceAll('#', '0xFF')));
    } catch (_) {
      return const Color(0xFF3B82F6);
    }
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
            // AI plan-my-day is always reachable here (the FAB is shown on every
            // board state) — so the entry point doesn't disappear once the board
            // has tasks and the empty-state CTA is gone.
            _createMenuItem(
              icon: Icons.auto_awesome,
              label: 'AI plan my day',
              iconColor: const Color(0xFF8B5CF6),
              onTap: () {
                Navigator.pop(context);
                _openAiPlanModal();
              },
            ),
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
    Color? iconColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? const Color(0xFF3B82F6)),
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
            ? (context.read<PlanMyDayCubit>().state as PlanMyDayLoaded)
                .categories
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
            ? (context.read<PlanMyDayCubit>().state as PlanMyDayLoaded)
                .categories
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
        final tasks = state is PlanMyDayLoaded ? state.tasks : <Task>[];
        final events = state is PlanMyDayLoaded ? state.events : <Event>[];

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
                '${DateFormat('HH:mm').format(event.startTime)}${event.endTime != null ? ' - ${DateFormat('HH:mm').format(event.endTime!)}' : ''}',
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
