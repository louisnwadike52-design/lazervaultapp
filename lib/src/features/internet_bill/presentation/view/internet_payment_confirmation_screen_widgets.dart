part of 'internet_payment_confirmation_screen.dart';

/// Nickname-entry dialog for the save-as-beneficiary flow. Kept as
/// a private StatefulWidget so the TextEditingController is owned by
/// the dialog's element subtree — disposing on the outer State right
/// after `showDialog` returned races with the dialog's close animation
/// (the TextField still reads the controller during fade-out) and
/// raised "dependents.isEmpty is not true" assertions.
class _NicknameDialog extends StatefulWidget {
  const _NicknameDialog();

  @override
  State<_NicknameDialog> createState() => _NicknameDialogState();
}

class _NicknameDialogState extends State<_NicknameDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final value = _controller.text.trim();
    if (value.isEmpty) return;
    Navigator.of(context).pop(value);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1F1F1F),
      title: Text(
        'Name this ISP account',
        style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w700),
      ),
      content: TextField(
        controller: _controller,
        autofocus: true,
        maxLength: 50,
        textCapitalization: TextCapitalization.words,
        style: GoogleFonts.inter(color: Colors.white),
        onSubmitted: (_) => _submit(),
        decoration: InputDecoration(
          hintText: 'e.g. Home Wi-Fi',
          hintStyle: GoogleFonts.inter(color: const Color(0xFF9CA3AF)),
          filled: true,
          fillColor: const Color(0xFF2D2D2D),
          counterStyle: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 11,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel',
              style: GoogleFonts.inter(color: const Color(0xFF9CA3AF))),
        ),
        ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4E03D0)),
          child: Text('Save',
              style: GoogleFonts.inter(
                  color: Colors.white, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
