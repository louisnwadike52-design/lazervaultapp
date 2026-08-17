part of 'payment_confirmation_screen.dart';

/// Nickname dialog body — owns its own `TextEditingController` so the
/// controller is disposed through the widget tree's normal teardown
/// rather than synchronously after `Navigator.pop()`. The old inline
/// implementation disposed the controller while the dialog's fade-out
/// animation was still in flight, triggering
/// `dependents.isEmpty is not true` in debug builds.
class _NicknameDialog extends StatefulWidget {
  final String initial;
  const _NicknameDialog({required this.initial});

  @override
  State<_NicknameDialog> createState() => _NicknameDialogState();
}

class _NicknameDialogState extends State<_NicknameDialog> {
  late final TextEditingController _controller;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initial);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final v = _controller.text.trim();
    if (v.isEmpty) {
      setState(() => _error = 'Nickname is required');
      return;
    }
    Navigator.of(context).pop(v);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: InvoiceThemeColors.secondaryBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: Text('Save this meter',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Give this meter a nickname so you can find it fast next time.',
            style: GoogleFonts.inter(
              color: InvoiceThemeColors.textGray400,
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 14.h),
          TextField(
            controller: _controller,
            autofocus: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submit(),
            style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
            decoration: InputDecoration(
              hintText: 'e.g. Home, Office',
              hintStyle: GoogleFonts.inter(
                  color: const Color(0xFF4B5563), fontSize: 14.sp),
              errorText: _error,
              filled: true,
              fillColor: InvoiceThemeColors.inputBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide:
                    const BorderSide(color: InvoiceThemeColors.borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide:
                    const BorderSide(color: InvoiceThemeColors.borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(
                    color: InvoiceThemeColors.primaryPurple),
              ),
            ),
            onChanged: (_) {
              if (_error != null) setState(() => _error = null);
            },
          ),
        ],
      ),
      actionsPadding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 8.h),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: Text('Cancel',
              style: GoogleFonts.inter(
                  color: InvoiceThemeColors.textGray400, fontSize: 14.sp)),
        ),
        TextButton(
          onPressed: _submit,
          child: Text('Save',
              style: GoogleFonts.inter(
                  color: InvoiceThemeColors.primaryPurple,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}
