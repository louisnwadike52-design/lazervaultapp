import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/src/features/plan_my_day/contacts/domain/entities/contact.dart';
import 'package:lazervault/src/features/plan_my_day/contacts/presentation/cubit/contact_cubit.dart';
import 'package:lazervault/src/features/plan_my_day/contacts/presentation/cubit/contact_state.dart';
import 'package:lazervault/src/features/plan_my_day/contacts/presentation/screens/contact_detail_screen.dart';
import 'package:lazervault/src/features/plan_my_day/contacts/presentation/widgets/contact_edit_sheet.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/plan_my_day_skeleton.dart';

/// People view — the CRM contacts list (rendered as a segment of Plan My Day).
class ContactsListScreen extends StatefulWidget {
  const ContactsListScreen({super.key});

  @override
  State<ContactsListScreen> createState() => _ContactsListScreenState();
}

class _ContactsListScreenState extends State<ContactsListScreen> {
  static const _muted = Color(0xFF9CA3AF);
  static const _purple = Color(0xFF4E03D0);
  String _query = '';

  @override
  void initState() {
    super.initState();
    context.read<ContactCubit>().loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
              child: TextField(
                onChanged: (v) => setState(() => _query = v.toLowerCase()),
                style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
                decoration: InputDecoration(
                  hintText: 'Search people',
                  hintStyle: GoogleFonts.inter(color: _muted, fontSize: 14.sp),
                  prefixIcon: const Icon(Icons.search, color: _muted),
                  filled: true,
                  fillColor: const Color(0xFF1F1F1F),
                  contentPadding: EdgeInsets.symmetric(vertical: 4.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<ContactCubit, ContactState>(
                builder: (context, state) {
                  if (state is ContactLoading) {
                    return const PlanContactsSkeleton();
                  }
                  if (state is ContactError) {
                    return _errorView(state.message);
                  }
                  final all = context.read<ContactCubit>().contacts;
                  final list = _query.isEmpty
                      ? all
                      : all
                          .where((c) =>
                              c.name.toLowerCase().contains(_query) ||
                              (c.company ?? '')
                                  .toLowerCase()
                                  .contains(_query) ||
                              (c.email ?? '').toLowerCase().contains(_query))
                          .toList();
                  if (list.isEmpty) return _emptyView();
                  return ListView.builder(
                    padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 96.h),
                    itemCount: list.length,
                    itemBuilder: (_, i) => _contactTile(list[i]),
                  );
                },
              ),
            ),
          ],
        ),
        Positioned(
          right: 20.w,
          bottom: 20.h,
          child: FloatingActionButton(
            heroTag: 'add_contact_fab',
            backgroundColor: _purple,
            onPressed: () => ContactEditSheet.show(
              context,
              cubit: context.read<ContactCubit>(),
            ),
            child: const Icon(Icons.person_add_alt_1, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _contactTile(Contact c) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Material(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(14.r),
          onTap: () {
            final cubit = context.read<ContactCubit>();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: cubit,
                  child: ContactDetailScreen(contactId: c.id),
                ),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              children: [
                _avatar(c),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.name,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if ((c.role ?? c.company) != null) ...[
                        SizedBox(height: 2.h),
                        Text(
                          [c.role, c.company]
                              .where((e) => e != null && e.isNotEmpty)
                              .join(' · '),
                          style:
                              GoogleFonts.inter(color: _muted, fontSize: 12.sp),
                        ),
                      ],
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: _muted, size: 20.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _avatar(Contact c) {
    final color = _colorFor(c);
    return Container(
      width: 42.w,
      height: 42.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        c.initials,
        style: GoogleFonts.inter(
          color: color,
          fontSize: 15.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Color _colorFor(Contact c) {
    final hex = c.avatarColor;
    if (hex != null && hex.isNotEmpty) {
      final v = hex.replaceAll('#', '');
      final parsed = int.tryParse('FF$v', radix: 16);
      if (parsed != null) return Color(parsed);
    }
    const palette = [
      Color(0xFF3B82F6),
      Color(0xFF10B981),
      Color(0xFFFB923C),
      Color(0xFF8B5CF6),
      Color(0xFFEF4444),
    ];
    return palette[c.name.hashCode.abs() % palette.length];
  }

  Widget _emptyView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline_rounded, color: _muted, size: 48.sp),
            SizedBox(height: 16.h),
            Text(
              'No people yet',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Add the people you work with — then link tasks and log '
              'interactions to keep your CRM in one place.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: _muted, fontSize: 13.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _errorView(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: _muted, size: 40.sp),
          SizedBox(height: 12.h),
          Text(message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: _muted, fontSize: 13.sp)),
          SizedBox(height: 12.h),
          TextButton(
            onPressed: () => context.read<ContactCubit>().loadContacts(),
            child: const Text('Retry', style: TextStyle(color: _purple)),
          ),
        ],
      ),
    );
  }
}
