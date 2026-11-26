import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ticketing_theme.dart';

/// The social platforms a host may publish, and how each one is labelled.
///
/// THE KEYS MATCH THE SERVER'S ALLOW-LIST EXACTLY (ticket_organiser.go
/// `ticketSocialPlatforms`). A key the server does not recognise is refused at
/// create time, so inventing one here would be a form field that can only ever
/// produce an error.
///
/// ONE TABLE, used by both the create form and the edit form. Two copies drift
/// — and a platform present in one screen and missing from the other reads as
/// the handle having been deleted when the organiser edits.
const List<({String key, String label, String hint})> organiserSocialPlatforms =
    [
  (key: 'instagram', label: 'Instagram', hint: 'yourhandle'),
  (key: 'x', label: 'X', hint: 'yourhandle'),
  (key: 'tiktok', label: 'TikTok', hint: 'yourhandle'),
  (key: 'facebook', label: 'Facebook', hint: 'yourpage'),
  (key: 'youtube', label: 'YouTube', hint: 'yourchannel'),
  (key: 'whatsapp', label: 'WhatsApp', hint: '+234...'),
  (key: 'website', label: 'Website', hint: 'https://...'),
];

/// Builds one controller per platform, optionally seeded from stored handles.
Map<String, TextEditingController> buildOrganiserSocialControllers([
  Map<String, String>? seed,
]) =>
    {
      for (final p in organiserSocialPlatforms)
        p.key: TextEditingController(text: seed?[p.key] ?? ''),
    };

/// The handles a host publishes, behind a disclosure.
///
/// COLLAPSED BY DEFAULT because seven optional text fields between the venue
/// and the price make the form look like work for the great majority of
/// organisers who fill none of them. The count on the header is what keeps a
/// filled-in set visible without expanding it.
///
/// The parent owns the controllers: it needs the values at save time, and a
/// widget that owned them would have to hand them back through a callback on
/// every keystroke.
class OrganiserSocialsField extends StatelessWidget {
  const OrganiserSocialsField({
    super.key,
    required this.controllers,
    required this.open,
    required this.onToggle,
    required this.onChanged,
    this.enabled = true,
  });

  final Map<String, TextEditingController> controllers;
  final bool open;
  final VoidCallback onToggle;

  /// Called on every keystroke so the parent can rebuild the filled-in count
  /// on the collapsed header — without it, collapsing after typing loses the
  /// only signal that anything is in there.
  final VoidCallback onChanged;

  final bool enabled;

  int get _filled =>
      controllers.values.where((c) => c.text.trim().isNotEmpty).length;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(10.r),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              child: Row(
                children: [
                  Icon(
                      open
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_right,
                      size: 18.w,
                      color: TicketingTheme.textSecondary),
                  SizedBox(width: 4.w),
                  Text('Social handles (optional)',
                      style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: TicketingTheme.textSecondary)),
                  if (_filled > 0) ...[
                    SizedBox(width: 8.w),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: TicketingTheme.ticket.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text('$_filled',
                          style: GoogleFonts.inter(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                              color: TicketingTheme.ticket)),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (open) ...[
            SizedBox(height: 4.h),
            for (final p in organiserSocialPlatforms)
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Row(
                  children: [
                    SizedBox(
                      width: 78.w,
                      child: Text(p.label,
                          style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: TicketingTheme.textSecondary)),
                    ),
                    Expanded(
                      child: TextField(
                        controller: controllers[p.key],
                        enabled: enabled,
                        onChanged: (_) => onChanged(),
                        style: GoogleFonts.inter(
                            color: enabled
                                ? Colors.white
                                : TicketingTheme.textMuted,
                            fontSize: 13.sp),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 12.h),
                          hintText: p.hint,
                          hintStyle: GoogleFonts.inter(
                              color: TicketingTheme.textMuted,
                              fontSize: 12.5.sp),
                          filled: true,
                          fillColor: TicketingTheme.card,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}
