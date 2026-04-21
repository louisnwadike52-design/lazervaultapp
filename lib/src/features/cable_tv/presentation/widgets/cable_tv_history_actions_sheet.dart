import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_history_actions_sheet.dart';
import '../../data/datasources/cable_tv_beneficiary_remote_datasource.dart';
import '../../domain/entities/cable_tv_payment_entity.dart';
import 'save_cable_tv_beneficiary_sheet.dart';

class CableTVHistoryActionsSheet {
  CableTVHistoryActionsSheet._();

  static Future<void> show(
    BuildContext context,
    CableTVPaymentEntity p,
  ) async {
    // Set Reminder + Save Smart Card only render for a successful
    // buy — matches data/airtime/internet policy.
    final bool isCompleted = p.isCompleted;

    String? existingId;
    String? existingNickname;
    if (isCompleted) {
      try {
        final ds = GetIt.I<CableTVBeneficiaryRemoteDataSource>();
        final beneficiaries = await ds.getBeneficiaries();
        final match = beneficiaries.where(
          (b) => b.smartCardNumber == p.customerNumber,
        );
        if (match.isNotEmpty) {
          existingId = match.first.id;
          existingNickname = match.first.nickname;
        }
      } catch (_) {}
    }

    final isSaved = existingId != null;

    if (!context.mounted) return;

    return BillHistoryActionsSheet.show(
      context,
      title: p.customerNumber.isEmpty
          ? 'Cable TV payment'
          : p.customerNumber,
      subtitle:
          '\u20A6${p.amount.toStringAsFixed(2)} \u00B7 ${_statusLabel(p)}',
      actions: [
        BillHistoryAction(
          icon: Icons.receipt_long,
          color: const Color(0xFF4E03D0),
          label: 'View Receipt',
          onTap: () {
            Get.back();
            Get.toNamed(
              AppRoutes.cableTVPaymentReceipt,
              arguments: {
                'payment': p,
                'fromHistory': true,
              },
            );
          },
        ),
        BillHistoryAction(
          icon: Icons.replay,
          color: const Color(0xFF10B981),
          label: 'Repeat Purchase',
          onTap: () {
            Get.back();
            Get.toNamed(
              AppRoutes.cableTVSmartCardInput,
              arguments: {
                'smartCardNumber': p.customerNumber,
                'providerCode': p.providerId,
                'isRepeat': true,
              },
            );
          },
        ),
        if (isCompleted)
          BillHistoryAction(
            icon: Icons.notifications_active,
            color: const Color(0xFFFB923C),
            label: 'Set Reminder',
            onTap: () {
              Get.back();
              Get.toNamed(
                AppRoutes.cableTVReminderCreate,
                arguments: {
                  'title': p.customerNumber.isEmpty
                      ? 'Renew cable TV'
                      : 'Renew ${p.customerNumber}',
                  'amount': p.amount,
                },
              );
            },
          ),
        if (isCompleted)
          BillHistoryAction(
            icon: isSaved ? Icons.edit_note : Icons.bookmark_add_outlined,
            color: const Color(0xFF4E03D0),
            label: isSaved ? 'Edit Smart Card' : 'Save Smart Card',
            trailing: isSaved
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle,
                          color: const Color(0xFF10B981), size: 16.sp),
                      SizedBox(width: 4.w),
                      Text(
                        'Saved',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF10B981),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                : null,
            onTap: () async {
              Get.back();
              await SaveCableTVBeneficiarySheet.show(
                context,
                smartCardNumber: p.customerNumber,
                providerCode:
                    p.providerId.isNotEmpty ? p.providerId : 'unknown',
                providerName:
                    p.providerId.isNotEmpty ? p.providerId : 'Unknown',
                customerName: p.customerName,
                existingBeneficiaryId: existingId,
                existingNickname: existingNickname,
              );
            },
          ),
      ],
    );
  }

  static String _statusLabel(CableTVPaymentEntity p) {
    if (p.isCompleted) return 'Completed';
    if (p.isFailed) return 'Failed';
    return 'Pending';
  }
}
