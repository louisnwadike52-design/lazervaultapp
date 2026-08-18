import 'package:connectivity_plus/connectivity_plus.dart';
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
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/plan_kanban_view.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/day_week_strip.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/plan_my_day_skeleton.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/task_contact_chip.dart';
import 'package:lazervault/src/features/plan_my_day/contacts/domain/entities/contact.dart';
import 'package:lazervault/src/features/plan_my_day/contacts/presentation/screens/contact_detail_screen.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/task_options_sheet.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/task_edit_sheet.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/reschedule_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lazervault/src/features/plan_my_day/services/plan_notification_service.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/time_block_list.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/create_task_bottom_sheet.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/create_event_bottom_sheet.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/create_time_block_bottom_sheet.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/screens/weekly_summary_screen.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/screens/productivity_insights_screen.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/screens/calendar_settings_screen.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/plan_my_day/email/presentation/cubit/email_cubit.dart';
import 'package:lazervault/src/features/plan_my_day/email/presentation/screens/email_inbox_screen.dart';
import 'package:lazervault/src/features/plan_my_day/contacts/presentation/cubit/contact_cubit.dart';
import 'package:lazervault/src/features/plan_my_day/contacts/presentation/screens/contacts_list_screen.dart';
import 'package:lazervault/src/features/plan_my_day/notes/presentation/notes_screen.dart';
import 'package:lazervault/src/features/plan_my_day/habits/presentation/habits_screen.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/screens/reminder_management_screen.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/upcoming_reminders_card.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/reminders_list_body.dart';
part 'plan_my_day_screen_widgets.dart';


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

  // Board layout: false = single-column (default), true = horizontal Kanban.
  // Persisted across sessions via SharedPreferences.
  static const _boardLayoutPrefKey = 'planmyday_board_kanban';
  bool _kanbanLayout = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _pageController = PageController(initialPage: 0);
    _loadBoardLayoutPref();
    context.read<PlanMyDayCubit>().loadDayData(_selectedDate);
  }

  Future<void> _loadBoardLayoutPref() async {
    final prefs = await SharedPreferences.getInstance();
    final kanban = prefs.getBool(_boardLayoutPrefKey) ?? false;
    if (mounted && kanban != _kanbanLayout) {
      setState(() => _kanbanLayout = kanban);
    }
  }

  Future<void> _toggleBoardLayout() async {
    HapticFeedback.selectionClick();
    setState(() => _kanbanLayout = !_kanbanLayout);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_boardLayoutPrefKey, _kanbanLayout);
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
        // People view brings its own "add contact" FAB, so hide this one there.
        // People (2) brings its own "add contact" FAB; Reminders (3) has its own
        // scoped-cubit FAB inside its view — hide the shared task/event FAB there.
        floatingActionButton: (_currentViewIndex == 2 || _currentViewIndex == 3)
            ? null
            : FloatingActionButton(
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
                itemCount: 4,
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
                    case 2:
                      return _buildPeopleView();
                    case 3:
                      return _buildRemindersView();
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
          SizedBox(width: 4.w),
          Expanded(
            child: _buildViewToggleItem('People', 2, Icons.people_alt_outlined),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: _buildViewToggleItem(
                'Reminders', 3, Icons.notifications_active_outlined),
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
        // Tighter padding so four equal-width tabs (Day/Board/People/Reminders)
        // fit without overflow on narrow phones.
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 9.h),
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
              size: 16,
            ),
            SizedBox(width: 5.w),
            // Scale the label down to fit its slot instead of overflowing the
            // border — keeps the full word, just smaller where space is tight.
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  label,
                  maxLines: 1,
                  softWrap: false,
                  style: GoogleFonts.inter(
                    color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// People (CRM contacts) view — its own ContactCubit, scoped to this segment.
  Widget _buildPeopleView() {
    return BlocProvider<ContactCubit>(
      create: (_) => serviceLocator<ContactCubit>(),
      child: const ContactsListScreen(),
    );
  }

  /// Reminders tab. Its own scoped PlanMyDayCubit (so ReminderListLoaded never
  /// clobbers the board/day state) + a transparent nested Scaffold that hosts
  /// the create-reminder FAB wired to that cubit.
  Widget _buildRemindersView() {
    return BlocProvider<PlanMyDayCubit>(
      create: (_) => serviceLocator<PlanMyDayCubit>()..loadReminders(),
      child: Builder(
        builder: (ctx) => Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFF4E03D0),
            onPressed: () => RemindersListBody.openCreateSheet(ctx),
            child: const Icon(Icons.add, color: Colors.white),
          ),
          body: const RemindersListBody(),
        ),
      ),
    );
  }

  Widget _buildBoardView() {
    return BlocBuilder<PlanMyDayCubit, PlanMyDayState>(
      // Only react to the three view states — ignore transient event states
      // (TaskCreated, WeeklySummaryLoaded, …) so the board never blanks between
      // a mutation and its silent reload.
      buildWhen: (prev, curr) =>
          curr is PlanMyDayLoaded ||
          curr is PlanMyDayLoading ||
          curr is PlanMyDayError,
      builder: (context, state) {
        if (state is PlanMyDayLoading) {
          return const PlanBoardSkeleton();
        }
        if (state is PlanMyDayLoaded) {
          // The board is the full task pipeline — day-independent — so a
          // day-change refresh (isDayLoading) keeps the current board on screen
          // rather than shimmering; only the very first load shows a skeleton.
          // Top-level tasks only; children surface nested under their parent.
          final boardTasks = state.topLevelTasks;
          if (boardTasks.isEmpty) {
            return _buildBoardEmpty();
          }
          // Group children by parent once so cards can show a subtask count.
          final subtasksByParent = <String, List<Task>>{};
          for (final t in state.tasks) {
            final p = t.parentTaskId;
            if (p != null) (subtasksByParent[p] ??= <Task>[]).add(t);
          }
          void move(Task task, String status, {int? index}) {
            HapticFeedback.selectionClick();
            context
                .read<PlanMyDayCubit>()
                .moveTask(task.id, status, boardOrder: index);
          }

          void options(Task task) => TaskOptionsSheet.show(
                context,
                task: task,
                cubit: context.read<PlanMyDayCubit>(),
              );

          final board = _kanbanLayout
              ? PlanKanbanView(
                  tasks: boardTasks,
                  onMove: move,
                  onTapTask: _showTaskDetailBottomSheet,
                  onOptions: options,
                  contactsById: state.contactsById,
                  subtasksByParent: subtasksByParent,
                  onOpenContact: _openContact,
                )
              : PlanBoardView(
                  tasks: boardTasks,
                  onMove: move,
                  onReorder: (status, orderedIds) => context
                      .read<PlanMyDayCubit>()
                      .reorderColumn(status, orderedIds),
                  onTapTask: _showTaskDetailBottomSheet,
                  onOptions: options,
                  onAddTask: _showCreateMenu,
                  onRefresh: () => context
                      .read<PlanMyDayCubit>()
                      .loadDayData(_selectedDate, forceRefresh: true),
                  contactsById: state.contactsById,
                  subtasksByParent: subtasksByParent,
                  onOpenContact: _openContact,
                );

          return Column(
            children: [
              _boardLayoutBar(),
              Expanded(child: board),
            ],
          );
        }
        if (state is PlanMyDayError) {
          return _buildPlanError(state);
        }
        return const SizedBox.shrink();
      },
    );
  }

  /// Thin bar above the board with the single-column ⇄ Kanban layout toggle.
  Widget _boardLayoutBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 12.w, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _layoutToggleBtn(
              Icons.view_agenda_outlined, 'List', !_kanbanLayout, () {
            if (_kanbanLayout) _toggleBoardLayout();
          }),
          SizedBox(width: 6.w),
          _layoutToggleBtn(
              Icons.view_week_outlined, 'Board', _kanbanLayout, () {
            if (!_kanbanLayout) _toggleBoardLayout();
          }),
        ],
      ),
    );
  }

  Widget _layoutToggleBtn(
      IconData icon, String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF4E03D0) : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
              color: active
                  ? const Color(0xFF4E03D0)
                  : const Color(0xFF2D2D2D)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                size: 15.sp,
                color: active ? Colors.white : const Color(0xFF9CA3AF)),
            SizedBox(width: 5.w),
            Text(
              label,
              style: GoogleFonts.inter(
                color: active ? Colors.white : const Color(0xFF9CA3AF),
                fontSize: 11.5.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
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

  /// Inline load-failure state for Plan My Day. Crucially this is the ONLY thing
  /// a backend outage shows here — the pre-login "under maintenance" modal is
  /// gated to auth screens (see AppStartupGate), so it can never overlay this
  /// screen. We differentiate the two connectivity failure modes:
  ///   • the USER is offline (device has no network) → "you're offline", and
  ///   • the SERVER is unreachable/erroring while the device IS online →
  ///     "can't reach our servers".
  /// For a transport error (`network_error`) we can't tell which from the failed
  /// request alone, so we run a live connectivity check; a 5xx (`server_error`)
  /// is unambiguously the server, so we skip the check.
  Widget _buildPlanError(PlanMyDayError state) {
    // Non-connectivity errors (validation, not-found, generic): show the
    // message as-is, no connectivity probing.
    if (!state.isConnectivityError) {
      return _errorBody(
        icon: Icons.error_outline,
        title: null,
        message: state.message,
      );
    }

    // A confirmed server-side (5xx) failure — the device reached the edge, so it
    // is not a connectivity problem on the user's end.
    if (state.isServerError) {
      return _errorBody(
        icon: Icons.cloud_off_rounded,
        title: 'Can’t reach Plan My Day',
        message:
            'We’re having trouble reaching our servers. Please try again shortly.',
      );
    }

    // Transport error: resolve offline (user) vs server-unreachable via a live
    // connectivity check. Defaults to the server variant while the check runs /
    // if it fails, since an online device is the common case.
    return FutureBuilder<bool>(
      future: _deviceOnline(),
      builder: (context, snap) {
        final online = snap.data ?? true;
        return online
            ? _errorBody(
                icon: Icons.cloud_off_rounded,
                title: 'Can’t reach Plan My Day',
                message:
                    'We’re having trouble reaching our servers. Please try again shortly.',
              )
            : _errorBody(
                icon: Icons.wifi_off_rounded,
                title: 'You’re offline',
                message:
                    'Check your internet connection and try again.',
              );
      },
    );
  }

  /// True when the device itself has a network path (wifi/cellular/etc.).
  /// Unknown → assume online, so a genuine server outage still reads as one.
  Future<bool> _deviceOnline() async {
    try {
      final results = await Connectivity().checkConnectivity();
      return results.any((r) => r != ConnectivityResult.none);
    } catch (_) {
      return true;
    }
  }

  Widget _errorBody({
    required IconData icon,
    required String? title,
    required String message,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.grey[600], size: 48),
            SizedBox(height: 16.h),
            if (title != null) ...[
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 6.h),
            ],
            Text(
              message,
              style: TextStyle(color: Colors.grey[400], fontSize: 14.sp),
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
      ),
    );
  }

  Widget _buildDayView() {
    return BlocBuilder<PlanMyDayCubit, PlanMyDayState>(
      // Only react to the three view states — ignore transient event states
      // (TaskCreated, WeeklySummaryLoaded, …) so the page never blanks between
      // a mutation and its silent reload.
      buildWhen: (prev, curr) =>
          curr is PlanMyDayLoaded ||
          curr is PlanMyDayLoading ||
          curr is PlanMyDayError,
      builder: (context, state) {
        if (state is PlanMyDayLoading) {
          // First-ever load (no cached content) → full-page skeleton.
          return const PlanDayFullSkeleton();
        }

        if (state is PlanMyDayLoaded) {
          // Day view is TIME-based: only this date's tasks (by due date), with
          // overdue + undated surfaced separately so nothing gets lost. The
          // Board view is the status pipeline over the full task list.
          final loading = state.isDayLoading;
          final dayTasks = state.tasksForDay(state.selectedDate);
          final isToday = DateUtils.isSameDay(state.selectedDate, DateTime.now());
          final overdue = isToday ? state.overdueBeforeToday : <Task>[];
          final events = state.events;
          final done = dayTasks.where((t) => t.isCompleted).length;
          return RefreshIndicator(
            color: const Color(0xFF4E03D0),
            backgroundColor: const Color(0xFF1F1F1F),
            onRefresh: () => context
                .read<PlanMyDayCubit>()
                .loadDayData(_selectedDate, forceRefresh: true),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 96.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header stays live during a day-change; only its stats/
                  // progress shimmer since those counts are what's refreshing.
                  _dayHeaderCard(state.selectedDate, done, dayTasks.length,
                      events.length, state.dailySummary?.focusMinutes,
                      loading: loading),
                  SizedBox(height: 12.h),
                  // Week strip — tap a day to navigate; drag a task (from its ≡
                  // handle) onto a day to reschedule it there. Stays interactive
                  // while the day loads.
                  DayWeekStrip(
                    selectedDate: state.selectedDate,
                    tasks: state.tasks,
                    onSelectDay: _onDateChanged,
                    onDropTaskOnDay: (task, day) => context
                        .read<PlanMyDayCubit>()
                        .rescheduleTask(task.id, day),
                  ),
                  SizedBox(height: 14.h),
                  _emailEntryCard(),
                  SizedBox(height: 14.h),
                  _dayUtilities(),
                  SizedBox(height: 14.h),
                  // Upcoming reminders — own scoped cubit so its ReminderList
                  // state never bleeds into the Day/Board views.
                  const UpcomingRemindersCard(),
                  SizedBox(height: 22.h),
                  // Only the data-backed sections swap for a shimmer while the
                  // newly-selected day is fetched.
                  if (loading)
                    const PlanDaySectionsSkeleton()
                  else ...[
                    if (state.timeBlocks.isNotEmpty) ...[
                      _daySectionHeader('Schedule', state.timeBlocks.length),
                      SizedBox(height: 10.h),
                      TimeBlockList(
                        timeBlocks: state.timeBlocks,
                        tasks: state.tasks,
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
                    if (overdue.isNotEmpty) ...[
                      _daySectionHeader('Overdue', overdue.length,
                          color: const Color(0xFFEF4444)),
                      SizedBox(height: 10.h),
                      ...overdue.map((t) => _compactTaskRow(t, state)),
                      SizedBox(height: 22.h),
                    ],
                    _daySectionHeader('Tasks', dayTasks.length),
                    SizedBox(height: 10.h),
                    if (dayTasks.isEmpty)
                      _dayEmptyHint(
                          'No tasks for this day. Undated tasks live on the Board.')
                    else
                      ...dayTasks.map((t) => _compactTaskRow(t, state)),
                  ],
                ],
              ),
            ),
          );
        }

        if (state is PlanMyDayError) {
          return _buildPlanError(state);
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
      DateTime date, int done, int total, int events, num? focusMinutes,
      {bool loading = false}) {
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
          // While a freshly-selected day loads, the counts are unknown → shimmer
          // the progress + stat chips instead of showing stale numbers.
          if (loading)
            const PlanDayHeaderStatsSkeleton()
          else ...[
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

  /// Entry point to the Gmail / email integration. Opens the email inbox flow
  /// (connect state, AI digest, summarized emails, build-my-day, drafts,
  /// settings) with its own EmailCubit.
  Widget _emailEntryCard() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => serviceLocator<EmailCubit>(),
                child: const EmailInboxScreen(),
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1E3A8A), Color(0xFF1F1F1F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Icons.mail_outline_rounded,
                    color: const Color(0xFF3B82F6), size: 22.sp),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Inbox',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      'Summaries, AI replies, and build your day from emails',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded,
                  color: const Color(0xFF9CA3AF), size: 22.sp),
            ],
          ),
        ),
      ),
    );
  }

  /// Secondary utilities as a compact single-line chip row (was three bulky
  /// two-line cards).
  Widget _dayUtilities() {
    return Column(
      children: [
        Row(
          children: [
            _dayUtilityChip(
                Icons.sync_alt_rounded, 'Sync', const Color(0xFF8B5CF6), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const CalendarSettingsScreen()),
              );
            }),
            SizedBox(width: 8.w),
            _dayUtilityChip(
                Icons.insights_rounded, 'Insights', const Color(0xFF10B981),
                () {
              // Own scoped cubit — NEVER share the landing page's cubit. These
              // screens emit ProductivityInsightsLoaded/WeeklySummaryLoaded, and
              // if the shared cubit were left in that state the Day/Board views
              // would blank on the way back (they only render Loaded/Loading/Error).
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) => serviceLocator<PlanMyDayCubit>(),
                    child: const ProductivityInsightsScreen(),
                  ),
                ),
              );
            }),
            SizedBox(width: 8.w),
            _dayUtilityChip(Icons.calendar_view_week_rounded, 'Weekly',
                const Color(0xFFF59E0B), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) => serviceLocator<PlanMyDayCubit>(),
                    child: const WeeklySummaryScreen(),
                  ),
                ),
              );
            }),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            _dayUtilityChip(Icons.sticky_note_2_outlined, 'Notes',
                const Color(0xFF3B82F6), () {
              Navigator.push(context, NotesScreen.route());
            }),
            SizedBox(width: 8.w),
            _dayUtilityChip(Icons.local_fire_department_outlined, 'Habits',
                const Color(0xFFFB923C), () {
              Navigator.push(context, HabitsScreen.route());
            }),
            SizedBox(width: 8.w),
            _dayUtilityChip(Icons.notifications_active_outlined, 'Reminders',
                const Color(0xFF4E03D0), () {
              Navigator.push(context, ReminderManagementScreen.route());
            }),
          ],
        ),
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

  Widget _daySectionHeader(String title, int count, {Color? color}) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            color: color ?? Colors.white,
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

  /// Floating chip shown under the finger while dragging a Day task row.
  Widget _dayDragFeedback(Task task) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFF4E03D0),
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.event_repeat_outlined,
                color: Colors.white, size: 16),
            SizedBox(width: 8.w),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 180.w),
              child: Text(
                task.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _compactTaskRow(Task task, PlanMyDayLoaded state) {
    final pColor = _dayPriorityColor(task.priority);
    final overdue = task.dueDate != null &&
        task.dueDate!.isBefore(DateTime.now()) &&
        !task.isCompleted;
    final contact = state.contactFor(task);
    final subtasks = state.subtasksFor(task.id);
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () => _showTaskDetailBottomSheet(task),
          onLongPress: () => TaskOptionsSheet.show(
            context,
            task: task,
            cubit: context.read<PlanMyDayCubit>(),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: _dayCard,
              borderRadius: BorderRadius.circular(12.r),
              border: Border(left: BorderSide(color: pColor, width: 3)),
            ),
            child: Row(
              children: [
                // ≡ handle — drag a task onto a week-strip day to reschedule.
                Draggable<Task>(
                  data: task,
                  dragAnchorStrategy: pointerDragAnchorStrategy,
                  feedback: _dayDragFeedback(task),
                  child: Padding(
                    padding: EdgeInsets.only(right: 6.w),
                    child: Icon(Icons.drag_indicator_rounded,
                        color: _dayBorder, size: 18.sp),
                  ),
                ),
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
                      if (contact != null || subtasks.isNotEmpty) ...[
                        SizedBox(height: 6.h),
                        Wrap(
                          spacing: 6.w,
                          runSpacing: 4.h,
                          children: [
                            if (subtasks.isNotEmpty) _subtaskCountChip(subtasks),
                            if (contact != null)
                              TaskContactChip(
                                contact: contact,
                                onTap: () => _openContact(contact),
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
                SizedBox(width: 4.w),
                GestureDetector(
                  onTap: () => TaskOptionsSheet.show(
                    context,
                    task: task,
                    cubit: context.read<PlanMyDayCubit>(),
                  ),
                  child: Icon(Icons.more_vert_rounded,
                      color: _dayMuted, size: 18.sp),
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

  /// Compact "N/M subtasks done" pill shown on a parent task card.
  Widget _subtaskCountChip(List<Task> subtasks) {
    final done = subtasks.where((t) => t.isCompleted).length;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: _dayBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.checklist_rounded, size: 12.sp, color: _dayMuted),
          SizedBox(width: 4.w),
          Text(
            '$done/${subtasks.length}',
            style: GoogleFonts.inter(
              color: _dayMuted,
              fontSize: 10.5.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// Jump from a task's contact chip to that person's CRM profile (People lens).
  void _openContact(Contact contact) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => serviceLocator<ContactCubit>(),
          child: ContactDetailScreen(contactId: contact.id),
        ),
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
      builder: (ctx) => _TaskDetailBottomSheet(
        task: task,
        cubit: context.read<PlanMyDayCubit>(),
      ),
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
