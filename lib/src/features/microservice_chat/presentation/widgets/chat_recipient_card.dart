import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/src/features/widgets/user_avatar.dart';

/// The confirmed counterparty of a transfer, rendered as a card.
///
/// WHY THIS EXISTS
/// ---------------
/// A transfer asks the user to be certain about two things before a PIN is
/// entered: how much, and *who*. The amount always rendered properly. The
/// recipient was a sentence — "**Obinna Eze** has been selected as the
/// recipient" — or a `To | Obinna Eze` row in a label/value table.
///
/// That is the single moment where misreading costs real money, and prose is
/// the weakest rendering of it: no face to recognise, no bank to sanity-check,
/// and no visual difference at all between the person you meant and a
/// near-identical name. Every other consequential object in this chat — the
/// receipt, the QR code, the PIN pad — is a card. The recipient was the
/// exception, even though the voice HUD had rendered an avatar for it all
/// along, so the one surface where you can actually LOOK at who you are paying
/// showed the least.
///
/// Built from `metadata.recipient_card` (see `chat_services_shared/
/// recipient_protocol.py`), which the same backend rail carries to the voice
/// overlay — so chat and voice now confirm identity identically.
class ChatRecipientCard extends StatelessWidget {
  const ChatRecipientCard({
    super.key,
    required this.data,
    this.onChangeRecipient,
    this.onSelectCandidate,
  });

  /// Whether this payload is a PICK-ONE list rather than one confirmed
  /// recipient. Set by `attach_recipient_candidates` server-side.
  bool get isCandidateList => data['candidates'] is List;

  /// Invoked with a candidate's 1-based index and username when the user taps
  /// a row in list mode. The caller sends it back through the ordinary text
  /// channel, which the agent's `select_recipient` already resolves by name,
  /// number or position — so a tap and "the second one" travel one path.
  final void Function(int index, String username, String displayName)?
      onSelectCandidate;

  /// The `recipient_card` payload, decoded.
  final Map<String, dynamic> data;

  /// Invoked by "Change" — only rendered when the backend marked this card
  /// `selectable`, i.e. the user genuinely still has a choice. Offering
  /// "Change" on an already-committed recipient would imply an edit the flow
  /// cannot honour.
  final VoidCallback? onChangeRecipient;

  static const Color _purple = Color(0xFF4E03D0);
  static const Color _green = Color(0xFF10B981);

  String get _kind => (data['kind'] ?? 'internal').toString();
  String get _name => (data['display_name'] ?? '').toString().trim();
  String get _username => (data['username'] ?? '').toString().trim();
  String get _avatarUrl => (data['avatar_url'] ?? '').toString().trim();
  String get _bank => (data['bank_name'] ?? '').toString().trim();
  String get _account => (data['masked_account'] ?? '').toString().trim();
  String get _amount => (data['amount'] ?? '').toString().trim();
  String get _currency => (data['currency'] ?? '').toString().trim();
  bool get _verified => data['verified'] == true;
  bool get _selectable => data['selectable'] == true;

  /// First/last split purely for the initials fallback. A single-word name
  /// yields one initial rather than a doubled letter.
  String get _first => _name.isEmpty ? '' : _name.split(RegExp(r'\s+')).first;
  String get _last {
    final parts = _name.split(RegExp(r'\s+'));
    return parts.length > 1 ? parts.last : '';
  }

  /// The line under the name: who they are, in the terms that identify them.
  /// An internal user is their handle; a bank account is its bank and last
  /// four. Empty when we have neither — better blank than a placeholder.
  String get _subtitle {
    if (_kind == 'external') {
      if (_bank.isNotEmpty && _account.isNotEmpty) return '$_bank · $_account';
      if (_bank.isNotEmpty) return _bank;
      return _account;
    }
    if (_username.isNotEmpty) return '@$_username';
    if (_account.isNotEmpty) return _account;
    return '';
  }

  @override
  Widget build(BuildContext context) {
    // A multi-match search ends in the user choosing, and that is a different
    // widget from "here is who you are paying" — see ChatRecipientCandidates.
    if (isCandidateList) {
      return ChatRecipientCandidates(
        data: data,
        onSelect: onSelectCandidate,
      );
    }
    final subtitle = _subtitle;
    return Container(
      margin: EdgeInsets.only(top: 8.h, bottom: 4.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: _purple.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: _purple.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // UserAvatar already owns the "real picture, else initials"
              // decision (and caches to disk), so a recipient with no photo
              // degrades to their initials rather than a broken image box.
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: _purple.withValues(alpha: 0.30),
                      blurRadius: 10,
                      spreadRadius: -2,
                    ),
                  ],
                ),
                child: UserAvatar(
                  size: 46.r,
                  imageUrl: _avatarUrl.isEmpty ? null : _avatarUrl,
                  firstName: _first,
                  lastName: _last,
                  borderColor: _purple.withValues(alpha: 0.55),
                  borderWidth: 1.4,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _name.isEmpty ? 'Recipient' : _name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (subtitle.isNotEmpty) ...[
                      SizedBox(height: 2.h),
                      // Tapping the identity line copies it — the number is the
                      // thing people cross-check against a message or a bank
                      // app, and re-typing it from a chat bubble is how digits
                      // get transposed.
                      GestureDetector(
                        onTap: () => _copy(context, subtitle),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                subtitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                  color: Colors.white.withValues(alpha: 0.72),
                                  fontSize: 12.5.sp,
                                ),
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Icon(Icons.copy_rounded,
                                size: 12.sp,
                                color: Colors.white.withValues(alpha: 0.45)),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (_verified) _verifiedBadge(),
            ],
          ),
          if (_amount.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Container(height: 1, color: Colors.white.withValues(alpha: 0.08)),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sending',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.65),
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  '${_currency.isEmpty ? '' : '$_currency '}$_amount',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
          if (_selectable && onChangeRecipient != null) ...[
            SizedBox(height: 10.h),
            GestureDetector(
              onTap: onChangeRecipient,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 9.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10.r),
                  border:
                      Border.all(color: Colors.white.withValues(alpha: 0.12)),
                ),
                child: Center(
                  child: Text(
                    'Change recipient',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _verifiedBadge() => Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: _green.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: _green.withValues(alpha: 0.45)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.verified_rounded, size: 12.sp, color: _green),
            SizedBox(width: 4.w),
            Text(
              'Verified',
              style: GoogleFonts.inter(
                color: _green,
                fontSize: 10.5.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );

  void _copy(BuildContext context, String value) {
    Clipboard.setData(ClipboardData(text: value));
    HapticFeedback.selectionClick();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied $value'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

/// A PICK-ONE list of possible recipients, rendered as tappable rows.
///
/// WHY THIS EXISTS
/// ---------------
/// A name search that matches several people ends in the user choosing. That
/// choice used to be offered as markdown — the agent wrote "1. @wanne_e —
/// Emmanuella Wanne" into its reply and waited for a typed answer. The
/// structured list was emitted all along (`_visual_feedback` with
/// `user_search_results`) but nothing rendered it: grep for that key across
/// the app returns nothing, and the voice socket has no candidates event. So
/// the one moment where picking the wrong row sends money to a stranger was
/// the moment with no UI at all.
///
/// Each row carries the avatar, the name and the handle, because those are
/// what distinguish two people with the same first name — which is the whole
/// reason a list is being shown.
class ChatRecipientCandidates extends StatelessWidget {
  const ChatRecipientCandidates({super.key, required this.data, this.onSelect});

  final Map<String, dynamic> data;
  final void Function(int index, String username, String displayName)? onSelect;

  static const Color _purple = Color(0xFF4E03D0);

  List<Map<String, dynamic>> get _candidates {
    final raw = data['candidates'];
    if (raw is! List) return const [];
    return raw
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  String get _query => (data['query'] ?? '').toString().trim();

  /// How many matched in total, which can exceed the rows shown.
  int get _total {
    final t = data['total'];
    if (t is int) return t;
    return int.tryParse(t?.toString() ?? '') ?? _candidates.length;
  }

  @override
  Widget build(BuildContext context) {
    final items = _candidates;
    // An empty list must render nothing rather than an empty framed box that
    // looks like a failed load.
    if (items.isEmpty) return const SizedBox.shrink();
    final hidden = _total - items.length;

    return Container(
      margin: EdgeInsets.only(top: 8.h, bottom: 4.h),
      decoration: BoxDecoration(
        color: _purple.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: _purple.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 8.h),
            child: Row(
              children: [
                Icon(Icons.people_alt_rounded,
                    size: 15.sp, color: Colors.white.withValues(alpha: 0.8)),
                SizedBox(width: 7.w),
                Expanded(
                  child: Text(
                    _query.isEmpty
                        ? 'Who did you mean?'
                        : '$_total matched "$_query" — who did you mean?',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          for (final c in items) _row(c),
          if (hidden > 0)
            Padding(
              padding: EdgeInsets.fromLTRB(14.w, 2.h, 14.w, 10.h),
              child: Text(
                // Said plainly rather than silently truncating: someone whose
                // person is not listed needs to know to narrow the search
                // rather than assume they are absent from the platform.
                '$hidden more match. Add a surname or use their @username to '
                'narrow it down.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 10.5.sp,
                ),
              ),
            )
          else
            SizedBox(height: 6.h),
        ],
      ),
    );
  }

  Widget _row(Map<String, dynamic> c) {
    final index = c['index'] is int
        ? c['index'] as int
        : int.tryParse(c['index']?.toString() ?? '') ?? 0;
    final name = (c['display_name'] ?? '').toString().trim();
    final username = (c['username'] ?? '').toString().trim();
    final avatar = (c['avatar_url'] ?? '').toString().trim();
    // Never an empty row: a candidate with neither name nor handle would be
    // untappable and unexplainable, so the handle stands in and vice versa.
    final title = name.isNotEmpty ? name : (username.isEmpty ? 'Recipient' : '@$username');
    final subtitle = name.isNotEmpty && username.isNotEmpty ? '@$username' : '';

    return InkWell(
      onTap: onSelect == null ? null : () => onSelect!(index, username, name),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        child: Row(
          children: [
            _avatar(avatar, title),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.65),
                        fontSize: 11.sp,
                      ),
                    ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded,
                size: 18.sp, color: Colors.white.withValues(alpha: 0.5)),
          ],
        ),
      ),
    );
  }

  Widget _avatar(String url, String title) {
    final initial = title.replaceAll('@', '').trim();
    final letter = initial.isEmpty ? '?' : initial[0].toUpperCase();
    return Container(
      width: 34.w,
      height: 34.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _purple.withValues(alpha: 0.35),
        image: url.isEmpty
            ? null
            : DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
      child: url.isEmpty
          ? Center(
              child: Text(
                letter,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          : null,
    );
  }
}
