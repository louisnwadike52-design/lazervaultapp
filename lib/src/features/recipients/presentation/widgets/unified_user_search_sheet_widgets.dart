part of 'unified_user_search_sheet.dart';

/// Pairs a device contact with its optional resolved Lazervault user.
class _ContactRow {
  final DeviceContact contact;
  final LazerVaultUserMatchModel? match;
  const _ContactRow(this.contact, this.match);

  bool get isLazervaultUser => match != null;
}

/// Secondary line for one result row.
///
/// RULE: a row must never say only a name. Two different people share a name,
/// and a Lazervault user can hold several accounts — so "Praiz Onah" alone
/// does not tell the payer which account is about to receive their money. The
/// masked account number is appended whenever there is a real one.
///
/// It is masked rather than printed in full for the same reason the directory
/// masks email and phone: this sheet will show you anyone on the platform, and
/// a full account number is a harvestable detail. The last four are enough to
/// recognise a number you were given.
///
/// [maskedAccountNumber] also refuses to mask anything that is not digits,
/// which matters here: an internal recipient created from a chat or a username
/// carries the user-id UUID in its account-number field, and masking that
/// would print `•••• 4f2a` as if it were an account.
String _userSearchSubtitle(UnifiedSearchResult r) {
  final bits = <String>[];
  // A saved ALIAS hit shows the headline the user chose ("Mum"), so the real
  // name has to appear here or they cannot confirm who Mum is.
  if (r.isSavedHit &&
      r.alias.isNotEmpty &&
      r.name.isNotEmpty &&
      r.name.toLowerCase() != r.displayName.toLowerCase()) {
    bits.add(r.name);
  }
  if (r.username.isNotEmpty) {
    bits.add('@${r.username}');
  } else if (r.phoneNumber.isNotEmpty) {
    bits.add(r.phoneNumber);
  } else if (r.email.isNotEmpty) {
    bits.add(r.email);
  }

  final masked = maskedAccountNumber(r.accountNumber);
  if (masked.isNotEmpty) {
    // Through BrandBank so a stored row spelled `LazerVault` — the sentinel
    // the internal/external routing compares against, which must NOT be
    // renamed — still READS as "Lazervault". See CLAUDE.md §0.
    final bank = r.bankName.isNotEmpty ? BrandBank.display(r.bankName) : 'Bank';
    bits.add('$bank  •  $masked');
  }

  if (bits.isEmpty) {
    bits.add(r.isLazervault ? 'Lazervault user' : 'Recipient');
  }
  return bits.join('  •  ');
}

/// Why this row matched, for a query that is nothing but digits.
///
/// The same digits are a valid phone number AND a valid account number, and
/// both are searched. Unlabelled, the payer sees two plausible rows for one
/// query with no way to tell "the person whose phone ends 7890" from "the
/// account 7890 belongs to" — and picking the wrong one sends real money to
/// the wrong person. Returns null for a non-numeric query, where there is no
/// ambiguity to resolve.
Widget? _matchBadge(UnifiedSearchResult r, String query) {
  final numericQuery = query.trim().isNotEmpty &&
      RegExp(r'^[0-9]+$').hasMatch(query.replaceAll(RegExp(r'[\s\-]'), ''));
  if (r.accountNumberMatched) {
    return _badgePill(
      label: 'Account no.',
      icon: Icons.account_balance_wallet_outlined,
      color: const Color(0xFF4E03D0),
    );
  }
  if (numericQuery && r.phoneNumber.isNotEmpty) {
    return _badgePill(
      label: 'Phone',
      icon: Icons.phone_outlined,
      color: const Color(0xFF6B7280),
    );
  }
  return null;
}

Widget _badgePill({
  required String label,
  required IconData icon,
  required Color color,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(6.r),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 11.w, color: color),
        SizedBox(width: 3.w),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    ),
  );
}

/// The trailing slot of a result/contact row: the row's own [idle] widget, or
/// a small spinner while that row's pre-navigation work is in flight. Same
/// box either way, so the row does not shift when the spinner swaps in.
Widget _rowTrailing({required bool busy, required Widget idle}) {
  if (!busy) return idle;
  return SizedBox(
    key: const ValueKey('user-search-row-busy'),
    width: 20.w,
    height: 20.w,
    child: const Center(child: LazerVaultLoader.small()),
  );
}
