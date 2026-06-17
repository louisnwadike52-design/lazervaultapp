import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_history_actions_sheet.dart';
import '../../../../generated/utility-payments.pb.dart' as pb;
import '../../data/datasources/internet_beneficiary_remote_datasource.dart';
import '../../domain/entities/internet_account_validation_entity.dart';
import '../../domain/entities/internet_package_entity.dart';
import '../../domain/entities/internet_payment_entity.dart';
import '../../domain/entities/internet_provider_entity.dart';
import 'save_internet_beneficiary_sheet.dart';

/// Bottom sheet of actions available on a past internet purchase in the
/// recent transactions strip / history list. Mirrors
/// `DataHistoryActionsSheet` — the same five actions, same semantics,
/// gated the same way:
///
///   * View Receipt — always available. Opens the receipt screen
///     with a reconstructed `InternetPaymentEntity`.
///   * Repeat Purchase — always available. Synthesizes a minimal
///     `InternetProviderEntity` from the historical row so the
///     account-input screen can boot without having to round-trip
///     the provider cache.
///   * Set Reminder — **completed-only**. Backend won't let you
///     schedule a renewal against a failed/pending charge.
///   * Set Rollover — **completed-only**. Same reason.
///   * Save / Edit Contact — **completed-only**. We deliberately
///     don't file a beneficiary from a failed buy; that leaves
///     stale contacts the user doesn't recognise.
class InternetHistoryActionsSheet {
  InternetHistoryActionsSheet._();

  static const _bluePrimary = Color(0xFF4E03D0);
  static const _success = Color(0xFF10B981);
  static const _warning = Color(0xFFFB923C);

  static Future<void> show(BuildContext context, pb.BillPayment p) async {
    final providerCode = _providerCodeFor(p.providerId);
    final providerName = _providerDisplay(p);
    final accountNumber = p.customerNumber.trim();
    final packageId = _planOrPackageId(p);
    final planName = _planName(p);
    final isCompleted = p.status.toLowerCase() == 'completed';

    // Probe for an existing saved contact so the "Save" action can
    // flip to an "Edit" affordance with a trailing Saved badge. Only
    // probe for completed payments — the action isn't shown otherwise.
    String? existingId;
    String? existingNickname;
    if (isCompleted) {
      try {
        final ds = GetIt.I<InternetBeneficiaryRemoteDataSource>();
        final list = await ds.getBeneficiaries(providerCode: providerCode);
        final match = list.where(
          (b) =>
              b.accountNumber == accountNumber &&
              (providerCode.isEmpty ||
                  b.providerCode.toUpperCase() == providerCode.toUpperCase()),
        );
        if (match.isNotEmpty) {
          existingId = match.first.id;
          existingNickname = match.first.nickname;
        }
      } catch (_) {
        // Best-effort — proceed without saved-contact detection.
      }
    }

    final isSaved = existingId != null;

    if (!context.mounted) return;

    return BillHistoryActionsSheet.show(
      context,
      title: accountNumber.isEmpty ? 'Internet purchase' : accountNumber,
      subtitle:
          '\u20A6${p.amount.toStringAsFixed(2)} \u00B7 ${_statusLabel(p.status)}',
      actions: [
        BillHistoryAction(
          icon: Icons.receipt_long,
          color: _bluePrimary,
          label: 'View Receipt',
          onTap: () {
            Get.back();
            final payment = _paymentFromProto(p);
            final providerEntity = _synthProvider(providerCode, providerName);
            Get.toNamed(
              AppRoutes.internetPaymentReceipt,
              arguments: <String, dynamic>{
                'payment': payment,
                'provider': providerEntity,
                'accountNumber': accountNumber,
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
            // (package_id + amount > 0), skip the account-input +
            // package-selection screens entirely and drop the user
            // onto the confirmation screen with everything pre-filled.
            // The confirmation screen probes for an existing saved
            // beneficiary / rollover on init and hides the matching
            // toggle when one is found — so a "clean" repeat buy
            // collapses to a single tap.
            if (packageId.isNotEmpty && p.amount > 0) {
              final packageEntity = InternetPackageEntity(
                id: packageId,
                name: planName.isNotEmpty ? planName : packageId,
                variationCode: packageId,
                amount: p.amount,
                providerId: providerEntity.serviceId,
                validity: '',
              );
              final validationEntity = InternetAccountValidationEntity(
                isValid: true,
                // pb.BillPayment doesn't carry the customer name; use
                // the account number as a readable placeholder so the
                // confirm screen's "Customer Name" row renders.
                customerName: accountNumber.isNotEmpty
                    ? accountNumber
                    : '${providerEntity.name} Subscriber',
                accountNumber: accountNumber,
                status: 'repeat_purchase',
                dueAmount: 0,
              );
              Get.toNamed(
                AppRoutes.internetPaymentConfirmation,
                arguments: <String, dynamic>{
                  'provider': providerEntity,
                  'package': packageEntity,
                  'validation': validationEntity,
                  'accountNumber': accountNumber,
                  'isRepeat': true,
                },
              );
              return;
            }
            // Fallback: missing package metadata — start from the
            // account-input screen with the ISP + account pre-filled so
            // the user can pick a fresh package.
            Get.toNamed(
              AppRoutes.internetAccountInput,
              arguments: <String, dynamic>{
                'provider': providerEntity,
                'accountNumber': accountNumber,
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
              final savedOk = await _ensureBeneficiarySaved(
                context,
                isSaved: isSaved,
                accountNumber: accountNumber,
                providerCode: providerCode,
                providerName: providerName,
              );
              if (savedOk == false) return;
              final title = accountNumber.isEmpty
                  ? 'Renew $providerName'
                  : 'Renew $providerName \u00B7 $accountNumber';
              Get.toNamed(
                AppRoutes.internetBillReminderCreate,
                arguments: <String, dynamic>{
                  'title': title,
                  'amount': p.amount > 0 ? p.amount : null,
                  if (packageId.isNotEmpty) 'packageId': packageId,
                  if (planName.isNotEmpty) 'planName': planName,
                },
              );
            },
          ),
        if (isCompleted)
          BillHistoryAction(
            icon: Icons.autorenew,
            color: _success,
            label: 'Set Rollover',
            onTap: () async {
              Get.back();
              final savedOk = await _ensureBeneficiarySaved(
                context,
                isSaved: isSaved,
                accountNumber: accountNumber,
                providerCode: providerCode,
                providerName: providerName,
              );
              if (savedOk == false) return;
              // Route to the dedicated create-rollover screen with the
              // beneficiary pre-filled + locked. Much cleaner than
              // piggybacking on the purchase flow — the user just
              // picks a package and a cadence and is done.
              final ds = GetIt.I<InternetBeneficiaryRemoteDataSource>();
              dynamic beneficiary;
              try {
                final list =
                    await ds.getBeneficiaries(providerCode: providerCode);
                beneficiary = list.firstWhere(
                  (b) =>
                      b.accountNumber == accountNumber &&
                      (providerCode.isEmpty ||
                          b.providerCode.toUpperCase() ==
                              providerCode.toUpperCase()),
                  orElse: () => list.isNotEmpty
                      ? list.first
                      : throw StateError('beneficiary not found'),
                );
              } catch (_) {
                // Beneficiary lookup failed — the user just saved it
                // via `_ensureBeneficiarySaved`, so this is unusual,
                // but we degrade gracefully by opening the create
                // screen unlocked so the user can pick from the
                // dropdown.
                beneficiary = null;
              }
              await Get.toNamed(
                AppRoutes.internetBillRolloverCreate,
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
            label: isSaved ? 'Edit Contact' : 'Save Contact',
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
              await SaveInternetBeneficiarySheet.show(
                context,
                accountNumber: accountNumber,
                providerCode:
                    providerCode.isNotEmpty ? providerCode : 'UNKNOWN',
                providerName:
                    providerName.isNotEmpty ? providerName : 'Unknown',
                existingBeneficiaryId: existingId,
                existingNickname: existingNickname,
              );
            },
          ),
      ],
    );
  }

  /// Save-gate for Reminder + Rollover — both features require a
  /// persisted beneficiary. Returns true when the contact is already
  /// saved or is saved inline; false when the user dismisses the
  /// sheet.
  static Future<bool> _ensureBeneficiarySaved(
    BuildContext context, {
    required bool isSaved,
    required String accountNumber,
    required String providerCode,
    required String providerName,
  }) async {
    if (isSaved) return true;
    if (!context.mounted) return false;
    final saved = await SaveInternetBeneficiarySheet.show(
      context,
      accountNumber: accountNumber,
      providerCode: providerCode.isNotEmpty ? providerCode : 'UNKNOWN',
      providerName: providerName.isNotEmpty ? providerName : 'Unknown',
    );
    return saved == true;
  }

  /// Minimal `InternetProviderEntity` assembled from history-row data.
  /// The account-input screen only reads `serviceId` (for input rules)
  /// and `name`; the other fields are placeholders safe to leave blank.
  static InternetProviderEntity _synthProvider(
      String providerCode, String providerName) {
    return InternetProviderEntity(
      id: providerCode,
      name: providerName,
      serviceId: providerCode.toLowerCase(),
      logoUrl: '',
      isActive: true,
      commissionRate: 0,
    );
  }

  static InternetPaymentEntity _paymentFromProto(pb.BillPayment p) {
    return InternetPaymentEntity(
      id: p.id,
      userId: p.userId,
      accountId: p.accountId,
      billType: p.billType,
      providerId: p.providerId,
      reference: p.reference,
      amount: p.amount,
      status: p.status,
      customerNumber: p.customerNumber,
      metadata: p.metadata,
      createdAt: p.createdAt,
      newBalance: 0,
      renewalDate: '',
    );
  }

  /// VTpass service_id → canonical provider_code. Keeps the recent
  /// transactions bottom sheet aligned with the confirmation screen's
  /// mapping so a saved account filed as `SMILE` matches a history
  /// row whose `providerId` came in lower-cased.
  static String _providerCodeFor(String providerId) {
    final id = providerId.toLowerCase();
    if (id.contains('smile')) return 'SMILE';
    if (id.contains('spectranet')) return 'SPECTRANET';
    if (id.contains('ipnx')) return 'IPNX';
    if (id.contains('swift')) return 'SWIFT';
    return providerId.toUpperCase();
  }

  static String _providerDisplay(pb.BillPayment p) {
    if (p.providerId.isEmpty) return 'Internet';
    final id = p.providerId.toLowerCase();
    if (id.contains('smile')) return 'Smile';
    if (id.contains('spectranet')) return 'Spectranet';
    if (id.contains('ipnx')) return 'IPNX';
    if (id.contains('swift')) return 'Swift';
    return p.providerId.toUpperCase();
  }

  static String _planOrPackageId(pb.BillPayment p) {
    if (p.metadata.isEmpty) return '';
    try {
      final m = jsonDecode(p.metadata) as Map<String, dynamic>;
      final v = m['package_id'] ?? m['variation_id'];
      return v == null ? '' : v.toString();
    } catch (_) {
      return '';
    }
  }

  static String _planName(pb.BillPayment p) {
    if (p.metadata.isEmpty) return '';
    try {
      final m = jsonDecode(p.metadata) as Map<String, dynamic>;
      final v = m['plan_name'] ?? m['package_name'];
      return v == null ? '' : v.toString();
    } catch (_) {
      return '';
    }
  }

  static String _statusLabel(String status) {
    final s = status.toLowerCase();
    if (s == 'completed') return 'Completed';
    if (s == 'failed') return 'Failed';
    if (s == 'refunded') return 'Refunded';
    return 'Pending';
  }
}
