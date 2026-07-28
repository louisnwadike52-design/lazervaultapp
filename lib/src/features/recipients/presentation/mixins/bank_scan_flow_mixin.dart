import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'package:lazervault/core/config/country_config.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/ai_scan_to_pay/domain/services/on_device_scan_extractor.dart';
import 'package:lazervault/src/features/ai_scan_to_pay/presentation/widgets/live_scan_camera_view.dart';
import 'package:lazervault/src/features/recipients/data/datasources/bank_scan_datasource.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/data/services/bank_scan_upload_service.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/scan_bank_details_modal.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/scan_history_sheet.dart';

/// The shared "Scan Account" pipeline: live camera → OCR (`/scan/bank-details`)
/// → verify sheet → route into send-funds. Extracted from `select_recipients`
/// so BOTH hosts of the account-number box run the identical flow with no
/// duplication:
///
///  * `SelectRecipients` (short-flow embed + the strip's "Scan History" tile)
///  * `AddRecipientScreen` (long-flow standalone Add-Recipient screen)
///
/// The host supplies two things via the abstract members below: the active
/// [scanCountry] and the single routing sink [onScanRecipientResolved]. Every
/// scan branch (bank / resolved-user / internal @user / phone / history)
/// funnels through that one sink, so the host decides whether that means an
/// inline short-flow send or a long-flow navigation.
mixin BankScanFlowMixin<T extends StatefulWidget> on State<T> {
  /// Active country (ISO code, e.g. 'NG'). Both hosts already track this from
  /// [LocaleManager]; drives currency + OCR locale.
  String get scanCountry;

  /// The single routing sink for a scanned/verified recipient. The host maps
  /// this to its send flow (short-inline vs long-navigate).
  void onScanRecipientResolved(
    RecipientModel recipient, {
    Map<String, dynamic>? sendFundsArgs,
  });

  /// Build a [BankScanDataSource] pointed at the gateway ROOT.
  ///
  /// The OCR + history routes live at the gateway ROOT (`/scan/bank-details`,
  /// `/scan/history`), NOT under `/chat`. CHAT_GATEWAY_URL ends in `/chat`, so
  /// we MUST strip it — otherwise the datasource posts to `/chat/scan/...`
  /// which 404s. Shared by the live scan and the history sheet so both hit the
  /// same base.
  BankScanDataSource _buildBankScanDataSource() {
    final gatewayUrl =
        (dotenv.env['CHAT_GATEWAY_URL'] ?? endpointRegistry.httpChatAgent)
            .replaceAll(RegExp(r'/chat/?$'), '');
    return BankScanDataSource(
      baseUrl: gatewayUrl,
      secureStorage: GetIt.I<SecureStorageService>(),
      uploadService: GetIt.I<BankScanUploadService>(),
    );
  }

  /// Open the Scan History bottom sheet. Lists past smart-scans newest-first;
  /// tapping one re-applies it through the same routing the live scan uses.
  Future<void> showScanHistory() async {
    await ScanHistorySheet.show(
      context,
      dataSourceBuilder: _buildBankScanDataSource,
      onSelectScan: _applyScanHistoryItem,
    );
  }

  /// Re-apply a stored scan. Rebuilds a [SmartScanResult] from the history
  /// row and feeds it through the SAME result-sheet + routing path as the
  /// live scan, so verification + prefill behave identically. No-data /
  /// ambiguous-with-nothing rows just surface an info sheet.
  Future<void> _applyScanHistoryItem(ScanHistoryItem item) async {
    if (!mounted) return;

    final result = item.toSmartScanResult();

    if (result.extractionType == 'no_data') {
      _showScanErrorSheet(
        'No Details Found',
        'This scan did not capture any payment details. Try scanning again.',
      );
      return;
    }

    // Reuse the live-scan result sheet so the user can review / verify the
    // stored extraction before it routes into send-funds.
    final action = await SmartScanResultSheet.show(
      context,
      scanResult: result,
      country: scanCountry,
    );
    if (action == null || !mounted) return;

    Map<String, dynamic> buildSendFundsArgs(RecipientModel recipient) {
      final args = <String, dynamic>{'recipient': recipient};
      if (action.amountMinor != null && action.amountMinor! > 0) {
        args['prefillAmount'] = action.amountMinor;
      }
      if (action.description != null && action.description!.isNotEmpty) {
        args['prefillDescription'] = action.description;
      }
      if (args.containsKey('prefillAmount')) {
        args['autoShowConfirm'] = true;
      }
      return args;
    }

    switch (action.type) {
      case ScanActionType.bankTransfer:
        final recipient = RecipientModel(
          id: '',
          name: action.accountName ?? '',
          accountNumber: action.accountNumber ?? '',
          bankName: action.bankName ?? '',
          sortCode: action.bankCode ?? '',
          isFavorite: false,
          isSaved: false,
          countryCode: scanCountry,
        );
        onScanRecipientResolved(recipient,
            sendFundsArgs: buildSendFundsArgs(recipient));
      case ScanActionType.resolvedUserTransfer:
        _handleResolvedUserScan(action);
      case ScanActionType.internalTransfer:
        if (action.username != null && action.username!.isNotEmpty) {
          _handleSmartScanUserSearch(
            action.username!,
            prefillAmountMinor: action.amountMinor,
            prefillDescription: action.description,
          );
        }
      case ScanActionType.phoneTransfer:
        final recipient = RecipientModel(
          id: '',
          name: '',
          accountNumber: action.phoneNumber ?? '',
          bankName: '',
          sortCode: '',
          isFavorite: false,
          isSaved: false,
          phoneNumber: action.phoneNumber,
          countryCode: scanCountry,
        );
        onScanRecipientResolved(recipient,
            sendFundsArgs: buildSendFundsArgs(recipient));
      case ScanActionType.retryCapture:
        // From history, "Scan Again" means start a fresh live capture.
        launchBankDetailsScan();
    }
  }

  Future<void> launchBankDetailsScan() async {
    // Go STRAIGHT into the live "hover to detect" scanner — no source-picker
    // bottom sheet. It auto-captures once the account / phone / @user / invoice
    // details sit steady in frame (no shutter tap). Users who want to pick an
    // existing screenshot / saved statement instead can tap the "Upload" button
    // built into the camera screen (LiveScanCameraView._pickFromGallery →
    // onImagePicked) — both paths feed the same OCR + verify + route chain.
    if (!mounted) return;
    await Get.to<void>(
      () => Scaffold(
        backgroundColor: Colors.black,
        body: LiveScanCameraView(
          title: 'Scan Account',
          onCapture: _onLiveScanCaptured,
          onImagePicked: _onLiveScanCaptured,
          // Manual "tap to capture" fallback → lean per-service OCR route.
          onManualCapture: (p) => _onLiveScanCaptured(p, lean: true),
          // On-device fast path: parse the still on-device; if it yields a
          // clean identifier, skip the upload + backend GPT-vision entirely.
          onDeviceResolve: (text) =>
              const OnDeviceScanExtractor().extract(text, country: scanCountry),
          onResolved: _onOnDeviceScanResolved,
        ),
      ),
      fullscreenDialog: true,
    );
  }

  /// Live-scan handoff: pop the camera page, then OCR + route on the still.
  /// Deferred to the next frame so the pop settles before the processing sheet
  /// attaches (otherwise the sheet can bind to the disposing page's context).
  void _onLiveScanCaptured(String imagePath, {bool lean = false}) {
    if (Navigator.canPop(context)) Get.back(); // close the live camera page
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _runBankScanAndRoute(imagePath, lean: lean);
    });
  }

  /// On-device fast-path handoff: the captured still was OCR'd + parsed
  /// on-device into a [SmartScanResult]; pop the camera and route it through the
  /// SAME Verify sheet + send-funds path a backend result uses — no upload, no
  /// GPT-vision call. Money-safety (NIP verify + PIN) is unchanged.
  void _onOnDeviceScanResolved(Object resolved) {
    if (resolved is! SmartScanResult) return;
    if (Navigator.canPop(context)) Get.back(); // close the live camera page
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _runBankScanAndRoute('', preResolved: resolved);
    });
  }

  /// OCR the captured/picked still (via the per-service gateway endpoint) and
  /// route the result into send-funds through the prefilled-editable
  /// SmartScanResultSheet. Shared by the live camera and the gallery path.
  Future<void> _runBankScanAndRoute(String imagePath,
      {bool lean = false, SmartScanResult? preResolved}) async {
    if (!mounted) return;
    // The long-flow host (AddRecipientScreen) may not sit under the
    // AuthenticationCubit provider; read it defensively so a scan there can't
    // throw provider-not-found. userId is best-effort (OCR still works without).
    AuthenticationCubit? authCubit;
    try {
      authCubit = context.read<AuthenticationCubit>();
    } catch (_) {
      authCubit = null;
    }

    BankScanDataSource? dataSource;
    try {
      final SmartScanResult result;
      if (preResolved != null) {
        // On-device fast path — the still was OCR'd + parsed on-device
        // (OnDeviceScanExtractor), so we skip the storage upload + backend
        // GPT-vision call entirely and route the SAME SmartScanResult straight
        // into the Verify sheet below. NIP verify + PIN are unchanged.
        result = preResolved;
      } else {
        _showScanProcessingSheet();
        await Future.delayed(const Duration(milliseconds: 100));
        if (!mounted) {
          if (Get.isBottomSheetOpen ?? false) Get.back();
          return;
        }

        final authState = authCubit?.state;
        final userId = (authState is AuthenticationSuccess)
            ? authState.profile.user.id
            : '';

        // BankScanDataSource goes through storage-service first (via
        // BankScanUploadService) and posts only the resulting public URL
        // to /scan/bank-details — see datasource for the 3-step pipeline.
        // Gateway-root resolution is shared with the history sheet via
        // _buildBankScanDataSource so both hit the same base.
        dataSource = _buildBankScanDataSource();

        result = await dataSource.scanBankDetails(
          imageFile: File(imagePath),
          userId: userId,
          locale: 'en-$scanCountry',
          countryCode: scanCountry,
          lean: lean,
        );

        dataSource.dispose();
        dataSource = null;

        // Always dismiss processing sheet before showing next UI.
        if (Get.isBottomSheetOpen ?? false) Get.back();
      }
      // Mounted check after async gap.
      if (!mounted) return;

      // Handle no_data immediately with error sheet
      if (result.extractionType == 'no_data') {
        _showScanErrorSheet(
          'No Details Found',
          'Could not find payment details in this image. Try with a clearer photo.',
        );
        return;
      }

      // Show smart result sheet for all other types
      final action = await SmartScanResultSheet.show(
        context,
        scanResult: result,
        country: scanCountry,
      );

      // 2.3: Mounted check after showing bottom sheet
      if (action == null || !mounted) return;

      // Route based on action type. When the OCR captured an amount or
      // memo (invoice / payment-slip flow), pass them through the Map
      // argument shape the InitiateSendFunds widget recognises —
      // `prefillAmount` (minor units) drives the amount controller's
      // initial value, `prefillDescription` populates the reference
      // field. The route handler unwraps both into the screen args.
      Map<String, dynamic> buildSendFundsArgs(RecipientModel recipient) {
        final args = <String, dynamic>{'recipient': recipient};
        if (action.amountMinor != null && action.amountMinor! > 0) {
          args['prefillAmount'] = action.amountMinor;
        }
        if (action.description != null && action.description!.isNotEmpty) {
          args['prefillDescription'] = action.description;
        }
        // If we have both recipient and amount, auto-show the
        // confirmation sheet so the user only has to tap "Send".
        if (args.containsKey('prefillAmount')) {
          args['autoShowConfirm'] = true;
        }
        return args;
      }

      switch (action.type) {
        case ScanActionType.bankTransfer:
          final recipient = RecipientModel(
            id: '',
            name: action.accountName ?? '',
            accountNumber: action.accountNumber ?? '',
            bankName: action.bankName ?? '',
            sortCode: action.bankCode ?? '',
            isFavorite: false,
            isSaved: false,
            countryCode: scanCountry,
          );
          onScanRecipientResolved(recipient,
              sendFundsArgs: buildSendFundsArgs(recipient));
        case ScanActionType.resolvedUserTransfer:
          _handleResolvedUserScan(action);
        case ScanActionType.internalTransfer:
          if (action.username != null && action.username!.isNotEmpty) {
            _handleSmartScanUserSearch(
              action.username!,
              prefillAmountMinor: action.amountMinor,
              prefillDescription: action.description,
            );
          }
        case ScanActionType.phoneTransfer:
          final recipient = RecipientModel(
            id: '',
            name: '',
            accountNumber: action.phoneNumber ?? '',
            bankName: '',
            sortCode: '',
            isFavorite: false,
            isSaved: false,
            phoneNumber: action.phoneNumber,
            countryCode: scanCountry,
          );
          onScanRecipientResolved(recipient,
              sendFundsArgs: buildSendFundsArgs(recipient));
        case ScanActionType.retryCapture:
          launchBankDetailsScan();
      }
    } on BankScanException catch (e) {
      // 2.4: Always dismiss processing sheet on error
      if (Get.isBottomSheetOpen ?? false) Get.back();
      if (!mounted) return;
      _showScanErrorSheet('Scan Failed', e.message);
    } catch (e) {
      // 2.4: Always dismiss processing sheet on error
      if (Get.isBottomSheetOpen ?? false) Get.back();
      if (!mounted) return;
      _showScanErrorSheet('Error', 'Something went wrong. Please try again.');
    } finally {
      // Ensure datasource is cleaned up even on unexpected errors
      dataSource?.dispose();
    }
  }

  void _handleSmartScanUserSearch(
    String username, {
    int? prefillAmountMinor,
    String? prefillDescription,
  }) {
    final currency = CountryConfigs.getByCode(scanCountry)?.currency ?? 'NGN';
    final recipient = RecipientModel(
      id: '',
      name: username,
      accountNumber: username,
      bankName: 'LazerVault',
      sortCode: '',
      isFavorite: false,
      isSaved: false,
      countryCode: scanCountry,
      currency: currency,
      type: 'internal',
    );
    // Mirror the Map-argument shape so the prefill from the OCR
    // scan survives the navigation hop.
    final args = <String, dynamic>{'recipient': recipient};
    if (prefillAmountMinor != null && prefillAmountMinor > 0) {
      args['prefillAmount'] = prefillAmountMinor;
      args['autoShowConfirm'] = true;
    }
    if (prefillDescription != null && prefillDescription.isNotEmpty) {
      args['prefillDescription'] = prefillDescription;
    }
    onScanRecipientResolved(recipient, sendFundsArgs: args);
  }

  /// Route a backend-resolved Lazervault user (scan matched a phone/email/
  /// username to a real user) straight into a free internal transfer — no
  /// username search needed because we already hold the user id + account.
  void _handleResolvedUserScan(ScanAction action) {
    final currency = CountryConfigs.getByCode(scanCountry)?.currency ?? 'NGN';
    final name = (action.resolvedDisplayName ?? '').trim().isNotEmpty
        ? action.resolvedDisplayName!.trim()
        : (action.username ?? 'Lazervault User');
    final recipient = RecipientModel(
      id: '',
      name: name,
      // For internal C2C the dispatch prefers internalUserId (the user UUID);
      // accountNumber is kept human-friendly (account id / username) for the
      // receipt's masked display.
      accountNumber:
          action.resolvedAccountId ?? action.username ?? (action.resolvedUserId ?? ''),
      bankName: 'LazerVault',
      sortCode: '',
      isFavorite: false,
      isSaved: false,
      internalUserId: action.resolvedUserId,
      countryCode: scanCountry,
      currency: currency,
      type: 'internal',
    );
    final args = <String, dynamic>{'recipient': recipient};
    if (action.amountMinor != null && action.amountMinor! > 0) {
      args['prefillAmount'] = action.amountMinor;
      args['autoShowConfirm'] = true;
    }
    if (action.description != null && action.description!.isNotEmpty) {
      args['prefillDescription'] = action.description;
    }
    onScanRecipientResolved(recipient, sendFundsArgs: args);
  }

  void _showScanProcessingSheet() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 32.h),
            Container(
              width: 72.w,
              height: 72.h,
              decoration: BoxDecoration(
                color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              // Branded loader replaces the bare CircularProgressIndicator
              // so the user sees the company logo while the OCR call is
              // in flight. Same 36px slot — pixel-stable.
              child: const Center(
                child: LazerVaultLoader(size: 36),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Scanning Bank Details',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF111827),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Extracting account information from the image...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF6B7280),
              ),
            ),
            SizedBox(height: 16.h),
            LinearProgressIndicator(
              backgroundColor: const Color(0xFFE5E7EB),
              valueColor: const AlwaysStoppedAnimation(Color(0xFF4E03D0)),
              minHeight: 3.h,
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
      isDismissible: false,
      enableDrag: false,
    );
  }

  void _showScanErrorSheet(String title, String message, {bool isWarning = false}) {
    final color = isWarning ? Colors.orange : Colors.red;
    final icon = isWarning ? Icons.warning_amber_rounded : Icons.error_outline;

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 32.h),
            Container(
              width: 72.w,
              height: 72.h,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 36.sp),
            ),
            SizedBox(height: 24.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF111827),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF6B7280),
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      side: const BorderSide(color: Color(0xFFE5E7EB)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      launchBankDetailsScan();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4E03D0),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Try Again',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
