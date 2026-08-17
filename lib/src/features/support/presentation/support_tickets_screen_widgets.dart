part of 'support_tickets_screen.dart';

/// Payload returned by [_NewTicketSheet] once the user confirms creation.
class _NewTicketResult {
  final String subject;
  final String message;
  const _NewTicketResult(this.subject, this.message);
}

/// Bottom sheet for creating a new ticket. Reminds the user of any existing open
/// tickets (so they don't pile up duplicates) and makes clear a NEW ticket ID is
/// being assigned. Owns + disposes its own controllers to avoid the dispose-timing
/// crash seen when disposing in `whenComplete`.
class _NewTicketSheet extends StatefulWidget {
  final List<SupportTicket> openTickets;
  const _NewTicketSheet({required this.openTickets});

  @override
  State<_NewTicketSheet> createState() => _NewTicketSheetState();
}

class _NewTicketSheetState extends State<_NewTicketSheet> {
  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _primary = Color(0xFF4E03D0);
  static const _textSecondary = Color(0xFF9CA3AF);

  // Character limits — kept in sync with support-service (maxUserText=5000,
  // maxSubjectLen=160). The field enforces them and shows a live counter.
  static const _maxMessage = 5000;
  static const _maxSubject = 160;

  final _subject = TextEditingController();
  final _message = TextEditingController();
  bool _showError = false;

  @override
  void dispose() {
    _subject.dispose();
    _message.dispose();
    super.dispose();
  }

  void _submit() {
    final subject = _subject.text.trim();
    final message = _message.text.trim();
    if (subject.isEmpty || message.isEmpty) {
      setState(() => _showError = true);
      return;
    }
    Navigator.of(context).pop(_NewTicketResult(subject, message));
  }

  @override
  Widget build(BuildContext context) {
    final open = widget.openTickets;
    return Padding(
      // Lift the sheet above the keyboard.
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: _bg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: _textSecondary.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text('Create a new ticket',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700)),
              SizedBox(height: 6.h),
              Text(
                'A new ticket ID will be assigned. Keep separate issues in separate '
                'tickets so our team can track each one.',
                style: TextStyle(color: _textSecondary, fontSize: 12.sp),
              ),
              if (open.isNotEmpty) ...[
                SizedBox(height: 14.h),
                _existingTicketsReminder(open),
              ],
              SizedBox(height: 18.h),
              _label('Subject'),
              SizedBox(height: 6.h),
              _field(_subject, 'Short summary of your issue',
                  minLines: 1, maxLines: 1, maxLength: _maxSubject),
              SizedBox(height: 14.h),
              _label('Message'),
              SizedBox(height: 6.h),
              // Roomy, growing field for a full description (expands to ~12 lines
              // then scrolls); capped + counted against the standard limit.
              _field(_message, 'Describe what you need help with in detail',
                  minLines: 6, maxLines: 12, maxLength: _maxMessage),
              if (_showError) ...[
                SizedBox(height: 10.h),
                Text('Please add a subject and a message.',
                    style: TextStyle(
                        color: const Color(0xFFEF4444), fontSize: 12.sp)),
              ],
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        side: BorderSide(
                            color: _textSecondary.withValues(alpha: 0.4)),
                      ),
                      child: Text('Cancel',
                          style: TextStyle(
                              color: Colors.white, fontSize: 14.sp)),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primary,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                      child: Text('Continue',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _existingTicketsReminder(List<SupportTicket> open) {
    // Show up to a few of the user's open tickets so they can decide whether they
    // really need a new one, or should reply to an existing thread instead.
    final preview = open.take(3).toList();
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFB923C).withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
            color: const Color(0xFFFB923C).withValues(alpha: 0.30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline,
                  size: 15.sp, color: const Color(0xFFFB923C)),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  open.length == 1
                      ? 'You already have 1 open ticket:'
                      : 'You already have ${open.length} open tickets:',
                  style: TextStyle(
                      color: const Color(0xFFFB923C),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          ...preview.map((t) => Padding(
                padding: EdgeInsets.only(top: 3.h, left: 23.w),
                child: Text(
                  '• ${t.ticketNumber}${t.subject.isNotEmpty ? ' — ${t.subject}' : ''}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: _textSecondary, fontSize: 11.sp),
                ),
              )),
          if (open.length > preview.length)
            Padding(
              padding: EdgeInsets.only(top: 3.h, left: 23.w),
              child: Text('and ${open.length - preview.length} more…',
                  style: TextStyle(color: _textSecondary, fontSize: 11.sp)),
            ),
        ],
      ),
    );
  }

  Widget _label(String text) => Text(text,
      style: TextStyle(
          color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600));

  Widget _field(TextEditingController c, String hint,
      {required int minLines, required int maxLines, required int maxLength}) {
    return TextField(
      controller: c,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      // Rebuild the counter as the user types.
      onChanged: (_) => setState(() {}),
      style: TextStyle(color: Colors.white, fontSize: 14.sp),
      // Dark-theme styled live counter (turns red at the limit).
      buildCounter: (context,
          {required int currentLength, required bool isFocused, int? maxLength}) {
        final max = maxLength ?? 0;
        return Padding(
          padding: EdgeInsets.only(top: 4.h, right: 2.w),
          child: Text(
            '$currentLength/$max',
            style: TextStyle(
              color: currentLength >= max
                  ? const Color(0xFFEF4444)
                  : _textSecondary,
              fontSize: 11.sp,
            ),
          ),
        );
      },
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: _textSecondary, fontSize: 13.sp),
        filled: true,
        fillColor: _card,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
