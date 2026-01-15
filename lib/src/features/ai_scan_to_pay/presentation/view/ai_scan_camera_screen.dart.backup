import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../domain/entities/scan_entities.dart';
import '../cubit/ai_scan_cubit.dart';
import '../cubit/ai_scan_state.dart';
import '../widgets/ai_chat_bottom_sheet.dart';
import 'ai_scan_to_pay_screen.dart';

class AiScanCameraScreen extends StatefulWidget {
  const AiScanCameraScreen({super.key});

  @override
  State<AiScanCameraScreen> createState() => _AiScanCameraScreenState();
}

class _AiScanCameraScreenState extends State<AiScanCameraScreen>
    with WidgetsBindingObserver {
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  bool _isCameraInitialized = false;
  bool _isCapturing = false;
  bool _isFlashOn = false;
  int _selectedCameraIndex = 0;
  final ImagePicker _picker = ImagePicker();
  bool _isDisposing = false;
  
  // Store the cubit reference to ensure context preservation
  AiScanCubit? _aiScanCubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _aiScanCubit = context.read<AiScanCubit>();
    _initializeCamera();
  }

  @override
  void dispose() {
    _isDisposing = true;
    WidgetsBinding.instance.removeObserver(this);
    _disposeCamera();
    super.dispose();
  }

  Future<void> _disposeCamera() async {
    if (_cameraController != null) {
      await _cameraController!.dispose();
      _cameraController = null;
    }
    if (mounted) {
      setState(() {
        _isCameraInitialized = false;
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_isDisposing) return;
    
    final CameraController? cameraController = _cameraController;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _disposeCamera();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  Future<void> _initializeCamera() async {
    if (_isDisposing) return;
    
    try {
      // Dispose existing controller first
      await _disposeCamera();
      
      // Request camera permission
      final status = await Permission.camera.request();
      if (!status.isGranted) {
        Get.snackbar(
          'Permission Denied',
          'Camera permission is required to scan documents',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      // Get available cameras
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        Get.snackbar(
          'No Camera',
          'No camera found on this device',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      // Initialize camera controller
      _cameraController = CameraController(
        _cameras[_selectedCameraIndex],
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _cameraController!.initialize();

      if (mounted && !_isDisposing) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      if (mounted && !_isDisposing) {
        Get.snackbar(
          'Camera Error',
          'Failed to initialize camera: ${e.toString()}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    }
  }

  Future<void> _switchCamera() async {
    if (_cameras.length < 2 || _isDisposing) return;

    setState(() {
      _isCameraInitialized = false;
    });

    await _disposeCamera();

    _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;

    _cameraController = CameraController(
      _cameras[_selectedCameraIndex],
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    try {
      await _cameraController!.initialize();
      if (mounted && !_isDisposing) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      if (mounted && !_isDisposing) {
        Get.snackbar(
          'Camera Error',
          'Failed to switch camera: ${e.toString()}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    }
  }

  Future<void> _toggleFlash() async {
    if (_cameraController == null || _isDisposing) return;

    try {
      setState(() {
        _isFlashOn = !_isFlashOn;
      });

      await _cameraController!.setFlashMode(
        _isFlashOn ? FlashMode.torch : FlashMode.off,
      );
    } catch (e) {
      if (mounted && !_isDisposing) {
        setState(() {
          _isFlashOn = !_isFlashOn; // Revert state on error
        });
        Get.snackbar(
          'Flash Error',
          'Failed to toggle flash: ${e.toString()}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<AiScanCubit, AiScanState>(
        listener: (context, state) {
          if (state is AiScanChatActive) {
            // Navigate specifically to AI scan screen and dispose camera
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                // Dispose camera immediately
                _disposeCamera();
                // Navigate specifically to AI scan to pay screen
                Get.offAll(() => BlocProvider.value(
                  value: context.read<AiScanCubit>(),
                  child: const AiScanToPayScreen(),
                ));
              }
            });
          } else if (state is AiScanPaymentProcessing) {
            // Immediate navigation for payment processing
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                _disposeCamera();
                Get.offAll(() => BlocProvider.value(
                  value: context.read<AiScanCubit>(),
                  child: const AiScanToPayScreen(),
                ));
              }
            });
          } else if (state is AiScanPaymentSuccess) {
            // Immediate navigation for payment success
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                _disposeCamera();
                Get.offAll(() => BlocProvider.value(
                  value: context.read<AiScanCubit>(),
                  child: const AiScanToPayScreen(),
                ));
              }
            });
          } else if (state is AiScanError) {
            Get.snackbar(
              'Error',
              state.message,
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
          }
        },
        builder: (context, state) {
          // Don't show camera if we're disposing
          if (_isDisposing) {
            return _buildLoadingCameraView();
          }
          
          // For navigation states, show completion view instead of loading
          if (state is AiScanChatActive || state is AiScanPaymentProcessing || state is AiScanPaymentSuccess) {
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
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 78, 3, 208),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 40.sp,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'Scan Complete!',
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Redirecting...',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          
          if (state is AiScanProcessing) {
            return _buildProcessingState(state);
          } else if (state is AiScanCamera && _isCameraInitialized) {
            return _buildCameraState(state);
          }

          return _buildLoadingCameraView();
        },
      ),
    );
  }

  Widget _buildCameraState(AiScanCamera state) {
    return Stack(
      children: [
        // Camera preview
        if (_isCameraInitialized && _cameraController != null)
          Positioned.fill(
            child: AspectRatio(
              aspectRatio: _cameraController!.value.aspectRatio,
              child: CameraPreview(_cameraController!),
            ),
          )
        else
          _buildLoadingCameraView(),

        // Camera overlay with viewfinder
        Positioned.fill(
          child: CustomPaint(
            painter: CameraOverlayPainter(),
          ),
        ),

        // Scan type indicator and instructions
        Positioned(
          top: MediaQuery.of(context).padding.top + 20.h,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getIconForScanType(state.session.scanType),
                      color: const Color.fromARGB(255, 78, 3, 208),
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      state.session.scanType.displayName,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 32.w),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'Position ${state.session.scanType.displayName.toLowerCase()} within the frame and tap capture',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Top controls
        Positioned(
          top: MediaQuery.of(context).padding.top + 16.h,
          left: 16.w,
          right: 16.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back button
              _buildControlButton(
                Icons.arrow_back,
                () => Get.back(),
              ),
              
              const Spacer(),
              
              // Flash toggle
              _buildControlButton(
                _isFlashOn ? Icons.flash_on : Icons.flash_off,
                _toggleFlash,
                isActive: _isFlashOn,
              ),
            ],
          ),
        ),

        // Bottom controls
        Positioned(
          bottom: MediaQuery.of(context).padding.bottom + 32.h,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Gallery button
              _buildActionButton(
                Icons.photo_library,
                'Gallery',
                () => _pickImageFromGallery(),
              ),
              
              // Capture button
              GestureDetector(
                onTap: (_isCapturing || !_isCameraInitialized) ? null : () => _captureImage(),
                child: Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    color: (_isCapturing || !_isCameraInitialized)
                        ? Colors.grey
                        : const Color.fromARGB(255, 78, 3, 208),
                    shape: BoxShape.circle,                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 78, 3, 208).withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: _isCapturing
                      ? SizedBox(
                          width: 24.w,
                          height: 24.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 32.sp,
                        ),
                ),
              ),
              
              // Switch camera button
              _buildActionButton(
                Icons.flip_camera_ios,
                'Switch',
                _cameras.length > 1 ? _switchCamera : null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildControlButton(
    IconData icon,
    VoidCallback? onTap, {
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isActive
              ? const Color.fromARGB(255, 78, 3, 208)
              : Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24.sp,
        ),
      ),
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label,
    VoidCallback? onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: onTap != null
                  ? Colors.white.withOpacity(0.2)
                  : Colors.white.withOpacity(0.1),
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
              icon,
              color: onTap != null ? Colors.white : Colors.white.withOpacity(0.5),
              size: 28.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: onTap != null ? Colors.white : Colors.white.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingState(AiScanProcessing state) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Processing animation
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color.fromARGB(255, 78, 3, 208),
                  width: 2,
                ),
              ),
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 78, 3, 208),
                  ),
                  value: state.progress,
                ),
              ),
            ),
            SizedBox(height: 32.h),
            
            Text(
              state.status,
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            
            Text(
              'Please wait while AI analyzes your image...',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingCameraView() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Color.fromARGB(255, 78, 3, 208),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Initializing camera...',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _captureImage() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized || _isDisposing) {
      return;
    }

    try {
      setState(() {
        _isCapturing = true;
      });

      // Capture image
      final XFile image = await _cameraController!.takePicture();
      
      // Process the captured image using stored cubit reference
      final cubit = _aiScanCubit ?? context.read<AiScanCubit>();
      cubit.captureAndProcessImage(image.path);
    } catch (e) {
      if (mounted && !_isDisposing) {
        Get.snackbar(
          'Capture Error',
          'Failed to capture image: ${e.toString()}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } finally {
      if (mounted && !_isDisposing) {
        setState(() {
          _isCapturing = false;
        });
      }
    }
  }

  Future<void> _pickImageFromGallery() async {
    if (_isDisposing) return;
    
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      
      if (image != null && !_isDisposing) {
        // Use stored cubit reference
        final cubit = _aiScanCubit ?? context.read<AiScanCubit>();
        cubit.uploadImage(image.path);
      }
    } catch (e) {
      if (mounted && !_isDisposing) {
        Get.snackbar(
          'Gallery Error',
          'Failed to pick image: ${e.toString()}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    }
  }

  IconData _getIconForScanType(ScanType scanType) {
    switch (scanType) {
      case ScanType.accountDetails:
        return Icons.account_balance;
      case ScanType.invoice:
        return Icons.receipt_long;
      case ScanType.barcode:
        return Icons.qr_code_2;
      case ScanType.utilityBill:
        return Icons.receipt;
      case ScanType.giftCard:
        return Icons.card_giftcard;
      case ScanType.qrCode:
        return Icons.qr_code_scanner;
      case ScanType.receipt:
        return Icons.receipt_outlined;
      case ScanType.bankDetails:
        return Icons.account_balance_wallet;
    }
  }
}

// Custom painter for camera overlay
class CameraOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = const Color.fromARGB(255, 78, 3, 208)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    // Calculate viewfinder dimensions
    final viewfinderWidth = size.width * 0.8;
    final viewfinderHeight = viewfinderWidth * 1.2;
    final left = (size.width - viewfinderWidth) / 2;
    final top = (size.height - viewfinderHeight) / 2;

    final viewfinderRect = Rect.fromLTWH(left, top, viewfinderWidth, viewfinderHeight);

    // Draw overlay with cutout
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(RRect.fromRectAndRadius(viewfinderRect, const Radius.circular(20)));
    path.fillType = PathFillType.evenOdd;

    canvas.drawPath(path, paint);

    // Draw viewfinder border
    canvas.drawRRect(
      RRect.fromRectAndRadius(viewfinderRect, const Radius.circular(20)),
      borderPaint,
    );

    // Draw corner indicators
    final cornerPaint = Paint()
      ..color = const Color.fromARGB(255, 78, 3, 208)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    const cornerLength = 20.0;
    const cornerRadius = 20.0;

    // Top-left corner
    canvas.drawLine(
      Offset(left + cornerRadius, top),
      Offset(left + cornerRadius + cornerLength, top),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(left, top + cornerRadius),
      Offset(left, top + cornerRadius + cornerLength),
      cornerPaint,
    );

    // Top-right corner
    canvas.drawLine(
      Offset(left + viewfinderWidth - cornerRadius - cornerLength, top),
      Offset(left + viewfinderWidth - cornerRadius, top),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(left + viewfinderWidth, top + cornerRadius),
      Offset(left + viewfinderWidth, top + cornerRadius + cornerLength),
      cornerPaint,
    );

    // Bottom-left corner
    canvas.drawLine(
      Offset(left, top + viewfinderHeight - cornerRadius - cornerLength),
      Offset(left, top + viewfinderHeight - cornerRadius),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(left + cornerRadius, top + viewfinderHeight),
      Offset(left + cornerRadius + cornerLength, top + viewfinderHeight),
      cornerPaint,
    );

    // Bottom-right corner
    canvas.drawLine(
      Offset(left + viewfinderWidth, top + viewfinderHeight - cornerRadius - cornerLength),
      Offset(left + viewfinderWidth, top + viewfinderHeight - cornerRadius),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(left + viewfinderWidth - cornerRadius - cornerLength, top + viewfinderHeight),
      Offset(left + viewfinderWidth - cornerRadius, top + viewfinderHeight),
      cornerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
} 