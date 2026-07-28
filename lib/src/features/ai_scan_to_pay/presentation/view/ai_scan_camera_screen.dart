import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../domain/entities/scan_entities.dart';
import '../cubit/ai_scan_cubit.dart';
import '../cubit/ai_scan_state.dart';
import '../../domain/services/on_device_scan_extractor.dart';
import '../widgets/live_scan_camera_view.dart';
import 'ai_scan_to_pay_screen.dart';
import 'package:lazervault/src/features/recipients/data/datasources/bank_scan_datasource.dart'
    show SmartScanResult;
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// AI Scan-to-Pay camera. The live "hover to detect" scanning + camera controls
/// live in [LiveScanCameraView]; this screen only feeds captured stills into the
/// unified [AiScanCubit.analyzeImage] pipeline and reacts to its states
/// (analysis started / bank-details extracted / chat handoff) by navigating.
class AiScanCameraScreen extends StatefulWidget {
  const AiScanCameraScreen({super.key});

  @override
  State<AiScanCameraScreen> createState() => _AiScanCameraScreenState();
}

class _AiScanCameraScreenState extends State<AiScanCameraScreen> {
  // Captured in initState so no BuildContext crosses an async gap when the
  // LiveScanCameraView hands back a still.
  AiScanCubit? _aiScanCubit;

  @override
  void initState() {
    super.initState();
    _aiScanCubit = context.read<AiScanCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<AiScanCubit, AiScanState>(
        listener: (context, state) {
          if (state is AiScanAnalyzing) {
            // Analysis started — pop back to the host screen (alive beneath us),
            // which routes AiScanIntentResolved / Ambiguous / NoData and the
            // subsequent pay states. The camera view self-disposes on removal.
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted && Navigator.canPop(context)) Get.back();
            });
          } else if (state is AiScanBankDetailsExtracted) {
            // Bank-details path: hand back to the main scan screen which holds
            // the listener that opens the prefilled-editable BankDetailsBottomSheet.
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                Get.offAll(() => BlocProvider.value(
                      value: context.read<AiScanCubit>(),
                      child: const AiScanToPayScreen(),
                    ));
              }
            });
          } else if (state is AiScanError) {
            Get.snackbar('Error', state.message,
                backgroundColor: Colors.red,
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP);
          }
        },
        builder: (context, state) {
          if (state is AiScanBankDetailsExtracted) {
            return _buildCompletionView();
          }
          if (state is AiScanAnalyzing) {
            return _buildProcessingView('Reading the details…');
          }
          return LiveScanCameraView(
            title: 'Scan to Pay',
            // All scan paths use the lean per-service OCR route (/scan/extract):
            // the heavy vision inference runs on chat-transfers-service and the
            // busy general-gateway orchestration tail (multi-agent resolution +
            // history + QR concurrency) is bypassed, so extraction is faster.
            // The AI-scan flow resolves recipients itself at pay time and keeps
            // its own history, so it needs none of that tail.
            onCapture: (path) =>
                _aiScanCubit?.analyzeImage(path, ScanSource.camera, lean: true),
            onImagePicked: (path) =>
                _aiScanCubit?.analyzeImage(path, ScanSource.upload, lean: true),
            onManualCapture: (path) =>
                _aiScanCubit?.analyzeImage(path, ScanSource.camera, lean: true),
            // On-device fast path: parse the still on-device and, when it yields
            // a clean identifier, route it through the SAME sheet + verify path
            // WITHOUT the backend GPT-vision call. Falls back to onCapture above
            // (the /scan/extract GPT route) for invoices / ambiguous / unclear.
            onDeviceResolve: (text) =>
                const OnDeviceScanExtractor().extract(text),
            onResolved: (obj) {
              if (obj is SmartScanResult) {
                _aiScanCubit?.resolveOnDeviceScan(obj);
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildCompletionView() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 78, 3, 208),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check, color: Colors.white, size: 40.sp),
            ),
            SizedBox(height: 24.h),
            Text('Scan complete',
                style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
            SizedBox(height: 8.h),
            Text('Redirecting…',
                style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  Widget _buildProcessingView(String status) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: const Color.fromARGB(255, 78, 3, 208), width: 2),
              ),
              child: Center(child: LazerVaultLoader.small()),
            ),
            SizedBox(height: 32.h),
            Text(status,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
            SizedBox(height: 8.h),
            Text('Please wait while we analyze your image…',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}
