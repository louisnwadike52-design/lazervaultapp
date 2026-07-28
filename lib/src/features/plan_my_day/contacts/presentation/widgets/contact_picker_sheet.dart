import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/plan_my_day/contacts/data/contact_repository.dart';
import 'package:lazervault/src/features/plan_my_day/contacts/domain/entities/contact.dart';

/// Bottom sheet that lists CRM contacts and returns the chosen one (or a
/// sentinel "unlink" contact with an empty id). Loads via ContactRepository so
/// it can be used from anywhere (e.g. the task options menu) without a cubit.
class ContactPickerSheet extends StatefulWidget {
  const ContactPickerSheet({super.key});

  /// Returns the selected [Contact], a Contact with empty id to unlink, or null.
  static Future<Contact?> show(BuildContext context) {
    return showModalBottomSheet<Contact>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const ContactPickerSheet(),
    );
  }

  @override
  State<ContactPickerSheet> createState() => _ContactPickerSheetState();
}

class _ContactPickerSheetState extends State<ContactPickerSheet> {
  static const _card = Color(0xFF1F1F1F);
  static const _muted = Color(0xFF9CA3AF);
  static const _purple = Color(0xFF4E03D0);

  late final Future<List<Contact>> _future;

  @override
  void initState() {
    super.initState();
    _future = serviceLocator<ContactRepository>().getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 0.7.sh),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D2D),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Text('Link to contact',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600)),
                const Spacer(),
                TextButton(
                  onPressed: () => Navigator.pop(
                      context,
                      const Contact(id: '', userId: '', name: '')),
                  child: const Text('Unlink',
                      style: TextStyle(color: Color(0xFFEF4444))),
                ),
              ],
            ),
          ),
          Flexible(
            child: FutureBuilder<List<Contact>>(
              future: _future,
              builder: (context, snap) {
                if (snap.connectionState != ConnectionState.done) {
                  return Padding(
                    padding: EdgeInsets.all(24.w),
                    child: const Center(
                        child: CircularProgressIndicator(color: _purple)),
                  );
                }
                final contacts = snap.data ?? const [];
                if (contacts.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Text('No contacts yet. Add people in the People tab.',
                        textAlign: TextAlign.center,
                        style:
                            GoogleFonts.inter(color: _muted, fontSize: 13.sp)),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 16.h),
                  itemCount: contacts.length,
                  itemBuilder: (_, i) {
                    final c = contacts[i];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: _purple.withValues(alpha: 0.2),
                        child: Text(c.initials,
                            style: GoogleFonts.inter(
                                color: _purple,
                                fontWeight: FontWeight.w700,
                                fontSize: 13.sp)),
                      ),
                      title: Text(c.name,
                          style: GoogleFonts.inter(
                              color: Colors.white, fontSize: 14.sp)),
                      subtitle: (c.company ?? c.role) != null
                          ? Text(
                              [c.role, c.company]
                                  .where((e) => e != null && e.isNotEmpty)
                                  .join(' · '),
                              style: GoogleFonts.inter(
                                  color: _muted, fontSize: 12.sp))
                          : null,
                      onTap: () => Navigator.pop(context, c),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
