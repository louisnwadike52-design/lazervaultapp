import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/contactless_payment_entity.dart';
import '../../domain/repositories/contactless_payment_repository.dart';
import '../cubit/contactless_payment_cubit.dart';
import '../cubit/contactless_payment_state.dart';
import 'package:lazervault/src/features/widgets/status_filter_chips.dart';
import '../../services/contactless_websocket_service.dart';
import 'package:get/get.dart';

import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'payment_success_screen.dart';
part 'payment_history_screen_widgets.dart';

class _TransactionCard extends StatelessWidget {
  final ContactlessTransactionEntity transaction;
  final int index;

  const _TransactionCard({
    required this.transaction,
    required this.index,
  });

  IconData _getCategoryIcon(String? category) {
    switch (category?.toLowerCase()) {
      case 'food':
        return Icons.restaurant_rounded;
      case 'transport':
        return Icons.directions_car_rounded;
      case 'shopping':
        return Icons.shopping_bag_rounded;
      case 'services':
        return Icons.build_rounded;
      case 'bills':
        return Icons.receipt_long_rounded;
      default:
        return Icons.contactless_rounded;
    }
  }

  Color _getCategoryColor(String? category) {
    switch (category?.toLowerCase()) {
      case 'food':
        return const Color(0xFFF59E0B);
      case 'transport':
        return const Color(0xFF3B82F6);
      case 'shopping':
        return const Color(0xFFEC4899);
      case 'services':
        return const Color.fromARGB(255, 78, 3, 208);
      case 'bills':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF4E03D0);
    }
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'completed':
        return const Color(0xFF10B981);
      case 'pending':
        return const Color(0xFFF59E0B);
      case 'failed':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF9CA3AF);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d, yyyy • h:mm a');
    final catColor = _getCategoryColor(transaction.category);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * 80)),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          _openReceipt(context);
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1F1F1F), Color(0xFF1F1F35)],
            ),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.06),
            ),
          ),
          child: Row(
            children: [
              // Category icon
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: catColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(
                  _getCategoryIcon(transaction.category),
                  size: 22.sp,
                  color: catColor,
                ),
              ),
              SizedBox(width: 14.w),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.receiverName,
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      dateFormat.format(transaction.createdAt),
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                    if (transaction.description != null &&
                        transaction.description!.isNotEmpty) ...[
                      SizedBox(height: 2.h),
                      Text(
                        transaction.description!,
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: const Color(0xFF9CA3AF).withValues(alpha: 0.7),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),

              // Amount + status
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    transaction.formattedAmount,
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF10B981),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: _getStatusColor(transaction.status.name)
                          .withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      transaction.status.name.toUpperCase(),
                      style: GoogleFonts.inter(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w700,
                        color: _getStatusColor(transaction.status.name),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Open the full receipt rather than a read-only sheet.
  ///
  /// The sheet could show the details but not DO anything with them — no
  /// download, no share, no PDF. A user looking up a past payment wants the
  /// receipt, which is the artefact they can actually send to someone.
  void _openReceipt(BuildContext context) {
    // Direction decides whose name leads the receipt and which PDF is built.
    // Getting it from the transaction rather than assuming: this screen shows
    // both money in and money out.
    var isReceiver = false;
    try {
      final me = context.read<AuthenticationCubit>().currentProfile?.user;
      if (me != null) isReceiver = me.id == transaction.receiverId;
    } catch (_) {
      // Provider not in tree (deep link / test) — fall back to payer view
      // rather than failing to open the receipt at all.
    }

    Get.to(() => PaymentSuccessScreen(
          amount: transaction.amount,
          currency: transaction.currency,
          payerName: transaction.payerName,
          receiverName: transaction.receiverName,
          payerUsername: transaction.payerUsername,
          receiverUsername: transaction.receiverUsername,
          referenceNumber: transaction.referenceNumber,
          category: transaction.category,
          description: transaction.description,
          transactionDate: transaction.createdAt,
          isReceiver: isReceiver,
          // The entity itself drives the PDF, so share/download carry the real
          // payload instead of a re-derived summary.
          transaction: transaction,
        ));
  }


}
