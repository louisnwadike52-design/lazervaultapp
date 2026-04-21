import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

/// Airtime-specific contact picker.
///
/// Phone-only: filters out contacts without phone numbers. On a contact with
/// multiple phones, inline-expands a sub-picker. Returns `(displayName, phone)`.
class AirtimeContactPickerSheet extends StatefulWidget {
  final void Function(String name, String phone) onPicked;

  const AirtimeContactPickerSheet({super.key, required this.onPicked});

  @override
  State<AirtimeContactPickerSheet> createState() =>
      _AirtimeContactPickerSheetState();
}

class _AirtimeContactPickerSheetState extends State<AirtimeContactPickerSheet> {
  List<Contact> _contacts = [];
  List<Contact> _filtered = [];
  bool _loading = true;
  bool _denied = false;
  String? _expandedContactId;
  final TextEditingController _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    _search.addListener(_applyFilter);
    _load();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _denied = false;
    });
    final status = await Permission.contacts.request();
    if (!status.isGranted) {
      setState(() {
        _denied = true;
        _loading = false;
      });
      return;
    }
    try {
      final list = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: false,
      );
      final withPhones =
          list.where((c) => c.phones.isNotEmpty).toList()
            ..sort((a, b) => a.displayName
                .toLowerCase()
                .compareTo(b.displayName.toLowerCase()));
      if (!mounted) return;
      setState(() {
        _contacts = withPhones;
        _filtered = withPhones;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Couldn\'t read contacts: $e'),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
    }
  }

  void _applyFilter() {
    final q = _search.text.toLowerCase().trim();
    setState(() {
      _filtered = q.isEmpty
          ? _contacts
          : _contacts.where((c) {
              final name = c.displayName.toLowerCase();
              final phoneMatch =
                  c.phones.any((p) => p.number.replaceAll(' ', '').contains(q));
              return name.contains(q) || phoneMatch;
            }).toList();
    });
  }

  /// Normalize to Nigerian local format: strip whitespace, convert
  /// +234.../234... -> 0..., keep other formats as-is (stripped).
  String _normalizeNg(String raw) {
    var digits = raw.replaceAll(RegExp(r'[^\d+]'), '');
    if (digits.startsWith('+234')) digits = '0${digits.substring(4)}';
    else if (digits.startsWith('234') && digits.length > 10) {
      digits = '0${digits.substring(3)}';
    }
    return digits.replaceAll('+', '');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(),
          if (_loading)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(color: Color(0xFF4E03D0)),
              ),
            )
          else if (_denied)
            Expanded(child: _buildPermissionDenied())
          else ...[
            _buildSearch(),
            Expanded(child: _buildList()),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.contacts,
                color: const Color(0xFF4E03D0), size: 22.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pick from Contacts',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Select the number to top up',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white.withValues(alpha: 0.65),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(Icons.close, color: Colors.white, size: 18.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 8.h),
      child: TextField(
        controller: _search,
        style: TextStyle(color: Colors.white, fontSize: 15.sp),
        decoration: InputDecoration(
          hintText: 'Search name or number',
          hintStyle: TextStyle(
            color: Colors.white.withValues(alpha: 0.4),
            fontSize: 14.sp,
          ),
          filled: true,
          fillColor: const Color(0xFF0A0A0A),
          prefixIcon: Icon(Icons.search,
              color: Colors.white.withValues(alpha: 0.5), size: 20.sp),
          suffixIcon: _search.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear,
                      color: Colors.white.withValues(alpha: 0.5), size: 18.sp),
                  onPressed: () => _search.clear(),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Color(0xFF4E03D0), width: 2),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        ),
      ),
    );
  }

  Widget _buildList() {
    if (_filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_off,
                size: 48.sp, color: Colors.white.withValues(alpha: 0.3)),
            SizedBox(height: 12.h),
            Text(
              _search.text.isEmpty
                  ? 'No contacts with phone numbers'
                  : 'No matching contacts',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      );
    }
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      itemCount: _filtered.length,
      separatorBuilder: (_, __) => SizedBox(height: 6.h),
      itemBuilder: (_, i) => _buildTile(_filtered[i]),
    );
  }

  Widget _buildTile(Contact contact) {
    final expanded = _expandedContactId == contact.id;
    final hasMany = contact.phones.length > 1;
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: expanded
              ? const Color(0xFF4E03D0).withValues(alpha: 0.5)
              : const Color(0xFF2D2D2D),
        ),
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(12.r),
            onTap: () {
              if (hasMany) {
                setState(() {
                  _expandedContactId = expanded ? null : contact.id;
                });
              } else {
                final phone = _normalizeNg(contact.phones.first.number);
                widget.onPicked(contact.displayName, phone);
                Navigator.pop(context);
              }
            },
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Center(
                      child: Text(
                        contact.displayName.isNotEmpty
                            ? contact.displayName[0].toUpperCase()
                            : '?',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF4E03D0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          contact.displayName.isNotEmpty
                              ? contact.displayName
                              : contact.phones.first.number,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          hasMany
                              ? '${contact.phones.length} numbers'
                              : contact.phones.first.number,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white.withValues(alpha: 0.55),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    hasMany
                        ? (expanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down)
                        : Icons.arrow_forward_ios,
                    color: Colors.white.withValues(alpha: 0.4),
                    size: 16.sp,
                  ),
                ],
              ),
            ),
          ),
          if (expanded && hasMany)
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 12.h),
              child: Column(
                children: contact.phones.map((p) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(8.r),
                    onTap: () {
                      final phone = _normalizeNg(p.number);
                      widget.onPicked(contact.displayName, phone);
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 6.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F1F1F),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.phone,
                              size: 14.sp, color: const Color(0xFF4E03D0)),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              p.number,
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          if (p.label != PhoneLabel.custom)
                            Text(
                              p.label.name,
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.white.withValues(alpha: 0.5),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPermissionDenied() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(28.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.contacts_outlined,
                size: 56.sp, color: const Color(0xFFFB923C)),
            SizedBox(height: 16.h),
            Text(
              'Contacts access needed',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Allow LazerVault to read your contacts so you can quickly '
              'pick a number to top up.',
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.white.withValues(alpha: 0.65),
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                ElevatedButton(
                  onPressed: () async {
                    await openAppSettings();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4E03D0),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                        horizontal: 22.w, vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'Open Settings',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
