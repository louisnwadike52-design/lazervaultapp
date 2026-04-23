import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/services/locale_manager.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_history_actions_sheet.dart';
import '../../data/datasources/data_beneficiary_remote_datasource.dart';
import '../../domain/entities/data_beneficiary.dart';
import '../../domain/entities/data_purchase_entity.dart';
import 'save_data_beneficiary_sheet.dart';

class DataHistoryActionsSheet {
  DataHistoryActionsSheet._();

  /// Resolve a user-facing carrier name from a network code. Keeps
  /// beneficiaries from being persisted with a literal "Unknown" string
  /// when the history row didn't carry the brand name — the backend
  /// accepts any value, so we have to guard the save path. Returns an
  /// empty string when we can't infer a carrier, and the caller then
  /// refuses to save rather than storing an ugly placeholder.
  static String _resolveNetworkName(String networkCode, String networkName) {
    if (networkName.isNotEmpty &&
        networkName.toLowerCase() != 'unknown') {
      return networkName;
    }
    final code = networkCode.toUpperCase().replaceAll('-DATA', '');
    switch (code) {
      case 'MTN':
        return 'MTN';
      case 'AIRTEL':
        return 'Airtel';
      case 'GLO':
        return 'Glo';
      case 'ETISALAT':
      case '9MOBILE':
        return '9mobile';
      default:
        return '';
    }
  }

  static Future<void> show(
    BuildContext context,
    DataPurchaseEntity p, {
    String countryCode = 'NG',
  }) async {
    // Prefer the entity's own `isInternational` (derived from
    // `bill_type` set by the backend) so callers don't have to
    // second-guess. `countryCode` stays as a hint for downstream
    // arguments (save-contact sheet / reminder create) where a
    // real ISO code is useful.
    final isIntl = p.isInternational || countryCode.toUpperCase() != 'NG';
    final networkCode = p.networkCode;
    final networkName = p.networkName;
    // Post-purchase actions (Set Reminder / Set Rollover / Save
    // Contact) are only meaningful when the buy actually succeeded.
    // Pending/failed rows keep View Receipt + Repeat Purchase only.
    final isCompleted = p.isCompleted;

    // Probe for an existing saved contact only when the extended
    // actions will actually render — skip the round-trip otherwise.
    String? existingId;
    String? existingNickname;
    if (isCompleted) {
      try {
        final ds = GetIt.I<DataBeneficiaryRemoteDataSource>();
        final beneficiaries = await ds.getBeneficiaries(
          networkCode: networkCode.isNotEmpty ? networkCode : null,
        );
        final match = beneficiaries.where(
          (b) =>
              b.phoneNumber == p.phoneNumber &&
              (networkCode.isEmpty ||
                  b.networkCode.toLowerCase() == networkCode.toLowerCase()),
        );
        if (match.isNotEmpty) {
          existingId = match.first.id;
          existingNickname = match.first.nickname;
        }
      } catch (_) {
        // Proceed without saved-contact detection
      }
    }

    final isSaved = existingId != null;

    if (!context.mounted) return;

    // Render the wallet-debit amount in the currency the user was
    // actually charged in (active locale / NGN by default), never in
    // Reloadly's sender wallet currency.
    final active = GetIt.I<LocaleManager>().currentCurrency;
    final cur = p.resolvedCurrency.isNotEmpty ? p.resolvedCurrency : active;
    final priceLabel = '$cur ${p.amount.toStringAsFixed(2)}';

    return BillHistoryActionsSheet.show(
      context,
      title: p.phoneNumber.isEmpty ? 'Data purchase' : p.phoneNumber,
      subtitle: '$priceLabel \u00B7 ${_statusLabel(p)}',
      actions: [
        BillHistoryAction(
          icon: Icons.receipt_long,
          color: const Color(0xFF4E03D0),
          label: 'View Receipt',
          onTap: () {
            Get.back();
            // One receipt screen for both local and intl history rows —
            // the receipt widget reads `purchase.isInternational` and
            // folds the FX / operator / country metadata into the
            // details card. Keeps QR + download + share + save-contact
            // behaviour identical across scopes; intl-specific fields
            // come from the backend `metadata` JSON on the bill row.
            Get.toNamed(
              AppRoutes.dataBundlesPaymentReceipt,
              arguments: {
                'purchase': p,
                'networkName': isIntl ? _countryLabelFor(p) : networkName,
                'network': networkCode,
                'planName': p.dataPlan.isNotEmpty ? p.dataPlan : null,
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
            if (isIntl) {
              // Repeat intl-data goes STRAIGHT to checkout with the
              // previously-purchased bundle rebuilt from the transaction's
              // metadata (country, operator, dest amount, FX). The
              // checkout screen knows how to hydrate its entities from
              // these raw fields — see IntlDataCheckoutScreen.initState
              // for the construction logic. This avoids making the user
              // re-pick country→operator→bundle just to repay the same
              // combo they already confirmed once. Back from checkout
              // pops to history (correct — there's no selection stack
              // to walk through).
              final meta = p.metadataMap;
              Get.toNamed(
                AppRoutes.intlDataCheckout,
                arguments: {
                  'isRepeat': true,
                  'phoneNumber': p.phoneNumber,
                  'amount': p.amount,
                  'countryCode': countryCode,
                  'destAmount': p.destAmount ?? 0,
                  'destCurrency': p.destCurrency,
                  'fxRate': (meta['fx_rate_used'] ?? meta['fx_rate']) is num
                      ? (meta['fx_rate_used'] ?? meta['fx_rate']) as num
                      : 0,
                  'operatorId': (meta['reloadly_operator_id'] ?? meta['operator_id'] ?? '').toString(),
                  'operatorName': (meta['operator_name'] ?? '').toString(),
                  'bundleDescription': (meta['bundle_description'] ?? meta['plan_name'] ?? '').toString(),
                },
              );
            } else if (networkCode.isNotEmpty) {
              Get.toNamed(
                AppRoutes.dataBundlesPlanSelection,
                arguments: {
                  'network': networkCode,
                  'networkName': networkName,
                  'phoneNumber': p.phoneNumber,
                  'isRepeat': true,
                },
              );
            } else {
              Get.toNamed(
                AppRoutes.dataBundlesHome,
                arguments: {
                  'isRepeat': true,
                  'phoneNumber': p.phoneNumber,
                },
              );
            }
          },
        ),
        if (isCompleted)
          BillHistoryAction(
            icon: Icons.notifications_active,
            color: const Color(0xFFFB923C),
            label: 'Set Reminder',
            onTap: () async {
              Get.back();
              final savedOk = await _ensureBeneficiarySaved(
                context,
                isSaved: isSaved,
                phoneNumber: p.phoneNumber,
                networkCode: networkCode,
                networkName: networkName,
                countryCode: countryCode,
              );
              if (savedOk == false) return;
              Get.toNamed(
                AppRoutes.dataBundlesReminderCreate,
                arguments: {
                  'phoneNumber': p.phoneNumber,
                  'amount': p.amount,
                  'title': p.phoneNumber.isEmpty
                      ? 'Buy data'
                      : 'Buy data for ${p.phoneNumber}',
                },
              );
            },
          ),
        if (isCompleted)
          BillHistoryAction(
            icon: Icons.autorenew,
            color: const Color(0xFF10B981),
            label: 'Set Rollover',
            onTap: () async {
            Get.back();
            // Ensure beneficiary is saved first (same pattern as Set Reminder).
            final savedOk = await _ensureBeneficiarySaved(
              context,
              isSaved: isSaved,
              phoneNumber: p.phoneNumber,
              networkCode: networkCode,
              networkName: networkName,
              countryCode: countryCode,
            );
            if (savedOk == false) return;
            // Re-fetch the saved beneficiary so we have a real entity.
            DataBeneficiary? beneficiary;
            try {
              final ds = GetIt.I<DataBeneficiaryRemoteDataSource>();
              final list = await ds.getBeneficiaries(
                networkCode: networkCode.isNotEmpty ? networkCode : null,
              );
              beneficiary = list.cast<DataBeneficiary?>().firstWhere(
                (b) =>
                    b != null &&
                    b.phoneNumber == p.phoneNumber &&
                    (networkCode.isEmpty ||
                        b.networkCode.toLowerCase() ==
                            networkCode.toLowerCase()),
                orElse: () => null,
              );
            } catch (_) {}
            if (beneficiary != null) {
              Get.toNamed(
                AppRoutes.dataBundlesRolloverCreate,
                arguments: {
                  'beneficiary': beneficiary,
                  'locked': true,
                },
              );
            } else {
              Get.toNamed(AppRoutes.dataBundlesRolloverCreate);
            }
          },
        ),
        if (isCompleted)
          BillHistoryAction(
            icon: isSaved ? Icons.edit_note : Icons.bookmark_add_outlined,
            color: const Color(0xFF4E03D0),
            label: isSaved ? 'Edit Contact' : 'Save Contact',
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
              final resolvedName =
                  _resolveNetworkName(networkCode, networkName);
              if (networkCode.isEmpty && resolvedName.isEmpty) {
                // Refuse to save when we can't identify the carrier —
                // persisting a literal "Unknown" string pollutes the
                // saved-contacts list and breaks "Buy Data" later on
                // (the plan-selection screen keys off networkCode).
                Get.snackbar(
                  'Cannot save',
                  "We couldn't identify the network for this number. "
                      'Save it from the buy-data flow instead.',
                  backgroundColor:
                      const Color(0xFFEF4444).withValues(alpha: 0.9),
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                  duration: const Duration(seconds: 3),
                );
                return;
              }
              await SaveDataBeneficiarySheet.show(
                context,
                phoneNumber: p.phoneNumber,
                networkCode: networkCode,
                networkName: resolvedName,
                countryCode: countryCode,
                existingBeneficiaryId: existingId,
                existingNickname: existingNickname,
              );
            },
          ),
      ],
    );
  }

  /// If the contact is not yet saved, shows the save-beneficiary sheet inline.
  /// Returns `true` when the contact is already saved or was just saved
  /// successfully, `false` if the user dismissed the save sheet.
  static Future<bool> _ensureBeneficiarySaved(
    BuildContext context, {
    required bool isSaved,
    required String phoneNumber,
    required String networkCode,
    required String networkName,
    required String countryCode,
  }) async {
    if (isSaved) return true;
    if (!context.mounted) return false;
    final resolvedName = _resolveNetworkName(networkCode, networkName);
    if (networkCode.isEmpty && resolvedName.isEmpty) return false;
    final saved = await SaveDataBeneficiarySheet.show(
      context,
      phoneNumber: phoneNumber,
      networkCode: networkCode,
      networkName: resolvedName,
      countryCode: countryCode,
    );
    return saved == true;
  }

  static String _statusLabel(DataPurchaseEntity p) {
    if (p.isCompleted) return 'Completed';
    if (p.isFailed) return 'Failed';
    return 'Pending';
  }

  /// Best-effort country label for an intl row to show under the network
  /// column on the receipt — reads the country name out of the backend
  /// `metadata` blob, falls back to the destination currency, then
  /// "International Data" as a last resort so the header never renders
  /// a cold blank.
  static String _countryLabelFor(DataPurchaseEntity p) {
    final meta = p.metadataMap;
    final name = meta['country_name'] ?? meta['countryName'];
    if (name is String && name.isNotEmpty) return name;
    final code = meta['country_code'] ?? meta['countryCode'];
    if (code is String && code.isNotEmpty) return code;
    if (p.destCurrency.isNotEmpty) return '${p.destCurrency} Data';
    return 'International Data';
  }
}
