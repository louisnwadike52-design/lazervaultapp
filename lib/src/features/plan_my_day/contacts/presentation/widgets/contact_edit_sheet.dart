import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/src/features/plan_my_day/contacts/domain/entities/contact.dart';
import 'package:lazervault/src/features/plan_my_day/contacts/presentation/cubit/contact_cubit.dart';

/// Create/edit a contact. Pass [existing] to edit; omit to create.
class ContactEditSheet extends StatefulWidget {
  final ContactCubit cubit;
  final Contact? existing;

  const ContactEditSheet({super.key, required this.cubit, this.existing});

  static Future<void> show(BuildContext context,
      {required ContactCubit cubit, Contact? existing}) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => ContactEditSheet(cubit: cubit, existing: existing),
    );
  }

  @override
  State<ContactEditSheet> createState() => _ContactEditSheetState();
}

class _ContactEditSheetState extends State<ContactEditSheet> {
  static const _card = Color(0xFF1F1F1F);
  static const _field = Color(0xFF2D2D2D);
  static const _muted = Color(0xFF9CA3AF);
  static const _purple = Color(0xFF4E03D0);

  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _phone;
  late final TextEditingController _company;
  late final TextEditingController _role;
  late final TextEditingController _notes;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _name = TextEditingController(text: e?.name ?? '');
    _email = TextEditingController(text: e?.email ?? '');
    _phone = TextEditingController(text: e?.phone ?? '');
    _company = TextEditingController(text: e?.company ?? '');
    _role = TextEditingController(text: e?.role ?? '');
    _notes = TextEditingController(text: e?.notes ?? '');
  }

  @override
  void dispose() {
    for (final c in [_name, _email, _phone, _company, _role, _notes]) {
      c.dispose();
    }
    super.dispose();
  }

  String? _v(TextEditingController c) {
    final s = c.text.trim();
    return s.isEmpty ? null : s;
  }

  void _save() {
    final name = _name.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Name is required')));
      return;
    }
    final contact = Contact(
      id: widget.existing?.id ?? '',
      userId: widget.existing?.userId ?? '',
      name: name,
      email: _v(_email),
      phone: _v(_phone),
      company: _v(_company),
      role: _v(_role),
      notes: _v(_notes),
      tags: widget.existing?.tags ?? const [],
      avatarColor: widget.existing?.avatarColor,
    );
    if (widget.existing != null) {
      widget.cubit.updateContact(widget.existing!.id, contact);
    } else {
      widget.cubit.createContact(contact);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: _field,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              Text(
                widget.existing != null ? 'Edit contact' : 'New contact',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16.h),
              _tf(_name, 'Name'),
              _tf(_role, 'Role / title'),
              _tf(_company, 'Company'),
              _tf(_email, 'Email', keyboard: TextInputType.emailAddress),
              _tf(_phone, 'Phone', keyboard: TextInputType.phone),
              _tf(_notes, 'Notes', maxLines: 3),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _purple,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tf(TextEditingController c, String label,
      {int maxLines = 1, TextInputType? keyboard}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: TextField(
        controller: c,
        maxLines: maxLines,
        keyboardType: keyboard,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.inter(color: _muted, fontSize: 13.sp),
          filled: true,
          fillColor: _field,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
