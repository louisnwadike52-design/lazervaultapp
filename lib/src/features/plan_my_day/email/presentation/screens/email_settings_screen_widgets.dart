part of 'email_settings_screen.dart';

/// Bottom sheet form to add an auto-reply rule.
class _RuleFormSheet extends StatefulWidget {
  const _RuleFormSheet();

  @override
  State<_RuleFormSheet> createState() => _RuleFormSheetState();
}

class _RuleFormSheetState extends State<_RuleFormSheet> {
  final _name = TextEditingController();
  final _fromContains = TextEditingController();
  final _subjectContains = TextEditingController();
  final _label = TextEditingController();
  String _mode = 'approve';
  String _tone = 'professional';
  bool _enabled = true;

  @override
  void dispose() {
    _name.dispose();
    _fromContains.dispose();
    _subjectContains.dispose();
    _label.dispose();
    super.dispose();
  }

  InputDecoration _dec(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
            color: EmailPalette.textSecondary, fontSize: 13.sp),
        filled: true,
        fillColor: EmailPalette.background,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: EmailPalette.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: EmailPalette.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: EmailPalette.primary),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: EmailPalette.card,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('New auto-reply rule',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 16.h),
              _fieldLabel('Rule name'),
              TextField(
                controller: _name,
                style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
                decoration: _dec('e.g. Newsletters'),
              ),
              SizedBox(height: 12.h),
              _fieldLabel('From contains'),
              TextField(
                controller: _fromContains,
                style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
                decoration: _dec('e.g. @company.com'),
              ),
              SizedBox(height: 12.h),
              _fieldLabel('Subject contains'),
              TextField(
                controller: _subjectContains,
                style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
                decoration: _dec('e.g. invoice'),
              ),
              SizedBox(height: 12.h),
              _fieldLabel('Label (optional)'),
              TextField(
                controller: _label,
                style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
                decoration: _dec('e.g. Finance'),
              ),
              SizedBox(height: 16.h),
              _fieldLabel('Mode'),
              Row(
                children: [
                  _modeChip('Approve first', 'approve'),
                  SizedBox(width: 10.w),
                  _modeChip('Auto-send', 'auto_send'),
                ],
              ),
              SizedBox(height: 16.h),
              _fieldLabel('Tone'),
              ToneSelector(
                selected: _tone,
                onChanged: (t) => setState(() => _tone = t),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Switch(
                    value: _enabled,
                    activeThumbColor: EmailPalette.success,
                    onChanged: (v) => setState(() => _enabled = v),
                  ),
                  Text('Enabled',
                      style: GoogleFonts.inter(
                          color: EmailPalette.textSecondary, fontSize: 13.sp)),
                ],
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: EmailPalette.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: Text('Save rule',
                      style: GoogleFonts.inter(
                          fontSize: 15.sp, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fieldLabel(String text) => Padding(
        padding: EdgeInsets.only(bottom: 6.h),
        child: Text(text,
            style: GoogleFonts.inter(
                color: EmailPalette.textSecondary, fontSize: 12.sp)),
      );

  Widget _modeChip(String label, String value) {
    final selected = _mode == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _mode = value),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 11.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? EmailPalette.primary : EmailPalette.background,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
                color: selected ? EmailPalette.primary : EmailPalette.divider),
          ),
          child: Text(label,
              style: GoogleFonts.inter(
                  color: selected ? Colors.white : EmailPalette.textSecondary,
                  fontSize: 13.sp,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400)),
        ),
      ),
    );
  }

  void _save() {
    if (_name.text.trim().isEmpty &&
        _fromContains.text.trim().isEmpty &&
        _subjectContains.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Add a name and at least one match condition')),
      );
      return;
    }
    Navigator.pop(
      context,
      EmailRule(
        id: '',
        name: _name.text.trim(),
        fromContains: _fromContains.text.trim(),
        subjectContains: _subjectContains.text.trim(),
        label: _label.text.trim(),
        mode: _mode,
        tone: _tone,
        enabled: _enabled,
      ),
    );
  }
}
