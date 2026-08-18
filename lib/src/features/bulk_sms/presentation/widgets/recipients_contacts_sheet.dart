import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/models/device_contact.dart';
import 'package:lazervault/core/services/contact_service.dart';
import '../../domain/entities/bulk_sms_entities.dart';
import '../utils/bulk_sms_utils.dart';
import '../view/bulk_sms_theme.dart';

/// Multi-select device-contacts picker. Reuses [ContactService]; returns the
/// selected contacts as normalized-NG [SmsRecipientEntity]s (invalid numbers are
/// silently skipped). Returns null when cancelled.
class RecipientsContactsSheet extends StatefulWidget {
  final Set<String> existingNumbers;
  const RecipientsContactsSheet({super.key, this.existingNumbers = const {}});

  @override
  State<RecipientsContactsSheet> createState() =>
      _RecipientsContactsSheetState();
}

class _RecipientsContactsSheetState extends State<RecipientsContactsSheet> {
  final ContactService _service = ContactService();
  final TextEditingController _search = TextEditingController();

  bool _loading = true;
  bool _permissionDenied = false;
  List<DeviceContact> _all = [];
  List<DeviceContact> _filtered = [];
  final Set<String> _selected = {}; // normalized E.164

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
    final granted = await _service.requestPermission();
    if (!granted) {
      if (mounted) {
        setState(() {
          _loading = false;
          _permissionDenied = true;
        });
      }
      return;
    }
    final contacts = await _service.getContactsWithPhone();
    if (!mounted) return;
    setState(() {
      _all = contacts;
      _filtered = contacts;
      _loading = false;
    });
  }

  void _applyFilter() {
    final q = _search.text.trim().toLowerCase();
    setState(() {
      _filtered = q.isEmpty
          ? _all
          : _all
              .where((c) =>
                  c.name.toLowerCase().contains(q) ||
                  (c.phoneNumber ?? '').contains(q))
              .toList();
    });
  }

  String? _numberFor(DeviceContact c) => BulkSmsUtils.normalizeNg(
      c.phoneNumber ?? (c.phoneNumbers.isNotEmpty ? c.phoneNumbers.first : ''));

  void _toggle(DeviceContact c) {
    final num = _numberFor(c);
    if (num == null) return;
    setState(() {
      if (_selected.contains(num)) {
        _selected.remove(num);
      } else {
        _selected.add(num);
      }
    });
  }

  void _done() {
    final byNumber = <String, DeviceContact>{};
    for (final c in _all) {
      final num = _numberFor(c);
      if (num != null && _selected.contains(num)) {
        byNumber.putIfAbsent(num, () => c);
      }
    }
    final recipients = byNumber.entries
        .map((e) => SmsRecipientEntity(
              phoneNumber: e.key,
              name: e.value.name,
              variables: e.value.name.isEmpty ? const {} : {'name': e.value.name},
            ))
        .toList();
    Get.back(result: recipients);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: BulkSmsTheme.bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: BulkSmsTheme.divider,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Text('Select contacts',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700)),
                const Spacer(),
                Text('${_selected.length} selected',
                    style: TextStyle(
                        color: BulkSmsTheme.textSecondary, fontSize: 12.sp)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: TextField(
              controller: _search,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: 'Search name or number',
                hintStyle: TextStyle(
                    color: BulkSmsTheme.textSecondary, fontSize: 14.sp),
                prefixIcon: const Icon(Icons.search,
                    color: BulkSmsTheme.textSecondary),
                filled: true,
                fillColor: BulkSmsTheme.card,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Expanded(child: _list()),
          _doneBar(),
        ],
      ),
    );
  }

  Widget _list() {
    if (_loading) {
      return const Center(
          child: CircularProgressIndicator(color: BulkSmsTheme.primary));
    }
    if (_permissionDenied) {
      return Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.contacts_outlined,
                size: 44.sp, color: BulkSmsTheme.textSecondary),
            SizedBox(height: 12.h),
            Text('Contacts permission needed',
                style: TextStyle(color: Colors.white, fontSize: 15.sp)),
            SizedBox(height: 6.h),
            Text('Enable contacts access in Settings to pick recipients.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: BulkSmsTheme.textSecondary, fontSize: 12.sp)),
            SizedBox(height: 14.h),
            TextButton(
              onPressed: () => _service.openSettings(),
              child: const Text('Open Settings'),
            ),
          ],
        ),
      );
    }
    if (_filtered.isEmpty) {
      return Center(
        child: Text('No contacts with phone numbers',
            style: TextStyle(
                color: BulkSmsTheme.textSecondary, fontSize: 13.sp)),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: _filtered.length,
      itemBuilder: (context, i) {
        final c = _filtered[i];
        final num = _numberFor(c);
        final valid = num != null;
        final selected = valid && _selected.contains(num);
        return Opacity(
          opacity: valid ? 1 : 0.4,
          child: GestureDetector(
            onTap: valid ? () => _toggle(c) : null,
            child: Container(
              margin: EdgeInsets.only(bottom: 8.h),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: selected
                    ? BulkSmsTheme.primary.withValues(alpha: 0.12)
                    : BulkSmsTheme.card,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color:
                      selected ? BulkSmsTheme.primary : BulkSmsTheme.divider,
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18.r,
                    backgroundColor:
                        BulkSmsTheme.primary.withValues(alpha: 0.2),
                    child: Text(
                      c.initials.isEmpty ? '?' : c.initials,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white, fontSize: 14.sp)),
                        Text(
                          valid
                              ? BulkSmsUtils.pretty(num)
                              : (c.phoneNumber ?? 'No valid number'),
                          style: TextStyle(
                              color: BulkSmsTheme.textSecondary,
                              fontSize: 11.sp),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    selected
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: selected
                        ? BulkSmsTheme.primary
                        : BulkSmsTheme.textSecondary,
                    size: 22.sp,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _doneBar() {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: SizedBox(
        width: double.infinity,
        height: 52.h,
        child: ElevatedButton(
          onPressed: _selected.isEmpty ? null : _done,
          style: ElevatedButton.styleFrom(
            backgroundColor: BulkSmsTheme.primary,
            disabledBackgroundColor:
                BulkSmsTheme.primary.withValues(alpha: 0.4),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r)),
          ),
          child: Text('Add ${_selected.length} recipients',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }
}
