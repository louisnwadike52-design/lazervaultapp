import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/shared_widgets/lv_snackbar.dart';
import '../../domain/entities/bulk_sms_entities.dart';
import '../cubit/bulk_sms_cubit.dart';
import '../utils/bulk_sms_utils.dart';
import '../view/bulk_sms_theme.dart';
import 'recipients_contacts_sheet.dart';
import 'recipients_csv_importer.dart';
import 'recipients_groups_sheet.dart';

/// Bottom sheet that builds the recipient list four ways: manual/paste,
/// contacts, CSV/file import, and saved groups. Returns the deduped recipient
/// list to the caller.
class RecipientsPickerSheet extends StatefulWidget {
  final List<SmsRecipientEntity> initial;

  /// Shared feature cubit — powers the saved-groups tab (list/create/delete).
  final BulkSmsCubit cubit;

  const RecipientsPickerSheet({
    super.key,
    required this.cubit,
    this.initial = const [],
  });

  @override
  State<RecipientsPickerSheet> createState() => _RecipientsPickerSheetState();
}

class _RecipientsPickerSheetState extends State<RecipientsPickerSheet> {
  // Keyed by normalized E.164 so duplicates never enter the list.
  final Map<String, SmsRecipientEntity> _recipients = {};
  final TextEditingController _pasteController = TextEditingController();
  bool _showPaste = false;

  @override
  void initState() {
    super.initState();
    for (final r in widget.initial) {
      _recipients[r.phoneNumber] = r;
    }
  }

  @override
  void dispose() {
    _pasteController.dispose();
    super.dispose();
  }

  Set<String> get _numbers => _recipients.keys.toSet();

  void _addAll(List<SmsRecipientEntity> list) {
    var added = 0;
    for (final r in list) {
      if (!_recipients.containsKey(r.phoneNumber)) {
        _recipients[r.phoneNumber] = r;
        added++;
      }
    }
    if (mounted) setState(() {});
    if (added > 0) {
      LVSnackbar.showSuccess(
          title: 'Added', message: '$added recipient(s) added.');
    }
  }

  void _applyPaste() {
    final parsed = BulkSmsUtils.parseNumbers(_pasteController.text);
    if (parsed.valid.isEmpty) {
      LVSnackbar.showError(
          title: 'No valid numbers',
          message: 'Enter Nigerian phone numbers separated by commas or lines.');
      return;
    }
    _addAll(parsed.valid
        .map((n) => SmsRecipientEntity(phoneNumber: n))
        .toList());
    if (parsed.invalidCount > 0) {
      LVSnackbar.showInfo(
          title: 'Some skipped',
          message: '${parsed.invalidCount} entr(ies) were not valid numbers.');
    }
    _pasteController.clear();
    setState(() => _showPaste = false);
  }

  Future<void> _pickContacts() async {
    final result = await showModalBottomSheet<List<SmsRecipientEntity>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => RecipientsContactsSheet(existingNumbers: _numbers),
    );
    if (result != null && result.isNotEmpty) _addAll(result);
  }

  Future<void> _openGroups() async {
    final result = await showModalBottomSheet<List<SmsRecipientEntity>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => RecipientsGroupsSheet(
        cubit: widget.cubit,
        currentRecipients: _recipients.values.toList(),
      ),
    );
    if (result != null && result.isNotEmpty) _addAll(result);
  }

  Future<void> _importCsv() async {
    final result =
        await RecipientsCsvImporter.pickAndParse(existingNumbers: _numbers);
    if (result.cancelled) return;
    if (result.recipients.isEmpty) {
      LVSnackbar.showError(
          title: 'Nothing imported',
          message: result.invalidCount > 0
              ? '${result.invalidCount} row(s) had invalid numbers.'
              : 'No recipients found in that file.');
      return;
    }
    _addAll(result.recipients);
    if (result.invalidCount > 0 || result.duplicateCount > 0) {
      LVSnackbar.showInfo(
        title: 'Import summary',
        message:
            '${result.invalidCount} invalid · ${result.duplicateCount} duplicate skipped.',
      );
    }
  }

  void _remove(String number) {
    setState(() => _recipients.remove(number));
  }

  void _done() {
    Get.back(result: _recipients.values.toList());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
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
                borderRadius: BorderRadius.circular(2.r)),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Text('Recipients',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700)),
                const Spacer(),
                Text('${_recipients.length} added',
                    style: TextStyle(
                        color: BulkSmsTheme.primary,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              children: [
                _methodGrid(),
                if (_showPaste) ...[
                  SizedBox(height: 14.h),
                  _pasteBox(),
                ],
                SizedBox(height: 18.h),
                _selectedHeader(),
                SizedBox(height: 10.h),
                ..._selectedList(),
                SizedBox(height: 20.h),
              ],
            ),
          ),
          _doneBar(),
        ],
      ),
    );
  }

  Widget _methodGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _methodTile(
                icon: Icons.keyboard_alt_outlined,
                label: 'Type / paste',
                onTap: () => setState(() => _showPaste = !_showPaste),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _methodTile(
                icon: Icons.contacts_rounded,
                label: 'Contacts',
                onTap: _pickContacts,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(
              child: _methodTile(
                icon: Icons.upload_file_rounded,
                label: 'Import CSV',
                onTap: _importCsv,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _methodTile(
                icon: Icons.groups_2_outlined,
                label: 'Saved groups',
                onTap: _openGroups,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _methodTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool disabled = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: disabled ? 0.5 : 1,
        child: Container(
          height: 74.h,
          decoration: BoxDecoration(
            color: BulkSmsTheme.card,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: BulkSmsTheme.divider),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: BulkSmsTheme.primary, size: 22.sp),
              SizedBox(height: 6.h),
              Text(
                disabled ? '$label (soon)' : label,
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pasteBox() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: BulkSmsTheme.card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: BulkSmsTheme.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _pasteController,
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9+\s,;\n\-()]')),
            ],
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
            decoration: InputDecoration(
              hintText: '0803 123 4567, 0810 987 6543\n0906 555 1212',
              hintStyle: TextStyle(
                  color: BulkSmsTheme.textSecondary, fontSize: 13.sp),
              border: InputBorder.none,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: _applyPaste,
              child: Text('Add numbers',
                  style: TextStyle(
                      color: BulkSmsTheme.primary,
                      fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _selectedHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Added recipients',
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700)),
        if (_recipients.isNotEmpty)
          GestureDetector(
            onTap: () => setState(_recipients.clear),
            child: Text('Clear all',
                style: TextStyle(color: BulkSmsTheme.error, fontSize: 12.sp)),
          ),
      ],
    );
  }

  List<Widget> _selectedList() {
    if (_recipients.isEmpty) {
      return [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Center(
            child: Text('No recipients yet',
                style: TextStyle(
                    color: BulkSmsTheme.textSecondary, fontSize: 13.sp)),
          ),
        ),
      ];
    }
    return _recipients.values.map((r) {
      return Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: BulkSmsTheme.card,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Icon(Icons.phone_iphone_rounded,
                size: 16.sp, color: BulkSmsTheme.textSecondary),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(BulkSmsUtils.pretty(r.phoneNumber),
                      style:
                          TextStyle(color: Colors.white, fontSize: 13.sp)),
                  if (r.name.isNotEmpty)
                    Text(r.name,
                        style: TextStyle(
                            color: BulkSmsTheme.textSecondary,
                            fontSize: 11.sp)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => _remove(r.phoneNumber),
              child: Icon(Icons.close,
                  size: 18.sp, color: BulkSmsTheme.textSecondary),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _doneBar() {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: SizedBox(
        width: double.infinity,
        height: 52.h,
        child: ElevatedButton(
          onPressed: _done,
          style: ElevatedButton.styleFrom(
            backgroundColor: BulkSmsTheme.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r)),
          ),
          child: Text('Done · ${_recipients.length} recipients',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }
}
