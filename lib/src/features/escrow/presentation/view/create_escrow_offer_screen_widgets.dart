part of 'create_escrow_offer_screen.dart';

// UI building blocks for CreateEscrowOfferScreen — same visual idioms as the
// deal-create carousel (_label/_field/picker tiles/deadline chips/progress).

extension _CreateEscrowOfferWidgets on _CreateEscrowOfferScreenState {
  Widget _progress() => Padding(
        padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Step ${_currentPage + 1} of ${_CreateEscrowOfferScreenState._totalPages} · ${_pageNames[_currentPage]}',
                style: GoogleFonts.inter(
                    color: EscrowTheme.textSecondary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600)),
            SizedBox(height: 8.h),
            Row(children: [
              for (var i = 0; i < _CreateEscrowOfferScreenState._totalPages; i++) ...[
                if (i > 0) SizedBox(width: 6.w),
                Expanded(
                  child: Container(
                    height: 5.h,
                    decoration: BoxDecoration(
                      color: i <= _currentPage
                          ? EscrowTheme.primary
                          : EscrowTheme.border,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                ),
              ],
            ]),
          ],
        ),
      );

  Widget _label(String t) => Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: Text(t,
            style: GoogleFonts.inter(
                color: EscrowTheme.textSecondary,
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w600)),
      );

  Widget _field(TextEditingController ctrl, String hint,
          {int maxLines = 1, TextInputType? keyboard}) =>
      TextField(
        controller: ctrl,
        maxLines: maxLines,
        keyboardType: keyboard,
        onChanged: (_) => _refresh(),
        style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.inter(
              color: EscrowTheme.textSecondary, fontSize: 13.sp),
          filled: true,
          fillColor: EscrowTheme.card,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: EscrowTheme.border)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: EscrowTheme.primary)),
        ),
      );

  // ── Page 1: what's being sold / requested ──
  Widget _page1Details() => SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label(_isSell ? 'What are you selling?' : 'What do you want to buy?'),
            _field(_titleCtrl,
                _isSell ? 'e.g. iPhone 13 Pro, 256GB' : 'e.g. PS5 console'),
            SizedBox(height: 14.h),
            _label('Specs / details (optional)'),
            _field(_descCtrl,
                _isSell
                    ? 'Condition, specs, what\'s included…'
                    : 'Exactly what you expect: condition, specs, colour…',
                maxLines: 3),
            SizedBox(height: 14.h),
            _label(_isSell ? 'Condition' : 'Condition you\'ll accept'),
            _conditionPicker(),
            SizedBox(height: 14.h),
            _label(_isSell
                ? 'Photos or a short video of the item'
                : 'Photos of what you want (optional)'),
            EscrowAttachmentPicker(
              onChanged: (m) => _media = m,
              onError: (msg) => showAppSnackbar('Escrow Pay', msg,
                  type: AppSnackbarType.error),
            ),
            SizedBox(height: 14.h),
            _label(_isSell ? 'Offer to (optional)' : 'Seller'),
            _counterpartyTile(),
            if (_isSell) ...[
              SizedBox(height: 8.h),
              Text(
                  'Leave this empty to share your listing by link — anyone on Lazervault who opens it can buy securely.',
                  style: GoogleFonts.inter(
                      color: EscrowTheme.textSecondary, fontSize: 11.sp)),
            ],
          ],
        ),
      );

  /// Back-Market-style grade tiles. Sell: exactly one grade required. Buy
  /// request: tap the selected grade again to clear it back to "any".
  Widget _conditionPicker() {
    return Column(
      children: [
        for (final (value, label, hint) in EscrowTheme.conditionGrades)
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: InkWell(
              onTap: () => _refresh(() {
                _condition = (!_isSell && _condition == value) ? '' : value;
              }),
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: EscrowTheme.card,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                      color: _condition == value
                          ? EscrowTheme.primary
                          : EscrowTheme.border),
                ),
                child: Row(
                  children: [
                    Icon(
                        _condition == value
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        color: _condition == value
                            ? EscrowTheme.primary
                            : EscrowTheme.textSecondary,
                        size: 18.sp),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(label,
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 13.5.sp,
                                  fontWeight: FontWeight.w600)),
                          Text(hint,
                              style: GoogleFonts.inter(
                                  color: EscrowTheme.textSecondary,
                                  fontSize: 11.sp)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        if (!_isSell)
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
                _condition.isEmpty
                    ? 'Any condition is fine — tap a grade to require one.'
                    : 'Tap the selected grade again to accept any condition.',
                style: GoogleFonts.inter(
                    color: EscrowTheme.textSecondary, fontSize: 11.sp)),
          ),
      ],
    );
  }

  Widget _counterpartyTile() {
    final cp = _counterparty;
    return InkWell(
      onTap: _pickCounterparty,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: EscrowTheme.card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
              color: cp == null ? EscrowTheme.border : EscrowTheme.primary),
        ),
        child: Row(
          children: [
            Icon(cp == null ? Icons.person_search_outlined : Icons.verified_user,
                color: EscrowTheme.primary, size: 20.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: cp == null
                  ? Text(
                      _isSell
                          ? 'Pick a buyer (or share by link)'
                          : 'Search by @username, phone or email',
                      style: GoogleFonts.inter(
                          color: EscrowTheme.textSecondary, fontSize: 13.5.sp))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cp.displayName,
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600)),
                        if (cp.username.isNotEmpty)
                          Text('@${cp.username}',
                              style: GoogleFonts.inter(
                                  color: EscrowTheme.textSecondary,
                                  fontSize: 12.sp)),
                      ],
                    ),
            ),
            Icon(cp == null ? Icons.chevron_right : Icons.edit_outlined,
                color: EscrowTheme.textSecondary, size: 18.sp),
          ],
        ),
      ),
    );
  }

  // ── Page 2: price + delivery terms ──
  Widget _page2Terms() => SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label('Price (NGN)'),
            _field(_amountCtrl, '0.00',
                keyboard:
                    const TextInputType.numberWithOptions(decimal: true)),
            SizedBox(height: 6.h),
            Text(
                'The escrow fee is calculated when the buyer pays — they\'ll see the exact total before confirming.',
                style: GoogleFonts.inter(
                    color: EscrowTheme.textSecondary, fontSize: 11.sp)),
            SizedBox(height: 16.h),
            _label('Delivery window (optional)'),
            _deliveryPicker(),
            SizedBox(height: 8.h),
            Text(
                'The clock starts when the buyer pays — if delivery doesn\'t happen in time, their money is automatically refunded.',
                style: GoogleFonts.inter(
                    color: EscrowTheme.textSecondary, fontSize: 11.sp)),
          ],
        ),
      );

  Widget _deliveryPicker() {
    const options = [0, 3, 7, 14, 30];
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: [
        for (final d in options)
          InkWell(
            onTap: () => _refresh(() => _deliveryDays = d),
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 9.h),
              decoration: BoxDecoration(
                color: _deliveryDays == d
                    ? EscrowTheme.primary.withValues(alpha: 0.18)
                    : EscrowTheme.card,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                    color: _deliveryDays == d
                        ? EscrowTheme.primary
                        : EscrowTheme.border),
              ),
              child: Text(d == 0 ? 'None' : '$d days',
                  style: GoogleFonts.inter(
                      color: _deliveryDays == d
                          ? EscrowTheme.primary
                          : Colors.white,
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w600)),
            ),
          ),
      ],
    );
  }

  // ── Page 3: review + publish ──
  Widget _page3Review() {
    final amountStr = 'NGN ${NumberFormat('#,##0.00').format(_amount)}';
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0x1A4E03D0), EscrowTheme.card],
              ),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: EscrowTheme.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_titleCtrl.text.trim(),
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700)),
                if (_descCtrl.text.trim().isNotEmpty) ...[
                  SizedBox(height: 6.h),
                  Text(_descCtrl.text.trim(),
                      style: GoogleFonts.inter(
                          color: EscrowTheme.textSecondary,
                          fontSize: 12.5.sp,
                          height: 1.5)),
                ],
                SizedBox(height: 10.h),
                Text(amountStr,
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          SizedBox(height: 14.h),
          _reviewRow(
              _isSell ? 'Offered to' : 'Seller',
              _counterparty?.displayName ??
                  (_isSell ? 'Anyone with the link' : '—')),
          _reviewRow(
              'Condition',
              _condition.isEmpty
                  ? (_isSell ? '—' : 'Any condition')
                  : EscrowTheme.conditionLabel(_condition)),
          _reviewRow('Delivery window',
              _deliveryDays == 0 ? 'None' : '$_deliveryDays days'),
          _reviewRow('Photos & video',
              _media.isEmpty ? 'None' : '${_media.length} attached'),
          SizedBox(height: 14.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.verified_user_outlined,
                  color: EscrowTheme.textSecondary, size: 14.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  _isSell
                      ? 'No money moves now. The buyer pays into escrow when they confirm; Lazervault releases it to you after they confirm delivery.'
                      : 'You pay into escrow now and we hold it. The seller delivers to get paid; if they decline or don\'t deliver, you\'re refunded.',
                  style: GoogleFonts.inter(
                      color: EscrowTheme.textSecondary,
                      fontSize: 11.sp,
                      height: 1.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _reviewRow(String l, String v) => Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120.w,
              child: Text(l,
                  style: GoogleFonts.inter(
                      color: EscrowTheme.textSecondary, fontSize: 12.5.sp)),
            ),
            Expanded(
              child: Text(v,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      );

  Widget _navButtons() {
    final isLast = _currentPage == _CreateEscrowOfferScreenState._totalPages - 1;
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: _submitting ? null : _back,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: EscrowTheme.border),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
              child: Text(_currentPage == 0 ? 'Cancel' : 'Back',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600)),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _submitting ? null : (isLast ? _publish : _next),
              style: ElevatedButton.styleFrom(
                backgroundColor: EscrowTheme.primary,
                padding: EdgeInsets.symmetric(vertical: 15.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
              child: _submitting
                  ? SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2))
                  : Text(
                      isLast
                          ? (_isSell ? 'Publish offer' : 'Fund & send request')
                          : 'Continue',
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}
