import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_history_actions_sheet.dart';
import '../../data/datasources/water_beneficiary_remote_datasource.dart';
import '../../domain/entities/customer_validation_result.dart';
import '../../domain/entities/water_beneficiary.dart';
import '../../domain/entities/water_payment_entity.dart';
import '../../domain/entities/water_provider_entity.dart';
import 'save_water_beneficiary_sheet.dart';

/// Bottom sheet of actions available on a past water bill payment, in
/// either the recent-transactions strip or the history list. Mirrors
/// `CableTVHistoryActionsSheet` / `DataHistoryActionsSheet`:
///
///   * View Receipt — always available.
///   * Repeat Purchase — always available; synthesizes a minimal
///     `WaterProviderEntity` + `CustomerValidationResult` so the
///     confirmation screen boots with everything pre-filled.
///   * Set Reminder — **completed-only**. Gated by ensure-saved.
///   * Set Auto-Pay — **completed-only**. Gated by ensure-saved.
///   * Save / Edit Account — **completed-only**.
class WaterHistoryActionsSheet {
  WaterHistoryActionsSheet._();

  static const _bluePrimary = Color(0xFF4E03D0);
  static const _success = Color(0xFF10B981);
  static const _warning = Color(0xFFFB923C);

  static Future<void> show(
    BuildContext context,
    WaterPaymentEntity p,
  ) async {
    final providerCode = p.providerCode;
    final providerName = p.providerName.isNotEmpty
        ? p.providerName
        : _providerDisplay(providerCode);
    final accountNumber = p.customerNumber.trim();
    final isCompleted = p.isCompleted;

    // Probe for an existing saved contact so the "Save" action can
    // flip to an "Edit" affordance with a trailing Saved badge. Only
    // probe for completed payments — the action isn't shown otherwise.
    String? existingId;
    String? existingNickname;
    WaterBeneficiary? existingBeneficiary;
    if (isCompleted) {
      try {
        final ds = GetIt.I<WaterBeneficiaryRemoteDataSource>();
        final list = await ds.getBeneficiaries();
        for (final b in list) {
          if (b.accountNumber == accountNumber &&
              (providerCode.isEmpty ||
                  b.providerCode.toUpperCase() ==
                      providerCode.toUpperCase())) {
            existingId = b.id;
            existingNickname = b.nickname;
            existingBeneficiary = b;
            break;
          }
        }
      } catch (_) {
        // Best-effort — proceed without saved-contact detection.
      }
    }

    final isSaved = existingId != null;

    if (!context.mounted) return;

    return BillHistoryActionsSheet.show(
      context,
      title: accountNumber.isEmpty ? 'Water payment' : accountNumber,
      subtitle:
          '₦${p.amount.toStringAsFixed(2)} · ${_statusLabel(p)}',
      actions: [
        BillHistoryAction(
          icon: Icons.receipt_long,
          color: _bluePrimary,
          label: 'View Receipt',
          onTap: () {
            Get.back();
            Get.toNamed(
              AppRoutes.waterBillPaymentReceipt,
              arguments: <String, dynamic>{
                'payment': p,
                'fromHistory': true,
              },
            );
          },
        ),
        BillHistoryAction(
          icon: Icons.replay,
          color: _success,
          label: 'Repeat Purchase',
          onTap: () {
            Get.back();
            final provider = _synthProvider(providerCode, providerName);
            // Fast-path: when we have both an account and a non-zero
            // amount, land directly on the confirmation screen. The
            // confirm screen probes for existing beneficiary / auto-
            // pay and hides matching toggles. For records missing an
            // amount we route to the customer-input screen instead so
            // the user can enter one — the confirmation build's
            // `args['amount'] as double` would otherwise crash.
            if (p.amount > 0) {
              final validation = CustomerValidationResult(
                customerNumber: accountNumber,
                customerName: p.customerName.isNotEmpty
                    ? p.customerName
                    : accountNumber,
                isValid: true,
              );
              Get.toNamed(
                AppRoutes.waterBillPaymentConfirmation,
                arguments: <String, dynamic>{
                  'provider': provider,
                  'validationResult': validation,
                  'customerNumber': accountNumber,
                  'amount': p.amount,
                  'isRepeat': true,
                },
              );
            } else {
              Get.toNamed(
                AppRoutes.waterBillCustomerInput,
                arguments: <String, dynamic>{
                  'provider': provider,
                  'preselectedAccountNumber': accountNumber,
                },
              );
            }
          },
        ),
        if (isCompleted)
          BillHistoryAction(
            icon: Icons.notifications_active,
            color: _warning,
            label: 'Set Reminder',
            onTap: () async {
              Get.back();
              final saved = await _ensureBeneficiarySaved(
                context,
                existing: existingBeneficiary,
                accountNumber: accountNumber,
                providerCode: providerCode,
                providerName: providerName,
                customerName: p.customerName,
              );
              if (saved == false) return;
              final title = accountNumber.isEmpty
                  ? 'Pay $providerName'
                  : 'Pay $providerName · $accountNumber';
              Get.toNamed(
                AppRoutes.waterBillRemindersCreate,
                arguments: <String, dynamic>{
                  'title': title,
                  'amount': p.amount > 0 ? p.amount : null,
                },
              );
            },
          ),
        if (isCompleted)
          BillHistoryAction(
            icon: Icons.autorenew,
            color: _success,
            label: 'Set Auto-Pay',
            onTap: () async {
              Get.back();
              final saved = await _ensureBeneficiarySaved(
                context,
                existing: existingBeneficiary,
                accountNumber: accountNumber,
                providerCode: providerCode,
                providerName: providerName,
                customerName: p.customerName,
              );
              if (saved == false) return;
              final ds = GetIt.I<WaterBeneficiaryRemoteDataSource>();
              WaterBeneficiary? beneficiary = existingBeneficiary;
              if (beneficiary == null) {
                try {
                  final list = await ds.getBeneficiaries();
                  for (final b in list) {
                    if (b.accountNumber == accountNumber &&
                        (providerCode.isEmpty ||
                            b.providerCode.toUpperCase() ==
                                providerCode.toUpperCase())) {
                      beneficiary = b;
                      break;
                    }
                  }
                } catch (_) {
                  // Degrade gracefully — create screen opens unlocked
                  // so user can pick from dropdown.
                }
              }
              await Get.toNamed(
                AppRoutes.waterBillAutoRechargeCreate,
                arguments: <String, dynamic>{
                  if (beneficiary != null) 'beneficiary': beneficiary,
                  if (beneficiary != null) 'locked': true,
                },
              );
            },
          ),
        if (isCompleted)
          BillHistoryAction(
            icon: isSaved ? Icons.edit_note : Icons.bookmark_add_outlined,
            color: _bluePrimary,
            label: isSaved ? 'Edit Account' : 'Save Account',
            trailing: isSaved
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle,
                          color: _success, size: 16.sp),
                      SizedBox(width: 4.w),
                      Text(
                        'Saved',
                        style: GoogleFonts.inter(
                          color: _success,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                : null,
            onTap: () async {
              Get.back();
              await SaveWaterBeneficiarySheet.show(
                context,
                accountNumber: accountNumber,
                providerCode:
                    providerCode.isNotEmpty ? providerCode : 'UNKNOWN',
                providerName:
                    providerName.isNotEmpty ? providerName : 'Unknown',
                customerName: p.customerName,
                existingBeneficiaryId: existingId,
                existingNickname: existingNickname,
              );
            },
          ),
      ],
    );
  }

  /// Save-gate for Reminder + Auto-Pay — both features require a
  /// persisted beneficiary. Returns true when already saved or saved
  /// inline; false when the user dismisses the sheet.
  static Future<bool> _ensureBeneficiarySaved(
    BuildContext context, {
    required WaterBeneficiary? existing,
    required String accountNumber,
    required String providerCode,
    required String providerName,
    required String customerName,
  }) async {
    if (existing != null) return true;
    if (!context.mounted) return false;
    final saved = await SaveWaterBeneficiarySheet.show(
      context,
      accountNumber: accountNumber,
      providerCode: providerCode.isNotEmpty ? providerCode : 'UNKNOWN',
      providerName: providerName.isNotEmpty ? providerName : 'Unknown',
      customerName: customerName,
    );
    return saved == true;
  }

  /// Minimal `WaterProviderEntity` assembled from history-row data.
  /// The customer-input screen reads `providerCode` + `providerName`;
  /// other fields are safe placeholders.
  static WaterProviderEntity _synthProvider(
      String providerCode, String providerName) {
    return WaterProviderEntity(
      providerCode: providerCode,
      providerName: providerName,
    );
  }

  static String _providerDisplay(String providerCode) {
    final code = providerCode.toUpperCase();
    if (code.contains('LSWC') || code.contains('LAGOS')) {
      return 'Lagos Water';
    }
    if (code.contains('FCT') || code.contains('ABUJA')) {
      return 'FCT Water';
    }
    return providerCode.isNotEmpty ? providerCode : 'Water';
  }

  static String _statusLabel(WaterPaymentEntity p) {
    if (p.isCompleted) return 'Completed';
    if (p.isFailed) return 'Failed';
    if (p.isRefunded) return 'Refunded';
    return 'Pending';
  }
}
