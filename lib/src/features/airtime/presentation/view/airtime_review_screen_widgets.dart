part of 'airtime_review_screen.dart';

/// Nickname-collection dialog opened when "Save as contact" is toggled
/// on. Mirrors the electricity meter "_NicknameDialog": single text
/// field, Cancel returns null, Save returns the trimmed value (refuses
/// empty so the toggle stays off when the user submits a blank field).
class _AirtimeNicknameDialog extends StatefulWidget {
  final String initial;
  final String recipient;
  final String networkName;
  const _AirtimeNicknameDialog({
    required this.initial,
    required this.recipient,
    required this.networkName,
  });

  @override
  State<_AirtimeNicknameDialog> createState() =>
      _AirtimeNicknameDialogState();
}

class _AirtimeNicknameDialogState extends State<_AirtimeNicknameDialog> {
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
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      title: Text(
        'Save this contact',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Give ${widget.recipient.isNotEmpty ? widget.recipient : "this number"} '
            'a nickname so you can find it fast next time.',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 14.h),
          TextField(
            controller: _controller,
            autofocus: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submit(),
            style: TextStyle(color: Colors.white, fontSize: 15.sp),
            decoration: InputDecoration(
              hintText: 'e.g. Mum, Brother, Office',
              hintStyle: TextStyle(
                color: const Color(0xFF4B5563),
                fontSize: 14.sp,
              ),
              errorText: _error,
              filled: true,
              fillColor: const Color(0xFF0A0A0A),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Color(0xFF4E03D0)),
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
          child: Text(
            'Cancel',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
        ),
        TextButton(
          onPressed: _submit,
          child: Text(
            'Save',
            style: TextStyle(
              color: const Color(0xFF4E03D0),
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
