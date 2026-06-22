import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/entities/scan_entities.dart';
import '../cubit/ai_scan_cubit.dart';
import '../cubit/ai_scan_state.dart';
import '../widgets/scan_type_card.dart';
import '../widgets/scan_history_card.dart';
import '../widgets/ai_chat_bottom_sheet.dart';
import '../widgets/bank_details_bottom_sheet.dart';
import '../widgets/scan_source_sheet.dart';
import 'ai_scan_camera_screen.dart';
import 'ai_scan_confirm_screen.dart';
import 'ai_scan_receipt_screen.dart';
import 'bank_details_processing_screen.dart';
import 'bank_details_receipt_screen.dart';
import '../../../presentation/views/dashboard/dashboard_screen.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:get_it/get_it.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class AiScanToPayScreen extends StatefulWidget {
  const AiScanToPayScreen({super.key});

  @override
  State<AiScanToPayScreen> createState() => _AiScanToPayScreenState();
}

class _AiScanToPayScreenState extends State<AiScanToPayScreen>
    with TransactionPinMixin<AiScanToPayScreen> {
  // Guard so the processing screen isn't double-pushed when the cubit
  // emits multiple AiScanBankDetailsProcessing states with progress
  // updates. We push once on entry and let the screen rebuild internally.
  bool _processingScreenPushed = false;

  // Guards for the unified flow.
  bool _confirmPushed = false;
  bool _payingScreenPushed = false;
  bool _sourceSheetOpen = false;

  final ImagePicker _picker = ImagePicker();

  /// Provide the PIN service implementation the mixin needs. Sourced
  /// from GetIt — the same singleton other money-moving screens use.
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();
  @override
  void initState() {
    super.initState();
    // The unified flow opens the source picker immediately instead of the
    // tile grid. Still call initializeScanTypes() so a resumable session is
    // surfaced first (it emits AiScanResumable and the resume prompt wins).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final cubit = context.read<AiScanCubit>();
      // ignore: discarded_futures
      cubit.initializeScanTypes().then((_) {
        if (!mounted) return;
        // Only auto-open the source sheet when there's nothing to resume.
        if (cubit.state is! AiScanResumable) {
          _openSourceSheet();
        }
      });
    });
  }

  /// Open the camera/upload chooser, then kick off analysis.
  Future<void> _openSourceSheet() async {
    if (_sourceSheetOpen || !mounted) return;
    _sourceSheetOpen = true;
    final source = await ScanSourceSheet.show(context);
    _sourceSheetOpen = false;
    if (!mounted || source == null) return;

    if (source == ScanSource.camera) {
      // Push the existing camera screen; on capture it calls analyzeImage.
      Get.to(() => BlocProvider.value(
            value: context.read<AiScanCubit>(),
            child: const AiScanCameraScreen(),
          ));
    } else {
      await _pickFromGalleryAndAnalyze();
    }
  }

  Future<void> _pickFromGalleryAndAnalyze() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image == null || !mounted) return;
      _confirmPushed = false;
      context.read<AiScanCubit>().analyzeImage(image.path, ScanSource.upload);
    } catch (e) {
      Get.snackbar(
        'Gallery Error',
        'Failed to pick image: ${e.toString()}',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
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
          // Per-service voice + chat icons — pin every session to
          // the AI-scan flow on chat-transfers-service via
          // DIRECT_ROUTES['ai-scan'] → primary 'transfers'. Same
          // pattern as crowdfund / autosave / lock-funds / tax /
          // customers / inventory / per-bill landings.
          ServiceVoiceButton(
            serviceName: 'ai-scan',
            iconColor: const Color.fromARGB(255, 78, 3, 208),
            backgroundColor: const Color.fromARGB(255, 78, 3, 208),
          ),
          SizedBox(width: 8.w),
          MicroserviceChatIcon(
            serviceName: 'AI Scan to Pay',
            sourceContext: 'ai-scan',
            icon: Icons.chat_bubble_outline,
            iconColor: const Color.fromARGB(255, 78, 3, 208),
          ),
          SizedBox(width: 8.w),
          IconButton(
            onPressed: () => context.read<AiScanCubit>().loadScanHistory(),
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
      body: BlocConsumer<AiScanCubit, AiScanState>(
        listener: (context, state) {
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
          } else if (state is AiScanAmbiguousResult) {
            _handleAmbiguous(context, state);
          } else if (state is AiScanNoDataResult) {
            _handleNoData(context, state);
          } else if (state is AiScanPaying) {
            _handlePaying(context, state);
          } else if (state is AiScanPaymentCompleted) {
            _handlePaymentCompleted(context, state);
          } else if (state is AiScanPaymentFailedResult) {
            _handlePaymentFailed(context, state);
          } else if (state is AiScanChatActive) {
            // Only show bottom sheet if it's not already showing
            if (Get.isBottomSheetOpen != true) {
              // Add small delay to ensure navigation from camera completes
              Future.delayed(const Duration(milliseconds: 300), () {
                if (mounted && Get.isBottomSheetOpen != true) {
                  _showAiChatBottomSheet(context, state);
                }
              });
            }
          } else if (state is AiScanBankDetailsExtracted) {
            // Camera → OCR completes → present the extracted details
            // sheet so the user can confirm the account, set the amount,
            // and tap Pay (which triggers AiScanBankDetailsAwaitingPIN).
            if (Get.isBottomSheetOpen != true) {
              _showBankDetailsBottomSheet(context, state);
            }
          } else if (state is AiScanBankDetailsAwaitingPIN) {
            // Bottom sheet emitted initiatePayment → present the
            // canonical PIN modal. On success, hand the verification
            // token to processPaymentWithPIN; on cancel/fail the user
            // returns to the extracted-details sheet and can retry.
            _handleAwaitingPIN(context, state);
          } else if (state is AiScanBankDetailsProcessing) {
            // Push the processing screen ONCE; subsequent processing
            // states are progress updates which the screen rebuilds
            // from. We rely on the screen reading the latest state via
            // its own BlocBuilder rather than re-pushing on each tick.
            if (!_processingScreenPushed) {
              _processingScreenPushed = true;
              Get.to(
                () => BlocProvider.value(
                  value: context.read<AiScanCubit>(),
                  child: BankDetailsProcessingScreen(
                    initialStatus: state.status,
                    initialProgress: state.progress,
                  ),
                ),
                preventDuplicates: true,
              );
            }
          } else if (state is AiScanBankDetailsPaymentSuccess) {
            // Replace the processing screen with the receipt — using
            // Get.off so back from the receipt returns to the AI scan
            // landing, not the now-stale processing screen.
            _processingScreenPushed = false;
            Get.off(
              () => BankDetailsReceiptScreen(receipt: state.receipt),
            );
          } else if (state is AiScanBankDetailsPaymentFailed) {
            // Pop the processing screen (if up) and surface the failure
            // with a retry hint. The bottom sheet stays dismissed so
            // the user can re-scan instead of retrying with bad data.
            if (_processingScreenPushed) {
              Get.back();
              _processingScreenPushed = false;
            }
            Get.snackbar(
              'Payment failed',
              state.canRetry
                  ? '${state.errorMessage} — tap retry to try again.'
                  : state.errorMessage,
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              duration: const Duration(seconds: 5),
            );
            context.read<AiScanCubit>().returnToScanTypeSelection();
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
          } else if (state is AiScanResumable) {
            // While the modal sheet is up, render the scan-type tiles
            // dimmed in the background so context isn't lost.
            return _buildScanTypeSelection(state.availableTypes);
          } else if (state is AiScanTypeSelection) {
            return _buildScanTypeSelection(state.availableTypes);
          } else if (state is AiScanChatActive) {
            // Show scan type selection with bottom sheet — curated list
            // matches the rest of the flow (no orphan tiles for scan types
            // without an end-to-end integration).
            return _buildScanTypeSelection(AiScanCubit.supportedScanTypes);
          } else if (state is AiScanHistoryLoaded) {
            return _buildScanHistory(state.sessions);
          } else if (state is AiScanError) {
            return _buildErrorState(state.message);
          }

          return _buildInitialState();
        },
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
          ElevatedButton(
            onPressed: () => context.read<AiScanCubit>().initializeScanTypes(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 78, 3, 208),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 3,
            ),
            child: Text(
              'Get Started',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
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

  Widget _buildScanTypeSelection(List<ScanType> availableTypes) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color.fromARGB(255, 78, 3, 208),
                  const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.auto_awesome,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What would you like to scan?',
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Choose the type of document or code you want to scan',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 0.85,
            ),
            itemCount: availableTypes.length,
            itemBuilder: (context, index) {
              final scanType = availableTypes[index];
              return ScanTypeCard(
                scanType: scanType,
                onTap: () => context.read<AiScanCubit>().startScanSession(scanType),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildScanHistory(List<ScanSession> sessions) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Scan History',
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () => context.read<AiScanCubit>().returnToScanTypeSelection(),
                child: Text(
                  'New Scan',
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
          if (sessions.isEmpty)
            Center(
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  Icon(
                    Icons.history,
                    size: 64.sp,
                    color: Colors.grey[600],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'No scan history yet',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Start scanning to see your history here',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];
                return ScanHistoryCard(
                  session: session,
                  onTap: () {
                    // Handle history item tap
                  },
                );
              },
            ),
        ],
      ),
    );
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

  void _showAiChatBottomSheet(BuildContext context, AiScanChatActive state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (modalContext) => BlocProvider.value(
        value: context.read<AiScanCubit>(),
        child: AiChatBottomSheet(
          session: state.session,
          messages: state.messages,
          extractedData: state.extractedData,
          isTyping: state.isTyping,
        ),
      ),
    ).then((_) {
      // Check if context is still mounted before using it
      if (mounted && context.mounted) {
        try {
          // Use a post frame callback to ensure proper state reset
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && context.mounted) {
              context.read<AiScanCubit>().returnToScanTypeSelection();
            }
          });
        } catch (e) {
          // Safely handle any context-related errors
          print('Error returning to scan type selection: $e');
        }
      }
    });
  }

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

  /// Show the extracted bank-details bottom sheet so the user can
  /// confirm + edit account number / bank / amount before paying.
  void _showBankDetailsBottomSheet(
    BuildContext context,
    AiScanBankDetailsExtracted state,
  ) {
    final cubit = context.read<AiScanCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => BlocProvider.value(
        value: cubit,
        child: BankDetailsBottomSheet(
          extractedDetails: state.bankDetails,
          sessionId: state.session.id,
        ),
      ),
    );
  }

  /// Bridge AwaitingPIN → canonical PIN modal → processPaymentWithPIN.
  /// `validatePinOnly` returns the verification token that core-payments-
  /// service binds to `transactionId` for the bank-details payment.
  Future<void> _handleAwaitingPIN(
    BuildContext context,
    AiScanBankDetailsAwaitingPIN state,
  ) async {
    final cubit = context.read<AiScanCubit>();
    final result = await validatePinOnly(
      context: context,
      transactionId: state.transactionId,
      transactionType: 'BANK_DETAILS_PAYMENT',
      amount: state.amount,
      // BankDetails doesn't carry a currency field — bank-details
      // payments are NGN-only on the current core-payments endpoint.
      currency: 'NGN',
    );
    if (result == null || !result.success) {
      // User cancelled or attempts exhausted — return to scan
      // selection so a stale "awaiting PIN" state doesn't trap the UI.
      cubit.returnToScanTypeSelection();
      return;
    }
    await cubit.processPaymentWithPIN(
      bankDetails: state.bankDetails,
      amount: state.amount,
      description: state.description,
      verificationToken: result.verificationToken ?? '',
      transactionId: state.transactionId,
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
    _confirmPushed = true;
    final cubit = context.read<AiScanCubit>();
    Get.to(() => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: cubit),
            BlocProvider(
                create: (_) => GetIt.I<AccountCardsSummaryCubit>()),
          ],
          child: AiScanConfirmScreen(intent: state.intent),
        ))?.then((_) {
      // User backed out of confirm — allow re-resolution next time.
      _confirmPushed = false;
    });
  }

  /// OCR found a value that could be an account number OR a phone number.
  void _handleAmbiguous(BuildContext context, AiScanAmbiguousResult state) {
    final cubit = context.read<AiScanCubit>();
    final data = state.data;
    final value = (data['account_number'] ??
            data['phone_number'] ??
            data['value'] ??
            '')
        .toString();

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetCtx) => Padding(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            Text(
              'What did you scan?',
              style: GoogleFonts.inter(
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              state.hint ??
                  'We found "$value" — is it a bank account or a phone number?',
              style: GoogleFonts.inter(
                  fontSize: 13.sp, color: const Color(0xFF9CA3AF)),
            ),
            SizedBox(height: 20.h),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(sheetCtx).pop();
                cubit.emitIntent(ScanPaymentIntent(
                  type: ScanIntentType.bankDetails,
                  title: 'Bank Transfer',
                  subtitle: value,
                  amountEditable: true,
                  accountNumber: value,
                  bankDetails: BankDetails(
                    accountNumber: value,
                    accountName: '',
                    bankName: '',
                    confidenceScore: 0.5,
                    fieldConfidence: const {},
                    accountType: 'external',
                    transferMethod: 'paystack_transfer',
                  ),
                ));
              },
              icon: const Icon(Icons.account_balance, color: Colors.white),
              label: Text('Bank account',
                  style: GoogleFonts.inter(
                      fontSize: 15.sp, fontWeight: FontWeight.w600)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.of(sheetCtx).pop();
                cubit.emitIntent(ScanPaymentIntent(
                  type: ScanIntentType.recipient,
                  title: value,
                  subtitle: 'Phone number',
                  username: value,
                  amountEditable: true,
                ));
              },
              icon: const Icon(Icons.phone, color: Colors.white),
              label: Text('Phone number',
                  style: GoogleFonts.inter(
                      fontSize: 15.sp, fontWeight: FontWeight.w600)),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Color(0xFF2D2D2D)),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Nothing payable found → snackbar + re-open the source chooser so the
  /// user can retake / re-pick.
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
      if (mounted) _openSourceSheet();
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