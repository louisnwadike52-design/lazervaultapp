part of 'transfer_history_bottom_sheet.dart';

class TransferHistoryItem extends StatelessWidget {
  final UnifiedTransaction transaction;
  final InlineSendHandler? onSend;

  const TransferHistoryItem({
    super.key,
    required this.transaction,
    this.onSend,
  });

  /// Build the row's leading avatar from the counterparty's name. Prefers
  /// initials-from-name (1 or 2 letters); falls back to a directional arrow
  /// icon when the transaction has no counterparty name (e.g. a generic
  /// "Credit" record where the sender is unknown).
  ///
  /// Sized to sit proportionally next to the 14sp title + 12sp date row —
  /// 30×30 keeps the avatar visually present without dominating the row.
  /// Destination institution for this row, via the shared resolver so the
  /// history sheet, the dashboard history and the receipt agree.
  TransferBankDisplay? get _bankDisplay => TransferBankDisplay.resolve(
        transaction.metadata,
        isTransfer:
            transaction.serviceType == TransactionServiceType.transfer,
      );

  Widget _buildLeadingAvatar({required bool isIncoming}) {
    // Every transfer leads with its destination institution's mark — an
    // external bank's logo, or the LazerVault logo for money that stayed on
    // the platform. Internal transfers used to fall back to counterparty
    // initials, which made them indistinguishable from a bank transfer whose
    // logo simply had not been bundled.
    final bank = _bankDisplay;
    if (bank != null) {
      return BankLogo(
        bankName: bank.name,
        bankCode: bank.code,
        size: 30,
        borderRadius: 8,
      );
    }

    final name = transaction.counterpartyName?.trim() ?? '';
    final initials = _initialsFrom(name);
    const brand = Color(0xFF4E03D0);
    return Container(
      width: 30.w,
      height: 30.w,
      decoration: BoxDecoration(
        color: brand.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: initials.isNotEmpty
          ? Text(
              initials,
              style: TextStyle(
                color: brand,
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            )
          : Icon(
              isIncoming ? Icons.call_received : Icons.call_made,
              color: brand,
              size: 14.sp,
            ),
    );
  }

  /// First-letter(s) of a person's name. "Jane Doe" → "JD",
  /// "Mononym" → "M", empty/whitespace → "".
  static String _initialsFrom(String name) {
    if (name.isEmpty) return '';
    final parts = name.split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final dateStr =
        DateFormat('dd MMM yyyy, HH:mm').format(transaction.createdAt);
    final isIncoming = transaction.flow == TransactionFlow.incoming;
    final counterpartyName = transaction.counterpartyName?.trim();
    final hasCounterparty =
        counterpartyName != null && counterpartyName.isNotEmpty;
    // Title prefers the actual sender/recipient name; falls back to the
    // generic "Transfer Sent / Received / Credit" label only when the
    // counterparty wasn't resolved (e.g. legacy records).
    final displayTitle = hasCounterparty ? counterpartyName : transaction.title;
    final directionColor =
        isIncoming ? const Color(0xFF10B981) : Colors.grey[600];

    return InkWell(
      onTap: () => _showActionSheet(context),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            // Recipient/sender avatar (initials, brand-coloured fallback).
            _buildLeadingAvatar(isIncoming: isIncoming),
            SizedBox(width: 12.w),

            // Title + date + status
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          displayTitle,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      // Compact directional arrow — replaces the large
                      // leading-circle arrow that the avatar now occupies.
                      Icon(
                        isIncoming ? Icons.call_received : Icons.call_made,
                        size: 12.sp,
                        color: directionColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Text(
                        dateStr,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      if (_bankDisplay != null) ...[
                        SizedBox(width: 6.w),
                        Flexible(
                          child: Text(
                            // "LV" for LazerVault: the full name would crowd
                            // out the date and status on a narrow row.
                            _bankDisplay!.shortLabel,
                            key: const Key('history_row_institution'),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: transaction.status.color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          transaction.status.displayName,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: transaction.status.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Amount
            Text(
              transaction.formattedAmount,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isIncoming
                    ? const Color(0xFF10B981)
                    : Colors.black87,
              ),
            ),

            // Tap the whole row to open the Repeat / Receipt action sheet
            // (parity with the saved-recipients transaction history).
            SizedBox(width: 6.w),
            Icon(Icons.chevron_right, color: Colors.grey[400], size: 20.sp),
          ],
        ),
      ),
    );
  }

  /// Tap a history row → action sheet offering Repeat (outgoing only) and
  /// Receipt, mirroring the saved-recipients transaction history sheet.
  void _showActionSheet(BuildContext context) {
    final isIncoming = transaction.flow == TransactionFlow.incoming;
    final canRepeat = transaction.flow == TransactionFlow.outgoing &&
        transaction.counterpartyName != null;
    final dateStr = DateFormat('EEEE, dd MMM yyyy \'at\' HH:mm')
        .format(transaction.createdAt);
    final counterpartyName = transaction.counterpartyName?.trim();
    final title = (counterpartyName != null && counterpartyName.isNotEmpty)
        ? counterpartyName
        : transaction.title;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 16.h),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Container(
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isIncoming ? Icons.call_received : Icons.call_made,
                color: const Color(0xFF4E03D0),
                size: 24.sp,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              transaction.formattedAmount,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: isIncoming ? const Color(0xFF10B981) : Colors.black87,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              dateStr,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
            ),
            SizedBox(height: 4.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: transaction.status.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                transaction.status.displayName,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: transaction.status.color,
                ),
              ),
            ),
            if (transaction.transactionReference != null) ...[
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ref: ',
                    style: TextStyle(fontSize: 11.sp, color: Colors.grey[500]),
                  ),
                  Flexible(
                    child: Text(
                      transaction.transactionReference!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            SizedBox(height: 20.h),
            Row(
              children: [
                if (canRepeat) ...[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(ctx); // close action sheet
                        Get.back(); // close the history sheet
                        final amountMinor =
                            (transaction.amount * 100).toInt();
                        // Carry the payee's Lazervault user id (stamped into
                        // the transaction metadata by accounts-service) so a
                        // save dedups by internal_user_id — the stable identity
                        // — instead of relying on account-number resolution.
                        final counterpartyUid = (transaction
                                    .metadata?['counterparty_user_id'] ??
                                transaction.metadata?['recipient_user_id'])
                            ?.toString();
                        final recipient = RecipientModel(
                          id: '',
                          name: transaction.counterpartyName!,
                          accountNumber: transaction.counterpartyAccount ?? '',
                          bankName: 'LazerVault',
                          isFavorite: false,
                          sortCode: '',
                          type: 'internal',
                          internalUserId: (counterpartyUid != null &&
                                  counterpartyUid.isNotEmpty)
                              ? counterpartyUid
                              : null,
                        );
                        final cb = onSend;
                        if (cb != null) {
                          // Host (Select Recipient) owns the send flow → open the
                          // amount sheet OVER the existing screens instead of
                          // pushing a fresh (blank) send screen.
                          cb(recipient,
                              amountMinor: amountMinor,
                              currency: transaction.currency);
                        } else {
                          // Route via the launcher so Repeat honors the user's
                          // transfer style (short vs long) instead of always
                          // opening the long form.
                          SendFundsLauncher.open(
                            recipient: recipient,
                            autoContinue: true,
                            prefillAmountMinor: amountMinor,
                            prefillCurrency: transaction.currency,
                          );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4E03D0),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.replay,
                                color: Colors.white, size: 18.sp),
                            SizedBox(width: 8.w),
                            Text(
                              'Repeat',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                ],
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(ctx); // close action sheet
                      // Leave the history sheet open underneath so the user
                      // returns to it after viewing the receipt.
                      TransactionReceiptRouter.navigateToReceipt(transaction);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.receipt_outlined,
                              color: Colors.black87, size: 18.sp),
                          SizedBox(width: 8.w),
                          Text(
                            'Receipt',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 8.h),
          ],
        ),
      ),
    );
  }
}
