import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_auto_recharge_create_sheet.dart';
import '../../../../../core/widgets/bill_history_actions_sheet.dart';
import '../../../../../core/widgets/bill_reminder_create_sheet.dart';
import '../../domain/entities/auto_recharge_entity.dart';
import '../../domain/entities/beneficiary_entity.dart';
import '../../domain/entities/bill_payment_entity.dart';
import '../../domain/entities/provider_entity.dart';
import '../../domain/entities/reminder_entity.dart';
import '../../domain/repositories/electricity_bill_repository.dart';
import 'rename_meter_sheet.dart';
import 'save_meter_sheet.dart';

/// Bottom sheet for electricity bill payment history items.
///
/// Uses the shared [BillHistoryActionsSheet] for consistent rendering.
class ElectricityHistoryActionsSheet {
  /// If the meter isn't saved yet, opens the save-meter bottom sheet so the
  /// user can name and persist it inline (no page navigation). Returns the
  /// saved-or-existing [BillBeneficiaryEntity], or `null` if the user
  /// cancelled — callers that need to attach a reminder/auto-recharge to
  /// the beneficiary use the returned entity directly and skip the extra
  /// `getBeneficiaries()` round-trip.
  static Future<BillBeneficiaryEntity?> _ensureBeneficiarySaved(
    BuildContext context, {
    required BillBeneficiaryEntity? existing,
    required BillPaymentEntity payment,
  }) async {
    if (existing != null) return existing;
    if (!context.mounted) return null;
    return SaveMeterSheet.show(context, payment: payment);
  }

  ElectricityHistoryActionsSheet._();

  static Future<void> show(
    BuildContext context,
    BillPaymentEntity payment,
  ) async {
    // Resolve the saved beneficiary (if any) matching THIS meter + provider.
    // Matching on both fields (not meter-only) prevents false positives when
    // the same meter number exists across discos, which was showing every
    // history row as "Saved". When found, the trailing label renders the
    // beneficiary's nickname — the "Edit Meter" action opens a rename
    // bottom sheet inline rather than navigating away.
    BillBeneficiaryEntity? savedBeneficiary;
    try {
      final repo = GetIt.I<ElectricityBillRepository>();
      final result = await repo.getBeneficiaries();
      result.fold(
        (_) {},
        (beneficiaries) {
          for (final b in beneficiaries) {
            if (b.meterNumber == payment.meterNumber &&
                b.providerCode == payment.providerCode) {
              savedBeneficiary = b;
              break;
            }
          }
        },
      );
    } catch (_) {
      // Proceed without saved-meter detection
    }
    final bool isSaved = savedBeneficiary != null;

    if (!context.mounted) return;

    // Reminder & auto-recharge only make sense once a payment has actually
    // gone through — for pending/processing/failed rows we hide them so the
    // user doesn't schedule recurring runs off a meter that never took.
    final isCompleted = payment.status == BillPaymentStatus.completed;

    return BillHistoryActionsSheet.show(
      context,
      title: '${payment.providerName} \u00B7 ${payment.meterNumber}',
      subtitle:
          '\u20A6${payment.amount.toStringAsFixed(2)} \u00B7 ${payment.status.displayName}'
          '${payment.hasRefundActivity ? ' \u00B7 ${payment.refundDisplayLabel}' : ''}',
      actions: [
        BillHistoryAction(
          icon: Icons.receipt_long,
          color: const Color(0xFF4E03D0),
          label: 'View Receipt',
          onTap: () {
            Get.back();
            Get.toNamed(
              AppRoutes.electricityBillReceipt,
              arguments: {'payment': payment, 'fromHistory': true},
            );
          },
        ),
        BillHistoryAction(
          icon: Icons.replay,
          color: const Color(0xFF10B981),
          label: 'Repeat Payment',
          onTap: () {
            Get.back();
            // Build the typed payload the confirmation screen expects
            // (plain strings would fail the `is ElectricityProviderEntity`
            // arg-type gate and pop the screen right back). We synthesise
            // a minimal provider + validation result from the historical
            // row so the user lands on Step 2 of the confirmation flow
            // with everything pre-filled — meter number, meter type,
            // customer name/address, phone, and the last amount.
            final synthProvider = ElectricityProviderEntity(
              id: payment.providerId,
              providerCode: payment.providerCode,
              providerName: payment.providerName,
              country: 'NG',
              supportsPrepaid: payment.meterType == MeterType.prepaid,
              supportsPostpaid: payment.meterType == MeterType.postpaid,
              isActive: true,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            );
            final synthValidation = MeterValidationResult(
              customerName: payment.customerName,
              customerAddress: payment.customerAddress,
              meterNumber: payment.meterNumber,
              meterType: payment.meterType,
              isValid: true,
            );
            Get.toNamed(
              AppRoutes.electricityBillConfirmation,
              arguments: <String, dynamic>{
                'provider': synthProvider,
                'validationResult': synthValidation,
                'providerCode': payment.providerCode,
                'meterNumber': payment.meterNumber,
                'meterType': payment.meterType,
                'phoneNumber': payment.phoneNumber ?? '',
                'customerName': payment.customerName,
                'customerAddress': payment.customerAddress ?? '',
                'amount': payment.amount,
                // Flag consumed by the confirmation screen to (a) prefill
                // the amount + (b) flip the back-nav so it pops back to
                // the history screen instead of the meter-input step.
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
            onTap: () async {
              // Take a context that OUTLIVES this sheet before closing it.
              //
              // Everything below ran against the sheet's own context after
              // Get.back() had unmounted it, so the save prompt returned null
              // and the `!context.mounted` guard tripped — the action did
              // nothing at all, silently, every time. Get.context is the
              // navigator's, which is still mounted after the sheet pops.
              final ctx = Get.context;
              Get.back();
              if (ctx == null) return;
              // No save gate: a reminder does not need a saved meter. The
              // backend stores beneficiary_id as optional, and requiring one
              // only added a way for this to fail quietly.
              final repo = GetIt.I<ElectricityBillRepository>();
              await BillReminderCreateSheet.show(
                ctx,
                subtitle:
                    '${payment.providerName} \u00B7 ${payment.meterNumber}',
                defaultTitle:
                    'Pay ${payment.providerName} for ${payment.meterNumber}',
                defaultAmount: payment.amount,
                onSubmit: ({
                  required String title,
                  required String description,
                  required DateTime reminderDate,
                  required double? amount,
                  required bool isRecurring,
                  required String? recurrenceType,
                }) async {
                  final result = await repo.createReminder(
                    title: title,
                    description: description,
                    reminderDate: reminderDate,
                    amount: amount,
                    // Bind to the saved meter when there IS one, otherwise
                    // leave it unbound: beneficiary_id is optional server-side,
                    // and an unbound reminder is far better than no reminder.
                    beneficiaryId: savedBeneficiary?.id ?? '',
                    isRecurring: isRecurring,
                    recurrenceType: recurrenceType == null
                        ? null
                        : ReminderRecurrenceTypeExtension.fromString(
                            recurrenceType),
                  );
                  result.fold(
                    (failure) => throw Exception(failure.message),
                    (_) {},
                  );
                },
              );
            },
          ),
        if (isCompleted)
          BillHistoryAction(
            icon: Icons.autorenew,
            color: const Color(0xFF10B981),
            label: 'Set Auto-Recharge',
            onTap: () async {
              // Auto-recharge genuinely REQUIRES a saved beneficiary — the
              // recurring worker needs a meter to bill against — so the prompt
              // stays. What changes is that it now runs against a context that
              // is still mounted: it used to run against this sheet's own
              // context after Get.back() had disposed it, so it returned null
              // without ever appearing and the action died silently.
              final ctx = Get.context;
              Get.back();
              if (ctx == null) return;
              final beneficiary = await _ensureBeneficiarySaved(
                ctx,
                existing: savedBeneficiary,
                payment: payment,
              );
              if (beneficiary == null) return;
              final repo = GetIt.I<ElectricityBillRepository>();
              await BillAutoRechargeCreateSheet.show(
                ctx,
                subtitle:
                    '${beneficiary.providerName} \u00B7 ${beneficiary.meterNumber}',
                onSubmit: ({
                  required double amount,
                  required String frequency,
                  required int dayOfWeek,
                  required int dayOfMonth,
                  required int executionHour,
                  required int executionMinute,
                }) async {
                  final result = await repo.createAutoRecharge(
                    beneficiaryId: beneficiary.id,
                    amount: amount,
                    currency: 'NGN',
                    frequency:
                        RechargeFrequencyExtension.fromString(frequency),
                    dayOfWeek: frequency == 'weekly' ? dayOfWeek : null,
                    dayOfMonth: frequency == 'monthly' ? dayOfMonth : null,
                    executionHour: executionHour,
                    executionMinute: executionMinute,
                  );
                  result.fold(
                    (failure) => throw Exception(failure.message),
                    (_) {},
                  );
                },
              );
            },
          ),
        BillHistoryAction(
          icon: isSaved ? Icons.edit_note : Icons.bookmark_add_outlined,
          color: const Color(0xFF4E03D0),
          label: isSaved ? 'Rename Meter' : 'Save Meter',
          trailing: isSaved
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Show the saved nickname so the user knows what the
                    // meter is stored as without opening the rename sheet.
                    Flexible(
                      child: Text(
                        savedBeneficiary!.displayName,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Icon(Icons.check_circle,
                        color: const Color(0xFF10B981), size: 14.sp),
                  ],
                )
              : null,
          onTap: () {
            // Navigator's context — Get.back() disposes this sheet's own, so
            // the `context.mounted` check that used to sit here ALWAYS
            // failed and neither sheet below ever opened.
            final ctx = Get.context;
            Get.back();
            if (ctx == null) return;
            if (isSaved) {
              // Rename inline via the shared sheet; no page navigation.
              // The repo's updateBeneficiary persists server-side; every
              // other screen that reads beneficiaries (saved-meters,
              // auto-recharge picker, reminder attach, history sheet on
              // next open) re-queries through getBeneficiaries, so the
              // new nickname propagates without extra plumbing.
              RenameMeterSheet.show(
                ctx,
                beneficiary: savedBeneficiary!,
              );
            } else {
              // Save inline via the sheet — previously we pushed the full
              // add-beneficiary screen, but every field except the
              // nickname is already known (provider, meter number/type,
              // customer name/address came back with the original
              // payment), so an inline sheet matches the rename UX and
              // keeps the user in the history list.
              SaveMeterSheet.show(ctx, payment: payment);
            }
          },
        ),
      ],
    );
  }
}
