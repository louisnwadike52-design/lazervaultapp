import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart' as grpc_helper;
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_message_entity.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/get_recipients_usecase.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_grpc;

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
  /// For all transfer types (new "transfer" and legacy "transfer_sent"/"transfer_received"),
  /// we derive from `isMe` (senderId == currentUserId) since senderId is always the money sender.
  /// After legacy dedup, both users see the same message, so isMe correctly gives the perspective.
  bool get _isSentByMe => isMe;

  /// Clean transfer reference — strips legacy "-recv" suffix for display/receipt.
  String? get _cleanTransferRef {
    final ref = message.transferRef;
    if (ref == null) return null;
    return ref.endsWith('-recv') ? ref.substring(0, ref.length - 5) : ref;
  }

  /// Whether "Send Again" should be offered for this transfer.
  bool get _canSendAgain {
    if (!isMe) return false;
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

    final Color iconColor;
    final IconData icon;
    final String label;

    if (isRequest) {
      iconColor = const Color(0xFFFB923C); // orange
      icon = Icons.request_page_outlined;
      label = isMe ? 'Money Requested' : 'Payment Request';
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
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onTap: isRequest ? null : () => _showTransferDetailsSheet(context),
        child: Container(
          constraints: BoxConstraints(maxWidth: 260.w),
          margin: EdgeInsets.symmetric(vertical: 4.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(16.r),
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
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconColor.withOpacity(0.15),
                ),
                child: Icon(icon, color: iconColor, size: 20.w),
              ),
              SizedBox(width: 12.w),
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
                        fontSize: 18.sp,
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
                              transferStatus,
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
            SizedBox(height: 24.h),
            // View Receipt button — for all completed transfers
            if (transferStatus == null ||
                transferStatus.isEmpty ||
                transferStatus == 'completed' ||
                transferStatus == 'success')
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      Get.toNamed(
                        AppRoutes.transferProof,
                        arguments: <String, dynamic>{
                          'amount': message.transferAmountMajor ?? 0,
                          'currency': currency,
                          'reference': ref ?? '',
                          'recipientName': isSent ? _displayName : 'You',
                          'senderName': isSent ? 'You' : _displayName,
                          'timestamp': message.createdAt,
                          'status': statusLabel.toLowerCase(),
                          'type': isSent ? 'debit' : 'credit',
                        },
                      );
                    },
                    icon: Icon(Icons.receipt_long, size: 18.w),
                    label: Text(
                      'View Receipt',
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            // Send Again button — only for completed transfers the current user sent
            if (canSendAgain)
              _SendAgainButton(
                otherUserId: otherUserId!,
                otherUserName: _displayName,
                transferAmount: message.transferAmount,
                transferCurrency: message.transferCurrency,
                onDismiss: () => Navigator.of(ctx).pop(),
              ),
            if (canSendAgain) SizedBox(height: 12.h),
            // Close button
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    side: const BorderSide(color: Color(0xFF2D2D2D)),
                  ),
                ),
                child: Text(
                  'Close',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
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

/// Stateful button that async-resolves the recipient before navigating.
/// First tries saved recipients, then falls back to resolving account via gRPC.
class _SendAgainButton extends StatefulWidget {
  final String otherUserId;
  final String otherUserName;
  final int? transferAmount;
  final String? transferCurrency;
  final VoidCallback onDismiss;

  const _SendAgainButton({
    required this.otherUserId,
    required this.otherUserName,
    required this.transferAmount,
    this.transferCurrency,
    required this.onDismiss,
  });

  @override
  State<_SendAgainButton> createState() => _SendAgainButtonState();
}

class _SendAgainButtonState extends State<_SendAgainButton> {
  bool _isLoading = false;

  Future<void> _onTap() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    try {
      // Try saved recipient first, then resolve account directly
      final recipient = await _lookupSavedRecipient() ?? await _resolveRecipientFromAccount();

      if (!mounted) return;
      try {
        widget.onDismiss();
      } catch (_) {
        // Bottom sheet may already be dismissed by user swipe
      }

      if (recipient != null) {
        final args = <String, dynamic>{
          'recipient': recipient,
        };
        if (widget.transferAmount != null && widget.transferAmount! > 0) {
          args['prefillAmount'] = widget.transferAmount;
        }
        if (widget.transferCurrency != null) {
          args['prefillCurrency'] = widget.transferCurrency;
        }
        Get.toNamed(AppRoutes.initiateSendFunds, arguments: args);
      } else {
        Get.snackbar(
          'Error',
          'Could not resolve recipient account. Try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFEF4444).withOpacity(0.9),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      debugPrint('[P2P] Send Again lookup failed: $e');
      if (!mounted) return;
      try {
        widget.onDismiss();
      } catch (_) {}
      Get.snackbar(
        'Error',
        'Could not load recipient details. Try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFEF4444).withOpacity(0.9),
        colorText: Colors.white,
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /// Look up the saved recipient by internalUserId from the backend.
  Future<RecipientModel?> _lookupSavedRecipient() async {
    String? accessToken;
    try {
      final authCubit = serviceLocator<AuthenticationCubit>();
      accessToken = switch (authCubit.state) {
        AuthenticationSuccess s => s.profile.session.accessToken,
        AuthenticationAuthenticated s => s.profile.session.accessToken,
        _ => null,
      };
    } catch (_) {
      return null;
    }

    if (accessToken == null) return null;

    try {
      final getRecipientsUseCase = serviceLocator<GetRecipientsUseCase>();
      final result = await getRecipientsUseCase(accessToken: accessToken);

      return result.fold(
        (failure) => null,
        (recipients) {
          for (final r in recipients) {
            if (r.internalUserId == widget.otherUserId &&
                r.accountNumber.isNotEmpty) {
              return r;
            }
          }
          for (final r in recipients) {
            if (r.bankName == 'LazerVault' &&
                r.name.toLowerCase() == widget.otherUserName.toLowerCase() &&
                r.accountNumber.isNotEmpty) {
              return r;
            }
          }
          return null;
        },
      );
    } catch (_) {
      return null;
    }
  }

  /// Resolve the user's account via gRPC and construct a RecipientModel directly.
  Future<RecipientModel?> _resolveRecipientFromAccount() async {
    try {
      final client = serviceLocator<accounts_grpc.AccountsServiceClient>();
      final helper = serviceLocator<grpc_helper.GrpcCallOptionsHelper>();
      final callOptions = await helper.withAuth();
      final response = await client.getUserAccounts(
        accounts_pb.GetUserAccountsRequest(targetUserId: widget.otherUserId),
        options: callOptions,
      );
      if (response.accounts.isNotEmpty) {
        final account = response.accounts.first;
        return RecipientModel(
          id: '',
          name: widget.otherUserName,
          accountNumber: account.accountNumber,
          bankName: 'LazerVault',
          sortCode: '',
          isFavorite: false,
          isSaved: false,
          internalUserId: widget.otherUserId,
          currency: account.currency.isNotEmpty ? account.currency : null,
        );
      }
    } catch (e) {
      debugPrint('[P2P] Account resolution failed: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton.icon(
        onPressed: _isLoading ? null : _onTap,
        icon: _isLoading
            ? SizedBox(
                width: 18.w,
                height: 18.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Icon(Icons.replay, size: 18.w),
        label: Text(
          _isLoading ? 'Loading...' : 'Send Again',
          style: GoogleFonts.inter(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3B82F6),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
          disabledBackgroundColor: const Color(0xFF3B82F6).withOpacity(0.6),
        ),
      ),
    );
  }
}
