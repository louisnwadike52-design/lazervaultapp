import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/face_verification_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/face_verification_state.dart';
import 'package:lazervault/src/features/widgets/themed_app_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:developer' as developer;

/// Facial Login Camera Widget
/// Provides real-time camera preview and face capture for login/verification
class FacialLoginCamera extends StatefulWidget {
  const FacialLoginCamera({super.key});

  @override
  State<FacialLoginCamera> createState() =>
      _FacialLoginCameraState();
}

class _FacialLoginCameraState extends State<FacialLoginCamera>
    with WidgetsBindingObserver {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  bool _isProcessing = false;
  String _statusMessage = 'Position your face in the frame';
  Color _overlayColor = Colors.white;
  final _secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _cameraController;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();

      if (_cameras == null || _cameras!.isEmpty) {
        setState(() {
          _statusMessage = 'No camera available';
        });
        return;
      }

      // Use front camera for face login
      final frontCamera = _cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => _cameras!.first,
      );

      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _cameraController!.initialize();

      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      developer.log('Error initializing camera: $e');
      if (mounted) {
        setState(() {
          _statusMessage = 'Error: ${e.toString()}';
        });
      }
    }
  }

  Future<void> _captureAndVerifyFace() async {
    if (_isProcessing || _cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    setState(() {
      _isProcessing = true;
      _statusMessage = 'Capturing...';
    });

    try {
      // Capture image
      final XFile imageFile = await _cameraController!.takePicture();
      final Uint8List imageBytes = await imageFile.readAsBytes();

      if (!mounted) return;

      // Get stored user ID from secure storage
      final storedUserId = await _secureStorage.read(key: 'user_id');

      if (storedUserId == null || storedUserId.isEmpty) {
        throw Exception('User ID not found. Please log in with your passcode first.');
      }

      if (!mounted) return;

      // Verify face using FaceVerificationCubit
      await context.read<FaceVerificationCubit>().verifyFace(
            userId: storedUserId,
            imageBytes: imageBytes,
            imageFilename: 'login_${DateTime.now().millisecondsSinceEpoch}.jpg',
            threshold: 0.5,
          );

      // The state change will be handled by BlocListener in build method
    } catch (e) {
      developer.log('Error capturing face: $e');
      setState(() {
        _statusMessage = 'Error: ${e.toString()}';
        _isProcessing = false;
        _overlayColor = Colors.red;
      });

      // Reset overlay color after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _overlayColor = Colors.white;
            _statusMessage = 'Position your face in the frame';
          });
        }
      });
    }
  }

  Widget _buildCameraPreview() {
    if (!_isCameraInitialized || _cameraController == null) {
      return Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: Colors.white),
              SizedBox(height: 16.h),
              Text(
                _statusMessage,
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    final cameraRatio = _cameraController!.value.aspectRatio;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Camera preview
        Transform.scale(
          scale: cameraRatio / deviceRatio,
          child: Center(
            child: CameraPreview(_cameraController!),
          ),
        ),

        // Face guide overlay
        CustomPaint(
          painter: FaceGuidePainter(color: _overlayColor),
        ),

        // Status message at top
        Positioned(
          top: 40.h,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            margin: EdgeInsets.symmetric(horizontal: 32.w),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              _statusMessage,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FaceVerificationCubit, FaceVerificationState>(
      listener: (context, state) {
        if (state is FaceVerified) {
          // On successful verification, navigate to dashboard
          Get.offAllNamed(AppRoutes.dashboard);
        } else if (state is FaceVerificationRejected) {
          setState(() {
            _statusMessage = state.reason;
            _isProcessing = false;
            _overlayColor = Colors.red;
          });

          // Reset overlay color after 3 seconds
          Future.delayed(const Duration(seconds: 3), () {
            if (mounted) {
              setState(() {
                _overlayColor = Colors.white;
                _statusMessage = 'Position your face in the frame';
              });
            }
          });
        } else if (state is FaceVerificationFailure) {
          setState(() {
            _statusMessage = state.message;
            _isProcessing = false;
            _overlayColor = Colors.red;
          });

          // Reset overlay color after 3 seconds
          Future.delayed(const Duration(seconds: 3), () {
            if (mounted) {
              setState(() {
                _overlayColor = Colors.white;
                _statusMessage = 'Position your face in the frame';
              });
            }
          });
        } else if (state is FaceVerificationLoading) {
          setState(() {
            _statusMessage = 'Verifying...';
            _overlayColor = Colors.blue;
          });
        }
      },
      child: Column(
        children: [
          ThemedAppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => Get.back(),
            ),
            title: 'Facial Recognition Login',
            titleColor: Colors.white,
          ),
          Expanded(
            child: _buildCameraPreview(),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
            color: Colors.black,
            child: Column(
              children: [
                Text(
                  'Position your face within the oval to login',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Cancel button
                    TextButton(
                      onPressed: _isProcessing
                          ? null
                          : () => Get.back(),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    // Capture button
                    GestureDetector(
                      onTap: _isProcessing ? null : _captureAndVerifyFace,
                      child: Container(
                        width: 70.w,
                        height: 70.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          color: _isProcessing
                              ? Colors.grey
                              : Colors.white.withValues(alpha: 0.3),
                        ),
                        child: _isProcessing
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              )
                            : Icon(
                                Icons.face_retouching_natural,
                                color: Colors.white,
                                size: 32.sp,
                              ),
                      ),
                    ),

                    // Placeholder for symmetry
                    SizedBox(width: 60.w),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for face guide overlay (reused from registration)
class FaceGuidePainter extends CustomPainter {
  final Color color;

  FaceGuidePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: color.a * 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final center = Offset(size.width / 2, size.height / 2);
    final ovalRect = Rect.fromCenter(
      center: center,
      width: size.width * 0.65,
      height: size.height * 0.5,
    );

    // Draw oval guide
    canvas.drawOval(ovalRect, paint);

    // Draw corner guides
    final cornerPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final cornerLength = 30.0;

    // Top-left
    canvas.drawLine(
      Offset(ovalRect.left, ovalRect.top + cornerLength),
      Offset(ovalRect.left, ovalRect.top),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(ovalRect.left, ovalRect.top),
      Offset(ovalRect.left + cornerLength, ovalRect.top),
      cornerPaint,
    );

    // Top-right
    canvas.drawLine(
      Offset(ovalRect.right - cornerLength, ovalRect.top),
      Offset(ovalRect.right, ovalRect.top),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(ovalRect.right, ovalRect.top),
      Offset(ovalRect.right, ovalRect.top + cornerLength),
      cornerPaint,
    );

    // Bottom-left
    canvas.drawLine(
      Offset(ovalRect.left, ovalRect.bottom - cornerLength),
      Offset(ovalRect.left, ovalRect.bottom),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(ovalRect.left, ovalRect.bottom),
      Offset(ovalRect.left + cornerLength, ovalRect.bottom),
      cornerPaint,
    );

    // Bottom-right
    canvas.drawLine(
      Offset(ovalRect.right - cornerLength, ovalRect.bottom),
      Offset(ovalRect.right, ovalRect.bottom),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(ovalRect.right, ovalRect.bottom - cornerLength),
      Offset(ovalRect.right, ovalRect.bottom),
      cornerPaint,
    );
  }

  @override
  bool shouldRepaint(FaceGuidePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
