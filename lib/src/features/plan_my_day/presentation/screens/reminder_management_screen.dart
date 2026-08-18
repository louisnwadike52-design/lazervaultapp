import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_cubit.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/reminders_list_body.dart';

/// Standalone Reminders screen (also embedded as the Plan My Day "Reminders"
/// tab via [RemindersListBody]). Reachable directly from a reminder push
/// notification's deep link. Provides its OWN scoped [PlanMyDayCubit] so its
/// ReminderListLoaded state never clobbers the board/day view.
class ReminderManagementScreen extends StatelessWidget {
  const ReminderManagementScreen({super.key});

  static Route<void> route() => MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => serviceLocator<PlanMyDayCubit>()..loadReminders(),
          child: const ReminderManagementScreen(),
        ),
      );

  static const _bg = Color(0xFF0A0A0A);
  static const _surface = Color(0xFF1F1F1F);
  static const _accent = Color(0xFF4E03D0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _surface,
        elevation: 0,
        title: Text('Reminders',
            style: GoogleFonts.inter(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w600)),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => RemindersListBody.openCreateSheet(context),
        backgroundColor: _accent,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text('New', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
      body: const RemindersListBody(),
    );
  }
}
