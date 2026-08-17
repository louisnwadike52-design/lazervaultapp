import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/funds/presentation/send_funds_launcher.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart' as grpc_helper;
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_message_entity.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/get_recipients_usecase.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_grpc;
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
part 'p2p_transfer_bubble_widgets.dart';


class P2PTransferBubble extends StatelessWidget {
  final P2PMessageEntity message;
  final bool isMe;
  final String otherUserName;
  final String? otherUserId;

  const P2PTransferBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.otherUserName,
    this.otherUserId,
  });

  /// Display name with fallback for empty strings.
  String get _displayName =>
      otherUserName.isNotEmpty ? otherUserName : 'Unknown User';

  /// Whether this transfer was sent by the current user.
  ///
  /// LEGACY messages ("transfer_sent"/"transfer_received") encode the direction
  /// in the type itself — trust that over senderId, because some legacy rows
  /// were stored with an inconsistent senderId which made a user's OWN sent
  /// transfer render on the receiver's (left) side. Canonical "transfer" rows
  /// always carry the money sender as senderId, so fall back to `isMe`
  /// (senderId == currentUserId) for those.
  bool get _isSentByMe {
    if (message.isTransferSent) return true;
    if (message.isTransferReceived) return false;
    return isMe;
  }

  /// Clean transfer reference — strips legacy "-recv" suffix for display/receipt.
  String? get _cleanTransferRef {
    final ref = message.transferRef;
    if (ref == null) return null;
    return ref.endsWith('-recv') ? ref.substring(0, ref.length - 5) : ref;
  }

  /// Whether "Send Again" should be offered for this transfer.
  bool get _canSendAgain {
    if (!_isSentByMe) return false;
    if (message.isTransferRequest) return false;
    if (otherUserId == null || otherUserId!.isEmpty) return false;
    // Don't offer for failed or pending transfers
    final status = message.transferStatus?.toLowerCase();
    if (status == 'failed' || status == 'reversed' || status == 'cancelled') {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final isSent = _isSentByMe;
    final isRequest = message.isTransferRequest;
    // A future-dated send that hasn't fired yet — you always schedule your OWN
    // send, so this only applies to outgoing bubbles.
    final isScheduled = message.transferStatus?.toLowerCase() == 'scheduled';

    final Color iconColor;
    final IconData icon;
    final String label;

    if (isRequest) {
      iconColor = const Color(0xFFFB923C); // orange
      icon = Icons.request_page_outlined;
      label = isMe ? 'Money Requested' : 'Payment Request';
    } else if (isScheduled) {
      iconColor = const Color(0xFFF59E0B); // amber
      icon = Icons.schedule;
      label = 'Money Scheduled';
    } else if (isSent) {
      iconColor = const Color(0xFFEF4444); // red
      icon = Icons.arrow_upward;
      label = 'Money Sent';
    } else {
      iconColor = const Color(0xFF10B981); // green
      icon = Icons.arrow_downward;
      label = 'Money Received';
    }

    final currency = message.transferCurrency ?? 'NGN';
    final amount = message.transferAmountMajor;
    final formattedAmount = amount != null
        ? NumberFormat.currency(
            symbol: _getCurrencySymbol(currency),
            decimalDigits: 2,
          ).format(amount)
        : '${_getCurrencySymbol(currency)}0.00';

    // Show transfer status if available and not completed
    final transferStatus = message.transferStatus;
    final showStatus = transferStatus != null &&
        transferStatus.isNotEmpty &&
        transferStatus != 'completed' &&
        transferStatus != 'success';

    return Align(
      // Align by the SAME derived direction the label uses, so a "Money Sent"
      // bubble always sits on the right and "Money Received" on the left even
      // for legacy rows whose senderId disagreed with their type.
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onTap: isRequest ? null : () => _showTransferDetailsSheet(context),
        child: Container(
          constraints: BoxConstraints(maxWidth: 230.w),
          margin: EdgeInsets.symmetric(vertical: 4.h),
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: const Color(0xFF2D2D2D),
            // Same per-party "tail" as the text bubble: the OUTER bottom corner
            // (right for the sender, left for the receiver) is tucked in so the
            // bubble reads as pointing to its owner. Top + inner-bottom stay round.
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
              bottomLeft: Radius.circular(isSent ? 16.r : 4.r),
              bottomRight: Radius.circular(isSent ? 4.r : 16.r),
            ),
            border: Border.all(
              color: iconColor.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Transfer icon
              Container(
                width: 30.w,
                height: 30.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconColor.withOpacity(0.15),
                ),
                child: Icon(icon, color: iconColor, size: 17.w),
              ),
              SizedBox(width: 10.w),
              // Amount and label
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 11.sp,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      formattedAmount,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          DateFormat('HH:mm').format(message.createdAt),
                          style: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 10.sp,
                          ),
                        ),
                        if (showStatus) ...[
                          SizedBox(width: 6.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 1.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFB923C).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              // Natural-cased ("Scheduled", not "scheduled").
                              transferStatus[0].toUpperCase() +
                                  transferStatus.substring(1),
                              style: GoogleFonts.inter(
                                color: const Color(0xFFFB923C),
                                fontSize: 9.sp,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              // Chevron indicator (tappable) — only for sent/received, not requests
              if (!isRequest)
                Icon(
                  Icons.chevron_right,
                  color: const Color(0xFF9CA3AF),
                  size: 20.w,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTransferDetailsSheet(BuildContext context) {
    final isSent = _isSentByMe;
    final currency = message.transferCurrency ?? 'NGN';
    final amount = message.transferAmountMajor;
    final formattedAmount = amount != null
        ? NumberFormat.currency(
            symbol: _getCurrencySymbol(currency),
            decimalDigits: 2,
          ).format(amount)
        : '${_getCurrencySymbol(currency)}0.00';

    final transferStatus = message.transferStatus;
    final statusLabel = (transferStatus != null && transferStatus.isNotEmpty)
        ? transferStatus[0].toUpperCase() + transferStatus.substring(1)
        : 'Completed';

    final Color statusColor;
    switch (transferStatus?.toLowerCase()) {
      case 'pending':
      case 'processing':
        statusColor = const Color(0xFFFB923C);
        break;
      case 'failed':
      case 'reversed':
      case 'cancelled':
        statusColor = const Color(0xFFEF4444);
        break;
      default:
        statusColor = const Color(0xFF10B981);
    }

    final ref = _cleanTransferRef;
    final canSendAgain = _canSendAgain;
    final showReceipt = transferStatus == null ||
        transferStatus.isEmpty ||
        transferStatus == 'completed' ||
        transferStatus == 'success';
    final hasActions = showReceipt || canSendAgain;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Container(
        padding: EdgeInsets.only(
          top: 16.h,
          left: 20.w,
          right: 20.w,
          bottom: MediaQuery.of(ctx).padding.bottom + 16.h,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h),
            // Title
            Text(
              'Transfer Details',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 24.h),
            // Icon + label + amount
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (isSent
                        ? const Color(0xFFEF4444)
                        : const Color(0xFF10B981))
                    .withOpacity(0.15),
              ),
              child: Icon(
                isSent ? Icons.arrow_upward : Icons.arrow_downward,
                color:
                    isSent ? const Color(0xFFEF4444) : const Color(0xFF10B981),
                size: 28.w,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              isSent ? 'Money Sent' : 'Money Received',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              formattedAmount,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 24.h),
            // Details rows
            _buildDetailRow(
              isSent ? 'To' : 'From',
              _displayName,
            ),
            _buildDetailRow(
              'Reference',
              ref ?? 'N/A',
              onLongPress: ref != null && ref.isNotEmpty
                  ? () {
                      Clipboard.setData(ClipboardData(text: ref));
                      Get.snackbar(
                        'Copied',
                        'Reference copied to clipboard',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor:
                            const Color(0xFF2D2D2D).withOpacity(0.95),
                        colorText: Colors.white,
                        duration: const Duration(seconds: 2),
                      );
                    }
                  : null,
            ),
            _buildDetailRow(
              'Status',
              statusLabel,
              valueColor: statusColor,
            ),
            _buildDetailRow(
              'Date',
              DateFormat('MMM d, yyyy \'at\' HH:mm').format(message.createdAt),
            ),
            if (hasActions) SizedBox(height: 28.h),
            // Action buttons — View Receipt + Send Again side by side.
            // Dismissal is handled by tap-outside / swipe-down (sheet defaults).
            if (hasActions)
              Row(
                children: [
                  if (showReceipt)
                    Expanded(
                      child: SizedBox(
                        height: 52.h,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            // Legal-grade proof: "From"/"To" must carry real
                            // FULL names (never "You"), since this receipt is
                            // shareable evidence. Current user comes from the
                            // auth cubit; the counterparty is the conversation
                            // display name. P2P chat transfers are always
                            // LazerVault→LazerVault (internal), so we surface
                            // the same internal-wallet rail the direct receipt
                            // shows — which also makes the "From" row render
                            // (TransferProof gates it on sourceAccountInfo).
                            String myName = 'You';
                            try {
                              final me = ctx
                                  .read<AuthenticationCubit>()
                                  .currentProfile
                                  ?.user;
                              if (me != null) {
                                final full =
                                    '${me.firstName} ${me.lastName}'.trim();
                                if (full.isNotEmpty) myName = full;
                              }
                            } catch (_) {/* provider not in tree → keep 'You' */}
                            final fromName = isSent ? myName : _displayName;
                            final toName = isSent ? _displayName : myName;
                            Get.toNamed(
                              AppRoutes.transferProof,
                              arguments: <String, dynamic>{
                                'amount': message.transferAmountMajor ?? 0,
                                'currency': currency,
                                'reference': ref ?? '',
                                'transferId': (ref != null && ref.isNotEmpty)
                                    ? ref
                                    : message.id,
                                'recipientName': toName,
                                'recipientBankName': 'Lazervault',
                                'sourceAccountName': fromName,
                                'sourceAccountInfo': 'Lazervault',
                                'timestamp': message.createdAt,
                                'status': statusLabel.toLowerCase(),
                                'network': 'Lazervault Internal Transfer',
                                'transferType': 'Internal Transfer',
                                'type': isSent ? 'debit' : 'credit',
                              },
                            );
                          },
                          icon: Icon(Icons.receipt_long_outlined, size: 18.w),
                          label: Text(
                            'View Receipt',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(0xFF2D2D2D),
                            side: const BorderSide(color: Color(0xFF3A3A3A)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                          ),
                        ),
                      ),
                    ),
                  if (showReceipt && canSendAgain) SizedBox(width: 12.w),
                  if (canSendAgain)
                    Expanded(
                      child: _SendAgainButton(
                        otherUserId: otherUserId!,
                        otherUserName: _displayName,
                        transferAmount: message.transferAmount,
                        transferCurrency: message.transferCurrency,
                        onDismiss: () => Navigator.of(ctx).pop(),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    Color? valueColor,
    VoidCallback? onLongPress,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Flexible(
            child: GestureDetector(
              onLongPress: onLongPress,
              child: Text(
                value,
                textAlign: TextAlign.end,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: valueColor ?? Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getCurrencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'NGN':
        return '\u20A6';
      case 'USD':
        return '\$';
      case 'GBP':
        return '\u00A3';
      case 'EUR':
        return '\u20AC';
      case 'GHS':
        return 'GH\u20B5';
      case 'KES':
        return 'KSh';
      case 'ZAR':
        return 'R';
      default:
        return currency;
    }
  }
}
