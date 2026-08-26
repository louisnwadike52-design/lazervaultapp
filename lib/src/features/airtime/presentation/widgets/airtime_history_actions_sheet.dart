import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_history_actions_sheet.dart';
import '../../../../../core/widgets/bill_reminder_create_sheet.dart';
import '../../data/datasources/intl_airtime_remote_datasource.dart';
import '../../domain/entities/airtime_transaction.dart';
import '../../domain/entities/intl_airtime_country.dart';
import '../../domain/entities/network_provider.dart';
import '../../domain/repositories/airtime_repository.dart';
import 'save_airtime_beneficiary_sheet.dart';

/// Bottom sheet shown when an airtime history item is tapped.
///
/// Delegates rendering to the shared [BillHistoryActionsSheet] while
/// preserving all airtime-specific routing logic (domestic/intl/a2c).
class AirtimeHistoryActionsSheet {
  AirtimeHistoryActionsSheet._();

  static Future<void> show(BuildContext context, AirtimeTransaction t) async {
    // Set Reminder + Save Contact only make sense against a buy that
    // actually succeeded. Pending/failed rows keep View Receipt +
    // Repeat Purchase only — matches data/internet policy.
    final bool isCompleted = t.status == AirtimeTransactionStatus.completed;
    final bool canSaveContact = !t.isAirtimeToCash;

    String? existingId;
    String? existingNickname;
    if (canSaveContact && isCompleted) {
      try {
        final repo = GetIt.I<AirtimeRepository>();
        // Fetch UNFILTERED and match locally. The server stores network codes
        // upper-cased while this passed the Dart enum name ("mtn"), and the
        // filter was a case-sensitive equality — so every saved contact came
        // back empty and the sheet offered "Save Contact" for numbers already
        // saved. Matching on the phone number here is also simply the right
        // test: it is the number that identifies the contact.
        final beneficiaries = await repo.getAirtimeBeneficiaries();
        final wanted = _digitsOnly(t.recipientPhoneNumber);
        for (final b in beneficiaries) {
          if (_digitsOnly(b.phoneNumber) == wanted) {
            existingId = b.id;
            existingNickname = b.nickname;
            break;
          }
        }
      } catch (e) {
        // Detection failed — the sheet still works, but say so rather than
        // silently presenting an already-saved contact as unsaved.
        debugPrint('[AirtimeActions] saved-contact lookup failed: $e');
      }
    }

    final isSaved = existingId != null;

    if (!context.mounted) return;

    return BillHistoryActionsSheet.show(
      context,
      title: t.displayTitle,
      subtitle:
          '${t.recipientPhoneNumber} \u00B7 ${t.currency} ${t.amount.toStringAsFixed(2)} \u00B7 ${t.status.displayName}',
      actions: [
        BillHistoryAction(
          icon: Icons.receipt_long,
          color: const Color(0xFF4E03D0),
          label: 'View Receipt',
          onTap: () {
            Get.back();
            _navigateReceipt(t);
          },
        ),
        BillHistoryAction(
          icon: Icons.replay,
          color: const Color(0xFF10B981),
          label: t.isAirtimeToCash ? 'Repeat Conversion' : 'Repeat Purchase',
          onTap: () {
            Get.back();
            _navigateRepeat(t);
          },
        ),
        if (isCompleted)
          BillHistoryAction(
            icon: Icons.notifications_active,
            color: const Color(0xFFFB923C),
            label: 'Set Reminder',
            onTap: () async {
              // Capture the NAVIGATOR's context before Get.back() disposes
              // this sheet's own. The reminder sheet is a modal route hosted
              // by whatever context it is handed, and the `context.mounted`
              // guards here were testing the dead one — so this action
              // returned before it could show anything at all.
              final ctx = Get.context;
              Get.back();
              if (ctx == null) return;
              // Go straight to the reminder sheet. This used to force the
              // save-contact sheet open first and abort the whole action if the
              // user dismissed it — so "Set Reminder" showed a nickname form and
              // then silently did nothing. A reminder does NOT need a saved
              // contact: the backend stores beneficiary_id as an optional
              // varchar defaulting to '', and only the title is required.
              final repo = GetIt.I<AirtimeRepository>();
              // Bind the reminder to the saved beneficiary so a recurring
              // reminder can fire-and-buy against it later.
              //
              // Reuse the lookup already done above where it ran, and match on
              // digits — never on raw string equality. The server stores
              // "+2347067334850" where the transaction carries "07067334850",
              // so an equality test never matched and every reminder was
              // created unbound, even for a contact that was plainly saved.
              String? beneficiaryId = existingId;
              if (beneficiaryId == null) {
                try {
                  final bens = await repo.getAirtimeBeneficiaries();
                  final wanted = _digitsOnly(t.recipientPhoneNumber);
                  for (final b in bens) {
                    if (_digitsOnly(b.phoneNumber) == wanted) {
                      beneficiaryId = b.id;
                      break;
                    }
                  }
                } catch (e) {
                  // Unbound is a valid reminder — beneficiary_id is optional
                  // server-side — so carry on rather than failing the action.
                  debugPrint('[AirtimeActions] reminder beneficiary bind failed: $e');
                }
              }
              await BillReminderCreateSheet.show(
                ctx,
                subtitle:
                    '${t.networkProvider.displayName} \u00B7 ${t.recipientPhoneNumber}',
                defaultTitle: 'Buy airtime for ${t.recipientPhoneNumber}',
                defaultAmount: t.amount,
                onSubmit: ({
                  required String title,
                  required String description,
                  required DateTime reminderDate,
                  required double? amount,
                  required bool isRecurring,
                  required String? recurrenceType,
                }) async {
                  await repo.createAirtimeReminder(
                    beneficiaryId: beneficiaryId ?? '',
                    title: title,
                    description: description,
                    reminderDate: reminderDate.toUtc().toIso8601String(),
                    amount: amount,
                    currency: 'NGN',
                    isRecurring: isRecurring,
                    recurrenceType: recurrenceType,
                  );
                },
              );
            },
          ),
        if (canSaveContact && isCompleted)
          BillHistoryAction(
            icon: isSaved ? Icons.edit_note : Icons.bookmark_add_outlined,
            color: const Color(0xFF4E03D0),
            label: isSaved ? 'Edit Contact' : 'Save Contact',
            // Surface the existing nickname (or just "Saved" when no
            // nickname is set) so the user knows what they'd be editing
            // without opening the sheet first.
            subtitle: isSaved
                ? ((existingNickname?.isNotEmpty ?? false)
                    ? 'Saved as "${existingNickname!}"'
                    : 'Already saved')
                : null,
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
              // Navigator's context — Get.back() disposes this sheet's own,
              // and a disposed context cannot host the save modal.
              final ctx = Get.context;
              Get.back();
              if (ctx == null) return;
              await SaveAirtimeBeneficiarySheet.show(
                ctx,
                phoneNumber: t.recipientPhoneNumber,
                networkCode: t.networkProvider.name,
                networkName: t.networkProvider.displayName,
                countryCode: t.isInternational
                    ? (t.metadata?['country_code'] ??
                            t.metadata?['countryCode'] ??
                            'NG')
                        .toString()
                    : 'NG',
                existingBeneficiaryId: existingId,
                existingNickname: existingNickname,
              );
            },
          ),
      ],
    );
  }

  /// Compares phone numbers by their digits alone, so a stored "07067334850"
  /// still matches a "+2347067334850" (or a spaced/hyphenated) rendering of the
  /// same line. Only the trailing 10 digits are significant for NG numbers.
  static String _digitsOnly(String raw) {
    final digits = raw.replaceAll(RegExp(r'[^0-9]'), '');
    return digits.length > 10 ? digits.substring(digits.length - 10) : digits;
  }

  static void _navigateReceipt(AirtimeTransaction t) {
    if (t.isInternational) {
      Get.toNamed(
        AppRoutes.intlAirtimeReceipt,
        arguments: {'transaction': t, 'fromHistory': true},
      );
      return;
    }
    if (t.isAirtimeToCash) {
      Get.toNamed(
        AppRoutes.airtimeToCashResult,
        arguments: {'transaction': t, 'fromHistory': true},
      );
      return;
    }
    Get.toNamed(
      AppRoutes.airtimePaymentConfirmation,
      arguments: {'transaction': t, 'fromHistory': true},
    );
  }

  static Future<void> _navigateRepeat(AirtimeTransaction t) async {
    final meta = t.metadata ?? const {};

    if (t.isInternational) {
      final countryCode = (meta['country_code'] ?? meta['countryCode'])
              ?.toString()
              .toUpperCase() ??
          '';
      // Original transaction is missing country info entirely (legacy
      // row, or backend dropped the field). Don't navigate to a screen
      // that's guaranteed to fail-state — guide the user to the country
      // picker manually so the repeat still completes.
      if (countryCode.isEmpty) {
        Get.toNamed(AppRoutes.intlAirtimeCountrySelection);
        Get.snackbar(
          'Country info missing',
          'This older transaction doesn\'t have a country tag. Pick the destination country to continue.',
          backgroundColor:
              const Color(0xFFFB923C).withValues(alpha: 0.92),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 4),
        );
        return;
      }
      IntlAirtimeCountry? country;
      if (countryCode.isNotEmpty) {
        try {
          final ds = GetIt.I<IntlAirtimeRemoteDatasource>();
          final list = await ds.getCountries();
          country = list.firstWhere(
            (c) => c.countryCode.toUpperCase() == countryCode,
            orElse: () => IntlAirtimeCountry.empty(),
          );
          if (country.countryCode.isEmpty) country = null;
        } catch (_) {
          country = null;
        }
      }
      // Catalog fetch failed (offline / API down) or returned no match —
      // build a fallback IntlAirtimeCountry from the metadata captured
      // when the original purchase succeeded so the user can repeat
      // even when the live catalog is unavailable. Only the
      // [countryCode] is strictly required; everything else falls back
      // to whatever the metadata carries (or sensible defaults).
      if (country == null && countryCode.isNotEmpty) {
        country = IntlAirtimeCountry(
          id: countryCode.toLowerCase(),
          countryCode: countryCode,
          countryName: (meta['country_name'] ?? meta['countryName'])
                  ?.toString() ??
              countryCode,
          dialCode: (meta['dial_code'] ?? meta['dialCode'])
                  ?.toString() ??
              '',
          currencyCode: t.currency,
          currencySymbol: (meta['currency_symbol'] ?? meta['currencySymbol'])
                  ?.toString() ??
              '',
          flagEmoji: (meta['country_flag'] ??
                  meta['countryFlag'] ??
                  meta['flag'])
                  ?.toString() ??
              '',
          isActive: true,
        );
      }
      Get.toNamed(
        AppRoutes.intlAirtimePurchase,
        arguments: {
          'isRepeat': true,
          if (country != null) 'country': country,
          'countryCode': countryCode,
          'operatorName':
              (meta['operator_name'] ?? meta['operatorName'])?.toString(),
          'reloadlyOperatorId':
              (meta['reloadly_operator_id'] ?? meta['reloadlyOperatorId'])
                  ?.toString(),
          'phoneNumber': t.recipientPhoneNumber,
          'amount': t.amount,
          'destCurrency': t.currency,
        },
      );
      return;
    }

    if (t.isAirtimeToCash) {
      Get.toNamed(
        AppRoutes.airtimeToCashProviderSelect,
        arguments: {
          'isRepeat': true,
          'phoneNumber': t.recipientPhoneNumber,
          'network': t.networkProvider.name,
          'amount': t.amount,
        },
      );
      return;
    }

    // Repeat lands on the MAIN quick-buy (Buy tab) with everything
    // prefilled — the separate legacy purchase flow was removed.
    Get.toNamed(
      AppRoutes.airtime,
      preventDuplicates: false,
      arguments: {
        'phoneNumber': t.recipientPhoneNumber,
        'amount': t.amount,
        'networkCode': t.networkProvider.name,
      },
    );
  }
}
