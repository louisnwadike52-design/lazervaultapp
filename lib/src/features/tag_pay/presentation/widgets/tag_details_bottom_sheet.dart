import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/user_tag_entity.dart';
import '../../domain/entities/user_search_result_entity.dart';
import '../../services/tag_pay_pdf_service.dart';
import '../../../../../core/types/app_routes.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'tag_lifecycle_actions.dart';

class TagDetailsBottomSheet extends StatefulWidget {
  final UserTagEntity tag;
  final bool isOutgoing; // true for sent tags, false for received tags

  const TagDetailsBottomSheet({
    super.key,
    required this.tag,
    required this.isOutgoing,
  });

  @override
  State<TagDetailsBottomSheet> createState() => _TagDetailsBottomSheetState();
}

class _TagDetailsBottomSheetState extends State<TagDetailsBottomSheet> {
  bool _isDownloadingInvoice = false;
  bool _isDownloadingReceipt = false;

  /// Leave the sheet, telling the list behind it that this tag changed.
  void _closeAfterLifecycleChange() => Navigator.pop(context, true);

  void _goToPayment() {
    Navigator.pop(context);
    Get.toNamed(AppRoutes.tagPaymentConfirmation, arguments: widget.tag);
  }

  /// Repeat/recreate this tag with the same recipient and amount
  void _repeatTag() {
    // Parse the name into first/last name
    final nameParts = widget.tag.taggedUserName.split(' ');
    final firstName =
        nameParts.isNotEmpty ? nameParts.first : widget.tag.taggedUserTagPay;
    final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    // Create a UserSearchResultEntity from the tag's target user info
    final targetUser = UserSearchResultEntity(
      userId: widget.tag.taggedUserId,
      username: widget.tag.taggedUserTagPay,
      firstName: firstName,
      lastName: lastName,
      email: '', // Not available from tag
      phoneNumber: '',
      profilePicture: '',
    );

    Navigator.pop(context);

    // Navigate to tag amount screen with pre-filled data
    Get.toNamed(
      AppRoutes.tagAmount,
      arguments: {
        'selectedUsers': [targetUser],
        'prefillAmount': widget.tag.amount,
        'prefillDescription': widget.tag.description,
        'prefillCurrency': widget.tag.currency,
      },
    );
  }

  Future<void> _downloadInvoice() async {
    if (_isDownloadingInvoice) return;

    setState(() => _isDownloadingInvoice = true);

    try {
      await TagPayPdfService.shareInvoice(
        tag: widget.tag,
        isOutgoing: widget.isOutgoing,
        // iPad/iOS share popover anchor — required so the share sheet opens.
        sharePositionOrigin: TagPayPdfService.shareOriginFromContext(context),
      );

      Get.snackbar(
        'Success',
        'Invoice generated successfully',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to generate invoice: $e',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      if (mounted) setState(() => _isDownloadingInvoice = false);
    }
  }

  Future<void> _downloadReceipt() async {
    if (_isDownloadingReceipt) return;

    // Only allow receipt download for paid tags
    if (!widget.tag.isPaid) {
      Get.snackbar(
        'Info',
        'Receipt is only available after payment is completed.',
        backgroundColor: const Color(0xFF4E03D0),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    setState(() => _isDownloadingReceipt = true);

    try {
      // Use the new method to generate receipt from tag data
      await TagPayPdfService.sharePaidTagReceipt(
        tag: widget.tag,
        isOutgoing: widget.isOutgoing,
        // iPad/iOS share popover anchor — required so the share sheet opens.
        sharePositionOrigin: TagPayPdfService.shareOriginFromContext(context),
      );

      Get.snackbar(
        'Success',
        'Receipt generated successfully',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to generate receipt: $e',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      if (mounted) setState(() => _isDownloadingReceipt = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPaid = widget.tag.status == TagStatus.paid;

    // Get display names with fallbacks
    final otherName =
        widget.isOutgoing ? widget.tag.taggedUserName : widget.tag.taggerName;
    final otherTag = widget.isOutgoing
        ? widget.tag.taggedUserTagPay
        : widget.tag.taggerTagPay;
    final displayName = otherName.isNotEmpty ? otherName : 'Lazervault User';
    final displayTag = otherTag.isNotEmpty ? '@$otherTag' : '';

    // Chip driven by the entity's single status source, so a state this branch
    // has not been taught can never be dressed up as PENDING. The old
    // if/else-if/else did exactly that: declined, expired and paying all landed
    // in the final `else` and were shown to the payer as an open demand.
    final (statusColor, statusIcon) = tagStatusChipStyle(widget.tag.status);
    final statusText = widget.tag.statusLabel;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Text(
                  'Tag Details',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.close,
                  color: const Color(0xFF9CA3AF),
                  size: 24.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Status Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  statusIcon,
                  color: statusColor,
                  size: 16.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  statusText,
                  style: GoogleFonts.inter(
                    color: statusColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Details
          _buildDetailRow(
            widget.isOutgoing ? 'To' : 'From',
            displayName,
          ),
          SizedBox(height: 16.h),
          if (displayTag.isNotEmpty) ...[
            _buildDetailRow('Tag', displayTag),
            SizedBox(height: 16.h),
          ],
          Divider(color: const Color(0xFF2D2D2D)),
          SizedBox(height: 16.h),
          _buildDetailRow(
            'Amount',
            widget.tag.formattedAmount,
            valueColor:
                isPaid ? const Color(0xFF10B981) : const Color(0xFFFB923C),
            isBold: true,
          ),
          if (widget.tag.description.isNotEmpty) ...[
            SizedBox(height: 16.h),
            _buildDetailRow('Description', widget.tag.description),
          ],
          SizedBox(height: 16.h),
          _buildDetailRow(
            'Created At',
            DateFormat('MMM dd, yyyy - hh:mm a').format(widget.tag.createdAt),
          ),
          if (isPaid && widget.tag.paidAt != null) ...[
            SizedBox(height: 16.h),
            _buildDetailRow(
              'Paid At',
              DateFormat('MMM dd, yyyy - hh:mm a').format(widget.tag.paidAt!),
            ),
          ],
          // Tags now lapse; say when, so a closed tag reads as closed and a
          // live one shows its remaining life instead of looking open forever.
          if (!isPaid && widget.tag.respondedAt != null) ...[
            SizedBox(height: 16.h),
            _buildDetailRow(
              widget.tag.isExpired ? 'Expired At' : 'Closed At',
              DateFormat('MMM dd, yyyy - hh:mm a')
                  .format(widget.tag.respondedAt!),
            ),
          ] else if (widget.tag.isPayable && widget.tag.expiresAt != null) ...[
            SizedBox(height: 16.h),
            _buildDetailRow(
              'Expires',
              DateFormat('MMM dd, yyyy - hh:mm a')
                  .format(widget.tag.expiresAt!),
            ),
          ],
          SizedBox(height: 24.h),

          // A transfer is already in flight — no Pay button, no Decline, just
          // say so. This tag used to render as PENDING with a live Pay button.
          if (widget.tag.isPaying) ...[
            TagUnpayableNotice(tag: widget.tag),
            SizedBox(height: 12.h),
          ],

          // Decline + Pay Now (incoming) or Cancel Tag (outgoing). Renders
          // nothing once the tag stops being pending, so paying / declined /
          // expired / cancelled offer no Pay button and nothing to withdraw.
          if (widget.tag.isPending) ...[
            TagLifecycleActionRow(
              tag: widget.tag,
              isOutgoing: widget.isOutgoing,
              onPay: widget.isOutgoing ? null : _goToPayment,
              onClosed: (_) => _closeAfterLifecycleChange(),
            ),
            SizedBox(height: 12.h),
          ],

          // Download Buttons Row - Invoice and Receipt side by side
          Row(
            children: [
              // Download Invoice Button
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _isDownloadingInvoice ? null : _downloadInvoice,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side:
                        const BorderSide(color: Color(0xFF60A5FA), width: 1.5),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  icon: _isDownloadingInvoice
                      ? LazerVaultLoader(size: 18)
                      : Icon(Icons.description_outlined,
                          size: 18.sp, color: const Color(0xFF60A5FA)),
                  label: Text(
                    'Invoice',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // Download Receipt Button (only enabled for paid tags)
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: isPaid && !_isDownloadingReceipt
                      ? _downloadReceipt
                      : null,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(
                      color: isPaid
                          ? const Color(0xFF34D399)
                          : const Color(0xFF6B7280),
                      width: 1.5,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  icon: _isDownloadingReceipt
                      ? LazerVaultLoader(size: 18)
                      : Icon(
                          Icons.receipt_long_outlined,
                          size: 18.sp,
                          color: isPaid
                              ? const Color(0xFF34D399)
                              : const Color(0xFF6B7280),
                        ),
                  label: Text(
                    'Receipt',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isPaid ? Colors.white : const Color(0xFF6B7280),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (!isPaid) ...[
            SizedBox(height: 8.h),
            Center(
              child: Text(
                'Receipt available after payment',
                style: GoogleFonts.inter(
                  color: const Color(0xFF6B7280),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],

          // Repeat Tag Button (only for outgoing/created tags)
          if (widget.isOutgoing) ...[
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _repeatTag,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFFA78BFA), width: 1.5),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                icon: Icon(Icons.repeat,
                    size: 18.sp, color: const Color(0xFFA78BFA)),
                label: Text(
                  'Repeat Tag',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    Color? valueColor,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 16.w),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.inter(
              color: valueColor ?? Colors.white,
              fontSize: isBold ? 18.sp : 14.sp,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
