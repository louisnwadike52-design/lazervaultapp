import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_history_actions_sheet.dart';
import '../../data/datasources/cable_tv_beneficiary_remote_datasource.dart';
import '../../domain/entities/cable_tv_beneficiary.dart';
import '../../domain/entities/cable_tv_payment_entity.dart';
import '../../domain/entities/cable_tv_provider_entity.dart';
import '../../domain/entities/smart_card_validation_entity.dart';
import '../../domain/entities/tv_package_entity.dart';
import 'save_cable_tv_beneficiary_sheet.dart';

/// Bottom sheet of actions available on a past cable TV purchase in
/// either the recent-transactions strip or the history list. Mirrors
/// `DataHistoryActionsSheet` / `InternetHistoryActionsSheet`:
///
///   * View Receipt — always available.
///   * Repeat Purchase — always available; fast-paths to confirmation
///     when the payment metadata carries enough to skip re-validation.
///   * Set Reminder — **completed-only**. Gated by ensure-saved.
///   * Set Auto-Renew — **completed-only**. Gated by ensure-saved.
///   * Save / Edit Smart Card — **completed-only**.
class CableTVHistoryActionsSheet {
  CableTVHistoryActionsSheet._();

  static const _bluePrimary = Color(0xFF4E03D0);
  static const _success = Color(0xFF10B981);
  static const _warning = Color(0xFFFB923C);

  static Future<void> show(
    BuildContext context,
    CableTVPaymentEntity p,
  ) async {
    final providerCode = _providerCodeFor(p.providerId);
    final providerName = _providerDisplay(p);
    final smartCardNumber = p.customerNumber.trim();
    final variationCode = _variationCode(p);
    final packageName = _packageName(p);
    final isCompleted = p.isCompleted;

    // Probe for an existing saved contact so the "Save" action can
    // flip to an "Edit" affordance with a trailing Saved badge. Only
    // probe for completed payments — the action isn't shown otherwise.
    String? existingId;
    String? existingNickname;
    CableTVBeneficiary? existingBeneficiary;
    if (isCompleted) {
      try {
        final ds = GetIt.I<CableTVBeneficiaryRemoteDataSource>();
        final list = await ds.getBeneficiaries();
        for (final b in list) {
          if (b.smartCardNumber == smartCardNumber &&
              (providerCode.isEmpty ||
                  b.providerCode.toLowerCase() ==
                      providerCode.toLowerCase())) {
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
      title: smartCardNumber.isEmpty ? 'Cable TV payment' : smartCardNumber,
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
              AppRoutes.cableTVPaymentReceipt,
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
            final providerEntity = _synthProvider(providerCode, providerName);
            // Fast-path: if the original row carries enough metadata
            // (variation_code + amount > 0), skip the smart-card-input +
            // package-selection screens and drop the user onto the
            // confirmation screen with everything pre-filled. The
            // confirmation screen probes for an existing saved
            // beneficiary / auto-renew on init and hides matching
            // toggles — so a "clean" repeat buy collapses to a single
            // tap.
            if (variationCode.isNotEmpty && p.amount > 0) {
              final packageEntity = TVPackageEntity(
                id: variationCode,
                name: packageName.isNotEmpty ? packageName : variationCode,
                variationCode: variationCode,
                amount: p.amount,
                providerId: providerEntity.serviceId,
                validity: '',
              );
              final validationEntity = SmartCardValidationEntity(
                isValid: true,
                // `pb.BillPayment` doesn't always carry the customer
                // name; fall back to the smart card number so the
                // confirm screen's "Customer Name" row still renders.
                customerName: p.customerName.isNotEmpty
                    ? p.customerName
                    : (smartCardNumber.isNotEmpty
                        ? smartCardNumber
                        : '${providerEntity.name} Subscriber'),
                smartCardNumber: smartCardNumber,
                currentPackage: packageName,
                renewalDate: '',
                dueDate: '',
              );
              Get.toNamed(
                AppRoutes.cableTVPaymentConfirmation,
                arguments: <String, dynamic>{
                  'provider': providerEntity,
                  'package': packageEntity,
                  'validation': validationEntity,
                  'smartCardNumber': smartCardNumber,
                  'isRepeat': true,
                },
              );
              return;
            }
            // Fallback: missing package metadata — start from the
            // smart-card-input screen with provider + smart card
            // pre-filled so the user can pick a fresh package.
            Get.toNamed(
              AppRoutes.cableTVSmartCardInput,
              arguments: <String, dynamic>{
                'provider': providerEntity,
                'smartCardNumber': smartCardNumber,
                'providerCode': providerCode,
                'isRepeat': true,
              },
            );
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
                smartCardNumber: smartCardNumber,
                providerCode: providerCode,
                providerName: providerName,
                customerName: p.customerName,
              );
              if (saved == false) return;
              final title = smartCardNumber.isEmpty
                  ? 'Renew $providerName'
                  : 'Renew $providerName · $smartCardNumber';
              Get.toNamed(
                AppRoutes.cableTVReminderCreate,
                arguments: <String, dynamic>{
                  'title': title,
                  'amount': p.amount > 0 ? p.amount : null,
                  if (variationCode.isNotEmpty) 'packageId': variationCode,
                  if (packageName.isNotEmpty) 'planName': packageName,
                },
              );
            },
          ),
        if (isCompleted)
          BillHistoryAction(
            icon: Icons.autorenew,
            color: _success,
            label: 'Set Auto-Renew',
            onTap: () async {
              Get.back();
              final saved = await _ensureBeneficiarySaved(
                context,
                existing: existingBeneficiary,
                smartCardNumber: smartCardNumber,
                providerCode: providerCode,
                providerName: providerName,
                customerName: p.customerName,
              );
              if (saved == false) return;
              // Route to the dedicated create auto-recharge screen with
              // beneficiary pre-filled + locked. User just picks a
              // package + cadence.
              final ds = GetIt.I<CableTVBeneficiaryRemoteDataSource>();
              CableTVBeneficiary? beneficiary = existingBeneficiary;
              if (beneficiary == null) {
                try {
                  final list = await ds.getBeneficiaries();
                  for (final b in list) {
                    if (b.smartCardNumber == smartCardNumber &&
                        (providerCode.isEmpty ||
                            b.providerCode.toLowerCase() ==
                                providerCode.toLowerCase())) {
                      beneficiary = b;
                      break;
                    }
                  }
                } catch (_) {
                  // Degrade gracefully — open the create screen
                  // unlocked so the user can pick from the dropdown.
                }
              }
              await Get.toNamed(
                AppRoutes.cableTVAutoRechargeCreate,
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
            label: isSaved ? 'Edit Smart Card' : 'Save Smart Card',
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
              await SaveCableTVBeneficiarySheet.show(
                context,
                smartCardNumber: smartCardNumber,
                providerCode: providerCode.isNotEmpty ? providerCode : 'UNKNOWN',
                providerName: providerName.isNotEmpty ? providerName : 'Unknown',
                customerName: p.customerName,
                existingBeneficiaryId: existingId,
                existingNickname: existingNickname,
              );
            },
          ),
      ],
    );
  }

  /// Save-gate for Reminder + Auto-Renew — both require a persisted
  /// beneficiary. Returns true when the contact is already saved or
  /// is saved inline; false when the user dismisses the sheet.
  static Future<bool> _ensureBeneficiarySaved(
    BuildContext context, {
    required CableTVBeneficiary? existing,
    required String smartCardNumber,
    required String providerCode,
    required String providerName,
    required String customerName,
  }) async {
    if (existing != null) return true;
    if (!context.mounted) return false;
    final saved = await SaveCableTVBeneficiarySheet.show(
      context,
      smartCardNumber: smartCardNumber,
      providerCode: providerCode.isNotEmpty ? providerCode : 'UNKNOWN',
      providerName: providerName.isNotEmpty ? providerName : 'Unknown',
      customerName: customerName,
    );
    return saved == true;
  }

  /// Minimal `CableTVProviderEntity` assembled from history-row data.
  /// The smart-card-input screen only reads `serviceId` (for API calls)
  /// and `name`; other fields are placeholders safe to leave blank.
  static CableTVProviderEntity _synthProvider(
      String providerCode, String providerName) {
    return CableTVProviderEntity(
      id: providerCode,
      name: providerName,
      serviceId: providerCode.toLowerCase(),
      logoUrl: '',
      isActive: true,
      commissionRate: 0,
    );
  }

  /// VTpass service_id → canonical provider_code. Keeps the actions
  /// sheet aligned with the confirmation screen's mapping so a saved
  /// contact filed as `dstv` matches a history row whose `providerId`
  /// came in as `DSTV`.
  static String _providerCodeFor(String providerId) {
    final id = providerId.toLowerCase();
    if (id.contains('dstv')) return 'dstv';
    if (id.contains('gotv')) return 'gotv';
    if (id.contains('startimes')) return 'startimes';
    if (id.contains('showmax')) return 'showmax';
    return providerId.toLowerCase();
  }

  static String _providerDisplay(CableTVPaymentEntity p) {
    if (p.providerId.isEmpty) return 'Cable TV';
    final id = p.providerId.toLowerCase();
    if (id.contains('dstv')) return 'DStv';
    if (id.contains('gotv')) return 'GOtv';
    if (id.contains('startimes')) return 'StarTimes';
    if (id.contains('showmax')) return 'Showmax';
    return p.providerId.toUpperCase();
  }

  static String _variationCode(CableTVPaymentEntity p) {
    if (p.metadata.isEmpty) return '';
    try {
      final m = jsonDecode(p.metadata) as Map<String, dynamic>;
      final v = m['variation_code'] ?? m['package_id'] ?? m['variation_id'];
      return v == null ? '' : v.toString();
    } catch (_) {
      return '';
    }
  }

  static String _packageName(CableTVPaymentEntity p) {
    if (p.metadata.isEmpty) return '';
    try {
      final m = jsonDecode(p.metadata) as Map<String, dynamic>;
      final v = m['package_name'] ?? m['plan_name'] ?? m['variation_name'];
      return v == null ? '' : v.toString();
    } catch (_) {
      return '';
    }
  }

  static String _statusLabel(CableTVPaymentEntity p) {
    if (p.isCompleted) return 'Completed';
    if (p.isFailed) return 'Failed';
    return 'Pending';
  }
}
