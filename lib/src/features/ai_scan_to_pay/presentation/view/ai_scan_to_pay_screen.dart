import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/shared_widgets/service_entrance_animation.dart';
import '../../domain/entities/scan_entities.dart';
import '../cubit/ai_scan_cubit.dart';
import '../cubit/ai_scan_state.dart';
import 'ai_scan_camera_screen.dart';
import 'ai_scan_confirm_screen.dart';
import 'ai_scan_receipt_screen.dart';
import 'bank_details_processing_screen.dart';
import '../../../presentation/views/dashboard/dashboard_screen.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:get_it/get_it.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/funds/presentation/send_funds_launcher.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
// Reuse the SAME verify sheet + result model the send-funds "Scan Account" flow
// uses, so AI Scan-to-Pay shows an identical verify-before-amount step.
import 'package:lazervault/src/features/recipients/presentation/widgets/scan_bank_details_modal.dart';
import 'package:lazervault/src/features/recipients/data/datasources/bank_scan_datasource.dart'
    show SmartScanResult;
import 'package:lazervault/core/services/locale_manager.dart';

class AiScanToPayScreen extends StatefulWidget {
  const AiScanToPayScreen({super.key});

  @override
  State<AiScanToPayScreen> createState() => _AiScanToPayScreenState();
}

class _AiScanToPayScreenState extends State<AiScanToPayScreen>
    with TransactionPinMixin<AiScanToPayScreen> {

  // Guards for the unified flow.
  bool _confirmPushed = false;
  bool _payingScreenPushed = false;
  bool _cameraAutoOpened = false;

  /// Provide the PIN service implementation the mixin needs. Sourced
  /// from GetIt — the same singleton other money-moving screens use.
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();
  @override
  void initState() {
    super.initState();
    // Camera-first: go STRAIGHT into the live "hover to detect" scanner on
    // entry — no source chooser. Gallery pick is the "Upload" button built
    // into LiveScanCameraView itself, so a separate "Upload from device"
    // option is redundant (mirrors the send-funds Scan Account flow).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _cameraAutoOpened) return;
      _cameraAutoOpened = true;
      _takePhoto();
    });
  }

  /// Push the camera screen; on capture (or its built-in gallery Upload) it
  /// calls analyzeImage.
  void _takePhoto() {
    if (!mounted) return;
    _confirmPushed = false;
    _payingScreenPushed = false;
    Get.to(() => BlocProvider.value(
          value: context.read<AiScanCubit>(),
          child: const AiScanCameraScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          // Honour the caller's route — pop back to wherever the user
          // launched AI Scan from (dashboard, send-funds, recipients).
          // Falls back to the dashboard only when no route is on the
          // stack (shouldn't normally happen but keeps the back button
          // useful even from a stale deep-link).
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            } else {
              Get.offAll(() => const DashboardScreen());
            }
          },
          icon: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              shape: BoxShape.circle,
              boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
            ),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 20.sp,
            ),
          ),
        ),
        title: Text(
          'AI Scan to Pay',
          style: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          // Voice + chat icons intentionally removed from this landing per
          // request — AI Scan to Pay is a camera/upload-first surface.
          IconButton(
            onPressed: () => context.read<AiScanCubit>().loadLocalHistory(),
            icon: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                shape: BoxShape.circle,
                boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],

              ),
              child: Icon(
                Icons.history,
                color: const Color.fromARGB(255, 78, 3, 208),
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
        ],
      ),
      body: ServiceEntranceAnimation(
        child: BlocConsumer<AiScanCubit, AiScanState>(
        listener: (context, state) {
          // A fresh analysis (camera capture or upload) means any prior
          // confirm/paying screen is done — reset the one-shot push guards so
          // the next resolved intent can push cleanly even after a retry.
          if (state is AiScanAnalyzing) {
            _confirmPushed = false;
            _payingScreenPushed = false;
          }
          if (state is AiScanResumable) {
            // Surface the resumable session as a sticky bottom sheet
            // with Resume / Discard. Either choice dispatches back to
            // the cubit and clears this transient state.
            _showResumePrompt(context, state);
          } else if (state is AiScanCamera) {
            Get.to(() => BlocProvider.value(
              value: context.read<AiScanCubit>(),
              child: const AiScanCameraScreen(),
            ));
          } else if (state is AiScanIntentResolved) {
            _handleIntentResolved(context, state);
          } else if (state is AiScanOcrResolved) {
            _handleOcrResolved(context, state);
          } else if (state is AiScanNoDataResult) {
            _handleNoData(context, state);
          } else if (state is AiScanPaying) {
            _handlePaying(context, state);
          } else if (state is AiScanPaymentCompleted) {
            _handlePaymentCompleted(context, state);
          } else if (state is AiScanPaymentFailedResult) {
            _handlePaymentFailed(context, state);
          } else if (state is AiScanBankDetailsExtracted) {
            // Resume path (a stored session with already-extracted bank
            // details). Hand the details straight to the send-funds flow — its
            // amount bottom sheet → PIN → receipt (short) / initiate screen
            // (long) with external-account name verification — instead of the
            // dedicated bank-details bottom sheet + processing/receipt screens.
            _payViaSendFunds(
              recipient: _recipientFromBankDetails(state.bankDetails),
              amount: null,
              currency: 'NGN',
            );
          } else if (state is AiScanError) {
            Get.snackbar(
              'Error',
              state.message,
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
          }
        },
        builder: (context, state) {
          if (state is AiScanLoading) {
            return _buildLoadingState(state.message);
          } else if (state is AiScanAnalyzing) {
            return _buildAnalyzingState(state.message);
          } else if (state is AiScanResumable ||
              state is AiScanTypeSelection) {
            // Behind the auto-opened camera, show the simple scan landing
            // (a single "Scan to pay" CTA) — reached when the user backs out.
            return _buildInitialState();
          } else if (state is AiScanLocalHistoryLoaded) {
            return _buildLocalHistory(state.entries);
          } else if (state is AiScanError) {
            return _buildErrorState(state.message);
          }

          return _buildInitialState();
        },
      ),
      ),
    );
  }

  Widget _buildInitialState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
                  const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.qr_code_scanner,
              size: 60.sp,
              color: const Color.fromARGB(255, 78, 3, 208),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'AI-Powered Scan to Pay',
            style: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              'Scan any document, QR code, or image and let AI guide you through the payment process',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.grey[400],
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: 40.h),
          // Single scan CTA — the camera auto-opens on entry; this reopens it
          // if the user backed out. Gallery pick lives inside the camera.
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SizedBox(
              width: double.infinity,
              height: 54.h,
              child: ElevatedButton.icon(
                onPressed: _takePhoto,
                icon: Icon(Icons.photo_camera_outlined,
                    color: Colors.white, size: 20.sp),
                label: Text('Scan to pay',
                    style: GoogleFonts.inter(
                        fontSize: 15.sp, fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState(String? message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LazerVaultLoader.small(),
          if (message != null) ...[
            SizedBox(height: 16.h),
            Text(
              message,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.grey[400],
              ),
            ),
          ],
        ],
      ),
    );
  }


  /// "Previous scans" — on-device history. Completed scans open the full-screen
  /// receipt; incomplete ones tell the user the flow wasn't finished.
  Widget _buildLocalHistory(List<AiScanHistoryEntry> entries) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Previous scans',
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              TextButton.icon(
                onPressed: _takePhoto,
                icon: const Icon(Icons.add,
                    color: Color.fromARGB(255, 78, 3, 208), size: 18),
                label: Text(
                  'New scan',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 78, 3, 208),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (entries.isEmpty)
            Padding(
              padding: EdgeInsets.only(top: 60.h),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.history, size: 56.sp, color: Colors.grey[700]),
                    SizedBox(height: 14.h),
                    Text(
                      'No scans yet',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Your scan-to-pay history will appear here.',
                      style: GoogleFonts.inter(
                          fontSize: 13.sp, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            )
          else
            ...entries.map(_buildHistoryTile),
        ],
      ),
    );
  }

  Widget _buildHistoryTile(AiScanHistoryEntry e) {
    final completed = e.isCompleted;
    final dt = e.createdAt;
    final dateStr =
        '${dt.day}/${dt.month}/${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    return GestureDetector(
      onTap: () => _onHistoryTap(e),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: (completed
                        ? const Color(0xFF10B981)
                        : const Color(0xFF9CA3AF))
                    .withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                completed ? Icons.check_circle : Icons.hourglass_empty,
                color:
                    completed ? const Color(0xFF10B981) : const Color(0xFF9CA3AF),
                size: 22.sp,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.title.isNotEmpty ? e.title : 'Scan',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    completed
                        ? '${e.currency} ${e.amount.toStringAsFixed(2)} • $dateStr'
                        : 'Didn\'t complete • $dateStr',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: (completed
                        ? const Color(0xFF10B981)
                        : const Color(0xFF9CA3AF))
                    .withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                completed ? 'Completed' : 'Incomplete',
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: completed
                      ? const Color(0xFF10B981)
                      : const Color(0xFF9CA3AF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onHistoryTap(AiScanHistoryEntry e) {
    if (e.isCompleted && e.receipt != null) {
      Get.to(() => AiScanReceiptScreen(receipt: e.receipt!));
    } else {
      showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: const Color(0xFF1F1F1F),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          title: Text(
            'Scan not completed',
            style: GoogleFonts.inter(
                color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.w700),
          ),
          content: Text(
            'This scan didn\'t complete the payment flow, so there\'s no receipt '
            'to show. You can start a new scan to try again.',
            style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF), fontSize: 14.sp, height: 1.4),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('Close',
                  style: GoogleFonts.inter(color: const Color(0xFF9CA3AF))),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                _takePhoto();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                foregroundColor: Colors.white,
              ),
              child: Text('New scan', style: GoogleFonts.inter()),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64.sp,
            color: const Color(0xFFEF4444),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.grey[400],
              ),
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () => context.read<AiScanCubit>().reset(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 78, 3, 208),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Try Again',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // _showPaymentProcessingOverlay + _showPaymentSuccessOverlay were
  // removed alongside the legacy AiScanPaymentProcessing /
  // AiScanPaymentSuccess states. The canonical bank-details flow uses
  // BankDetailsProcessingScreen + BankDetailsReceiptScreen which are
  // pushed via the listener above; this surface stays scan-driven.

  /// One-shot guard so a rapid second AiScanResumable emit doesn't
  /// stack two prompts.
  bool _resumePromptShown = false;

  /// Surface the resumable session as a non-dismissible bottom sheet
  /// with Resume / Discard. Each choice dispatches back to the cubit
  /// (resumeStoredSession / discardStoredSession) and the listener
  /// then routes to the appropriate next screen.
  void _showResumePrompt(BuildContext context, AiScanResumable state) {
    if (_resumePromptShown) return;
    _resumePromptShown = true;

    final cubit = context.read<AiScanCubit>();
    final scanLabel = state.session.scanType.name
        .replaceAllMapped(
            RegExp(r'([A-Z])'), (m) => ' ${m.group(0)!.toLowerCase()}')
        .trim();
    final hasExtracted = state.bankDetails != null;
    final ageMins = DateTime.now()
            .difference(state.session.createdAt)
            .inMinutes
            .clamp(0, 999);

    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetCtx) {
        return Padding(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Center(
                child: Text(
                  'Resume your scan?',
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                hasExtracted
                    ? 'We held your $scanLabel scan from $ageMins min ago — '
                        'the account details are ready. Resume to enter '
                        'the amount, or start over.'
                    : 'A $scanLabel scan from $ageMins min ago is still '
                        'in progress. Resume where you left off, or start '
                        'over.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: () {
                  _resumePromptShown = false;
                  Navigator.of(sheetCtx).pop();
                  cubit.resumeStoredSession();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(255, 78, 3, 208),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Resume',
                  style: GoogleFonts.inter(
                      fontSize: 15.sp, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 10.h),
              TextButton(
                onPressed: () {
                  _resumePromptShown = false;
                  Navigator.of(sheetCtx).pop();
                  cubit.discardStoredSession();
                },
                child: Text(
                  'Start over',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ===== Unified intelligent-scan flow handlers =====

  /// Full-screen "Reading your scan…" loader.
  Widget _buildAnalyzingState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 110.w,
            height: 110.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color.fromARGB(255, 78, 3, 208),
                width: 2,
              ),
            ),
            child: const Center(child: LazerVaultLoader.small()),
          ),
          SizedBox(height: 28.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Detecting bank details or a payment code…',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(fontSize: 13.sp, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  /// A scan resolved to one payable target → push the unified confirm screen,
  /// sharing the same AiScanCubit so cubit.pay() states reach this host.
  void _handleIntentResolved(BuildContext context, AiScanIntentResolved state) {
    if (_confirmPushed) return;
    final intent = state.intent;

    // Transfers (a Lazervault user or a bank account) with an EDITABLE amount
    // reuse the send-funds flow — its amount bottom sheet → PIN → receipt (short
    // flow) or the initiate-send screen (long flow) — instead of a dedicated
    // scan capture screen. Fixed-amount targets (invoice / dynamic QR, where
    // amountEditable == false) keep the confirm screen since send-funds can't
    // lock the amount.
    final recipient = _recipientFromIntent(intent);
    if (recipient != null && intent.amountEditable) {
      _confirmPushed = true;
      _payViaSendFunds(
        recipient: recipient,
        amount: intent.amount,
        currency: intent.currency,
      );
      // The send-funds flow now owns navigation; allow a fresh resolution if the
      // user backs out and re-scans.
      _confirmPushed = false;
      return;
    }

    _confirmPushed = true;
    final cubit = context.read<AiScanCubit>();
    Get.to(() => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: cubit),
            BlocProvider(
                create: (_) => GetIt.I<AccountCardsSummaryCubit>()),
          ],
          child: AiScanConfirmScreen(intent: intent),
        ))?.then((_) {
      // User backed out of confirm — allow re-resolution next time.
      _confirmPushed = false;
    });
  }

  /// Build a send-funds RecipientModel from a scanned payment intent, or null
  /// when the intent isn't a person/bank transfer (qr-pay / invoice / unknown
  /// keep their own flows).
  RecipientModel? _recipientFromIntent(ScanPaymentIntent i) {
    switch (i.type) {
      case ScanIntentType.recipient:
        // Internal Lazervault user (resolved by username / user id).
        if ((i.userId ?? '').isEmpty && (i.accountNumber ?? '').isEmpty) {
          return null;
        }
        return RecipientModel(
          id: '',
          name: i.title.isNotEmpty ? i.title : (i.username ?? 'Lazervault user'),
          accountNumber: i.accountNumber ?? '',
          bankName: 'Lazervault',
          sortCode: '',
          isFavorite: false,
          isSaved: false,
          type: 'internal',
          internalUserId: (i.userId ?? '').isNotEmpty ? i.userId : null,
          currency: i.currency,
        );
      case ScanIntentType.bankDetails:
        // External bank account.
        if ((i.accountNumber ?? '').isEmpty) return null;
        return RecipientModel(
          id: '',
          name: i.title,
          accountNumber: i.accountNumber ?? '',
          bankName: i.bankName ?? '',
          sortCode: i.bankCode ?? '',
          isFavorite: false,
          isSaved: false,
          type: 'external',
          currency: i.currency,
        );
      case ScanIntentType.qrPay:
      case ScanIntentType.invoice:
      case ScanIntentType.unknown:
        return null;
    }
  }

  /// Build a send-funds RecipientModel from OCR-extracted bank details (resume
  /// path). Internal accountType → Lazervault recipient (the backend resolves
  /// internal_user_id from the account number); otherwise an external bank.
  RecipientModel _recipientFromBankDetails(BankDetails d) {
    final isInternal = d.accountType.toLowerCase() == 'internal';
    return RecipientModel(
      id: '',
      name: d.accountName.isNotEmpty ? d.accountName : 'Bank Transfer',
      accountNumber: d.accountNumber,
      bankName: isInternal ? 'Lazervault' : d.bankName,
      sortCode: d.bankCode ?? '',
      isFavorite: false,
      isSaved: false,
      type: isInternal ? 'internal' : 'external',
    );
  }

  /// Hand a resolved recipient (+ optional pre-filled amount) to the shared
  /// send-funds launcher, which honours the user's short/long flow preference.
  void _payViaSendFunds({
    required RecipientModel recipient,
    double? amount,
    required String currency,
  }) {
    final minor = (amount != null && amount > 0) ? (amount * 100).round() : null;
    SendFundsLauncher.open(
      recipient: recipient,
      autoContinue: true,
      prefillAmountMinor: minor,
      prefillCurrency: currency,
      checkRecurring: true,
    );
  }

  /// An OCR scan resolved to a payable target. Show the SAME verify sheet the
  /// send-funds "Scan Account" flow uses ([SmartScanResultSheet]) so the target
  /// is REVIEWED + VERIFIED before any amount is entered — NUBAN "Verify
  /// Account" name resolution for a bank account, confirm-recipient for a
  /// Lazervault user / phone / email, or disambiguation for an ambiguous value.
  /// Only AFTER the user confirms do we hand the verified recipient to the
  /// shared send-funds flow (amount → PIN → receipt). Mirrors the reference
  /// `_runBankScanAndRoute` in select_recipients so both scanners behave alike.
  Future<void> _handleOcrResolved(
      BuildContext context, AiScanOcrResolved state) async {
    if (_confirmPushed) return;
    _confirmPushed = true;

    // Country/currency for the verify sheet's bank picker + amount prefill,
    // sourced from the dashboard's locale (NG fallback keeps it safe).
    String country = 'NG';
    String currency = 'NGN';
    try {
      final lm = GetIt.I<LocaleManager>();
      if (lm.currentCountry.isNotEmpty) country = lm.currentCountry;
      if (lm.currentCurrency.isNotEmpty) currency = lm.currentCurrency;
    } catch (_) {/* keep NG/NGN defaults */}

    final a = state.analysis;
    final scanResult = SmartScanResult(
      extractionType: a.extractionType,
      confidence: a.confidence,
      accountNumber: a.accountNumber,
      accountName: a.accountName,
      bankName: a.bankName,
      bankCode: a.bankCode,
      username: a.username,
      displayName: a.displayName,
      phoneNumber: a.phoneNumber,
      email: a.email,
      possibleTypes: a.possibleTypes,
      disambiguationHint: a.disambiguationHint,
      amountMinor: (a.amount != null && a.amount! > 0)
          ? (a.amount! * 100).round()
          : null,
      description: a.description,
    );

    final action = await SmartScanResultSheet.show(
      context,
      scanResult: scanResult,
      country: country,
    );
    _confirmPushed = false;
    if (action == null || !mounted) return;

    final double? amount =
        (action.amountMinor != null && action.amountMinor! > 0)
            ? action.amountMinor! / 100.0
            : null;

    switch (action.type) {
      case ScanActionType.bankTransfer:
        // External bank account — VERIFIED via NUBAN in the sheet, so
        // action.accountName is the confirmed holder name.
        _payViaSendFunds(
          recipient: RecipientModel(
            id: '',
            name: action.accountName ?? '',
            accountNumber: action.accountNumber ?? '',
            bankName: action.bankName ?? '',
            sortCode: action.bankCode ?? '',
            isFavorite: false,
            isSaved: false,
            type: 'external',
            currency: currency,
            countryCode: country,
          ),
          amount: amount,
          currency: currency,
        );
        break;
      case ScanActionType.resolvedUserTransfer:
        final name = (action.resolvedDisplayName ?? '').trim().isNotEmpty
            ? action.resolvedDisplayName!.trim()
            : (action.username ?? 'Lazervault user');
        _payViaSendFunds(
          recipient: RecipientModel(
            id: '',
            name: name,
            accountNumber: action.resolvedAccountId ??
                action.username ??
                (action.resolvedUserId ?? ''),
            bankName: 'Lazervault',
            sortCode: '',
            isFavorite: false,
            isSaved: false,
            type: 'internal',
            internalUserId: action.resolvedUserId,
            currency: currency,
            countryCode: country,
          ),
          amount: amount,
          currency: currency,
        );
        break;
      case ScanActionType.internalTransfer:
        // A scanned Lazervault username — the send-funds internal path resolves
        // the account from the username at dispatch.
        final uname = action.username ?? '';
        _payViaSendFunds(
          recipient: RecipientModel(
            id: '',
            name: uname,
            accountNumber: uname,
            bankName: 'Lazervault',
            sortCode: '',
            isFavorite: false,
            isSaved: false,
            type: 'internal',
            currency: currency,
            countryCode: country,
          ),
          amount: amount,
          currency: currency,
        );
        break;
      case ScanActionType.phoneTransfer:
        _payViaSendFunds(
          recipient: RecipientModel(
            id: '',
            name: '',
            accountNumber: action.phoneNumber ?? '',
            bankName: '',
            sortCode: '',
            isFavorite: false,
            isSaved: false,
            phoneNumber: action.phoneNumber,
            currency: currency,
            countryCode: country,
          ),
          amount: amount,
          currency: currency,
        );
        break;
      case ScanActionType.retryCapture:
        _takePhoto();
        break;
    }
  }

  /// Nothing payable found → snackbar + re-open the camera so the user can
  /// retake / re-pick.
  void _handleNoData(BuildContext context, AiScanNoDataResult state) {
    Get.snackbar(
      'No payment details found',
      state.message,
      backgroundColor: const Color(0xFFFB923C),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 4),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _takePhoto();
    });
  }

  /// Generic payment in flight → push the (generalized) processing screen once.
  void _handlePaying(BuildContext context, AiScanPaying state) {
    if (_payingScreenPushed) return;
    _payingScreenPushed = true;
    Get.to(
      () => BankDetailsProcessingScreen(
        initialStatus: state.status,
        initialProgress: state.progress,
      ),
      preventDuplicates: true,
    );
  }

  /// Payment completed → replace the processing screen with the unified
  /// receipt; back from the receipt returns to the dashboard.
  void _handlePaymentCompleted(
      BuildContext context, AiScanPaymentCompleted state) {
    _payingScreenPushed = false;
    _confirmPushed = false;
    Get.off(() => AiScanReceiptScreen(receipt: state.receipt));
  }

  /// Payment failed → pop the processing screen (if up) and surface the error.
  /// The user lands back on the confirm screen to fix + retry.
  void _handlePaymentFailed(
      BuildContext context, AiScanPaymentFailedResult state) {
    if (_payingScreenPushed) {
      Get.back();
      _payingScreenPushed = false;
    }
    Get.snackbar(
      'Payment failed',
      state.canRetry
          ? '${state.message} — you can try again.'
          : state.message,
      backgroundColor: const Color(0xFFEF4444),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 5),
    );
  }
}