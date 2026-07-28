import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/plan_my_day/habits/domain/habit.dart';
import 'package:lazervault/src/features/plan_my_day/habits/presentation/habit_cubit.dart';

class HabitsScreen extends StatelessWidget {
  const HabitsScreen({super.key});

  static Route<void> route() => MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => serviceLocator<HabitCubit>()..loadHabits(),
          child: const HabitsScreen(),
        ),
      );

  static const _card = Color(0xFF1F1F1F);
  static const _muted = Color(0xFF9CA3AF);
  static const _purple = Color(0xFF4E03D0);
  static const _amber = Color(0xFFFB923C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: _card,
        elevation: 0,
        title: const Text('Habits',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: Builder(
        builder: (ctx) => FloatingActionButton(
          backgroundColor: _purple,
          onPressed: () => _editHabit(ctx),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      body: BlocBuilder<HabitCubit, HabitState>(
        builder: (context, state) {
          if (state is HabitLoading || state is HabitInitial) {
            return const Center(
                child: CircularProgressIndicator(color: _purple));
          }
          if (state is HabitError) {
            return Center(
              child: Text(state.message,
                  style: GoogleFonts.inter(color: _muted, fontSize: 13.sp)),
            );
          }
          final habits = state is HabitsLoaded ? state.habits : <Habit>[];
          if (habits.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(32.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.local_fire_department_outlined,
                        color: _muted, size: 48.sp),
                    SizedBox(height: 14.h),
                    Text('No habits yet',
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600)),
                    SizedBox(height: 6.h),
                    Text('Build streaks — mark a habit done each day.',
                        textAlign: TextAlign.center,
                        style:
                            GoogleFonts.inter(color: _muted, fontSize: 13.sp)),
                  ],
                ),
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 96.h),
            itemCount: habits.length,
            itemBuilder: (_, i) => _habitCard(context, habits[i]),
          );
        },
      ),
    );
  }

  Widget _habitCard(BuildContext context, Habit h) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration:
            BoxDecoration(color: _card, borderRadius: BorderRadius.circular(14.r)),
        child: Row(
          children: [
            Column(
              children: [
                Icon(Icons.local_fire_department_rounded,
                    color: h.currentStreak > 0 ? _amber : _muted, size: 24.sp),
                Text('${h.currentStreak}',
                    style: GoogleFonts.inter(
                        color: h.currentStreak > 0 ? _amber : _muted,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(h.title,
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 2.h),
                  Text(
                    'Best ${h.longestStreak} · ${h.frequency ?? 'daily'}',
                    style: GoogleFonts.inter(color: _muted, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert, color: _muted),
              onPressed: () => _habitMenu(context, h),
            ),
            GestureDetector(
              onTap: () => context.read<HabitCubit>().logToday(h.id),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: _purple,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check, color: Colors.white, size: 16),
                    SizedBox(width: 4.w),
                    Text('Done',
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _habitMenu(BuildContext context, Habit h) {
    final cubit = context.read<HabitCubit>();
    showModalBottomSheet(
      context: context,
      backgroundColor: _card,
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit_outlined, color: Colors.white),
            title: const Text('Edit', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(ctx);
              _editHabit(context, habit: h);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline, color: Color(0xFFEF4444)),
            title: const Text('Delete', style: TextStyle(color: Colors.white)),
            onTap: () {
              cubit.deleteHabit(h.id);
              Navigator.pop(ctx);
            },
          ),
        ],
      ),
    );
  }

  void _editHabit(BuildContext context, {Habit? habit}) {
    final cubit = context.read<HabitCubit>();
    final titleC = TextEditingController(text: habit?.title ?? '');
    final descC = TextEditingController(text: habit?.description ?? '');
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Container(
          decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(habit != null ? 'Edit habit' : 'New habit',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 14.h),
              TextField(
                controller: titleC,
                style: GoogleFonts.inter(color: Colors.white),
                decoration: _dec('Habit (e.g. Read 20 min)'),
              ),
              SizedBox(height: 10.h),
              TextField(
                controller: descC,
                style: GoogleFonts.inter(color: Colors.white),
                decoration: _dec('Description (optional)'),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: _purple),
                  onPressed: () {
                    final title = titleC.text.trim();
                    if (title.isEmpty) {
                      Navigator.pop(ctx);
                      return;
                    }
                    cubit.saveHabit(
                      id: habit?.id,
                      title: title,
                      description: descC.text.trim().isEmpty
                          ? null
                          : descC.text.trim(),
                    );
                    Navigator.pop(ctx);
                  },
                  child:
                      const Text('Save', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _dec(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: _muted),
        filled: true,
        fillColor: const Color(0xFF2D2D2D),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
      );
}
