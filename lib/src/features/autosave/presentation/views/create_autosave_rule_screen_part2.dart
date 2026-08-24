part of 'create_autosave_rule_screen.dart';

class _TimePickerTile extends StatelessWidget {
  final TimeOfDay time;
  final VoidCallback onPick;
  const _TimePickerTile({required this.time, required this.onPick});

  @override
  Widget build(BuildContext context) {
    final hh = time.hour.toString().padLeft(2, '0');
    final mm = time.minute.toString().padLeft(2, '0');
    return GestureDetector(
      onTap: onPick,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_surfaceRaised, _surface],
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: const [_shadowMd],
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: _accent.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.access_time_rounded, color: _accent, size: 22.sp),
            ),
            SizedBox(width: 14.w),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: hh,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),
                  TextSpan(
                    text: ':',
                    style: GoogleFonts.inter(
                      color: _accent,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                  TextSpan(
                    text: mm,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.edit_rounded, color: _textMuted, size: 14.sp),
                  SizedBox(width: 6.w),
                  Text(
                    'Change',
                    style: GoogleFonts.inter(
                      color: _textMuted,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoundUpChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool selected;
  final VoidCallback onTap;
  const _RoundUpChip({
    required this.label,
    this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: selected ? _roundUpTint : _surface,
          borderRadius: BorderRadius.circular(22.r),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: _roundUpTint.withValues(alpha: 0.45),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ]
              : const [_shadowSoft],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 14.sp,
                color: selected ? Colors.white : _textMuted,
              ),
              SizedBox(width: 6.w),
            ],
            Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SegmentedToggle extends StatelessWidget {
  final String left;
  final String right;
  final bool isLeft;
  final ValueChanged<bool> onTap;
  const _SegmentedToggle({
    required this.left,
    required this.right,
    required this.isLeft,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: const [_shadowSoft],
      ),
      child: Row(
        children: [
          Expanded(child: _segment(left, isLeft, () => onTap(true))),
          Expanded(child: _segment(right, !isLeft, () => onTap(false))),
        ],
      ),
    );
  }

  Widget _segment(String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: EdgeInsets.symmetric(vertical: 11.h),
        decoration: BoxDecoration(
          color: active ? _accent : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: active
              ? [
                  BoxShadow(
                    color: _accent.withValues(alpha: 0.45),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: active ? Colors.white : _textMuted,
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _AccountDropdown extends StatelessWidget {
  final List<dynamic> accounts;
  final String? valueId;
  final String hint;
  final ValueChanged<String?> onChanged;
  const _AccountDropdown({
    required this.accounts,
    required this.valueId,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: _surfaceRaised,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: const [_shadowSoft],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: valueId,
          isExpanded: true,
          hint: Text(
            hint,
            style: GoogleFonts.inter(color: _textMuted, fontSize: 14.sp),
          ),
          dropdownColor: _surfaceRaised,
          icon: Icon(Icons.keyboard_arrow_down_rounded,
              color: _accent, size: 22.sp),
          items: accounts.map<DropdownMenuItem<String>>((a) {
            final id = a.id.toString();
            final label = '${a.accountType} (****${a.accountNumberLast4})';
            return DropdownMenuItem<String>(
              value: id,
              child: Text(
                label,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _PreviewCard extends StatelessWidget {
  final Color tint;
  final IconData icon;
  final String title;
  final String body;
  const _PreviewCard({
    required this.tint,
    required this.icon,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border(
          left: BorderSide(color: tint, width: 3),
        ),
        boxShadow: const [_shadowSoft],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              color: tint.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: tint, size: 19.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  body,
                  style: GoogleFonts.inter(
                    color: const Color(0xFFD1D5DB),
                    fontSize: 12.5.sp,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyAccountsState extends StatelessWidget {
  final VoidCallback onClose;
  const _EmptyAccountsState({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(28.w),
      margin: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: const [_shadowMd],
      ),
      child: Column(
        children: [
          Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              color: _accent.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.account_balance_wallet_outlined,
                color: _accent, size: 32.sp),
          ),
          SizedBox(height: 16.h),
          Text(
            'No accounts yet',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Auto-save needs at least one source and one destination account. '
            'Open an account from the dashboard, then come back.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: _textMuted,
              fontSize: 13.sp,
              height: 1.4,
            ),
          ),
          SizedBox(height: 18.h),
          _SoftButton(label: 'Back to dashboard', onTap: onClose),
        ],
      ),
    );
  }
}

class _AccountsLoadErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _AccountsLoadErrorState({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(28.w),
      margin: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: _danger.withValues(alpha: 0.3)),
        boxShadow: const [_shadowMd],
      ),
      child: Column(
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: _danger.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.cloud_off_rounded, color: _danger, size: 28.sp),
          ),
          SizedBox(height: 14.h),
          Text(
            'Couldn\'t load your accounts',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: _textMuted, fontSize: 12.sp),
          ),
          SizedBox(height: 16.h),
          _SoftButton(label: 'Try again', onTap: onRetry),
        ],
      ),
    );
  }
}

// Linked external bank row for the Bank Inflow trigger. State-driven:
//   • mandate ready  → selectable card with a ⚡ ready badge
//   • otherwise      → "Set up Direct Debit" action row (opens the same
//     mandate sheet the Beam flow uses)
class _LinkedBankRow extends StatelessWidget {
  final LinkedBankAccount account;
  final MandateEntity? mandate;
  final bool selected;
  final bool ready;
  final VoidCallback onTap;
  const _LinkedBankRow({
    required this.account,
    required this.mandate,
    required this.selected,
    required this.ready,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: selected ? _inflowTint.withValues(alpha: 0.12) : _surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: selected ? _inflowTint : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            if (!selected) _shadowSoft,
            if (selected)
              BoxShadow(
                color: _inflowTint.withValues(alpha: 0.28),
                blurRadius: 16,
                offset: const Offset(0, 7),
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: _inflowTint.withValues(alpha: selected ? 0.26 : 0.14),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.account_balance,
                  color: _inflowTint, size: 22.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.bankName,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${account.accountName}  ${account.accountNumber}',
                    style: GoogleFonts.inter(
                      color: _textMuted,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  MandateStatusBadge(mandate: mandate),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            if (ready)
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? _inflowTint : Colors.transparent,
                  border: Border.all(
                    color: selected ? _inflowTint : _hairline,
                    width: 2,
                  ),
                ),
                child: selected
                    ? Icon(Icons.check_rounded,
                        color: Colors.white, size: 14.sp)
                    : null,
              )
            else
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: _onDepositTint.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  // A granted-but-provisioning mandate is already being set
                  // up — the pill mirrors the badge instead of implying a
                  // fresh setup is needed.
                  linkedAccountStateForMandate(mandate) ==
                          LinkedAccountState.settingUp
                      ? 'Setting up…'
                      : 'Set up Direct Debit',
                  style: GoogleFonts.inter(
                    color: _onDepositTint,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
