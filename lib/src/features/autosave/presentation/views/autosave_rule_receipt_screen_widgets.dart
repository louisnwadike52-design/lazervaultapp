part of 'autosave_rule_receipt_screen.dart';

// Presentation for the rule receipt. Split out per the file-size rule; these
// are the same widgets the send-funds receipt uses, in the same order, so the
// two read as one product.

const _accent = Color(0xFFA78BFA);
const _cardColor = Color(0xFF1F1F1F);
const _borderColor = Color(0xFF2D2D2D);
const _muted = Color(0xFF8E8E93);

extension _AutoSaveReceiptWidgets on _AutoSaveRuleReceiptScreenState {
  Widget _backBar() => Padding(
        padding: EdgeInsets.fromLTRB(12.w, 4.h, 12.w, 0),
        child: Row(
          children: [
            IconButton(
              onPressed: _toDashboard,
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white, size: 18.sp),
              splashRadius: 22.r,
            ),
            const Spacer(),
            const ReceiptBrandMark(),
            SizedBox(width: 8.w),
          ],
        ),
      );

  /// Status badge → what the rule saves → name → created stamp.
  Widget _hero(AutoSaveRuleEntity rule) {
    const badge = Color(0xFF10B981);
    return Column(
      children: [
        Container(
          width: 78.w,
          height: 78.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: badge.withValues(alpha: 0.10),
            shape: BoxShape.circle,
          ),
          child: Container(
            width: 62.w,
            height: 62.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: badge.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: Container(
              width: 46.w,
              height: 46.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.lerp(badge, Colors.white, 0.22) ?? badge,
                    badge,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: badge.withValues(alpha: 0.40),
                    blurRadius: 18,
                    offset: Offset(0, 6.h),
                  ),
                ],
              ),
              child: Icon(Icons.savings_rounded,
                  color: Colors.white, size: 24.sp),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        // The figure that matters: what each trigger will actually save.
        Text(rule.amountDescription,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 28.sp,
                fontWeight: FontWeight.w700)),
        SizedBox(height: 6.h),
        Text('Auto-Save rule created',
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500)),
        SizedBox(height: 6.h),
        Text(rule.name,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                color: _accent, fontSize: 13.sp, fontWeight: FontWeight.w600)),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(rule.status.name.toUpperCase(),
                style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: _muted)),
            SizedBox(width: 8.w),
            Text('·',
                style: GoogleFonts.inter(fontSize: 14.sp, color: _muted)),
            SizedBox(width: 8.w),
            Text(
                DateFormat('dd MMM yyyy, h:mm a').format(rule.createdAt),
                style: GoogleFonts.inter(fontSize: 12.sp, color: _muted)),
          ],
        ),
      ],
    );
  }

  Widget _detailsCard(AutoSaveRuleEntity rule) {
    final rows = <Widget>[
      _sectionLabel('Rule'),
      _row('Trigger', AutoSaveTriggerLabels.nameOf(rule.triggerType)),
      _row('How it fires', rule.triggerDescription),
      _row('Saves', rule.amountDescription),
      if (rule.description.trim().isNotEmpty)
        _row('Note', rule.description.trim()),
      SizedBox(height: 6.h),
      _sectionLabel('Accounts'),
      _row('From', _sourceLabel),
      _row('To', _destinationLabel),
      if (rule.sourceBankName.trim().isNotEmpty)
        _row('Linked bank', rule.sourceBankName.trim()),
    ];

    final hasLimits = rule.targetAmount != null ||
        rule.minimumBalance != null ||
        rule.maximumPerSave != null;
    if (hasLimits) {
      rows.addAll([
        SizedBox(height: 6.h),
        _sectionLabel('Goals & limits'),
        if (rule.targetAmount != null)
          _row('Target', _money(rule.targetAmount!)),
        if (rule.minimumBalance != null)
          _row('Keep in source', _money(rule.minimumBalance!)),
        if (rule.maximumPerSave != null)
          _row('Max per save', _money(rule.maximumPerSave!)),
      ]);
    }

    rows.addAll([
      SizedBox(height: 6.h),
      _sectionLabel('Reference'),
      _row('Rule ID', rule.id),
      _row('Currency', rule.currency),
    ]);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 14.h),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: _borderColor),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows),
    );
  }

  Widget _sectionLabel(String label) => Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: Text(label.toUpperCase(),
            style: GoogleFonts.inter(
                color: _muted,
                fontSize: 10.5.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8)),
      );

  Widget _row(String label, String value) => Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: GoogleFonts.inter(
                    color: _muted,
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w500)),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(value,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      );

  /// Where to go next. Kept in the scroll area so the Download/Share bar below
  /// stays in the fixed position it occupies on every other receipt.
  Widget _ctaCard() => Row(
        children: [
          Expanded(
            child: _button(
              label: 'View all rules',
              icon: Icons.list_alt_rounded,
              onTap: _toRules,
              primary: true,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _button(
              label: 'Create another',
              icon: Icons.add_circle_outline,
              onTap: _createAnother,
            ),
          ),
        ],
      );

  Widget _actions() => Padding(
        padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 12.h),
        child: Row(
          children: [
            Expanded(
              child: _button(
                label: 'Download',
                icon: _isDownloading ? null : Icons.download_outlined,
                isLoading: _isDownloading,
                onTap: _isDownloading ? () {} : _download,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _button(
                label: 'Share',
                icon: _isSharing ? null : Icons.share_outlined,
                isLoading: _isSharing,
                onTap: _isSharing ? () {} : _share,
              ),
            ),
          ],
        ),
      );

  Widget _button({
    required String label,
    required VoidCallback onTap,
    IconData? icon,
    bool isLoading = false,
    bool primary = false,
  }) =>
      Material(
        color: primary ? _accent.withValues(alpha: 0.16) : _cardColor,
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                  color: primary
                      ? _accent.withValues(alpha: 0.45)
                      : _borderColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading)
                  LazerVaultLoader.tiny()
                else if (icon != null)
                  Icon(icon,
                      color: primary ? _accent : Colors.white, size: 18.sp),
                if (!isLoading && icon != null) SizedBox(width: 6.w),
                Flexible(
                  child: Text(label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w600,
                          color: primary ? _accent : Colors.white)),
                ),
              ],
            ),
          ),
        ),
      );
}
