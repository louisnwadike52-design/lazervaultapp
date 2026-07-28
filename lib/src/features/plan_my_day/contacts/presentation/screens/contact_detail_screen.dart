import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/src/features/plan_my_day/contacts/domain/entities/contact.dart';
import 'package:lazervault/src/features/plan_my_day/contacts/domain/entities/contact_interaction.dart';
import 'package:lazervault/src/features/plan_my_day/contacts/presentation/cubit/contact_cubit.dart';
import 'package:lazervault/src/features/plan_my_day/contacts/presentation/cubit/contact_state.dart';
import 'package:lazervault/src/features/plan_my_day/contacts/presentation/widgets/contact_edit_sheet.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/task.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/task_status.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/plan_my_day_skeleton.dart';

class ContactDetailScreen extends StatefulWidget {
  final String contactId;
  const ContactDetailScreen({super.key, required this.contactId});

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  static const _card = Color(0xFF1F1F1F);
  static const _muted = Color(0xFF9CA3AF);
  static const _purple = Color(0xFF4E03D0);

  @override
  void initState() {
    super.initState();
    context.read<ContactCubit>().loadDetail(widget.contactId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: _card,
        elevation: 0,
        title: const Text('Contact',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocConsumer<ContactCubit, ContactState>(
        listener: (context, state) {
          if (state is ContactsLoaded) {
            // Contact was deleted → the detail no longer exists.
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is ContactDetailLoaded) {
            return _detail(state.contact, state.interactions, state.tasks);
          }
          if (state is ContactError) {
            return Center(
              child: Text(state.message,
                  style: GoogleFonts.inter(color: _muted, fontSize: 13.sp)),
            );
          }
          return const PlanContactDetailSkeleton();
        },
      ),
    );
  }

  Widget _detail(
      Contact c, List<ContactInteraction> interactions, List<Task> tasks) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 40.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56.w,
                height: 56.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _purple.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: _purple.withValues(alpha: 0.5)),
                ),
                child: Text(
                  c.initials,
                  style: GoogleFonts.inter(
                      color: _purple,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c.name,
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700)),
                    if ([c.role, c.company]
                        .any((e) => e != null && e.isNotEmpty))
                      Text(
                        [c.role, c.company]
                            .where((e) => e != null && e.isNotEmpty)
                            .join(' · '),
                        style:
                            GoogleFonts.inter(color: _muted, fontSize: 13.sp),
                      ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit_outlined, color: Colors.white),
                onPressed: () => ContactEditSheet.show(context,
                    cubit: context.read<ContactCubit>(), existing: c),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444)),
                onPressed: () => _confirmDelete(c),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          _infoCard(c),
          if ((c.notes ?? '').isNotEmpty) ...[
            SizedBox(height: 16.h),
            _section('Notes'),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                  color: _card, borderRadius: BorderRadius.circular(12.r)),
              child: Text(c.notes!,
                  style: GoogleFonts.inter(
                      color: Colors.white, fontSize: 13.5.sp, height: 1.4)),
            ),
          ],
          SizedBox(height: 20.h),
          Row(
            children: [
              _section('Tasks'),
              if (tasks.isNotEmpty) ...[
                SizedBox(width: 8.w),
                Text('${tasks.length}',
                    style: GoogleFonts.inter(color: _muted, fontSize: 12.sp)),
              ],
            ],
          ),
          SizedBox(height: 4.h),
          if (tasks.isEmpty)
            Text('No tasks linked to this person yet.',
                style: GoogleFonts.inter(color: _muted, fontSize: 13.sp))
          else
            ...tasks.map(_taskRow),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _section('Interactions'),
              TextButton.icon(
                onPressed: () => _logInteraction(c),
                icon: const Icon(Icons.add, color: _purple, size: 18),
                label: const Text('Log', style: TextStyle(color: _purple)),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          if (interactions.isEmpty)
            Text('No interactions logged yet.',
                style: GoogleFonts.inter(color: _muted, fontSize: 13.sp))
          else
            ...interactions.map(_interactionRow),
        ],
      ),
    );
  }

  Widget _infoCard(Contact c) {
    final rows = <(IconData, String)>[
      if ((c.email ?? '').isNotEmpty) (Icons.email_outlined, c.email!),
      if ((c.phone ?? '').isNotEmpty) (Icons.phone_outlined, c.phone!),
      if (c.lastContactedAt != null)
        (
          Icons.history_rounded,
          'Last contacted ${DateFormat('MMM d, yyyy').format(c.lastContactedAt!)}'
        ),
    ];
    if (rows.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration:
          BoxDecoration(color: _card, borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        children: [
          for (final (icon, text) in rows)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              child: Row(
                children: [
                  Icon(icon, color: _muted, size: 18.sp),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(text,
                        style: GoogleFonts.inter(
                            color: Colors.white, fontSize: 13.5.sp)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  /// A linked-task row on the contact profile — read-only (status + due date).
  Widget _taskRow(Task t) {
    final statusColor = PlanTaskStatus.colorFor(t.status);
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border(left: BorderSide(color: statusColor, width: 3)),
        ),
        child: Row(
          children: [
            Icon(
              t.isCompleted
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_unchecked_rounded,
              size: 18.sp,
              color: t.isCompleted ? const Color(0xFF10B981) : _muted,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                t.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: t.isCompleted ? _muted : Colors.white,
                  fontSize: 13.5.sp,
                  decoration:
                      t.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                PlanTaskStatus.labelFor(t.status),
                style: GoogleFonts.inter(
                    color: statusColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _interactionRow(ContactInteraction i) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: _purple.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(i.type,
                style: GoogleFonts.inter(
                    color: _purple,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600)),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if ((i.note ?? '').isNotEmpty)
                  Text(i.note!,
                      style: GoogleFonts.inter(
                          color: Colors.white, fontSize: 13.sp)),
                if (i.occurredAt != null)
                  Text(
                    DateFormat('MMM d, yyyy • h:mm a').format(i.occurredAt!),
                    style: GoogleFonts.inter(color: _muted, fontSize: 11.sp),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String t) => Text(t,
      style: GoogleFonts.inter(
          color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w600));

  void _logInteraction(Contact c) {
    final noteController = TextEditingController();
    String type = 'call';
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheet) => Padding(
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
                Text('Log interaction',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 14.h),
                Wrap(
                  spacing: 8.w,
                  children: [
                    for (final t in ['call', 'meeting', 'email', 'note'])
                      ChoiceChip(
                        label: Text(t),
                        selected: type == t,
                        onSelected: (_) => setSheet(() => type = t),
                        selectedColor: _purple,
                        backgroundColor: const Color(0xFF2D2D2D),
                        labelStyle: TextStyle(
                            color: type == t ? Colors.white : _muted),
                      ),
                  ],
                ),
                SizedBox(height: 14.h),
                TextField(
                  controller: noteController,
                  maxLines: 3,
                  style: GoogleFonts.inter(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Note (optional)',
                    hintStyle: GoogleFonts.inter(color: _muted),
                    filled: true,
                    fillColor: const Color(0xFF2D2D2D),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: _purple),
                    onPressed: () {
                      context.read<ContactCubit>().logInteraction(
                            c.id,
                            type,
                            note: noteController.text.trim().isEmpty
                                ? null
                                : noteController.text.trim(),
                          );
                      Navigator.pop(ctx);
                    },
                    child: const Text('Save',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _confirmDelete(Contact c) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _card,
        title: const Text('Delete contact',
            style: TextStyle(color: Colors.white)),
        content: Text('Delete "${c.name}"?',
            style: const TextStyle(color: Color(0xFFD1D5DB))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: _muted)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444)),
            onPressed: () {
              context.read<ContactCubit>().deleteContact(c.id);
              Navigator.pop(ctx);
            },
            child:
                const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
